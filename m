From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Process of updating a local branch from another with tracking
Date: Wed, 12 Feb 2014 15:55:01 -0600
Message-ID: <CAHd499CQK7Mmd+vWb74Nj4usX8KhmurJNd31MrAMUs6Vb2zOOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 22:55:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDhlx-0000EC-Jh
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 22:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbaBLVzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 16:55:06 -0500
Received: from mail-vc0-f177.google.com ([209.85.220.177]:52799 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbaBLVzC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 16:55:02 -0500
Received: by mail-vc0-f177.google.com with SMTP id if11so7433803vcb.36
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 13:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=voT9Y7o5skG3F22LJZpe71vO6Ahyj8EGre2VdF4XCjA=;
        b=HoAyVaMlIQ6r/Jk7FvqAy2ZnqCE9VvLfbeZ1TDn48Wj23jnD0cCJsA5qtmgJbEGUxW
         TtnQaRfGK5IoakvYtIEN0te3sK6Pe9URgZZISVI3sQeRM7/8/7rhm0MSMIO2V/zcxSoj
         L4ri9+THAhTMrESH3D8MrtgmfH+39nfVtqMOdMlES6gjsN2HSzV7oAmNbM2dOih5Lbym
         v0zsgZRFzzVWXBeAhOle+DCqggTRkq8Oj6DPau033Gja0fehpNev65DxuPSa2vY3FTaN
         lIbCsNmiyThJe7HM3F47cjPktUbfguGX+b0t/6OudVCqc/7gMR1TskvFa4f9ChWAvWGB
         /oUw==
X-Received: by 10.58.168.142 with SMTP id zw14mr1704494veb.33.1392242101086;
 Wed, 12 Feb 2014 13:55:01 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.202.3 with HTTP; Wed, 12 Feb 2014 13:55:01 -0800 (PST)
X-Google-Sender-Auth: OwiRAvYiHMyZ6Sjr4kchV_QSong
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242027>

I have the following alias defined:
sync = "!f() { cbr=$(git rev-parse --abbrev-ref HEAD); git co $1 &&
git pull && git co $cbr && git rebase $1; }; f"

The goal is to basically update a local branch which tracks a branch
on a remote, and then rebase my local topic branch onto that updated
local branch.

I do this instead of just rebasing onto origin/master. Example:

git checkout master
git pull --rebase origin master
git checkout topic1
git rebase master

I could do this instead but not sure if it is recommended:

git checkout topic1
git fetch
git rebase origin/master

Any thoughts on the alias I created? I'm a Windows user and still new
to linux stuff, so if it sucks or could be simplified just let me
know.

And as a secondary question, just curious what people think about
rebasing onto a remote tracking branch. When I do merges I usually
refer to the remote branch, but during rebase I use the local branch
instead, but I don't know if there is any functional reason to not
skip the local branch and go straight to the remote tracking branch
(it saves a step).
