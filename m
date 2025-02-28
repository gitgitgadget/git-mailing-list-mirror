Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2825B696
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736892; cv=none; b=F0sGGB/oPNZtHIegV2igMcGp4HLFwUKdnzLB9UOb1dl4/S9WMV8GI3pj2p7RA2jrpoSfbhzW2aXEhmN6QIFpSVXqlX0dog8PoJ00Lzd7oX3Ck3sJT4FvcJJ79dSsj4Blg0jJI+P6tRFGYZtqahTBOolyna/W3mWRzSb46BjfbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736892; c=relaxed/simple;
	bh=Dn2Xw38QeWy4N7TMhBJjmu288DKBlQ7oTqeXWmJvb+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLN/JuPVStFDCQkbhJVlkwirnFFT8xKyoeVXgNdmvE775EcB/Mm1lcyi27wQA6ooXRC+TiabYtep5HFm4fClf2zZ2zoy8/tZ2ZSvh6TlwBmpBv57oGqEsQFnxrVqKDuYZhZSkVxaqqBbp20WJUieVgZLWjAp6bGggKVheqd6k30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eVQwtaTD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5mwPb/mg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eVQwtaTD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5mwPb/mg"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 395561140142;
	Fri, 28 Feb 2025 05:01:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 28 Feb 2025 05:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740736889; x=1740823289; bh=DBSJotKyPQ
	KpCEZQFliR1Xxv5p2ApaxJf6HdjpcXNZs=; b=eVQwtaTDidcfm4P2vLNLqUD3Er
	4e+af6lNsJiQ/zu/Y7sb59LEITk2xsgvWm6aPPGtJ/VCl2XM/C1t1+felxo3P2sA
	DTYAMf6Cd0UDfLxqaO5qVep6sO8HtHzBSFKApKnuRO0Vm5YIywHwltV6zsQndkuq
	4fZdJao5khlYmTNVZhj4KsBnwNRQzHn2yZS2KUSVWiRY+FXFpO80CmraDKahi0il
	j5AEADO4CS/bpyUMMYZrnxsC55iPfgoBebt9LKWavofK6dTdOQbnZu8MoobU5xlq
	BSSUoorXoarsVKkppxoGik5EqAs0WuFGRJZzHZNTWt2GkPH0J/TvFweRZRTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740736889; x=1740823289; bh=DBSJotKyPQKpCEZQFliR1Xxv5p2ApaxJf6H
	djpcXNZs=; b=5mwPb/mgNT71p3Ti+TSaSlWJQP99QJjbSkpZTDduyUysnee6YxR
	JH5dldI+g2WETW6vh0Z7+078v7wC/EUMuuMnxb8kJqMg8Ku+ISeYZt6Ypcgx2hDz
	R07T/LmERnYBRtH5rlOl5Wxy0IVFQGCaOA9ORgFbjOx17ZsUG6soMHyPb8qt38Yg
	XBy9vrWWGs80kUK7nPhhJc59YX5ycC8WDm81VgC9olQe61V0Ukn8L9TtJhIjUwqi
	PIkKK/rtXl5L7nmzOeE00Wc1Av2plopDdLZgCxrDhTxaFC4ZQrsz4rH+jJ+PRJSP
	p74vrIf11OWSvF6AOByflfg/lFjLnf5t/mA==
X-ME-Sender: <xms:eYnBZ5CepZwIUpqIKpCusYxcAcHLnDIaQ4yCm5cW1P-EnRTqJeElTA>
    <xme:eYnBZ3j_r9PHPa-d5-HgcecITxFSmNZvplafyWMkJ2_GJftYh5UvNDn3FIVfHAFLQ
    99c7-v45gB2xm7k6g>
