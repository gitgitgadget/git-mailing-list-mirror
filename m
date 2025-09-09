Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AB9302771
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398977; cv=none; b=gl42j553UrXVrIPYPhQv5Z3UaMN/y67esTIshRhpOxo4WWVWW0IqcBUJHF223A2cN1qpyOXAA5U87ohljwX70f6Xo9eyOvn/3e1RZMhJe39iy3bYiUnYfZ0F+GG98keuGVtU9MpKL4+bkb/WNlVBC53eKyTd9YnHpEJbuluaE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398977; c=relaxed/simple;
	bh=T1ZNVr4/Sl+AXzOpYuukK28OEpg37fQo5vJz+zjDsuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muZHOqtgRbuerEVHnwFVrMfegLSpfe4NT3BxDcbBF7bAufY6EqvVxvr5phnNHCyPJwlQ86CfAdvukvkIUtfeegFTtN5EYwQAPQSn7GyirgTlq1cgtXRZexRnEOZEPelCDxRDoLZ+GiigUx+RmEL4Lgh0YdWUZ/cGBEYgFcwCzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xj/cLMf9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AOndq/y2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xj/cLMf9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AOndq/y2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDCA614000F8;
	Tue,  9 Sep 2025 02:22:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 09 Sep 2025 02:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757398974; x=1757485374; bh=aCxq0f56ku
	QDXKHpgO/ypcEKO7sM4XYQ3rpJrkz3HL4=; b=Xj/cLMf9gAadzhcg6LsBHZq75d
	IzWbm3cw0NMFT0pHzMZ93HicAbM3twr+6IwqrxUlp76pSG0LLn9rsbVIcwOvXA4V
	yE9sefcqNND48hdkYvL/xgbDQZFRT5mrCyzoHLRJ806x0QPGuUWOXTQP8QqHJkZY
	lR6OvXfnAsKfb0VXpZqYenTuUToB3h2umN2ZhR3hNhRgrZoY2PMd/qrlcECgAFU3
	6J2STSbLyNNtNH/fBqhHNiJqx39rDyN+LeIdn//kXLYzmjPRNJm6OMh79j1LJ7Zp
	woI8d2eUF+g8qnjC7uKUD7uTKVOuHZfuOq5jAxk486oqAjDgfrK8SmchnIWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757398974; x=1757485374; bh=aCxq0f56kuQDXKHpgO/ypcEKO7sM4XYQ3rp
	Jrkz3HL4=; b=AOndq/y2qPWvABmwclJzww239rdRCxowse3SjVEKiM1b8RuW0dp
	KMl82ZSaVVjMnqfb0qjzg1FDvPEx0dUneMHZ80lsY1cpn8ESQWVjKoPfs54A9HZ6
	uiK20GANIywf+DJfLhdd/vkKzpjIGG1ialqNkaGo+tItm0VDOhgRrC4nnSOI8RPu
	7kWnK9ozrASkY27DLtxxOx16reWWMtiqPj0BM52kUKFm1ZKkGrPQpWmKs2GEGqG3
	kuUj/srYetu/ZWQpKzDQVXbFivYdtcLYnQL98PSmmAyYeGC3daxUrQpDOINBiN4z
	pUk8arIsjGY7gpKg3qp90Dq3KGagONsOj3w==
X-ME-Sender: <xms:vse_aLFm1m2-x8oFFCxz_zEm61PRor610l6NxEE21WAbd4kfigKiQg>
    <xme:vse_aIi1AcL6118MZIBcz5GOvpNNAacxZhuodZh-e5muU-kvWGXn-uxzvNByBcnMZ
    t94CG-f3637acyNiw>
X-ME-Received: <xmr:vse_aO_DDJXkLDicw6oRFPCANQ3RgAnn_Z4QifzI9otWhZSAEOJIyfgUgH0U7wwnbDALT9wY51bftokTywaSKpF10_BXN269ciq_N2pbil8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vse_aHqkkrqXkeM0yHM8yqD4bxXQKHprMfEftJIqGqreixIDX1X9vw>
    <xmx:vse_aF-PRTp_MkT1IHE_qovWgQhhQK8LFv7iTTi1Pdmf8_8SY69i2w>
    <xmx:vse_aDUYlrePSQXwtz2SJO7ALuXwU5skSfH8E-muJkF6waa0li3e_A>
    <xmx:vse_aDDkVf0g24Y2DF5OHUg4ZxtjR6G7rqw6GcjVD0oQU7ZciaiQwQ>
    <xmx:vse_aJU2shezUrMmP-BfJrVl--lQ5NrgUmVE1rxT7urflCAVN1nB2MNA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 02:22:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97e1a3b3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 06:22:52 +0000 (UTC)
Date: Tue, 9 Sep 2025 08:22:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] string-list: allow passing NULL for `get_entry_index`
Message-ID: <aL_HuZUF_cCtrADS@pks.im>
References: <aL21cEM0OcnrKtBW@ArchLinux>
 <aL217NTO73Xn9dJD@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL217NTO73Xn9dJD@ArchLinux>

On Mon, Sep 08, 2025 at 12:42:20AM +0800, shejialuo wrote:
> Callers of `get_entry_index()` are required to pass a non-NULL
> `exact_match` parameter to receive information about whether an exact
> match is found. However, in some cases, callers only need the index
> position.
> 
> Let's allow callers to pass NULL for the `exact_match` parameter
> when they don't need this information, reducing unnecessary variable
> declarations in calling code.

It would be nice to either explain why we want this or, alternatively,
to include that specific user in the same patch.

Patrick
