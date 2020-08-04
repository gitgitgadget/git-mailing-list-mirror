Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AB8C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46202075D
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGg3UllV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgHDNAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgHDNAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 09:00:34 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3EDC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 06:00:34 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h21so24365990qtp.11
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cup1L9UIRtMGtUkr4Tj/VDwePf31SGFgquBmZN9U1tE=;
        b=XGg3UllV6AaoHvkJSS3NFp/+6VGZuOxycyuNXfMowkBmE5bW21lK/vSZWAa7O93VrR
         Wa2eyIbRfpcNXzitqM1qZ8esgJxQGcIPatXeg6q2oKxx5k/038990+uDs3Xr9TdqfY20
         8iI6wFDWtKP3lxoHqZfnu3siEYQkq+/tTOhP2jzC5Ol+NvpYKQfCG+he/XD3+KTJ4yam
         Zrz1LtUO5dsFO2UuHqv9kEb+FagawSs114VMm5ebSOFQ0fxo28lIzluh3cPvvbMmkTWu
         IqYnkB4cdpBQ/UOO4hTKePAaSr3oA4VfgX3w3LpWLBBETiKyfrIQj2UtwMiGxf3CQpd/
         1vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cup1L9UIRtMGtUkr4Tj/VDwePf31SGFgquBmZN9U1tE=;
        b=WHe7EwE+8l1/J1DBUmgBiSwAQtHR6XWPTc3mtg0WfWjI4GsZlhXBRjY8wC6HmLJwgX
         X2DHA0830BGU+tW1FVXg566te0gwi71OlOLdphOX/tJeaisRze6Ml+kusFQAJcwLTNX7
         eQa026nTixbytHsIlSUrBNJzzaeaCTbeWFVcNu62Z0/2W12C2IXH/KkgNRrcohrnu3gP
         J0Nel9CafuuA9J4sXBNsjKRuwTxiEmjRS6ijHxrEpsQ+/7z1gbhabsq1ipHQTF/uXfts
         tOC9F3kuG0Uq2TBgg430gOpR4kzOkBWSw1eCn7GkriUdEF4d7wlbEVIEWT8EwLyGKT6y
         37Zw==
X-Gm-Message-State: AOAM531g1/CgSKPskRwnWo/2GUCDb7S9s5rh2jrmkeBopG/JUfMyDtKV
        HUnYcOqnw2POsxZh9gZFmno=
X-Google-Smtp-Source: ABdhPJyU7kocRIi1f/WMqtgy531QTDRpvL9AogDu67RWW1JW8g8uo5BKL9eVuYi6l0bWaZLCYeGlAA==
X-Received: by 2002:aed:3947:: with SMTP id l65mr22204355qte.374.1596546033186;
        Tue, 04 Aug 2020 06:00:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:359e:33e7:c1bc:799? ([2600:1700:e72:80a0:359e:33e7:c1bc:799])
        by smtp.gmail.com with ESMTPSA id h24sm21481979qkk.72.2020.08.04.06.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 06:00:32 -0700 (PDT)
Subject: Re: [PATCH 08/10] bloom: split 'get_bloom_filter()' in two
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
References: <cover.1596480582.git.me@ttaylorr.com>
 <a494094c10f9bddca5743973409ccb4540841116.1596480582.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c54cc9a8-322c-6235-4170-228354c1ff33@gmail.com>
Date:   Tue, 4 Aug 2020 09:00:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <a494094c10f9bddca5743973409ccb4540841116.1596480582.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2020 2:57 PM, Taylor Blau wrote:
> 'get_bloom_filter' takes a flag to control whether it will compute a
> Bloom filter if the requested one is missing. In the next patch, we'll
> add yet another flag to this method, which would force all but one
> caller to specify an extra 'NULL' parameter at the end.
> 
> Instead of doing this, split 'get_bloom_filter' into two functions:
> 'get_bloom_filter' and 'get_or_compute_bloom_filter'. The former only
> looks up a Bloom filter (and does not compute one if it's missing,
> thus dropping the 'compute_if_not_present' flag). The latter does
> compute missing Bloom filters, with an additional parameter to store
> whether or not it needed to do so.
> 
> This simplifies many call-sites, since the majority of existing callers
> to 'get_bloom_filter' do not want missing Bloom filters to be computed
> (so they can drop the parameter entirely and use the simpler version of
> the function).

> +struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
> +						 struct commit *c,
> +						 int compute_if_not_present,
> +						 int *computed)

Could we further simplify this by letting "computed" be the indicator
for whether we should compute the filter? If "computed" is NULL, then
we won't compute it directly. This allows us to reduce the "1, NULL)"
to "NULL)" in these callers:

> +			struct bloom_filter *filter = get_or_compute_bloom_filter(ctx->r, c, 1, NULL);

> +	filter = get_or_compute_bloom_filter(the_repository, c, 1, NULL);

Thanks,
-Stolee
