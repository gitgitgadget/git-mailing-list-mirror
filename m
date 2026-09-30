Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00870318EC5
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785728; cv=none; b=h8RW0SxgD4GlhEMEjK512LOrydsI/GksfrxnxmsO/6CBhhwnxLzQCEAQJayEokT9w56slRALZnrsivirl8Mac477ZeDoCXfeZffrFrbas2mt8wRZFXx+7XTKKL2DjPbMDwEdgDujma4Lp4oXLfLTjDhUuXbnlDA+BgWD2Q5jlyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785728; c=relaxed/simple;
	bh=YY3VPyQP44VCCAJB8h15cbeN/t9KED+l8Ee/WuO9Auo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDEwmF0j0iOUq8qMMhfvSYCFOGEF36faG2UTChXuQQo3kIJ7Vucao6FKFE758i3XKl7XnmDttyYPvwh0Iu6USY+z+iEYsYFZGTif4puXhj70al6pDzF3mT6+Vt3tUm4F//gnNmdeXDjVi/+eXGmcvLVVEd265owGLcH0Ld/b9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bPSMOm4f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRMQiYSn; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bPSMOm4f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRMQiYSn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 167E914001B2;
	Wed, 30 Sep 2026 12:28:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 12:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790785726; x=1790872126; bh=uBRGfwjXLi
	KugRRMnLl79ZnkWRibV+ybWXDabF268z4=; b=bPSMOm4fwuZn3TwAxNsyGgc238
	Jmb8OYfVqj9NYWL5i4PNYgIc/ePSaDcQtNjkGACc/i0WULbFMzZxCmwR59frglYh
	2ILwCXNwkHsLhZ9BIde2WSwbvjTtL16jqnFL/D+8nxhU3f0uI7seqe/Gt4MAAaPW
	pneWh/meJgCsSMrmNmlN/+e2+tj39kd9EgqR5fbWGNrvB9ae75zGFSQ0trGgKqRB
	NFqLqJfrNYero9TnzipQF5A9LDnR1Bl+994dUb41Bia0o4D2s69TnLF99Wb/taec
	uU30dA3M+hbx+5PCerQ15Xh/QTwATcy7v7RjDQD37PPp+DpRZ+O/ieINgIhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790785726; x=1790872126; bh=uBRGfwjXLiKugRRMnLl79ZnkWRibV+ybWXD
	abF268z4=; b=VRMQiYSnqlNQanSG3jfUdxYZiX1h0FxbU+s+P8zWWcN26GnCN2b
	Gp0B+E6+8dfBpoFb5tmpb3SPb623ejUc0DDgJDJUE7gcq/kFUqTXIy9oPgBwyinz
	aAl4z8Rgm21ASwJziorXOrPbzJfxbqk/F9KL7D0WHdlPJes5s6UeBJtz/OwpZjEz
	rfOCP5VUxlzrku0CkXaMV316URFgMOAxKUGfkATPClUWZ0pZTKYW6Ht9fOfaitnm
	vFvQD1sgH8J/ayh+xRzyuwmLb7GUromyKtY+YMwoKskIoUX5L3IOnAzYsu7+HnJG
	ELIOa/dn5cY8y//tJKl4ZVwn6040Tc57J3A==
X-ME-Sender: <xms:vji9agaKy9Qt0UPrg8dWYTOpziHur_FJq6bzcZ-S-pSooD76j-XCoQ>
    <xme:vji9ai0gBZx4-ji6WCZAhIihpr53TGZNkH9SJMhcxazcKCS665Z890edPmxRThiT9
    0T_jy4FzMexiI-msbv8oZF0Sw3sN_J_jhoDjdITyYD_Uwk3v1PxO_xw>
X-ME-Received: <xmr:vji9aoUpEe1suxhhIaRcsZaKjIhGJZd06cnbunzoHBDBeeITWefQyA>
X-ME-Proxy-Cause: dmFkZTECJrhWGSk1mjbIUuSD346p6iuxdTT+sfQmnEwswW2gIE1AXv/PRIw5+TrRy5SSV2
    UwzgE7gCnWzScz2qS4DK5GZlWizQ+DYt1zjChHbfgR2L4q6l6LsFkGmUaziKk9PDGNSuUv
    8409P4r5sEfiTjmT0cOONs9T3yJnnFqKhb0dUIbN6SuxWxeOducURaz+iDY54KtJf+6Niq
    CE892zxbAR879TApb9Xm9UIAnmXYft38pRMG1PAraxIM6yjtZ1hgaN0S/UdBnQ8eMdEw4O
    yk7sQtT/y9NBdigHTKRX0Ri+qTXgHQipgyHElvAg2yTkTdgRlU9Pt41MIRuPPCm8tNMnon
    KINpqP1NbShXU5O06H3CaCmnhc5WvEvFHUweQMK5sscOVTyeqHr7rwiozLiGnJpRDSq2L3
    oZ1Tc3HD1bUfs64iveu4R2Hr2ZiAXa8t5xdEZ8jY2GYK3Mx6Fq4hHv1sEQEhJDYcB/hB7O
    VojTdXVYK7TEOU4V11dCFp4isjBRDKXBzIzJG/uq9LMHV4UxoGfvYhwwKaJN9RvDR0bZxc
    XdQ+95MUiOVPZ6u8st497mV8C0clcRmREVU5DvSpxCytc5l8z4a+h7pIygqOowINgseTfI
    FkYG3vBIhyHeCRFo8qJ1ObdAem7oTkSLE9FcNfgT0oTVtrWa50KMdCCt9EoQ
