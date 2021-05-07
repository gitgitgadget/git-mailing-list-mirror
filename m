Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F394C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 01:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC996112F
	for <git@archiver.kernel.org>; Fri,  7 May 2021 01:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhEGBcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 21:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEGBcO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 21:32:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E165FC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 18:31:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z9so10504105lfu.8
        for <git@vger.kernel.org>; Thu, 06 May 2021 18:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwAM5cgFqGh81bFdTPh1M9M42L7exh24Uz4JxEWgSqw=;
        b=YhriaGQAglIg9AfsVPKGs89XT5EsLd9U5zcgPKuqOcQjQ243iLsIWayQGxXO8bfpq5
         u6125Jv5BIiNvHMNvLWhLsQI/3hmb6VoInbODGs6puuW2sdmAi4Q/11dKJJPhGSd2+A4
         WF6T1BL/6/IY8nZPBdchyvetmqa+nATU9IGPKDvO3Rry9IuV278wsHu+V1pBx6TQ6PSo
         Jhz/eSw/GPUQyzDbdhgpdt9Oc15jRU+KY+jUslgCpINBhFXEuTLK1puq7Muf9kX9Aai3
         pZjvzfi/2HicuVfEhhQWwgAL0znWbCETvxV1dgsl2KW68OArRNbKHxwgE9bcuxllbssR
         f9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwAM5cgFqGh81bFdTPh1M9M42L7exh24Uz4JxEWgSqw=;
        b=pnw3urPD0s+L9yZMzx5OmLOxCAr1uRoPEv9KPvvy5fQnUHcBFRXIgMsH67pUrFX/Xp
         dj33CNb4rAGpcr2ThguC7d4NR7OE1x9OptsHSS94UJDGp5rWgoJLiKDRXG5siaOw2+ka
         ySWjGG3MEkS32p88StqyL/cl1o6kHN2kcM1E1QUsIKXxDyULlf0q27foC+w28wKWX214
         6FlqSEY1sHJWDbxaH2WXsLzsNA+SVeUfZOG23y1dzAnwd4FU04hgToKBcC82t0qeweK9
         K2VRF2+4LO9H7h9EiFm4g3EqkBDfW9vrCfvARPqbo4zg1XiS2saIKm35GLWzx1kf3aBQ
         8hfA==
X-Gm-Message-State: AOAM5311N8Kdo5h3u7JGq9CZfDgKCXvBAUjYd3L5hJ9LvHTFq0ZzGe80
        ftDtr5rdA3x9Fw+BrkM3dqhTCT+pXtIJY/m0KdY=
X-Google-Smtp-Source: ABdhPJwsmRd0WOcPf8HK2A7L5iH23nxuV3soVBPGGhQocLdeORd7v6NLvUQBD/9Bs0w/gt2ycXGQeNuHK5dJKk2oJl4=
X-Received: by 2002:a05:6512:c04:: with SMTP id z4mr4751442lfu.167.1620351073419;
 Thu, 06 May 2021 18:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru> <xmqqmttgfz8e.fsf@gitster.g>
 <xmqqy2d0cr5l.fsf@gitster.g> <87v9837tzm.fsf@osv.gnss.ru> <xmqqzgxfb80r.fsf@gitster.g>
 <87czu7u32v.fsf@osv.gnss.ru> <xmqqtunj70zy.fsf@gitster.g> <87eeemhnj4.fsf@osv.gnss.ru>
 <xmqqbl9q7jxf.fsf@gitster.g> <87r1imbmzz.fsf@osv.gnss.ru> <xmqqy2cu58vo.fsf@gitster.g>
 <87tunh9tye.fsf@osv.gnss.ru> <xmqqim3w3dvx.fsf@gitster.g> <87wnscuif9.fsf@osv.gnss.ru>
 <xmqqpmy3y5ar.fsf@gitster.g> <87sg2zr3l0.fsf@osv.gnss.ru>
In-Reply-To: <87sg2zr3l0.fsf@osv.gnss.ru>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 6 May 2021 19:31:01 -0600
Message-ID: <CAMMLpeQ9q+XRP7eyk4UhmSRDnrw-c57hAkcT+_gEKXFprx4qeQ@mail.gmail.com>
Subject: Re: Why doesn't `git log -m` imply `-p`?
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 6, 2021 at 2:48 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> F> Sergey Organov <sorganov@gmail.com> writes:
> >
> >> It's nice we've reached mutual understanding!
> >
> > Yes, and thanks for correcting me.
> >
> >> The only remaining issue then is if we just go and do the change of -m
> >> semantics, or do we need to take some backward compatibility measures?
> >> Looks like we are rather safe to just go, as it's unlikely there will be
> >> any real breakage. What do you think?
> >
> > I still wish I could come up with the usual backward compatibility
> > transition dance for this case, but I do not think there is one.
>
> Fine, thanks, so I'll prepare and submit a patch.

Thanks guys! I am so glad you were able to reach a consensus!

-Alex
