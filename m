Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B81AA1D2
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639080; cv=none; b=tF994fBLhnX6pBW8cf24YAkKCz+JlzyoMBRCxOSsQjTGPxneJTMQTz6+U9ruSYfAR0wGsefQaaW29DS4kKQxJzReMIBI69mtsYxCx/PY4rEn6yzNdTeOz325aVuP6mtODB/ONe0/igEGHlqg5yNwgGBwugsp9sevxcTLKZJUItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639080; c=relaxed/simple;
	bh=mSfN6mqdAfE86SOTO4GIt1BcyasTX1QIeCwZQdc8eOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5Jt5YnQiHNXzEsgCd5j0k5z9IKnT4l0B5isRMNX17phWcggENtS8zPupzc3bM925+eRcpeYkqwxP4EeG/SAueBRTyWB6hS5mCWogehKOPA8VDRE5GSn7bCGQnp1fEB4NvZA6ac5hq5OumLmcvw+NDjJBSnwlZ8NxD4WIBQoF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oxw0bx2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T1kZAbP8; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oxw0bx2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T1kZAbP8"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15A2825400CF;
	Mon, 19 May 2025 03:17:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 19 May 2025 03:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747639075; x=1747725475; bh=mSfN6mqdAf
	E86SOTO4GIt1BcyasTX1QIeCwZQdc8eOA=; b=Oxw0bx2TdGRz30HKe15pVSGgHa
	Das8oLSP4OXwmCsaZnXTBb0uocWgEQZjp+wgpEAue2QDLkoehmCazRmK8l9fb+40
	vuMemF/R7I5xJnWxOdWh7glT80mk4kU5Jp+lG66z4g6KfTjQJSig66+/sInqTvaf
	i00rzAKmVSUUbPEuZ2mCvoF/93N9UMSIZGFIRdJLSYSnOFEN3CqZeXS6+DtOwNhg
	C3zsExady3kR5KIK8/AbIIX7vwHtEuSIbILCu/MalI980Hl5U0q5yMWbCV47wFZj
	Cc4joISJt6/7xMYXWEYkJsmId0lMbg4D+cLFivTzru8RvCsT+qhZ/T+UjHSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747639075; x=1747725475; bh=mSfN6mqdAfE86SOTO4GIt1BcyasTX1QIeCw
	ZQdc8eOA=; b=T1kZAbP84c0jdP1Ttx1BbXryT92M4TKaMbHrGwSmZhEwYfZAgXF
	qqbl+YiLKSaP9TeklfIKJpP0Ll1/LgCZh4Vbd9jovfKXeC/j7Pz2Q8MJW/xfifbC
	vI157vpFqC65AxWbJGwrtTtLEi/PUggHnI+fmh7SLYBifCy7NdyWkfIjQt8j+3bw
	K2smujl35IHoKnyIHiqrzUgkEusvAXdJfMHQnQiAO8w9QH1XmPfxRGsq+PfUIDo/
	8PmKOg4k/26TEJGpYrT1h7/Wf2CqWKkzF1lJXmwtNWmmOX4W9LEOnVJsTtwHdz5L
	wHWQJAqRYC7GrBI10OFrFAO2hDs9/BGalJg==
X-ME-Sender: <xms:I9sqaIf18Y9t76C-VfIxx0qgyOm2ryhlvQ9fBrdelSatsTWIVY5SVw>
    <xme:I9sqaKPwBl9gyprGjEGV3xFA5VZmoWwSEznop5lkHPojbvueViMEbtThwg2cuAZsB
    Tz9CVDW4YQ9mqKU6Q>
X-ME-Received: <xmr:I9sqaJg_y9nRavBlcipWzRv2Cro22-g6bXNTn04xCRUJGK1khBcjHiNzEfBQ47hLrlrjuoWREsXUXM1zCiIx6hz6zZL75Pt2F5dISVPWO5MG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I9sqaN8PsAusVmA8Qvb9S1LinZ-xeJJvr5CwQPcN48wCH7ZAldhGUA>
    <xmx:I9sqaEvgEGhjA-fhxEr37iR3lLTIJgLq72BzglF3CLyoX_QmxAJ_lw>
    <xmx:I9sqaEF-vcj-ZEV_eWgYghP1L_OkyfoaRLlQmts3dK4EapuIVWDh_w>
    <xmx:I9sqaDO5puzeO2CWHNQGplCTIzhkc8uYc-bHeNWci-niGkYzSLlobw>
    <xmx:I9sqaB5mJZTIolAO-DpHkFNyc3rHS5IQ0mYxhUaqvjbK698IqYXQ6s_M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 03:17:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0f9dbfd0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 07:17:54 +0000 (UTC)
Date: Mon, 19 May 2025 09:17:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/8] string-list: remove unused "insert_at" parameter
 from add_entry
Message-ID: <aCrbIbB8DDw0eeae@pks.im>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDU46MmoGPB60b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDU46MmoGPB60b@ArchLinux>

On Sun, May 18, 2025 at 11:57:07PM +0800, shejialuo wrote:
> In "add_entry", we accept "insert_at" parameter which must be either -1
> (auto) or between 0 and `list->nr` inclusive. Any other value is
> invalid. When caller specify any invalid "insert_at" value, we won't
> check the range and move the element, which would definitely cause the
> trouble.

Maybe "which may easily cause an out-of-bounds write" instead of vague
"trouble"?

> However, we only use "add_entry" in "string_list_insert" function and we
> always pass the "-1" for "insert_at" parameter. So, we never use this
> parameter to insert element in a user specified position. Let's delete
> this parameter. If there is any requirement later, we need to use a
> better way to do this.

Makes sense.

Patrick
