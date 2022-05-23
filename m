Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F68C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiEWUpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiEWUpB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:45:01 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF881D9EAD
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:44:58 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a10so16507816ioe.9
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lPmIRBonMWA3XS0KhPkmzoTLfTPx3+4taPU/C8Yrrhw=;
        b=MDZF3Nc/OSILto9hzRuSEaEtwzDGyn3o+H9DW98/ybxXQ9384qxySyBaD5rinbVREl
         YQLuNQTLj2R5Tu+HmXb4JLP3KrX4QIcTLw/lFW5hn3MOP6axfbsiLkqzRwNmyY1C5/Si
         1M+oO+IuSNMfqBD9AEhqX1AADIZrKfqATaEjR0FEOIgHw9G4z7QAkD3+yNLIiUd0XtLK
         YxP0SWBd6YPexP1RMrY17CTm/qENYGy+5i/q852CX7CIu98EvpI8Cc29M30Alaa0R0OR
         6uKRG3xALjP9Kd6obayBpF0QSLSDbSVXZpvFc1fJN+KsoN8q/+4sTiPKZCwngvGZXnAz
         EXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lPmIRBonMWA3XS0KhPkmzoTLfTPx3+4taPU/C8Yrrhw=;
        b=XvN0W8dGg2VyTawmXhHf2s8bbe8X12ww9LZ/DFf6tz63GQuIDm1rkuSMM6t+sQAMcv
         QzPqQb3eQgJtj8LL0aY6KUddlStmQa11JwpVGbMc85vHpgCWTnbeVnfBbO0vBLaIWsmd
         uvhm5v3xVM2ZMWMFgcLMei+kpUYKVG57Dd9kHX9pMKMNZttE3xdtOzGTSU1Ux9FI2mI1
         dwlY9P3Kw+ZmGveaSY4ntXM4kU1+dj2gCxTRQSDKacwaiNbnDdtSXx0pqH6bHiEdydnt
         jfPzlvmTSEVCarBntNoG8ZHaaN14ku2HxPKDaSbZoaiJUe5pcj7jj6p549MWEuAkuetK
         R5Pw==
X-Gm-Message-State: AOAM530sSziOxXrgCPL4jZ0XckUDLo9HExYFstSzM/yZRjOppRuNptLd
        fYHDainBpes0EiWqzaD3HJ4+5qG8toiy
X-Google-Smtp-Source: ABdhPJxKTk0Y2nJDiN8QfTDpaFKFzmM6T265+7BbXctOiq5gBXPBHPzNdRYB0ET1PgN26GkJec4uKw==
X-Received: by 2002:a05:6638:d94:b0:32e:c8c8:2747 with SMTP id l20-20020a0566380d9400b0032ec8c82747mr3630611jaj.32.1653338698204;
        Mon, 23 May 2022 13:44:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d5d2:1564:989:490a? ([2600:1700:e72:80a0:d5d2:1564:989:490a])
        by smtp.gmail.com with ESMTPSA id k28-20020a02ccdc000000b0032e2ff3ab34sm2979720jaq.7.2022.05.23.13.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 13:44:57 -0700 (PDT)
Message-ID: <362128ff-690d-8dc1-88fd-620f52b14d54@github.com>
Date:   Mon, 23 May 2022 16:44:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] check-ignore: --non-matching without --verbose
Content-Language: en-US
To:     Carl Smedstad via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Carl Smedstad <carl.smedstad@protonmail.com>
References: <pull.1236.git.1653310466062.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1236.git.1653310466062.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/23/2022 8:54 AM, Carl Smedstad via GitGitGadget wrote:
> From: Carl Smedstad <carl.smedstad@protonmail.com>

>  -n, --non-matching::
> -	Show given paths which don't match any pattern.	 This only
> -	makes sense when `--verbose` is enabled, otherwise it would
> -	not be possible to distinguish between paths which match a
> -	pattern and those which don't.
> +	Only show given paths which don't match any pattern. If `--verbose` is
> +	enabled, show both paths that match a pattern and those which don't.

This may be better to indicate the behavior as predicated on the
existence of --verbose:

	If `--verbose` is enabled, then all paths are listed along
	with an indicator (`::`) that no matching pattern was found.
	Without `--verbose`, list only the paths that do not match
	any pattern.

> -		if (!quiet && (pattern || show_non_matching))
> -			output_pattern(pathspec.items[i].original, pattern);
> +		if (!quiet) {
> +			if (verbose) {
> +				if (show_non_matching || pattern)
> +					output_pattern(pathspec.items[i].original, pattern);
> +			} else {
> +				if (show_non_matching && !pattern)
> +					output_pattern(pathspec.items[i].original, pattern);
> +				if (!show_non_matching && pattern)
> +					output_pattern(pathspec.items[i].original, pattern);

These three blocks all call the same code line. So really you want
to avoid a single case:

	if (!quiet &&
	    ((verbose && (show_non_matching || pattern)) ||
	     (!verbose && !!show_non_matching != !!pattern)))

This is the most direct way to write what you had above. However,
we could do this more simply:

	/* If --non-matching, then show if verbose or the pattern is missing. */
	if (!quiet && show_non_matching && (verbose || !pattern))
		output_pattern(...);

	/* If not --non-matching, then show if the pattern exists. */
	if (!quiet && !show_non_matching && pattern)
		output_pattern(...);

Hopefully that's a bit easier to parse. I believe it is
equivalent.

Thanks,
-Stolee
