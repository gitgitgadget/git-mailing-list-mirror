Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F8C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 05:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6528820842
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 05:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxrDhpxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgHEF4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 01:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEF4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 01:56:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CE7C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 22:56:06 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qc22so30238067ejb.4
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 22:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xrVNi0QLDJybGXDPwmWYnASAr4TAN3C3MkhawBdHVcc=;
        b=OxrDhpxDXr/3LgJzrPuGDMb0FmH5+8QtYBBQnHPLpKiAfNnjam1M9aWGmJIKCesCn6
         sYXzqJT9vLiaa4JXV/uEzaE97m1J1S+fa2q8Fvn0/1XGtYxkBKigoC/5jk8FYZ8vUX33
         MM1KEqG9clHeL0ZD8dK6LpjWGkzqSmgm6VtI/KO+qj++64A6843xHRkXo/xhFlzwWLB/
         wDscBN08Cbjl3ZE4ZEUkDZJcuLRsiFQJHHDCDxk7eiCoQxwhoCZrqSIazgecyNiL+pP5
         I31+8q+tLJHzZ1+gIUZw8E95a4pGa0ICRKUVtW9L6e2vglEpu2m12zWGacG6wE9jx+SM
         n6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xrVNi0QLDJybGXDPwmWYnASAr4TAN3C3MkhawBdHVcc=;
        b=kemK9ob8fK/RigddA1TmbF95M3EvIH3ODQl3Jgh4jXfH3xRSUC2+Fjmf36tmyI0kFv
         P0dU+egZ5cJzYwPYjUbRBDwZg9AYvPVU4U4VWh7AusgtJEMncU76nhr5hXx0hLe6RTuR
         SE8cdbIaTJsI/1v7cp3kBMc5xBzhV3VkIStHZcrPEDX2WaLtAiN2L2OUiFmGBMPnne8v
         gHGpHOCl8VgojCpv4QueXgyPXU49xDchNKLm0x75mpAEWLJLeVyXsHZBa6v3iEjOSQc9
         yRRs0B7Iaag6IskHFBPVVZ9v8B10YRSOmAYb7Fh8MEog5T8P+Ew2r0MgsYZ/U+ErT493
         ZpSw==
X-Gm-Message-State: AOAM531iBBL9DRdaN0CX3NxmPtDYrOXl8KwdsoNTPjWxcYnfNwA0snJi
        n69+A0sGq5oGJcgR5RwMvUAXleWddoY2HQIc/uU=
X-Google-Smtp-Source: ABdhPJwElr+wS2FjW5BzvAI7Mon3wi179FdTVq+PFe+Kur6e/obQaiBvrSAJQMnwukHP1/b9LzxNtG+IUaGPKwz4JYE=
X-Received: by 2002:a17:906:1ec3:: with SMTP id m3mr1635651ejj.197.1596606964832;
 Tue, 04 Aug 2020 22:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200801175840.1877-1-alipman88@gmail.com> <20200804220113.5909-1-alipman88@gmail.com>
In-Reply-To: <20200804220113.5909-1-alipman88@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 5 Aug 2020 07:55:53 +0200
Message-ID: <CAP8UFD1Z1V6+iPO2CMOqdHhUGkmTdvCK+TDNtoOcX8QvC4coNQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Introduce --first-parent flag for git bisect
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 5, 2020 at 12:04 AM Aaron Lipman <alipman88@gmail.com> wrote:
>
> OK, here's take 4! Responding to Junio's feedback, first:

[...]

> Martin, thanks for your suggestions

[...]

It's better to have the people you are replying to as recipients of
your emails (in the "To:" field). I have added them into "Cc:".

> > (Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>, FWIW.)
>
> I'm still getting used to the conventions - should I add your name as
> a signed-off-by tag, a thanks-to tag, or both?

We often use the following trailers:

- "Helped-by:" when someone helped you
- "Suggested-by:" when someone suggested the main idea in the patch
- "Reported-by:" when someone reported an issue fixed by the patch
- "Acked-by:" when someone explicitly acked the patch
- "Reviewed-by:" when someone explicitly gave their "Reviewed-by:"

If your patch is based on a patch from someone else, you can also keep
the "Signed-off-by:" and other trailers that the person already put in
the commit message. If you haven't made a lot of changes to a patch
initially from someone else you can also keep them as the author.

Thanks,
Christian.
