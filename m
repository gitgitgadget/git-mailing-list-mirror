Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC17C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72EE61469
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhF3SWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 14:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhF3SWu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 14:22:50 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16495C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:20:21 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id m9so6518337ybo.5
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtG4+Uw+/9/j1r9wlkcSge086lRZdfajjLVwZzPEBGs=;
        b=pGmzCayj/6aJNLUFI5QM7AjszybfuYuOTQsmZz/uRIGAvyVwCylWuygFmwe/YUMkXg
         Ejvs2PEdFuydRqt68iTifQubm3eQftnl9QaFbB8iNDfhLqWOOPwiWIwhwcBmfyPN7iVn
         P8Jh89uvnh5FUUFwBtMspM9YsE3pXXH3lsZ+z6pCZh1Pr8Z1lLpv2n6hrFVUR2QiuUMw
         vphCkQ6cNFPue+oLpmKC1jYdxiaGHH8pTaU/hTwvzkZwTK+WhSW87RvtssuJDE3ZbyuZ
         EaMHy2HxV7kfQz8pnsio/3fIfJ0Y6IiVo/gv+q3RYqyxcviDyWRAZXhIr8oh8DuA9InA
         iVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtG4+Uw+/9/j1r9wlkcSge086lRZdfajjLVwZzPEBGs=;
        b=e/n0jd/sRZbG9ev/VK4Ak6FNaIj24SUqF25AW48wKh9mjfIGs6Zwy6FhsjwbRhJuI6
         NXkv99GGWKXej9lto8U4akoA0vVRfJRkPU+7tZcFedRuwVL0dM0qVEGYr+VedZxpRDyK
         yT44S8wxQsCwbZk6Es1CgbO6yc30ZrFtnOEXh/oB0Hp9hd2EuFWUtEpd0yhh3jYCGfUK
         oF683Ott/fCybW5P0DVdnaCr6Xgc2uDLwUGdssHxPDGpNd0N+QoYS6/sjOqliK9fdR1J
         xtnmbRIFT+Ju2lvP1+udl/GOMVqkybiksMsCKKcPQJwJURZw3dz1ESSxE03Ec1TriNB2
         dFuw==
X-Gm-Message-State: AOAM531rXqyEvF6D1oPJmis+AusTVW5hHTgNdUMfWraW++Qv2y2UOkv2
        xMd80zqav+2H9/UZJh6qKr5LJuqx15TLrp86Mkk=
X-Google-Smtp-Source: ABdhPJwF5pHMWEQsI/B3GwefIbV0HRFbocngDRnm88TW5oeWcnuXDaVfpandByZ04bZ3pBX9tMQzEvRiqY/D5xsPPNc=
X-Received: by 2002:a25:888b:: with SMTP id d11mr49892850ybl.385.1625077220173;
 Wed, 30 Jun 2021 11:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
 <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com> <YNyxD4qAHmbluNRe@coredump.intra.peff.net>
In-Reply-To: <YNyxD4qAHmbluNRe@coredump.intra.peff.net>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 30 Jun 2021 14:20:09 -0400
Message-ID: <CACPiFC+F9P1DY_Dgt4+Z-U4o5WRbRduq60+Df0+FHBn6=XL2hw@mail.gmail.com>
Subject: Re: Structured (ie: json) output for query commands?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 1:59 PM Jeff King <peff@peff.net> wrote:
> It's been discussed off-and-on over the years, but I don't think
> anybody's actively working on it.

thanks!

> The trace2 facility has some json output. That's probably not helpful
> for what you're doing, but it does mean we have basic json output
> routines available.

Cool. I see json-writer.c; right.

> One complication we faced is that a lot of Git's data is bag-of-bytes,

Great point -- hadn't thought of that. Don't see anything in
json-writer.c but we do use iconv already.

cheers,


m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
