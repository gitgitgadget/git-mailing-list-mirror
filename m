Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4A3BE633
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236141; cv=none; b=BtCNe0jLhWKGz0Oo24M8II/ip2wChqjNOC9T4vr2hstv/oVaYyPlxLcUmu2wFd8v/BI6jiANQb7NfWYvsDSc4hiu47FsM6cvpFUakhzb+INEzs20PMjjOxL8YCeCLC8ReIOT9+KjWIinJf4vr4eMEXBy5y8YiTCzTbIKRaQirbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236141; c=relaxed/simple;
	bh=MPWX/RZv2MT7Vpf05QaymWCuysV7YJli6L/25lrIn+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QE/Zg0I966K5E670X4h32sYD1PgLRK0F2v3E6LZoqan3L8LOZ1wuuYw1+AGZ/ZlptpxqAqcrcfvUip9btJMuVZ0GZQL/t+HFnRy5gHkH5U21RmKd8SZIcMV36XKD/o51JB9OZwPsh4YFmiwKUYAKHpXtizRlBudiJTralVTV43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q0sk+8gj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GOnkvEbn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q0sk+8gj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GOnkvEbn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A03E140013A;
	Thu, 16 Jul 2026 17:08:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 17:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784236138; x=1784322538; bh=T6LIBD70jO
	G8BnGld/I7uJrIzxGk4Hm/maT50jqvkVI=; b=Q0sk+8gjFGL2nSqZsGlkZunCd0
	PdyVzXPWJn/cHtRi9RynO5CNA/JVtRuw1JVFrapoXgyGUKlVR8cPtpNTrbKk1BKE
	LPoVNh00GrBf/7PPqclCXQOh95Z9tXMyxuAmKO5OaDxRmgOOC/uzIcDvqhH4LaGj
	A0NWe8+orUYiK4rZ4+X1uRKvawKkY28F1Vv7G2QGNJhYu/rQEN1TpcQ5pVcJuU2Z
	i8p6zJsstzBqQeSJDyR/RvpaN1SNBF16MXlzfiSgakC2fuGlL5jDnvwPZiuULPuX
	CNx4jt+UQhAJoKZxdbRWQOxL1OsCVB/eJNBQuJr6sj4zpa1j/XNIee8m0ITQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784236138; x=1784322538; bh=T6LIBD70jOG8BnGld/I7uJrIzxGk4Hm/maT
	50jqvkVI=; b=GOnkvEbnjhRaMvzm55YJhT44bzy0cSJMyteJl4vHW6JjkH1dvS0
	IPmqLcV3uwlcm5xa+PQM6u+lH7YLC7XL+1x46LfIHcvCerKmTcrTrQYb83jIZjk3
	6JWe51Dm6CJHFNfvUQQXzIG9xJWSILkLVHJJ66iaZKJ27ZT8QZbOw33viM6r23No
	DSvq33h250jl7BjJE2qM55g6u0w4ru3r0WGIcZM8Cbpcnga7rgOcXyRz+6xvt1Fb
	/cZKagM0LSh4UoF406g/aKu0sCNOfPrSzGnu07CQ4Kx4Wj98AvqQaStqoMpAXtsi
	mIg1z6k5s9M3PPm0g3t/x3UdJNKiEjMdjHg==
X-ME-Sender: <xms:akhZaj8WQ6ggtFZ8uJGDdLzLVyJ7yPTNX7BboHH_rRP_1tyXIDLu2A>
    <xme:akhZaiTzVEG-qwa7LjWWL2eoUztJFn3Y-BGGWNkqGfd0QTD7VXGdGu1NqBbHZUe_3
    F4EHF6LQE3V1ia-Phywx13EteEICiRInbV5AfoQ8dHcNpkaWjppnA>
X-ME-Received: <xmr:akhZakqz6wfYvKQqgBwWMm091fiQgKmw1_QLflX0CoUC6tTDhrlamwL9dGkjFOA0M5hESPeS0UUZk8z3mC8YmOXxaRKv0Waj5F6Y0Gk>
X-ME-Proxy-Cause: dmFkZTGjA6FXMQJmxHBNMAt9yHog2aq2ANJOcKxdKvnA5rgBBkUkaAHJB5Vi3htREnyWKG
    sseDLaigiCaPzot+tNZ/sSBh41YDS+MjasUkg3JN3p7lfQxdvTdseXaERqzJylPUhD1T+i
    9CEDQBrnFH4ECoNeSrTyYNcOa48yedm21gNduSwOgxlBUVasggR9GMJX75GvHrgU2BfqbQ
    dpyzt0J7wclt4/ugPETuQycY6bH9H67QMjiy6OcW+vdDCbgUgOkq+APtWCUsY4Dor7EtdG
    C7qLrqz6qZbI4rIf5T3CKn4uea/0ZRIdfwumPvO+aY/cytuCvokDfcJDp7udUMKYCfRuk4
    9auPsS4+0WECC6z1+B0phmNDGhwSoTVfYxF0jVIokxu8q3CILvao9dKDQDlwgRLCRmmpmO
    RmXXevaa0RqvR+RQMXJlyVf/TuNrN+YvJpiWu0oSL9qIYp13cKGkzj4qR79NHxpoqS+5Cd
    dUBm2lKQrKLGE19T0UHzxPThhvgdmIuBdm+OqTnOs9kO7wtagSlN2yz02TrRiPJuEQHqKV
    MoBKFWVIc8a7wSTCWyZTILkoCH9ftwU9S+lvHlqeqS9i97uM7W23I0MV8tJTFhUrln9y6G
    AGwU01KzbkMtPEHtpAEjIZueRcairjVqWfM93khQCidkEPDCUq2yCxvNtMzA
