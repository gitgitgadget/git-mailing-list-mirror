Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2371DF256
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 05:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751606685; cv=none; b=lHwxWS0R9Hgc7WV4Cn5iJB6lE76/5CccwBQxx7hMe2QNMGJqtxHtKth9RzVi4gMdefjvdGkMONWmemx4qxGxTtOEXxKOyBuLl7fd6cvSsceUAfzaPvsDZp+o5oxc6tGT/QIupHeqtQMqK+YZqiQDwXOC8gmXEoTzOnSxxu+cs2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751606685; c=relaxed/simple;
	bh=a5s7gU23a441fMw3MT7AEsrmhQ3CM3R7x9d+pB+ZKik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrMIG2Q9ijEqUbS2Akv92ZcPR/lN9Be5hukwzUGRC4XqXZ2cWoO5TS+mPnmPKpUTHt06a9iEYOqmEQKnM5v7mdbckF7FqwHSMjFIEVZdVBc04KQxLXUgQUPdjmC2VLWDfj+AcbaaUqYQY72zu4AyA+gLt2CWCluojH3YBAz4C7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NNNk/go3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpXEh+1W; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NNNk/go3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpXEh+1W"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E4C47A0141;
	Fri,  4 Jul 2025 01:24:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 04 Jul 2025 01:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751606682; x=1751693082; bh=2vVzYULcPp
	fW0IroNN6kjGTGWlydd2+dmc6dllfm3z8=; b=NNNk/go3/K1vfh/J+51TbnpcWX
	4zepyftBloo94XrxZizpvKfXFUNGowdgP8OhQV08WHHkdaPVjYGQvEEz7OGfe5g+
	B1kmBm28JMQ+VbC9A9hg/DCoRHaW+5RMmjmYW5wubiQf0viSMUMl/xiAkaa10Sax
	YVApKRUoVznvBLmrjdFoHPiN0S71JN26zIO6KYyOuFCCEn+Nsz1bcdm1Z4qH4g0i
	kZ6qYy0O/VnkZrqN3D1hzRgGadF6R6ngq4HEcxoeDcMY0CvobwWTXuQAHo4eS9AP
	Vz8qUHfDMfCyYnqcET5FGM0h8zau2ASNqy2ADaGofThOCmDYIf6OBZTzH0EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751606682; x=1751693082; bh=2vVzYULcPpfW0IroNN6kjGTGWlydd2+dmc6
	dllfm3z8=; b=NpXEh+1W6cIuFnkld3aotzx9euyR3SjWdC/IZuE1wCWhi6phNvx
	jCVonyYdjTsEmRlUKjsqFXt2S03pVPu09D3C1hru886daYdHAGkjrPielheaCIui
	73aDLVyjA8/abpeuMWtc/cpgJ/46ibSS4vutNRGsC+zp99LRRJFJ5mcfa88SyA0z
	nNMeWqzT/pXsUdidYa+Olxi2F/9fAeRf2ErLXCXE4R7uBKv/aE54jsWFpq83W4I8
	VY9nbcnQo5nwNHzyZ5VR50AGATprq6UbEo6UJsTMiE2jS6XFHv+raIG5QwZibdeQ
	9ezQIGRu5neDU6PoU1NvAeOLFUyBBXGni1Q==
X-ME-Sender: <xms:mmVnaNfSNMGzqdC1b6wXcR4G1KSHNqUTa7YYRnIE9W7d3F3qx4YbvA>
    <xme:mmVnaLMLFdHLcsRnFqaNd_NZhyCSVwA3njwdBi1A1S_gPgx6pZcPHwgtMsvzZiawu
    75RyCWxEcDaH8507A>
X-ME-Received: <xmr:mmVnaGgl3ei1mYjbyb6O38WNJ50YgFxqb42bqq_8bxgyG3azq8x2lfGNoLm5du7S-ET1r8sAQRSR4_ApeQNCqz_PlnM4lcGPeLTxybV-9QzO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvdefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvght
X-ME-Proxy: <xmx:mmVnaG_Jh8ZVnjFT8iGSKuYwNruFxqGCsU2xwcKGKDBYhesWJeax9Q>
    <xmx:mmVnaJtCYrc0Qv9TU3VNe3Szk_yd0ZaS7Ohtj0YFH-3yTW-YT2Pu4g>
    <xmx:mmVnaFE6eK5DQtg5D2MC_FJ0d0ImVT0sdydjoIukjXVdT1M6Pp1oNQ>
    <xmx:mmVnaAMs38CuYmWfE3WBfo5gMMJMTRyCSSv2GfYd97MldnITb7hDmw>
    <xmx:mmVnaI7PFMxw6Yx91SQS-zbTN8LHDIjUsBryjKdZ69v0TNlFZyudTn0->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 01:24:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c81bfc4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 4 Jul 2025 05:24:40 +0000 (UTC)
Date: Fri, 4 Jul 2025 07:24:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/8] enhance "string_list" code and test
Message-ID: <aGdllONkAbTJt-Ud@pks.im>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aGDAZ6a0-PyXXGmK@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGDAZ6a0-PyXXGmK@ArchLinux>

On Sun, Jun 29, 2025 at 12:26:15PM +0800, shejialuo wrote:
> Changes since v2:
> 
> 1. [PATCH v3 1/8]: improve the commit message to explain that we would
>    handle a warning in the later commits.
> 2. [PATCH v3 2/8] and [PATCH v2 3/8]: improve the commit message to add
>    the history background.
> 3. [PATCH v3 4/8]: improve the commit message to show why the current
>    bianry search algorithm introduces the sign warning and how to change
>    it to fix the sign warning.
> 4. [PATCH v3 5/8] - [PATCH v3 8/8]: remove list into test helper instead
>    of test itself for reducing the shared state.
> 5. [PATCH v3 8/8]: improve the commit message to say why we can't delete
>    "test-tool string_list" totally.

Thanks, this version looks good to me!

Patrick
