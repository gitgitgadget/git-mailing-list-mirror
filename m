Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455CA34D4DF
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836230; cv=none; b=Q7xwyR+7CrkecGqT7MWeL0nKjN1N0IuQYbccKn+o4QcaEXm+UNihnx5zirWywY66poHZzrvABdfrC/MCp+m1suwvXabwbgGvpENN2kTMjzjyZxfxS8erj/xxPN7K+heM1IRFFWkvc3XMrwb6fIHxEJj6qEcYYHbuQQIgYNTKRr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836230; c=relaxed/simple;
	bh=k0ZeEFWc4JxBHBMytEo73j+1uovRp8ceiv2F5Bk91z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQnQ333vOAPL3A5nGZeOJkoCV98GzXTZ/OH1pyUJJNgtKimRnIMgh7ejbkR6xx2+5ixukXU0hHbGaplhPs2cIqyS9crCjSqAwjqKwPEiBtD30fbO5TUWkbc6+WetQdIZq+WvJi2imvd0EVocAtSNQIu2RUnIq+52yet2NMIzaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qiaTcmFM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C2Z3OvJp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qiaTcmFM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C2Z3OvJp"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 80C94EC05CA;
	Mon, 23 Feb 2026 03:43:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 23 Feb 2026 03:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771836227; x=1771922627; bh=NcmndZDzmk
	K1elitOModidQFDr6u5mW41hmtnAEBJlI=; b=qiaTcmFMoCRom0ePrH0EQuoO/4
	sBBwMJ2758QJ/1e1mrtZb2Yv6apJhdWqPnfQBiANxmmUrgLiyvcvclG9j259Cclb
	Q2e/Digc3puUTJaL15SqEPgWDFaJvzmfzPk2pi6n6Z3JlxYakNEynvYzN/vQsULr
	BvDB6qjm+psXeDtxrKdbU86LTCFblqB8o4aSpmZLOZ1yXf20AUGIdS6nYBDrfYFI
	Peg1UiP2k03JWQ0hXGsZbzAIfVaT0Rk4iHtjA2QzR4uyMrAWGxfOcrlhZbPpy1hh
	PVgB8p0zt2mufguBpge7pU4aqATh1OdrIC5XcS4ZGpqWDtHy4zb/qxZwd1Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771836227; x=1771922627; bh=NcmndZDzmkK1elitOModidQFDr6u5mW41hm
	tnAEBJlI=; b=C2Z3OvJpQjmkkdUH0JHTtBXlMhau+OunFqWPZXkW7WLRAKYXfiE
	P2bj6kRq4wtuxP/G8sZWKCK+lEfeNjCVpYUcj6Cz5+ePxvk6wnmMIixuPNgGVxcd
	VNt8f6G4Kz9EqW/CIkynFUv3cjHYjLCGxTmmbkhFUaSlByka7aRxVGJkKKogWPGH
	QQTn9551/JqLChV5ETTGtMrog/Fp5Z6hvarGtyAr4eTLJQZRvNECLbzafBftdD5a
	ZbiLukENUhE3xOfk0zQr8DZ5GnM5G9ix0hye1kOxl/nJYdGUQ0bPHXAIIG4eeeQT
	akq/13htkxBMaBJi1QgO45tQKJTL6C167SQ==
X-ME-Sender: <xms:QxOcaRjWxFLgzGp4MgqyAT901_lCW2KOq9RXiH-4On7j0scAQ9zcNA>
    <xme:QxOcadevGvbYnlbm8iUD3DyY8obsK2oQ9EkVripYGdvpO5EQqCaU_v9HvyIhBfKAs
    T7ZLRxgupTSZGj6nLCJaY--aexf85D6ktNPD6sxIzNJCUoZrvptpA>
X-ME-Received: <xmr:QxOcaecQCoR5vumnAvp8IDtrz4bGkDoR0ytFpgcPeYeQexp_sPeiCtYjbzKQlHactCWDtD_CZE0aV4FH-eGkKyd8uD9CCmkzZ5Ua3tp57A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeijeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpefhhfffveefffevieeifeelueejueekuefgte
    fhkeeggeetkefggeefueffuddtgfenucffohhmrghinhepsghighhfihhlvghthhhrvghs
    hhholhgurdhnohifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:QxOcaf8_NxMektigHvC0cUG56jPNtfFuLY0ROlQYy7wqP8ugTCijFw>
    <xmx:QxOcaSnVel1PGTIyMvdPP5M101a-Ai-uG0TFx_CXzyCMZXhMyUQH7A>
    <xmx:QxOcaZ8ZLUMUFgYq_jFupsi3NAtRtoMAZTt7QGtG66whJH5reeNKxw>
    <xmx:QxOcaYnMnw0T7azgRFCIyLD1nC6Jch9g5qAwr_9bN1DtDcb86XIHTA>
    <xmx:QxOcaVqUuzu1YpAY52_XZ2ftOuoSmoEFXxzBXGAuDuFAKBiGlhPsg3xW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 03:43:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cadc1394 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 08:43:44 +0000 (UTC)
