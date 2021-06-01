Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C21CC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 00:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D216561159
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 00:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhFAAbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 20:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhFAAbf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 20:31:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825D9C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 17:29:54 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b25so13473481iot.5
        for <git@vger.kernel.org>; Mon, 31 May 2021 17:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+iVWQRBUAKmn19D8hvDspa3WRKUac/BAP56NYSqRK8=;
        b=c9+7Y2+diFEwwAbOGaa65uJ6TiP+c+4E9aWyhLUqY9+uVewXgsrk8NOBZ2laGPpU6i
         8NlMUELuI6UCO/VLpkWeNI7qQvligZU5sB77MNqQ9rAM5TBXGLsxxo89iApp9uPfcx8c
         CJh2E06YYaF9D5VVOiQeXyDvklCdSCgI/Ni5ruaQDdR7XJzX9A7awGU+QxhhxZuRCOLp
         o/zAvaoWLaLgkHm/ph0lHxSiT7FNRo6YgjGdoctwwb22crESiwFMIAZtMTRo5mUaD8+J
         jTrWelXdjhpFYlHE3sEZ3TuVlWmsDVhOzWzibBqC3saHwpqV8ORvPEy6BoPQQ+7PU+Gr
         pcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+iVWQRBUAKmn19D8hvDspa3WRKUac/BAP56NYSqRK8=;
        b=iSGPqK2DyPSVum/Z/QPICrwExEk6Tye+ro5j3sNHwXGg41it7ogaJ2pxnB2Ssia2vb
         FLLoPZp9wQ4+BBGepznAGXt+7hkefDYlBia8nkn6PWrxEYxnrZYqxoUTMUSllK8EIl4L
         eJUOd8rqkgSrg+2tQA5JyWetxh2uXpu0MgTN6KbEjbukNifOCfEAZQQ9zrmHBlzLTphE
         qw9dIWMH0Kpx0OdAmuEXdvumazEn8S4hJ6Ck6ppMqoDtIfczcfEYQ3fimOu8ZHXKfxNc
         Uadr121WDan6wIwS1czHuwJf2kfMtpSKK2uCR7vvUt+hTIPcMsY4G1k/UBwiBhyax+Kp
         fmGw==
X-Gm-Message-State: AOAM5307GxEKwyahBnx3H6CC326UbPUuJpBF0VUZDGUU+HSSeeJFlrY2
        +u2hLCtYy2rrMiYNxlUfabw86QEYGFKtHfvdMKo=
X-Google-Smtp-Source: ABdhPJwv/wzNKhZLU1efw5yW5XjApWIi66SgaUwemvg0TLud6Y89cMVdiO4a4rCQ2qfpgKkQiMmqawlivK6lJj2OgNE=
X-Received: by 2002:a05:6638:11:: with SMTP id z17mr6540892jao.102.1622507393726;
 Mon, 31 May 2021 17:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAFOYHZBAg7pkise8bir7Z3qApw9mJB8Z99p6z71-_T6=7rFV7w@mail.gmail.com>
 <CAFOYHZAfQivHvs5=hGt-A1CbtwW-iJSwC1iFk7FY3wnNcVNVrQ@mail.gmail.com>
 <aa18c448-9a74-0837-a2bb-008aab31f0e4@gmail.com> <CAFOYHZA4xbnWc1d1zK-fjoDHZntQj7weDZk1r=SOJxVtKD4aOA@mail.gmail.com>
 <d919f68e-42a9-bd74-c16e-8d2c185b6938@gmail.com>
In-Reply-To: <d919f68e-42a9-bd74-c16e-8d2c185b6938@gmail.com>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Tue, 1 Jun 2021 12:29:42 +1200
Message-ID: <CAFOYHZAjzS+fizM+wadgFq3F6tSYu35CJOFuCWPFc5TH6Fq8vg@mail.gmail.com>
Subject: Re: [BUG] gitk error - can't read "arcnos()": no such element in array
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 31, 2021 at 7:53 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 31/05/21 14.38, Chris Packham wrote:
> >> Is your problematic repo public? If so, we can test against that.
> >>
> >
> > Unfortunately not. It's actually an internal kernel tree which has a
> > different root to upstream (hence using git replace to attach upstream).
> > All of which make the history a bit funky.
> >
> > I don't know if the problem will survive anonymisation but I can try.
> >
>
> Did you mean vendor kernel tree based on Linux kernel?

Kind of. A repo that was created in 2007 before we were using git
properly by extracting the kernel tarballs and adding our code. So
although it's a kernel tree it shares no common history with Linus'
tree.

git fast-export/fast-import doesn't seem to like the affected repo so
I'm not having much luck with making anything publicly available.

> I think you can
> try reproducing the issue with either Linus' tree [1] (mainline only) or
> Greg's stable tree [2] (mainline + release branches and tags).
>
> [1]: https://github.com/torvalds/linux
> [2]: https://github.com/gregkh/linux
>

I've tried a few experiments
- cloning the "bad" repo -> no problem seen in clone
- cloning the "bad" repo with --mirror -> no problem seen in clone
- copying the "bad" repo -> same problem seen in copy

So now that I have a copy that shows the problem I can do a few more things.
- copy repo, remove replace refs (git replace -l | xargs git replace
-d) -> problem remains
- copy repo, remove replace refs and all remotes except origin ->
problem remains
- copy repo, run git gc -> no problem

So the git gc seems to have done the trick. I'm happy enough to leave
it there and hope that this thread is useful for future mailing list
searchers. I'll keep a copy of the affected repo around if there is
anything someone wants me to try.
