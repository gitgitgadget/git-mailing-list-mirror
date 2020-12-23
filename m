Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA116C433E6
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C5023159
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgLWOKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbgLWOKv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:10:51 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663D9C0613D3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:10:11 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id a109so15116647otc.1
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Su9evugEjpuVNyj02w304ICpZrthvZ2zlNQDxUsd7ks=;
        b=oujn1RV8n25to4oenaah6aasjNAawNRX7yQU8fTFGj00WXU2ADYeemExu8rCzIfZW5
         T/3ZKZWECe5PELuFS6s5oCBNAvsP5vrNJLC/08H+mZC8kt3dejEqD153vRnmZmgKLYsY
         szrh5Xg0N/22H6CjFVmrNzAMP2/qTDHTZAZO+s0d7Is8N21DJNT+iHcmw2mVoy2AXji8
         JxxYEVHtrb0NvjlH6maRdKSsPDvDEWQY8P7+dr2rdjWt8GTVGo8wN/c4g3QhiQIm/J1F
         Rt5rNFKzHLsG+XIPasF6VkQeKBd0t2HV0IQ9IaRfkTirmCCdhomyezC/r5a4lgixt1tc
         BMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Su9evugEjpuVNyj02w304ICpZrthvZ2zlNQDxUsd7ks=;
        b=rqzka9XFINmlYGn6aMbwH1jd/019pGEpP5bFJFf73YFvc4Tc8FMFJEYSBl52nCO2YS
         kIY36G58DUJSrkz0/zfP/lEBB1UgHXnxfx2uyxtRh0hrtDmxO5NH+e+GmeLXIEMSgrP6
         VAdTL6o93qkmtWWFU4+V4a4Jk85/DEYW6RUv4EiY5eIykvPJAIvGHJ3yePXB5ZnxoUb1
         rEei9Q/8BnwZrDpKqVoPWacqoIXXNqiUSvcoTsdubsyeRAVaqgBF6P2CiYbsyRfkaIdo
         kBfGcLS1ipKgE2+lsaDJiM2N6NKq2LtFZoGxN8Q4Z2GroQoypP8yQTsgAfEokb/W8V7i
         QySw==
X-Gm-Message-State: AOAM531CqCBPEg3sJ7wlvKei1dR88fTa8IBYYgIrndhPGjr6DFzRqllD
        xToXIg+pEp0exof4/QkVCO4=
X-Google-Smtp-Source: ABdhPJxZkCX+aHZJ60FRyvKPfP6xSxOb+MP3TTFG5zHV4bFbwWEY0VmgPtxNafyHFeOazpJPPu9JPA==
X-Received: by 2002:a9d:68d8:: with SMTP id i24mr20439627oto.31.1608732610795;
        Wed, 23 Dec 2020 06:10:10 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id d124sm5318390oib.54.2020.12.23.06.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 06:10:10 -0800 (PST)
Date:   Wed, 23 Dec 2020 08:10:09 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <5fe34fc13163_198be208bd@natae.notmuch>
In-Reply-To: <xmqqsg7waleg.fsf@gitster.c.googlers.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
 <5fd85811c3a6_d7c48208aa@natae.notmuch>
 <xmqqmtyf8hfm.fsf@gitster.c.googlers.com>
 <5fd8aa6a52e81_190cd7208c8@natae.notmuch>
 <5fdd154264baf_130e182082b@natae.notmuch>
 <xmqqsg7waleg.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v7 0/5] making pull advice not to trigger when unneeded
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > It's clear --ff doesn't imply a merge, so we shouldn't act as if it was.
> 
> Do you specifically mean --ff, or do you talk collectively about
> anything that goes in opt_ff in the C code?

I meant --ff, but the rationale can be extended to all of opt_ff.

> The "--ff" option means "we are allowing fast-forward, so please do
> not make new commit object unnecessarily, but it is just we are
> allowing---we are not limiting ourselves to fast-forard; feel free
> to create a merge commit if necessary".

Yes. *If* a rebase is not specified.

> So it does imply that the user prefers to merge and does not want to
> rebase.

We could imply that, but currently it doesn't.

Currently this does not do a merge:

  git config pull.rebase true
  git pull --ff

> If you meant what opt_ff can relay, then there are "--no-ff" and
> "--ff-only" to consider:
> 
>  - "--no-ff" says "we do not allow fast-forward; when the other side
>    is pure descendant of ours, create a merge commit to make them
>    the second parent, so that our side of the history stays to be
>    the first-parent chain that merged them as a side topic."  It may
>    not say what should happen when the history does not
>    fast-forward, and it _is_ possible to argue, for the sake of
>    argument, that it asks to rebase if not fast-forward (so that
>    their history becomes the primary and we build on top of them)
>    while asking to merge if fast-forward (so that our history stays
>    the primary and we absorb their work as a side branch), but that
>    is a behavior that does not make much sense.

I agree it doesn't make much sense; if the user wants a rebase in case
of non-fast-forward, --no-ff is the only way.

>    It is much easier to reason about if we accept that the user who
>    says "--no-ff" expects a merge to happen, not a rebase.

Yes, but currently that's not the case.

Currently this doesn't do a merge:

  git config pull.rebase true
  git pull --no-ff

We would need to change the semantics.

>  - "--ff-only" says "when their history is pure descendant of ours,
>    just fast-forward our branch to match their history, and
>    otherwise fail."  This one does not have to imply either merge or
>    rebase, as both would give us identical result (i.e. merge would
>    fast-forward and rebase would replay *no* work of our own on top
>    of theirs.  Either case, the result is that our branch tip now
>    points at the tip of their history).
> 
>    The topic under discussion is based on the "we do not have to
>    give advice between merge and rebase if the history
>    fast-forwards", and anybody in support of the topic would be in
>    agreement with this case.

Yes.

> In any case, I think what we have in 'seen' already is a good
> stopping point for this cycle.

It's not a bad stopping point.

But the next patches are needed too. Up to the first 6 patches should be
uncontroversial.

> We are not erroring out any new case and simply not showing an advice
> in a situation that it would not apply---the question "does --ff imply
> merge?" does not have to be answered in order to evaluate the 5-patch
> series we have.

Not my patches.

The patch you introduced regarding rebase_unspecified does depend on
what happens next. If we decide to change the semantics of --ff* and
imply a merge, then my patch to add REBASE_DEFAULT is needed, and as you
can see in another patch series [1], that basically has to revert your patch.

Cheers.

[1] https://lore.kernel.org/git/20201218211026.1937168-8-felipe.contreras@gmail.com/

-- 
Felipe Contreras
