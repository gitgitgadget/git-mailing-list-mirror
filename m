Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54101F91D6
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837439; cv=none; b=COYSX/CSSOUZQOouNUlO9yiw4X3FirRr0tuWmwErtIZI7MNVLOvYPHsVelMQvfQaKYc1+JRE1ui71gPybEDgGRobEXhdX9bb1r/iCTWnKv1UjMVkZUoD3mm2Pi0poAO8TsWKNzMpE2S8kRA/kmcW1j7NfSgqBw/GfA23WpnGZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837439; c=relaxed/simple;
	bh=zNiW2C4xMUpsW0xGZemkRDocl96sZXuEcQSk0Z+38K0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l/QUNhohlttExL8X15+B2aZuA5oY5bzW2OI9Rrglr5i+EmWmJzugF2DG8+sPbOn/2FdZ6MHrVheFgS8NFTVdlsvoefGjhmhmvYJAZ4jwDbuJF7rMyW+qV6Og24U2xfcUSIrBt4UVB68tA0uA3ioPWpZRWAzcPQiumzqjjAVTxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wNt8rFkv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TegHeIKn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wNt8rFkv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TegHeIKn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFDF4140001A;
	Thu, 25 Sep 2025 17:57:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 25 Sep 2025 17:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758837436; x=1758923836; bh=858lTFTDyh
	gDR6rAKfk5BvKeBofHYzzQZf3BmPAcCT8=; b=wNt8rFkvOozMiJWQC3VRsVnkFY
	Z2+pB6BLe0QCRbk5GgNFzO4busNvR1k3Mh5BJeJJrfuoHA3gL3otvwklrSChkzvN
	s5eyLwHoXjo/wOq/46XLFYx/1Xs81T4Z9BsuyqQ6mUtCfmr+hSllJ76WFykhcn03
	O6qtIHzVwRVWh2xczUNZxFEoHQbQISM6M7Y7BXKveDCuCxjeb3rPujgH+ZEYCfiv
	uh0oSvXDVo48O2kMtY6huBu5oELzgozZBj0WCwTQwW8M8VtS1YpOEmG+Ps0lkl66
	VtFZlP/ZyTzAs08KA6qG4Ap8MOWx1OVIRBGvJAVfxqJ18bWYfMbFcHDs12Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758837436; x=1758923836; bh=858lTFTDyhgDR6rAKfk5BvKeBofHYzzQZf3
	BmPAcCT8=; b=TegHeIKnfX7apAlBNgiPSm+z/fBcc8A5i2IyjCD+RMk1i15kpPX
	AXLLW4zgfCphG9t0K6efHiy5a2DXiUfR33Z/AnKjUsdX+qRgeptvzoGhXiRblUFD
	MhPTedO8IMNx2SefR3PXJOUgwad1zIOc+pcHxPdTZ5R1VKyk9mEBTQopSoe8nHUo
	8pws7Bw6fDwootXX7Bf8DO/4/zzCNmY1m0NFaOC2SpoCIh1R5hCem1SftA9umh80
	QIpI9R3iPZ9nSShmASSQnxPXkM+2EIPYMivCR5DQ0goQUlzTEC5g2qaT+LlcK89t
	W1Q3LWYqGKbt9vdmYhbCDi225V4KSAwnOAw==
X-ME-Sender: <xms:vLrVaL_73JP-NRfdzwgQkH5EEdiGUqmfbfJd9hahLobDDQh9hlBLAQ>
    <xme:vLrVaPLBKud-sJ_8d1Z86VBCa4_HHgEvxA4pQri8gFh_XyZRBd69qIR7NDntgo__S
    AmKYVVTw9ojenraEocbRkjCJqPGMXmOFGL2ajCUrtMog37xzw3B>
X-ME-Received: <xmr:vLrVaGYICrOsfNJnAoxPMO_fG6EJD0OT7uiPJNB-RNry70o5uA4cORcxj8rpYfrLQ9D539U9HhtR6aBOKppnGUGOAWSK_MHy09xr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehptgguhhhosggsshesvghlvggtthhrohhophhtihgtrg
    hlrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vLrVaBK7o1nGhl5cxpIPVhvHsyz_TCtC4sGgDGcxbSGCrJnVAq75Ww>
    <xmx:vLrVaEBOwr9XYAAZ37jz8e9RTer9OQvxPJWh7xZnNJJf88-00y_G0Q>
    <xmx:vLrVaGpSmuU6Xk8C8RdY79RgYl5BnNEZGwNQdN6nerHohVfae_Octw>
    <xmx:vLrVaPhcS7yadBx6oxdc7QqZ5ew7tCshpmTgm73Jj55KLBBBVkqQsg>
    <xmx:vLrVaCw2fe4J5RlgicKMaUlHo5Hz5ROb1Uat5L0Wap7hIgn_-MN4Cs4w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 17:57:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phil Hobbs <pcdhobbs@electrooptical.net>
Cc: git@vger.kernel.org
Subject: Re: whatchanged is super useful!
In-Reply-To: <67a6ec3a-a718-438f-ac4c-ff989f316a9b@electrooptical.net> (Phil
	Hobbs's message of "Thu, 25 Sep 2025 17:44:55 -0400")
References: <67a6ec3a-a718-438f-ac4c-ff989f316a9b@electrooptical.net>
Date: Thu, 25 Sep 2025 14:57:15 -0700
Message-ID: <xmqqh5wqdwlg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phil Hobbs <pcdhobbs@electrooptical.net> writes:

> I use git whatchanged all the time.  Please don't remove it!

No, we will remove it.  What we wanted to hear readers ask was "what
can I use instead?"  And the answer is "git log --raw" or even
better "git log --stat", "git log --name-only", etc., depending on
your taste, all of them shorter to type than "git whatchanged".

