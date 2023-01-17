Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CD6C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 20:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjAQUYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 15:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjAQUV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 15:21:27 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506B37C85F
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:13:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g23so18943872plq.12
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HVH+rR3GrN13blIPJexQIZZh8oWCXFMbBJJhK+janc4=;
        b=CagrBW4+l5aMqC4v3NQ4U9cN8iARvs25cssFfwHE04acVeXpOMk6z3WUwEMS6LmGRo
         cTLni5Osdxx6xr9QbclIrrTTtaDJDNUcVyKllwhVM6fETKmTnFiBGvhUdxpU04y54ePm
         bEYgfWp00CorcjCPZ5AFK5KuOMeoG2sQZIaItRJSXRD/iGS2kQcYaOWCaHbBrurDmSHW
         clMGdqOa1xlWLGBzB+RTH85AeotS5i8ACdkek0NDQ3TFtH+WIGpfb1/23wABGYJehsrd
         dh9SNTSY9GZdy/LcVih49T3nLN1Sdsg7mG5XrUUg7mXEmvDg07h14zvtWoAKqTniR66D
         y2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVH+rR3GrN13blIPJexQIZZh8oWCXFMbBJJhK+janc4=;
        b=dYl8oh47lP3FWknaHHszIGsCRrf06zkZQeQzMiJWNQEblgmmijEGdN7g5JuBldKZAJ
         hKgt5DV3eFa5nMDLwz6dZ4NTpFkLslZdvqgXzzNAQxV1PehNQUCMCObejB9CyuPeoSyo
         zQtX4LCLm7eUWaFl49l4NRqyyN7o0jXCKLxsG8Y5clB7WSw9etZLw9goEtOcANnvKDac
         lqcXE5LK4qVUOHaAU+SHwjZQPXG5ncMLrFdq9nMxk7JOpzIg8vVamC5cG5hF7ppNGIit
         Z89eKldnEZuZe2krhUpbXfTHFj+JSsU8Bx7YCK3NwvUrnMKLRJZyKNKOiVReWryPSR9i
         FLTA==
X-Gm-Message-State: AFqh2krVa60IA2VFLaFTJC1FiWGb2td8qV5MmuMU38QHLym4Yl0bygSY
        XF+wDqBx2kVsysZu1m8OL4Ws
X-Google-Smtp-Source: AMrXdXuS7AKXxdjNuSDwdhlAjh7/w9NOQM4k+yYj8pUFCOEMdziDlQxuvjmtODvIr9qnBGWmuwCkLQ==
X-Received: by 2002:a05:6a20:6d22:b0:b6:8476:ef72 with SMTP id fv34-20020a056a206d2200b000b68476ef72mr3702974pzb.36.1673982803712;
        Tue, 17 Jan 2023 11:13:23 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id n68-20020a622747000000b00588e0d5124asm6287981pfn.160.2023.01.17.11.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 11:13:23 -0800 (PST)
Message-ID: <5fb1385a-3821-8e1f-b31c-2c38f87dc965@github.com>
Date:   Tue, 17 Jan 2023 11:13:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
From:   Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/8] bundle-uri: parse bundle.heuristic=creationToken
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <9007249b9488c23f00c2d498ffd520e4af8b37a4.1673037405.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <9007249b9488c23f00c2d498ffd520e4af8b37a4.1673037405.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The bundle.heuristic value communicates that the bundle list is
> organized to make use of the bundle.<id>.creationToken values that may
> be provided in the bundle list. Those values will create a total order
> on the bundles, allowing the Git client to download them in a specific
> order and even remember previously-downloaded bundles by storing the
> maximum creation token value.
> 
> Before implementing any logic that parses or uses the
> bundle.<id>.creationToken values, teach Git to parse the
> bundle.heuristic value from a bundle list. We can use 'test-tool
> bundle-uri' to print the heuristic value and verify that the parsing
> works correctly.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/config/bundle.txt |  7 +++++++
>  bundle-uri.c                    | 21 +++++++++++++++++++++
>  bundle-uri.h                    | 14 ++++++++++++++
>  t/t5750-bundle-uri-parse.sh     | 19 +++++++++++++++++++
>  4 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/config/bundle.txt b/Documentation/config/bundle.txt
> index daa21eb674a..3faae386853 100644
> --- a/Documentation/config/bundle.txt
> +++ b/Documentation/config/bundle.txt
> @@ -15,6 +15,13 @@ bundle.mode::
>  	complete understanding of the bundled information (`all`) or if any one
>  	of the listed bundle URIs is sufficient (`any`).
>  
> +bundle.heuristic::
> +	If this string-valued key exists, then the bundle list is designed to
> +	work well with incremental `git fetch` commands. The heuristic signals
> +	that there are additional keys available for each bundle that help
> +	determine which subset of bundles the client should download. The
> +	only value currently understood is `creationToken`.

