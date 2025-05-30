Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1440220F50
	for <git@vger.kernel.org>; Fri, 30 May 2025 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748641352; cv=none; b=oMAhVqqIAqet4vKEyEabxCmj4mThOaVSqBk8zl8SfVIquOfjcImgEYDmZTxQ8UWOpKDhb5LFIpL0OtiMHXrvc2X81tOpLEzHlNVP69viGaDEFvHlGqSpIJNvFKgovcTyv4DFX4Pinh5JUKa0jcr3L0JDC+rxiAsdlqNFhzO1Ouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748641352; c=relaxed/simple;
	bh=HF/y+FIw+ls6JCx3ySmXwgu0qydUKqmnWIf7AP29ExU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AlSVjUddxLjTQVYDheO4UnnzrwOG/+Ucq9CJP1JVvMr7w7QQYhx0MeZ2ZjEbOEk2fuxPM8KzES8AoyITNTL60TpuwlqGdVk5tWkIDaCZXEkMrVp+RH4edZVVEQRqtgfyKP1TwZ8m5LSJifIh8eX+DRtQDN5d5WyD1wzKoC+cb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LSSnI6Ef; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pPstUHMq; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LSSnI6Ef";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pPstUHMq"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C2F4138011E;
	Fri, 30 May 2025 17:42:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 30 May 2025 17:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748641349; x=1748727749; bh=0wDy7tunWw
	ppHbvr/3sKWdlODgm08UfQHtJEGJKwUzI=; b=LSSnI6EfNeuDxkiYuKM15B/7BP
	yj7g1oLQP9HeU04HHDHz59pBjRPA++IRgpFwwoRZdBQu5DnJZ2G/n1o6j/mEtktX
	Vh1UsySGMq61NIWOZyVYXRZpiw8qpdNI3aVIMZYEf7xVDFp8CUVUU3RaBlHqc6y0
	/pwUPwIyXww6WQ95bkM8SQCA5k7kpYRHsqeiCYkbyV54P3ylYEJFF7OchC2mD/H/
	LWp8/NI6wEaTMUHQoZa+TsoNPe7AL9lWmWYG1haPRmZIfUfcnTBfDnUB8dTPyja3
	+UT20hhlT8VEJBjQGPTb3ob0AgpXoVUNN0jS1ueZf2BHI97/Yi88eiVWvxwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748641349; x=1748727749; bh=0wDy7tunWwppHbvr/3sKWdlODgm08UfQHtJ
	EGJKwUzI=; b=pPstUHMq1FzRw7Zrp/gt1o9YQDguBuxYO3/TAxJAfMsgpjz8GY7
	cBLq4luNoIZUGhBFltJmd4/Tks5/0PaFeOK8AHA1fmheZbEYOJvd4w17D9S1EdJY
	1Hnu50DLb6iRdaL6trxFMSg8RI03P8nnlJuH3JB5S2AeHYtVA//150nL1BQdBdrr
	iwP+lmB8t/DZsv/FXrsZJqQafVsCjta+LEtfH44ZUFrVmYpwxJYbdBz6b3Gnwbux
	QSNwGRQIDCsAzzSipZxNrmSyRh6cIUoeDhBQcSCVznS9+SG7ChdASFQfPpZP8+Od
	+aAvOwgYAjmQzRwUNg2oAjIJ6xCmQPlUDXA==
X-ME-Sender: <xms:RSY6aB0L0aGwW6NPng1eBPWJkLjLlA_j4IaQlVQrmRX4lpfUYSQ8TQ>
    <xme:RSY6aIHlr2JfIAc93VsFTc-lh4SjHTqzLB4cwNMXghir3ISrVDmxjEBMcQlaKxHLO
    pFoRGs0Gd8wX-VjeA>
X-ME-Received: <xmr:RSY6aB72YnVNRO3j3hn9aFRdQ4j08jq_mk0FX19yfw_4aIYw0l7SnKVKtLKmucRXK4CIDzLMeVqY4GOcez4kSUCpoe6q3DqLGctJH78>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeftdduvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdr
    tghnpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RSY6aO0qzRDqXWki5VPHpeJYeoZQIrprLnCKgU5rHYbRf6aqHyjj-Q>
    <xmx:RSY6aEH5q9C_dT_4b09fZ6n8ZDU0P3WVS4NObpBT98t2nEz0WfnkIA>
    <xmx:RSY6aP8i_AHMmZfS59og1tgX8XXk7yH2S2LziCbWoHbDOMgG9SQlOA>
    <xmx:RSY6aBmSfTdX5dR5c1igcIOBV_033j8V6fFq2X3DUtIUk4oBmK-8Lw>
    <xmx:RSY6aCc-x_LpNUXX3sY8HIFV_CE6utkqtnMoNpWZNamlK7zoRTISw1jJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 17:42:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2 2/2] t5333: test memory leak when use pseudo-merge in
 boundary traversal
In-Reply-To: <56b24d681cbcedaf5c03c89eee582d554a0894b7.1748628847.git.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Fri, 30 May 2025 18:14:06
	+0000")
References: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>
	<pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
	<56b24d681cbcedaf5c03c89eee582d554a0894b7.1748628847.git.gitgitgadget@gmail.com>
Date: Fri, 30 May 2025 14:42:27 -0700
Message-ID: <xmqqa56tepx8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 &&

The test linter complains on this line for me, it seems.

I've ran out of time for today's integration cycle, so this topic
will not be in what I'll push out later this afternoon.

Thanks.
