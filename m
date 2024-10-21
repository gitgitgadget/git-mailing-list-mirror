Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7A1EBA0C
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514824; cv=none; b=Im2LhB/uYAXwT7Q64zCkaFXYp9TFDQU+vD2jOzgBNB0FdWknQKmuXcuxRJrkRpOvZl1sHytc8qxlixjschbqlevzx0WdWoo4j8yb1xrIJsxNIq6ew1q4mG3mX8UvI4BybDXG8oJjfO4Vb2NYevGpHHqyQ3K3NvyDezY+O/VouH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514824; c=relaxed/simple;
	bh=Pr6O+n+UKTlPF+6CcSFEhBc47XwOPlTTBFF961qIJkc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKctA8WGHVFFExli1MDfTRArbJoEs7IGjmiCJTESK6Hx+CtCcVpd0hOUrNFkS4F47EwapcaOtwx05OPcXLPa1F0xKbIbK9nn5YX/KdN3wy7apYtKDM0s+A8COEDIHrqU6CXIHbVHIE7q1UlzFugBZdAGcMWGvnutvwr4aFcPu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mgcTOCqY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lvyxovnj; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mgcTOCqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lvyxovnj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FD43138039A;
	Mon, 21 Oct 2024 08:47:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 21 Oct 2024 08:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729514821; x=1729601221; bh=I/xKK1q+NW
	IwaMYo4FwWIMHJP45bYS6icH+vYpibEAM=; b=mgcTOCqYL156pZTbeWxEdy6VHe
	iuqWoJVHPazPoXSg73je47/6TmlNz8pviyv3+NDD2mcsl64yNgWb+GCCGveC/1KX
	koxTHGzsLFlW0OH6wDXUDtOsdTVLYfnPEZhdsWklllzYxxYm0w5qYRuC6rUV3wqn
	7rlhSF5pj+wXnQkeV2Nodin1Ai+7hnthUeiG/Ru49KJ+kmHiq3iCI0CiY5CzOCKf
	No/y3oDJAlfIEjqcolUTG/TGPQxLmlwqdCURybqOV9+lxjIwO8kEWWadqNkUZEAM
	n9ShvQlRL1s3LmEjL0krkJ++iYRwbzUomkpj7tAUKDLppZipF93fOPH4y7sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729514821; x=1729601221; bh=I/xKK1q+NWIwaMYo4FwWIMHJP45b
	YS6icH+vYpibEAM=; b=lvyxovnjVpQJ1tFDC7PbMULTigSwySOEagrTYJ1peqkK
	A1tvJrxdLsdr4zquMY6zFLEXF9vlPp646GXgrprzjlYrYUhNu0+MGx6hq3V8A0vv
	9iOEO7Qh0OXjI506OzqYGhMfZ2cnrVD382bAvLLFkKbJGNKCFySofy5QkfJzC8iM
	VPKfZ6ZRbFox0TI6O9VS9wj/pXMiHIVaObztKT4wjihXvdgVpBG7QaaOZhQpDy7U
	lvqSsCb0s9flEolnZgm53UFXnyOwFsraR0qPu93fKG3ygN9NYrx/hlGwPZmFdr+U
	mpJBV1/h30x8ZggzMTpSmLDG1cBEGJyjAFYT6zxfLg==
X-ME-Sender: <xms:RU0WZ13Oq9IYnHq-UZ9Gt7SxXtgEVNQylKE44OXjtE27zDBvLVlsoQ>
    <xme:RU0WZ8GHQDoFJpHrEiNOJA3gEPB9Zkb5poIBXUXNF-1vq8-gd_3YIPI3zqlfcl4so
    2rV6zwa1kZ8gmjGew>
X-ME-Received: <xmr:RU0WZ16LvUJRqxxnFLezLHRwpw9XJd2BBJhckBvpEP8WFUMHSCC8ibZY_gFkv45mRwbOxVweLcQXf9WbZ-Pyz-l6H_h8SyytSJjVIGxmxJIq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:RU0WZy03dvlwP-F3t-7YL8eEBICK0fXjJfXSHIRp42v3cE1CnSuAww>
    <xmx:RU0WZ4Gwp4wdVbR-0mH6FWo4V0K4goeT9IfStASrSN9sWuEGjPkfqQ>
    <xmx:RU0WZz-pzKGKO5fVQRQZBo-Aq8_jjCMz6pYCFqlIAlCHY4AHrBiuJA>
    <xmx:RU0WZ1k75N5KP--2y1VcNW4KZY6rwOfrMF_HevuIUNCqys7x3TvLew>
    <xmx:RU0WZ0h8Fqxl-rf5U45V85FTH5rFvSdYUus-0fvhQlFK0lET3I_2nJZw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 08:47:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7bb6194 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 12:45:29 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:46:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Emily Shaffer <nasamuffin@google.com>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
Message-ID: <ZxZNObRiWvxTk6OG@pks.im>
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
 <xmqqv7yc3goa.fsf@gitster.g>
 <Zvs11sEe_6c_L8DA@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvs11sEe_6c_L8DA@tapette.crustytoothpaste.net>

On Mon, Sep 30, 2024 at 11:35:50PM +0000, brian m. carlson wrote:
> On 2024-09-30 at 22:44:37, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > 
> > > ....  It is designed to be passed and returned by value, not
> > > pointer, and it is possible to do so in two registers on 64-bit systems.
> > > Similar functionality works well for error types in Rust and for the
> > > standard library's lldiv_t, so this should not pose a problem.
> > 
> > It should not, in the sense that "any reasonable platform should be
> > able to pass two 64-bit word in a structure by value", but isn't it
> > optimizing for a wrong (i.e. have error) case?  In the case where
> > there is no error, a "negative return is error, zero is success",
> > with a pointer to "more detailed error info, in case the call
> > resulted in an error", would let us take branch based on a zero-ness
> > check on an integer in a machine-natural word, without even looking
> > at these two words in the struct.
> 
> We can adjust the first word so that it's always zero on success, in
> which case, because it's returned in two registers, the processor will
> be able to branch on a zero-ness check on one of those registers.  (We
> can even optimize the check by looking at the low 32 bits, which will do
> the same for 32-bit machines as well.)  The performance benefit will be
> the same, and I should note that Rust does this kind of thing without a
> problem.

I was wondering the same here, also because having to write
`git_error_ok()` is a bit unwieldy. One of my thoughts in this context
was to not be shy of allocating the error structures such that we don't
have to pass by value, but instead pass by pointer. It also gives us a
bit more flexibility with the error structure itself, as we don't have
to optimize for size anymore. Or at least not to the extent as we'd have
to do with the current proposal.

The obvious problem of course is if we're running out of memory. But I
think we can easily special-case this and return a statically-allocated
error specific to that situation, where `git_error_free()` would know
not to free it.

Patrick
