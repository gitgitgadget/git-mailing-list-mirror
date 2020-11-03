Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A37C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 11:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E4D208B6
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 11:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+7jq5PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgKCLDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 06:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgKCLDN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 06:03:13 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C7C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 03:03:12 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id u62so18007340iod.8
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 03:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9d4v2OzH78fVzlWt+QfvZ/vvKu9QB5RMPA0Gy/JxUc=;
        b=X+7jq5PEPDMc+3J7MM8wJnhLIF0FiEtSf4RLKUEZHNsXmMZF0WO5ec7cku1dY1iYG3
         jeGpQ0QZTEwICXNZ6ApILx3Lo4ac3svdLjZgTGzcqKwnnAJMOazU1oizs6iFQPeMtq05
         OiKyHHbEWnWd/yrxtqWOIBhc5poPcMoMxcr6Akxdxs0euZuhnWONqtl8aSndBvNMggzx
         9PSHGWMccKd9JFMC1q/xdVP/4N+viN/nxIL12AspxVeRDDcWZ4ZFN3zamULvxCCXTWpS
         7G15pAfbn6yJBjQR3Tu+jTNEdFTi0VH6Haol5pE5SRjWEglf1KuKC5ll+mS31RHU3Ruc
         j3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9d4v2OzH78fVzlWt+QfvZ/vvKu9QB5RMPA0Gy/JxUc=;
        b=GRHMWF6EahyyZA60P929pftGnptLdBiG/5oR4FIfTFTbKZbNnhDVz8irMVVZc7OAvK
         lk4x9jPOH1fjZVUwOnvSyyZjZ0ovsZ/hrcBLjF/OVRNlz9U/kVBDHOlvQZNd9gYr5D/T
         C7adO4WnS4X9FgBHYZb36ZdPk+1x7n/u14rgFKEet1qhPLUdpSmg7T86F+5L154/aBd0
         YQyja1yObPte1zEvKn85Zbss7OOg8/556R9DN5IssWkjZudcN+z+wc+Bc7wzvNQWQkpT
         iZO2gBBiLUfHXHh/npjJMAv6uGOLnOsvUWMVf+A7TrttbusHgXj4zMcHGeoDXCwbQoG0
         +k7Q==
X-Gm-Message-State: AOAM5320TFw2v+s+WZKsoh+RUIYJebUXFA/J3GA1echNB+uksNkEZmxU
        pTMqiOx2GOjDVhJfOupcrJfCPM5b/KzOgDGigis=
X-Google-Smtp-Source: ABdhPJwsiQ6Kvliv851gvy8Cib2T9cO/b91MAgdSU7wAbfJ50FZo777msjJ70vU62/iY8EQsz6PB0ioLdU/2pYYczRo=
X-Received: by 2002:a02:6a25:: with SMTP id l37mr1938172jac.70.1604401391577;
 Tue, 03 Nov 2020 03:03:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
 <24f2c4a62317231f4eabed23bb24d345abc9d67e.1603807338.git.gitgitgadget@gmail.com>
 <xmqq7drbbcj5.fsf@gitster.c.googlers.com> <CAFzd1+7wzPZa9brWzWzSQdcMEnbEcV28zqBBAV_rsdsKNaKaFg@mail.gmail.com>
 <xmqqpn4vqogu.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn4vqogu.fsf@gitster.c.googlers.com>
From:   "herr.kaste" <herr.kaste@gmail.com>
Date:   Tue, 3 Nov 2020 12:02:45 +0100
Message-ID: <CAFzd1+5D4pHhGf=K0LwaaOUjoBByqsMTpBVtR+Ots6-afBTDEA@mail.gmail.com>
Subject: Re: [PATCH 1/4] rebase -i: stop overwriting ORIG_HEAD buffer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Di., 3. Nov. 2020 um 01:21 Uhr schrieb Junio C Hamano <gitster@pobox.com>:
>
> "herr.kaste" <herr.kaste@gmail.com> writes:
>
> > Phillip pointed out that ORIG_HEAD is actually not save *if* there is
> > a `reset` or `rebase --skip` during the rebase.  Otherwise, by design,
> > ORIG_HEAD would be easier to use, as in the form `<branch_name>@{<n>}`
> > two things have to be decided and can go wrong.
>
> What "two"?  You should be able to just say @{1} regardless---that
> was the whole point of performing all the intermediate steps while
> on the detached HEAD so that you can rely on <n> being 1, and @{<num
> or time>} is a short-hand of <branch>@{<num or time>} for the
> current branch, and not a short-hand for HEAD@{...}, to help such a
> use case.
>
> Or am I missing something?

Well, "@{1}" basically means: from the stream of things that happened take
the first.  It is very natural to refer to the most recent thing differently.
In practice, until now, I used the {...} form only to refer to older things.
To put it differently, using {...} I'm researching history.

From the docs:

    ORIG_HEAD is created by commands that move your HEAD in a drastic way,
    to record the position of the HEAD before their operation, so that you
    can easily change the tip of the branch back to the state before you ran
    them.

That's just humane.  You do something, and then you revert.  I don't need
a concept of a written history here, just of recency.
