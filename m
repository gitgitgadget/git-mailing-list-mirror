Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EFE17BD3
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572349; cv=none; b=EJhGwNasSSuztyRDlLe+upff8A+nRpvPafKWaajBH1lnHO3C7QbMYKtozbkXrFcUvTT8PfPouPcRty3JZFfOIRZaxul2rMciJmryKiBBGAqEtbhTyhO3AtKZ4v/Y0bQ+OLwXep7IRxkosu9hMv/4X64SATGhjAcOWgFIwgy2z98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572349; c=relaxed/simple;
	bh=OygXxF7k3pyPyAlefcd1eDKoDSxUptKIMg/rMFtfuDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lISKrAAYxEbKP4r2QB1JcoyLdUoalms/DaNSkXssZRmU4dmGavjKzX+VpZvnobqxAjcjhHYtIHWhMXAm6m2UejZiaoqahhLd4NCQVaDBsF+zUfWsXdBJNBfSYdDh4z9U+96HGBWY3Yxh/2Vap/yfPKEy2Z08OUU1vEaQpDNlXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qERi22Sc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SlhLNW2i; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qERi22Sc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SlhLNW2i"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E1401140138;
	Mon,  3 Feb 2025 03:45:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 03:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738572347;
	 x=1738658747; bh=N4YCyemhYxcKkSt6zN3eTBx4V5vWOe/6PomUzJvWVi0=; b=
	qERi22ScV7HyPvFT/utjMGg1BgAww+5G3vp3CPClF6IsrmMHYNQ+/2X2SSoC5EYc
	h6Jioc4kgyBI6TXpsM24EYHmM5G63wvTBnicOHI3vneAaNP4HMVcd+03eYx0UhbE
	YKRcXEjQ9muRTGvNZzK7eTIhwtJUr7pu1iM/2IActBtYUfWIeq7Ajgs41FmNGJ6k
	jnnfhYLOOZPfTLG7I7y4lzjGs1+3BtpIypC/5JFM8wsQUADXsvt1JTv7THPx22yO
	k1pQ1McJpKcJKEeCLtfCj4ln5N+/3K+Q1z5ZCofKf5H2gkRdmuua29GbH79wM6ZG
	0xo39KpiuVXNNSfgy0xk8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738572347; x=
	1738658747; bh=N4YCyemhYxcKkSt6zN3eTBx4V5vWOe/6PomUzJvWVi0=; b=S
	lhLNW2isV6yzJLYlMdMfJyX30BzX0meWu90kjKDSga8Amwtni+tQgcAVP+IroqZy
	/bnCtWTUtbSSxaGfuBc7VV22cfiFewSyLmhGBLhCbf4+ZzQ0ydh9GWMXP9QisPAA
	cTDPnqI+D4E5ACYKbYyl5p37OaIjJZcaZIBa9e3NsbF4YJA1il6DRoHK98+QPWL2
	aZUy+H05AxdBNigOf0pYwdHTIgw67I88PUULzc9/I2Dd7rbM1GBIjNBd+wFhDAT0
	5uaj2+0B5LWAOQYtbUPfg4qiGzAKnHrlwS0td2xHlt0qiXbuRfCIVQi/2wNTS/OL
	rIAjL68QXPGGcey8UPcog==
X-ME-Sender: <xms:O4KgZySpUyZNrhAP3nNw7i_eoBz89wRH9ixPEioTj1Sw2PFWyZgQPw>
    <xme:O4KgZ3x4u-j9-l59-jTIWjsn6aXpRXnjHatxJwg1kSQhnIoLrIfCa1OlwRZBKytE8
    DJlSUPhorZcOh9uIA>
X-ME-Received: <xmr:O4KgZ_0MwhdWch4djTKMoP0wIcNmoPuvoZfXBeu0-OyWCVKLzsBftndK5Hef455Bip5dOBxFgZfjvMlxEotGtwLPALbWW3uRHPEmJCN7fjQIwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    peffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkh
    cuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhep
    udekueevgfekudfftedvheeggfdvheeugfdtleeukeeuffetjeetffehtdfggfegnecuff
    homhgrihhnpehgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhs
    thhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrggrrhhtih
    gtrdhsihhvrghrrggrmhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:O4KgZ-BBahnE0JpGbZTu_VGYnexTR0E1jTY3N0pqov_i_X6xypKfCQ>
    <xmx:O4KgZ7gQMYAkkjf_TMveM7_DxpvB8jeB3PExZ2pbuS2UW5E-pohq1g>
    <xmx:O4KgZ6oKcCR934LYfGfL6kIuFQL9STOaM6xnGOarRTIceegfX_eE4Q>
    <xmx:O4KgZ-jXnuDRZqHVKX5RlBaZwT00xJmoWvl1I7dH-xSr-ulnQpW2OQ>
    <xmx:O4KgZ2WfTTKz5M16CNHUVLMa0rZZyHuDdpZ-JG9qCckP0_qwXkdg52uI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:45:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fd232714 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:45:43 +0000 (UTC)
Date: Mon, 3 Feb 2025 09:45:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jialuo She <shejialuo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
Message-ID: <Z6CCNrNgatFMbMee@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im>
 <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>

On Sun, Feb 02, 2025 at 05:22:05PM +0530, Kaartic Sivaraam wrote:
> Hello Christian, Karthik, Jialuo, Patrick and all,
> 
> On 28/01/25 23:00, Kaartic Sivaraam wrote:
> > 
> > Thank you for suggesting these ideas, Patrick! I've incorporated them
> > into a draft ideas page for now. You can see them here:
> > 
> > https://git.github.io/SoC-2025-Ideas/
> > 
> > Kindly suggest any corrections to the description, project size /
> > difficulty as necessary. I've mentioned potential mentors based on what
> > I'm aware of so far.
> > 
> > Patrick, Christian and Karthik, kindly mention the ideas that you're
> > interested to mentor.
> > 
> 
> Gentle reminder that the ideas list needs completion. Specifically, the
> following ideas only list Patrick as a potential mentor:

Thanks for the reminder!

>   - Refactoring in order to reduce Git’s global state
> 
>   - Machine-Readable Repository Information Query Tool

I'll definitely need a co-mentor as I'll be out of office for two weeks
in May. Otherwise we'll have to drop these two projects if nobody else
wants to mentor them with me.

> The following idea mentions Karthik and Patrick as potential
> mentors.
> 
>   - Implement support for reftables in “dumb” HTTP transport
> 
> The following idea mentions Jialuo and Patrick as potential
> mentors.
> 
>   - Consolidate ref-related functionality into git-refs

Overall it would also be nice if I wasn't mentoring in all projects :)
I'm fine with being mentor in one project and co-mentor in another, but
don't think that I'll have the capacity to do more than that.

Patrick
