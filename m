Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2E414A20
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834917; cv=none; b=JOSd6HKvvIRcCYM2WFMzwOmAdmhvcHr84ri2y4bvXFsUi+SPG6d9RJM+s9FPFuW7h0t8r/uKfcxMg9w2Fqvn1H9kojwHVH5x2VFKAtXpnUAPijjVkI1Rg3cQjgizzUWdj/n+XHeK58aWkVxJVrYKf7AfezVx7ilPv3EOCbgSgvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834917; c=relaxed/simple;
	bh=MvfaV67eO592L32rk0s/7T/ntZsmkJ1xsMXMCmzk+uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HklSlb3a9mArxg2czJlPTpnpoc92HelUE3SM5Ts0XzssSGqVChIjRbitKyfiB/d0iOyCpjUpwH7boGssHK/gNKr2HFstn3SiQf1T/3Zz7+3YUs++/EOrgTcWynA6NVnsbWPqFwsMnnjfvS2RlM2vICZ08Vh6sjl50YnV/eWJ3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jTWZo/Dr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u3/FAO4z; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jTWZo/Dr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u3/FAO4z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3346F1400094
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:55:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 12 Oct 2026 15:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791834915; x=1791921315; bh=b6+3JvJxJK
	vUHeiMO+jjpOHxf9Y0LDW7LKG8T92tBYk=; b=jTWZo/Dr8evtC0Za4qlmLxkJiT
	CAunGgSVn5SVOddCTO3pdvXqRTsHnjLnKTxvJEojK5GdT0QTpoDAB0Vqy8G9tsSB
	rJdSUzHoJSP+HPpQmRn4MgTsV4OijGyo5Ei4JQ22wtfWCmBCtfgyLwdcsJZyOfNd
	ru3hBkIOLwl49UacULMOMwxUL+g28TTkTuxJVoZT8RPyQv7C4kU3tuBfi2dXrc7R
	d0XJQb3nlCqiosxCzuALSi7MEP+k01sKkK/JvUlbiTdwQbiDM/EvdfP9dhcW6f8B
	6hCYbh9YPED4xy4P26mUP30Rool6yuA7typ3ywRKbwFnhheGisDhp5In751A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791834915; x=1791921315; bh=b6+3JvJxJKvUHeiMO+jjpOHxf9Y0LDW7LKG
	8T92tBYk=; b=u3/FAO4zMTenZVrM213yrlZ40eSIY6Enr+j3ThgJRFKzISWoqil
	lG+0ty6MRDE7xFZnRKG4j/VH3MoZI3XLCHKsKkUe4ODfmCoHuBTiqjnF2du3nBMh
	A6y8e0Cp5LXwFWPTWO4eIQl33AY++QNHdk2vcej6UDlPreAN4P8DfZjaemSM8TOi
	rMT5VPSkL7I3PFANpmXwsLnjJxUxzd1zyC2ziYOfC3/m/5qbHtrcqF6bJ5SrdSwg
	LCXT9+GPZpk90mBXexl+aoupiEmLxsJz80Pg+p2XgcQoQ9igSElHaiThk+Iuk8ZO
	cwF0QdpJ/8v//xOXz2VwkMic0s/Z8WbxOug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791834915; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:cNmVIz840xPnsbpT37Ma+iX6n5ZWA/7WDnMNQ1rc7CFbAj9
	lG7HZYIDyDn0yNNBlzR6rkhamWk/qKp7FTuSEn2cLnbO6cI8Jkn9rqyAlxyfc/0a
	Ma5paXUvXMs4+rpBEOI7UIbl86L4jW0L3fQTOQg1TRVL0RQsVGcaUb7qqh9GgYVK
	uV93RfJ02AGqKpTKWw5vVU6JXFvICIoFwc0BY9hnfdyqOeQLkiKxyFX+d27bgYj7
	JyO9iLf0v/rlryqtH3SCBGex0a3Bu5T4nasxIHjtPaO0BWgPZbTLR//Pvn3oaMBB
	+gwT5zYD1g4Kn+JFnRrixv1QxGtB6heHeQmPFKQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3ACyv0XM3Sd8kUUz40tzDCV+1I3ni4lxtzny0pjRm8A=:MvfaV67eO592L32rk0s/7T/ntZsmkJ1xsMXMCmzk+uo=;
X-ME-Sender: <xms:IjvNasO2ajqr70BJecJk_IaKoXo5CYw4hl7XdjnaEyvc3Hsn1lbbSg>
    <xme:IjvNampE2ExtDDWKThQG1xfP85r-CFwCcD2UBhxW9Zxsa50Ke6-Fv8jVSP_9D9wps
    fcYOQj61WMFwizlO2rzv6OLbuemHzQB5yrtW1gu4X4NDeIxfND3yveC>
