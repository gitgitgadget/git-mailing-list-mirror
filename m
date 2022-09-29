Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB4DC433F5
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 21:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiI2V6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiI2V6M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 17:58:12 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1C414F811
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 14:58:11 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n1-20020a170902f60100b00179c0a5c51fso1820676plg.7
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bNJVmGuycnpUTrbk2mZ7qWFTvJYs0/4vpATsaQymfNw=;
        b=L3YXCzmsUJ8KXkqJ/3Jl6vnyJlhWpcKee+2tcjjiMSxa3Peotsq0kUKxvTjekYr4lN
         02hSZ/KCIMLJnmGBM+a3Yd9yI5sJxj/TAVRncnQV65fQ7xaAe0Asfs6Hr8sr8N+DT10C
         qBfCUhFaeXlB9p3Drgbony9iNUBqCjwXM1gMnv0mAA3mydHLZURg2KxRBt26E+yCcbpu
         OloHQUkeQL/phf4266y1UAJPANYoRNH0JLlwhd2idcx44f2WQDueMzQRRTzpBRZVT2bT
         i4eNsc/ZiVnBQ229wK/udQkHVgmmdrlyB/cTlZCOPpvPiwrseSuzq62SJjwOkFFbb3WG
         6dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNJVmGuycnpUTrbk2mZ7qWFTvJYs0/4vpATsaQymfNw=;
        b=lSy1OX3MRURYMo9wEXgIxr3KPKG8TJ8UcW8fntZKK0iDajm48PCD4On0Uhz9BAbKIb
         GDptCdEXyPgEIcrb3wIR/SPlPS4J3kQx+0GsX2ibhQzJ9T/URwg+d9AiKPWIcmpY9jUF
         lqNbvnLoakZ7EUlXiVuyeAG5Ri0kW6m4Cb4JEp8jwaCi0TZOJHLo1ms7biCSq74gYCV5
         SlVBpd3wYocXPErx97OlYcsYPgPidz6hchCeFrTO551B9WpQFdExJzFPBAb6H/0p4es1
         icPQ2QJO+cMraIWnHd7zM8tL+VGubxb+q5gb332cZU/+2Jo6CnUNNUzMxNZ/TronrI5E
         fXFA==
X-Gm-Message-State: ACrzQf12nCvgW2owuWZ29Xv9dSuVKtwYwWtAOip80tVYNzlFYkmyGVQb
        gdMqQHlKpXZvkWlzkdqMXpaVIIGps9UkMzY8dJDg
X-Google-Smtp-Source: AMsMyM7Cggr5Q1MlYFTk4HXddKAQg8uKLbEOscrFMeuRLuuDejsD2+5+B9GERXTWwB8cd20XaQs/MsWJ367CY0YjItU9
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with
 SMTP id w6-20020a17090ac98600b00205f08ca82bmr51056pjt.1.1664488691142; Thu,
 29 Sep 2022 14:58:11 -0700 (PDT)
Date:   Thu, 29 Sep 2022 14:58:08 -0700
In-Reply-To: <a6ab8f7c69925b5dfd95f3e4c83c6ccd4d2dfee3.1662734015.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220929215808.1438418-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 9/9] bundle-uri: fetch a list of bundles
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> +static int download_bundle_to_file(struct remote_bundle_info *bundle, void *data)
> +{
> +	int res;
> +	struct bundle_list_context *ctx = data;
> +
> +	if (ctx->mode == BUNDLE_MODE_ANY && ctx->count)
> +		return 0;
> +
> +	res = fetch_bundle_uri_internal(ctx->r, bundle, ctx->depth + 1, ctx->list);
> +
> +	/*
> +	 * Only increment count if the download succeeded. If our mode is
> +	 * BUNDLE_MODE_ANY, then we will want to try other URIs in the
> +	 * list in case they work instead.
> +	 */
> +	if (!res)
> +		ctx->count++;
> +	return res;
> +}

So this returns nonzero if a download fails...

> +static int download_bundle_list(struct repository *r,
> +				struct bundle_list *local_list,
> +				struct bundle_list *global_list,
> +				int depth)
> +{
> +	struct bundle_list_context ctx = {
> +		.r = r,
> +		.list = global_list,
> +		.depth = depth + 1,
> +		.mode = local_list->mode,
> +	};
> +
> +	return for_all_bundles_in_list(local_list, download_bundle_to_file, &ctx);
> +}

...and for_all_bundles_in_list does not proceed with the rest of the
loop if any callback invocation returns nonzero. Don't we need to
continue retrying the others if the mode is ANY?

> +static int attempt_unbundle(struct remote_bundle_info *info, void *data)
> +{
> +	struct attempt_unbundle_context *ctx = data;
> +
> +	if (info->unbundled || !unbundle_from_file(ctx->r, info->file)) {
> +		ctx->success_count++;
> +		info->unbundled = 1;
> +	} else {
> +		ctx->failure_count++;
> +	}
> +
> +	return 0;
> +}

Do we need to handle the case in which a file is missing but it's
expected because the mode is ANY and another file was successfully
downloaded?

> +static int unbundle_all_bundles(struct repository *r,
> +				struct bundle_list *list)
> +{
> +	int last_success_count = -1;
> +	struct attempt_unbundle_context ctx = {
> +		.r = r,
> +	};
> +
> +	/*
> +	 * Iterate through all bundles looking for ones that can
> +	 * successfully unbundle. If any succeed, then perhaps another
> +	 * will succeed in the next attempt.
> +	 */
> +	while (last_success_count < ctx.success_count) {
> +		last_success_count = ctx.success_count;
> +
> +		ctx.success_count = 0;
> +		ctx.failure_count = 0;
> +		for_all_bundles_in_list(list, attempt_unbundle, &ctx);

I think it would have been clearer if the invocation to
for_all_bundles_in_list were to stop early if a bundle has been
successfully unbundled, and then you can just run this loop n times,
instead of needing to reset the success count each time in order to
check that the latest count is more than the prior one. But this works
too.

[snip tests]

I see that there are ALL tests, but could we have an ANY test as well?
