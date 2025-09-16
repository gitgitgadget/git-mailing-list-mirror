Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D924247281
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043189; cv=none; b=pZE81HyBSDI/z2p16O2pIbWIRC2/D9my1fjhYKtbWc3iLtjbIgULOoiD3t8ezGIkeoYOtgkAIciDxOgeTsTBljw+7YPT8w+oILt/T5ExyjP6ojji6gIK6a6Eewh+35cm1AvwQ64Ns+3B9Uep7pYkH2jhnZXoBIC1rLDmcynOgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043189; c=relaxed/simple;
	bh=mEv9lXOmEvH3gtCkVHfNrBPcsr5dDKBmHfzD+BOiWfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WO2y2nC5qVCRNrMOAcmr11R6Q5zspmZUbbnz3WtP0JVckWfJmw5TtaR7OFFTo0snryV2oSrRz9vXq8YGUCCUlwRYzbICapsR42Aq0qENITGA6585c5WGpdXKxTZlmM6nH3ss8jIkKo1cPVDg3d5qs9ki1i5haNkp4r2+aLJqGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ieMd3xn/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UgPEJQEM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ieMd3xn/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UgPEJQEM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 440CD1400239;
	Tue, 16 Sep 2025 13:19:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 16 Sep 2025 13:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758043186; x=1758129586; bh=QW4sYwpHCb
	S1Uyer1SRFBaL+z/x/7u01y1UAOelLeXA=; b=ieMd3xn/y4ISyRJx2BHbAtsUN4
	aREt+JMmXdr4MWgN3dUtQdy6I38H9j1c+IA7orlhXYB8bIeIpvGBX4qbLGgIrAzh
	VZnVzSka64BZOPyGyUCr9+MSsbBeGqwoyiVjn2EFpzzdZ/M6RBeB1sFl1fl5CNj+
	+zm+sG2EVl1hZ8fAByCFBwEzuld9xzzzEstbTtszK3XFQFcHFz1Tg96eAP5usX81
	251VZMJl0H/SVZpchkAA4FhRjc3AzdMDgMmHKAeOtBK0AZ6rShOrnUXcoEUE/6f9
	1ZzpXotptwTZGeG54iPmmwkQCpFvpYIXm0DtSAv3bDKhXDrfHPz4spOybS5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758043186; x=1758129586; bh=QW4sYwpHCbS1Uyer1SRFBaL+z/x/7u01y1U
	AOelLeXA=; b=UgPEJQEMGt32IFLTyMqMv77ds/GBpeg800QkrgsGWo+GLX2JrRM
	5hjFf550xvCaImSSE4pSiSp/fcir8LEVQHVOuuRGek08/IbliOhnHI7KYPU+sQ/U
	dd0refIJTXtjEefgE+cKSEO22xeO64AX/uA3M2rk9ZP9W7gXN0zf92nrHE3c/EF5
	SKu95WlJOQKhXwBH9p5X0+TnMv9UcRyZD18pON6E6sCx593LND7SrG5NqEoakm/s
	LoCSqH9kNB0QPyp8QzYkUzH7dWPIo4corPmwlP0TMtDMt3HUGbT7oHLvAZUY+i1o
	tr6PoYxMCSW2vkQaLwaU9wyCDluGEoM9M1Q==
X-ME-Sender: <xms:MZzJaKrWx8ajqIx8ZHpM2ame4EgbIAALeCs3sRTbn_nKPLkmMbqCfA>
    <xme:MZzJaGcwy1fLkrxpKsd5uooSpmQ_gMtWCDvPXM5K4uUGJxSeyx6q7y5XTRTq0plFi
    M8RzhGhO6-_1sO-ZQ>
X-ME-Received: <xmr:MZzJaJpbNY0cc3vW2D4kOnHnRjIzKmRV9T5N_LLtZxb5-hFjcPzG6k193EdiVtdU0-_MvkJ7yDxooLXCEcdgr6ndHu708jxFFzUh9L4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MZzJaHGqklyQTnaytlHn1s-7IYVZdzjkg3YdoKbYFujdwza2HzcAeg>
    <xmx:MZzJaJsrq9WBXkFWeaAifrWMec4qrzalegLnq2E48657C7aSfbzYkA>
    <xmx:MZzJaJW5H3syPrw9SY1XVqSC8R6MjdFBs86THYvmipWLC8WR_PExrw>
    <xmx:MZzJaFF1rNvS0ARt3QNVae19s1c8St2OVprJPD9iqQ4vU2zXLK1Q_Q>
    <xmx:MpzJaFOXScbz4JpTWIKCnjVy3WiVAAgVSeR25Wdttw-kFgxeW2rgKwf_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 13:19:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #06; Mon, 15)
In-Reply-To: <20250916164912.GA15474@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 16 Sep 2025 12:49:12 -0400")
References: <xmqqtt13frqm.fsf@gitster.g> <aMkJVMbSmeA4cIAy@pks.im>
	<xmqqzfaunzjo.fsf@gitster.g>
	<20250916164912.GA15474@coredump.intra.peff.net>
Date: Tue, 16 Sep 2025 10:19:44 -0700
Message-ID: <xmqqv7limi1b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That said, it is not really that big an issue and I am fine with any
> fix. If you want to document how the history unfolded, then I think an
> evil merge shows that (neither topic had a problem on its own, but when
> merged we needed to adjust the result). And it is probably the least
> amount of work. ;)

That's also fine, too.  Let me try that ;-)