X-ME-Proxy: <xmx:vji9akWvAuEV4FjKcfCBlMqcmLsvJI6bzZaiUTS79VPGjdSefX5GeQ>
    <xmx:vji9avcZmgu5X4p85KKcYb5dnNu5yXB7tWMQMJ82-IOA9pTsFPouOQ>
    <xmx:vji9alV5NpDe1HnHdODlcMv3WThFAOWvzTO6l3ov-_IY6l6lSY6moQ>
    <xmx:vji9agcRY1afMqhR12ORog73gbNepDdnBM1YbS2H5qypMk91SD-fWg>
    <xmx:vji9aq3kfkVSDEEv9mk251R2Rr4rVgRL9D2dk3Wz9NJEZvx6TaCyvOkw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 12:28:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 29aea881 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 16:28:44 +0000 (UTC)
Date: Wed, 30 Sep 2026 18:28:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH 1/1] repo: add filtering options to "repo structure"
Message-ID: <ar04uStCZ4pnEJ38@pks.im>
References: <20260924164503.119506-1-markchucarroll@fastmail.com>
 <20260924164503.119506-2-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924164503.119506-2-markchucarroll@fastmail.com>

On Thu, Sep 24, 2026 at 12:45:03PM -0400, Mark C. Chu-Carroll wrote:
> "git repo structure" provides a collection of useful information
> about the information stored in a repo. In particular, it's
> valuable for diagnosing performance issues caused by large objects
> stored in a repo.
> 
> The current implementation of "git repo stucture" provides summary
> information about everything in the repository - all of the
> branches, remotes, tags, stashes, and notes. But sometimes
> to properly diagnose a problem, it's useful to be able to exclude
> refs that are known to not be relevant to the issue at hand.

Yes, indeed. Sometimes you may for example want to figure out where
exactly the storage size of a particular repository is going. Or in the
case of GitLab for example, we may have bookkeeping references that are
not controllable by customers. So we may only want to get the structure
for all the customer-controllable branches there.

> Add a set of flags that allow a user to selective exclude
> reference types from the report generated by "git repo structure".
> When a ref type is excluded by the filter, it no longer appears
> in the report (ie, if "--no-tags" is passed, the report line
> for "Branches" will no longer appear under "* References").
> Following the pattern of flags that are only used to
> disable functionality (eg, "--no-verify" in "builtins/push.c"),
> only the "--no-<reftype>" syntax is listed in the updated
> documentation.

Hmm, okay. I would have expected that the user can essentially pass
arbitrary revisions as understood by git-log(1) et al. And if they pass
any such revisions, we should not enumerate anything but what they have
passed, so the flags shouldn't only be used to exclude.

So, for example:

    $ git repo structure --branches
    $ git repo structure master
    $ git repo structure --all --not --branches

I would hope that git-repo(1) can achieve that rather easily because I
expect that it uses `struct rev_info`, but let's read on.

> Overview of the changes:
> - Add an enum to represent the structure flags.
> - Add structure flags to the options for the "repo structure" commands.
> - For each reference flag, add a conditional in "count_references"
>   which decides whether or not to add a ref to the pending list.
>   If an references is not added to the pending list, the things it
>   transitively references will not be added to the stats.
> - Add a set of test cases to verify that reference counts
>   in the repo structure report correctly omit the specified
>   resource types.
> - Update the documentation for git-repo to include the new options.

Note that we typically don't have lists of what exactly has changed in
the commit. That kind of information is already visible from the diff
itself. So what the commit message itself should focus on is whether any
of these changes are non-obvious or whethere there's any dragons to be
found.

So in summary: everything that may surprise the reader should be part of
the commit message, everything that's just obvious plumbing doesn't
really have to be mentioned.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 84e012f83f..c8f6e38011 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -490,7 +504,8 @@ static inline size_t get_total_object_values(struct object_values *values)
>  }
>  
>  static void stats_table_setup_structure(struct stats_table *table,
> -					struct repo_structure *stats)
> +					struct repo_structure *stats,
> +					enum repo_structure_filter_flags flags)
>  {
>  	struct object_stats *objects = &stats->objects;
>  	struct ref_stats *refs = &stats->refs;
> @@ -502,9 +517,15 @@ static void stats_table_setup_structure(struct stats_table *table,
>  	ref_total = get_total_reference_count(refs);
>  	stats_table_addf(table, "* %s", _("References"));
>  	stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
> -	stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
> -	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
> -	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
> +	if (flags & REPO_STRUCTURE_FILTER_BRANCHES) {
> +		stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
> +	}
> +	if (flags & REPO_STRUCTURE_FILTER_TAGS) {
> +		stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
> +	}
> +	if (flags & REPO_STRUCTURE_FILTER_REMOTES) {
> +		stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
> +	}
>  	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
>  
>  	object_count_total = get_total_object_values(&objects->type_counts);

Coding style: we don't use curly braces around single-line statements.

But more importantly, I think this is where the mismatch in expectations
comes from that I was pointing out further up. My expectation was that
what we want to achieve is to filter the reachable objects by revisions,
which I think is a much more useful thing to do. But what the flags do
instead us to filter the output in the "References" count.

I think that we should rather go into the direction of filtering objects
and not the ref output, as the latter isn't all that useful. It _may_
make sense to maybe make some sections of the output optional, but
excluding individual ref types is arguably too fine-grained.

In any case, to go into the direction of filtering objects you'd want to
adapt `parse_options()` so that it accepts unknown options (you can
achieve that by passing `PARSE_OPT_KEEP_ARGV0 |
PARSE_OPT_KEEP_UNKNOWN_OPT`) and then pass argv to `setup_revisions()`.
And I think that _should_ already achieve proper filtering of objects by
revisions.

Thanks!

Patrick
