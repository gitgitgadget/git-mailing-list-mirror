Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52A3019B0
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398991; cv=none; b=t07t7IyYUN0nMVNVz4HXUTV+3jo2ozzr/9lOlPv0Al53AHkNVtXmvOLN3a68T4I7CUSI7EQqSmMzfyjEKthGyKKOjFPYN5+kQNdmyFYGMPpYFKVucpDvLxWgtyJBZFz9O4/ttZ9mjnDok8ada5WZtEe3UzjoU1ZYs3oXTsigRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398991; c=relaxed/simple;
	bh=OCG5NIFhA0BK+p82UBJLjIjHKBOxcKpNhMGsSXOGVlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTkhu0XyUCLWoY0FBjQBlbVUa5MjdHRpBt6CD+TqFNNIXYbqBiKUwwgvudm0hWWtaeLgH4jWRItufqHC2oFxWG/wSrfDXw6sFGa7bSwKHsQ5zWpGvQPICf8JA3Fap1fQp95b6ATXAYy9c38f8uvWC/Ju81mSgZ5tZt2hRAgXCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lKilM2zI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YRQgliAf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lKilM2zI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YRQgliAf"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D5C97EC0143;
	Tue,  9 Sep 2025 02:23:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 09 Sep 2025 02:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757398988; x=1757485388; bh=zZi3Ej7Sj0
	SUKWy1VaPDOL21Sdj/HUPtZcIcty/XTEc=; b=lKilM2zIjWMo6VaIcwlgO8jDcO
	CE6sHROBygfByMKAz4sei3aVRAnykoSO//HOd1GlYX977qInnSsqFdJ/wk+ao2jJ
	w6eGTjQnn7GOLrVM9cIDnr1axEp/V1uu7T24QYTR05SQaYh4v6bSveWrqN9mDzFu
	pa7uxIvschgGURaiRTUifkP+pbvwROQM1uoD+JASeWcuLNXbGRDMB4UNnG1n6hID
	vHtvcKFCw6tv73YbcU/CEdm/LkUIYPMKjJo/+9DcC0hklsPczPDABIyrXhXaPGhr
	jFp4MTwPy8QVMwum0hN0W19pGFJ9gKnlP3hcUZmf8b4odnAN+Iq5F9L7mogQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757398988; x=1757485388; bh=zZi3Ej7Sj0SUKWy1VaPDOL21Sdj/HUPtZcI
	cty/XTEc=; b=YRQgliAf/rd2SGcj8j5VGXV6o0trKGNz8EAV9BbS4nIzqRrmbtU
	ZYTlrk29QmDXbkdBGvco2dVqUNKLHp+pz6gSN2YSsReXP6/m44D3LfJPIfutgI1P
	aAl0dVN2IRiXssXVsnlH2eM3wsZXRWKY22rAEqT9WelOHSLvKejXwnC9Qn3gJwB+
	nrgXCqe3HsKUDAkYzL2kdDtoXqBjGXA3yZOl/MWxiYLMUyN9atv9dMFa4Gnq7FzX
	a8+ttjdJzNmHT+6mouRvRbeKyuZZbQkYT2vbD3F4Ahvaa321mEio/XJFDvnEsbX6
	FFPbtcfThF4QiTGD8GY33F9Ca6aIRYmfE0Q==
X-ME-Sender: <xms:zMe_aPOctJoQiQnKVT5uscysNJAA3wxxVOv7QSDs9YOGP1lcpdSuUw>
    <xme:zMe_aKIbNsKHZ-NqWFUI2DD0uyjAnOoNidxufv0l4YZNvO4DY7ZifNii9XXAqJP0Y
    RjB2A5wzPdtyduABA>
X-ME-Received: <xmr:zMe_aAGZD2sA_Z4b827mbWUkWYQwjw2bDu9yz_59LA0PYTpbpD8YB_dNtZRa2PshQzUMNKU1eCai_8UPPocJrNTjFUb9DwO8yMqMzkccts0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zMe_aCSJzW1vFsgi1-e6Ui1MCHfVAWTic31I2F95t99_D8nIbiVB3A>
    <xmx:zMe_aMGngaw_lT3GL4lPvg3RZGYbRpKdNRGRv33vrz-_OMTCtvxytw>
    <xmx:zMe_aO-FbM9IcmVh-JgbtjuCcpQ7ELQP23a0uSqFB-PJMveq2fjwWw>
    <xmx:zMe_aGK4rz1ucCFialXEOL-vX2ETqnGk0xLSUVdVEfMsEOVUtdKWCQ>
    <xmx:zMe_aPeAKsjpIEDNRPdO5_bGCxWTmfKj5dBKS6nMhquxBSv269pv5g0h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 02:23:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 351a2abc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 06:23:07 +0000 (UTC)
Date: Tue, 9 Sep 2025 08:23:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] string-list: change "string_list_find_insert_index"
 return type to "size_t"
Message-ID: <aL_HySU6d1a9qIBf@pks.im>
References: <aL21cEM0OcnrKtBW@ArchLinux>
 <aL21_e9B8aCpPRyX@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL21_e9B8aCpPRyX@ArchLinux>

On Mon, Sep 08, 2025 at 12:42:37AM +0800, shejialuo wrote:
> As "string_list_find_insert_index" is a simple wrapper of
> "get_entry_index", we could simply change its return type to "size_t".

The missing connecting piece is that `get_entry_index()` itself already
returns a `size_t`.

> diff --git a/mailmap.c b/mailmap.c
> index 253517cdf6..0168342650 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -266,7 +265,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
>  	 * overlong key would be inserted, which must come after the
>  	 * real location of the key if one exists.
>  	 */
> -	while (0 <= --i && i < map->nr) {
> +	while (i-- > 0 && i < map->nr) {

This could simply be `while (i-- && i < map->nr)`.

Patrick
