Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2D1F755B
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163220; cv=none; b=bKnzeDKsMP31SRgtwDUhv/kJIBbpLHyozlHsWqXxJyJOMBvDGCTxXdcZfXq4q1UaJvOKB+1Zi1cHLn4dDu0XBzb9dbfGyE3a3tngKQaml5CC+lR2ASGYZPzZZRA+Pt4QqToEZNG+u+tFVjKLWoZtAIQ4WTnMUpNqJCKTx7W7j9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163220; c=relaxed/simple;
	bh=R0Km0p8QHzdkXRB4mh9MXq7LC41D4zLQype5U3SldP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nXpHK4dXaBCo2jwkfYbIBIwpLHeCUpQm4LSbyDupWiMttCXaa4H9f/GBJh1HjytjwgCGDAE+3WjskYoIdXXGMNaXkigfbkHVWQxLdwTWXBH6RzemkBwnVVXIFsK8SoD3PfXAAy4XEL3lfLqRu3IwG26ApqK4YX+qxsyMBiFg47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=omwons8p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLjswUOh; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="omwons8p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLjswUOh"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 014E9114012F;
	Fri, 21 Feb 2025 13:40:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 21 Feb 2025 13:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740163216; x=1740249616; bh=1gHfM2cA2o
	W4itn2/eccY9sgbYvKlkdTCTDm8d6mjPo=; b=omwons8p3XOCosRoBL3fvBkQYu
	hsOzLOcDvE6tl+fgeu49p/b0iBKQ0bxSkrw9YZ+jmXGioxRrR+UaMFyjVIbuBcQn
	T2yDUAQurWnubFsJUHTIaLNEqETXsxuOUmEK/TBArUMOeHtkn3aEJx5tYxh8cwJo
	+L8QBO9hxprO4VC5QF9kcE87vIu0ZBvm/RaSkMBqYn019vqQweXSaGDsjBWtH7Hp
	uLGC5tq3MRpobq8R4Et5fpJdNOgXj+4aRdntifpFBFLV0mjcyZnpFd6We/Qy0hl6
	f4xn/3+uyNqNwPSLXKaqMjk03fffy76LnuqvqE1QnMx+UnaUau5CEgao197w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740163216; x=1740249616; bh=1gHfM2cA2oW4itn2/eccY9sgbYvKlkdTCTD
	m8d6mjPo=; b=nLjswUOhRKlomJ7dQLRzwKIA0VGUB4CmOawQlQ1ZbUgb3mSIJjD
	WfU84yvCaf2g3VgpAEBah2BcMtjuyzsmtKLTWj8HGHzCkIKC2Isb5TPZTFI1zrdp
	0wsNwneIYnaBbnSUyYKC2eHjKqhlkMa9HEpSv/EXmwbMPWCIPlxO9qYHlMkS0thN
	Njnnmjqw0a+zPF8wvFgXmSvSq5S0keL/P4gYRTKHla91RNg8hWYuuX/S6JFo7v8Z
	2YhkS4AjECKPIdABmFZm+j07++eFA2nHRi2VW9Ny/fFuFk4YtYvBRhvqWIQHTbfk
	bfpmpYOf6wrMErJFdQS12gEhwQ/0a2uxVgA==
X-ME-Sender: <xms:kMi4ZyTjTxCUXDkiWqAFPHYokS2jUet1TmO7HPYldl4JqgPJAYhbAw>
    <xme:kMi4Z3wqPJ18LS_e-p_QdSIvu9_kIomuCY00hZSH_d0uEv06f5VcdE7h56YQS7_Bk
    -UMpDW0H2QyBiLPjA>
X-ME-Received: <xmr:kMi4Z_3WeaqFB0vZQDobpxVgSmz1rgqrGBG40vz_0eX9uiHddsgIHIan-mdPs7k_jtbYOsPmsxf6eQA4K4eq5ffqi3dN80aYYxuwZlI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhi
    ughgvgdrtghomh
X-ME-Proxy: <xmx:kMi4Z-BDJ-na6HYS70SuBf4zJi2916tUCs8RAsWSfcyHD1BZVnvkuw>
    <xmx:kMi4Z7jqdps8SjQE3kiCkQ_Rmgf7gkuz3fmU6w7040l1Klh2EMTBOA>
    <xmx:kMi4Z6rcCXsKQdnsdtB4zfOEo5m1t5-y101VkUgTTa46bsQmHqHGjA>
    <xmx:kMi4Z-hByYoFaKmnbuliBUodp7mPJcjhEHtbDTo-B2hbCXi1UTYfbw>
    <xmx:kMi4ZwabzVJnr4uI08zIhxFtZBpsQv3QovD59udganbZq-AMJxEGDPY0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 13:40:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Karthik Nayak <karthik.188@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>
Subject: Re: [PATCH v5 0/3] Introduce a "promisor-remote" capability
In-Reply-To: <Z7g6eOmgRyP-BEcZ@pks.im> (Patrick Steinhardt's message of "Fri,
	21 Feb 2025 09:34:00 +0100")
References: <20250127151701.2321341-1-christian.couder@gmail.com>
	<20250218113204.2847463-1-christian.couder@gmail.com>
	<Z7g6eOmgRyP-BEcZ@pks.im>
Date: Fri, 21 Feb 2025 10:40:14 -0800
Message-ID: <xmqqikp39m5t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I'm fine with this version of the patch series. There are a couple of
> features that we probably want to have eventually:
>
>   - Persisting announced promisors. As far as I understand, we don't yet
>     write them into the client-side configuration of the repository at
>     all.
>
>   - Promisor remote agility. When the set of announced promisors
>     changes, we should optionally update the set of promisors connected
>     to that remote on the client-side.
>
>   - Authentication. In case the promisor remote requires authentication
>     we'll somehow need to communicate the credentials to the client.
>
> All of these feel like topics that can be implemented incrementally once
> the foundation has landed, so I don't think they have to be implemented
> as part of the patch series here. I also don't see anything obvious that
> would block any of these features with the current design.

All of them smell like with grave security implications to me.

I am happy to see none of them are included in this round, as
getting the details of them right would take a lot of time and
effort; it is great to have the fundamentals first without having to
worry about them.

> Thanks for working on this!

Likewise.
