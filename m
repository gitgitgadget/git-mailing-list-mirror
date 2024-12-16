Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C9201018
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336106; cv=none; b=mnwne/VlvUiyHwIggQQ6k/wbKgYFD+A4YYIARWJiv2IG/pRjrsw3Mf1diVvzI/HEl0BcYieGeGcbcwXE2ZuQH0z/KsEtpvrYCYMit+qk933RoD0OaO9+gxRNhwP+KLLK1Q1nMjbZiWHAqqDO2WDbMif4c0bgqD8eb4EJcop6Ftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336106; c=relaxed/simple;
	bh=bshC+5T5hLdsmTq9ooIDFJTMqpjGgZF0IFMRi55yv/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyS90+yR4OtLjIn0u5o0LwqMI8IZAD1Pv+VFqzwbdWSuUVwAXoo33uNaXRCDsRrfxw9xD0C7qnKKQ3Ol2hYHLHJFSnREXrNowZqTDNflkuLfZ9kbiK44rZURoxe+gKDaPg+iF86sEZqVO4WyFJN8Dnr+WTG1PU6wJhTQ88s/gfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fvvMoejv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3q+PaJJ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fvvMoejv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3q+PaJJ"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73171254009E;
	Mon, 16 Dec 2024 03:01:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 16 Dec 2024 03:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734336103; x=1734422503; bh=eev/0p/uHp
	8Eid5pIW21bMnfUSMiwwBux+rndEtczGk=; b=fvvMoejvNR6fnGjzcoYsNBY4yd
	je0AhP8ickxLrAhZX4Ga+iLkEbOViuCF+FrkhRHRuT5SFY6yglziVQbdiRc9s169
	n8vhSyTLdV1+QgcuDxijYm0piXdqpFyKLOzR4ze4H0ehjvGb+wbXyz9ZjXFMf7IK
	r/dyk8mltRrs3ttvlth7JDSSrrclCBOi/8/h2CLK0amNNHK//Ejlvn3nMbPp2SPt
	piyujVsbUb/MMWTZkGBPj9ZnWTMynEipVQBW266QcWB9tl3KvbJ2JMbz1UUVnCd7
	/UWV1FAsjRM/AcGvniTBSvFIJSAYQ9gN/FXVZKhzW5joCgLtN9xZHrsYOAfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734336103; x=1734422503; bh=eev/0p/uHp8Eid5pIW21bMnfUSMiwwBux+r
	ndEtczGk=; b=l3q+PaJJ8fKQVdIzxQ286S+mJRxhWogR06QPNJrw00m9TsOqh+p
	J6weVu3J5dEHqASzE+D/7eeSRzL4yNc+YdisRj26GpKZ34vRVrn5HCZhDY9WiK/s
	0oeW1/MSN26Tk4Kcx/LI/RMcFIKtFxDWe7CD3Y4iKA3LA3R6bEMmfYGKrEE9A7Lm
	rZFLktghvkHXOeP3cNxvEODGkyHKcIZ3FHjkFyifnwIT6ffxxnqnc6rQwRvHwgjM
	KVoXLAlluHKU54OlEbtCnk/mYKgh1c+vuecpJBWfqIarPdTkaMZ4PqZxAC7XcYIw
	jXwKntjTSaeE0rQqO6kf376RMIc8HCNONBg==
X-ME-Sender: <xms:Z95fZ5ZtGyv1YG59bixFG5nl2FC-HFhrK6OEbijNxfGi0jB2aRd4Cg>
    <xme:Z95fZwaJYGHymOLntCRAR6ZBseTQZCmAEr6y9dhl7Hu-yISkzxoqfofZKslmeoc4N
    4NSwls9K9kLHNKqbQ>
X-ME-Received: <xmr:Z95fZ78THq6ZMYpI_BWST1XuNWXKy2Gjk4SClQXsohYqTCrnd8D7C2MK4beP8doo7XoO5t7FHK3u8DbTd-L9v36c0wIdMzHLrnyLfyZOs7KPmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledvgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeguvghrrhhitghkshhtohhlvggvsehgihhthhhusg
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghi
    lhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:Z95fZ3pug0MKSmskSr1mCI7dFDCtRgZ-FrT5WRSyZRFI3xFT52RLVA>
    <xmx:Z95fZ0pq87SfUBN52R95HD3w21WxLsCiovU_eIhhZBQLbRBbYEj-7A>
    <xmx:Z95fZ9RZQWabHcr21dKZS4SSaTyUZssVyGF-2voSzvZ3NbnqfgLcZw>
    <xmx:Z95fZ8pIlVpjp6dYfNTzPvGTPKO_d5k0Z9iCj9nH09piSAK1FHH84w>
    <xmx:Z95fZ_Df-2EFHrjBGTr4E_KzgYLu_TMruSn_AildUZnkpPlQYyAO7yXk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 03:01:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 347f0d98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Dec 2024 07:59:58 +0000 (UTC)
Date: Mon, 16 Dec 2024 09:01:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik.188@gmail.com, Derrick Stolee <stolee@gmail.com>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 4/5] backfill: add --sparse option
Message-ID: <Z1_eVZTDPp9g1FhQ@pks.im>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <19a8efebbad7f414e3ef3fdca612dc1fcb835f25.1733515638.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19a8efebbad7f414e3ef3fdca612dc1fcb835f25.1733515638.git.gitgitgadget@gmail.com>

On Fri, Dec 06, 2024 at 08:07:17PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> One way to significantly reduce the cost of a Git clone and later fetches is
> to use a blobless partial clone and combine that with a sparse-checkout that
> reduces the paths that need to be populated in the working directory. Not
> only does this reduce the cost of clones and fetches, the sparse-checkout
> reduces the number of objects needed to download from a promisor remote.
> 
> However, history investigations can be expensie as computing blob diffs will

s/expensie/expensive

Patrick
