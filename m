From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: gitignore excludes not working?
Date: Sat, 7 Dec 2013 09:07:46 +0800
Message-ID: <CANYiYbG=qdoLmD9FkOPikjVeN9T69+U6KBGYyVc5NAvuiZ1rLA@mail.gmail.com>
References: <CACPiFCJ0Jj1M8KCrwus=DeRSBE2O3HKhvEo-UJhHoZDhHTzsSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 02:08:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp6Nb-0006jW-EX
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 02:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111Ab3LGBHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 20:07:49 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:45203 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab3LGBHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 20:07:48 -0500
Received: by mail-wg0-f49.google.com with SMTP id x12so1349754wgg.28
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 17:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P5jFndGWwwfbHJM6KX9w03bP/hcJxv0F6ah7+P5MI7M=;
        b=J3IS/8bjCUR0FKWDUZjttr21CSyWLWvORcnnOIaWiMJfwXZfmCDlXXGV/sXA6Sxwgm
         H2PZOnJKi70DsyqAWxPCHjbFgho+N7biD28KKwmyZGtD34ruyiLrZ9vYCYQ0yDkfTG/Y
         B93diQb0WzTs6KWlU2HSXeR5M7+jVSi39HRafZt4MZckdOgMT771DEI0TO6r+M/V58Tp
         oHb9ddZBOk+S/rnYqmnmbgBXDQvmV9MCVr5rM2C13fRwODLvwubzt658d5noPk/PK3kQ
         tvNgizaRludUrb+nzVaklE9QmvFA7SwAXOJesXI7GII1CQw8OxKbOTQtZZJB8JjFUkOt
         wycg==
X-Received: by 10.180.82.161 with SMTP id j1mr4845962wiy.23.1386378466906;
 Fri, 06 Dec 2013 17:07:46 -0800 (PST)
Received: by 10.216.213.207 with HTTP; Fri, 6 Dec 2013 17:07:46 -0800 (PST)
In-Reply-To: <CACPiFCJ0Jj1M8KCrwus=DeRSBE2O3HKhvEo-UJhHoZDhHTzsSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238968>

2013/12/7 Martin Langhoff <martin.langhoff@gmail.com>:
> Tested with git 1.7.12.4 (Apple Git-37) and git 1.8.3.1 on F20.
>
> $ mkdir foo
> $ cd foo
> $ git init
> Initialized empty Git repository in /tmp/foo/.git/
> $ mkdir -p modules/boring
> $ mkdir -p modules/interesting
> $ touch modules/boring/lib.c
> $ touch modules/interesting/other.c
> $ touch modules/interesting/lib.c
> $ git add modules/interesting/lib.c
> $ git status
> # On branch master
> #
> # Initial commit
> #
> # Changes to be committed:
> #   (use "git rm --cached <file>..." to unstage)
> #
> # new file:   modules/interesting/lib.c
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> # modules/boring/
> # modules/interesting/other.c
>
> $ echo '/modules/' > .gitignore
> $ echo '!/modules/interesting/' >> .gitignore
>

I happened to write a software "Gistore" to backup arbitrary files and
directories using Git, and it will save interesting things in .git/info/exclude.
For your case, you could write .gitignore as:

    /modules/*
    !/modules/interesting
    !/modules/interesting/**

You can find my code in Gistore to generate proper .gitignore here:

    https://github.com/jiangxin/gistore/blob/master/lib/gistore/repo.rb#L228

Because I will ignore all files except what I want, the ignore file would be:

   *
    !/modules
    !/modules/interesting
    !/modules/interesting/**


-- 
Jiang Xin