Date: Mon, 23 Feb 2026 09:43:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
Message-ID: <aZwTPfmyrFp-QAPq@pks.im>
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222183710.2963424-1-sandals@crustytoothpaste.net>

On Sun, Feb 22, 2026 at 06:37:10PM +0000, brian m. carlson wrote:
> When we iterate over our packfiles in the fsck code, we do so twice.
> The first time, we count the number of objects in all of the packs
> together and later on, we iterate a second time, processing each pack
> and verifying its integrity.
> 
> This would normally work fine, but if we have two packs and we're
> processing the second, the verification process will open the pack to
> read from it, which will place it at the beginning of the most recently
> used list.  Since this same list is used for iteration, the pack we most
> recently processed before this will then be behind the current pack in
> the linked list, so when we next process the list, we will go back to
> the first pack again and then loop forever.  This also makes our
> progress indicator loop up to many thousands of percent, which is not
> only nonsensical, but a clear indication that something has gone wrong.
> 
> Solve this by skipping our MRU updates when we're iterating over
> packfiles, which avoids the reordering that causes problems.

Right, this makes sense. We know that we cannot modify the list of packs
in case we're iterating through them, so `repo_for_each_pack()` should
indeed skip the MRU updates.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I realize that t1050 may seem like a bizarre place to put this test.
> However, I was debugging my sha256-interop branch and why the final test
> calling `git fsck` was failing, so I placed a `git fsck` earlier in the
> test to double-check and discovered the problem.  Since we already have
> a natural testcase here, I thought I'd just place the test where we
> already know it will trigger the problem.

Makes me wonder though why none of the tests t1450-fsck exhibit this
pattern. I cannot imagine that there is no test there that doesn't have
multiple packs. *goes checking* We actually might not, but when trying
to come up with a minimum reproducer I failed at first.

This is because ultimately the root cause seems to be a bit more
complex: we don't only care about there being multiple packfiles. We
also care about "core.bigFileThreshold".

Typically, we don't execute `find_pack_entry()` at all when verifying
packfiles as we iterate through objects in packfile order. We thus don't
have to look up objects via their object ID, but instead we do so by
using their packfile offset. And this mechanism will not end up in
`find_pack_entry()`, and thus we wouldn't update the MRU.

But there's an exception: when the size of the object that is to be
checked exceeds "core.bigFileThreshold" we won't read it directly, but
we'll instead use `stream_object_signature()`, which eventually ends up
calling `odb_read_stream_open()`. And that of course _will_ call
`find_pack_entry()`, as we're now in the mode where we search by object
ID, not by offset. And consequently, we'll update the MRU in this call
path.

With that knowledge it's kind of easy to reproduce the issue: we simply
need two packfiles, and each of them must contain at least one blob that
is larger than "core.bigFileThreshold".

Now I agree that the below proposed fix would be a good change to make
the code more solid while we still have `repo_for_each_pack()` (I plan
to eventually get rid of it). But arguably, the above logic is kind of
broken regardless of this: we are asked to verify objects in the current
pack, but we may end up verifying the object via a different pack. So if
the same object were to exist in multiple packs, we might end up only
verifying one of its instances.

I've got a couple patches in the making that'll fix this.

> diff --git a/packfile.h b/packfile.h
> index acc5c55ad5..086d98c1a0 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -191,8 +192,13 @@ static inline struct repo_for_each_pack_data repo_for_eack_pack_data_init(struct
>  
>  	odb_prepare_alternates(repo->objects);
>  
> +	data.repo = repo;
> +
>  	for (struct odb_source *source = repo->objects->sources; source; source = source->next) {
> -		struct packfile_list_entry *entry = packfile_store_get_packs(source->packfiles);
> +		struct packfile_list_entry *entry;
> +
> +		source->packfiles->skip_mru_updates = true;
> +		entry = packfile_store_get_packs(source->packfiles);
>  		if (!entry)
>  			continue;
>  		data.source = source;
> @@ -212,7 +218,10 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
>  		return;
>  
>  	for (source = data->source->next; source; source = source->next) {
> -		struct packfile_list_entry *entry = packfile_store_get_packs(source->packfiles);
> +		struct packfile_list_entry *entry;
> +
> +		source->packfiles->skip_mru_updates = true;
> +		entry = packfile_store_get_packs(source->packfiles);
>  		if (!entry)
>  			continue;
>  		data->source = source;
> @@ -220,6 +229,9 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
>  		return;
>  	}
>  
> +	for (struct odb_source *source = data->repo->objects->sources; source; source = source->next)
> +		source->packfiles->skip_mru_updates = false;
> +
>  	data->source = NULL;
>  	data->entry = NULL;
>  }

I still think that this hardening here would be worth it, but it has the
problem that we won't reset the value in case the caller breaks out of
the loop by themselves. I don't really have a good idea for how to fix
this, except by turning it into a function with a callback.

Patrick
