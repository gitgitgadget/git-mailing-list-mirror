Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE831F453
	for <e@80x24.org>; Wed, 31 Oct 2018 13:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbeJaWvt (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 18:51:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46182 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbeJaWvt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 18:51:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id c16-v6so17666980qtj.13
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MmCZW2f49ikJFoTNeYTq472W/rUy3PxtEc9cJu0dQ7w=;
        b=EY24MyVPZKaac86MbNh6tZ/rqzALo41Kg8pBU4hZfyWA2GW7MEimuwdnPzklQOQWEz
         ntib7/9YRLG+l2bt5FMcDojKwHBUPZz+KjJRcewsO8yKCXbPktXOfTOFmsU2CLsCAmIv
         1GdR0OQyIZPK2Gm0wqxLgqyu9BDr9HMvzZckHQcK4NXZHZyN8OSJTafLrYxzEvE3RGOo
         ZexNZqChKDV2KZSdfPoHUv+ukzqWzgiP3DUXI8X5yLQ6Obl9UjWicvb9szYyW4kZRHBG
         FrAmyezwMpk2JGOP3nH9UpmrJQYBOymHV/M9yFS8QIjTnKzIKLGFoCj3ZgmwR04LCJa5
         thOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MmCZW2f49ikJFoTNeYTq472W/rUy3PxtEc9cJu0dQ7w=;
        b=bwtWfjw80+eWpLkUl0jJzHKOuwB1cQI6kCYByx+yyf5V+uudo0hlMqrhPv/bo4Xh+c
         cux/XlPKywn8HOi9QaJaodcBUGAC7avvNuZQoN/OAlf5n0D4ha4sGjy2HK+mgph3g5pN
         Dg+zSyyLwM07LMT8BE8QdvbT9wGZW+504CRRZEsB7C10LweSOHsF+dXtUUeTReyXrysO
         VeyAWc2SlzzyNL9+BaSy2PfOGyPuD3B0e65qYZehTB8cXyuyr8vbmo91smcdWyvInIla
         Nhoz4Ev3ujdcOZAI1+pti+IgXfB7KQ6h19IX+6HdIIrK8sWRzQs4qpmmaLhULte26x53
         SDqA==
X-Gm-Message-State: AGRZ1gJ9HwPrAzlTpzS9vIIzxwwSVWr2wo7y4P4weuM+wKC9I1hRGRz/
        Ozm40RCXXTPNxauXlEcnaMg=
X-Google-Smtp-Source: AJdET5fxDfvuxSRiuPVkmDNGbkKCFINof94jABZAb2CuD8AQZvj7TZhUDMQ6O+ZlS0Q9OCGouGNxdg==
X-Received: by 2002:a0c:98a6:: with SMTP id f35mr2644066qvd.224.1540994020586;
        Wed, 31 Oct 2018 06:53:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1547:f48:38e6:a522? ([2001:4898:8010:0:fe7c:f48:38e6:a522])
        by smtp.gmail.com with ESMTPSA id 18-v6sm21413966qtm.13.2018.10.31.06.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:53:40 -0700 (PDT)
Subject: Re: [PATCH v3 4/8] merge-recursive: new function for better colliding
 conflict resolutions
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20181014020537.17991-1-newren@gmail.com>
 <20181019193111.12051-1-newren@gmail.com>
 <20181019193111.12051-5-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0b84c95b-38bc-e39e-a033-81eb3e7b8202@gmail.com>
Date:   Wed, 31 Oct 2018 09:53:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181019193111.12051-5-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/19/2018 3:31 PM, Elijah Newren wrote:
> +#if 0 // #if-0-ing avoids unused function warning; will make live in next commit
> +static int handle_file_collision(struct merge_options *o,
> +				 const char *collide_path,
> +				 const char *prev_path1,
> +				 const char *prev_path2,
> +				 const char *branch1, const char *branch2,
> +				 const struct object_id *a_oid,
> +				 unsigned int a_mode,
> +				 const struct object_id *b_oid,
> +				 unsigned int b_mode)
> +{
> +	struct merge_file_info mfi;
> +	struct diff_filespec null, a, b;
> +	char *alt_path = NULL;
> +	const char *update_path = collide_path;
> +
> +	/*
> +	 * In the recursive case, we just opt to undo renames
> +	 */
> +	if (o->call_depth && (prev_path1 || prev_path2)) {
> +		/* Put first file (a_oid, a_mode) in its original spot */
> +		if (prev_path1) {
> +			if (update_file(o, 1, a_oid, a_mode, prev_path1))
> +				return -1;
> +		} else {
> +			if (update_file(o, 1, a_oid, a_mode, collide_path))

The latest test coverage report [1] shows this if statement is never run, so
it appears that every call to this method in the test suite has either
o->call_depth positive, prev_path1 non-NULL, or both prev_path1 and 
prev_path2
NULL.

Is there a way we can add a test case that calls this method with 
o->call_depth
positive, prev_path1 NULL, and prev_path2 non-NULL?

> +				return -1;
> +		}
> +
> +		/* Put second file (b_oid, b_mode) in its original spot */
> +		if (prev_path2) {
> +			if (update_file(o, 1, b_oid, b_mode, prev_path2))

Since this line is covered, we _do_ call the method with prev_path2 
non-NULL, but
prev_path1 must be non-NULL in all cases.

I may have found a reason why this doesn't happen in one of the callers 
you introduced.
I'm going to comment on PATCH 8/8 to see if that is the case.

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/62f0bcf6-aa73-c192-d804-e6d69cac146f@gmail.com/
