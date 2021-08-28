Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54B2C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 05:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A748560E90
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 05:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhH1FeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 01:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhH1FeL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 01:34:11 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8EAC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 22:33:21 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso10760598ott.13
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 22:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhgyMCdK7nlTCdnfaFyobGyJxIZubhOrDqHpE83xHnc=;
        b=lylaaTlhjkGyOS1+BXkA7nRccK1kDTSBRmXuMiZ5JIHPWbdhWfCxHyUQqV7DsjSrc+
         PQrYqip2ehHtwiVEQ4t4Y4KQVTWqacwqAqr1bsbUgrxvSh2aKPyp/XTPUp9+9Adjnoz4
         5trG/qIdpec0Rxd3UU2ALKkrI6p9+v5TLKbX10rblTAKGDZUc9lXMpsuQayvgVhRsAQa
         k/inUd5g+/CVYotI3/0aipa8CKfyFYVhpcXiryIbPvmvte/PuYWS1pfUf6l9DYAQzKqp
         RxsIM56F+hSiJz/YAWluC5S5jUA/Jx76oj70n57WxJzvVlWzSAzESPTy2RmiPVWnC5oX
         vwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhgyMCdK7nlTCdnfaFyobGyJxIZubhOrDqHpE83xHnc=;
        b=gnaJ8799wC5Pkfaj7TOSzXowm8bSvRB7OB2TLQ8AtI1eDZjXykIesD1ufBgxXQHXMo
         8XGK/yTCChLS5T3Hn9Rfbu1zQKdmKpUKT58/1y3T+nzkdGhd2u5Q4w0O+rS5KrvBmn/u
         kqIzKxDDgwzw0F8YVzW+5ffIMB0iaY/329KAG5KYUtEbQ8e6QfuW6pQOtZPBbf3T3Szg
         voba0o/Me7xF4vw7o718iRBgFhTkCmaNt+rsHdricb8qlgFDIaTrI5lEKvi21GjPhfcM
         hTd92wcT4spJYsc8IrNJmck3HUpW86KTRrl0yLoVS8s3lPmmK0pnD4OHn07wy09Rn2cP
         6pgw==
X-Gm-Message-State: AOAM5315rIon4jwhDFCbNfOp0AL/jn5H+rYw4yj8uVVSV5inzt9evIaW
        Wa3IF+F+jV2nufJn/yzur5TVn3tLvzlZjEu2NDM=
X-Google-Smtp-Source: ABdhPJzHPcR56wOe2o7TGyBLFZp8hF1QaDnu7WwZHTU4hCf+ZI3YI83kfaZ8mI737ef27OhRSmbcadfgKk1UGQuk7tw=
X-Received: by 2002:a9d:630e:: with SMTP id q14mr10906032otk.316.1630128800899;
 Fri, 27 Aug 2021 22:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <c0557284-8f82-76cc-8c47-0b1bc9f2ce5a@rawbw.com>
In-Reply-To: <c0557284-8f82-76cc-8c47-0b1bc9f2ce5a@rawbw.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Aug 2021 22:33:10 -0700
Message-ID: <CABPp-BFwvDY6-6pQ2MSPzAGafONjTEMNUkLwuRuQCJ_wx2ns2w@mail.gmail.com>
Subject: Re: Git re-creates newly added directory when it is pushed
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 8:49 PM Yuri <yuri@rawbw.com> wrote:
>
> I create a new directory, add it to git and push it.

And I think you left out that you cd'ed into the directory as well
before running your `git pull --rebase`.

> After push it says: Unable to read current working directory: No such
> file or directory
>
> [yuri@yv /usr/ports/math/stanmath]$ git pull -r && git push origin
> --push-option=confirm-author
> remote: Enumerating objects: 283, done.
> remote: Counting objects: 100% (283/283), done.
> remote: Compressing objects: 100% (187/187), done.
> remote: Total 188 (delta 94), reused 3 (delta 0), pack-reused 0
> Receiving objects: 100% (188/188), 29.37 KiB | 578.00 KiB/s, done.
> Resolving deltas: 100% (94/94), completed with 50 local objects.
>  From ssh://gitrepo.freebsd.org/ports
>     80469139f77f..cf8b94761057  main       -> origin/main
> Successfully rebased and updated refs/heads/main.
> fatal: Unable to read current working directory: No such file or directory
>
>
> Why does Git have to delete and then create again the directory when it
> is already there?
>
>
> This isn't a big issue, but it is very odd that git deletes the working
> directory.

It was deleted by the rebase operation, because rebase (currently)
works by first checking out the target commit onto which it will apply
all your local patches.  That target didn't have the directory; the
directory was added by your local patches.  So checking out that
commit necessarily deletes the directory.  Then rebase applies each of
your local patches, one by one, updating the working directory as it
applies them.  Since your local patches create that directory, it gets
re-created by this process.

And since your current working directory was inside that directory
that was deleted, later commands get all confused by the current
working directory not existing.

Incidentally, rebase works like this because the default merge
backend, recursive, intrinsically works with the working copy and
updates it as it goes.  Rebase could theoretically redo each of the
merges without updating the working copy, assuming there are no
conflicts, and then checkout the new target commit at the end.  That'd
require a new merge backend that allowed merging without updating the
working copy, though, which was only recently added (see the Git 2.33
release notes).  Rebase has not yet been updated to take advantage of
that capability; there's a good chunk of work involved to try to do
so.  And even when it does, you could still hit this problem if rebase
hit a conflict on a local patch where the relevant directory did not
yet exist.


Hope that helps,
Elijah
