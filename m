Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1251F597
	for <e@80x24.org>; Tue, 31 Jul 2018 21:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbeGaXOC (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 19:14:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41048 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeGaXOC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 19:14:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so9699681pgu.8
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gmhywn1jennHXuFOuPaOUte9SqGFsEin4afAM7lZK8g=;
        b=KzSPealMRRaS0xe6RqPd4JI00kcV1qqX6lp7yC+dxrhrys+NcydEvjMFwAuodDyR+I
         OlMCOr4OVF/g5v4C55Q8LlxlW3qyf21Xqn+iw5nNYDCF1OLxdYr10Am4+iwfFHUcqlb4
         j09j0OCNkQ6YdIwbk2UoOUIKAbhuljfthdgX4lPY0hapHEY+ZNmFNU1fEiTYsK3UNI5p
         9ji0KkWcIghac+pxx209zq+PYp1tp4DYtE3EPLHte4SuUjZ+Q0o0nNlwfReCe7nl7YhZ
         wJSrgzOyfo4/7IBS7Vl8WMpl24+H2ZnACX5dayqjaQMTE/U4CcfOHG/Yotw3ZLsF0ZQr
         JPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gmhywn1jennHXuFOuPaOUte9SqGFsEin4afAM7lZK8g=;
        b=Wm5Cz2gtMtqf0Ucwq8aoYRGNFohoyMcQjq54BG5qbOO7mBXnIxT7bEmKga3E7QLoMO
         hvHHBMa+awg2gKll1kO3M0aJmbrntHxvCEIgZ2mckjD2fwFDIwuYcA84BQexcYKQmfEm
         j3UU6fhVh1ACPMwF6YhRj7xx4mSARqMkcmYziBKIkd0SRUPMjKX2a3CBm8Lf2LTihNV2
         qUqdMezOIGQ7TrwNnz5PrdlrSvQYBGID/39fd38VkVGSt8daQdiINHSsu5RBhxpI8Ppm
         KsFDd89/Z8ReSvMB8eUzQE2iHrGQrm34XQlQI+KHfjlt2Wj43flmyJeQolKOysYlVXs7
         0JDw==
X-Gm-Message-State: AOUpUlGyAmPJH9Cd4rLf8Y9sDZSUHf4vi/7nwhLiVqi5g6y3jXpDXt9L
        QzvxvxD0d1DhN1rYLYQK5qt0/L8d
X-Google-Smtp-Source: AAOMgpcPXg82+RhuxISfVwxnlXIGnyFYMzmdzMH3CFD9rKHeIAgJ68vlJ6q+oVxODkAvBFx/acnZIQ==
X-Received: by 2002:a62:234d:: with SMTP id j74-v6mr81146pfj.106.1533072703622;
        Tue, 31 Jul 2018 14:31:43 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r71-v6sm25823517pfg.43.2018.07.31.14.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 14:31:42 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:31:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Dana Dahlstrom <dahlstrom@google.com>
Subject: Re: [PATCH] remote: prefer exact matches when using refspecs
Message-ID: <20180731213120.GA113554@aiede.svl.corp.google.com>
References: <20180731211832.142014-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731211832.142014-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> When matching a non-wildcard LHS of a refspec against a list of refs,
> find_ref_by_name_abbrev() returns the first ref that matches using the
> DWIM rules used by refname_match() in refs.c, even if an exact match
> occurs later in the list of refs.
>
> This causes unexpected behavior when (for example) fetching using the
> refspec "refs/heads/s:<something>" from a remote with both
> "refs/heads/refs/heads/s" and "refs/heads/s". (Even if the former was
> inadvertently created, one would still expect the latter to be fetched.)
>
> This problem has only been observed when the desired ref comes after the
> undesired ref in alphabetical order. However, for completeness, the test
> in this patch also checks what happens when the desired ref comes first
> alphabetically.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  remote.c         |  7 +++++--
>  t/t5510-fetch.sh | 28 ++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 2 deletions(-)

Very clear analysis --- thank you.

> --- a/remote.c
> +++ b/remote.c
> @@ -1687,12 +1687,15 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
>  
>  static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const char *name)
>  {
> +	const struct ref *best_match = NULL;
>  	const struct ref *ref;
>  	for (ref = refs; ref; ref = ref->next) {
> -		if (refname_match(name, ref->name))
> +		if (!strcmp(name, ref->name))
>  			return ref;
> +		if (refname_match(name, ref->name))

Should this check be

		if (!best_match && refname_match(name, ref->name))

?  Otherwise, this would make us prefer the last ref instead of the
first (which probably doesn't matter but would be an unintended
behavior change).

> +			best_match = ref;
>  	}
> -	return NULL;
> +	return best_match;
>  }
>  
>  struct ref *get_remote_ref(const struct ref *remote_refs, const char *name)
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index e402aee6a..da88f35f0 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -535,6 +535,34 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
>  	)
>  '
>  
> +test_expect_success 'LHS of refspec prefers exact matches' '

Nice.

With or without the suggested tweak,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for a pleasant read.

> +	mkdir lhs-exact &&
> +	(
> +		cd lhs-exact &&
> +		git init server &&
> +		test_commit -C server unwanted &&
> +		test_commit -C server wanted &&
> +
> +		git init client &&
> +
> +		# Check a name coming after "refs" alphabetically ...
> +		git -C server update-ref refs/heads/s wanted &&
> +		git -C server update-ref refs/heads/refs/heads/s unwanted &&
> +		git -C client fetch ../server refs/heads/s:refs/heads/checkthis &&
> +		git -C server rev-parse wanted >expect &&
> +		git -C client rev-parse checkthis >actual &&
> +		test_cmp expect actual &&
> +
> +		# ... and one before.
> +		git -C server update-ref refs/heads/q wanted &&
> +		git -C server update-ref refs/heads/refs/heads/q unwanted &&
> +		git -C client fetch ../server refs/heads/q:refs/heads/checkthis &&
> +		git -C server rev-parse wanted >expect &&
> +		git -C client rev-parse checkthis >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  # configured prune tests
>  
>  set_config_tristate () {
