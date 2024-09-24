Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E79B80BFC
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172315; cv=none; b=GTV0Axuo9kIzl9nqIXaaCox2zX1dj4H+zFI4dbWdtThUWsBWy/UeYgTMwtXon2BJ/YyfFnFXIKU3bawK9OSKvtZgq0G7JHx/55ctuvzFFL8EVP7NLS0qSxnYyHG/lGKJPu0/w62+L6ySVAN7UQTrm0zie76v12iAa/PuAgh5fAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172315; c=relaxed/simple;
	bh=FDGCC3aepNgAIuLXz2Dym6fo2+TXZk4ad5BMWbdzuhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d47JZphymXmUwKlS5BkpV27eGuThYPW9KK1+3oqebyi705Z9+s4gFTbAnEpG10QVkl0cEeU1f84gcZXArZjJEnoa4X+cX7fg3OA2cXA6SkFmegy3n0Cm0Zt6WUdrXn79nU/e5/BEgfVaNUv4Go0YU3tM7XA4WzaJKOMRsulMlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G6eljldj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GIuKbZRc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G6eljldj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIuKbZRc"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9026F1140306;
	Tue, 24 Sep 2024 06:05:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Sep 2024 06:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727172311; x=1727258711; bh=ElGH9tOzNK
	RGvN+apFaKhU6LBB7B43LPQ7sePG3+b/I=; b=G6eljldjptgKyxTTKJF2btyJRd
	xgDeRQeDCCA0fToRtjEKyBNjgGyrGwcJerDJadUcCYUhSUdUIImftEfUAyGbjmU8
	eLDqfHSGj12JlyneEJqRQVctEoO3/uPtl//M2k6I3vEkkjvb73c9u0lYUG9PDjkD
	isRw3VDNUiCH0qtOCTxI+lIwJnl7pNpCHmUbJrkHn1Qu0sCgGD8aUJ5buQAGyZP6
	ClwIvtX7H7SoHSPJN3hjU8GtdSnd16M4ZvU7w+FlaLAgs4vP2e5EpIvpvw/+wHMk
	TZ5UOxhrrxFfR7S7OL2MAyb64LZ0uaSCUpq3A8GuD0pmTstRUb6ta9E722vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727172311; x=1727258711; bh=ElGH9tOzNKRGvN+apFaKhU6LBB7B
	43LPQ7sePG3+b/I=; b=GIuKbZRcOK2LMKb6sysJic1uwHQiq+7oSdOoapJWMH/M
	VwD7D0Rt93M9pW4Tlh0qQn+cCKieY2oUiJSyLsqRe6i892DLcCko1Uuq/XWZ7DO7
	lj8X1ocXjZ6XbTGhUaCm6fPnr+xRDeYQSD7U/FqLctqc2iEdygrwjXqlyi0LzLzC
	I4uP8YqBkgoM1TLXWLKlvl9nJZDlyZFqM8c9akaFqJD4qWzQs0rBPyK+pNRVliOm
	5YMMwxnYlRFx+l6Tl3exIjr9e70BsufgwN0ttOJ5n75CbXMpYCn+tWooS3cgixfE
	qvj7MZthiNROUqxZWnMSMpwZbcrJCG7ReV8vW/2Q+w==
X-ME-Sender: <xms:147yZseVFfX8NCYoUMf5g92wg0nWr7OS8apk6hAyOgEqgWFzZeumBw>
    <xme:147yZuOrK6yPaXUYTgePv1Y08CxFr3d8edUjEEaWB8QPKQRMQymk45Ef2GGDjAwxf
    _1-pcrhFUmIqE2Vnw>
X-ME-Received: <xmr:147yZth5qtGoMjVnhS-zWYs7WY9Y4yV-yJh8ec5xXJoEi18jKSEWWgoA0f75glG2cpeg7lYbHNzXeRhVGz64hb-325KHfxyMv__EWBmV0tupKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:147yZh9dEVdr4eIgdGxow0JtIs-g8HFavWqSayB-Cwt2q7vFyLSA7w>
    <xmx:147yZotE5qIAzl7dInXGJp6b-OcdqydVt3h_mEOrTcafPoRk9XMzbw>
    <xmx:147yZoGtqngvcT9DDWhl9KBpWqDezCE5_Lkk8AvKgf7TRm-MaWgJXA>
    <xmx:147yZnNXF_yzw6AxGIoiEtQK9wAbSlySkNxokrx8XEwKLBTcIq9iVA>
    <xmx:147yZkLiEKji2S1TDKsyIcNp41ToEY0hP1Cy2IDJ5Atyr_PYsJX6HSOx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 06:05:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59638230 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 10:04:34 +0000 (UTC)
Date: Tue, 24 Sep 2024 12:05:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: rename clar-related variables to avoid confusion
Message-ID: <ZvKOyukIHHAzA2IB@pks.im>
References: <pull.1795.git.1726687276169.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1795.git.1726687276169.gitgitgadget@gmail.com>

On Wed, Sep 18, 2024 at 07:21:16PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In c3de556a841f (Makefile: rename clar-related variables to avoid
> confusion, 2024-09-10) some `Makefile` variables were renamed that were
> partially used by the CMake definition. Adapt the latter to the new lay
> of the land.

Ah, thanks for the fixup! I really hope that I can (soonish) make the
case for CMake being part of our officially supported build systems that
is also exercised as part of our CI.

Patrick
