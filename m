Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB86C433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 23:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E34961926
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 23:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhCSXgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 19:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCSXfv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 19:35:51 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5919EC061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 16:35:51 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n8so6522175oie.10
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 16:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=auQ6YW99YpIIm5UsY/go2iMIEoZmpjid0twWU98HTDM=;
        b=TVFFXHgMeDS6iQs8e5CwKOd2F+H/yk8psYri4fCFkKZZflZwbg3epTiTI3wU9UOIsf
         6EAtuUDw4uMyzklqwJ1GM2R3OEvsvo67FF0l4UDBEnmsrQ22oz5kRYswxWgmRX7lTDti
         ad1oYXZIfbNt4QCQXWcJNeIBJ79KlHn21niKft3LiOf/pPA0d/e+BFzp1jMWPBpJCcqp
         x47QErm8Lb2FCP1+/0IiujyNKtcOg5qGmlYE/zzLh84LDLM89kedbMPlqd/V6jpjvbXU
         nKxlQc35KNZOMDDmYGGT78lJ5bhzl5cwczg6ayXPGBt22rLR+Hc0eazyWtLh3xFYnqbz
         JfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=auQ6YW99YpIIm5UsY/go2iMIEoZmpjid0twWU98HTDM=;
        b=WtsdjluNkPMpSwOPeWO9aTEfbeHiXiwvPhXOVBKL8g8DSvEAAtIi1KXw7uj5a3BcyN
         PQWgpyRUyIgF6aM9A1OwhuXa7qMpAFmd9+qr/XA1PirpBQYzzkarWXddyr3tW61LQ4/L
         ZyMk+QLXDVCTcSdM5A5JiIKoF/0Ptl59UOLlPZpYDTFqDaOHCKxzl+vjJISONNxY6lWI
         xw9isJQs2erWBuARjLLjJKOTzijzqUIryJSWE8v8WeFEjuc7sD5mf/18HugfXOV8DkGf
         YQNhrinoHeiUaEBd82BTWhJvaFB//MSdNM8gTbCBtoD7DAWezFdGnG55/dhWsh5GTquE
         CLXw==
X-Gm-Message-State: AOAM530cgLLFwL/wh3vSr9L26FgW+f/3Aa8Ylr+hjra90cQXSpI/pcYV
        N7IN8Nn5NUeUUewVTHqNeaRt3JDkJBVjXRBKJdLtqUM663o=
X-Google-Smtp-Source: ABdhPJyLqzghA+EV7/H12dW6XcUanVsYq6FiQRASVRt7UKoJisPGVm85XJfO7kMGwQaqqPX6JRnKfkyZOneqrf5DLEc=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr2654580oij.167.1616196950729;
 Fri, 19 Mar 2021 16:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
 <pull.905.v2.git.1616016485.gitgitgadget@gmail.com> <80cccc70-296a-05d2-94a8-0e005e4abe1d@gmail.com>
In-Reply-To: <80cccc70-296a-05d2-94a8-0e005e4abe1d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 19 Mar 2021 16:35:39 -0700
Message-ID: <CABPp-BEFPCmr-_cn5bzoOefMN4LKARefKaoobcgJLjcRLBBoZg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Declare merge-ort ready for general usage
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One more thing...

On Fri, Mar 19, 2021 at 6:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/17/2021 5:27 PM, Elijah Newren via GitGitGadget wrote:

^^^ Note: 18 hours, 42 minutes difference.

> > This series depends on ort-perf-batch-10[1], and obsoletes the ort-rema=
inder
> > topic[2] (that hadn't been picked up yet, so hopefully this doesn't cau=
se
> > any confusion)
> >
> > With this series, merge-ort is ready for general usage -- it passes all
> > tests, passes dozens of tests that don't under merge-recursive, and
> > merge-ort is is already significantly faster than merge-recursive when
> > rename detection is involved. Users can select merge-ort by (a) passing
> > -sort to either git merge or git rebase, or (b) by setting pull.twohead=
=3Dort
> > [3], or (c) by setting GIT_TEST_MERGE_ALGORITHM=3Dort.
> >
> > Changes since v1:
> >
> >  * subsumed the ort-remainder topic (the first 10 patches), which has
> >    already been reviewed by both =C3=86var and Stolee[2].
> >  * the next two patches were the original v1, reviewed by Stolee
> >  * the final patch is new and adds testing.
>
> Sorry for the delay in looking at this.

Delay?!?  You only took a day and a half to respond!  That's a fast
turnaround, not a delay.  Don't apologize for that, or you'll set
unreasonably high expectations that'll scare the rest of us away.  :-)


Thanks for all your review efforts; it's very much appreciated!
