Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600D2C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbiK2BvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiK2BvI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:51:08 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1929E1DA
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:51:07 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x66so12292903pfx.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9SbSF9XBT8UXERBXjRmuxGdPdPrcbYdwF0a1xkCsEw=;
        b=W7CE8py/jnF2jjt726uQNIVtBip3BkpwFAi3PpQeYfsXPGGVl6Vr5Fn7gdKq/+eCDH
         8gyEulbWtXJMSEtN5Wq66o5zAnc2OmZvidoHCPi+FxZZVHBxB4HJhJ/CZVL5FvT1uJLF
         buykXE7vxrO6RaswiOZ/KUkNtagc4tBV2j9S+s2U2eYogEtO6q89jIWjIi2AQ0TY0ziU
         pujst+llV7VFJEFGYj+OTn2szLhmztny0O16mI7GVSNwO9Ko+bNuYYmoWS3U5m7yd2ny
         7wM6qK5yspjlLpSvdAokSdRK5aNTD+tNaxHodTWzKxv5jVv1nzPFTU9JTiOk1xY/+HyQ
         DkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9SbSF9XBT8UXERBXjRmuxGdPdPrcbYdwF0a1xkCsEw=;
        b=LffuMuWtarRIU7jM7n4bBsS6jWUnOE6XJOKsCWMV/j/2MKeVDfCJfDyLPMkaa0NnG1
         FPZoHWCfD++mFPIkcQ/HSZTbpfRF6Oj4AP9eawebIylXivEVvY0yIe7Iuo4Ukj7VSfeH
         cWpQCzCtFnZM0BDHglSkv9743x10OuPp/OhLieLny7Er+dVkMnYuPrtTvtZfUy5nUlc7
         XOr22VrSnFkHlB+Sh4OtE8m/54e0TX6SUI98REbUNe0sV2zWC3BHBOsLUir1ZxpyBDOV
         gkMR+D0gYKviAnWTpXAQZe8Ep/s00FZ1NncLRQBfcESHUGcS5XZClFvEqcKm6jPMkxBo
         6sZg==
X-Gm-Message-State: ANoB5pmtISpUy9KjJwnVCuqUbZdQpennAH0UvcSm7qQKDIkBuJhGvtev
        v0pREdS/3/6zYUVuj3xxUwWhGiX6Zgsn
X-Google-Smtp-Source: AA0mqf4DK5tfbFPwlpEanCqPWr/EJkG1TT7HUPi6D5B0b31nrigbiRueyCtz8izSl6rTtzga5fKAtQ==
X-Received: by 2002:a62:5281:0:b0:561:efcf:1d21 with SMTP id g123-20020a625281000000b00561efcf1d21mr35002780pfb.68.1669686666609;
        Mon, 28 Nov 2022 17:51:06 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b00186e34524e3sm9490085plg.136.2022.11.28.17.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 17:51:06 -0800 (PST)
Message-ID: <c916a819-565e-e58e-3565-dbe2bc1cd9a5@github.com>
Date:   Mon, 28 Nov 2022 17:51:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 8/9] bundle-uri: download bundles from an advertised
 list
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <f254da46a2c2afa74c6fdfd8cc1e2110c70455a5.1668628303.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <f254da46a2c2afa74c6fdfd8cc1e2110c70455a5.1668628303.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The logic in fetch_bundle_uri() is useful for the --bundle-uri option of
> 'git clone', but is not helpful when the clone operation discovers a
> list of URIs from the bundle-uri protocol v2 command. To actually
> download and unbundle the advertised bundles, we need a different
> mechanism.
> 
> Create the new fetch_bundle_list() method which is very similar to
> fetch_bundle_uri() except that it relies on download_bundle_list()
> instead of fetch_bundle_uri_internal(). The download_bundle_list()
> method will recursively call fetch_bundle_uri_internal() if any of the
> advertised URIs serve a bundle list instead of a bundle. This will also
> follow the bundle.list.mode setting from the input list: "any" will
> download only one such URI while "all" will download data from all of
> the URIs.
> 
> In an identical way to fetch_bundle_uri(), the bundles are unbundled
> after all of the bundle lists have been expanded and all necessary URIs.

This explanation is clear and matches the implementation below. I'll admit
it's a bit difficult to wrap my head around what's going on but, from what I
understand, it does what it needs to do to set up for the next patch.

There's no way to test this change in this patch (since
'fetch_bundle_list()' isn't called anywhere yet), but I think that's fine;
making it testable would probably make the patch too long/complicated to
follow.

> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle-uri.c | 21 +++++++++++++++++++++
>  bundle-uri.h | 11 +++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/bundle-uri.c b/bundle-uri.c
> index ab91bb32e9b..5914d220c43 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -577,6 +577,27 @@ cleanup:
>  	return result;
>  }
>  
> +int fetch_bundle_list(struct repository *r, const char *uri, struct bundle_list *list)
> +{
> +	int result;
> +	struct bundle_list global_list;
> +
> +	init_bundle_list(&global_list);
> +
> +	/* If a bundle is added to this global list, then it is required. */
> +	global_list.mode = BUNDLE_MODE_ALL;
> +
> +	if ((result = download_bundle_list(r, list, &global_list, 0)))
> +		goto cleanup;
> +
> +	result = unbundle_all_bundles(r, &global_list);
> +
> +cleanup:
> +	for_all_bundles_in_list(&global_list, unlink_bundle, NULL);
> +	clear_bundle_list(&global_list);
> +	return result;
> +}
> +
>  /**
>   * API for serve.c.
>   */
> diff --git a/bundle-uri.h b/bundle-uri.h
> index 7905e56732c..a75b68d2f5a 100644
> --- a/bundle-uri.h
> +++ b/bundle-uri.h
> @@ -102,6 +102,17 @@ int bundle_uri_parse_config_format(const char *uri,
>   */
>  int fetch_bundle_uri(struct repository *r, const char *uri);
>  
> +/**
> + * Given a bundle list that was already advertised (likely by the
> + * bundle-uri protocol v2 verb) at the given uri, fetch and unbundle the
> + * bundles according to the bundle strategy of that list.
> + *
> + * Returns non-zero if no bundle information is found at the given 'uri'.
> + */
> +int fetch_bundle_list(struct repository *r,
> +		      const char *uri,
> +		      struct bundle_list *list);
> +
>  /**
>   * API for serve.c.
>   */

