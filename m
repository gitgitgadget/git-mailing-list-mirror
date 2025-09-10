Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE5EAC7
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 04:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757480284; cv=none; b=P85lHkBflv3eV63ZnYzIyLHxnBYfP1K8tw7qxZTKMNSO+XMI4IacwrfFA58fnNMF/vwgnyMk5Q7ZQDOzILoMifpvwKSNU7hn4zaJL8EX+T9CHajjC5L0X4rFugxXio3haHKMuDCKuxwwiiqx24eNgBVaEi2ETsDsEbblKj9cSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757480284; c=relaxed/simple;
	bh=oGVmSwq3D3F/Ju+lMAt1Vv3MarPqcd86T6XYpADY+JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knpNFrAsbVKmjERc6kNGO+Z15ICgRV0dfAAdQe6TLBfBtcDe1IzZUmUlVwYx2uk9cZPAwB8LjeLrp3GX6P7GglM6Zy3TLiUkxmYrDEx345t8uIcxZfFMCAs993lSekJ/UH+iUXrOrxlZsmyr2z8k0dDDMRtkRhAROfOdnRa6X5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GDSXqCXm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RznuKaOn; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GDSXqCXm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RznuKaOn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 040DCEC0217;
	Wed, 10 Sep 2025 00:58:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 00:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757480280; x=1757566680; bh=s5QLRp4bnI
	LfRN2V1XdEBRDu+9uOBFRS7a4WpzoQTaw=; b=GDSXqCXm1v7E3axbvTgvonKaG7
	2eSfKnDKB+OqPaudV+FL+x2xibvAA04OQopW8ox/YwTnE2lrS693b6IHji640A4k
	RE4FMrKObwbWM/QwhC6L6YcVxnlgQ/oSvmUJf7jFzRA68fJJhu+lc3gPrUFRvaE1
	9cgspmEVsTeFhcv8OfgmMuQ4UorPuGtd11sv7n1IBuPYBV/PhcRZMcUmwoHheQd1
	vuz2CfKg0D5M2UM1yftwfT/HGH2IichEn7S/D77xkz2t79AEUeyNgsEOD+XfYbbb
	RZ5va7xnkDLGLTk96EvcxictsXVSuJGBA9F1MfW0gVycGh1qn6HXC6Dd8g+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757480280; x=1757566680; bh=s5QLRp4bnILfRN2V1XdEBRDu+9uOBFRS7a4
	WpzoQTaw=; b=RznuKaOn4KPWL4FtHU4oArpzOb4lnr9XEYLds2P4HrPxRy3XxrH
	M8SD6Kjg+u7/r5haY1iOBxBYdwCFYbogtLGIortKrfsAyut/pqZGIN4f2WTOzP0C
	7ePTE//hcdsqQKYU4C/kJCllzrSxiz0t/deAA5GFUMw7tNoWXzn/6ZC/nEJ+lWXf
	MWzvKm57thfCMU3f6tvobsKzmh8d/wvhaxOOoON2tCElPmM0vrzIK3BJJ3iHrbyx
	15lYK3Xn33XKJ2T7aNdtpO/u653T4V5EBe264AXhG/BadbQkW/ew3jQi65rdceb6
	yaBGdZEJAEr2qw7BsrEqkcpUDM59m4Xy7CA==
X-ME-Sender: <xms:WAXBaHs2bxwmMacgjA12oqrzcdJLrvF_6xvMR-cxVlHxtvIB8nOlOQ>
    <xme:WAXBaLu8Lh5s4zUMw81_fyX3GZR0IMz7nNmJVaKq-Fjx2bBeL3QNbzpPyyxVqhmRV
    l71_GXtLCPPtJkv5g>
X-ME-Received: <xmr:WAXBaEPhpOagQHVbakbSRUZcjyOHkm7cmVGITX3lhG4qL_YJSzhYwdbS_U70VTgwCyEVm_xYopcCJ3hTHaSpv8HdYUHI49Xur64t8e_9DHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiud
    elueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WAXBaB2Xu4SPChxhSF09p0PbxNKAHDTivWxoMZ8gLw3HQDo-UUTyUw>
    <xmx:WAXBaIPm8IwFYbzIm_fSbuXdHjj_-I2M4ll6lQ383eePiusX7O3cEA>
    <xmx:WAXBaJ3hQvpZVhx8ydMzUEoEooe25Bz2MJBLyqVlRPWCYJbzNLUPkg>
    <xmx:WAXBaHHeFyseH56G6CSF0T3b5vvi-sb7-avbNv9_I49oHgf3PwkCCg>
    <xmx:WAXBaAVJTe6fdPN3SsNjLOk7jfagSDbBCyvu-HDOflPsAXrAPScbVlct>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 00:58:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4f8f48c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 04:57:58 +0000 (UTC)
Date: Wed, 10 Sep 2025 06:57:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] string-list: change "string_list_find_insert_index"
 return type to "size_t"
Message-ID: <aMEFUyRfdeTvPehB@pks.im>
References: <aL21cEM0OcnrKtBW@ArchLinux>
 <aL21_e9B8aCpPRyX@ArchLinux>
 <aL_HySU6d1a9qIBf@pks.im>
 <xmqq1pofv3dg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pofv3dg.fsf@gitster.g>

On Tue, Sep 09, 2025 at 12:21:15PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> @@ -266,7 +265,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
> >>  	 * overlong key would be inserted, which must come after the
> >>  	 * real location of the key if one exists.
> >>  	 */
> >> -	while (0 <= --i && i < map->nr) {
> >> +	while (i-- > 0 && i < map->nr) {
> >
> > This could simply be `while (i-- && i < map->nr)`.
> 
> Yes, especially if the reason why we avoid "not negative" aka "0 <="
> is because the counter is now unsigned, yours is much more intuitive
> way to say "as long as i is not yet zero".  Alternatively you could
> say "while (i-- != 0 && ...", but not comparing with 0 is more
> customary.
> 
> Better yet, shouldn't we stay away from "i", if the point of the
> change is to make it unsigned, as "i" has a strong connotation with
> "int, the platform natural signed integer type"?

For me "i" in a loop typically just means "index" and not "int". So
personally, I'm fine with that variable name.

Patrick
