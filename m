Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851E3314C1
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812533; cv=none; b=SRUuPyOV02yaH3hj8kjxlJTyCRePiI4KjiB0tEYdwgr52We0kJCwijCxJ/lq+s32Hq45ckrB4Blpq18nnmjFrLI2KzA3FV5wDBYqxPWbwutoX9Q4tEotGXE2otIVKCx06hOKaCrs12Zh/LwMBipWHnof106tr/h/GtBWtFL9McY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812533; c=relaxed/simple;
	bh=qc3pVQjXwL6sMwL1nY8VSKg6ENFQclE1x4e49dOriSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0ivgC4NW/Nh0ysoY1PR79yTWlvuLp9CkkGwzwcluPoQv/NUP7Hg20xtGWcwMYiMJ5le4WlhGc1xOqiTjYzEz5AiQOsRtbM0FgkjlSvgn+JLn4ASJzmj8VXIsAa8OKfjXRpnS7X+rtdV8SXRinyCaD8ytPwCF/n1HfaQ6t2satQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZPsH0ggW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFTRvhEy; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZPsH0ggW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFTRvhEy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C7FFE1400184;
	Mon, 15 Dec 2025 10:28:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Dec 2025 10:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765812529;
	 x=1765898929; bh=nr7HAANhdXkhwMxWBiZxs1sIrQs2uvLWilRDE7FfGcc=; b=
	ZPsH0ggWiMVk/ttk2QxHg4qn1jDZBhjW6UC8GWJrLV699+mWw553m9VeVOJOhgVf
	AC5vcdNcBo0cP+5dGNnlcdHAkvgah3oVDRy23cDmtt2jpm3a6AWw/Fvkinql5ng1
	zZL+wk3tI0xr70ItB/Uw7PBH9uqhM//GF5OrQ6UeKDKjYFZ7tO66jB2fuAmdH32+
	8vkSE1xhEzTqbp8pEOMXc93W95ly+AhfVWSOaAbh9S5p8ne9FsC7H7J/HQvrMN/7
	5QNc7d7f02Tzj2byBwkzzSqb8vXe7+87/kY/LmawbFc/MGItqKWu5M68fcE1ecS4
	hpKXxh9oM99gnK6v7Xma3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765812529; x=
	1765898929; bh=nr7HAANhdXkhwMxWBiZxs1sIrQs2uvLWilRDE7FfGcc=; b=Q
	FTRvhEy7G+FcYAhI6rFKGA1q4Dui1Di6pXhcqCGbiHPEW1FcObKyqZo7LeoL6ZUG
	L4xf82y+UoDHIK5W/3i5TgdyHypvgVGAshnK6Kxh54GLzelhWSjDGz3RqpToOD61
	IBDK1JcjnPMbb2RTbjroY/ftJ/JTa9uDdheIeT5FIIJzTJ+d0Ir55sHbU3+bULLf
	qIOHtIWnE1Rd7fGBaqdXhZZUtPonKeIBlDmyGDXv1sZKKzqzKZJA5us1C2RTzysP
	3eGvcF6RO764XsfPIvuKd7d0WRPjx2Beyoek/14NG5XABUXnhkPrSF0MztbRahre
	UIEzsv1ForlVeWKjCKM4Q==
X-ME-Sender: <xms:MSlAaYKMWeCtgjVSoCYGO-f0srDiFApQN5TU7ndZcMDB2gppuogz1A>
    <xme:MSlAafCFYlmrDDEPtFemtXlwsG57lVETD-iNld4OmTknwLem9i3s4QGdpHVXNnq7e
    pWLOSSTt_cGmPQ8LcpfsI3s1JzN72AKTdg4mQiKG9dakXNxxMt2Dg>
X-ME-Received: <xmr:MSlAaRA6m89YM-ZyrKZEii28UBM7mFd2qfebONMZ0pMjF_6Q4ueH81nNT4layP9984bYnPAVanhBf64PAnn1W9yEo-XsBrCQ1v2Z-t4O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefjedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epudetheffgeeutdefvefgteehhfegveffffdtveeiffejleeuteekteeujeegkeevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtth
    hopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihr
    vghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MSlAaRBDo8dTekXVdpue07QAX5qKrcCUsAIb6Mftc8u49CkyH1A3iQ>
    <xmx:MSlAacqqmZbbmdmEPVgCCNCuXnALueoBE4cssRJeInnR-7ZsFsT0Aw>
    <xmx:MSlAabmNE9HihA695Bslv0u-yrS-dd7ZKs59pFlMc1blhh4RpMIHWg>
    <xmx:MSlAaczVbAHaBqENEX3Xj_D-ayDqR88DDHacgJDEArZIlofHfA95zA>
    <xmx:MSlAaXaFu0yjfc67c6rqvVMZxn4U9uS8peZmE5T7_-XMVM70F1jvLhQN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 10:28:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79c056c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Dec 2025 15:28:46 +0000 (UTC)
Date: Mon, 15 Dec 2025 16:28:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Git <git@vger.kernel.org>, Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: meson -Drust=enabled fails on macOS without GNU sed
Message-ID: <aUApKxjYHMPHNIac@pks.im>
References: <CALnO6CCu7A7mkLy==K9a-u-z0kYBKLiyBz+Qq8c7PWLHO-YuNw@mail.gmail.com>
 <CAPig+cSctvQoCNvQqrsLjzLQBc7H9u2hpxeBHE19_AQsup+kFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSctvQoCNvQqrsLjzLQBc7H9u2hpxeBHE19_AQsup+kFQ@mail.gmail.com>

On Fri, Dec 12, 2025 at 03:32:30PM -0500, Eric Sunshine wrote:
> On Fri, Dec 12, 2025 at 3:01 PM D. Ben Knoble
> <ben.knoble+github@gmail.com> wrote:
> > I think it's due to e509b5b8be (rust: support for Windows, 2025-10-15)
> > [relevant folks CC'd], where we assume sed can take "-s" (which AFAICT
> > is a GNU extension). But perhaps "-n" was intended with a "p" flag on
> > the substitution?
> >
> > I've been building with Rust enabled on Gentoo now for a minute and
> > haven't hit any issues, but that's perhaps because the command is
> > running with "-s" and not working as intended (yet still producing the
> > expected results).
> >
> > The relevant snippet is this (reformatted slightly by GMail, apologies):
> >
> > case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
> >   *-windows-*) LIBNAME=gitcore.lib;;
> >   *) LIBNAME=libgitcore.a;;
> > esac
> >
> > but "cargo -vV" produces something like
> >
> > cargo 1.89.0 (c24e10642 2025-06-23)
> > [...]
> > host: x86_64-apple-darwin
> >
> > (on my older system, on which I haven't tried the build; the failure
> > is on my newer system with close-enough-to-the-same output). I'm sure
> > you can see why I don't understand why we need GNU's "-s" ("consider
> > files as separate rather than as a single, continuous long stream")
> > here?
> 
> Yup, that's a strange one. Indeed:
> 
>     sed -n 's/^host: \(.*\)$/\1/p'
> 
> would be the correct way to do it, while also being compatible with
> BSD-lineage `sed` (such as `sed` on macOS).

Ah, indeed. Would one of you want to turn this into a patch?

Thanks for the report!

Patrick
