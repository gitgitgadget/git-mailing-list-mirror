Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34C14E2C0
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915655; cv=none; b=Rojgc/HAYM0DEAlmgGPs0fKggdjFluKryT8uKAbn3HwsOH/ZwsGdCDBpob2aiIR71YAUXNvc3+8wKNqPeNfBpgASgqupdpB78Eb5T5Os83OPjlH1dldFQPLkDRBvDA396yz1UgHEAnIjQpL0G90twVNrIWDOIXimRbBbH55oS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915655; c=relaxed/simple;
	bh=keapJG7JYRec2eU2h1bzNQm+k5VLV3GIZP+vYgmdmL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkfKzLsT7WDH2zxGeah0AOx3vw5kIK2wrYnskw11BX/tofQKYbT6ga6zEL+2cn8yJiXkiFIkdVGoyemjauEMvC4a17bU0eXK1tJUj6K0CKEIazv5T3NTqfHGxQyd4ad4FUihRdBtg+pzGNCXpEh1dVCTvZEmPHTFN5CyWWfKCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WNg3xQe1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LvfYehlS; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WNg3xQe1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LvfYehlS"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D4FE114014F;
	Mon, 18 Nov 2024 02:40:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 18 Nov 2024 02:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731915652;
	 x=1732002052; bh=8h57QBqOy/GXcV41aW2ytc7ERr8+qW/zHaZ0XhVWg4o=; b=
	WNg3xQe15iVsIpFSYQGI6ttFqMY0aXxiiBhSEj4O8A0GTXAWl1XiADChTyPxXRfw
	qtPxX7rPysOZfiN2nQdnA91uSmq9X5A4CajVCIKgrQZr4jfoNaU+WkOaPY+nVhJ5
	CzU2ba648RN9Bfyvx1HFkOfko18bWPvG++KEjMloslpHAEIrL3kqq/iNC5tDyqtB
	NAk02eQfXFeqD9qQ1Jhkv0mVSqaegYWTgKJamhgca0plSyvBb3m784uMOnOmUWH7
	5qwswz+peKgAn+ApZcyab9cxHrudLUaAt9O7dVk354FCjCjszzYmUIcJgst6yGz9
	xLPEHtE6/SRevPsAfkFA2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731915652; x=
	1732002052; bh=8h57QBqOy/GXcV41aW2ytc7ERr8+qW/zHaZ0XhVWg4o=; b=L
	vfYehlS2FmIBxp76wxgBY33mF0V8hmnzn2XPVd6WDmiJofnvZq5KnTM2KFbwQmIv
	kkkhVwwmI0zmmFmgks9ulZvP/aWifwxgeaEcy1OIEuCNyux1qtxTK302mE3SkrFj
	YbqPxLFfAZzNhXJFkbQm5mWw+lIOAGfcYuHtEm1Vqe8WAlnA585/k6IkWya0rA3r
	Ll31SArMo2333crgHAwOPL42Tl/JXh0TmQmj7Gks319uQZRaS9K/z4D2HMOm7r/Z
	mi4GbaSPH9xlr8J07ptN/WPsQFQRbGiOxI+L8OlyDexGHwetOCqGY4ORIWvqyDDj
	epNiFtPSbkPQedsfKAEFQ==
X-ME-Sender: <xms:hO86Z2S3k-yjei4VNUJeoRH6K31KtJHGmPWLQHNuQeIxt251Y31hwQ>
    <xme:hO86Z7wJz4F4wymNFS1URJNVweZ1Plu2irIV-6t0aKDmpkz9UkfEEgfALnPu5240r
    6Nzo5cFZbKYCDCRIw>
X-ME-Received: <xmr:hO86Zz1llkBexDTuxiZ7jKv7nq_fpBLuXZ_Tf3DX2wE8N8yeMLvQFJ3IWhriZ43hPq99pDlm6qUkIy8JNeoY2Y6P3gVIBlj-zQKV2pxqupXz6WD->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptedtueetfe
    eutdeivdegvefgtdehjeejieekfffhleefieehudfhkeekkeevtdevnecuffhomhgrihhn
    pehgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrmhesghgvnhhtohho
    rdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvght
X-ME-Proxy: <xmx:hO86ZyBVHR6_wqeivj0DEROXywpJCvGha_y-HZ6h5eJ6tHaHO40_ig>
    <xmx:hO86Z_jCu6KNWKS85anLvgrlmEAFkzzN_RHfZv3Uts5QZO2l2HkK_A>
    <xmx:hO86Z-pvo0hBNEG1EVS2xcIywo2Tp-uFaBOLYi_3nFWqdzpYvRkkuw>
    <xmx:hO86Zyh0eE4us4z7MAdycRNFORZGt4M9-YWrqCfbsrfc_qeMS4LQ_g>
    <xmx:hO86Z_dfZeRI5P9JEnWqWaTCuXVAVoSZT3Tafa5Ev9BM3zIhtYvjTlxa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 02:40:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 04423af5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 07:40:04 +0000 (UTC)
Date: Mon, 18 Nov 2024 08:40:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Sam James <sam@gentoo.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: Re: -Wunterminated-string-initialization warning with GCC 15 in
 object-file.c
Message-ID: <ZzrvecZnS-b0M-1p@pks.im>
References: <87wmh2o9og.fsf@gentoo.org>
 <20241117090329.GA2341486@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241117090329.GA2341486@coredump.intra.peff.net>

On Sun, Nov 17, 2024 at 04:03:29AM -0500, Jeff King wrote:
> On Sun, Nov 17, 2024 at 02:50:39AM +0000, Sam James wrote:
> 
> > With upcoming GCC 15, a new warning is added
> > (-Wunterminated-string-initialization) that fires when building git:
> > ```
> >     CC object-file.o
> > object-file.c:52:9: warning: initializer-string for array of ‘unsigned char’ is too long [-Wunterminated-string-initialization]
> >    52 |         "\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1" \
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > object-file.c:79:17: note: in expansion of macro ‘EMPTY_TREE_SHA256_BIN_LITERAL’
> >    79 |         .hash = EMPTY_TREE_SHA256_BIN_LITERAL,
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > object-file.c:61:9: warning: initializer-string for array of ‘unsigned char’ is too long [-Wunterminated-string-initialization]
> >    61 |         "\x47\x3a\x0f\x4c\x3b\xe8\xa9\x36\x81\xa2" \
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > object-file.c:83:17: note: in expansion of macro ‘EMPTY_BLOB_SHA256_BIN_LITERAL’
> >    83 |         .hash = EMPTY_BLOB_SHA256_BIN_LITERAL,
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ```
> > 
> > Context for the new warning is at https://gcc.gnu.org/PR115185.
> 
> I think the warning is a false positive for us, but I don't begrudge
> them for adding it. It could definitely catch real problems.
> 
> Here are some patches. The first one should fix the warning (but I don't
> have gcc-15 handy to test!). Please let me know if it works for you (and
> thank you for reporting).
> 
> The others are cleanups and future-proofing I found in the same area.
> Not strictly required, but IMHO worth doing.
> 
> +cc brian since I think this is a continuation of some hash-algo
> cleanups he did earlier, plus he piped up in the other gcc-15 thread. ;)

I've got two comments, but other than that this looks like a nice
cleanup to me. Thanks!

Patrick
