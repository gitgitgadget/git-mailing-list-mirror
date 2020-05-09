Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3C1C28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C1E20A8B
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehbw3BJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgEIRfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 13:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgEIRfc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 13:35:32 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E60C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 10:35:32 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id i9so1052039ool.5
        for <git@vger.kernel.org>; Sat, 09 May 2020 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nI4fZ7LZa73GTXN+W3ge2M0nn43N2+rS1/lzjCYuBfo=;
        b=ehbw3BJ/fuKnog52eeT7gCtrT2mHlh9EYaIeNJYS4eWp8BL3sLcNkSa2wahmn9B+1F
         UbVAD1GoicIr4qykCkG4YfBiee7P3IBMjGT2cmqYUVQjsTt6g2mhAJVRfhrv7j6lClQp
         Cz3VdWru+ZSkLz+sCEwynOOpzTLaN9L8me5rnkf+eFBUyp0u14+GC3FSPf8AmR9AKvYt
         5wgtfqM0UXqUf3LHSCGvhcqSB3IGA02tQIF0K2Nfzxinp6h0TDOBZFME4sIMCV6//nkl
         9vlqe6APYTdhmiJ9eBTzTK1NCMkglJCn7F0zKJPUhaR7qdhSI/yAgtpWsZQD58MlB1Fe
         KThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nI4fZ7LZa73GTXN+W3ge2M0nn43N2+rS1/lzjCYuBfo=;
        b=ShRnXzEvcpFPpV7jo1wPnenKOBiomQS7txv0UoBY1FMu8+DJTHyLMlRUmzG7/EysJr
         cU+i7xAIZyl2jZjBN4r+iGzzZRXh9BEZc37qbwMX3oDCR/fGaIAl1A8LJVYB37Yd8t7i
         L2qaPInz9nYxrO7WMq3OOLpy9L6AT6E+JRUO/rScJFQ1WTz+EEMPfXZnuj2CKodm2wTm
         64Vi4o+nOxZA3LrpUiVmQipT0enM5fcq9DRtyAkOez+YXqvtPcMz+UQ+bywTiM2qmL0B
         Sl0ji5dqvCe6cYCJtR+9cmr9hiMHRXBZHmLCmYw5eb6ETVtJzJ7nqF4QsnrinKtow6W6
         Cclw==
X-Gm-Message-State: AGi0PubdJ1uAWhAsrxpcEKGSIhVp7z30IH1LnoAgQ/PoDzBYpnywmUiK
        9Stpg/PwZmW7dh5mrDOh3QFCmOv+yjWpasXcY6SW/jbk
X-Google-Smtp-Source: APiQypKt26Uqm3sT1dxg0KCTw4lKKswdMornGOc7calM27H52W6IRCCprWMy2D03yRXWl2usoC4anKmg8lIJFWFp4go=
X-Received: by 2002:a4a:d136:: with SMTP id n22mr7449157oor.85.1589045731287;
 Sat, 09 May 2020 10:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.606.git.1587412477.gitgitgadget@gmail.com> <CAP8UFD2SNnpKWtYUztZ76OU7zBsrXyYhG_Zds1wi+NqBKCv+Qw@mail.gmail.com>
In-Reply-To: <CAP8UFD2SNnpKWtYUztZ76OU7zBsrXyYhG_Zds1wi+NqBKCv+Qw@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 9 May 2020 23:05:20 +0530
Message-ID: <CA+CkUQ8z=ZFFwGA_Xz=40HqVcjntZbGzDXFthxMF8XrEhxMY2A@mail.gmail.com>
Subject: Re: [PATCH 0/2] [WIP] removed fetch_if_missing global
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 6:40 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> You might want to add Jonathan in Cc next time, as it could help your
> patches move forward. I have added him to this email.

Thanks, I'll remember next time.

> Maybe you could add a few tests as in 6462d5eb9a.

Sounds like a plan.

> It is ok to not take care of the other places for now. If that was the
> only reason why this patch series is marked as WIP, then you might
> want to remove WIP, especially if you add tests.

I'll remove it, after writing tests.

> It would be nice if you could give the full URL of the bug, as there
> have been different bug trackers used by different people.

I'll do this in future versions.

Thanks,
Hariom

On Thu, May 7, 2020 at 6:40 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Apr 20, 2020 at 9:57 PM Hariom Verma via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > We are not much happy with global variable fetch_if_missing. So, in commit
> > 6462d5eb9a ("fetch: remove fetch_if_missing=0", 2019-11-08) Jonathan Tan
> > jonathantanmy@google.com [jonathantanmy@google.com] attempted to remove the
> > need for fetch_if_missing=0 from the fetching mechanism. After that,
> > fetch_if_missing is removed from clone and promisor-remote too.
>
> You might want to add Jonathan in Cc next time, as it could help your
> patches move forward. I have added him to this email.
>
> > I imitated the same logic to remove fetch_if_missing from fetch-pack &
> > index-pack.
>
> Maybe you could add a few tests as in 6462d5eb9a.
>
> > I'm looking forward to remove fetch_if_missing from other places too, but I
> > not sure about how to handle it.
>
> It is ok to not take care of the other places for now. If that was the
> only reason why this patch series is marked as WIP, then you might
> want to remove WIP, especially if you add tests.
>
> > In fsck, fetch_if_missing is set to 0 in the beginning of cmd_fsck().
> >
> > In rev-list, fetch_if_missing is set to 0 in parse_missing_action_value(),
> > and in cmd_rev_list() while parsing the command-line parameters.(almost
> > similar case in pack-objects)
> >
> > fixes #251
>
> It would be nice if you could give the full URL of the bug, as there
> have been different bug trackers used by different people.
>
> Thanks,
> Christian.
