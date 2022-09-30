Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEB1C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 12:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiI3MuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 08:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiI3Mtj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 08:49:39 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6BB16511A
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 05:49:22 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id d64so4611006oia.9
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Rs8ijyDGLRK/rPR78e/3ggRUVyd88+4mbQWpho1TJXM=;
        b=PhV+CST0DaA7jHsXJmbWY7u8dju47jFm+bmrQLLxphttJjB50MH+F1x6wtKJ0igjpU
         QZJvXd7HIM01YyF+vgVHD6dK7/yo74X4jugq9QDl2BDIQR7yGhwZWX5otK/WzgVCw4oQ
         Ig2eJhkzSuFDEFXaEaX5iU9UQbDc21rXkpG0DSUExFXw5GrPT04domWi7HPuJT1sXqPp
         0NxlX2y4hNccItkE6hvBpa9dmRryvwwzyAMHsSTdz8zyODSn3HwMVJ+6Pr8VoCn/zoD0
         Yil6IVO8e6CQDp+ZcKe/Mi/H7tzznCwUOx0PVfIJOR6RtexKRPV8bwhRG4NY4DXkQZDf
         fQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Rs8ijyDGLRK/rPR78e/3ggRUVyd88+4mbQWpho1TJXM=;
        b=fTP+Br4waE3ciEeLnRvH4ddhaPhxm8eFhTKq8/juAqnl5DHi4GZbQ2nr8Nf3xNTKay
         qfUroHlGLhuzw6fvKztey3qACVSOzKlsgS5FkZ0pqMQ3tTJGsjsXr9Tdo3o133DLiHin
         LRBmB/5Y2f+gAoxEDAbCNA1Bcq8H+xuur+id99sQczeyDcxeEiQoSVriJypANbJT/dy3
         VqKg7Oz8b57ozX71H7uelP0bHni1G3ZCrPzAyI8rseyT8djVv+BYn93B7D6rAkKLl0rg
         yDrzah1IdeV6dNWy3MYOqidgpeIJOP6ooPXkEj30dnYHlYhsBvsE7W7sknG1f81Bm7sG
         2eSg==
X-Gm-Message-State: ACrzQf216QKKqidv8rVk7ZOF/tnSOgC6/PXkrbgmjMYAlQaYIl2fKVHM
        JaB/XYSGn2i0Zfu9gRpyJvxp
X-Google-Smtp-Source: AMsMyM7wddTDkvZCyeHDrOKo+Gh4CwvhVbIJA1u01d3RFK/DKnq8IDVfSltvXMiD1v98J1unFMKeMA==
X-Received: by 2002:a05:6808:2383:b0:350:741f:158f with SMTP id bp3-20020a056808238300b00350741f158fmr9415444oib.44.1664542161896;
        Fri, 30 Sep 2022 05:49:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8c53:a5aa:3322:e297? ([2600:1700:e72:80a0:8c53:a5aa:3322:e297])
        by smtp.gmail.com with ESMTPSA id cp26-20020a056830661a00b006596cafaeabsm569975otb.47.2022.09.30.05.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 05:49:21 -0700 (PDT)
Message-ID: <a91f2868-d65b-3e24-cf18-b483b7807c29@github.com>
Date:   Fri, 30 Sep 2022 08:49:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 9/9] bundle-uri: fetch a list of bundles
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        steadmon@google.com, Glen Choo <chooglen@google.com>,
        Teng Long <dyroneteng@gmail.com>
References: <20220929215808.1438418-1-jonathantanmy@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220929215808.1438418-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/29/2022 5:58 PM, Jonathan Tan wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +static int download_bundle_to_file(struct remote_bundle_info *bundle, void *data)
>> +{
>> +	int res;
>> +	struct bundle_list_context *ctx = data;
>> +
>> +	if (ctx->mode == BUNDLE_MODE_ANY && ctx->count)
>> +		return 0;
>> +
>> +	res = fetch_bundle_uri_internal(ctx->r, bundle, ctx->depth + 1, ctx->list);
>> +
>> +	/*
>> +	 * Only increment count if the download succeeded. If our mode is
>> +	 * BUNDLE_MODE_ANY, then we will want to try other URIs in the
>> +	 * list in case they work instead.
>> +	 */
>> +	if (!res)
>> +		ctx->count++;
>> +	return res;
>> +}
> 
> So this returns nonzero if a download fails...
> 
>> +static int download_bundle_list(struct repository *r,
>> +				struct bundle_list *local_list,
>> +				struct bundle_list *global_list,
>> +				int depth)
>> +{
>> +	struct bundle_list_context ctx = {
>> +		.r = r,
>> +		.list = global_list,
>> +		.depth = depth + 1,
>> +		.mode = local_list->mode,
>> +	};
>> +
>> +	return for_all_bundles_in_list(local_list, download_bundle_to_file, &ctx);
>> +}
> 
> ...and for_all_bundles_in_list does not proceed with the rest of the
> loop if any callback invocation returns nonzero. Don't we need to
> continue retrying the others if the mode is ANY?

You are right! Thanks.
 
>> +static int attempt_unbundle(struct remote_bundle_info *info, void *data)
>> +{
>> +	struct attempt_unbundle_context *ctx = data;
>> +
>> +	if (info->unbundled || !unbundle_from_file(ctx->r, info->file)) {
>> +		ctx->success_count++;
>> +		info->unbundled = 1;
>> +	} else {
>> +		ctx->failure_count++;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Do we need to handle the case in which a file is missing but it's
> expected because the mode is ANY and another file was successfully
> downloaded?

By "file is missing" I think you mean "we never successfully downloaded
that file" and I agree that we should skip those bundles. I'll add more
tests for ANY mode to hopefully catch these issues.

>> +static int unbundle_all_bundles(struct repository *r,
>> +				struct bundle_list *list)
>> +{
>> +	int last_success_count = -1;
>> +	struct attempt_unbundle_context ctx = {
>> +		.r = r,
>> +	};
>> +
>> +	/*
>> +	 * Iterate through all bundles looking for ones that can
>> +	 * successfully unbundle. If any succeed, then perhaps another
>> +	 * will succeed in the next attempt.
>> +	 */
>> +	while (last_success_count < ctx.success_count) {
>> +		last_success_count = ctx.success_count;
>> +
>> +		ctx.success_count = 0;
>> +		ctx.failure_count = 0;
>> +		for_all_bundles_in_list(list, attempt_unbundle, &ctx);
> 
> I think it would have been clearer if the invocation to
> for_all_bundles_in_list were to stop early if a bundle has been
> successfully unbundled, and then you can just run this loop n times,
> instead of needing to reset the success count each time in order to
> check that the latest count is more than the prior one. But this works
> too.

It's a little bit backwards to have the "terminate early with nonzero
value" signal "success", but it would work. With careful commenting, I
think it's doable.

> I see that there are ALL tests, but could we have an ANY test as well?

Yes, excellent point. They are absolutely necessary.

Thanks,
-Stolee
