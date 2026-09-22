Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59134A2065
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104576; cv=none; b=ji7FQOMjr6ovgHB4yMvFU19BebNge1ArrRQoktt2nxkNCCYpI/3vwpVZ3aYDREw3Vg/wdyo9x5Vpziv2yWUkkluzqNlnPYPGHoQwUEkkhBQWYsnISr32zqjEDmTSCfRU2gjNAWZ+GtLuytLIGFBvncPuuC0xv0Zp/B1akrYIBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104576; c=relaxed/simple;
	bh=14MMSfHVRlQUpGDr2FDY16LHM4IIT7OzmEn3yZPuljU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aF7nK7N1mc5FSQgMtKEBkM6xe5TKw0QK5TsofJegruawuOpj7u2sSHMQ11Mc7R8IFATVWrEEuZH07qH0PdwVwYDWVTg2Eie8oRDjDTsVpWZLOWFxkXeeGiafGo6MTDCSBX9Tb/fW6tp5ri9TczxqBNKtFVKL1nCIjpV/NAeKzHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sf/GHMG8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRoER856; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sf/GHMG8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRoER856"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AA9F3EC0123;
	Tue, 22 Sep 2026 15:16:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 22 Sep 2026 15:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790104573; x=1790190973; bh=750SnI1fyQ
	umrL87nu3KpcqDkHzWJrxdwAAGj+AT5qs=; b=Sf/GHMG8TD2uY4bClI9a3UpaOj
	i5XfUA4PQaNgzHnC77zD+qoQN2REYMDg27qyDdVHCaugNTr7/Izi/hUvtHHChnIS
	U4YMPQLrTHg7z7r1kjs3+zGf3xMGR3P5orDC37cEwNJMxDYI7+sXe7qGuh6e2E80
	I1ySKi1T6an1ncnO/zFIlTjPOvsNj+SmDDdzfdpkjuWxMweqea9RLS3sbVzZArnp
	9KaLyW5Sc1ggspeE2TLQ1rZO6LaaGQ5/sL+OvzXQtRc6zmTDwJj9uxtK2Q5OIqVn
	hU+mPit2+H1Sa7XfBDg/yLhLiGqdW1pMXW5HrLZZbYKnKmaMy/x7Dc8ETCHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790104573; x=1790190973; bh=750SnI1fyQumrL87nu3KpcqDkHzWJrxdwAA
	Gj+AT5qs=; b=eRoER856xZ/FeYa51vZwDJiXamRHqBGdFZv0Yrqvtiwu+1dEXzd
	0sSQ6rB4GamfQjmbpy1PwZfsN+nS0XyVfm+sWvhaUvTA8MNBQ0LrVb8iEhU2Aplt
	GrE7fLRtgjbh94LtQE6tVFhUWpSsUktbecVf95P0WbP3ZmW1zdNjq5KDHYKLayAY
	qcreaPx1M+aY2uD+/XGj519QOeJ1miny6HX3iiKZ/TOgYIXo+eOxS6lLEB9CLim1
	yoQ/053py2kRZvMn6ccqyyIlA8Z206vhAsXoQRxUOZTMQiy+M1L37EoyW+a30VPW
	FcwS3XgeheCyx+rrQsEHV+RtlEOxBFde06Q==
X-ME-Sender: <xms:_dOyalhbVS-BBILNDjfX_un16HyBfOwI9Z_TKPNHfiyTSPXzc4R_iA>
    <xme:_dOyasnUPI_Sa-r6TBkBJ20fqLi1W5sPucV5HvuQjBNeOzfdTA8per5q0Q9LKbfuh
    5R2aH3ZaZNlqX_CubgGiMm0WmLa7Y_Q32y5XYcxzHC3cccWqkbAS-Y>
X-ME-Received: <xmr:_dOyaosEfaJRWLB9JfNAeN2AwK2A4eEuXbUjltFod1QRFEPzHIWTLNPkD9EhQuQcoccuTHtHnd5gOjWkAIBeEYHi5ztMWo0NTyZt>
X-ME-Proxy-Cause: dmFkZTGpHx9Bp4QtTwapZYEY4SnmxqedtVjnVsH4j/Samg03Qdoms0ul4QOf81z4hZ9gjh
    8+ZBRPnX0aJbnAnDTYK6/BSN+qrIcrmXJXCPo1kg8JNdCJkEb/Z2ooB099Yw6Hsv9EQid3
    TkWtVxcv5OdnRRDqcFZxEu/Jpzf3dgpyG/SvpwoPuM9Gx5+qxv3H++lirLhJBEWMSsSLu3
    CeSwRfOGOj19UnKg7iF7q2xk/O8lULyQmIcqY6QR0Cu5nsW/M0T+StlxzcbDxK0ZVxTVqY
    4WPFo5q1Vz4/o6FxhG9c2ikoJo/8EQyiu2fzoMkIS6X8ccRJKmxsXc+y8bf+0r0RtXSpei
    3KP6epQsorFTp7pByN7q/Wb2WQbmBrHcJnu0Ncnv6jcrZxDAt44FpFaxDSmkGJ9cntz2EE
    X6U9ElAd1K6bkzOgZOs03MxheLjikK41K7bTi4MWTODO5BVN1/WR/y8QAXY0ezdwndGY1C
    SNLd0JS3iyRPa2HPGuDA3OLkZI2x+17+a5pd+fH+KsbDv6EEeApKY1JwIjDJ/e4vZwgEOk
    HjgHJG7/oi1NQ0adanA5OKUDu+zeCsq20n2qhnZiiuXzugNZ13nMSMkEE1/8XVR8DaKD2R
    85Ufa8hFXBMvVvWsNMsoouWAXvysQxBL2qVS6tE9UeOn9HJUfs9x4p1R8a1w
