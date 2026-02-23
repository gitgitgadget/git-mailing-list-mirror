Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2B356A24
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843624; cv=none; b=l2oJkRyZII2gOZuuOSBop96mVprB3wiGMRCS6jsWdf22vbaVWN6erg4KGg9Q1mEJTiEs/UgrahUAxwD+OPZaXL/L8KzD2LtUPnFRYnGpTiECdCeo1oFc8DPx4L8/wSTW3wGwwYyBxYRUyuZb1MCyLgzcFOsvE/YdANKLCL2J2Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843624; c=relaxed/simple;
	bh=O6qMQhwvGcPIMQ8Q0yqFf71dr0/RzwxKyye5YUZQQQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxFDUus8JVFdiB4a6VR/bjX1Q5+sHtNJMbg1dbGGBqxvtamiBHLmututuHHebJpHoS1+jvNuWvfnmSJJ3x5jxjIJHOTS8UWtL31poOhLeBy9zzoH11M+ZIcDyzlXrTrNF5UMNYqU4W07PS6ucpQwUT2PibjKSgHvFb5biJ08B+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bBquMHcn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fkVqLeuJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bBquMHcn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fkVqLeuJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F3A714001D1;
	Mon, 23 Feb 2026 05:47:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 05:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771843622; x=1771930022; bh=kL5erMxBf6
	RLnRTtfqLspIDS3Yu8V+eRwrze3UN9qfg=; b=bBquMHcnkvFMT05qVnJWt61EHr
	ROkyCkqpJZHVclvDEx8ED0kYcTCoehZFAtAvjsWNGy82fNI5XWB4e41+8bJhayUV
	8GcKKuOM+zC0ZMo0pjmI8QMg3WkchKNetSoB7rYF77juDnpm0X4kClInE6Nr0Y+d
	OR4H1rOSBf6zNbJAvQjKUq9GlEZLs/VH2xNyKnjbzGDaFAaTkqP+/BGouNB5tCTT
	reckqZ6XQlgtwk54WMoqySP1tnjFBvHcvEKqHECQTQ4E62RZccmCoUnJvoPmIUmR
	EJV5enb5xFLU0NVuFTN1nq6ydqvQ9GocxkifsvMd5s86OYvEdkT2hrtnjspQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771843622; x=1771930022; bh=kL5erMxBf6RLnRTtfqLspIDS3Yu8V+eRwrz
	e3UN9qfg=; b=fkVqLeuJ8g9uWR+q9BLaQr1eIJbxZ8t1og1IZK6t8rdMp8z6Emj
	Ot6NuM523qEK8xsjJNo0TWNYchx1ag6/AYQH6ajd6NpqR+zmuF1sIWAh57DLi1mn
	50VaBY8hwqBT7NIxpVdnDuo1Tqeg0OA5hBQFae4I/Ok/U93BMRmTWAHdO9o5z8ZZ
	0iH7GmCjwE1D3/CN57YE2+RgdFmBkVgIsM35ni3kQ25kBR6a/70ekQd43Z8DhJ8T
	MYaCNxpAigJGid/vFXXgEmBSjgOwI9sO6dPrWAMe5EkeVCPLUxbY1vUoVnXsP8Kh
	yMgiv2X+LfZnotCWXn4XJsosL774WiuZF1g==
X-ME-Sender: <xms:JjCcaVHld5cwMAb9YY7VmZgJpkQeDkg21vsubwDsvZsRn0x_ZqmpJA>
    <xme:JjCcaQUJU7OQ3Ld4PV5yruuN6tVwi-bE-BZoRZ85RVrx9xY6NMpyiUqIr6eo9D0gT
    TdsFCpdiRhUsfxLpiX1YSP8DEj_h5OAOJgjDqTtuQKrPs4fo230Ag>
X-ME-Received: <xmr:JjCcaUxLWs8rc-wtNR1xXvbOR8DtPQCgEWv1HZTcIBl1kB7OoyVB4TvutPVGhrU7-roT9-NMI12hZy5-aTrqtaYWQrMeGGrRsQ1uqZb09g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JjCcaWOgAuOm8uf7uYTa0yYWf0X60LTM6ymRhOR3ts3S7FErc1T7wA>
    <xmx:JjCcad65QaNr71vVqZ5KiBM_enfrNivc91GdlLyDYISRIkveWAH4vA>
    <xmx:JjCcafOCOQq5fGWQpYwUng_DaI5_6mMFZ-uUefELyVlyArdUdCQo_g>
    <xmx:JjCcaTnGu1N25d1IgJ5116EGjvQVtYPC9Q_TiuiABvjnf9y5lEWE0g>
    <xmx:JjCcaV0N6eNglx-EbfmtHj6mc7Kvu07VWBWpjBXSz1x9rZ7uQ1Cv8CSX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 05:47:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d170e0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 10:47:00 +0000 (UTC)
Date: Mon, 23 Feb 2026 11:46:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/17] refs: move `refs_head_ref_namespaced()`
Message-ID: <aZwwIUaoN4bmmXXR@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
 <20260220-pks-refs-for-each-unification-v1-1-17170bd99de1@pks.im>
 <CAOLa=ZRLeTmGQJF3Wo0SHaQDgy+0G4L6=zciEMtwMPoYqpPM1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRLeTmGQJF3Wo0SHaQDgy+0G4L6=zciEMtwMPoYqpPM1A@mail.gmail.com>

On Mon, Feb 23, 2026 at 03:05:27AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The function `refs_head_ref_namespaced()` is somewhat special when
> > compared to most of the other functions that take a callback function:
> > while `refs_for_each_*()` functions yield multiple refs, we only yield
> 
> Perhaps swap s/we/refs_head_ref_namespaced() will/
> 
> > at most the HEAD ref of the current function. As such, the function is
> 
> Should this be s/function/namespace?

Yup. Will adapt both, thanks!

Patrick
