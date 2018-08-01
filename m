Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28B851F597
	for <e@80x24.org>; Wed,  1 Aug 2018 23:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbeHBA4O (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 20:56:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40121 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731634AbeHBA4N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 20:56:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so149024pff.7
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 16:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z6DV6QFWz7bqbEIhk1ixvn9Se0kI62op9uy4diFKUfE=;
        b=HZPGpRZharwmMgch0vnNglmOpdYvLs34VS7l4m/Z1YwAyIrQZKBE0GOkXaUtKfG3w7
         Xn8XjxbL01adBVXIXQgLw09p9kiWX3NXb1ElIi1DPutSb3Jwplyr35uJ9+MgiFrLwPAs
         M+3JJ/DxcHVdmDOzw3GM8uikns5O6AR04RgQi3qDZ8dDVIpe/bVaLUOFkStkOELSL2bV
         PKSPBoXj7X+S9xU0eXc3iG0y3AsoaKTXoIUNruaipRnAWdHgp3dkWWWCpX0NKNS3NaX0
         8Vq9f7Apuh+CxjIMzice7OHALVDgG9TvUqCAWugP9NjIDb+ZqKv3k4QzcugaUWqEePx5
         qLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z6DV6QFWz7bqbEIhk1ixvn9Se0kI62op9uy4diFKUfE=;
        b=WPPC40f9YvDuj/iBZe9oivwJcYAvQN0yQxjKe9RelN/KnA+6uxr+XpUSfa7krZxGnO
         e7q9E9aNC3LW3iyNqeItErRGPPXdGJkEFVB5XrLTRNQDniuv3XSw9m5hqbf2+hDMJTRl
         td3H5PrQAd01fJbGyyhrP3hEaxnEKEfAauqwNWuM1jtm6oniHx6goy9IglmsXWZSsRXX
         fvDUHC0IpxAP9RayREqr04tQ9NunN7k6+zxTfObbi71U+geMEyhMXmMeA4OAn0HUijE8
         sWQJyaZACNsLMeNbUzKmjXjOF5BJlVKKYW4UTkTOY5wu9CADs3+/+9zUU3PtOrwGa+IT
         GBJg==
X-Gm-Message-State: AOUpUlGa6hGMMjaOdEqb+PTqTZjq9CxigIROHR9oIHxR1Yd1X/F980aG
        r3FSxre8eFxFM+C6eyXb3Gw=
X-Google-Smtp-Source: AAOMgpeCn4FVgRh46H+gKLuO4Nx2g07uCR8pjfxJJNSeZlH6KwexocxI6WEUwJsC5ci10L23ZP2GmQ==
X-Received: by 2002:a63:7f16:: with SMTP id a22-v6mr282934pgd.255.1533164884220;
        Wed, 01 Aug 2018 16:08:04 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i20-v6sm202181pfj.82.2018.08.01.16.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 16:08:03 -0700 (PDT)
Date:   Wed, 1 Aug 2018 16:08:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] remote: make refspec follow the same disambiguation
 rule as local refs
Message-ID: <20180801230802.GC189024@aiede.svl.corp.google.com>
References: <xmqq8t5q821c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8t5q821c.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> When matching a non-wildcard LHS of a refspec against a list of
> refs, find_ref_by_name_abbrev() returns the first ref that matches
> using any DWIM rules used by refname_match() in refs.c, even if a
> better match occurs later in the list of refs.

Nicely explained.

[...]
> --- a/refs.c
> +++ b/refs.c
> @@ -487,16 +487,22 @@ static const char *ref_rev_parse_rules[] = {
>  	NULL
>  };
>  
> +/*
> + * Is it possible that the caller meant full_name with abbrev_name?
> + * If so return a non-zero value to signal "yes"; the magnitude of
> + * the returned value gives the precedence used for disambiguation.
> + *
> + * If abbrev_name cannot mean full_name, return 0.
> + */
>  int refname_match(const char *abbrev_name, const char *full_name)
>  {
>  	const char **p;
>  	const int abbrev_name_len = strlen(abbrev_name);
> +	const int num_rules = ARRAY_SIZE(ref_rev_parse_rules) - 1;

This is assuming ref_rev_parse_rules consists exactly of its items
followed by a NULL terminator, which is potentially a bit subtle.  I
wonder if we should put

	static const char *ref_rev_parse_rules[] = {
		"%.*s",
		"refs/%.*s",
		"refs/tags/%.*s",
		"refs/heads/%.*s",
		"refs/remotes/%.*s",
		"refs/remotes/%.*s/HEAD",
		NULL
	};
	#define NUM_REV_PARSE_RULES (ARRAY_SIZE(ref_rev_parse_rules) - 1)

and then use something like

	const int num_rules = NUM_REV_PARSE_RULES;

so that this dependency is more obvious if the ref_rev_parse_rules
convention changes later.

Alternatively, what would you think of using the simpler return
convention

	return p - ref_rev_parse_rules + 1;

?  Or even

	return p - ref_rev_parse_rules;

and -1 for "no match"?

[...]
> --- a/remote.c
> +++ b/remote.c
> @@ -1880,11 +1880,18 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
>  static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const char *name)
>  {
>  	const struct ref *ref;
> +	const struct ref *best_match = NULL;
> +	int best_score = 0;
> +
>  	for (ref = refs; ref; ref = ref->next) {
> -		if (refname_match(name, ref->name))
> -			return ref;
> +		int score = refname_match(name, ref->name);
> +
> +		if (best_score < score) {
> +			best_match = ref;
> +			best_score = score;
> +		}
>  	}
> -	return NULL;
> +	return best_match;

Sensible and simple.  If we wanted to make items earlier in the list
return a lower value from refname_match, then we'd need a !best_score
test here, which might be what motivates that return value convention.

[...]
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -535,6 +535,41 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
>  	)
>  '
>  
> +test_expect_success 'LHS of refspec follows ref disambiguation rules' '

Clearly illustrates the bug this fixes, in a way that makes it obvious
that a user would prefer the new behavior.  Good.

With or without the tweak of introducing NUM_REV_PARSE_RULES mentioned
above,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
