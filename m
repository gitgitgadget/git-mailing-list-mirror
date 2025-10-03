Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C71DF25C
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509794; cv=none; b=J0Uu1Pqvg0TPMxMCAPXdigJeK5+deFu8EFTb6sZzw+D7jzWJDRXpJ/cmzt1L/5qm/ND/Ba8ulHTzXZGSDCFKNEPmp3cN8M6XyzXa1a9FPJ5Ak0baLC0hwQ1Ptf1RtR+cH4kzlb3yRiTpKS3N6C8ZF3fz13mCUrUJhSE6Yc/ioyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509794; c=relaxed/simple;
	bh=G6CKvh95PheE21wWw6p2klUUrNEyN7rWGvkuPemMi0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L67flX4V03jINHLT8e69xIi2k6biX8JVQR7IygDOsUa0hc0cgY00EoFIg6Ky8yQO+QaRoKESe1WvEg7J3L67uf9VYoAQ/VkEztPUq3rq9UjSmZQhuoRwSz7Hoj/lwGqw0Xfbi0WU48fkbS1Y1rHaCBuVobYpTllHylleh4ep8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HpX9SSnd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v0NAew9Z; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HpX9SSnd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v0NAew9Z"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 95408EC028D;
	Fri,  3 Oct 2025 12:43:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 03 Oct 2025 12:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759509791; x=1759596191; bh=qhprI0oqUN
	pyEXE2fEq2iigH7oUdP8XpVWe7vC2Xbow=; b=HpX9SSnd2Y3RHbCrsEY3GfXo/3
	ucEhvzJePz5DKfq8gTxBEi88sOc0PzHmprqW5Mh9jLZ7u/N82l55zYf/OEaozddS
	0fQpTUQuKSVvOcg2n7zbkz2xONyxmI07fKnBsfT/jBZhzjur+D/aCpDOWAh59374
	+ezkcb3ApGKKssoDotyhgMOzjB0v6st3LZatDJAPkiXoKiWA2wJJ0Fb5UheqrxfF
	VwhezAwMsJ91WWoHwIQU3s83iQ5v72MtFE7o3K2MJN/Ew9NwCovXTHSZrzfH4tER
	2Sk/DnxzjJ+kOEm7/GQf/xLbultmXpvHvLYOWrX9hZJaWCRiE68AZQgdreXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759509791; x=1759596191; bh=qhprI0oqUNpyEXE2fEq2iigH7oUdP8XpVWe
	7vC2Xbow=; b=v0NAew9ZD8i3413gA6ouAOeKyvwIRG/BQp+yljyguG6WPQyptA/
	8QyD2WNjuc2RSdZSk4/D90y5rYDs+YVHMrtlLeqXomW62LYFMKUZ+VdIDoH6+9OS
	BUTsm4dHoJ+inF0L9gpb6Eic+9oSNFaFKRnDa/LmMP1X1MQxFesTGvZpWWbE4wuj
	bLPvBObceOuak3Z0olGwho7lJvcnUZGwff3epVjMGNQDojDL7Mg2PTftg5gX2Iyo
	f619a/KY+OlBe4QiesLrYhuNVmRwR1lSNlCD7nULz7qF/6E/Ev4YJAnxIUVehPCb
	HK+o0Qe1o/Hm65rhysVBQFH0E9P7N4hvG2A==
X-ME-Sender: <xms:H_3faCBVRhCzw-1Tnma4bvOS_qaPR863qaE5BFwGHWieKPZO6LuAEQ>
    <xme:H_3faDblGXMMcJ9dX5vqyUB9p3GWGvxmGwU0ahSQZEYChCSFErkFFRAHa9kJgNaU-
    Xlc_rv5H8Y2d5mI8n5Q1ws50aElC7Dem9boL1Q3rwpX7YGaJFcooQ>
X-ME-Received: <xmr:H_3faN6uzwpcaiYIb5RXuYQK61iMxjmEKHdmeJ537X-PUUrHvOLnaoJpVes9UiU2-h1MKmNVzkaioe5pXPQa0VyMj7UIc3om-ni->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:H_3faMYS0m-LOrHmSVihx2gZRNnN8c8zybNzXevPMxPEl8f7H8Lvhg>
    <xmx:H_3faEif7ZBH-Tg0I_CoyX9wg7eONlFOTADEP6xjvrqEBs-UkXf86A>
    <xmx:H_3faF_bo3zzLMrhdOZfok7l__YnBdqkmOEnI1XCicjl8E3c_DnHjg>
    <xmx:H_3faHoJqTw3y72E4BKacv1JZjxgq4Q5i96BawyHeg3_2R2jvpBNBw>
    <xmx:H_3faHpos8Qm1v8RAGpuIRflPHVqTF-I_d9eOFI66g7cp8GcagoB-Fbb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 12:43:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 0/2] Makefile update libgit.a: Include xdiff and
 reftable in libgit.a
In-Reply-To: <pull.2065.v2.git.git.1759447647.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Thu, 02 Oct 2025 23:27:25
	+0000")
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
	<pull.2065.v2.git.git.1759447647.gitgitgadget@gmail.com>
Date: Fri, 03 Oct 2025 09:43:09 -0700
Message-ID: <xmqqbjmoueaq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes in v2:
>
>  * Add xdiff and reftable objects directly to LIB_OBJS.
>  * Explain why xdiff-objs is removed.

Both changes look sensible.  Will queue.  Thanks.
