Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33DE13B58C
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652304; cv=none; b=iMsjxu3oW3UFOPWKXCIBxS5a9MHEVee0aASYQ4SHeoIwRCJ2HNJ96G3Uk1aSjKZgK9LPj2M2PPQsNW0XAb7f+KaSllteaoR+SxsxPqOQhP8ZQZIA1n7GqgceAYPR56I6AedikFV+exwXIE/nuWIluJneE6INP4kbRzsoRhScAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652304; c=relaxed/simple;
	bh=2bzYdwJdJXmkqBcjofdWXQQOGbP/O7dmzkhHWGC83Bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WO/gW/J3RuZkWJ9onAdeWVwBHXdSFmDqgGOnamHQsYCPNzjCWtHj9wvU+9ofEDz9wBAJZZLKKMr4fIYKKClj31/DIM40406bUYUXX85uTigM/eWMUGqOk+SOBxqBnWoGliq8//2IYr96htThzRL4bL+YLLqj3n/Wi6dzI50Jflo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TpL6EgWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lJjpbOC0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TpL6EgWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lJjpbOC0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D9A2EEC092F
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 13:11:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sat, 10 Oct 2026 13:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791652300; x=1791738700; bh=i2lA9OPGRe
	Qx6SOP3bSs1BxjdcarRWP6r3kDR478sKQ=; b=TpL6EgWop690/g+cYn+Sz1DV/E
	Go6mBi+ReI9WpIzcsux9wax4Gq39iB0rX2uqyOV54o6cZf9HMD9cCP7vQ+/sKPdT
	1Fs1iRgkbjtaysnv2EJq2w2w5tXGrZ8Sk7st25lkTtnJCXKmwDwRtrpsfrr/DWzl
	I1NzCySzt24D03qfCwUG7zUcZ+V+/rzwENd/rL7R4mSVV68mNOnRn+z574MPIeta
	rjX5gsRESRVkki19zfMv0PqtSAttKEuUs9q108ORGgH8zKCv23+FkPUich+Pfh76
	fxFbX4uUSReHlZwuECzPSpIyVKlJERxel/JM3vfxykoMVBKlDtCSyJnS6yPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791652300; x=1791738700; bh=i2lA9OPGReQx6SOP3bSs1BxjdcarRWP6r3k
	DR478sKQ=; b=lJjpbOC0qbZsVVJ4HWgAblIQ1jofo76Fr6PafaDSTos7U13YU8x
	utmCxgygcuiF1DkivZ61kJCnXID/2c5v8UDsjuBzAmOMNk0SEYW9RyY5s/w7p2ji
	ImAqW9jahhUj6qNLw2ok0JPzgIlpGuCsxHxyx1nncP5aI2UJEYGhri/t4WWD4voY
	dk4POm/nDQGAbmxSMiGHUqPGuVpMkOoF+YSUdfns0dNB5pIrH29E1e5xBQx7eVcF
	OwTsHurohcghzThqARlAFbb7Lke10PyPa6mGDM7gu/Y/DhQYJJZLYweURoLcux2Z
	IiL0jc7Of6MaYVoe8D3c7MV3I1j57bvh7Kg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791652300; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:IBwvvjIifKsiUXn/59xR4b7EWMGRu6NAmwHvt6uH+bKq5Ln
	dm2ibItCpUgRaUMo4NR5tlhiLW1wWwwrehGkOSWZPidQKVx84KSJA74nu0w/col1
	C3VtwuR879SNzhrz/UKvfVTFX4W+RakJ4dOIO8objm2rh/9V3AK4UYcULql0mKAp
	bHK5BexmYIzkF/OmCXBQNwBF3x5bVh4N2qVJ5MPlKKET98VoxDF0Lnz2U6cB3dxA
	UobyWmUTDc6qCKmPA1uIPc+xdq30wGHmE0zdBI04z1dmbpHPIQ8OQAeK9H8c4Kvu
	m90/4v6P6d7wAmWgUz2pHB2EAKZSLHo+aaEtdHg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:42rLWINrijcUUoggxmm1jaRZ8hjtCi3YRqY9PaPj0yc=:2bzYdwJdJXmkqBcjofdWXQQOGbP/O7dmzkhHWGC83Bo=;
