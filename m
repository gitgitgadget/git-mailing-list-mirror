From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] commit-tree: do not pay attention to commit.gpgsign
Date: Tue, 3 May 2016 00:20:40 -0400
Message-ID: <CAPig+cRHxtOxR09LR6jEDAk7kT3oJMzwLe=iyKqxcGhviVaMNQ@mail.gmail.com>
References: <xmqqk2jcqfxm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 06:20:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axRpG-0001Od-6J
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 06:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbcECEUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 00:20:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35516 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbcECEUl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 00:20:41 -0400
Received: by mail-io0-f194.google.com with SMTP id u185so1083314iod.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 21:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=BWf+55wiYGuip5FfkFG641Y4+lnphQMR3IShs5WlYCo=;
        b=m8eLIIAYj3H1fVIZ9fKDW5yRe/G3VJHmPUQFXsUWEqcJZcJKrz0BXMbZyql9PpyoF7
         f3K+GqbyU+AeW52AVZkKJ+uWzMKJE+AgsJBcih/g0BdWMFvKGsAhjqoBVIsfb0fFcv/y
         UY+19KHf+tvIiv4nIyPbVe790ZCmJpmhBgPbguRg1XFYjxlnEEWBlAdsbcxdsR/zceoT
         y7QTNYviLWTuh0EGV4zx1FRTVVyTs/HUNqCRQOGTyGLgtlP27YYYj4Ibz7UpVC6jpBjp
         loMWlTrP8CdD+ldXvZ86LgQSuTP2JiYj7Jt+E7QbbPt9mYMH/9dgByPbMfn1JljO49/n
         Fraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BWf+55wiYGuip5FfkFG641Y4+lnphQMR3IShs5WlYCo=;
        b=l0kD4k3NHq7fZul6Ezyzm2/RxILY0MEyYFtS6Kdu/MOTNUU8Z0WHlaO9S5bWzwdHcI
         HujVcc2C5u+9sXW11zWaWmDIlX8CyrxKwdmuVObEGhPILeuWoUnD9jFZwMO/eJujhWtu
         +Pfds84j0U+jJ50dYN6DHDkxo8Fx3swrpvZgl7cu8NgLl7NWs6XWzwSs3gWVAdGfO/FX
         TMEDJRXsne+o6wiIIJjMiboPyta1jnLkoJmuQseBgULJNqoeq15npb/Wu1YSyEWpqGD4
         2hR5z24jPAiS5YcCvrvvcuzqDsgj3gnWl3J09Rm9qMXbHzUf1n26ZyonH4VjWrwUB0W5
         dwog==
X-Gm-Message-State: AOPr4FXpGQ62zKfla59ixygWPG8X4a2smppICQ1r+KIgnMkALjUcE6V5Bl/iSgZ771qpXzLVZ0ZVS17rVTA1yA==
X-Received: by 10.107.9.102 with SMTP id j99mr822103ioi.104.1462249240661;
 Mon, 02 May 2016 21:20:40 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 2 May 2016 21:20:40 -0700 (PDT)
In-Reply-To: <xmqqk2jcqfxm.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 8br0rqgfkT_Ds-FFqUtC-g4QAV0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293320>

On Mon, May 2, 2016 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ba3c69a9 (commit: teach --gpg-sign option, 2011-10-05) introduced a
> "signed commit" by teaching --[no-gpg-sign option and commit.gpgsign

s/\[no/[no]/

(ditto in the "simpler" patch)

> configuration variable to various commands that create commits.
>
> Teaching these to "git commit" and "git merge", both of which are
> end-user facing Porcelain commands, was perfectly fine.  Allowing
> the plumbing "git commit-tree" to suddenly change the behaviour to
> surprise the scripts by paying attention to commit.gpgsign was not.
>
> Among the in-tree scripts, filter-branch, quiltimport, rebase and
> stash are the commands that run "commit-tree".  If any of these
> wants to allow users to always sign every single commit, they should
> offer their own configuration (e.g. "filterBranch..gpgsign") with an
> option to disable (e.g. "git filter-branch --no-gpgsign").
>
> Ignoring commit.gpgsign option _obviously_ breaks the backward
> compatibility, and I seriously doubt anybody sane is depending on
> this misfeature that commit-tree blindly follows commit.gpgsign in
> any third-party script that calls it, but following the "be careful
> when removing (mis)features" tradition, let's give these scripts an
> escape hatch.  Passing the new --use-commit-gpgsign-config option to

s/to$//

> makes it pay attention to the commit.gpgsign configuration again.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
