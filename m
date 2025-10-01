Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C03594A
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759361533; cv=none; b=TleFeeh+5gy5ULFiQyHlAYLCqLRrQESwh36ow0Kjm1trxT9Q4OZSO2sDk60UOyGbBg+RxCMMz96Oxp+p3wjivPh87huKRiPE2XvO6/2y9lPQxDpcV4urWFIn7OLm7OepdQpi9Dc5Bo3yCLWDZzThh6bgESHreixNbS/Dfh716Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759361533; c=relaxed/simple;
	bh=/erN+C63cg3i/Hl4qyE2K47STXHLUIOR+xcLHBxR++Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dcCJhk3HadsxkOLlbBUP/smMpiDpV1i0AasRuKkWgwbR+wjldhdLm/2oTgLUTV9N9Idf0n7EnGZn9O0s7j1S7SCzt21Lo2tRj6u0YKAUCg+UIXRNMmnh1HwXFuGsVBUK1B6s6qrDKP/qU6xZn7ufRTgxyNMmY4fAIkr0m4586m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hgNvhZqu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P52ByDDk; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hgNvhZqu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P52ByDDk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 71E7F1D000F0;
	Wed,  1 Oct 2025 19:32:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 19:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759361530; x=1759447930; bh=CUfTI1Ddie
	+1Z/E9uK5Xuoj7OPosWvOE4721GT7gDGk=; b=hgNvhZquMrQz4pjCnOwu0IRU9/
	bZOVm9m855wrlSzFxvB0y6txs+X7abG/DiT+9j5j9kgD0Bk7JaIOLUgbYdLuGZAg
	jCgV7Ub7zWK6+8a9UVJ9FJW+yuqMYll915AVU9R/osbgCbDGUZG3wUFNxv+cG5WW
	LiE6djqideIWtnCWHYUZwcttXVjZcVUdHS5XQrA3CBmiF28psmJlGNvYGvcbbyeH
	qLjZecDB8kUX/2YFpBHrV9jOr5v6BKCAlQgOXiZRy3Fs551/IyrD/1jCTpWnlGof
	x6bLQIn0k6R1C2uH4Zrs2NaRwHIHZi3kzm3NQBiSpD6Gb5a38rRyV0GeBhkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759361530; x=1759447930; bh=CUfTI1Ddie+1Z/E9uK5Xuoj7OPosWvOE472
	1GT7gDGk=; b=P52ByDDkVjFzA0Ax5MPxbSVh3LUnqnDHw9bgF70811ufcXNIVeD
	smMiGhymwLIcLbSse5oJfeqU2jrAm5eEp9l/7DdXC52ox4tFN+GVJkaRLuuXtPrm
	XGL70Dio5Ntx1GVJLFYJGixXmxzR4N6/g8/x8aKVtmP5hCdVY8AU1t0YD95MeXZU
	2MoWDVxpvM8QMjn/+jQDGhUDnFCP74pAfm5+iLVH8Mj/5k1pgCOEIEBUUKMfxhu1
	IizVzeg9b8Atbv0cnDweDLLiuyxnLipBL4K5wzWEN5lZNb06mwtWQSgu7PhZeM7H
	Y5cFZU9jHAFHzygk87lkDQxEIECpEep7Svg==
X-ME-Sender: <xms:-rndaHnma-CfIFz3_iIAzIb2XSGgTfjakh3_cPLJ7Y8-NrH-zCKnAA>
    <xme:-rndaB2YvEfCEq8JCfFymlxg5cFs_ZNs52IJaI4Gj0C0in0qYYbCObtf9MCOUfq96
    wopSnL6cjqrTfHV6rqZJ8hdThWpwvCfynFrPBY6isni01q1ntIsi6k>
X-ME-Received: <xmr:-rndaCrgnMoXTIaDrbNlzhynYGoFjJfeFXJCyJJa3Szc1Qy00X1Jsepl27TOqYezj36brIw52urmDTQCMOjX63Cc4lHGvt4tZb9D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-rndaOc7CSL9uPclgMatFxedzWlKx5C1j9U7wRnj6KNckEFthCyvsg>
    <xmx:-rndaBpB9QHJSv2V5iYekgje94UEquyPnNfcb8tjPvZAudZqOHp9tQ>
    <xmx:-rndaPFheAy2K5By2tCs0nhMQdgMvABH4-tK8jRb8P7zIAPlTvsgFg>
    <xmx:-rndaBtNV0cjNXbbWUyNIsJuB16_7dM3psnq852sUY-r4QiLc0YxYQ>
    <xmx:-rndaOIeoKfSGNH1Bc19kKO8_puhSLBII4h_vxwuVBPGeAT9y6buSnc0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 19:32:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/3] Makefile update libgit.a: Include xdiff and
 reftable in libgit.a
In-Reply-To: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Wed, 01 Oct 2025 18:02:25
	+0000")
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
Date: Wed, 01 Oct 2025 16:32:08 -0700
Message-ID: <xmqqecrmyz9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The Rust compiler only needs to know how to link against libgit.a in 2 cases
> that I can think of:
>
>  * Rust unit tests
>  * Rust defining the main function
>
> Otherwise Rust can be compiled without linking, and then Makefile and Meson
> can use Cargo's produced static lib files to build Git.

It is a bit unclear why two (or three) are so much more hassle than
one, but OK.  Allowing both build systems to agree on the same set
of artifacts is very much desirable, and if meson based build rolls
everythning into a single library archive, the the other one should
do the same.

Of course we could run "ar" ourselves and combine the three into a
single library archive, but as an approach, what you have here is a
perfectly fine, and more preferrable, way to achieve the goal of
ending up with a single archive file.

This topic, however, especially its first step, had caused rather
unpleasant textual conflicts when merged to 'seen' (I didn't check
which other topic was the most heavily conflicting, though).  I may
attempt to get a clean merge again tomorrow, but due to time
pressure, tonight's 'seen' was done without these patches merged.

Thanks.
