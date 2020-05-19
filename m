Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA4CC433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 21:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7BE320758
	for <git@archiver.kernel.org>; Tue, 19 May 2020 21:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5s5NfQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgESVPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 17:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESVPA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 17:15:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9EBC08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 14:15:00 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g185so1345222qke.7
        for <git@vger.kernel.org>; Tue, 19 May 2020 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IQwtoK2BimauRqNnJTNdyd8PmMycpzWnoCKFNBSAYnc=;
        b=k5s5NfQUzEHP9SJb5wNFjiB3dUelOMEukmE4v+2MNgGU0Rxrn67NIMoULerG+Jyl0g
         Xd6tMIKWIz+FN6xz01NR0S3CaWsXPfhEgeeg52w3Olbg78y6IQ4qwMYDTP0y6YVQJZdu
         rSD3qCazFq8MFRAid4/6chEziXbnT3ognPYr/BivfamNT9wxGugMXqlZcflrYZt0i05J
         UWWQ7XVWNDP46sWeAU/gFjk47u8r6VHH99yDQPkjrSHNGzfso04zXTFFT+bQmTQMl4Oa
         v4JZesKUgHgGOGYmWLeAGrm34v7HCXbcYW0CndTBL8qPRadrRN9naYxEZuebFfiG5rfI
         9KMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQwtoK2BimauRqNnJTNdyd8PmMycpzWnoCKFNBSAYnc=;
        b=O0kjC3CpMDxWFbcYolLjPL3rGKP0ZG4/51VPwkrLPsOuoH7QDhwGIjbkJ+in6i4a3R
         rQ8IRf2j25hh0yjgifXfjYUMMRBarW69PjZpCfmNSRpxpSa991ntHLiLcVxbyDBJvMey
         EvUGMLb3h93nR9XcDIl/F9oW0Cqs8kwjL1md50k6ZXulXyAiHfnUERvp287GXSoJAi1G
         z0mkcLZWFdjPLMvw/hNJhkefrpZf7RImoR4Zql5PnJUUsckMVasfouHwZvjACXnq5fiR
         8E8pQtIA6Qm5q6LDef4QJASSnMXWwlD2u3Jq1CC3dLyGXKOG3uMCOQUWMipeINeIlBoP
         rgLQ==
X-Gm-Message-State: AOAM531upzJpd1l+p8HgdBhXP3flJhry5O78sIBuWd9k551vBSzV1RxX
        e1vDhRoqfQ0gfY+KelpM7b0=
X-Google-Smtp-Source: ABdhPJzip/FbHIMk6d6pW1tMT3a9hon2tr4lm+Xjes4eV2csVxxrLnSbDZC6WptvvgT8/H6966VNBw==
X-Received: by 2002:a37:72c7:: with SMTP id n190mr1469374qkc.270.1589922899799;
        Tue, 19 May 2020 14:14:59 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id k43sm895277qtk.67.2020.05.19.14.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 14:14:58 -0700 (PDT)
Date:   Tue, 19 May 2020 17:14:56 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] remote-curl: fix deadlocks when remote server
 disconnects
Message-ID: <20200519211456.GA5091@generichostname>
References: <cover.1589816718.git.liu.denton@gmail.com>
 <cover.1589885479.git.liu.denton@gmail.com>
 <20200519184004.GA88536@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519184004.GA88536@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, May 19, 2020 at 02:40:04PM -0400, Jeff King wrote:
> It _seems_ to work, because that's the case your invalid-shallow test is
> covering. I'm just not sure if it works consistently, or what error we
> might produce in some cases (e.g., saying "woah, what's the weird 0002
> packet" instead of "the server response ended unexpectedly" or
> something).
> 
> I suspect any remaining issues there are cosmetic, and it might be OK to
> just discover them organically through use. But if you happen to have
> done some poking around there, it would be nice to hear it.

From what I can tell, every time a packet is read using the reader in
do_fetch_pack_v2(), we're careful about checking the packet type so we
should be safe there. Also, when piping stuff over to index-pack and
unpack-objects, it looks like the resulting call to recv_sideband()
treats any control packets as flush packets so it should handle the 0002
fine.

I could have missed checking some spots, though. But as far as I can
tell, if it can't handle the 0002 properly, it was already buggy to
begin with. I agree that we can let any remaining issues be shaken out
through use.

> Thanks for working on this. When we had the initial discussion, I was
> really worried the solution was going to be quite nasty, but I think it
> turned out to be reasonably nice.

Thanks,

Denton

> -Peff
