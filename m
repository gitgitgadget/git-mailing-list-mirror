Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF8215055
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287302; cv=none; b=ntc1/iYUt/IMpGOd/IaLzTcxiE2daN+mm2VqQeNx59pcDyZVhMJhwHZ23cBN3QjIqq4c2ICCh1ya4eLlJvSlMlGzD2r22A5MWVMJE9g/4e1pLU+potYefwRLjjPkVWPxQbzskk9az/bIl0DVIlcy4QU6jY7LDmJwzEntA48Ejcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287302; c=relaxed/simple;
	bh=5jRSJio9nd1qWYAIHH+i9MihHx4hNITQ3cXZPojVE2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVy217+2bnRonpl1Y08IPH6/kCZEFWyzGM7ucFbAzaLoFyvu3UDnpFcfQiDKVQNZhIm2I6nqiro53xZPY8TD9yLi2Ij25mhHa1Lp7RtSaNsXbtcAhJkymgO17dNKB2PQAPxFKMr0l4qzQnBUcCdta+EYFLyzaAzCIBq2oJNwI9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ikoayONd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fdmP8Sb0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ikoayONd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fdmP8Sb0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5AB74EC02BF;
	Tue, 13 Jan 2026 01:55:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Jan 2026 01:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768287300; x=1768373700; bh=p40gz8Ilzm
	jd97sRhfNKiFxGSIHduF8sXQzST/e8RVA=; b=ikoayONdbJJalYhfzNmWD3pHVd
	RqfTstBRq37/2/baCt8MDHtm9h3cYGM5TQ6tx3GNPhZpm5hr2fj3u0H0lsEq42lA
	PDqc/OQHpG2aHHaTmZC0hBCwsC0hFUGir4SCN0f4KxdO+oPj2RCBzshjBpc2Ersq
	BDrZPlEms29GReI8jxtYoxEIS+yGBl3lNBR211N9bsW1r6rqP7f89EgUwalruTby
	LOiJr1jWupoSxMAzWRe/5uZHk0Kdu9I9OLLCxjLoAYNWoXZghgDHuL3Ly1HkDAc7
	odTB1pq3sjpCirFUES+62mYWspQnwaz57TCkbBUqaZgtH0VXz9TUf8BxWKjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768287300; x=1768373700; bh=p40gz8Ilzmjd97sRhfNKiFxGSIHduF8sXQz
	ST/e8RVA=; b=fdmP8Sb0KNmoDgD3t6irPhMX9asJaWaA2AigsF3wVepFeG40YCr
	4KWrHMpdB58PuT468P897Pwo4WUsucyeZBoU4pq2NdxzdK+g8owS5jc0dYz28fFu
	DMhAHuwX4HL92AQb/q+cEg2GuoPFmSJpEHk6L6DoLB2Ngr8gN0urdrZHpBWcxPFl
	6WFpezMA+a1sYaCJfFhYKxvfkj4o9WA3XW2QsJx5QFCPxK+qYYIqeXoxGmrcW4ql
	uwPT1ZUZtiehOXSf5MYTZBW0wOXCgNyR8Tdgvaea5FQPJWuHxLaaEQNEkc/zN0yN
	f9y6v2tFpLyCayVqM893QwjP8DrjcUD4s/w==
X-ME-Sender: <xms:Q-xlaWrkul1GKBWvc_zPxuXC2eZuz-OTqi1AxWoEOuJkarBp2EZdMw>
    <xme:Q-xlacF0VAEvRpSt5RABsBdaNW4mk3ULJc9Xcfomkp8_-WIGMUpynoonYr6I2fq3z
    tzAarPOSMflEdfaPUbaukJmfR4Iu7XnSwCJEf89o1Fj1RETikwLlQ>
X-ME-Received: <xmr:Q-xlaYkkRaYNEYmO-FrjjWs1tJIeMUGcs1MYgblgmmpQxRNs59JpxPFGuXgHm7Spqm2ehKpAWinOhm3IKZCpytzqd5kn06GME1JfcfNN0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhushhtvggusegtohguvggsvghrghdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q-xlafknWk_UnaJW9yE1MpQl1-ai8TxfeJ-cj1C1w98HLJLJBeKaqA>
    <xmx:Q-xlaZs2Ovt20HhF2HpLIlxyCcBL38boBxKf6USl5_whkqCQpYGBDw>
    <xmx:Q-xlaSkDThCfVvnTB6azumAWF_ksin30lyB7fmHL8VSbgQVy0R028g>
    <xmx:Q-xlaUs4re1WT2pFBXadMjc_cYx-aEesLmVe6sNFZ06SVyBtuO1G7Q>
    <xmx:ROxlafSW0x20i-qT7kffGaiMWWVi5N8_xZC7XA3WsglQg_gl_8pNxn5U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 01:54:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08587878 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 06:54:57 +0000 (UTC)
Date: Tue, 13 Jan 2026 07:54:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>
Subject: Re: [PATCH] last-modified: verify revision argument is a commit-ish
Message-ID: <aWXsP1GJ2YfrZyh0@pks.im>
References: <20260112-toon-last-modified-tree-v1-1-ecbc78341f76@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-toon-last-modified-tree-v1-1-ecbc78341f76@iotcl.com>

On Mon, Jan 12, 2026 at 05:17:41PM +0100, Toon Claes wrote:
> Passing a tree OID to git-last-modified(1) would trigger BUG behavior.
> 
>     git last-modified HEAD^{tree}
>     BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified
> 
> Fix this error by verifying the parsed revision is peels to a

s/is peels/peels/

> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index c80f0535f6..cac94e384d 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -145,8 +145,15 @@ static int populate_paths_from_revs(struct last_modified *lm)
>  		if (obj->item->flags & UNINTERESTING)
>  			continue;
>  
> -		if (num_interesting++)
> -			return error(_("last-modified can only operate on one tree at a time"));
> +		if (num_interesting++) {
> +			ret = error(_("last-modified can only operate on one tree at a time"));

A preexisting issue, but isn't this error message a bit weird? Below we
assert that we've got a commit, but here we say that we expect to work
on a tree.

> +			break;
> +		}
> +
> +		if (!repo_peel_to_type(lm->rev.repo, obj->path, 0, obj->item, OBJ_COMMIT)) {
> +			ret = error(_("revision argument is not a commit-ish"));
> +			break;
> +		}

I'd prefer a `goto out` in both error cases, but that's a matter of
style and thus a subjective proposal. So no need to address this.

>  		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
>  			      &obj->item->oid, "", &diffopt);
> diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
> index 50f4312f71..d0d52add05 100755
> --- a/t/t8020-last-modified.sh
> +++ b/t/t8020-last-modified.sh
> @@ -235,4 +235,9 @@ test_expect_success 'last-modified complains about unknown arguments' '
>  	grep "unknown last-modified argument: --foo" err
>  '
>  
> +test_expect_success 'last-modified expects commit-ish' '
> +	test_must_fail git last-modified HEAD^{tree} 2>err &&
> +	grep "revision argument is not a commit-ish" err
> +'

Do we have tests that verify that this works when passed for example an
annotated tag?

Thanks!

Patrick
