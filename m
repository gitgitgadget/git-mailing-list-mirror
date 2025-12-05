Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38A27FD75
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764934429; cv=none; b=hU3qGcOKbC7b2+aiZeGU0am3a2qSGFLJFMabSoW/GMgSGFSTn9P6KhKiBDYkwNIBOYnNYuJ8kaEhOiA4R/yViNPvZ8FZBKNGlvD2xCE03v1wsGCZe/+HXDlF/sXKdEOgyCiyKA7GeEEQ8CIkyZDHpdDC0mVOI/PAUG5x2bkrnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764934429; c=relaxed/simple;
	bh=bfhjq+FymPegsgI+kgwljnyaJ8FPjnIpF1tXsfmU0m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jyofam5yZhnUxPreblLHAnxlKOGVS6FlYjekPy60mAvTPqISO8gTh2VFolo03GUMmjTE21aS3FeOFTaW00WTZ75Hi9sOX37QgowvLqpsxaTSnAaqylgH8B7iel26VBjVHVuM5qAblTlB8xMeCybgGtirxOXbT7/Rvtu9JWdsyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pIyRijVY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JQhO43GE; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pIyRijVY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQhO43GE"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E70241D000CD;
	Fri,  5 Dec 2025 06:33:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 05 Dec 2025 06:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764934424; x=1765020824; bh=voqknlFWnZ
	Fywr/ub7CfVyD23Zwjxb+Q1/7K8d3fiY0=; b=pIyRijVYPofKCvWleuke+UfEMB
	ROhWLzURoc1Q8iC+eLu6IQYEhAcauue+qrE+g0R2jGm8LUhVshkz8d8vwLIVlXGs
	Nz+A5+G9bhOUD+FyIVUdS7E+yYb95wh8FtH7AIS7k3O7eVNqId8Y83XvCnyN27di
	lmB/9Zr7Pv/QCunYdDInsAM7ljgJe0U/7Yg5gCWpnRCFhrZmWC539TCqa9qxq8ba
	5tmJw36zd8xq2DM8ukzqyshnS+apJSDS66WF4MpFhU/K/G3ZluhfXkzslwqXM2hx
	rK0SIDCYfkjXQ1yo0vTDX1Qg8rxAReyqYD3VynbSy0CToxKEn2BP4vIXBeIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764934424; x=1765020824; bh=voqknlFWnZFywr/ub7CfVyD23Zwjxb+Q1/7
	K8d3fiY0=; b=JQhO43GEw3XrqoZl26fP3Usrz5iq59cbgywPRf1kNCayOhSw3u6
	1X9tELmw+sTyBjHHTIV35BVD6/HXKQ362TwLyrOki4vZ/9CBF09uJZVhQIu3JzjT
	feXcNMi1cTpq16o9gc4/SBhC+6QuWykF+4I+2BINgDhh190yUwRcwHHsP6zAjwI3
	svtTL2cYFSTeELT80eLZu4ANh7AxlZCg+gnV6ttmDDLW5EQmdS7jWUhTIAYLwB+z
	iTh0fzf3fF/wZNTECrxLW7AW8MOZdCwy0Rr7CSO9f1r3GGujkG3ccZkDiW02gPXY
	5PxwJ37I7WoCRuHoIftQfHqFaG1pJI7FLkQ==
X-ME-Sender: <xms:GMMyaX-3vtI4YntwZqOFaNRowCzNY7OuxQjZewdZsPww3RkgJ4cbqw>
    <xme:GMMyaWw8mY8A6D3RFY-cvFf8Mrxp7CWcvmSqgQxx078AdGqKkj7r7UwT8uZnWdUe6
    8TI1bu7S3lQVjhBjHnZJZ6wWcFaAX2X5qrJLpAcPAHBcJhjOOyG1g>
X-ME-Received: <xmr:GMMyafqZNYgWndD9SRiQAKWyBKZ9ajzZx_2l57r4EWDNNfb2A8zRdl69lD0mYTrxrUavlh5QlOR7llmmwFxGaChanp01Y5Uif_vjsJyEQR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    esughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhi
    nhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsihguughh
    rghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:GMMyafqio75KZ7ESbDgQlSf9mN9CiVqh9zA1UTigut2eodWnjvPB_Q>
    <xmx:GMMyaXBpUc7hVQ73-OQLAe-eMr0KjqvmofRQHGfGIZ_U5zSXWl6ZYA>
    <xmx:GMMyaVuVFhNxkTaFI4KI_ca6sfcx6IHcW6cCFxEig-RuoPdu5D8z3w>
    <xmx:GMMyaeIbLI47QxgduvXXj9e6bifFU6EtaNJ9JYXdWAc4a-ITTUJEJA>
    <xmx:GMMyafJ1WK3q77PmOla3NrRSH6NbspAkKCABJUXiOCSVQoMilXXRjqTg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 06:33:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b18b7913 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Dec 2025 11:33:42 +0000 (UTC)
Date: Fri, 5 Dec 2025 12:33:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, newren@gmail.com,
	gitster@pobox.com, phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk, karthik.188@gmail.com,
	johannes.schindelin@gmx.de, toon@iotcl.com
Subject: Re: [PATCH v2 2/2] replay: add --revert mode to reverse commit
 changes
Message-ID: <aTLDEgGzVnvU45va@pks.im>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-3-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202201611.22137-3-siddharthasthana31@gmail.com>

