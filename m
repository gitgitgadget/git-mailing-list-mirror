Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3393FC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66E82246B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 12:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgLOMzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 07:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgLOMyY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 07:54:24 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88453C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 04:53:44 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id x13so19226278oto.8
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 04:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6oirzDkd9Em6WRiLEcBSj6vIbqOeT/8G06UzMBjc4RI=;
        b=tOI54/QTAu0fgxgziTwnIsgRdTIk25oOlPYYVxMKGSlb2TmcWoujxlwd8SNWPcBJTZ
         jpZI1dkhFq5VVtO+RfJvaZ2iw26SfnFEyPIPlRDrAJRADD9OrV004QSqon+EEtRNXOgK
         7gMGxaOOayoYUvgBDBh8It5pX2jKGDjpFEj3XzHnugRssSNTMD9rx+cH4ar5ZYIOuf7b
         tJisRJO8o9Qs26pFhzlS1bpxIHwL9lrab1tUraLd53TsbIw8YqlPNF4hZC6vezzPR5M7
         8NmIicG8P0AdmuMh3OC2SstuZ7eM2bZZaDJjZbi5f5yklYadlxptXRIlCyc9Mcc/Tm3C
         Jnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6oirzDkd9Em6WRiLEcBSj6vIbqOeT/8G06UzMBjc4RI=;
        b=m5Hv1Pu6w7Oj+eQFI8FnSzlBipuf/NTcrZdbKClrcBI4o615tWbeAR60cJPocAwVI+
         Zotdo+orpGCcmQL3drj7ryw0TBLFxgzTlTCKSRpLqAVelgn/otT9GR8BjzjrUNL2Pq1d
         YU2mgaGYh+3db7/ce2mulX/BfypTXsUwX37uTlW8bXFRnx96cNd4/dXA55z0HlARObOv
         WIFncu+LNb/AfPAvGxyuvjVF4Hw3IMG86qE4BtlluqTXEPnmBZjBcWviBkkawenWBK8v
         sO/SO+2aQfpPnQMPNHTCB6mfHR6DWB4irpghJCu3Isu9jiU4B7JJgS6DjGAbfA2rqZK1
         mxrw==
X-Gm-Message-State: AOAM532rnae9EDJWzk4fI5lWoQ6MwSWt4of+TgKnqh+/d0Gb1zvD3cJc
        FCEQc1syYSmQ1x0LsnIc0Ew=
X-Google-Smtp-Source: ABdhPJxBP1b7TDcJUncTLbSdRl4XsbFndI91gho2bGjeyZNCAABPjRoeIImjrWusp4Vs5p0Q3vnRjA==
X-Received: by 2002:a9d:4b19:: with SMTP id q25mr689369otf.124.1608036823898;
        Tue, 15 Dec 2020 04:53:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 186sm2745686oie.38.2020.12.15.04.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 04:53:43 -0800 (PST)
Date:   Tue, 15 Dec 2020 06:53:41 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Message-ID: <5fd8b1d5d4d7c_190cd7208b@natae.notmuch>
In-Reply-To: <xmqqh7on8gia.fsf@gitster.c.googlers.com>
References: <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
 <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
 <xmqq360h8286.fsf@gitster.c.googlers.com>
 <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
 <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
 <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
 <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
 <xmqqy2i6w45c.fsf@gitster.c.googlers.com>
 <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
 <xmqqtussirsl.fsf@gitster.c.googlers.com>
 <X9ggAxk/z0D9Qom+@coredump.intra.peff.net>
 <xmqqh7on8gia.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > So I like pull.mode in that sense. But it is also weighed against the
> > fact that we'd still have to support pull.rebase, and we'd still have to
> > support pull.ff, and explain how those interact with pull.mode (and I
> > think any new error in this area must be squelched by those existing
> > variables, or it would be a regression for people who already picked
> > their default long ago).
> 
> I agree that if we were starting from scratch, things would have
> been much simpler; choose among three ways to reconcile histories
> (merge, rebase, or ff-only), without adding --[no-]rebase, and allow
> --[no-]ff only when merging (i.e. things like --ff-only --ff,
> --no-ff --rebase, would be nonsense combinations).  The additional
> complexity of introducing pull.mode is the primary thing I am
> hesitant to support it, as we have to design and explain how
> existing knobs interact with newer one.

I have already tried all the options.

If we go through a deprecation period (which I insist we must), the
options are these:

 1. Change the semantics of --ff-only (breaks backwards-compatibility)
 2. Add a "pull.rebase=ff-only" option (very weird)
 3. Add a "pull.mode" configuration (tons of advantages)

Yes, we have to map the modes to the existing knobs, but it's not complex:

 * pull.rebase = false  <=> pull.mode = merge
 * pull.rebase = true   <=> pull.mode = rebase
 * pull.rebase = *       -> pull.mode = rebase

That's it. We don't even have to map --ff-only (which has different
semantics anyway).

Cheers.

-- 
Felipe Contreras
