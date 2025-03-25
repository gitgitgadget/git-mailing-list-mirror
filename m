Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102225A337
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905880; cv=none; b=UKO1aK2xXygCZIT8fZ+wxIbPr07vMt8NMwROaUtChUct4C6JIirDN35mnNrhY7moEynkMxXFzyXrXWyHmXawUrfRPJXCTKMrBXEMi5Q3POSDpXI83H8pdm9S2ObEnZqLc4/YfZHWL+NsXfk8RWpoFHdJpjHHUO/XL68kXk4OssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905880; c=relaxed/simple;
	bh=FAC12FUqnhCGq6JrlQFgFe3x0W3QNJqH9oa5tlk1kgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHPHMgwIdsMX+NCYrpdWGUnK1YErOXgZOcTMXoPObnF5ufX+iw30zJQfUCmkCvIB8d8SU9ZlPORTT/vVrpEZWwdVYkIVcrDkHE/81FYkSu3NzrMAcZdpoBBZb3p0/i/FB5W0ehZnlCalanGHC9j6ASCEkv/jmJQmNalqp5kdEDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LqG3Xy2G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ry3O65A7; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LqG3Xy2G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ry3O65A7"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DCA7A13838FD;
	Tue, 25 Mar 2025 08:31:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 25 Mar 2025 08:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742905877; x=1742992277; bh=Wq0N7uniud
	q+VMvw1IgVyLRPM9/Y0dYofl+M+7d4TKs=; b=LqG3Xy2GEY4LYUSuKmXHVPlbco
	Or9NKN5ge1Mxy3G65c+u3vqvkXRoLYwiF9vmF1PIOxwqLrJ5+aPkBvL730BlX2hm
	r2bKC6MP+aFpwA1M6urFkeu1eZRgFw+Nuq7tplqreGZTB5I3HmiF9HxIR2FfPYjL
	DGkV2M2RVEGveqHTKLTNPsMRqHo42bS9YnKbXPOAqFdk0t7NQRnMLBa/qSiKHO62
	8Cna5LUe7LKdFVh+j8opHlhbx2BUmF5chz7m92Rg5DhcgeASdsMwLZNNfzXHyzpl
	5N8H3n5fQ0kAc4DZNFNTkDus3T08Ct77GgVHoomVa+M4ibt6Jh0j1vVE7wcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742905877; x=1742992277; bh=Wq0N7uniudq+VMvw1IgVyLRPM9/Y0dYofl+
	M+7d4TKs=; b=ry3O65A7hfHgr0uXao1ZGdKXQlDKmoOBEStEEeh12GcNUE4624h
	jWqXoVtrXdW5ckd1U4Sv8BLnU7Zng7hokCmcw7drxyS6b8OXDsfvvRpYnQ2hDaC8
	cRTxkcKejp9oNqQ/aCfsEyeuPLEWz0vv3roFB3YFWF+aA55HyXaYq09N25REmGED
	/R2Sk5Er6qgXBmvUN4Uyec1ncnAQiuoHOZLq46tcfmB97X7kzMtY3iF/9+kHRuHG
	7MtAOScRSRNZFjx61ZJ22V8QaTvAbXLKf/FEE7jnlKUI42oTZHstouUCT1P2GkjC
	LtphMUt2XvOW/W2n463VIPc6djwpsJQTIqA==
X-ME-Sender: <xms:FaLiZ3QAIIu9O06kJctJGL3KSuBK9q34B3lkJ0c2wba_UIkEHUyTeg>
    <xme:FaLiZ4yF7keBEVOO1itT_6qkQsOY5aIx-HBo1wil1T2mG3738uUsdSLezghp6JDdK
    1ZbFZNNOqEz6Weh5w>