X-ME-Proxy: <xmx:_dOyaqaGAEmnUmnOwNUBoqjz5KQydmScxIUN0Dp7De8wcMURODlOwA>
    <xmx:_dOyaoCouiQ2-l0Mn1h1o1B3YvPh5DxEsO_aYpGl8IlzKdRf2XydBA>
    <xmx:_dOyaq90fr4RWu3AodbcVyOxbRJCnnXg7Jaq6XI7bqR9grGmmuFRsw>
    <xmx:_dOyasTkB9WDJ46kvQxor9Of5aPZfPN6ynCGWJ19SRj2lzcV_hJh7w>
    <xmx:_dOyalMV-Bm93I9Gdb1nJ5ZGzy0LUxrCb_GW4y6LBagWbCNTvG4yW_5O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 15:16:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Phil Hord <phil.hord@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  "D . Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 3/3] fetch, remote: retain old OIDs when pruning refs
In-Reply-To: <3f3062252ac1aa057b9ee9a2dd9892e629ba7a82.1790079917.git.maciej.ciemborowicz@gmail.com>
	(Maciej Ciemborowicz's message of "Tue, 22 Sep 2026 14:26:09 +0200")
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
	<cover.1790079917.git.maciej.ciemborowicz@gmail.com>
	<3f3062252ac1aa057b9ee9a2dd9892e629ba7a82.1790079917.git.maciej.ciemborowicz@gmail.com>
Date: Tue, 22 Sep 2026 12:16:11 -0700
Message-ID: <xmqqeceldrlw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

>  	if (!dry_run) {
>  		if (transaction) {
>  			for (ref = stale_refs; ref; ref = ref->next) {
> -				result = ref_transaction_delete(transaction, ref->name, NULL,
> -								NULL, 0, "fetch: prune", &err);
> +				result = ref_transaction_delete(transaction, ref->name,
> +							&ref->new_oid, NULL, 0,
> +							"fetch: prune", &err);
>  				if (result)
>  					goto cleanup;
>  			}
>  		} else {
> +			for (ref = stale_refs; ref; ref = ref->next) {
> +				string_list_append(&refnames, ref->name);
> +				oid_array_append(&old_oids, &ref->new_oid);
> +			}
>  			result = refs_delete_refs(get_main_ref_store(the_repository),
>  						  "fetch: prune", &refnames,
> -						  NULL, 0);
> +						  &old_oids, 0);
>  		}
> +		if (result)
> +			goto cleanup;
>  	}

Hmph, I may not be reading the code correctly, but the last "goto
cleanup" in the above block can happen when refs_delete_refs() call
that internally uses the best effort transaction sees an error.  If
we were about to prune 30 refs but failed to prune one of them, and
if we are running with non-negative verbosity, don't we still want
to make the "[deleted]" report for the 29 of them and possibly
report "[failed to delete]" for the one that failed?

>  
>  	if (verbosity >= 0) {
>  		int summary_width = transport_summary_width(stale_refs);
>  
> +		if (!refnames.nr)
> +			for (ref = stale_refs; ref; ref = ref->next)
> +				string_list_append(&refnames, ref->name);
>  		for (ref = stale_refs; ref; ref = ref->next) {
>  			display_ref_update(display_state, '-', _("[deleted]"), NULL,
>  					   _("(none)"), ref->name,

> @@ -1639,17 +1650,24 @@ static int prune_remote(const char *remote, int dry_run)
>  	printf_ln(_("Pruning %s"), remote);
>  	printf_ln(_("URL: %s"), states.remote->url.v[0]);
>  
> -	for_each_string_list_item(item, &states.stale)
> -		string_list_append(&refs_to_prune, item->util);
> -	string_list_sort(&refs_to_prune);
> +	for_each_string_list_item(item, &states.stale) {
> +		struct stale_ref *stale_ref = item->util;
> +
> +		string_list_append(&refs_to_prune, stale_ref->name);
> +		oid_array_append(&old_oids, &stale_ref->oid);
> +	}
>  
> -	if (!dry_run)
> +	if (!dry_run) {
>  		result |= refs_delete_refs(get_main_ref_store(the_repository),
>  					   "remote: prune", &refs_to_prune,
> -					   NULL, 0);
> +					   &old_oids, 0);
> +		if (result)
> +			goto cleanup;
> +	}

Ditto.  Beyond the post context of this hunk ... 

>  	for_each_string_list_item(item, &states.stale) {
> -		const char *refname = item->util;
> +		struct stale_ref *stale_ref = item->util;
> +		const char *refname = stale_ref->name;
>  
>  		if (dry_run)
>  			printf_ln(_(" * [would prune] %s"),

... around here is a code that reports "* [pruned]" for the ones
that we successfully removed, which is now ignored when even one of
the bulk removal fails.

