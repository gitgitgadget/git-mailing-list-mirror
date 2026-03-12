Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453283CF024
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332517; cv=none; b=f6D+Jjz//Ku19wtyVJ0/7zNETj+r+jpxR4NaOVx2LITljhKJwjt2cDS92Wx0SAig7o0wh52xHDW6RH/2GDdcbqzmWR42d5uroj61IAtiVm5oihzgSkyJAWTIMH299wL/QcYjChSEC7zvSVNFICd58BuvxfLHGBGGMgVPNDEFvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332517; c=relaxed/simple;
	bh=01SkW1MxFUF4DhlKFUPLKqtX0uPK38Xk70BTLwyjVsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RGuliuhowhbG+rfPESw1pFYFzp8fJWrLgHGbF5F8b8ifp2KRxlOSY/8zLKxML4ZGTATSyZ2NXrs0c8/htqRcYET4wvrd2Ad3jQELVlMVBnX+kTEByR1Aopw/TzQ+mDKHkEl3sgLN+vQgrbLZGMyFP9L27cG9KOBoQmneQxWHpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AkIvhFVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XllPjzgd; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AkIvhFVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XllPjzgd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 145937A011F;
	Thu, 12 Mar 2026 12:21:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 12:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773332514; x=1773418914; bh=mln1CxTC9i
	W6ldsQ0E/iqalU4mlzYqU+iP0flE+qp54=; b=AkIvhFVK8tqyhKWnts0ccZGxGU
	nrdy7mrkwEXV8PurJZwVmd8C1I6uIbH5HGvVDsMUaEDq80PTauq4xBmo4IT5G6hN
	ZythrLf1OC3rTGTL9p01KQ1O6K1hPOIHyt4YSWyijqigw61XRU0u3BVkPiKD7q7m
	WhCsofc4VoT1WCDDeUbNzUlXFrOM3DB7odU6xW0v+IOa0Wms/dzoYgdrZ44PLndc
	POfAXKEcN8H5IhFkY+rRmPEEdYUtJ7V8WMfpgovspwEc12XvdvXJfBAnW+jxR/bP
	IgdVTI2YEaTUuiCJpnam6o5Te9bGiVZZqFjYsteodBHphx27fXJ/i5dpG0jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773332514; x=1773418914; bh=mln1CxTC9iW6ldsQ0E/iqalU4mlzYqU+iP0
	flE+qp54=; b=XllPjzgdSgV77S84VXE22p8PZhxPw8zzsuTsYzPTGN4vuYP3/8e
	GD3URfNL8RhHhncgVNuDWyFprZmDwgs7mgOiTDIPW1g6HtSrH1AvA7LisRu3vBkz
	NZzoGIPr1IDh5rSPKIE0o98J7ivlLNiln/pDc6EGrepz09XTIvh1PfYoX+r5fPnW
	gtq+SeMy9m8d4UwsbbNSpLkF85F2/HWwwSyPsApEHfMZRTJkEAe+6Ny7HOqRczJV
	BEKHatefZhyhHsyDi4fm8HRFi8fPYs9ryOFO9qE1XjMLxgX76WnqhluX843lZ8cq
	75WCCEaNLmi2Moy6P6fracjd9fMZAtjuM9Q==
X-ME-Sender: <xms:IuiyaW2s_EEjiQ5GVqtTzrcdpYlkYLBQnvg75XuQeVgV9odOS9kpxQ>
    <xme:IuiyaQhQzUdsIGN2BaiRn-k5imqQShSwOu2xfb1KVYAH1hmqIYVKpGThjqo-eK5Gr
    d5Y5O1wKOz8CXAAq7Pa7Vc-28KjNeTZvBxBc1QSlQSupmzEllGeUfw>
X-ME-Received: <xmr:IuiyacRLMPQtThE75MaFh_GtU8QenTfB8hLmw52IIaW54vY5FVVRR1_uLTvMrH5D4hhtxI_8gk2-ybJHzrp_Y5Egd18_WEl2XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsuhhtihhr
    shhkhiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IuiyaRjeHBYHev_1FBnLJECPwk4692RaAqMeMklevdH6g9XRn2idRw>
    <xmx:Iuiyac6bVVLjqQtWUtTnXt3LleA_oUJinN36SPwSmFoIP7gJmVK2mw>
    <xmx:IuiyaeDr50jODZzAkDgkkyjSozgC_-NReRmumLoftHgTavn3g8uyUg>
    <xmx:IuiyaTa4_Yjjdw7YSSe0LuzQV2G1GhDyDSHWve1D8rEu01mCYTSU4g>
    <xmx:IuiyaUhUtHxTnEGqKChbNwSILfhQoX9nGTN85kuV3RwcyQxK5Lxe-FVn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 12:21:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrey <butirsky@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: bash completion bug: "symbolic-ref" subcommand doesn't complete
In-Reply-To: <c1e0c05b-c767-4fcc-859a-4da6b90c4497@gmail.com> (Andrey's
	message of "Thu, 12 Mar 2026 19:14:16 +0300")
References: <c1e0c05b-c767-4fcc-859a-4da6b90c4497@gmail.com>
Date: Thu, 12 Mar 2026 09:21:53 -0700
Message-ID: <xmqqikb1ggri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrey <butirsky@gmail.com> writes:

> Bash can't complete some commands, e.g. symbolic-ref, bugreport, maybe 
> others.

Isn't this working as intended?

Our general principle is that the plumbing commands are not designed
to be "typed" by end-user to use interactively, and cat-file,
commit-tree, etc. are not completed to reduce cluttering when the
user does

	$ git <TAB>

If zsh completion includes plumbing commands, then zsh completion is
buggy, or those who designed zsh completion did not understand the
general principle ;-).
