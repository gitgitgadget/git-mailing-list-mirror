From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Re: Git issues with submodules
Date: Sat, 23 Nov 2013 12:34:23 +0530
Message-ID: <CALkWK0nNu=XtYEedJbppsz-3+ShYa1yUrS28GA0JBbmLuF1Caw@mail.gmail.com>
References: <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
 <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
 <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
 <20131122151120.GA32361@sigill.intra.peff.net> <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
 <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
 <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
 <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
 <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
 <528FC638.5060403@web.de> <20131122215454.GA4952@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Nov 23 08:05:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vk7Hc-0002Hi-S0
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 08:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830Ab3KWHFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 02:05:06 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:53237 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab3KWHFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 02:05:05 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so3789809iec.30
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 23:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mL9rvgKKraktYpmFlzXPbEZVpyR5CM7LeW7c5tr/5Xk=;
        b=nQKDoq/y3nb+vAY7FBLm0WP3MNTYcSoGyGrsTT2PSXMwqGZ5ZDtYTOcer8KJLK4TZj
         diiV7yxcb384PgDZ/dzIIXaePYNbjO4+eZLe7VLVkyLEFi/zkf0GkTP2Hyxaf4ghLUgx
         F2zuSZZ9jkhrAonxtkIppN+8zlrnKF6gF9+6G+Witbv5sj5zrXk0SavqDrxNk68Kocz1
         ng0MwRNgvcbzhpFlN/9ElxzQMtvofOOxSl8c4XVs0d1eWV/dYPll7JnzHzRTuZ4CTvmQ
         DUcX8nYNOOs+G5wJ5GgceasWPVUORPwm5zXXq4czuo/74VCqeWq3OkdLGDQ9Z+ipz4qR
         52Kg==
X-Received: by 10.50.23.16 with SMTP id i16mr5380390igf.50.1385190304101; Fri,
 22 Nov 2013 23:05:04 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Fri, 22 Nov 2013 23:04:23 -0800 (PST)
In-Reply-To: <20131122215454.GA4952@sandbox-ub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238229>

Heiko Voigt wrote:
> What I think needs fixing here first is that the ignore setting should not
> apply to any diffs between HEAD and index. IMO, it should only apply
> to the diff between worktree and index.
>
> When we have that the user does not see the submodule changed when
> normally working. But after doing git add . the change to the submodule
> should be shown in status and diff regardless of the configuration.

Yeah, I think this is a good direction.

> After that we can discuss whether add should add submodules that are
> tracked but not shown. How about commit -a ? Should it also ignore the
> change?

Here, I think ignored submodules should behave like files matched by
.gitignore: add should not add (`add -f` would be a good way to force
it), and `commit -a` should also exclude it.
