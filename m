Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F0BC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB4264E26
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhBIN0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhBIN0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 08:26:31 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1021BC061786
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 05:25:51 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b14so4281904qkk.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 05:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dW4l9q1l8LvIU6mJ3GHEjbTnLsqH7QckHcG17rchiXU=;
        b=h/RxvXUWC1mFZukIzYtSuT+SH3Icgww1t6ZR5fLZfV6qhuvgUMxNpxvUhYNF4fOpDF
         oXe2I+AOfBQkpn2RAu321mmCu8lnRxRZD2eQt00QhOQqhfBoSGB8DEt9hUjIVyF+QohK
         5sF++02PwXqEibGbAxMIz1dLdrraLHW2ezKRE9UlP0phoixZSsdROnVVonQC688j/B24
         Jh4rp3BKl+fGN2VYoGqNB3tXLGHQTlqHlldb3KV8b/Ihy6Z1mlgEM3zFh2/cG4TvEv6M
         pihR9i0qdnAEmX6J9Z4Q81G66C/HgtOYmP+m8STD9VUKqmmhqsWjbSyqoTQ+Ln2Z2RRu
         inHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dW4l9q1l8LvIU6mJ3GHEjbTnLsqH7QckHcG17rchiXU=;
        b=pePL9YhVmnwl9ur5OGrEft2g34dzL7vqDHC9xbK+sEH8/PeSKzVLg/hR9VwodG8/kV
         ACot0+BIoWwgMcVWgt59tPlJGGP9+oMlNgNmT8LY3T3GPwm15PmwVEw6Sp9zofffCvmT
         y/V8/N4MX/PG8SBexPbYSVBY3gnUyta17yl+Vztr/E0awc118CknOZxOikOzHKlnh9My
         5YwjEX64nUpUoymqVHrYeCcsid4tZEsAuyEpCzALv82YlFUHv5RCBnmktqy+jzEOKHRH
         91M5eIm4zWJMN8nBLBOrUfT93LC/yltTb7MYepmrLMPHotsXLLUWUN+nNvlOHDLsNDFL
         gnyA==
X-Gm-Message-State: AOAM533sqy7ATm2vIBMmVle7YsY/oZNfj92vPWdGlLg0qPgWjmfUM0NL
        xuFAMv0NHo2MZiAOmOZnM28=
X-Google-Smtp-Source: ABdhPJxg/894nFbTZwhTmhs+l+WKL3jVsr9Zamw9qzc279yoVdCpECBbVdHJBnYTTgGxk9UrWw3BNQ==
X-Received: by 2002:a37:a68a:: with SMTP id p132mr716489qke.26.1612877150191;
        Tue, 09 Feb 2021 05:25:50 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7c18:1f04:a165:5ea0? ([2600:1700:e72:80a0:7c18:1f04:a165:5ea0])
        by smtp.gmail.com with UTF8SMTPSA id d1sm343452qkj.123.2021.02.09.05.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 05:25:49 -0800 (PST)
Message-ID: <b64e30ab-9cb3-ffee-ec5e-1b94529ce636@gmail.com>
Date:   Tue, 9 Feb 2021 08:25:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 2/4] diffcore-rename: complete find_basename_matches()
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <dcd0175229aa6fba576425e78875b95385acb58d.1612870326.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <dcd0175229aa6fba576425e78875b95385acb58d.1612870326.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2021 6:32 AM, Elijah Newren via GitGitGadget wrote:
> +	/*
> +	 * When I checked, over 76% of file renames in linux just moved

Perhaps "In late 2020," instead of "When I checked".

> +	 * files to a different directory but kept the same basename.  gcc
> +	 * did that with over 64% of renames, gecko did it with over 79%,
> +	 * and WebKit did it with over 89%.
> +	 *
> +	 * Therefore we can bypass the normal exhaustive NxM matrix
> +	 * comparison of similarities between all potential rename sources
> +	 * and destinations by instead using file basename as a hint, checking
> +	 * for similarity between files with the same basename, and if we
> +	 * find a pair that are sufficiently similar, record the rename
> +	 * pair and exclude those two from the NxM matrix.
> +	 *
> +	 * This *might* cause us to find a less than optimal pairing (if
> +	 * there is another file that we are even more similar to but has a
> +	 * different basename).  Given the huge performance advantage
> +	 * basename matching provides, and given the frequency with which
> +	 * people use the same basename in real world projects, that's a
> +	 * trade-off we are willing to accept when doing just rename
> +	 * detection.  However, if someone wants copy detection that
> +	 * implies they are willing to spend more cycles to find
> +	 * similarities between files, so it may be less likely that this
> +	 * heuristic is wanted.
> +	 */
> +
> +	int i, renames = 0;
>  	struct strintmap sources;
>  	struct strintmap dests; 

...

> +	 * copy detection.  find_basename_matches() is only used when detecting
> +	 * renames, not when detecting copies, so it'll only be used when a file
> +	 * only existed in the source.  Since we already know that the file

There are two "only"s in this sentence. Just awkward, not wrong.

> +	 * won't be unmodified, there's no point checking for it; that's just a
> +	 * waste of resources.  So set skip_unmodified to 0 so that
> +	 * estimate_similarity() and prefetch() won't waste resources checking
> +	 * for something we already know is false.
> +	 */
> +	int skip_unmodified = 0;
> +



> -	/* TODO: Make use of basenames source and destination basenames */
> +	/* Now look for basename matchups and do similarity estimation */
> +	for (i = 0; i < num_src; ++i) {
> +		char *filename = rename_src[i].p->one->path;
> +		char *base = NULL;
> +		intptr_t src_index;
> +		intptr_t dst_index;
> +
> +		/* Get the basename */
> +		base = strrchr(filename, '/');
> +		base = (base ? base+1 : filename);

Here is the third instance of this in the same function. At minimum we should
extract a helper for you to consume.

> +		/* Find out if this basename is unique among sources */
> +		src_index = strintmap_get(&sources, base);
> +		if (src_index == -1)
> +			continue; /* not a unique basename; skip it */
> +		assert(src_index == i);
> +
> +		if (strintmap_contains(&dests, base)) {
> +			struct diff_filespec *one, *two;
> +			int score;
> +
> +			/* Find out if this basename is unique among dests */
> +			dst_index = strintmap_get(&dests, base);
> +			if (dst_index == -1)
> +				continue; /* not a unique basename; skip it */
> +
> +			/* Ignore this dest if already used in a rename */
> +			if (rename_dst[dst_index].is_rename)
> +				continue; /* already used previously */
> +
> +			/* Estimate the similarity */
> +			one = rename_src[src_index].p->one;
> +			two = rename_dst[dst_index].p->two;
> +			score = estimate_similarity(options->repo, one, two,
> +						    minimum_score, skip_unmodified);
> +
> +			/* If sufficiently similar, record as rename pair */
> +			if (score < minimum_score)
> +				continue;
> +			record_rename_pair(dst_index, src_index, score);
> +			renames++;
> +
> +			/*
> +			 * Found a rename so don't need text anymore; if we
> +			 * didn't find a rename, the filespec_blob would get
> +			 * re-used when doing the matrix of comparisons.
> +			 */
> +			diff_free_filespec_blob(one);
> +			diff_free_filespec_blob(two);
> +		}
> +	}

Makes sense to me.

Thanks,
-Stolee
