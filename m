From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: bug? git push triggers auto pack when gc.auto = 0
Date: Tue, 4 Feb 2014 13:02:14 +0700
Message-ID: <CACsJy8B0WKfxSYBSgRZQYz6_h+S9pGd03A=rrWM0_twRdKvyZw@mail.gmail.com>
References: <loom.20140204T030158-758@post.gmane.org> <CACsJy8Bo4XgA-g2hy+_pVEKLnerL9WNhpWe==zJANmCMdGXuow@mail.gmail.com>
 <loom.20140204T055040-646@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 07:02:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAZ5w-0002u2-0O
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 07:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbaBDGCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 01:02:47 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:47250 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaBDGCp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 01:02:45 -0500
Received: by mail-qc0-f170.google.com with SMTP id e9so13165692qcy.29
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 22:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CPRSMSmu7EC2z5294psHIClhbnhZqUGsiTw0U30hmto=;
        b=N+5REmHAJVeKcUs1AVA2YpjnPcqXrxKtUfx4JeiSHEDrgUrhFpKG+uIoLt2kqt31A3
         2AWtMtpQcrXFe0SiLVQQscgk6FlKsVoRppNSsb0n0J9I5ZJKHqKCSomRdZfokn9PlMfi
         oYQ3M5mVUkZiH4G7EgeSVRBFwpmGEMQRezqnLqNxE7MGzKmJ9j87PmDdJ4UJYsQygpdD
         3OKPohAiQZW/3vJXNbjE+Lubv1KUm64Lmow6u0C/JuECp6E76nCPqinMDI5yiCS1iU88
         +D4w1f9QWA9V/Jps49deiHZCsHkJEFNIlKkmp7nXt9WhtmNA+9ZzyEmZnKqIaCGNUPb3
         ahpA==
X-Received: by 10.140.84.19 with SMTP id k19mr59510433qgd.98.1391493764691;
 Mon, 03 Feb 2014 22:02:44 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Mon, 3 Feb 2014 22:02:14 -0800 (PST)
In-Reply-To: <loom.20140204T055040-646@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241512>

On Tue, Feb 4, 2014 at 12:13 PM, chris <jugg@hotmail.com> wrote:
> However, I question why I should even care about this message?  I'm going to
> assume that simply it is a lengthy synchronous operation that someone felt
> deserved some verbosity to why the client push action is taking longer than
> it should.  Yet that makes me question why I'm being penalized for this
> server side operation.  My client time should not be consumed for server
> side house keeping.
>
> An obvious fix is to disable gc on the server and implement a cron job for
> the house keeping task.  However, as often the case one does not have
> control over the server, so it is unfortunate that git has this server side
> house keeping as a blocking operation to a client action.

I agree it should not block the client. I think you can Ctrl-C "git
push" at this point without losing anything (data has already been
pushed at this point) but that's not a good advice to general cases.
Maybe we can do something at the server side to not block the client..

Another thing we could do is put "remote: " in front of these strings,
even in ssh case. They seem to confuse you (and me too) that things
happened locally.
-- 
Duy
