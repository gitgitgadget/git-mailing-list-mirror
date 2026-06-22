Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAE33F582
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150694; cv=none; b=VpxPVzeuLR7ruWWQfCjceYJeRYKqB9jn1dHn8C9t7/ZOTiOYoDU0wIhEDihkJO3G91UmBBZ0kTJ5vseRkXjLhWK6nd/R/BAX4xTHThP8sFqAOmaQW2LKTx8k4AsBWKFs5JoVfBZPSFMPRkWeaCYo05/6/kUKca1DhUT2R3y7KbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150694; c=relaxed/simple;
	bh=zcj+88AMQSXz3/f3uqdnFwytVLgBp3aMSsaWwlcK+sw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GfZeF7C3pRjg3ST8+m730JeCVWBuGfG1JftqGnfMzfFMHEcGt7tvMG/scDP8wWZCNsdsqYW1hZuJu2L8IzA3oqbcMJvKXgbFEzt8Pd2Cne729sZwGZziHrWyw9NOLy1R3DXXKvgGl12xe8rM4D0758CcdyXmSKkT0bFshUiUQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c456Znu9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixnfD36B; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c456Znu9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixnfD36B"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A934514001FD;
	Mon, 22 Jun 2026 13:51:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 22 Jun 2026 13:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782150692; x=1782237092; bh=91BsaZNUHu
	M31c5/hnLqCE7KyoeWtaMKqCadkZ6yDmw=; b=c456Znu9WhDZ0Rsh/3by1bTpfi
	KFjv139SOTzPxvolEHj8Ul2igd783uJPRy1k0vDZxU7bQTieObBD4CarZWEQC0oJ
	84V9uV6aY8uPcLEX5NotU0g0G45AsYofmAKzyUxJ+fWFJx/hWU19MGDLk3RLihTN
	MIfmreJ7PZ5bsIQ2UhyigVexubQYv/jBDEYQdHp6kHO6DxcKXVXL++IBzq6EzSlE
	V+Fm64vurN0+h3E0ZQ/MYfqe+TYNRERhyvDkjtKkj+a/xUMljEg0gQ41Lc5fKsvv
	kTr1XnPH4ElrpTIjof6T5uvUbNYt+NYxawCLzDc0zF5KchsSdqb1FPK72XFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782150692; x=1782237092; bh=91BsaZNUHuM31c5/hnLqCE7KyoeWtaMKqCa
	dkZ6yDmw=; b=ixnfD36BObChvOAtnj5VmUB50H9NQjG5csSzLMngytF1hFvqRT4
	o1bYGw0M9/Et20cF7Rs7xxwC+P6z7ToAC+6Np4o4tL8DfmHwXHjRzFZXwR04NBfU
	9Lfuj7JdRP22BpoNRjB5CctoYtcnyJdFfChB8ISPlCrO2FLuIXVU8tHXqFrDkxSU
	ep2bHV8DG2zDYIrXItErkS5Oqs2R3V/dDIrJ/3UtAY2RXtXVOIK8We3UGiJGRTzz
	UpR3kq9JhJ1bfUqnTPYS9yEr7gFnrqGFMGRKxl1zHk8gljeum0cVeMX6ZP/xBiiz
	8tjG4l4wFjsh3gSNvK4/279gVd5N76yEzhQ==
X-ME-Sender: <xms:JHY5aoSVru_LL5oWWEYgSrqDEOaB8CKcSXLKmUqQ_JIJxH4U1SMRBA>
    <xme:JHY5atM4LOdtH-NTPoxRRMYpeQ9Ki8Te68G8Yqa7kfA-GGR4SF_ZgwGB3iMblRLtd
    6s2Ycnb1o03t_joVuy8NBg6p_3iFaRboteJyvXgk8ZiBVYFA2qZIQ>
