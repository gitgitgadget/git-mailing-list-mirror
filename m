Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C52A944
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020325; cv=none; b=bNoVhnTofTLfFi88Kv2nizXvRx3jmptzwQaDX4uMjy60CfTtnFQ4pqmvmR26m0ZuMSEAYOyQpwEdWk6+wtOnkKI1cVdamPBVxZRI0G/kWOi52QJ7IeMaL90CwW3ME7GJK7/ut84Q6wUiSZ7bC1qAtguujGfIGWlRmvf5uCUn33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020325; c=relaxed/simple;
	bh=tOrJyNsghK0qj2mDK9lADtFy9Cg6jKCS97vaEDqRItg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qGAC6TsK4b7lQ6VySFJD7FGibgsY4Erk5DrBJ0SQ6qyz1O/eJSIetNjYyhV6vF+774fGiW2adQZCDhMEJkBh8Uw0/z99oCMYatw7OVrAmA3f1s5ljxrsGyfvJr49J9Jy2h3CfFGq74gFZsUtGDBHmhKiZYknoUObcCD2dc93iXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E/evAqNW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SzmmNCo/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E/evAqNW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SzmmNCo/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A6FD57A007B;
	Tue,  8 Jul 2025 20:18:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 08 Jul 2025 20:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752020322; x=1752106722; bh=gDrTv2WD3i
	mLCMjymj5r0k3qAGBV42+nmeHu6XlANSU=; b=E/evAqNWrUzmJPHNnjym1p6V64
	8H8u+ScSGjGz+ru8fZ9vdGg9uQp57NcZs4WtPN5GKtHmrg8BZWPI+cb7zAAh5c3j
	PVJZ9oQoIb/pA9v/aVIVP+xWibrkeMPDKA9wmTYLYuXX4dCCiBc0N0I/Z7Hi0/gT
	ZOCL1RxTxwMHDWOEbIwVSECUi3+oK1KynYVTVzm50905amgnexUHYRhEHIwtUHJZ
	NFiX7HJ3EBncG0KLZUyLXSuvu+jggQHYqtPjMpI1GfjpYfcMceXGuhIDr1H4hzi6
	cYid34666G8AdejEgEEtLFVQjdS5tVPSny0cxnJLkxmCxzYR+ym/dBOa94Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752020322; x=1752106722; bh=gDrTv2WD3imLCMjymj5r0k3qAGBV42+nmeH
	u6XlANSU=; b=SzmmNCo/uD/+mMdAb6qnA/NXNDVI6d1DEEKia71zkgd2N17Ywuf
	UBxrbcycngz8Jcwz73yh8caecuWphbiqf7uTCSsHd+rFznp0SRSHZogpTWI0CDWa
	sIhibOo3JPEoQ1gC5nQPvsspAGXr2iF0p1NIJA7vGyR/39vJK50HsIjmOgssfKxu
	gVjmn0PLnVSlUoFWcD5d9uTLY0J4KPSm4YI19gDocvIRizT23qguYJxHuE+RNM7T
	tB2lYS0PtcIIGtYl29/lUvO5XcCGYd9j4td38xQs/FZkHYH/3I8WUTyZDEImI+Jb
	fLbI0/X4HwAwo8bP5ESEZ1Cy3FkXQVAK2ig==
X-ME-Sender: <xms:YrVtaGwk0snOIcNLtEb8XxoBWzHQsOeWyMBykw6eemfb_RR5MhbGIg>
    <xme:YrVtaP1lBuJeDxjc17tlBcKLFktCxEOPn2E4oWa9BIKQWxjKO319s2r8n1hWdyA-2
    5K7VbzHq-hUk2bJpA>
X-ME-Received: <xmr:YrVtaOwoRvZ56L7zDcfUOh1TJLcHHMzCPuvz_CJcUTtf4w6WUmqPAEp3EmhzlGY5vAP2_jLiIzbiiuMYSTOM3HG1ZF30sLdrkCnL4_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefiedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YrVtaOFI6I3phOQzlhf94qnJXSn-trskc0BZJWlxBjQVMM06qHjNDw>
    <xmx:YrVtaJaNGr1TZedcYZ-51k9s2PaYC8lN1_w_Qz6iHkKbmQvHFKLscQ>
    <xmx:YrVtaIBopW03dQIGVxKmmtij1rWeJ1GRCY9RnFubwXSeyR-BbWWBaQ>
    <xmx:YrVtaJl5uS92zknNiL48DBdBsl7MmWXgrReoC--BjC3zQc__aVkiTA>
    <xmx:YrVtaOhnRWjIDhrpjsVivuJSL2XYg_bpBgKbZbiIj2doM7clHo4Z6xLR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 20:18:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  shyamthakkar001@gmail.com,  ps@pks.im,  ben.knoble@gmail.com
Subject: Re: [GSOC PATCH v5 0/3] environment: remove sparse-checkout related
 global variables
In-Reply-To: <cover.1751309770.git.ayu.chandekar@gmail.com> (Ayush Chandekar's
	message of "Tue, 1 Jul 2025 00:57:45 +0530")
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
	<cover.1751309770.git.ayu.chandekar@gmail.com>
Date: Tue, 08 Jul 2025 17:18:40 -0700
Message-ID: <xmqqbjpuqkrj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> This patch series aims to remove global variables related to
> sparse-checkout from the global scope and to remove the definition
> '#define USE_THE_REPOSITORY_VARIABLE' from a few files.

For this topic, it seems that the ball is in the author's court
after a few review comments.  What's the status of it?

If it is back-burnered for now, then we may eject the topic out of
'seen' to make room for a new topic that touches the same area with
overlapping changes.

Thanks.

