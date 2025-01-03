Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE71B21B9
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931561; cv=none; b=J5XIV4L6miQFXjD8thlQKH4DzEA+1zlGD7IZu2UnAlGSK5hgz3HJqWhz3XPMnimQet/5O3cPin2zUuloIqdlrJHuXd6Qd7MyuEhCbOOFjTszByitcWGUh1otes4a9rKD0sXPcVhQnafEiKDPXBrzXBOiZ4y76ti4RhkhjqL1Jeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931561; c=relaxed/simple;
	bh=sNTtRB1nggkkZuWqwoebwJoz0O1i3llYMRuKtQoKpiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H2RZV3AyTS7jnbATr+xhL2e5sh+zzy9zU8F8AZzwE9T0in4yU6QLFrdsUj9xUGVJT7HiPPubWmSHdxuTAkBilzXPTZ287kL1+/GnwCTYDKsUVJC8JG4Lr5PQgzxn467Wt1UdrQ/T1IyRHi4IRV24g742jc5VQcYmuktywMwpIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tIsZr7FZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T6AoC9sF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tIsZr7FZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T6AoC9sF"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A6BA138022D;
	Fri,  3 Jan 2025 14:12:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jan 2025 14:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735931558; x=1736017958; bh=sNTtRB1ngg
	kkZuWqwoebwJoz0O1i3llYMRuKtQoKpiQ=; b=tIsZr7FZRWbhX7qBvIzUvkADw/
	Qdeo5AQi/DFVVfoIKge22PCZ+E9k8ugR1scQo12bmzAtPO5yO0FOOwN3RZee1mUY
	+WxDxu2KklkfR+xd7TcW5/Nsv9uYBooEf7RaDYLAj6aZ2TFos+8uPJj2Fmxejt8z
	hmI0D6yX1BHvvxGUKiYEzaB7jV7r/1wFOwu8zKm3glrmBmZvmTftgjE6oj9UueRV
	JtxdbeXliC7UYjx2x8GDjoCKJ8kKTQKh+dXJm+NxRvL8MLDAFaQYtMEydcL2PC+b
	hSz3Vt48uvPW3hgleOU5sGtunZVMHROwYI2zCMuZEdBJxMgtgZo8kbSbping==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735931558; x=1736017958; bh=sNTtRB1nggkkZuWqwoebwJoz0O1i3llYMRu
	KtQoKpiQ=; b=T6AoC9sF2+e/NnHYIF98t4uCxyUoxH3dl61cCZvpTtBSnNMzq+H
	KYwlOSxTFEYdoeiZQmOSU0tT0C6v+6nEErAYBLveE4frKM5CvqqJ3jh3tIPr5v+y
	PbjwmTQ9vmRq9mU90a02q50mKw1Av9Uib4VfezUPPUgBF7LGaIE7lc1gHOG0nfb7
	qzR1X/Uq93dsEJZ+CVO4PVL/GiTlZpsqqsFeL6oRuWQvg0xnmqXI4T9GMADtt8Mm
	6LYGM+kNmrRWJa4RGUU2RR7ORo0VtDUicX1VldOd5Xah/opKYGgYpRx+KiEVh8O4
	y/ahBYa0EzfkKt2+C6ow0voChCbCg+pffBA==
X-ME-Sender: <xms:pjZ4Z5Dww8OwLw_waNgZCJvoFKBmG1D5lmhIImkzLzAlFXuK9gRtEQ>
    <xme:pjZ4Z3jpRFE6PGAJjPzXovANjY78vIWodmW1gTE2w-iT7veG0exgR9OZdQqor2AiI
    rc7rSfbpEN44H4LYw>
X-ME-Received: <xmr:pjZ4Z0mQGcbMiEPCukok2IN_my4jVuU5i8OtsHZGd5OpjtQ87YnPGLnaXVXif4wVRF-BP5YTmhuSR7XsxHTIGjqhi32mDd4QIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pjZ4Zzxxs-YxCLvQ0C6PwvrpIlwrYZAdZ5XCPDCOpJe3-OKAjj-jtA>
    <xmx:pjZ4Z-Tithnf35tpDD3uwDcRzcPcCmSFGbxPr-9sv4e62dl1nRJ4hg>
    <xmx:pjZ4Z2YPzqWb2Ps7Ax8zULvwBZUvB5m-Lghcfgu22C-zDsVJwcwGLw>
    <xmx:pjZ4Z_TDN9NGF8dI8u-FTMNaEP7vs2UF7KySwlZLN4zeFEgJ7rp3vA>
    <xmx:pjZ4Z8e7htSAETYUcKJcRPnaO_Dqc49U-QREbjKU0b74SUpMCE2M99p0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 14:12:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/10] gitlab-ci: remove the "linux-old" job
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-6-a9bb95dff833@pks.im> (Patrick
	Steinhardt's message of "Fri, 03 Jan 2025 15:46:43 +0100")
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
	<20250103-b4-pks-ci-fixes-v1-6-a9bb95dff833@pks.im>
Date: Fri, 03 Jan 2025 11:12:36 -0800
Message-ID: <xmqq34hzr9sr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "linux-old" job was historically testing against the oldest
> supported LTS release of Ubuntu. But with c85bcb5de1 (gitlab-ci: switch
> from Ubuntu 16.04 to 20.04, 2024-10-31) it has been converted to test
> against Ubuntu 20.04, which already gets exercised in a couple of other
> CI jobs. It's thus not adding any significant test coverage.
>
> Drop the job.

Dropping and reducing is always welcomed ;-)