This description clearly describes the 'heuristic' key and what it does.

> +
>  bundle.<id>.*::
>  	The `bundle.<id>.*` keys are used to describe a single item in the
>  	bundle list, grouped under `<id>` for identification purposes.
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 36268dda172..56c94595c2a 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -9,6 +9,11 @@
>  #include "config.h"
>  #include "remote.h"
>  
> +static const char *heuristics[] = {
> +	[BUNDLE_HEURISTIC_NONE] = "",
> +	[BUNDLE_HEURISTIC_CREATIONTOKEN] = "creationToken",
> +};
> +
>  static int compare_bundles(const void *hashmap_cmp_fn_data,
>  			   const struct hashmap_entry *he1,
>  			   const struct hashmap_entry *he2,
> @@ -100,6 +105,9 @@ void print_bundle_list(FILE *fp, struct bundle_list *list)
>  	fprintf(fp, "\tversion = %d\n", list->version);
>  	fprintf(fp, "\tmode = %s\n", mode);
>  
> +	if (list->heuristic)
> +		printf("\theuristic = %s\n", heuristics[list->heuristic]);

Given this condition, the 'heuristic' key should not be sent if it's
'BUNDLE_HEURISTIC_NONE'. But, as a fallback...

> +
>  	for_all_bundles_in_list(list, summarize_bundle, fp);
>  }
>  
> @@ -142,6 +150,19 @@ static int bundle_list_update(const char *key, const char *value,
>  			return 0;
>  		}
>  
> +		if (!strcmp(subkey, "heuristic")) {
> +			int i;
> +			for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
> +				if (!strcmp(value, heuristics[i])) {
> +					list->heuristic = i;
> +					return 0;
> +				}
> +			}

...this condition seems to handle 'BUNDLE_HEURISTIC_NONE' anyway. There's no
harm in this, since 'BUNDLE_HEURISTIC_NONE' is the default value of
'list->heuristic' anyway.

>  void init_bundle_list(struct bundle_list *list);
> diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
> index 7b4f930e532..6fc92a9c0d4 100755
> --- a/t/t5750-bundle-uri-parse.sh
> +++ b/t/t5750-bundle-uri-parse.sh
> @@ -250,4 +250,23 @@ test_expect_success 'parse config format edge cases: empty key or value' '
>  	test_cmp_config_output expect actual
>  '
>  
> +test_expect_success 'parse config format: creationToken heuristic' '
> +	cat >expect <<-\EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +	[bundle "one"]
> +		uri = http://example.com/bundle.bdl
> +	[bundle "two"]
> +		uri = https://example.com/bundle.bdl
> +	[bundle "three"]
> +		uri = file:///usr/share/git/bundle.bdl
> +	EOF
> +
> +	test-tool bundle-uri parse-config expect >actual 2>err &&
> +	test_must_be_empty err &&
> +	test_cmp_config_output expect actual
> +'

And this test verifies that 'heuristic' is no longer being ignored. Looks
good!

> +
>  test_done

