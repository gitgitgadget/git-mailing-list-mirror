Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95A145B3F
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744950291; cv=none; b=mrIKxJrGy4gk1/Guy1QVvAGXkfooRLJ4zKMiZYRRdLbhzuaG3kZuNOsjHLyh8ihp58xr+wUF8zapeF7x/POXhpUJosvDgtiCCDhab9fTC5byOi8Q/MqaGw4l2pxx2AL3M5C09UmCcTVTrE6Rt/qJGVRsQqmy/jlj7vwSdDjZHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744950291; c=relaxed/simple;
	bh=R/03WgOiw/YJCmND4V7hnGeylxwWWKUqbOBQXTq+AV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bvAqXtAOk8OCwENg68iQk5GtaEn2FMyFW06jYBzCMe8aWVF3bBg5uh4NGX8nLd6XP3IjUss773ToCBTGgazEhHFsATVRXUC7rk/Mo/ubwCXSIvluhf1Amf2W1tBeo08SjBomrCN4s80YllJzBaH/8QYdUvOH/HSXbjfXsKPUTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=crcbek1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+XTk6dp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="crcbek1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+XTk6dp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3DA5B114022F;
	Fri, 18 Apr 2025 00:24:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 18 Apr 2025 00:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744950288; x=1745036688; bh=1yaHzHiNqi
	MH+6DDWn8fJnqi+kONJpeV0c4ZaQz5//Q=; b=crcbek1HConA71zyKsUg/60ZE/
	F7kl+TiK8EngmvNUpY/Bx/Htxoa2tGFy6fCKeeVcpPRpGbXopui7ao1kytgBS1Bv
	cbCHI0KGmtrD328rJ5lFu1Vvof06na8ee7AsYj2UfnGsZqGoz6pCaRRglk3ttjl0
	8C1vrwnzEnkW2LGmB4V39swtGRDxaVzVBAQ6ee+fgVjBR+xIMr9BVacZ9eJ5CsI9
	2ren0p8BbLNJ+GedHTnQMwWDyNO3/w6dAhF/JhE+loAG4TAw4f3hyV0FWnmKs/TM
	pj+ui1ey3lw+SfplyAOAKZbDgLjhxkdjp61SbX7QOlcfK32yzRynbd4E9UDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744950288; x=1745036688; bh=1yaHzHiNqiMH+6DDWn8fJnqi+kONJpeV0c4
	ZaQz5//Q=; b=m+XTk6dpr+cAvKEi+s1shoVFPxHZg6KMD0rWqPEmcSmcardGH/9
	5Oc5sb43/UGfj+vQTibgvkZ2ygM41sIHZQrMzu1vFMhlI0gi7+ck2uzwXhMXR21s
	5Ind6PUZmhGo64kalSYJxNn5Wb3nvKS41JRkBVWdfvqKt4W7pxwlAEbyVX3WQ6t7
	UK1qE4mLFCznGYy3LOR0Om38YAdEAMsHrBGwTcc8iHWWOKm99ScEw79osuTvOS2K
	x6RW7nkaSjAeh0VDMMuBLfZZt8cXF1eRK6Njc8vJ3DHfJ8ERaAOkrGZRiXhGkawP
	6OYyc5xac/SKaOw/h0IYRpwDHFRa6zpKHRg==
X-ME-Sender: <xms:D9QBaJXNQDFz0J7R06W39x7RCi2-H0iK3YM5canTuvIl9z-zSKK91w>
    <xme:D9QBaJmCnTSmh4kxY9MhXH2zCdRcFHwDjqAAXODES8QnQVajrjFrDY-ACsXehv4kv
    LHVcEHpUujLm2HJ5Q>
X-ME-Received: <xmr:D9QBaFZp0vSxuw9pwRhtERLOD-Z5OXVQ-1VTjfcD-fu22ThyMuR7I2qJonbCafHlqglXhTIb2ZBdcLirJfTbawtscaeoC0Q7OAjj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeduudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ENQBaMWJZTwx5OnO-LyCiyVNxyw8uSWdjI20idGVDgZVdhIv9LHB7w>
    <xmx:ENQBaDlr4gT1aUWQyIjW6382xr42-BymHPMh1jiHT9S61hQdGAWErw>
    <xmx:ENQBaJd5L0iDu8YSZUCJTQXGIv0lfXhA0myRUeneZOs9qIBwLFwM5A>
    <xmx:ENQBaNEARt_fL_p4r5CAKIUO4IqyDupIvjgpbZ6eG_rGaQh6E-VAig>
    <xmx:ENQBaCq1T1OrlxmcAcJLTGn0BThf658DiWMhGmTCMt1ir9Yc3kNmX-6m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 00:24:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 3/4] t/perf: avoid testing bitmaps without lookup table
In-Reply-To: <xmqqcydae8fg.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	17 Apr 2025 15:21:07 -0700")
References: <cover.1744924321.git.me@ttaylorr.com>
	<8cc5952e594b78ffb2ba4bcaabd62a8e5b8fe72a.1744924321.git.me@ttaylorr.com>
	<xmqqcydae8fg.fsf@gitster.g>
Date: Thu, 17 Apr 2025 21:24:46 -0700
Message-ID: <xmqqzfgeaygh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I somehow have a feeling that removal of these "performance" tests
> is less worrysome than removing correctness tests, but as long as we
> claim to support both configurations (i.e. with and without lookup
> tables), it feels a bit premature to remove tests for one of them.

In case the implication was missed, I was hinting that in the longer
term, once one variant proves to be better than the other variant(s)
in any and all aspects, it would be a great move to remove the other
one(s).  It is exactly what is happening on the recursive-ort front.

Once we become so confident about correctness and performance with
the configuration with lookup tables that we are willing to lose an
escape hatch to operate without them, we can obviously remove these
tests for configuration without lookup tables.  If we are not there
yet, and still rely on the "escape hatch" value of the configuration
that does not use the lookup tables, we want to make sure that the
escape hatch still functions, right ;-)?

Thanks.