X-ME-Sender: <xms:zHHKagdvzuekfHcVftU9T0tMTi1LfYGRj9sFPkSbrSuySFevPJHW_w>
    <xme:zHHKal7Rio4upzpB5K5HJRDedThYUlZMZY8brH64L8q-95AgN_urgVuXVvIuIyz42
    kk9Jo4bnT1j5Ez0Eq3ekaRViDMWBcPxlzKalYDrBMFrgv5DjQQGGV8>
X-ME-Received: <xmr:zHHKarXzoDjpkiPva8hhEBJAMCOi62CptFnJAf1FVX84vOXXO3nXi3EAgDDQfClUlA74mcBveiPV6hcyn-CioB4-atBpUp7l1jVE>
X-ME-Proxy-Cause: dmFkZTG2qIz6HhqlYjiY4Yk0GaRR7rxNXODm8VfbtP/+ri0a4MlI2OUpojFXtQd7MYyVfZ
    tuhmgwXBTBQc20YsyIFzGx9LdJZsYqKWQA2aNJfb1woR5Fq30S/VD9oxP4WGi/iHq0bL5E
    dwWegU9t00ox5OgCJnlhJp3AEYb1DM0sCOaGRHJWs4OlFxmqXo0vH31c4Qx03USYfiVsQX
    OO5LrKvAjhrJWyuv23BxoV2DFzQDKE0JiwR3tFT9rfuqkRgyifMnFAC2ywYUEOIfFclXXq
    6s+KcK/i3XzQoRsarfcFiitOP1foj1hDHbkPswepHtacI9TD82kCEZCJPQbux+U0b3f7VN
    pbx9nriN777NTEWOk0WVC6cMN+GKfIaqnq/Cj4PJsyyely2ayv2KgzqXMePyekSY57d+9C
    Mlbpj0WFvejoRL5ht3AH4GuzLmGnoJoXSGtXCwKCcmvA+VE84MANSNH9ueulsUcoNJXqt1
    xS+da6VUDaXIQMyMNglWB4PDPcD6E2GjfUGUAMeVEXEqt5rNp0EWr+lJxGwKrwBY/9N9WA
    /MA/R+ybKR+EKjatTT1I5pncdx3/8aqoRHwTNyEUoLoxZz6doXX1d0g4bCuiVobt1lioYK
    X2WDulwJWjqjVW7EuBFRloIhsRRkxQxMfNG8xIUE96z+d1JpPyY9IVep6v2w
X-ME-Proxy: <xmx:zHHKas7RRTwWlHx0AU99k5UkTveOcvVh3D_U7D0m1J2E6by1DJd_3A>
    <xmx:zHHKauo3l9iPrAUPqzv9q_eJZWu_Up-FEB7GFy_s-AvOQx1iV_C5qg>
    <xmx:zHHKankphxvWztsx9chGOftauun_aF00nv8NQwWjaNnsKf4gdrmi_g>
    <xmx:zHHKaiPVY193L6FXna0raVJMWh3pVUFuLi6QFG6SyMiNxFl9SJSUyQ>
    <xmx:zHHKapAkdL-rpI5Hm66P3uq_sOBLV_zxWYEgOozpoA2HDQ_el6XjqwoI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 13:11:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v8 2/5] fetch: extract collect_upstream_from_remote()
 helper
In-Reply-To: <08fea07a8be8a91ac54db44f9c035ecb49c86c9f.1791619334.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sat, 10 Oct 2026
	08:02:11 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
	<08fea07a8be8a91ac54db44f9c035ecb49c86c9f.1791619334.git.gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 10:11:39 -0700
