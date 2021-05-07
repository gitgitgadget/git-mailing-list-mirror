Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77870C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 03:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590AB613D9
	for <git@archiver.kernel.org>; Fri,  7 May 2021 03:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhEGDqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 23:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhEGDqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 23:46:09 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE5EC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 20:45:09 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id n184so7507038oia.12
        for <git@vger.kernel.org>; Thu, 06 May 2021 20:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ob8cU132b6xDDBEABEQ5Y+cKE3TOJkQC1tfXg/Uyt8=;
        b=pS2YuLwSG13fStpqDnzbYm0i5wITmiZvf2M4BwgFgu/KBVmGZPxIp2/33vOCkr8ybT
         yUjabtWGxIDFIGeyHS/L3lf05jnyVZshPBtLj7WV5VuO5Ipww1yXneR5E7tKiW86Xmr9
         tv9LRJHdMR57KyXX0Ig+lUeYDDUcz8lNYuekaluAGDQ+Jq4F/R1dM2/CydtkPtuFeQjF
         THw0QKcodHcew2MFOivmj/r5k9GmoXHJbrJLgPo9l6byjIwG8sPGaiEq1oqv8KlmB0bl
         vk/7lAR0436i+92bc+vaUgBxJ0EwLUWXufzVJg3STWSA9FELpyiuDdvVi9hutwzOsSXh
         /RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ob8cU132b6xDDBEABEQ5Y+cKE3TOJkQC1tfXg/Uyt8=;
        b=cMFJ6QNbLzwBTQSkWbFoYPm4Oo/yNVEuOylrBc0ha4aZr5JuKFOm9iz5W5ONJ/AxyB
         PwzEFwMpgSL/TLNUBVq0dBNbW9L5HhXKT0kz4xOHiG/DDZp46xfXDNpbaURd1sNLd1aN
         pcqYaLuBCVRfArng9sbMxIn5nsyHrBy902IW0Jrga4DADIN/UgMB1EIXdwNiQnMQQ1fP
         FdqVRq4JdtfYR7Y8dnOCEr0/+SYWiuO3oHsZ0ZooflQz1XXXmIBFgGBvlKQCi0/ikrZ7
         pnk2RwEydNd9zIgPMs793cXAJ8Zd2P+JicRLMqM/yUCcwDlsUTqH0+lE1qOF3t3GKqcC
         gMdA==
X-Gm-Message-State: AOAM5323Ee2k+vt8w7QhTx/0rmwUW0Ut0fQAmkvBv6OdtdpvVEWDtEh6
        8WMWricHsftWEJcOz7OfeMa2XjY46ZmVGgX+cE5zqupZoYY/Zg==
X-Google-Smtp-Source: ABdhPJwSJNrXuhmojaaCf0XmUV989idYF7jxZ/D6eFGOO95Z7wEfZdlh4BeXGekcQ2YHG+1rViLfgtMWcpAsK93Wya0=
X-Received: by 2002:a54:4498:: with SMTP id v24mr5489467oiv.31.1620359108617;
 Thu, 06 May 2021 20:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com>
 <YHdzDlAfsuZ21HR7@camp.crustytoothpaste.net> <YHf+m7vOQumdJXwX@coredump.intra.peff.net>
 <CABPp-BH3tbTyA9gj=2vb878d1MQVCTqT7=kS5U+sB6CoDX0Jww@mail.gmail.com> <YJSzQm2p5bCAd8Fv@coredump.intra.peff.net>
In-Reply-To: <YJSzQm2p5bCAd8Fv@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 May 2021 20:44:57 -0700
Message-ID: <CABPp-BF3e+MWQAGb6ER7d5jqjcV=kYqQ2stM_oDyaqvonPPPSw@mail.gmail.com>
Subject: Re: Git clean enumerates ignored directories (since 2.27)
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Gore <Jason.Gore@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 6, 2021 at 8:25 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, May 06, 2021 at 07:31:40PM -0700, Elijah Newren wrote:
>
> > On alpine linux-musl, I get an "error: Tests passed but test cleanup
> > failed; aborting", which makes it report as a failed build.  I'm not
> > sure how to fix it and am asking for ideas.
> >
> > Apparently the deeply nested directory hierarchy cannot be removed on
> > that platform with a simple "rm -rf $dirname".  It throws a "rm: can't
> > stat '/__w/git/git/t/trash
> > directory.t7300-clean/avoid-traversing-deep-hierarchy/directory400/directory399/directory398/.....(you
> > get the idea)....': Filename too long" error message.[1]
> >
> > Adding a "test_when_finished find directory400 -delete" also gives a
> > "Filename too long" message followed by a lot of "Directory not empty"
> > messages.[2]
> >
> > Anyone have any bright ideas about how to tweak this test?  See [3]
> > for the current incarnation of the code, which was basically taken
> > from Brian's sample testcase.
>
> My guess is that that version of "rm" is trying to feed the entire
> pathname directly to unlink() and rmdir(), and it exceeds PATH_MAX.
>
> Even with GNU tools, for instance, I get:
>
>   $ rmdir $(find avoid-traversing-deep-hierarchy -type d | tail -1)
>   rmdir: failed to remove 'avoid-traversing-deep-hierarchy/directory400/
>     [...and so on...]/directory1': File name too long
>
> because it feeds the whole to a single rmdir() call. Whereas stracing
> GNU "rm -rf", it uses unlinkat() and openat() to delete each level
> individually (probably to avoid this exact problem).
>
> Is the actual path length important, or just the depth? If the latter,
> then calling it "d400/d399/.../d2/d1" would likely help, as that's less
> than 2000 bytes.

I needed some kind of way to notice and test that we had recursed into
the directory.  Excessively long paths trigger failures in open()
calls in git itself, which was the only marker I knew of.  So, I was
essentially depending on the long paths.  (The actual depth was not
important.). If there were a different way to determine whether we
recursed into the first level subdirectory, that'd be nicer.  I
thought about adding some trace2_region_enter/trace2_region_leave
calls and letting them nest up to whatever depth, though that seemed a
bit ugly.  I also thought about trying to determine the maximum
recursion level and seeing if that could be emitted via some kind of
trace2 magic, but that sounded like another rabbit hole.  In the end,
I gave up and used Brian's modification of Jason's testcase.

However, it looks like manually unstacking and deleting the directory
is going to work.  Incredibly ugly and slow, but adding the following
at the end of the testcase makes it work (at least on that platform,
still awaiting results on others):

    # alpine-linux-musl fails to "rm -rf" a directory with such
    # a deeply nested hierarchy.  Help it out by deleting the
    # leading directories ourselves.  Super slow, but, what else
    # can we do?  Without this, we will hit a
    #     error: Tests passed but test cleanup failed; aborting
    # so do this ugly manual cleanup...
    while test ! -f directory-random-file.txt; do
      name=$(ls -d directory*) &&
      mv $name/* . &&
      rmdir $name
    done
