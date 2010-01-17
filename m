From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Get rid of refreshing cache after "git commit"?
Date: Sun, 17 Jan 2010 15:16:46 +0700
Message-ID: <fcaeb9bf1001170016q5e285201r36f6030579cfa605@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 17 09:16:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWQJa-0007ji-RL
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 09:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab0AQIQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 03:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464Ab0AQIQs
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 03:16:48 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:40712 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab0AQIQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 03:16:48 -0500
Received: by pwj9 with SMTP id 9so1147405pwj.21
        for <git@vger.kernel.org>; Sun, 17 Jan 2010 00:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=yk9rivM8SMfz6Bqvdg5AWSIIOW8m7zupRggyAC1rXvg=;
        b=DKqDNFHiIb2g8Wr201uqTkr5TnL8EpjHl6IzkUIXm12H3aLO1d7Rptyk9WIP8wIYSt
         RM8yMYvGzVyOpWB1zPMo4PQcoPE1xuYJwGAZAZeNaOOFcLJZOhX2XflVuPRDeDZ5djLm
         r0TeI7uC4Bvf0s6t0IQQYv93niBo7iZ3KIQYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=p53KObhiTA4zPhZp+D69LZttg7be9b00lwf45kpY+emzhNMhywaSOu94LRypR6vQMb
         gWAGGY64jwW4ZR2KjW/jvb2mlAQI7LmEJcYYqyzLyQ+1oFyqfFH5UhU1XN+o4cWl1EwN
         GLcWloMwmdttb4Gy0esfEmnnmCP9OBnI8kwwA=
Received: by 10.114.236.20 with SMTP id j20mr1940234wah.185.1263716206843; 
	Sun, 17 Jan 2010 00:16:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137277>

Hi,

The current "git commit" refreshes cache and writes out after a
commit. I dug back in history to see how it was introduced. It looks
like from the very first days of "git commit", which was
git-commit-script at that time, git-update-cache was called on
specified paths, until commit 22cff6a (git-commit: pass explicit path
to git-diff-files. - 2005-08-16) started to do "git-update-cache -q
--refresh" without paths and the tradition keeps going until today.

Nowadays almost (all?) porcelain commands silently refresh index
before doing anything relating to worktree, I wonder if this tradition
is still necessary. On (again) gentoo-x86 repository, taking out the
refresh part could cut down about 1 sec on total 3 secs from "git
commit -m foo".
-- 
Duy
