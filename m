From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC] status - don't show gitdir
Date: Thu, 30 Jun 2011 19:32:20 +0700
Message-ID: <BANLkTikCmWLar4ztZgrWdB-md2X3bUxATg@mail.gmail.com>
References: <4E0C3C1D.1050406@nextest.com> <1309434388-3536-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: raible@nextest.com, jens.lehmann@web.de, hvoigt@hvoigt.net,
	git@vger.kernel.org, gitster@pobox.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 14:33:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcGQl-0001Ig-Sx
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 14:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab1F3Mcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 08:32:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56692 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab1F3Mcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 08:32:51 -0400
Received: by bwd5 with SMTP id 5so1778458bwd.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v7m+Tfde67dXGQLuMsqgtr31KCPnmuGe+IciGGA2Veg=;
        b=dbNmAop7kZugfsC4Zk7XsZevnIZNE4Ze6jtA1RyiJz/K14L5uJUpps8tTabsl17tiu
         2pgKJ93g2qLbAKZ+J3sAPiziaFAw+qTHHN/EdLzoHD5DmCJQ6ojXGNdoiBdc5vXORBPM
         VeZtyKvJJUjHVeOELW6+qeE6YrQ1lvwH0GdEQ=
Received: by 10.204.77.194 with SMTP id h2mr1937880bkk.144.1309437170188; Thu,
 30 Jun 2011 05:32:50 -0700 (PDT)
Received: by 10.204.56.138 with HTTP; Thu, 30 Jun 2011 05:32:20 -0700 (PDT)
In-Reply-To: <1309434388-3536-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176487>

On Thu, Jun 30, 2011 at 6:46 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> When gitdir is inside the working dir, don't show it as a untracked
> directory.

read_directory_recursive() and friends ignore .git by default. I think
if you want to ignore the directory that .git file points to, you
should update there. I'm too lazy to check the code (my
read_directory_recursive is heavily modified currently), but I think
it does not check file type for .git entries now.

But if we step back a bit, why do you want git to automatically ignore
dirs that .git file points to? .git files are used to save real repo
somewhere safe, e.g. outside working directory. You do not handle
another case in your patch, where .git is a real symlink. In both
cases, it's not hard to add "real-git-dir" to .git/info/excludes.
-- 
Duy
