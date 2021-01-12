Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0314DC43381
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49CA22202
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436594AbhALTuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 14:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393255AbhALTuS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 14:50:18 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD56C06179F
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 11:49:37 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id z11so3016429qkj.7
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 11:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ubTfV3WwnuCdFPAislsaMx6AisCEuQ37+mk1B2oiJg=;
        b=NKlPix6GMLJo/xx0KS4vu30JIQ3Moyb9BeKk340ACBtUJ4qhKngODQhFZb4oeGwgm8
         jsSKzpkXbt0SnRhHryD4866aJpaqMUHGHVP01yKA30zJYOzXiCmpLTDGMAwRN10QA23/
         aQyWAaEo1ee4z+ghw6NofliVnEmqeAy60VLogMAKdP823zVTHHJz1N7UU3c0rN1ynE85
         mSlgxbv7hb1scbqG7phrNRKMX70ej9YD4Ad9Q+7zlYJHa20YcA7LI2U/c0ErRBspu6Dg
         KDHkLbkAN9Af9B/jgL0BArt3mH3MKz/4W8YZpXDIZi1/BiLYNGD+dX70s92++AIklsBG
         LuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ubTfV3WwnuCdFPAislsaMx6AisCEuQ37+mk1B2oiJg=;
        b=ZQ0ngZ1aXsTxldXDz6tA2IgrqoQs8rGJxFuYLZMueiT5z5dpgQ/7fdohTaEvy8sxCC
         KorQtb7AV7I7YzHrfHXU7GRq9xvS4fBgNZWNEcMPXitZTsdssUm845sZbqyFwT/QmslA
         JaNJDNHPAfpcQENGd43ri7P1z5Umnc8rSUL9w9CNunBe+uyRHrXO3WEn1nsWxZoCpAKA
         r/piz0lvUvvn8hMRZ0OiRlPTLmtaRQZoC2jw0QYDtz4KjdyTGhhMV1tVcE84pndFqDPS
         Y/oMLaG4i2+S5lHT/wbDxKI+49rnrN3AOmdGWKxqhFKqMS9q/t7EgTKPOMqDGqNkwjxt
         UNow==
X-Gm-Message-State: AOAM532utigVZLv3RljAzg06gM5PrfgJhKRsS0q+69Ntqr5Ua0us1dDy
        dY5FLuHEpZeVdxiHWfkLSUeC/eTgmfpzsA==
X-Google-Smtp-Source: ABdhPJzPh9BKeP/B6kNByyiVlPNdWosT6a8chsuAalKOBvIquoA3QkkENM2mR5pc16BbsDtP0SwHGw==
X-Received: by 2002:a37:a06:: with SMTP id 6mr1073909qkk.376.1610480976942;
        Tue, 12 Jan 2021 11:49:36 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id b65sm1850411qkg.75.2021.01.12.11.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:49:35 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:49:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] fetch-pack: refactor writing promisor file
Message-ID: <X/39TS5C2TNf2X6t@nand.local>
References: <20210112082159.2277214-1-chriscool@tuxfamily.org>
 <20210112082159.2277214-2-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112082159.2277214-2-chriscool@tuxfamily.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 09:21:59AM +0100, Christian Couder wrote:
> Let's replace the 2 different pieces of code that write a
> promisor file in 'builtin/repack.c' and 'fetch-pack.c'
> with a new function called 'write_promisor_file()' in
> 'pack-write.c' and 'pack.h'.

This is just great. Even though I'm sure that I have read that code in
builtin/repack.c a hundred times before, I for some reason always have
to remind myself what it is doing.

So, I'm very happy to see that it is being cleaned up behind a function
whose name describes its behavior clearly. And, if that function can be
used to remove some duplication in a sensible fashion along the way,
then all the better.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
