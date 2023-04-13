Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B9C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 13:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjDMN7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjDMN7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 09:59:30 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B7AF0A
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 06:59:03 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1842e8a8825so17915848fac.13
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681394343; x=1683986343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tAaoPTLgxxSpbmrvLcvrUHoxjszguNfBHRHUgwsmOY=;
        b=DEaPX3mAE9PtpH3nOVQ2qeQ0o4ggUAk4EAG2Vb2ZtUxBgsheUWmgY46VDPlOnLrpGh
         xF27SGB3RJvTgcC5IbChGlciI3v88pzGZWW5+wk9JJP2usKbmIWFu7FZJnEE1NP07N/j
         bjY10PNWw+FHIA4KcH0U48RERikVEKC/0ZuPFElbHHYbCwzCOlShYKETVm9KOe4oVwh+
         9twTkkc1gPmHmJhf68lTdEgiDsjoVz4wfK9nhRP33winb2eF2UcsC1wE/0qBZmcXfdU9
         uEmaqu3ushFfj+ObKSaXlCvvEFpQ5h8sWN9JEwTMvqWg55W4ZomdlW1H/a55wv3YxjEg
         e17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681394343; x=1683986343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tAaoPTLgxxSpbmrvLcvrUHoxjszguNfBHRHUgwsmOY=;
        b=i4FMNVZTyNw0PSK7s8pvh8hpH/Myf6v0Wa1ba3oGF37JAJde+ZIFBe7FU0bILHWlWe
         6UjKw5uJjeic+rj+jrQwRV8EUowbsdn5K1kGSk9f9DTFSr4je4zei9jN1/EpIoN2GZoa
         O2If2Gkb8v10Uec6UCTVvEZhy9dznryP/q8eCbMtfM52YMECVRSbX6272xUM+sO0vC+U
         1/xmlgmE4MgHwbCvpGdhQrssB5qPPzZ5ZY6kLtGh3oO8emo/METuvPfgcMvnETLe3Wvc
         7tsDP1LCf50aZga5Zn8J/6sPl3o9ApPkh6WcymjqWKwXX9Tm9obVRj9b6q6pqjrvt743
         2kpg==
X-Gm-Message-State: AAQBX9cEAbYSUvYIvZTby+vkgycrae3yuY+dr4sY3nrZCHNYSMuYvjM4
        dvbBZcgRh0UaChpvPEj5e8aE
X-Google-Smtp-Source: AKy350aEkvDErspgYEhR6GkpozIOyB3hxhHGpfWLOwA1JzFhz3pcf8+eqqyWRoh37EUDig+RmE1jOg==
X-Received: by 2002:a05:6870:5897:b0:17a:cabc:c930 with SMTP id be23-20020a056870589700b0017acabcc930mr1614556oab.4.1681394343188;
        Thu, 13 Apr 2023 06:59:03 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n6-20020a4a4006000000b0053b547ebee7sm624479ooa.1.2023.04.13.06.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 06:59:02 -0700 (PDT)
Message-ID: <52079b9b-a55c-e7d1-930e-38105dd8a85b@github.com>
Date:   Thu, 13 Apr 2023 09:59:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 09/10] repack: honor `-l` when calculating pack
 geometry
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
 <285695deafa5a4a49f774dc484782dd8e4fd4997.1681384405.git.ps@pks.im>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <285695deafa5a4a49f774dc484782dd8e4fd4997.1681384405.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2023 7:16 AM, Patrick Steinhardt wrote:
> When the user passes `-l` to git-repack(1), then they essentially ask us
> to only repack objects part of the local object database while ignoring
> any packfiles part of an alternate object database. And we in fact honor
> this bit when doing a geometric repack as the resulting packfile will
> only ever contain local objects.

> +	# Verify that our assumptions actually hold: both generated packfiles
> +	# should have three objects and should be non-equal.
> +	packed_objects shared/.git/objects/pack/pack-*.idx >packed-objects &&
> +	test_line_count = 3 packed-objects &&
> +	packed_objects member/.git/objects/pack/pack-*.idx >packed-objetcs &&

Typo: s/packed-objetcs/packed-objects/

> +	test_line_count = 3 packed-objects &&
> +	test "$(basename member/.git/objects/pack/pack-*.pack)" != "$(basename shared/.git/objects/pack/pack-*.pack)" &&

nit: could we do this where we store the output of the previous two
commands into different files and then use "! test_cmp"?

	packed_objects shared/.git/objects/pack/pack-*.idx >shared-objects &&
	packed_objects member/.git/objects/pack/pack-*.idx >member-objects &&
	test_line_count = 3 shared-objects &&
	test_line_count = 3 member-objects &&
	! test_cmp shared-objects member-objects &&

Thanks,
-Stolee