On Wed, Dec 03, 2025 at 01:46:11AM +0530, Siddharth Asthana wrote:
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 6606a2c94b..7660f7412f 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -77,9 +105,14 @@ static struct commit *create_commit(struct repository *repo,
>  
>  	commit_list_insert(parent, &parents);
>  	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
> -	find_commit_subject(message, &orig_message);
> -	strbuf_addstr(&msg, orig_message);
> -	author = get_author(message);
> +	if (action == REPLAY_REVERT) {
> +		generate_revert_message(&msg, based_on, repo);
> +		author = xstrdup(git_author_info(IDENT_STRICT));
> +	} else {
> +		find_commit_subject(message, &orig_message);
> +		strbuf_addstr(&msg, orig_message);
> +		author = get_author(message);
> +	}
>  	reset_ident_date();
>  	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
>  				 &ret, author, NULL, sign_commit, extra)) {

Do we want to be defensive in those if-chains and verify that `action ==
REPLAY_PICK` in the other case, and `BUG()` if it's not?

> @@ -273,21 +322,39 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  	pickme_tree = repo_get_commit_tree(repo, pickme);
>  	base_tree = repo_get_commit_tree(repo, base);
>  
> -	merge_opt->branch1 = short_commit_name(repo, replayed_base);
> -	merge_opt->branch2 = short_commit_name(repo, pickme);
> -	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
> +	if (action == REPLAY_PICK) {
> +		/* Cherry-pick: normal order */
> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
> +		merge_opt->branch2 = short_commit_name(repo, pickme);
> +		merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
>  
> -	merge_incore_nonrecursive(merge_opt,
> -				  base_tree,
> -				  result->tree,
> -				  pickme_tree,
> -				  result);
> +		merge_incore_nonrecursive(merge_opt,
> +					  base_tree,
> +					  result->tree,
> +					  pickme_tree,
> +					  result);
>  
> -	free((char*)merge_opt->ancestor);
> +		free((char *)merge_opt->ancestor);
> +	} else {
> +		/* Revert: swap base and pickme to reverse the diff */
> +		const char *pickme_name = short_commit_name(repo, pickme);
> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
> +		merge_opt->branch2 = xstrfmt("parent of %s", pickme_name);
> +		merge_opt->ancestor = pickme_name;
> +
> +		merge_incore_nonrecursive(merge_opt,
> +					  pickme_tree,
> +					  result->tree,
> +					  base_tree,
> +					  result);
> +
> +		free((char *)merge_opt->branch2);
> +	}
>  	merge_opt->ancestor = NULL;
> +	merge_opt->branch2 = NULL;

We can `FREE_AND_NULL()` instead of manually unsetting these.

> @@ -387,18 +460,28 @@ int cmd_replay(int argc,
>  	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
>  			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
>  
> -	if (!onto_name && !advance_name_opt) {
> -		error(_("option --onto or --advance is mandatory"));
> +	/* Exactly one mode must be specified */
> +	if (!onto_name && !advance_name_opt && !revert_name_opt) {
> +		error(_("exactly one of --onto, --advance, or --revert is required"));
>  		usage_with_options(replay_usage, replay_options);
>  	}
>  
>  	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
> -				  contained, "--contained");
> +				  !!onto_name, "--onto");
> +	die_for_incompatible_opt2(!!revert_name_opt, "--revert",
> +				  !!onto_name, "--onto");
> +	die_for_incompatible_opt2(!!revert_name_opt, "--revert",
> +				  !!advance_name_opt, "--advance");
> +	die_for_incompatible_opt2(contained, "--contained",
> +				  !onto_name, "requires --onto");

We have `die_for_incompatible_opt3()` that can be used here to check for
mutual exclusivity of "--revert", "--advance" and "--onto".

> @@ -508,7 +594,7 @@ int cmd_replay(int argc,
>  		kh_value(replayed_commits, pos) = last_commit;
>  
>  		/* Update any necessary branches */
> -		if (advance_name)
> +		if (advance_name || revert_name)
>  			continue;
>  		decoration = get_name_decoration(&commit->object);
>  		if (!decoration)
> @@ -532,7 +618,7 @@ int cmd_replay(int argc,
>  		}
>  	}
>  
> -	/* In --advance mode, advance the target ref */
> +	/* In --advance or --revert mode, update the target ref */
>  	if (result.clean == 1 && advance_name) {
>  		if (handle_ref_update(ref_mode, transaction, advance_name,
>  				      &last_commit->object.oid,
> @@ -544,6 +630,17 @@ int cmd_replay(int argc,
>  			goto cleanup;
>  		}
>  	}
> +	if (result.clean == 1 && revert_name) {
> +		if (handle_ref_update(ref_mode, transaction, revert_name,
> +				      &last_commit->object.oid,
> +				      &onto->object.oid,
> +				      reflog_msg.buf,
> +				      &transaction_err) < 0) {
> +			ret = error(_("failed to update ref '%s': %s"),
> +				    revert_name, transaction_err.buf);
> +			goto cleanup;
> +		}
> +	}

This conditional and the one beforehand are the exact same, except that
we use either `revert_name` or `advance_name`. Let's merge them:

    if (result.clean == 1 && (revert_name || advance_name)) {
        const char *ref = revert_name ? revert_name : advance_name;
        if (handle_ref_update(ref_mode, transaction, ref,
                      &last_commit->object.oid,
                      &onto->object.oid,
                      reflog_msg.buf,
                      &transaction_err) < 0) {
            ret = error(_("failed to update ref '%s': %s"),
                    revert_name, transaction_err.buf);
            goto cleanup;
        }
    }

Patrick
