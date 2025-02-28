Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBF25CC9C
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736882; cv=none; b=esfWFephHGgTx5KRRaVGUcih66mvT6PArog6hfHPGDfV892w6UAF3+fF5w72jGacgJFSaedGvJYM9rXAkeFSELsuREMdjj+uDHfPtcpphT+z/o5dpXFRLI8tfHSbwaVVuuCHSoz/AEYAH7fLD/x4RTDvYINwW76W2T111Uo4GYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736882; c=relaxed/simple;
	bh=aRRUKDFVBx/Wfim4Noq3eFqFbrkZgRk+/I3wpfdEyAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/QTJsLGYuD4B8y++iXGA+BbwbIu8SU4UfB2IW0vZskjuRzfaBhrRDY8tVsBFuPV/wFCthRllch2bXOJtDqgC6fZbtVR84NFVKvTfnXJVnOOABGaLO+wE3MPdja+BIMq1+OFy5cKSGY6XPSbRDawh0Zsah0WBlafzotImyFLk5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HRnNLU9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k0BbDqOy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HRnNLU9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0BbDqOy"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E9D3138016A;
	Fri, 28 Feb 2025 05:01:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 05:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740736879; x=1740823279; bh=jqMGQ+pOxP
	GkfCibZPvfaOOnyaY5laOVoY/P+QDRSYQ=; b=HRnNLU9whZMsNw8ztZB09LX94t
	1AlNnigGrfHnD1uC6tfHkucKs7vWdWtndWenkWF2ZR9+KLDeBh1M0wjj4EWRhOju
	/Z3WYFC6NeSmbGs+QyGgkIVg5PKYploWv3REZJudtQ1D0vQSLLgmUXyQkUXSdZ6K
	RT6ZF7lNTHZPxaUt6g8ud1jUyeLO1W459sjmAdY2+HlxFIYOGof8GXrWRYIMmC/V
	cDA/VLvjEA2UMvJuJTHoB/vf+b0lCNep8pDj3sHiv3G1YUWLCN9yyL02YT6hYYS5
	afSmGHL5qZM+s/4fawNRn3t8auAuPXaNiXm+rkCHCtuEEq/2FXdix+yzwLBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740736879; x=1740823279; bh=jqMGQ+pOxPGkfCibZPvfaOOnyaY5laOVoY/
	P+QDRSYQ=; b=k0BbDqOyXcy2ohZqJBzxsb7zcK0wMhOkTD0ZB4RcxRQvxEwoAfw
	rCdWGrDt/s8rYp+qOHBpuJKQ3vgldS/An8OSwnaa+l6FKeJxFWumjX8Ymmg2Dykg
	x7qq6EQs/FTsg/5xJQVNclmI5td/lRQx8VJlO1xZ6kwv/+ZO823xSUjLIvFRN4Xd
	gUxR8c7uV7sWz2j8T8FzZXLuP9vW0KtPojVg4qBSC5vVZW/SJET005VN/+2g47Hc
	XGv433VmBPKtgo4FYTm67bdm1gAats7IjmovP6MrR4L/xgrneBD0Hnhw/TRSmoM8
	l2DFNr8RPGjApk3PM8CqBpODOwRzCdFAHQw==
X-ME-Sender: <xms:bonBZ_kKoQb1VmuyjbB8m8qa3QCubatqgk9TV34mVsPDNzB0g4RcPw>
    <xme:bonBZy1-79UtKqkpLi18xxqSHskbPYuHH9TBsTvjVFc1qKx_ws6VXEHe8IJJMBEJ0
    gGxhLl4X5VEHz6Gvg>
X-ME-Received: <xmr:bonBZ1p_MZHxIydJkZzj64QsTI4gXjIq-AYAc7z2w1n54vEmnCT0ckFS6ouBq4ElcW2yeODxncPKUhFQtTBCxO-l-0qjk_4A_987vHRn2N2Zpp8H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:bonBZ3mBWQJVNnVuqLvJDQPGpfbDqmft0fx-g90lSDI86LpQtthzAA>
    <xmx:bonBZ92aPvAXv63ILVZzQM_cNgeeXvBjD3YL2bUf_hBCPdwZ6dTkdw>
    <xmx:bonBZ2sabXT4IHeiNFwZTfOtewTZeQbMKNMxKj-w-YD9xQmBvBHtrA>
    <xmx:bonBZxXzcS8fFQ61vjEQp41q_GeMl0uP65N1QMOAppbm8GZMvTovrg>
    <xmx:b4nBZ1-JY_Ct8870iavlr6kn5p1M6ko5MSxc56VW8l2zBHeekrHOUMK5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:01:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e294c394 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:01:17 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:01:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/13] pack-bitmap.c: open and store incremental
 bitmap layers
Message-ID: <Z8GJbOoY9Z3VMSEM@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <5b5d625cbe02560a20c12b7dd20aeda4979017bb.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b5d625cbe02560a20c12b7dd20aeda4979017bb.1732054032.git.me@ttaylorr.com>

On Tue, Nov 19, 2024 at 05:07:26PM -0500, Taylor Blau wrote:
> Prepare the pack-bitmap machinery to work with incremental MIDXs by
> adding a new "base" field to keep track of the bitmap index associated
> with the previous MIDX layer.
> 
> The changes in this commit are mostly boilerplate to open the correct
> bitmap(s), add them to the chain bitmap layers along the "base" pointer,

s/bitmap layers/of &/

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index bba9c6a905a..41675a69f68 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -54,6 +54,13 @@ struct bitmap_index {
>  	struct packed_git *pack;
>  	struct multi_pack_index *midx;
>  
> +	/*
> +	 * If using a multi-pack index chain, 'base' points to the
> +	 * bitmap index corresponding to this bitmap's midx->base_midx.
> +	 */
> +	struct bitmap_index *base;
> +	uint32_t base_nr;
> +

It would be nice to point out that `base_nr` is not 0-indexed, but
1-indexed, which is rather uncommon. Is there any particular reason why
you made it 1-indexed?

> @@ -377,8 +384,13 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
>  char *midx_bitmap_filename(struct multi_pack_index *midx)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	get_midx_filename_ext(&buf, midx->object_dir, get_midx_checksum(midx),
> -			      MIDX_EXT_BITMAP);
> +	if (midx->has_chain)
> +		get_split_midx_filename_ext(&buf, midx->object_dir,
> +					    get_midx_checksum(midx),
> +					    MIDX_EXT_BITMAP);
> +	else
> +		get_midx_filename_ext(&buf, midx->object_dir,
> +				      get_midx_checksum(midx), MIDX_EXT_BITMAP);
>  
>  	return strbuf_detach(&buf, NULL);
>  }

Okay, this is mostly the same change as in the preceding commit, but for
bitmaps instead of reverse indices.

> @@ -397,10 +409,17 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  {
>  	struct stat st;
>  	char *bitmap_name = midx_bitmap_filename(midx);
> -	int fd = git_open(bitmap_name);
> +	int fd;
>  	uint32_t i, preferred_pack;
>  	struct packed_git *preferred;
>  
> +	fd = git_open(bitmap_name);
> +	if (fd < 0 && errno == ENOENT) {
> +		FREE_AND_NULL(bitmap_name);
> +		bitmap_name = midx_bitmap_filename(midx);
> +		fd = git_open(bitmap_name);
> +	}
> +

Wait, this looks weird to me. `bitmap_name` already contains the result
of `midx_bitmap_filename()`, so you're essentially retrying the exact
same operation as before?

Patrick
