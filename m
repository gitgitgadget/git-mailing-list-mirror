Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE811CDA16
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811358; cv=none; b=YO2hcO3Feup8UQJ7OFHCR6NlOaIoZMN6V8XspOdhjP72Wa98lGBQYJl83agBwSc6O6/FVylmQg0nbXdNtyGaiA7AuoHfIrNwsx8J7blF8S9EVtoYbN/u5QEzk78qSPNT46Z5XOYufFAqAlE4u8UvtvqbBjmiQUzLewyOTQXVTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811358; c=relaxed/simple;
	bh=mBrVUcELjXXdvGhmOWGwqW4h/zATcur3EFc9OZ/Y5QM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nPdRfbStcgTFPMXhdxc7C72WVLIg6S8CkAUp+0VDSXPYfR7P6URU7uBIknsdiixyKEoya05pUCvlTQC0/aIV49vRNtiwDWZiR1OioV8r9TCHpsLIlnEcYlS2IvzkIDHnYqyzWDLVHLDfZk7WnoqmYnFeGOiwl6EAF3GGdmUSmHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PgrIwx/j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mBHF3pKU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PgrIwx/j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mBHF3pKU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 968F413811F6;
	Tue,  1 Oct 2024 15:35:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 15:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727811355; x=1727897755; bh=gsaUxwXAlO
	1Q3VfaTkl+nnUqMy06YI4ix2sBCCsxXLo=; b=PgrIwx/jD918PaON/bzmynXTcc
	9xJ8RMKL0QFnvWBDAow1iecvc4dk/tyaFre1X7CG800lUUJzjbZtdA4WP7ILe9K9
	C/ICXpVgpVxRhsM1mzleNId5LWggwig1b8kCNCRQHiYhqErjM2kZFisjL/+OjDSN
	Jmk5wo6gfSyXvBtAa8Y3AvUi+jna42O7/vUBGmBpvk+pcDKbIIHs49A6t5VwcSMG
	0yZLptobYGaXclmnZZucBhBAn7xt/fudAu7rOR94C/Kf7dG+/h4xgUlpjJG0Zlkd
	Lt8IN10uqlOPW1+V88gShGlYmEh0jPMAvjUUSsUoEEmkw3qQnW8/6S+m+/9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727811355; x=1727897755; bh=gsaUxwXAlO1Q3VfaTkl+nnUqMy06
	YI4ix2sBCCsxXLo=; b=mBHF3pKU2OiB/Z5ckWKK2HLutadEQP5i1DNecrXy0zBi
	BZopmLTOAy0Clc/Z2YjdsgPO7yWlgRGV9zAWlh7YFlaryhjGfNz5LQIciQn/yEJn
	BQeoUT1qZ3fsIFvrzdhAWEbxKXqlT7jffoSeITDNT5YGP3pvJA0bHnz1HqJB684j
	MBLJ+xS4YKse1ardVzAYjrkM7HLTPNqkVuQMNmKq9HGjJuPSyMbrDQklX9ENuxVH
	jq+A5zEMooGq/cq6PwPboLvi3HgGIvOT+oZY5Ad9wrdt/LFf+pfcVxnERH4jaNXU
	lCqXIEJirQ58hiXb42/CiVxwaLZwQw2+yzh1VqFr/A==
X-ME-Sender: <xms:G0_8Zlyj27sQ3yvPhKe3meWpTJU_GgWPEMK8Avwxs26K-jzHCqHUzA>
    <xme:G0_8ZlRSD_ppBDlj7h5V1ZUcCEEFYSjpzksyuyJHMMf96qAXTnYWciwBPRXDMx6_J
    6ipx5xFBerGKzhKvQ>
X-ME-Received: <xmr:G0_8ZvXdTfHdU0WfFBECbsuFf4ccgy2yBM0sqIJvqqezOqEw8icdH0MyNDqzgn_2RaF3PO2SFeSBL9bsy5x-eBOg0o9ys5Mo3qzPItU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghlvhhinhifrg
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhrghnhigrnhhgrdhtohhnhiessgih
    thgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopegvmhhrrghsshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhokhgt
    vghvihgtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:G0_8ZngLUQzNiC3OSZak8feCMogqHVZCJHGzICuGWeHY4Wj2cSiZqg>
    <xmx:G0_8ZnB2s-2BeVxvyPY98Xv2eEyNOGyAC5DBA57wD4chdgQ8ug7LGQ>
    <xmx:G0_8ZgKq-EFp1KnkEtHI1lZ-eYkj8iUt9gtfDKEhh9j-wiIN989kWw>
    <xmx:G0_8ZmDAE2jeLIz_cmz7TGDofviDx7OY4hg2D2kFgztEh7nv7h9cpA>
    <xmx:G0_8Zr0tNIsEIQBH-9ViCZzrWE2h76IVqt-6a5g2P9sMl9yQ2bFNQHpQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 15:35:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: Han Young <hanyang.tony@bytedance.com>,  git@vger.kernel.org,  Jonathan
 Tan <jonathantanmy@google.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Enrico Mrass <emrass@google.com>,  sokcevic@google.com
Subject: Re: Missing Promisor Objects in Partial Repo Design Doc
In-Reply-To: <20241001191811.1934900-1-calvinwan@google.com> (Calvin Wan's
	message of "Tue, 1 Oct 2024 19:17:51 +0000")
References: <20241001191811.1934900-1-calvinwan@google.com>
Date: Tue, 01 Oct 2024 12:35:53 -0700
Message-ID: <xmqq34lfvco6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Calvin Wan <calvinwan@google.com> writes:

> It seems that we're at a standstill for the various possible designs
> that can solve this problem, so I decided to write up a design document
> to discuss the ideas we've come up with so far and new ones. Hopefully
> this will get us closer to a viable implementation we can agree on.

Thanks for writing this up.  Very much appreciated.

I'll hold my thoughts before others have chance to speak up, though.

Thanks.
