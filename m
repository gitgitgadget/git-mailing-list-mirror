Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2C3D3491
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982438; cv=none; b=qZIsM5ZjM6uapRXF9thIXbcFdMu+K++1tbRd7AMX9zIGVl1ifVpiP22L2VXZjSxngaVaP2wfloBxKJh6L2QbmL27SjABz76kOf/FqXOcnoLfOh99zJZpKcSJCOkHO0CwL7X7nnkfqGOU5INHS5lyXXPqorRIQiVbsENYoQc+NoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982438; c=relaxed/simple;
	bh=J9YilUxW/eqGEqEMDtICYcrDs/Ix4AcXoBYaRNr7nxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8xlcZPuBR8aVqFPZdWxFlNYosNI3Pt8XB4aIZpFOX9031EFYjRb522pd5fTrzeoVDzFsAClq7H6WAsCRhPLPzU1ToCeZIsPMengqc1LDuRgSA9yb+HPibNxcmux0raheoxP7G2gK3+DVkAeuBfvUY4QJWid5Iync7winopvu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HdNj0+aA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y1c4ekyU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HdNj0+aA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y1c4ekyU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 95B687A0134;
	Wed, 21 Jan 2026 03:00:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 21 Jan 2026 03:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768982434;
	 x=1769068834; bh=weSKrk+IwDXiDdK1P08cJMc/QcwvVZn5IreU2gZhYFk=; b=
	HdNj0+aAiLA/wt0LpmV9W+/sUlu/x9iAYrS4yb50mTAQkftrhj2psQHt/T45b7Kq
	kWV1hBwGH/lsECQy/iK0X+Y6TNfP/pTfUiCdqasCr50Ma17J1G6YcRgVGpv4T4KK
	OfQ1G030fOXb5IrSMjXZQATIaXAholxiw/ZB5CM155g+1MAdbNi00Q1U0CyrOZEJ
	JYBMHq64Q19PntdPbrsvWvDat5DtldTieCCWNMmqe7nRdPZottRxJOhzzipeEWGj
	Y6uCc3Eu7ySvetduMDSWFDAfLXFSlb53kEEhcjyjrXngzKhnsRWjDvrQWojSeG1k
	ZKsyYoc5ay52iNqtgVZxJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768982434; x=
	1769068834; bh=weSKrk+IwDXiDdK1P08cJMc/QcwvVZn5IreU2gZhYFk=; b=Y
	1c4ekyUtZ5H7s95txvIUWN2c1iv2v6sYHzgctAFbssnqEuDBv+H6WNfOuyyuyW8q
	LIiym3AUAkEPf1q03Z5QApaT+V7tzz9jc17QJwwBpnveT04ChdJLbCfO9fPM4Muz
	bugXEoYPMhkrCYWSzp3iW4MaDp9cTNywVbndlzZ9Ts0LihF8yMdCPo2ToT7tqQmu
	Hn7Lc/dsvay6zzd1tkSTWFnWus47JgIBOyRnn1FL4HtTizdd7XMIC88ALjCzSOJb
	kgWmRgG53sQ6WWtitXCVIXPhT3KfBHLIZAOYtfsZwEWL5RR5Xl9bDClfCfcVxBAj
	efcTM6HWePqXGqEH71BJw==
X-ME-Sender: <xms:oYdwaZ2FvRyUcNAxY4az36GEctg5UDcitA-RLCG3l7cjgZETTnj80w>
    <xme:oYdwaQODNBgHGfBFG8t6D4rZf7-jIeYR6WR5c8eeiDXU8UGTYfKbYXLxRxkW9XhwG
    Kd3k7iBI4RsQoj7Llogm0udfFv5n3-HGT2SUf2LPwiuAzaugtwS2A>
X-ME-Received: <xmr:oYdwaRWPCWSNTyVbYc86urK4ogiq7VpC1tfZRpS2LjlnyTWF25b-sD_vGNIahlkj-B2r-fPkw5fOaMr_xN8pla2EvWx5JvBK9aVU3fhnT00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekro
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepudetheffgeeutdefvefgteehhfegveffff
    dtveeiffejleeuteekteeujeegkeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudehpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrg
    hilhdrtghomhdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtoh
    hordhorhhgpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oYdwadZpwfgSIXa7SsGq4vqyLJmaxQPaaHl9GQoFYfQEM6iZI1aBPw>
    <xmx:oYdwaT14H_CBkZrjZEDCDG3hOW3s5n3O34CArf_uTLrweQHPF6Q6oQ>
    <xmx:oYdwaRAF1NUjO4H0oJsclWixXSgEHK2MXoRrKrM3sCjgMIEP-2hQXA>
    <xmx:oYdwaf_6PEYswqbFi-PgGrWtgjJJ2DX19iCdh9y3TQFHdSUHYrNELg>
    <xmx:oodwaWjU7UFZSANVC9FQg4wmrTmLnbpAaWlmhpEL7nNfZ9YOcdGjG0nZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 03:00:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0cc56110 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 08:00:27 +0000 (UTC)
Date: Wed, 21 Jan 2026 09:00:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org,
	collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org,
	ezekielnewren@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	me@ttaylorr.com, newren@gmail.com, phillip.wood123@gmail.com,
	pierre-emmanuel.patry@embecosm.com, sam@gentoo.org
Subject: Re: [PATCH RFC v4 1/9] meson: add infrastructure to build internalg
Message-ID: <aXCHmFcwmOLxSJeo@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-1-4a63fc69278d@pks.im>
 <20260120221844.6085-1-ben.knoble+github@gmail.com>
 <aXAOhTx07g4LVTNo@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXAOhTx07g4LVTNo@fruit.crustytoothpaste.net>

On Tue, Jan 20, 2026 at 11:23:49PM +0000, brian m. carlson wrote:
> On 2026-01-20 at 22:18:42, D. Ben Knoble wrote:
> > As far as I can tell, v4 of the Rust series introduced this script [1]. I didn't
> > notice any comments on or about the use of "--quiet" here, and Gentoo's been
> > carrying a patch to remove it [2] (also attached below). I don't think it's been
> > sent upstream, but we could… any thoughts on "why --quiet" or objections to such
> > a patch?
> 
> I have no objections to either of these patches.  We'd want `--quiet` by
> default for the Makefile due to the output format, but I don't know why
> we'd need it for meson.

For Meson it's kind of the same reasoning -- not having "--quiet" breaks
the format for the default non-verbose build.

We could of course introduce a build option that makes the Cargo command
itself be verbose? It feels a bit heavy-handed, but maybe that's fine.

Patrick