X-ME-Proxy: <xmx:akhZavmHNKQbt2XtWTGCYriqQSBeUbbd3XtOfIRxCctFtYx2vTT7QQ>
    <xmx:akhZatfKk-XWHYP7tlF8jaPH724i-qTdO-Rp7EqgZMRk3tWO8bC-Vg>
    <xmx:akhZaro9AAo6FQie58mHjoydr_Y7CQ55eshEwn8DhSixxXh0P0lsZQ>
    <xmx:akhZanNgDnaOFqgfPWw1sSyy40XRWwx-kYCYK-eAN8Sb0gSUrkew2A>
    <xmx:akhZaqKFFd7YA5sgbzNtz5DFYFZIN4DBNt3BLdBAneU4OflLIwx_LqgP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 17:08:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  me@ttaylorr.com,  ps@pks.im,
  johannes.schindelin@gmx.de,  l.s.r@web.de
Subject: Re: [RFC PATCH 1/7] builtin/repack.c: add --drop-filtered and
 --dry-run options
In-Reply-To: <20260716132848.95982-2-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Thu, 16 Jul 2026 18:58:42 +0530")
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
	<20260716132848.95982-2-r.siddharth.shrimali@gmail.com>
Date: Thu, 16 Jul 2026 14:08:56 -0700
Message-ID: <xmqqh5lyej6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> --drop-filtered is incompatible with bitmap writing: filtering breaks
> the "all objects in one pack" closure that bitmaps require. An explicit
> -b is rejected with a clear error and a default-on bitmap configuration is
> silently disabled for the duration of the command.

That is very well intentioned.

> @@ -231,6 +234,10 @@ int cmd_repack(int argc,
>  			   N_("pack prefix to store a pack containing pruned objects")),
>  		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
>  			   N_("pack prefix to store a pack containing filtered out objects")),
> +		OPT_BOOL(0, "drop-filtered", &drop_filtered,
> +				N_("delete filtered out objects (requires --filter)")),
> +		OPT_BOOL(0, "dry-run", &dry_run,
> +				N_("only show which objects would be dropped")),
>  		OPT_END()
>  	};
>  
> @@ -252,6 +259,43 @@ int cmd_repack(int argc,
>  	po_args.depth = xstrdup_or_null(opt_depth);
>  	po_args.threads = xstrdup_or_null(opt_threads);
>  
> +	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
> +		!!filter_to, "--filter-to");
> +
> +	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
> +		write_bitmaps > 0, "--write-bitmap-index");

Hmph.  Since this step does not change the parsing or configuration
for write_bitmaps, we cannot tell if (write_bitmaps == 1) at this
point in the execution came from the command line (e.g., an earlier
call to parse_options() around line 247 of builtin/repack.c) or from
the configuration files (e.g., a call to repo_config() around
line 245).  In other words, wouldn't it be ...

> +	if (dry_run && !drop_filtered)
> +		die(_("--dry-run only takes effect with --drop-filtered"));
> +
> +	if (drop_filtered) {
> +		if (!dry_run)
> +			die(_("--drop-filtered doesn't work without --dry-run yet"));
> +
> +		if (!po_args.filter_options.choice)
> +			die(_("--drop-filtered requires --filter"));
> +
> +		if (!(pack_everything & ALL_INTO_ONE))
> +			die(_("--drop-filtered requires -a"));
> +
> +		/*
> +		 * Only blob:limit=<n> is supported for now. Reject other
> +		 * filter choices early, before walking the object database.
> +		 */
> +		if (po_args.filter_options.choice != LOFC_BLOB_LIMIT)
> +			die(_("--drop-filtered only supports --filter=blob:limit=<n> for now"));
> +
> +		/*
> +		 * Without a promisor remote there is nowhere to re-fetch the
> +		 * dropped objects from, so dropping them would be permanent
> +		 * data loss.
> +		 */
> +		if (!repo_has_promisor_remote(repo))
> +			die(_("--drop-filtered requires a promisor remote"));
> +
> +		write_bitmaps = 0;

... way too late to drop the flag here?

> +	}
> +
>  	if (delete_redundant && repo->repository_format_precious_objects)
>  		die(_("cannot delete packs in a precious-objects repo"));
