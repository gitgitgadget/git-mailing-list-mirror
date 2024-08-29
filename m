Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE83A156875
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925822; cv=none; b=Ykh7JMPTId7KvKkTtSF92nm73zRZDSIrCyoqftKShHBfBmBfMT5nJy4PENdIss3qcc9AEavL8GfHXM+tOYZet0iuSCFeeKMHYzM0kP76ldssfEMCmaousmgBg+BEgj9hVQx2ynoiorgIaOHcOHWx19mn19H3xJ5OZMjsp/ww4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925822; c=relaxed/simple;
	bh=yReVxvgCrR7f1cxDFwL7ZLUcVYHaPqPT5np6cHBAAAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCVEVZzePrd44Ba/HtyAiQn8GKV0Pu25a1/IV1mJUnF7f/dltfN00bU4nRmaLtzolkpDDRLbZgTdeE9yqx2y/6iizSroms/grW5NMD/Wd5RCziJmxnOxxrCNODrkpDRFbUXXLK1N1kEIFqW8oQwm11Y1lelJq/IrrQQGu+I22z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V+bxR8iw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ApRTWHsa; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V+bxR8iw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ApRTWHsa"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D5ADE1151C09;
	Thu, 29 Aug 2024 06:03:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Aug 2024 06:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724925819; x=1725012219; bh=q4zUidsmlx
	gnkf+uThxqTO8T5ib6kn6xM3bjYgyN2mI=; b=V+bxR8iwuL0Ky5Rsg9oCKtuajY
	2gQg7W1lZWMAsOTAppW3vp9lp8+TkkRbSb8OfS0DfJ339S8cH5VSsUCwKw/FsWcp
	b7TqdG9vgbyX5aZAsP6mweSANJqcd6Qc1qyq4ofgBlgfO3wHYNgdQ/84+A7KMKqY
	seKSU4EePpFnLA5VzN6syOfamKhMAeyJrIJG+WZDE+obnD9L+tXIR8DlPth4YfCb
	W01pbEQRCP/iOkAao2UD6k8/iQqyjuTcaFUaI9uOTpYlmkqm9qIbn1mU5eUSlL1t
	5ZaJBOvsVl9ap7cemcBesY5+wrwZlPCzbzfPWgWkZ2PGcNmZJgKOqpND0Z0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724925819; x=1725012219; bh=q4zUidsmlxgnkf+uThxqTO8T5ib6
	kn6xM3bjYgyN2mI=; b=ApRTWHsaHghRkj9XOGrK3oYSPwRxuMbkHSnatMjeeomg
	GWlEs1tWpsBSG8aG7CvE+H9VthQjA49UWeujCDcI1foTB/ArMcK28i5NU8X2F7o7
	tfayOLA2u3a8KQilwEu82JKbpY9N7WiOMVmg3o8M4IqBM2egYu33XOdlVXRmEEeM
	zx1oM5sGmsH6wYLoUxvsCSVj2hEyfqzwA+9EwtrPO80lB+MdjQKZPDwbzKAu4Fra
	WKombnkIufTmXhRZMyNhjNf+/BPZDAbZhj64jShgp8U6f+YsWVVfTva587taBemQ
	fRV0uZ4JF6cm4WrGIeX3zwdAOy5xmAbGffCkUjv11w==
X-ME-Sender: <xms:e0fQZmCj5FAlnPVOOuUBf0TW1vKYNWs35nqpSkLlBs1GYy1h4C2nAQ>
    <xme:e0fQZgjslwDkixL728byzBFJKVkVHUzFxf7JGI57waRthog4EBQwsK0f4UPhhPWmt
    ZuFT5G5qbPq1Pu6GA>
X-ME-Received: <xmr:e0fQZpkHfz2lLehKv1IXd73SUJmft7wv8VmQbcZESzc7Z2Qgz04L7dbhWb6ff7cynmv512T6xIl1bmpf1o69-9DGTsJvUzXSMedOzKlmf17eWXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvrhhitghsuhhnshhhihhnvg
    estghhrghrthgvrhdrnhgvth
X-ME-Proxy: <xmx:e0fQZkwe2UPamJqBzuN8jzMFoSt5rPbkSusLYK35vsAJ1KBbDKad2Q>
    <xmx:e0fQZrTy_QbL5qNhxfleDHc0uHeqHQFp9_KNc85ufwJ--3OAxbp3nA>
    <xmx:e0fQZvaqBHmNvuGRndp5B1F9h9Fa1fCUg4QnbYVq-TKWSgzU8u51RA>
    <xmx:e0fQZkRg-xljBnYCEgWguWnX5-4ydc_Y46j2bewaoNt8Ob0iCWOW9Q>
    <xmx:e0fQZpMz9_QHjTC0KWceH8JplYqmDmSdXfOYQ3Dr7Z7Gwvr8U-mJJpMY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 06:03:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c929507e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 10:03:30 +0000 (UTC)
Date: Thu, 29 Aug 2024 12:03:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] chainlint: reduce annotation noise-factor
Message-ID: <ZtBHecRkFQkSAF6C@tanuki>
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240829091625.41297-3-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829091625.41297-3-ericsunshine@charter.net>

On Thu, Aug 29, 2024 at 05:16:25AM -0400, Eric Sunshine wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> When chainlint detects a problem in a test definition, it highlights the
> offending code with an "?!ERR ...?!" annotation. The rather curious "?!"
> delimiter was chosen to draw the reader's attention to the problem area.
> 
> Later, chainlint learned to color its output when sent to a terminal.
> Problem annotations are colored with a red background which stands out
> well from surrounding text, thus easily draws the reader's attention. As
> such, the additional "?!" decoration became superfluous (when output is
> colored), however the decoration was retained since it serves as a good
> needle when using the terminal's search feature to "jump" to the next
> problem.
> 
> Nevertheless, the "?!" decoration is noisy and ugly and makes it
> unnecessarily difficult for the reader to pluck the problem description
> from the annotation. For instance, it is easier to see at a glance what
> the problem is in:
> 
>     ERR missing '&&'
> 
> than in the noisier:
> 
>     ?!ERR missing '&&'?!
> 
> Therefore drop the "!?" decoration when output is colored (but retain it
> otherwise).
> 
> Note that the preceding change gave all problem annotations a uniform
> "ERR" prefix which serves as a reasonably suitable replacement needle
> when searching in a terminal, so loss of "?!" in the output should not
> be overly problematic.

Okay, now the "ERR" prefix becomes a bit more important because we drop
the other punctuation. I'm still not much of a fan of it, though. Makes
me wonder whether we want to take a clue from how compilers nowadays
format this, e.g. by using "pointers".

So this:

    2 (
    3 	foo |
    4 	bar |
    5 	baz &&
    6 
    7 	fish |
    8 	cow ?!AMP?!
    9 
    10 	sunder
    11 )

Would become this:

    t/chainlint/pipe.actual:8: error: expected ampersands (&&)
    7 	fish |
    8 	cow 
            ^
    9

While this would be neat, I guess it would also be way more work than
the current series you have posted. And whether that work is ultimately
really worth it may be another question. Probably not.

So overall, I'm fine with the direction that your patch series takes.

Patrick