Message-ID: <xmqqik39iipg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1962,23 +1962,36 @@ static int do_fetch(struct transport *transport,
>  
>  	if (rs->nr) {
>  		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
>  	} else {
> -		struct branch *branch = branch_get(NULL);
>  
> -		if (transport->remote->fetch.nr) {
> -			refspec_ref_prefixes(&transport->remote->fetch,
> -					     &transport_ls_refs_options.ref_prefixes);
> -			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
> -				do_set_head = 1;
> -		}
> -		if (branch && branch_has_merge_config(branch) &&
> -		    !strcmp(branch->remote_name, transport->remote->name)) {
> -			int i;
> -			for (i = 0; i < branch->merge_nr; i++) {
> -				strvec_push(&transport_ls_refs_options.ref_prefixes,
> -					    branch->merge[i]->src);
> -			}
> -		}
>  
>  		/*
>  		 * If there are no refs specified to fetch, then we just

We used to say "if there is remote.*.fetch, add them.  whether there
is remote.*.fetch or not, if the current branch builds on their
branch(es), add them too".

> @@ -1962,23 +1962,36 @@ static int do_fetch(struct transport *transport,
>  
>  	if (rs->nr) {
>  		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
> +	} else if (transport->remote->fetch.nr) {
> +		struct string_list tracked = STRING_LIST_INIT_DUP;
> +		struct string_list_item *item;
> +
> +		refspec_ref_prefixes(&transport->remote->fetch,
> +				     &transport_ls_refs_options.ref_prefixes);
> +		if (follow_remote_head != FOLLOW_REMOTE_NEVER)
> +			do_set_head = 1;
> +
> +		/*
> +		 * The configured refspec may not cover the current
> +		 * branch's upstream (e.g. a narrowed -t refspec), so
> +		 * make sure we can still fetch it regardless.
> +		 */
> +		collect_upstream_from_remote(the_repository, &tracked,
> +					      transport->remote, NULL);
> +		for_each_string_list_item(item, &tracked)
> +			strvec_push(&transport_ls_refs_options.ref_prefixes,
> +				    item->string);
> +		string_list_clear(&tracked, 0);
>  	} else {
> +		struct string_list tracked = STRING_LIST_INIT_DUP;
> +		struct string_list_item *item;
>  
> +		collect_upstream_from_remote(the_repository, &tracked,
> +					      transport->remote, NULL);
> +		for_each_string_list_item(item, &tracked)
> +			strvec_push(&transport_ls_refs_options.ref_prefixes,
> +				    item->string);
> +		string_list_clear(&tracked, 0);

This reorganizes it to say "if there is remote.*.fetch, do the same
as before.  If there is not remote.*.fetch, add their branch(es) the
current branch wants".

This "duplicate what happens to the current branch" belongs to the
next step where you want to add more logic to the latter part (i.e.,
"no remote.*.fetch" case), and not to this step.

IOW I would have expected to see

	} else {
		if (transport->remote->fetch.nr) {
			struct string_list tracked = STRING_LIST_INIT_DUP;
			struct string_list_item *item;

			refspec_ref_prefixes(&transport->remote->fetch,
					     &transport_ls_refs_options.ref_prefixes);
			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
				do_set_head = 1;
		}

		/*
		 * The configured refspec may not cover the current
		 * branch's upstream (e.g. a narrowed -t refspec), so
		 * make sure we can still fetch it regardless.
		 */
		collect_upstream_from_remote(the_repository, &tracked,
					      transport->remote, NULL);
		for_each_string_list_item(item, &tracked)
			strvec_push(&transport_ls_refs_options.ref_prefixes,
				    item->string);
		string_list_clear(&tracked, 0);
	}

that touches "help the current branch when rs->nr == 0" part and
nothing else.

Of course, because the next step [3/5] wants to split the above
else{} block to do different things between the case where
remote.*.fetch is and is not empty, at that point the extra
code may be introduced there, ending up with the shape of if/else if
cascade as we see in your patch.

> diff --git a/remote.c b/remote.c
> index 99a086ea5a..5e980625b8 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1884,6 +1884,21 @@ int branch_merge_matches(struct branch *branch,
>  	return refname_match(branch->merge[i]->src, refname);
>  }
>  
> +void collect_upstream_from_remote(struct repository *repo,
> +				   struct string_list *tracked,
> +				   struct remote *remote,
> +				   const char *refname)
> +{
> +	struct branch *branch = repo_branch_get(repo, refname);
> +
> +	if (!branch_has_merge_config(branch) ||
> +	    strcmp(branch->remote_name, remote->name))
> +		return;
> +	for (int i = 0; i < branch->merge_nr; i++)
> +		string_list_insert(tracked, branch->merge[i]->src);
> +}

The original tries to avoid branch == NULL causing a segfault, but
the above does not.  Intended or overlooked?

Other than that, this looks like a straight-forward refactoring.
