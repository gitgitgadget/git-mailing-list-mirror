Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3D3112B0
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590733; cv=none; b=HOT4UWvhgLCpDHaowp2ktQQLnMip0X2Ci91fIcEM3yRjWWX+bYpdnI1niOQnj1eBVo0g29WHCGyBNcdOHOYUnTw9vOG823w5Ss2BCS5RTHMjMT6JoUG7+WHFJpoQ+S+khS5C4cBjjxHnzlK47H/IRGufiev1okLhfLJX1eKAEs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590733; c=relaxed/simple;
	bh=pp4nt1jrDqaMDKW1E1fAPg33IvAZClcQFDYvjiCj4/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBmnU1s/rmGEaFpXhWC8FDFqv2Xjrmy71Si1TbNnhajLQHACSK465FgYON/LaHO7+Se0XB3FuGQ4b5wPTQFXr4JVPSTGpsfjBCKUAddqAr0mygx1lRQitar75avnFbzQbBq8d4bVgPEfVR8/he+Zr86MW5QfyxtLrK+Lcla5jr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KSRGEQfW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D49RwJTx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KSRGEQfW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D49RwJTx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4573B1D0021F;
	Tue, 19 Aug 2025 04:05:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 19 Aug 2025 04:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755590730; x=1755677130; bh=dzLgtYzlqf
	QnrKWY9TnM4IkVokBNQWkl+wvj0AEz2ac=; b=KSRGEQfWagskxvOaB6bXP/AGFh
	pDwiDWCbH2hseAmk0aDNlY3oYy5RV2F8XMCBq24e1GyVk6st/dZLSma5s/TfKlEB
	zTmyyaVCai54t/LTEk3BSgQiZ0US1fB18KU7+mO9nf9nvlownf8oa/v5FpshOFZA
	nBWIFnSrrW9QRcw078tjY5r/XgkSAzKE0KERjTkTzXUvvGIUX4N9uKDBGWg1n04E
	JBl0zIP7PGqvIHNyHY+DEDVDOlVeKq5DMnX+CWYP4t0Hhik4nbHz5uYJszvsWJWP
	tcayC2vbmltOzNeJQBzgnot6jcd1UP58j+ai4Kg+zU5hkQZ5OmPeD1N2PRJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755590730; x=1755677130; bh=dzLgtYzlqfQnrKWY9TnM4IkVokBNQWkl+wv
	j0AEz2ac=; b=D49RwJTxWmqKhzZFkCB9dBFIEthNOaaw5ZHMPf82QsXmQvRaA8e
	MiyXaTlzLJ2V4g4aQkl35k6V/JlOqty2y74duX9FUTo8s9SmaKmF59/CcRhWZnez
	P+h2J8NNKt00mSP4BdPduoPUQzma6T5ZgGu3tBhTh80AhWgnUVftxDoiz1Uc/84i
	JUCoHx1L4KcBstErMp/0axOjVL/1TnyPhuVYPsblTEIDi/hYZ6NE9LI2IQXqcE6z
	KLYn4AuzfG+d5OcEYUH5Tu5ivuHT20/hw7nBiwoNN6Lkl1iovbn8+a3FDq2LMsX9
	gtMuHYdjNmB2PM0ePgJUVPeRilRAhaX841A==
X-ME-Sender: <xms:STCkaETcjflj25eMFam9kXKydOB20CatKBVasywwgd7khCf2zISbKQ>
    <xme:STCkaKM7vwQwxGxaO41oc8qxmKv0Qg3Y8KxU3yhU0JCsLxHE3D3fNKs9RhFpm0B-V
    psTsUIrFKS9JkKjgg>
X-ME-Received: <xmr:STCkaCRGMg0eCNfuDK8Kf2w6JAJC18SEy9U1OHj4DpGTsrFZwCPYBGU01qLDqqhPIBiYUmN-I7Lq6B-YCUc-3NJ-_Tl0i5zgpSiT1OPO6qrW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehprhhophhhvggthhgvnhhgsehsthhurdhp
    khhurdgvughurdgtnhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhr
    seifvggsrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukh
X-ME-Proxy: <xmx:STCkaIgEEhFM-BCULPj6T7vLkDo-H7DYpYqy_kuKyWOwarOhWtZBXw>
    <xmx:STCkaL88TiFW0WuaCnlwyE-aGGZk8ZQCcMuVR6ilmsKk16gFPI5UGA>
    <xmx:STCkaPHt_yjFSMVnTEMbGKNGTqoTNBKiE_6UR6-_8TU_ihvkkYQ12Q>
    <xmx:STCkaOnZuLuerFYWR7MZL8IF9sFxkmIYJCDxuidLnP6f-salDs1sGQ>
    <xmx:SjCkaB2nFpsGy_HhBHyPrgiXIazFQBGiwMy4dn06q5lAOatL1qY0iXaK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 04:05:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83c7cb46 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 19 Aug 2025 08:05:28 +0000 (UTC)
Date: Tue, 19 Aug 2025 10:05:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
	Cheng <prophecheng@stu.pku.edu.cn>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] describe: pass commit to describe_commit()
Message-ID: <aKQwRaX94uwTwiQP@pks.im>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
 <20250818210417.GE1024556@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818210417.GE1024556@coredump.intra.peff.net>

On Mon, Aug 18, 2025 at 05:04:17PM -0400, Jeff King wrote:
> There's a call in describe_commit() to lookup_commit_reference(), but we
> don't check the return value. If it returns NULL, we'll segfault as we
> immediately dereference the result.
> 
> In practice this can never happen, since all callers pass an oid which
> came from a "struct commit" already. So we can make this more obvious
> by just taking that commit struct in the first place.

I was wondering a bit about commit-graphs. We had the case in the past
where it was possible to look up commits via the graph even though they
don't exist in the ODB. So we might actually end up with a missing
object if `GIT_COMMIT_GRAPH_PARANOIA=false`, which is the default value.
But that might be fine? No idea without digging further.

In any case, the refactoring makes sense regardless from my point of
view.

Patrick
