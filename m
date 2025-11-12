Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025944A35
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928223; cv=none; b=jkA6qvDnXvxYU/d9JGaSchQIxlxzpaLyas8pKnVxffU0UV41zUWsj54NHSTy1uR7g4w21mgvZvdnd1eNPjcxkGaj0U31y/qgFSF9AL8T2U7FUJAaX6SKveVBsRRec6GjSLkfy3kGiY1jteqRnpcUybp6HqFGS/Pr3khX1czXjfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928223; c=relaxed/simple;
	bh=kbII2w7TkHYed+kut4KI+ma46QmNf/xwuonhls264RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfNgTirM/+daGfLZrRKnxkw1TJiT96Rs2YmXZi3uHYExFY6325MqKTl69bxLB5OGVbHmwnhyQWUUo0EC/c3yZX92P0NGIUWg7ZFg8ju5EH48UXloFFwov5rnC1KpLHAo9Tfx5+LMpqSPZpescM0Qx+CK/I/Dh3Y8C3S7Q4FY9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gCxDCXXy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L3RCxBPW; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gCxDCXXy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L3RCxBPW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C28877A0074;
	Wed, 12 Nov 2025 01:16:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 12 Nov 2025 01:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762928219; x=1763014619; bh=HZLV4kpSqF
	jje+n1uvyzASuuE46GuiL1o9K8ofwOPJ8=; b=gCxDCXXyY42uVIqnqELd1b7ce6
	iQiqHkagoLkeCbysxn4kA5u8AZ6ZQPpyPWb3JcdqwCJwLmthKODiHWSvC+QAacw/
	MdX/KcT0P3/PKht4V7wfJrQBL62yk1od2McicnG3JkuIaJX1aoZ24CKGA9tnfOAl
	A2MQvItd2uHFHwErs4SQiWwWhQJEcbzlEjbixHI3Kz3kcUR80diUxMipMtslCP0K
	qIj7RXrBFXzxotzQ+PoKdKs3xzeP2aNJGrdogZpCc8330o4YQC9SRRXXaxfBEy7f
	MtPsorTCoMCDd3ws6Fdl6tnvRmsciVHYUxv3BkabDIT4J2gZ4rm/PmsQ6DZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762928219; x=1763014619; bh=HZLV4kpSqFjje+n1uvyzASuuE46GuiL1o9K
	8ofwOPJ8=; b=L3RCxBPWhiea88ceWLd5KlaQu4NvztPDbezMJKdTB+ieFHUbK+5
	4fPiF8WFuR3qh8/rlyenAehigWItACIAxxbZSH+LOIGcshcRkJBzYEf+1cSC+3Zu
	meWOz+SLaAGzMrOhk7F47ja8EPj0zDXATupPNhRPc6BUYGJSNi9AyQD6GSIPD2e5
	3p6fODP3z3VWKGyW3prFS+4VAIFPULiZq92hUVkABi6uDRlD3LFRH/8mbA/5inT0
	uk7yOQq+BsHGy5XgdSAI6Ew9nt4IM1GHnQ7FVRuVtcDLcx4YatwSmzrBLd89ZJ3d
	CawPXGZWpNbjqCvYNAm4M+jL7sNUJd2d2Dw==
X-ME-Sender: <xms:WyYUaaUsZjiUuBTg2rEhr2Ojc4274AwE2o27N-rVvZamltwj3S2QkQ>
    <xme:WyYUadcm5ih4Q6OPGWJwC8_eoqIkLlLLnkjn1LmLqRp_D37MfyqepzfOKVE6LcYkK
    s06DkcSw3FFknysNentH3phryHrJmbAakhFPBn9axNFXPhk0Iq_xvQ>
X-ME-Received: <xmr:WyYUaWtGKhQtZe0ujZvot-qOqRoJm5tndyFPbqBeAqY13n7E0Otg06-MSO19FYT4SS9xCisUzwoRwa72ATMxWF5UwpYdfpLk8Z9kMO6I8Vo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvsghohhhmrghnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WyYUac9Hicu4IK-kagMSRr_5cayoMfo2jfthVYcuQHUXsj5THgd8-g>
    <xmx:WyYUaR1K4emDY3ThVPmM-T9z9dkANNicVh2QDKsHHQSV6fLr_y2ZKA>
    <xmx:WyYUaRD2OnpVdyKH4hkLMUihBkMctlyvKGjIwQNYX_OYOJkRMKL5Vg>
    <xmx:WyYUaddsJhEB8C8HWBHjknEzcY-YPfIM_u4-Lal-9NZ1-yuTQTGUKg>
    <xmx:WyYUadNxqc0aSrpZ1u8KmnYR8RsU0pFzpMqFIw1b62QXwjVt01KVscJm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 01:16:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6109afa0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 12 Nov 2025 06:16:56 +0000 (UTC)
Date: Wed, 12 Nov 2025 07:16:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, David Bohman <debohman@gmail.com>,
	jltobler@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v4 2/2] fetch: fix non-conflicting tags not being
 committed
Message-ID: <aRQmVPe1RsFcr4hz@pks.im>
References: <20251111-fix-tags-not-fetching-v4-0-185d836ec62a@gmail.com>
 <20251111-fix-tags-not-fetching-v4-2-185d836ec62a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-fix-tags-not-fetching-v4-2-185d836ec62a@gmail.com>

On Tue, Nov 11, 2025 at 02:27:08PM +0100, Karthik Nayak wrote:
> The cleanup section is reached with `retcode` set in several scenarios:
> 
>    - `truncate_fetch_head()` and `open_fetch_head()` both set `retcode`
>      before the transaction is created, so no commit is attempted.
> 
>    - `prune_refs()` sets `retcode` after creating the transaction, so
>      the commit will now proceed. Before batched updates, `prune_refs()`
>      created its own transaction internally with all-or-nothing
>      semantics. This was done since all deletions were made without an
>      old OID, which meant they were assumed to never fail. This change
>      allows partial deletions to succeed, consistent with how other
>      reference updates behave during fetch.

Okay, so we do have a change in behaviour for `prune_refs()`. I guess
the reasoning is sound, but I was wondering why we don't have a test for
this.

I guess the reason is that, as you said, it should in theory always
succeed. But what if with the "files" backend one of the refs that we're
about to prune was locked? Would that be a case where we continue with
pruning the remaining refs now?

Thanks!

Patrick
