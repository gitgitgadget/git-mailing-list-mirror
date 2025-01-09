Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E302B9BF
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445460; cv=none; b=WkYH5+7Z2M5zVd6hEWkovILPFd2I+ExEg2HEEhnNEsuzrn5bXiPeWL+kFJz6OdHl4EUoLOOyl0BCjvyRJ+9NobB8nNncNZ245bkzL5iHRdj30G1BARn/dqfpNa5h+/Ub4a19q/iQK/Axc9i9TuLzR1DymwyrlHdHx50Yt0RQWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445460; c=relaxed/simple;
	bh=7o8v4Sz0mvgwvSJi/foFoTCXcZjZZ7TEO+LSrKo08aU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLeoWS8SXbBsg1fAnxnRcEKjfpo994USXoQvMD6pSpajPdBQF6rGvsVBeH6UrCuRq+pdI55l+c6T6PhYcgXkCI1xhAcL/FcPqiN5pL9uycxEISHmZtLAoXaJwP5csd0BdHjC7FM4NZmOmgossMYS/v6ZU+jdJjl2k1VGgyrTXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zA88d39p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xtjrKjk3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zA88d39p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xtjrKjk3"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8458011400A9;
	Thu,  9 Jan 2025 12:57:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 09 Jan 2025 12:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736445456; x=1736531856; bh=vHqRSS20wt
	lPFeWnSPTeQ4tYCzDnGqi1GeR5iGCon80=; b=zA88d39p70c5TuyB7mY8cQXLLV
	3Z90XBERgGzFXCQXpcU0tpgLYC+bVj5vgTF0o8aTLl7diYbTpc1tyCG9x991AlV/
	LnHIDcw81rf/ilNUPJSGXl63o2/fmdNzxmpb1iKtM15MKM+hrTBZRecgudmRvHH9
	O779pIlYzEX/WEwQzWFB6OxWxEdsj6CiN58wQCWyIjLOdFtdJfCtyNHuVJPOT1xP
	SSBJsfIgPkWL+rAmJ4P/6bF/R7Nk5qhs38/TtR9gSmFNbnlaam2H3koq/zvSQdRQ
	9QaPTRNEZnJ6AbVmc38FCuKiva35w2Yh+7UOJ+PqbFDMGUWP5d5C9JsgWsew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736445456; x=1736531856; bh=vHqRSS20wtlPFeWnSPTeQ4tYCzDnGqi1GeR
	5iGCon80=; b=xtjrKjk3ABJQnavzjxHNSOIgm/IcgVbQdY9UNBa30X49NpHK7hs
	NaKNRf2tadCsRlwiCTyeRyPEs9U5sA/Bb1qZP3xbNU/BohfziU9Cy42zm7cRYX25
	mfWq5g4BeOeo2EIXp2bjoDpx8l0+vUI9nSXDvcdxPc2OP+sqmtfnZ+Gv8Z/IkQ2n
	oRKyFITfkkZT0VvCxvekDzY+fL+ZD3ZY+ZTPrqEJMWoASDInm5rISiXCN80VQX4b
	lMxMHwYDUvlkrboYOZzdNZ19xT52IOzm+78i+K7z9W2vVUlMTydbXzKaYQeBln9d
	XEpGLLY2k4JesJZPmhyvWJa1rawbdCTGKmw==
X-ME-Sender: <xms:EA6AZ4rLOGhWru1bDeVXBai7EBMSPerTumqSamzm9DkhzmRlcy3Aug>
    <xme:EA6AZ-rBOv5G5dSVQMKort_Hcky6nQ015xhQZTzE7Wb98O-Y145J4QiUUV-zvwtyF
    qefCc0mTWMrjXrpEw>
X-ME-Received: <xmr:EA6AZ9MkVbBfnsSPqluD5uwY7FBzbNXP21MKWFNk71XKpWZOmQexAqDYnwQhJ2fczmOIjyFpnCI1ved85q277Idw_NMiwVTUNUju>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopeifihhnkhesshgrvhhilhhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EA6AZ_6rvcRkpz2DWyu2ezkvkQwV3TZzCci1PpjVosQZHxXuMRojLg>
    <xmx:EA6AZ34ztDsMQCHqSCdgGQXgIAbFW3TKs6xuDu7L5F5wszT5vu4GRg>
    <xmx:EA6AZ_i8C48MGX7mrf41hGSOFt8qxG4v3hWG2sVleLj1fohlkcRiUg>
    <xmx:EA6AZx7XAyudpp8CKYgfgXg7fAzmONwnO-hmTyAsVr5y-7EXabo29g>
    <xmx:EA6AZ63rYfwphOE2vrSQrsWG1EO3UIkAUNgsLG1ffDztLeW_Q9Wp8Df4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 12:57:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>,  Wink Saville <wink@saville.com>
Subject: Re: [PATCH 01/14] run_diff_files(): delay allocation of
 combine_diff_path
In-Reply-To: <20250109082818.GA2748836@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jan 2025 03:28:18 -0500")
References: <20250109082723.GA2748497@coredump.intra.peff.net>
	<20250109082818.GA2748836@coredump.intra.peff.net>
Date: Thu, 09 Jan 2025 09:57:34 -0800
Message-ID: <xmqqwmf3j2ep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> While looping over the index entries, when we see a higher level stage
> the first thing we do is allocate a combine_diff_path struct for it. But
> this can leak; if check_removed() returns an error, we'll continue to
> the next iteration of the loop without cleaning up.
>
> We can fix this by just delaying the allocation by a few lines.
>
> I don't think this leak is triggered in the test suite, but it's pretty
> easy to see by inspection. My ulterior motive here is that the delayed
> allocation means we have all of the data needed to initialize "dpath" at
> the time of malloc, making it easier to factor out a constructor
> function.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  diff-lib.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Makes sense.

>
> diff --git a/diff-lib.c b/diff-lib.c
> index c6d3bc4d37..85b8f1fa59 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -156,18 +156,6 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>  			size_t path_len;
>  			struct stat st;
>  
> -			path_len = ce_namelen(ce);
> -
> -			dpath = xmalloc(combine_diff_path_size(5, path_len));
> -			dpath->path = (char *) &(dpath->parent[5]);
> -
> -			dpath->next = NULL;
> -			memcpy(dpath->path, ce->name, path_len);
> -			dpath->path[path_len] = '\0';
> -			oidclr(&dpath->oid, the_repository->hash_algo);
> -			memset(&(dpath->parent[0]), 0,
> -			       sizeof(struct combine_diff_parent)*5);
> -
>  			changed = check_removed(ce, &st);
>  			if (!changed)
>  				wt_mode = ce_mode_from_stat(ce, st.st_mode);
> @@ -178,7 +166,19 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>  				}
>  				wt_mode = 0;
>  			}
> +
> +			path_len = ce_namelen(ce);
> +
> +			dpath = xmalloc(combine_diff_path_size(5, path_len));
> +			dpath->path = (char *) &(dpath->parent[5]);
> +
> +			dpath->next = NULL;
> +			memcpy(dpath->path, ce->name, path_len);
> +			dpath->path[path_len] = '\0';
> +			oidclr(&dpath->oid, the_repository->hash_algo);
>  			dpath->mode = wt_mode;
> +			memset(&(dpath->parent[0]), 0,
> +			       sizeof(struct combine_diff_parent)*5);
>  
>  			while (i < entries) {
>  				struct cache_entry *nce = istate->cache[i];
