Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C0AC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F4364ED7
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhBINez (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhBINe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 08:34:29 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBACC061786
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 05:33:49 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 63so17495257oty.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 05:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4aq+n5W+HF9R3oUhAkzrFzwkiyLuqunJzLVxfeGXK8c=;
        b=FJZGwT/q0eyHCIYw5CQpfRuJDunzmHphs6bsOwh2kmZn2wMd+2rO3sD4bLOsYmwo8x
         xf9pRH5+ISU13s9RBgtIHGqlv9vtxB+7kpIbsvNEvn8rkB7jQh8BHzc9qIxURamNFGZc
         wOjUZ4CpkW1myttaM8v4VxRyODyoRVUW6xryZIWVUYP0cZ3UwWzMO1vVCFrCUxfrc8oh
         w/oLo0UCzWIqXI7RFfS6Vj+IXfxYwARCGvtBCbxJCnckGelFCx9P8E+5VogmFjCS+se1
         dvZXj7BKvu64oeemUlj2WIpDu6kZkDxk34QeFw3EKGwj5EKdMnH1AyiuAz0bNQZPWmBd
         YWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4aq+n5W+HF9R3oUhAkzrFzwkiyLuqunJzLVxfeGXK8c=;
        b=K2dxKnh0oYA79/uC5stc9EQirxyIAwGHMsBV/vHO30qciYcie+pQR4ZZtQhUYAKQCH
         OEukB6VVn9FX57UoivvB65LPd0mjD4qZA4Iq7wUPUP21SntpeFkzNT7W9MD7Lmn7ivys
         cAltuK3gP2FE88kR/TiNoVlu5r8uWmaiNBxc7PdKjmpCh/dwTboDIr3wCrVSE3R62QDO
         PwAZELMnlHViEyvZtkn+H61r8hkF/dkUk5btd/hFqUTsUhDSn9BvaU6+5nefIMnNzEqn
         S4VjxIG8epJgsC/YNZKLP/YbjWSHR7s8KrhCjyE2As+5J1IFN60kcWmlderz8bSmIJqT
         A6Ng==
X-Gm-Message-State: AOAM533+wG3eKZNtfvOlIdX8uwh8dtvxZkRXEU8dl4YyORMXVXzn9zYw
        iblvNfQvj3MMHadDDSBSTcM=
X-Google-Smtp-Source: ABdhPJy0DmsgY1Exi+K8UN3JxsODBGL0+U+UE1YKAWdOeEEgv7/m0vW2oZsiUKzfAQ0LscAh3Z2qKg==
X-Received: by 2002:a9d:6290:: with SMTP id x16mr16289291otk.109.1612877628477;
        Tue, 09 Feb 2021 05:33:48 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7c18:1f04:a165:5ea0? ([2600:1700:e72:80a0:7c18:1f04:a165:5ea0])
        by smtp.gmail.com with UTF8SMTPSA id b25sm1331686otf.16.2021.02.09.05.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 05:33:48 -0800 (PST)
Message-ID: <48a208c2-75fe-773e-aa2a-12a90dd06ddd@gmail.com>
Date:   Tue, 9 Feb 2021 08:33:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 3/4] diffcore-rename: guide inexact rename detection
 based on basenames
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
 <ce2173aa1fb7ac3830bf8856a14558446e16a3dd.1612870326.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ce2173aa1fb7ac3830bf8856a14558446e16a3dd.1612870326.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2021 6:32 AM, Elijah Newren via GitGitGadget wrote:
> +	num_sources = rename_src_nr;
> +
> +	if (want_copies || break_idx) {
> +		/*
> +		 * Cull sources:
> +		 *   - remove ones corresponding to exact renames
> +		 */
> +		trace2_region_enter("diff", "cull after exact", options->repo);
> +		remove_unneeded_paths_from_src(want_copies);
> +		trace2_region_leave("diff", "cull after exact", options->repo);

Isn't this the same as

> +	} else {
> +		/* Determine minimum score to match basenames */
> +		int min_basename_score = (int)(5*minimum_score + 0*MAX_SCORE)/5;
> +
> +		/*
> +		 * Cull sources:
> +		 *   - remove ones involved in renames (found via exact match)
> +		 */
> +		trace2_region_enter("diff", "cull exact", options->repo);
> +		remove_unneeded_paths_from_src(want_copies);
> +		trace2_region_leave("diff", "cull exact", options->repo);

...this? (except the regions are renamed)

Could this be simplified as:

+	num_sources = rename_src_nr;
+
+	trace2_region_enter("diff", "cull after exact", options->repo);
+	remove_unneeded_paths_from_src(want_copies);
+	trace2_region_leave("diff", "cull after exact", options->repo);
+
+	if (!want_copies && !break_idx) {
+		/* Determine minimum score to match basenames */

I realize you probably changed the region names on purpose to distinguish
that there are two "cull" regions in the case of no copies, but I think
that isn't really worth different names. Better to have a consistent region
name around the same activity in both cases.

> +		int min_basename_score = (int)(5*minimum_score + 0*MAX_SCORE)/5;

Did you intend for this to be 5*min + 0*MAX? This seems wrong if you want
this value to be different from minimum_score.

> +
> +		/* Utilize file basenames to quickly find renames. */
> +		trace2_region_enter("diff", "basename matches", options->repo);
> +		rename_count += find_basename_matches(options,
> +						      min_basename_score,
> +						      rename_src_nr);
> +		trace2_region_leave("diff", "basename matches", options->repo);
> +
> +		/*
> +		 * Cull sources, again:
> +		 *   - remove ones involved in renames (found via basenames)
> +		 */
> +		trace2_region_enter("diff", "cull basename", options->repo);
> +		remove_unneeded_paths_from_src(want_copies);
> +		trace2_region_leave("diff", "cull basename", options->repo);
> +	}
> +

Thanks,
-Stolee
