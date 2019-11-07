Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD921F454
	for <e@80x24.org>; Thu,  7 Nov 2019 05:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfKGFHU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 00:07:20 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37714 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGFHU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 00:07:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so531969lfp.4
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 21:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBVv/QoNbdp03L+OlJ0MvFyPKpRbYNKNXDKeNkUTy2E=;
        b=iEu92QwqCEcl/WSyTfuSE20KNxnKTG8OpbBod9OfQar1YCvTM0rVuWK0hIjXQHhTzo
         4w931F1gmILOJxDz7/3D3yOVsF+11Ar2OOB6Hxe2N2Wuw3yhRuBG2Dh50bib69peWUdt
         dKyBby78Z00BMQPXmWhMpq85pzWmS/ISYOeOWlvgYsFwnjPUsyifmuo36CqLntfBdFIL
         r2FQDrXNasrgoZEgkM7ex+1f270Nosmz1Y3vCQV7NCwHVsVLJriPrahiFSysTY+/dsS4
         pgkw7HGSTrgCOuU5N+BwH+g4bK4Z4FpvHF25f0IIHsybqJKXcZk1Z1NZHJ7aF2rUKCeM
         4EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBVv/QoNbdp03L+OlJ0MvFyPKpRbYNKNXDKeNkUTy2E=;
        b=gkMZ590vBXURY+maS20OcpuzrM2I2SjGTP2xJfp3PdxP25GbZND8vGrRn5RtylkFTc
         QazjfklK3eofrkfvKUva47okhalBNZ73s9HC47J5YSWhucssDcR5/eEDMPKvZtbCaIsy
         UqSwLhRtLPxrbpjZ8wNmysbB74IG+3tp7ZrvF9aqLkKRKIdt9Ipx5kqO42SUuXHDqbod
         SDsQg1I3Qb4RWjD/K+XvfQh4cmzyuMeu477wqE5cv9jCienWj2ICw23LTpkYAiClOY/b
         OvBqhM6cpUqFFL5lkzU0YsntaWt1jxzvKGZXLRBGZ05JQXnW7yHWzMCd/A/bRLMQ1zrF
         j10w==
X-Gm-Message-State: APjAAAUIsNeNtdRLv9ba7WwsdZOdaNZK8+qD9lVRGKHamRKazU/ys02Y
        yUqhiCVHSdk0iEAlJgK/KtA+nWyWQuRdD9RsqxT7MWuk
X-Google-Smtp-Source: APXvYqylGFGQ3OOwSWZgV6YP+0/svW38INXgcrTXkj5P3G6bFQUsCZ/IMLTAVz8Jiyfo8kNolqBvX+luFPhHSOkJlYQ=
X-Received: by 2002:a19:41c8:: with SMTP id o191mr832595lfa.101.1573103238125;
 Wed, 06 Nov 2019 21:07:18 -0800 (PST)
MIME-Version: 1.0
References: <xmqqtv7hvi6r.fsf@gitster-ct.c.googlers.com> <20191106213609.57464-1-jonathantanmy@google.com>
In-Reply-To: <20191106213609.57464-1-jonathantanmy@google.com>
From:   Jubilee Young <workingjubilee@gmail.com>
Date:   Wed, 6 Nov 2019 21:07:06 -0800
Message-ID: <CAPNHn3oCOQRriDLmLFag0DWgvq2t3TLMiu25HyBKcuBuwLgb2g@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] Implement rev-list --bisect* --first-parent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi! Thanks for all the feedback.

On Wed, Nov 6, 2019 at 1:36 PM Jonathan Tan <jonathantanmy@google.com>
wrote:
>
> > > Also, clarify in the commit message somewhere that this commit does
not
> > > change the behavior of "git bisect".
> >
> > s/\.$/ when used without the "--first-parent" option&/; you mean?
>
> As far as I know, "git bisect" doesn't support --first-parent, whether
> before or after this patch.

Correct, it still provides the usual "usage: git bisect ..." error.
This provides plumbing but no porcelain right now.

> At first I thought that this patch also teaches "git bisect" to support
> "--first-parent", but that is not the case. Only "git rev-list" learns
> to make "--bisect" work with "--first-parent". So I wanted the
> clarification. (But if you think that the clarification is unnecessary,
> that's fine too.)

I had been trying to deduce the best approach for writing the commit
message but in the end I retained a hunch that I didn't yet know enough
to write the best one so this conversation is quite illuminating re:
commit style.

If it's even slightly confusing I would like to clarify, since bisect.c
and git bisect are... very different!

I think Dscho's recommendation also will result in the patch overall
being far more lucid.