X-ME-Received: <xmr:IjvNatG3B0whIa7iUQAYVNhgReCNBJFxLyIR9pITu8YnJ82b69NJnLZoFoz-jUxJFGL3eNNIq5iNqkZoctLi1CRhBZFJf-RV6X9I>
X-ME-Proxy-Cause: dmFkZTGNM1wddiK0wwf7GvBXgly7i5lKB1EmtJ1Ki0tvVXGQABHl5FMckYga7lhQpi+76m
    bvNKMy9e3G7NX+ORlQ9wyktkXLKjNfhK9PlypSzlPx7y73K7Vw1c+CTZHiKB5lRxPnfXHR
    d2HsmLQkp53f6+mnW1JyLnmwjae5uDr71GFqtnwsqGHRR5AWwe1eNMuf3kDIYfo5LZgQo+
    mFBF7qjVkney92AAHgHKz4Ej9KjKzNTiwqJDComV5VG7It7bnvH5hiHrN8uzSHX7s5uzXe
    O0JtJ8YwRsL/aqtFhnjl9B0pjINhqxs1Rb+slxVDL6K219jlS/QKPBDnTmh9mtv/DdGiLD
    DuZwDRRLYEnomQy4mCOd96Xs5MggFtXlOjs72jq5vv7XPwTtG+pwLfXh1HPD0WNECfTA9g
    elYcMvuW5AfMInGBETTiLy2r2K2WN504ZFNAOw0vXwGoAA8TmG9BkmVmxzSrAtFTMFN7yJ
    Vl3yZo2qXYE2VTknelNrA2hCBsrgiB/AR4JMpaJxdbgnAPmpWVNoqakF885fMSLFZhYwW7
    Dyhwl9A79bMTJCRfCZ/JkcMJ1bf41eJyzkviENm8Zgd/IUY19Cqe05ePXiclIRf9yg80b1
    nh4kCL30hmPy/M8Nf/gy46TTckFk4mCdNo9IqQCQccgeL0QNv2Rc5Rd0qvCg
X-ME-Proxy: <xmx:IjvNarp5COVf3MuUwHZ3tI3k2jl4vkEfRmY2M8oDvz-zPArR-ci2uQ>
    <xmx:IjvNama_5gvcHG4X8mPWcsWCPPMA-ZT_CLmNp_2dHMc6YWCr1UCEmA>
    <xmx:IjvNakVBbdYX--QZyzpA8iAuoxFXt0Q69aJZvoG304WKJBHXrUJqYg>
    <xmx:IjvNav8-zYSWBpvl2KQ8JOwC7WWEq7MIcLxOOjJnyhvjotydO05YgA>
    <xmx:IzvNako1d9HxzfY-7-j5TK5fmqUahQ21O0nPvBXAneS9n521PdELK6Gz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 15:55:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  Mitja =?utf-8?Q?Bezen=C5=A1ek?=
 <mitja.bezensek@login5.org>,
  Patrick Steinhardt <ps@pks.im>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2] fetch: commit references fetched before backfilling
 tags
In-Reply-To: <20261012-799-shallow-fetch-with-tags-v2-1-4211e9a13d3c@gmail.com>
	(Karthik Nayak's message of "Mon, 12 Oct 2026 17:29:17 +0200")
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
	<20261012-799-shallow-fetch-with-tags-v2-1-4211e9a13d3c@gmail.com>
Date: Mon, 12 Oct 2026 12:55:11 -0700
Message-ID: <xmqq4ieq66e8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> When using batched updates, the references aren't yet committed to disk
> when we start backfilling tags. This means in situations such as shallow
> fetching the negotiation during backfilling tags, the client doesn't
> have any references to report in the 'have' section. Since backfilling
> doesn't use a depth limit, this can cause the server to send all the
> objects present in the repository.

Ouch.

> Fix this by committing the previous batched update and initiating a new
> one for backfilling tags. Also add a test which captures this regression.

> @@ -2076,6 +2076,27 @@ static int do_fetch(struct transport *transport,
>  		struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
>  
>  		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
> +
> +		/*
> +		 * Backfilling tags has no depth limit. If we don't commit
> +		 * the fetched references, the backfill will report no refs
> +		 * in the 'have' section of the negotiation. This can cause
> +		 * the server to send all objects.
> +		 */

Does this problem only happen when the main fetch updated some ref,
or can backfilling make such a huge negotiation even when the main
fetch transaction is empty?

> +		if (tags_ref_map && !atomic_fetch) {
> +			retcode |= commit_ref_transaction(&transaction, false,
> +							  transport->remote->name,
> +							  &rejected_refs, &err);

This block is entered only when "--atomic" is not in effect, because
we want to update all refs or nothing, and these "all refs"
presumably includes the followed tags, but does it mean those who
want atomic fetch should be prepared to see their fetch degenerate
down to a full clone?

> +
> +			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> +								  REF_TRANSACTION_ALLOW_FAILURE, &err);
> +			if (!transaction) {
> +				free_refs(tags_ref_map);
> +				retcode = -1;
> +				goto cleanup;

Is this jumping a bit too far?  If our primary fetch have finished
successfully, and opening the next transaction only for tag backfill
task has failed, there are tons of processing happening we skip with
this new "goto" that we would have normally performed, starting with
computing summary_width used for later reporting, writing out
FETCH_HEAD, and setting upstream for the current branch, all of
which we should be able to do as long as the primary fetch
successfully finishes, no?

> +			}
> +		}

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 300bd5396d..5ba372fbcb 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1942,6 +1942,22 @@ test_expect_success "backfill tags when providing a refspec" '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'shallow fetch does not fetch objects again for tags' '
> +	test_when_finished rm -rf source target &&
> +
> +	git init source &&
> +	test_commit_bulk -C source 10 &&
> +	git -C source tag -a tag -m tag HEAD~2 &&
> +	root_oid=$(git -C source rev-parse HEAD~9) &&
> +
> +	git init target &&
> +	git -C target remote add origin ../source &&
> +	git -C target fetch --depth 5 origin &&
> +
> +	# Should not fetch objects beyond the pre-specified depth.
> +	test_must_fail git -C target cat-file -e "$root_oid"
> +'
> +
>  test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
>  	test_when_finished rm -rf base repo &&
>  
>
> ---
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
> change-id: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0
>
>
> Thanks
> - Karthik