X-ME-Received: <xmr:FaLiZ838-mhRwDcYcj22JuPXPJSH3kcfvnhF5OcQQdi7qEw_M_df7m2ZwkVoMF8EI584rQhVTOs9vvKaWtFdQgurOkqh0q8y-8ejj6U0xx2ajg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:FaLiZ3A93Ukz2D9zfVUi9pROiY5l_sckDHdC69Twx4Sgfk0e9I0y_Q>
    <xmx:FaLiZwiN6TdBX45wesNUlya2j3CB_nyh5lenU4j6n464_uzYvVbxPQ>
    <xmx:FaLiZ7rYbBdChhBp81dMbwUseQ51pHhrjOKWUd43cWZCP6LZeQvb6Q>
    <xmx:FaLiZ7j0JE5C0pv1DEwR1u9F7lskKygqHaUZse2tQUnvelmMGwf7Ng>
    <xmx:FaLiZ4diSwK25NQKjNwty4ciCvguFMAYRHOALBg7fPJIqc43x4xfFeRh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 08:31:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 96a29bef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 12:31:15 +0000 (UTC)
Date: Tue, 25 Mar 2025 13:31:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 5/8] refs: introduce enum-based transaction error types
Message-ID: <Z-KiEsx4ry3CX5eJ@pks.im>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
 <20250320-245-partially-atomic-ref-updates-v4-5-3dcc1b311dc9@gmail.com>
 <Z9x578gHJQPCYU4v@pks.im>
 <CAOLa=ZRM8EeeVXpZFpLU7Wg8k98_U+0hw1y63gQDjPEfR2P2cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRM8EeeVXpZFpLU7Wg8k98_U+0hw1y63gQDjPEfR2P2cw@mail.gmail.com>

On Mon, Mar 24, 2025 at 02:50:56PM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, Mar 20, 2025 at 12:44:00PM +0100, Karthik Nayak wrote:
> >> diff --git a/refs.h b/refs.h
> >> index 240e2d8537..dcd83e81e2 100644
> >> --- a/refs.h
> >> +++ b/refs.h
> >> @@ -16,6 +16,29 @@ struct worktree;
> >>  enum ref_storage_format ref_storage_format_by_name(const char *name);
> >>  const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
> >>
> >> +/*
> >> + * enum ref_transaction_error represents the following return codes:
> >> + * REF_TRANSACTION_ERROR_GENERIC error_code: default error code.
> >> + * REF_TRANSACTION_ERROR_NAME_CONFLICT error_code: ref name conflict like A vs A/B.
> >> + * REF_TRANSACTION_ERROR_CREATE_EXISTS error_code: ref to be created already exists.
> >> + * REF_TRANSACTION_ERROR_NONEXISTENT_REF error_code: ref expected but doesn't exist.
> >> + * REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE error_code: provided old_oid or old_target of
> >> + * reference doesn't match actual.
> >> + * REF_TRANSACTION_ERROR_INVALID_NEW_VALUE error_code: provided new_oid or new_target is
> >> + * invalid.
> >> + * REF_TRANSACTION_ERROR_EXPECTED_SYMREF error_code: expected ref to be symref, but is a
> >> + * regular ref.
> >> + */
> >> +enum ref_transaction_error {
> >> +	REF_TRANSACTION_ERROR_GENERIC = -1,
> >> +	REF_TRANSACTION_ERROR_NAME_CONFLICT = -2,
> >> +	REF_TRANSACTION_ERROR_CREATE_EXISTS = -3,
> >> +	REF_TRANSACTION_ERROR_NONEXISTENT_REF = -4,
> >> +	REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE = -5,
> >> +	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
> >> +	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
> >> +};
> >> +
> >
> > Tiny nit: I think it's generally preferable to document each specific
> > right next to its definition.
> >
> 
> Idk about this, I based it off on `enum bisect_error` which is similar,
> but I also see the same in `enum scld_error`.
> 
> I'm okay to change this though, perhaps makes sense to document the
> preferred style however.

Probably would make sense, yes. The argument for why it's preferable to
do this inline is that it's harder for the list to grow stale. It's
trivial to see when a comment needs to be removed/updated.

Patrick