X-ME-Received: <xmr:eYnBZ0nudcueJ3LEf-3wCDhVMiWolTp1vLVEOa-w-SLmN4-g3tQXVpwL0KEjggPliH0gyk-RQATGk2shyBpaTrlK_NWWXLsh7HNGgMVUmpJzg5jG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eYnBZzx3e9PK_hG20bjQ6vc0iZu-B2TDW90hiyfW9yNAaGgdG1Hs8A>
    <xmx:eYnBZ-RwRSiZfzYlmD-3uZT3A_cVxGh_EyDVpZTNxOPxaNRfe_cWsQ>
    <xmx:eYnBZ2aFFNSsZD3MxZomfbFhxFgWomUtnUzgLNM_b86tXsxFZ0y3tw>
    <xmx:eYnBZ_QBPJ170JwqABYRFdHbfb_s_3kBspjX7eu6fLQTmOzZwI1owg>
    <xmx:eYnBZ7IDOvrsn7VqY53xOQIfId76ifnVT6R-74s_JMux1palCN5a2gK0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:01:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f84dae7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:01:27 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:01:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/13] pack-bitmap.c: teach `rev-list --test-bitmap`
 about incremental MIDXs
Message-ID: <Z8GJdv5FwDP_k1et@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <17ab23dd76dce076275873e96991acd2f2b2a994.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ab23dd76dce076275873e96991acd2f2b2a994.1732054032.git.me@ttaylorr.com>

On Tue, Nov 19, 2024 at 05:07:38PM -0500, Taylor Blau wrote:
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 1dddb242434..02864a0e1f7 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -2564,13 +2584,57 @@ static void test_show_commit(struct commit *commit, void *data)
>  	display_progress(tdata->prg, ++tdata->seen);
>  }
>  
> +static uint32_t bitmap_total_entry_count(struct bitmap_index *bitmap_git)
> +{
> +	uint32_t total = 0;
> +	do {
> +		total = st_add(total, bitmap_git->entry_count);
> +		bitmap_git = bitmap_git->base;
> +	} while (bitmap_git);
> +
> +	return total;
> +}
> +
> +static void prepare_bitmap_test_data(struct bitmap_test_data *tdata,
> +				     struct bitmap_index *bitmap_git)

Nit: according to our style guide this should be called
`bitmap_test_data_prepare()`.

> +{
> +	memset(tdata, 0, sizeof(struct bitmap_test_data));
> +
> +	tdata->bitmap_git = bitmap_git;
> +	tdata->base = bitmap_new();
> +	tdata->commits = ewah_to_bitmap(bitmap_git->commits);
> +	tdata->trees = ewah_to_bitmap(bitmap_git->trees);
> +	tdata->blobs = ewah_to_bitmap(bitmap_git->blobs);
> +	tdata->tags = ewah_to_bitmap(bitmap_git->tags);
> +
> +	if (bitmap_git->base) {
> +		CALLOC_ARRAY(tdata->base_tdata, 1);
> +		prepare_bitmap_test_data(tdata->base_tdata, bitmap_git->base);
> +	}
> +}
> +
> +static void free_bitmap_test_data(struct bitmap_test_data *tdata)

Same nit here, this should be called `bitmap_test_data_free()`. In fact,
it should be called `bitmap_test_data_release()`, because we don't free
`tadata` itself.

> @@ -2579,17 +2643,26 @@ void test_bitmap_walk(struct rev_info *revs)
>  	if (revs->pending.nr != 1)
>  		die(_("you must specify exactly one commit to test"));
>  
> -	fprintf_ln(stderr, "Bitmap v%d test (%d entries%s)",
> +	fprintf_ln(stderr, "Bitmap v%d test (%d entries%s, %d total)",
>  		bitmap_git->version,
>  		bitmap_git->entry_count,
> -		bitmap_git->table_lookup ? "" : " loaded");
> +		bitmap_git->table_lookup ? "" : " loaded",
> +		bitmap_total_entry_count(bitmap_git));
>  
>  	root = revs->pending.objects[0].item;
> -	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
> +	bm = find_bitmap_for_commit(bitmap_git, (struct commit *)root, &found);
>  
>  	if (bm) {
>  		fprintf_ln(stderr, "Found bitmap for '%s'. %d bits / %08x checksum",
> -			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
> +			oid_to_hex(&root->oid),
> +			(int)bm->bit_size, ewah_checksum(bm));
> +
> +		if (bitmap_is_midx(found))
> +			fprintf_ln(stderr, "Located via MIDX '%s'.",
> +				   hash_to_hex(get_midx_checksum(found->midx)));
> +		else
> +			fprintf_ln(stderr, "Located via pack '%s'.",
> +				   hash_to_hex(found->pack->hash));
>  
>  		result = ewah_to_bitmap(bm);
>  	}

I'm a bit surprised that this doesn't result in any changes required in
our tests.

Patrick
