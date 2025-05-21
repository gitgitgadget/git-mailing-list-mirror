Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668A1465AE
	for <git@vger.kernel.org>; Wed, 21 May 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845075; cv=none; b=ILKP5nm0qWQfxY4l+7Wh+/oQw2/2YQpdyEc43t03tHFEhpVOzOsLX2ZpnC8Y7Z4Yf/iEoc2m1A/784pSlKRWX3vCjp4ZVxXdHxTUcvsIyhKIWFXd9+sV4MNEw1KI10zbScAGY59QD4C5/vipx0Xba91siRkA+9PitmKbpssvZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845075; c=relaxed/simple;
	bh=5GHlNeWOdPPSAN3ZRYuQhJ/C03J5eZYS9YRIIIb3Aps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UdVQA19bIkwFS1JeRXFFBiYbU56R63M/8wg/qqp7+g2kwVuU5VyD3xEe2zBfCT8K4lkiZ9lqHNKSynyqQEPwo00GejPyWCJNPNSSgWgjFe2ji3rdCfiwM+h1KNuMHP5G0HTSCPc9u4W6LvoyTMt8r9QOhcnXza4ZjlyxQxJJVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qBojBBoZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGSysXTi; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qBojBBoZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGSysXTi"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DE27114008D;
	Wed, 21 May 2025 12:31:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 21 May 2025 12:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747845071; x=1747931471; bh=4i+JS4ODHI
	BwLvYB1OytxC7nz9uFD8y3JpM4IGRcUIY=; b=qBojBBoZP0Qk9+wsU0hypNDYz9
	QxbL9ycgGu6liRKtd2/qdk0mTOKEWzJwKGwHQZL86OapM/ncSnUEf6o6VX3LRVnS
	9EKqKqPZJu78u8swuhJnuHXXhfR10MsNNWAso+Ticw8wcHklZCpktH1BA4sNeNSQ
	zrF+gxVvkOVYx0HwVTEXaXZrkbveNKzqH0Yfy+3ZrgW76y6jEtneAMGiKBANQe5F
	IkPaxBHbLuhdG177+TVwxFsbUChFtnAdrSiZJ83qWKpElZEWaZ+RGr/YmN06tMoo
	n24BZdLtbdQ3cD7IN7xcScR7lGbNLUB1WTw/M7/SPnfDxFgx/IwHxSX8vvkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747845071; x=1747931471; bh=4i+JS4ODHIBwLvYB1OytxC7nz9uFD8y3JpM
	4IGRcUIY=; b=HGSysXTiCDjS+8MygP8K412FE7g1ZdxHWLFdpatDPGnk7Om3vhb
	C2koo81KAKZ2++0Bc2z0WLbuTBJNgSNl7eRQt9nj5YYkUL8EwGV2LeeKYFNxm6rF
	jgoAHQvbz2/fQ+wzVACGauyTIkMw/yfGjiOYJX/rNb5SauFfiUtKtnAY6/VCh/8h
	3sLirxpDUv+ioI0tx/SweN6IY2qMPXvvjayfTybYNM0M4xIA7hwg2wEd6kIqFpvC
	w5tVTrmNZWZY2u8Ai2qb3012aA+6xYmjekRgqQZULmlaLmPMrg7igFjZRjGeR45T
	4t0qlZkYwojRxo5VLaxZk4EfItPcqxxrB8A==
X-ME-Sender: <xms:z_8taDWfDq9DIffWaCgifWYrw8yLuOg3GoadEsJLHBQ8vGTgz8YA4g>
    <xme:z_8taLmDFa-EED4R1TmED4ltwYTjmuCBIi_ELCEsZuz4ELbTaoHplNu0RTmKLC8oh
    ddTg-r4gz82aMvAxQ>
X-ME-Received: <xmr:z_8taPajbbRpcweCIu8mjZszyjRs0334wrBrKNINwDcRzx9C1rkRNRsmCeDqxXrcyXaAQB70tBnHZ12oS4e36_BS5B09QGqbMOI7Wqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefheeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgff
    kfggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeejgeegfeek
    teffgfehudeugefgffevfeevvddtudevhfeiheekgfegteffkedtnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    ehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:z_8taOU_qRNx8UPkXsHnxEiv9efPxlVJ9aaXLtj_9x4NIk0C8EdMfQ>
    <xmx:z_8taNm21ydEZuEwriX5nfKm_Uzu7FJPfSZqu2VqIRgPW7Ceht5-3Q>
    <xmx:z_8taLdsEgQWZ9rzTMViMz2nEElixQHRX1KIhFs4dzTxooBpUPd8wA>
    <xmx:z_8taHFF1qaSzq1xocWa68kOFqsL4k8E3HRU5l4BSaF2s1h0CPWxrQ>
    <xmx:z_8taEQ-57mq-NjwpmbUviZvhE1q4H0PyZO-BDAgX7fGg5sFqCxu18G1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 12:31:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v5 0/3] align the behavior when opening "packed-refs"
In-Reply-To: <aCS7O8tNekg_u9Wp@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 14 May 2025 23:48:11 +0800")
References: <aCMnrwkoJ2WyqGZT@ArchLinux> <aCS7O8tNekg_u9Wp@ArchLinux>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 21 May 2025 09:31:09 -0700
Message-ID: <xmqq7c2aapte.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> As discussed in [1], we need to use mmap mechanism to open large
> "packed_refs" file to save the memory usage. This patch mainly does the
> following things:
>
> 1: Fix an issue that we would report an error when the "packed-refs"
> file is empty, which does not align with the runtime behavior.
> 2-4: Extract some logic from the existing code and then use these
> created helper functions to let fsck code to use mmap necessarily
>
> [1] https://lore.kernel.org/git/20250503133158.GA4450@coredump.intra.peff.net
>
> Really thank Peff and Patrick to suggest me to do above change.
> ...
> Change in v5:
>
> 1. Improve the commit message in the first patch to be more clear:
>     1. Talk about the current behavior, what error we would report if
>        "packed-refs" is empty.
>     2. To align with the runtime behavior, we should skip checking the
>        content of "packed-refs".
>     3. Why do we need to report to the user when the "packed-refs" is
>        empty
> 2. Fix grammar issue in the last patch.

The thread has gone quiet on this topic.  Is everybody happy with
this version?

Thanks.

