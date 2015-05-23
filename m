From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status doesn't ignore GIT_DIR directory?
Date: Fri, 22 May 2015 19:03:48 -0700
Message-ID: <CAPc5daW2yTHHegPDrEWS5KiSYWZECV+AxMnewzz9ayASB1QNUw@mail.gmail.com>
References: <555FD1EA.2060706@rightscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thorsten von Eicken <tve@rightscale.com>
X-From: git-owner@vger.kernel.org Sat May 23 04:04:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvynj-0006Wj-HO
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 04:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbbEWCEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 22:04:11 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35901 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797AbbEWCEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 22:04:09 -0400
Received: by qget53 with SMTP id t53so19034142qge.3
        for <git@vger.kernel.org>; Fri, 22 May 2015 19:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1z6VxMHhJjbmi2ZrMaXi3Z32d5uBjdv8X3tExeW4MjQ=;
        b=T0rDGEUqwZTs1zvG52N/YErDCMc1LMCE/cI3Y75d31xVcRISRdFeS0H0etGdFNOYFO
         e+kXyRQkLao7ZKEQ6DCdc53D7Nx0AtQ2387wsXWvkxxAUYIEuh+ORosvRN9Eyb0P/ru1
         tVBQaVeKDAASDAw/itPPphS/KUdxC6tEMz39xVYkWi3at064TLnmyl34daZk48EOpwrM
         ATLhP+4P+AVVq5PT8XwE5WnEt6zJMTRBACqknKetBa914HGcQjdlIbDxFRLUdKSx1yAE
         1oLmXGDy434yGrhsFDDrdITYVh7KLoPckyCh8B5hYubxz/AoM7MExQnaR/v8sThW4THp
         GRAg==
X-Received: by 10.140.23.35 with SMTP id 32mr14645683qgo.106.1432346649010;
 Fri, 22 May 2015 19:04:09 -0700 (PDT)
Received: by 10.140.233.12 with HTTP; Fri, 22 May 2015 19:03:48 -0700 (PDT)
In-Reply-To: <555FD1EA.2060706@rightscale.com>
X-Google-Sender-Auth: Z_OKJ6d5ykuXEBBrZeGZJcwMvRo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269789>

As far as I know, GIT_DIR was prepared as a mechanism to point at
another .git directory that does not live inside the working tree, not
as a mechanism to rename it to arbitrary name. E.g.

 $ git init
 $ mv .git .svn
 $ GIT_DIR=$(pwd)/.svn ; export GIT_DIR

is not expected to work.


On Fri, May 22, 2015 at 6:03 PM, Thorsten von Eicken <tve@rightscale.com> wrote:
> I renamed my .git directory to _git and I'm surprised that git status thinks
> that it's an untracked file:
>
> $ GIT_DIR=_git git status
> On branch master
> Your branch is up-to-date with 'origin/master'.
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>         _git/
>
> nothing added to commit but untracked files present (use "git add" to track)
>
> This doesn't seem to make sense, shouldn't git ignore whatever $GIT_DIR
> points to? Or is there some other magic option I need to use for it to do
> what I expect?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
