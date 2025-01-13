Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3C1C5D4C
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782833; cv=none; b=NMW+GVnFlCacUC+KmUHGad5EaopG/2nHdiG0vzNvFW7x7MsjlYqP+DHlV78ipICC5olyTQcDyBMekB18kfZTYzl9PQSWf83oKyrN81VA8llAT1PJkpUSZitZpxvqq1a+C5F68cZFW5BH9W2jpKCbV2RkuCz3WBIE4FoeRky7rJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782833; c=relaxed/simple;
	bh=DSiNpLtjkbh9aHFgcWsAC07n5NyLJGvHUxSXFBtAsHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rremjTDm8oQ3YP4m9pVdemQMbm0FUY5Lwu0QGPv0FYzSj+1DiOSFEsxIQtKUKLIHh7Lg1raSogDs9ydYomNrQ3ooliK7pN13GbjRzBVfj2yJbXcZbCpKjYKW400hV+CYLDl1H3PPTpEFpviD3VTzUif0tbnBb+UHct/F8HU8iGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kTPIOXaE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bZ8FpQa1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kTPIOXaE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bZ8FpQa1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 156C51380833;
	Mon, 13 Jan 2025 10:40:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jan 2025 10:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736782831; x=1736869231; bh=DSiNpLtjkb
	h9aHFgcWsAC07n5NyLJGvHUxSXFBtAsHA=; b=kTPIOXaExQ+CDTmt2L8ebqIV0H
	Ig+TbMYGfqnv4Kqp1TDpQf3m5oFOT6LtwftHkHhhqlMS0mS2NQW/68hADWI9Bt5C
	dwisZqs4sNmXXLsmIQb1/sPSF5t8pzYIiKpDKcX6vQxX9UzeaLsQPuTT1ehJ6TUn
	n3dB0a2CKvLOaB73rNUkL2SDj1r8CvCTqSRyCtDpIapjhwzHjpuM09NyNpm1GuH7
	GB95KuJciapLdtEV+QxTR7zA+Tb1RUHycVJbc4l5CHKu8PJPVkzymlSsXxc5Da7J
	dZGgoFqmdaOTGxsQFlhOnJuMG50eLL9+y+AzmS+sa5PzSXg+PVBZex6UuP1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736782831; x=1736869231; bh=DSiNpLtjkbh9aHFgcWsAC07n5NyLJGvHUxS
	XFBtAsHA=; b=bZ8FpQa1STv3rgt6VxQf63sh5Ajieu/HLVcx/7QLFRytRGb9iUU
	NOjT4pQuyis3O6dpQHGSpbsY0J5A0+F8p2lkzrsj14vijYdlQ50aDHEHLRbbt6vt
	eXSHYWgMLj0Nf/PSY1Kop6fhF6j+qkdei13rwRjVSQYVuBSx/8N/x5o3og7tGVos
	ddHdQO/CzbmQennZfZu33L7CdOX1IwGXweLLBbkDGtQnhClXREV7L1dcM9sDOXuV
	d/+bbg6kK0fMRIPclyOzwKo5zJh2ibnhPlz3smKclnZBla6zEapv050emuE7QECj
	TKSDOhbnkJIQfxDgjNn9HT3fKxzTczHq/eg==
X-ME-Sender: <xms:7jOFZz0HLA7RUBLOkWiFxd0EAJGola3nJp4gWScOOf7MFSYRRzvA_Q>
    <xme:7jOFZyH_cXGVrLi6-uFDtdXo6iCsNJyy9c6ykhknx0vbAX5uAnieB5OCcO01zT7Yo
    8kQij2V2hsC4mUBlQ>
X-ME-Received: <xmr:7jOFZz6fjYDlP__acIpVgojkHc9XsgagxNdQ67h8i2nTi_udpVQ8JQs-KjRzrb753NV4w3Bl_9AznZeJozWDPIzTGRViA_6RkJcpqxXCCDJSxlIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopeifihhnkhesshgrvhhilhhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7jOFZ43tac-cbC-OlrROgL4ZHF2SzXlmiFMuMkrijy73vuwLoxh83A>
    <xmx:7jOFZ2GXxvvoTD2jAjMn15DUf6fbMuugWNQ8I5SOVN1nIXkV_g2qcw>
    <xmx:7jOFZ5824svNRzAvg9fkWxKKr60HVtkZ08-UFIREm69xn5c3G3XzaA>
    <xmx:7jOFZzmtlbvqm5vQeErjeQFp7uLM6BTZ_UeMDvrDbpFsf76O66yY1g>
    <xmx:7zOFZyhKEOp6d6_a5wYbfjOHmAf_79p-f3MgC0aPIKs1PY8CIdsz5xoP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 10:40:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3be974a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 15:40:29 +0000 (UTC)
Date: Mon, 13 Jan 2025 16:40:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Wink Saville <wink@saville.com>
Subject: Re: [PATCH 07/14] tree-diff: drop path_appendnew() alloc optimization
Message-ID: <Z4Uz7B4J89NphNF6@pks.im>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
 <20250109084649.GG2748836@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109084649.GG2748836@coredump.intra.peff.net>

On Thu, Jan 09, 2025 at 03:46:49AM -0500, Jeff King wrote:
> So my conclusion is that it probably does help a little, but it's mostly
> lost in the noise. I could see an argument for keeping it, as the
> complexity is hidden away in functions that do not often need to be
> touched. But it does make them more confusing than necessary (despite
> some detailed explanations from the author of that commit; it just took
> me a while to wrap my head around what was going on) and prevents
> further refactoring of the combine_diff_path struct. So let's drop it.

A 1% performance speedup does not feel like a good argument to me, so
I'm perfectly fine with dropping the code, even if most of it is
actually in the form of comments. But that already shows that it needs
quite a bit of explanation.

I wonder though: did you also use e.g. Valgrind to compare the number of
allocations? glibc tends to be heavily optimized with regards to small
allocations, so you typically don't notice the performance impact caused
by them even when the number of saved allocations is significant. So the
effect might be more pronounced with other libcs that aren't optimized
for such usecases, like e.g. musl libc.

Patrick