X-ME-Received: <xmr:JHY5ajPM47nlA9Mu-FwFPgsjSmaPDNPchID08eXU2k-C_YVYPjJiHZ9vw61BhcF9Vjo1Dg8Zhw3j6ioVQsawcABftb_GW42YT2fyQ0s>
X-ME-Proxy-Cause: dmFkZTFomkJb8gaUvEsKRNc7ipGb2ZnawT8TygDYGWKolQXAP4lqsKnCyi9KcwEEnlUGxm
    IdrCqUK0GfxCfwogFWzNYi0KqzSC5aTo+Y+BS/i2kR4EZND4gqb7gzPqDVpSYwWxbIoxtN
    xhLUXR3+f272zS34nCWCQ+GKkDX4yvNQ1gq6WcClyRc7IQaBrV71fmaKXY7tmIARE2Z5Jv
    hLgNhSoxxQOGbaiKyjnVuLjoPZOSrC/NTmXzGVdtw7ztt+If5GpvUmv2q+rCeM2U8dh7/9
    BobdgOtEkBCGmjjA40+j+Hp+YIt/Gke+Juri10+f7QY8v40mUAXM+GJeNxUKt6/yKCU6K1
    RRd8g7iIaL2MrOnnD+6mWtjUrNzBQ5D4fMPZF2fTNxaUrGWlSR6Ns6E4N+DVLsxGbEBPAm
    nsR0loJ++gq3Qjct+owXBMkTN9D5dDdq52XA4P4c4u9FPBYlfo+4U8Q11TDoUUj0EvHMyT
    wOXw0pdQKGddElO47IVEgV88G+8GyZckjJUsASMLyCKbw0s7J/LG5akB14zP2QSjgH4xzk
    9uCecrekO5R3MMJraJQ3EI1LchF1EbXaHzdOob//szKyekXW4tc+6h/YgFgOBKJW/4U6f3
    UX9eWCoNUMk/zzLv0Pc52JXqaVHA4O7KXbpkxlQ6HX9YJaL2Roq2i7BYxcUw
X-ME-Proxy: <xmx:JHY5altHQjEhlZ5k2sobbvklNpgzxj_CbElkPTyFf6swFDmitWF2vA>
    <xmx:JHY5alWfmaESPlFHMRr-Kq1D4Uio2shzpxfbrfTXBDvATfPBtyBEzw>
    <xmx:JHY5alu2fHZv983YSY1XGvaziIQFCTDi1vV4UNw6Zqr3Ns8QxGVHgQ>
    <xmx:JHY5apVwpvLQrluXsRKNZkuo01tTCz85N-mppNieuw8C1Ua9pVkj4Q>
    <xmx:JHY5alWMS69f9BWy1Wci4JAdpFRH0GNqbI9Zv44w0P_2q2nNKapROuhH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 13:51:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] odb/source-packed: extract logic to skip certain packs
In-Reply-To: <20260622-pks-connected-generic-promisor-checks-v1-1-25eba2698202@pks.im>
	(Patrick Steinhardt's message of "Mon, 22 Jun 2026 10:49:27 +0200")
References: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
	<20260622-pks-connected-generic-promisor-checks-v1-1-25eba2698202@pks.im>
Date: Mon, 22 Jun 2026 10:51:30 -0700
Message-ID: <xmqqa4sm1n19.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The caller can pass flags that allow them to filter out specific kinds
> of objects when iterating objects via `odb_for_each_object()`. This only
> works for "normal" iteration though, as we `BUG()` when the user passes
> flags and specifies an object prefix.
>
> This limitation will be lifted in the next commit. Prepare for this by
> extracting the logic that skips certain kinds of packs so that we can
> easily reuse it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-packed.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)

Quite straight-forward creation of a simple helper function.

> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 42c28fba0e..3afc4bf01f 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -126,6 +126,22 @@ static int match_hash(unsigned len, const unsigned char *a, const unsigned char
>  	return 1;
>  }
>  
> +static bool should_exclude_pack(struct packed_git *p, enum odb_for_each_object_flags flags)
> +{
> +	if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
> +		return true;
> +	if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
> +	    !p->pack_promisor)
> +		return true;
> +	if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
> +	    p->pack_keep_in_core)
> +		return true;
> +	if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
> +	    p->pack_keep)
> +		return true;
> +	return false;
> +}
> +
>  static int for_each_prefixed_object_in_midx(
>  	struct odb_source_packed *store,
>  	struct multi_pack_index *m,
> @@ -306,17 +322,9 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
>  	for (e = packfile_store_get_packs(packed); e; e = e->next) {
>  		struct packed_git *p = e->pack;
>  
> -		if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
> -			continue;
> -		if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
> -		    !p->pack_promisor)
> -			continue;
> -		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
> -		    p->pack_keep_in_core)
> -			continue;
> -		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
> -		    p->pack_keep)
> +		if (should_exclude_pack(p, opts->flags))
>  			continue;
> +
>  		if (open_pack_index(p)) {
>  			pack_errors = 1;
>  			continue;
