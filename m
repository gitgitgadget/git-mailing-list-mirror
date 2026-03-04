Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76276377554
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610198; cv=none; b=EDOpC2cVcwGtgG8raTiOW6BlBZydj9hAeq1i2ZPkfRilOGVX2B9tDygLcuQV8tYIxCrXE46agi9PnXG5JDiZATAptS9/efsiKK5ckAJArRxx9XW6DYc7ZqSfl4QiP4rtByY5cdyJ+2Pq1Fsyrj8iNIaK3lz/SGgGG+mx/j/nCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610198; c=relaxed/simple;
	bh=1zMu0R/CkC2rO15jzCa7rUBv0Wsvez67xqLc/NP2kY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eh6YFo2IJsxeu42uygPHkBWoGW3LKgtaBBcC8HBav7SXlxYGx7dFTJRmYs9UKtm6ElEvKic1mmtbU6qubOs3AsqoitglorQr9OPrLr7moP2i4FeUTXCaHdnfUrknZNFzTj9sg97pPf+xr46xtkOZ/SphGpQw2OzUOQW5b2IQzlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hX0tHR1s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOADQD3W; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hX0tHR1s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOADQD3W"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id AD0A4EC04DC;
	Wed,  4 Mar 2026 02:43:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 04 Mar 2026 02:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772610196; x=1772696596; bh=cQqr0a9vZk
	R5pC0upspTlaHZ5ERNh7FNxSe76N/GxrQ=; b=hX0tHR1spVO4EXGp7v79X9Zbso
	79uIemaeLToS0+gjN6WBym/Us7gwIAjphb9gBYItLAmTQY2Savu1Dd/oMFTb+Kg9
	k4PitobAF5CKAXjNq63juMyiWHad+peAZbahANm0xScC9AcZfeKBvaaL8t7gQ6o9
	SbaYuEoskw3wNTHkyZV7nmsfQsb83OH6RwAjQjnfV1ZqB6DVtwKTpkUCgZR18+eN
	8ROTo/RKhnjpurk/ZyE2biI/mukHEM7KeYcKlb7egXjM4CfQtEjzwGP4kFvgoNeS
	TdbXRbBHL+cOGCw47RzJl5/B0il70EFIZ3R+5vwhgrqWLfQ+Dd1/XnIUcThA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772610196; x=1772696596; bh=cQqr0a9vZkR5pC0upspTlaHZ5ERNh7FNxSe
	76N/GxrQ=; b=LOADQD3WSMRxMDCk9KV90a9CPpZV8p02zvzwXbbq3JfTk7V1ENe
	zKqpKO0TrkxJv7npFKjdREatJAqXHGNHOD0gLICa8kxiRdnMJqDIh0ulwN4beu4M
	i7Ajw+eR/y3bRfPHMIyLNr7x+w0yCQq4rhl2McbzdrnOKlXFQtLodXSUEX4rScmW
	mkwArSMX/usmcjcr1xXEqHTCNRlF0BdH0dXpRM3uMbnJ/+/Kp6HzqfbeGEroF/gT
	wY4hPAPR+AgWzNU54iHz5ScaNTDqrGhfPK5orPPuNqcOI7BakAnVIPMV6OH5x/wp
	L962wxZ0O12ofhMGTHCEtI3ugbyqMjwQZlA==
X-ME-Sender: <xms:lOKnaVVO1YwxXU62eld682gEt6sekLaQwT9JLa_oE6EKzmEHGiLFIA>
    <xme:lOKnadCvYDmyFnNUyjF_Jm6DDMisXDf-0qdeyggCSvgfB-oI9wjUQT-JaPts0ZtzA
    9D1-pFaaDha7JMTTBxnkAgYUkvE2XQlymFd9Zt-dSeaKRc0rw3ovw>
X-ME-Received: <xmr:lOKnaezDXfTos5EYxVhp1fH-b-_OIA75lSsT-aDrhO93QygyEqOSiH_rjBxHaTghHTIkX_cAYfePziRLd2nmV1gDnZo2E9Ux_-Ct6Yl_L2ggXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhhuhgssehprghulhhishgrghgvvghkrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:lOKnaSD3THjpy0OOQhLU_t2p_E9j8GNnaGQpBheOuhSM8o8Xr2LChQ>
    <xmx:lOKnaTZ0rVosExIUpT_jfuz7Cm_9Vwf2AGEuHi3Zjnus6lfd06kEdw>
    <xmx:lOKnaSiAnHJc9AxeiZUT8gWYOyR70gTlXQ2wL7o6-Fm0VMSy8cC-FQ>
    <xmx:lOKnad6KearaUNj4tnWKcIfXKAWuVvpgzTaTw4yNpmhTw4wHtcIbFg>
    <xmx:lOKnaSeV_FFwdwlbt9Y-_W9C9xWIBtMq2xEwLvj032vMj7fLGnJV0vW0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 02:43:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 11d201e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 07:43:15 +0000 (UTC)
Date: Wed, 4 Mar 2026 08:43:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v7 08/10] fsmonitor: add tests for Linux
Message-ID: <aafikA4bQS3lB0Hq@pks.im>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
 <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
 <fad2f0a81ab5fcdced2cdf3c02877fbb00244efa.1772065643.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad2f0a81ab5fcdced2cdf3c02877fbb00244efa.1772065643.git.gitgitgadget@gmail.com>

On Thu, Feb 26, 2026 at 12:27:21AM +0000, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
> 
> Add a smoke test that verifies the filesystem actually delivers
> inotify events to the daemon.  On some configurations (e.g.,
> overlayfs with older kernels), inotify watches succeed but events
> are never delivered.  The daemon cookie wait will time out, but
> every subsequent test would fail.  Skip the entire test file early
> when this is detected.

Hm. So the fsmonitor listener for Linux is not reliable? Wouldn't the
end user see the same issue then? I'm not sure whether just ignoring
that issue and adding a timeout to our tests is the proper way to fix
it.

Before we jump to such solutions I'd rather want to know what the root
cause of this. We had similar issues in the past on macOS, where we
eventually figured out that we were missing events due to the buffers
not being big enough. So did you investigate what the conditions are to
trigger this?

Patrick
