Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DFC199FDE
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960008; cv=none; b=sDiSmOHs4xeq5eKe/vNO24wYUNrEJoYoF6Byl4IOYNUrIfvyt8463I1xnby9MLvNGlCg7zKx9zOKCA/bsRafVzpj1Obffr75jdJPKb431FuuAKML8JW2jG8NjRHD3tCrGiWZg9MZM+gFA7trfl+mFT/C73rudl+ezb6mHpG4WkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960008; c=relaxed/simple;
	bh=W4/kpYzSDi1bSpzlL0s7LcghdUC1O1/GWsDfz0td8oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwsu7AhRh+3lGfrXJe4kCkFW7i+C6Uyltb4XR4Hvos9JfynpHs0dZEXOwXfyvupVxhtVtFDTNLI3vJEBPr55VT5xvDQvp8LauUZa7LQZpHQzGrOn9cBYjQZenAhRMsHsTesFKFSqu+x7wXkanD3wtyCMK1DFIzQTykggBVqIPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=shVsR9De; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ATDWp48o; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="shVsR9De";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ATDWp48o"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 273ED138011B;
	Wed, 15 Jan 2025 11:53:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 15 Jan 2025 11:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736960005; x=1737046405; bh=GiANh07hLr
	e+eKibeiSGXLjnT+ji9xKdcxbJbaLixJ8=; b=shVsR9DeG7Ur1F/6qBguPvXH6E
	suB5wuFLz72acf7jMimeO+Q8bM5NKpQUfyu2BrPTjqILe8gVoQJ/AnxNLsHix9x5
	jhZIw2gektTQn6yCOfzKTg1nURtAEu36qKNgBGHTDSYRstKIrmdBCqoVdUJuNA7e
	RJIOF3rJZWhWnZnhitZVZOEuTa9MKmDnlIwYU9GZwPUyruOYI6UuJfkdLjJlenRw
	oY9Il186xOFwZfUs8ZHForkKBaIUu1qRiQEGtfJmEZdsJcLn01ggMSfZQgjDPGbI
	XMOIAbnb6bXGtX6jJF1oxB2ndt1WFK/Skc9bfmcm5LLS1TweN78NBSMdqZOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736960005; x=1737046405; bh=GiANh07hLre+eKibeiSGXLjnT+ji9xKdcxb
	JbaLixJ8=; b=ATDWp48oFGFtKsgS16DnYar828hy45qtyriHN8xwGbCAdtpb8ZQ
	CsZuA+mzI87d1pBPJiJJM6tqhlgdckATXIHlCfwlBP9vS/+wVvI6PYfxcg33y58K
	9wmBdRgEZuVTaemRo5g1j3Q12T4GyInHO8gzjvot4XrsJ7S94Qey/2r0oxIBAiuM
	tSCAA6hClCMhDw32gM1iu9QiJ4SE4gd7llp02yAXSl9TD9P+6WAY1l0AHDx9A7GV
	yvjsVIeH3vcxO+Fz3NEPfvidSVepOlKQbOznRznmyzQDHLPHF7qP+GdC5eprx6JU
	8W+9mVdAeHb3w9pRdEcONLxmm0wn9pOzcBA==
X-ME-Sender: <xms:BOiHZ-wPESRux4VY8zvW1TYzONp3ZPis1IE5F_U4vi5PbE_cGVCEoA>
    <xme:BOiHZ6TrF03zT7MPoHHDzHXmdY1AtXQfNwcjBmChY9eq6xeMhl3udDwwshsS6Uc6K
    6F6Csxqx9cp_HVyog>
X-ME-Received: <xmr:BOiHZwUFdbsAUK9kH7KXO3aLWDClNbl8uzQjhurlHHBqwmXQZ-jcYURmuEN2JKh2iJvRgxhiBxrOIg54zCxTiyIiZ5jygBIwL-1Q1gxpEh-2nhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:BeiHZ0gN1S5bdlyxdB_ERra9iTI3BjD8Vwn_2_UKOtmpjznbzSi-Eg>
    <xmx:BeiHZwAcSUXWUJd5Y6krGlI4CHAmHMaV6t0KFs0hnECa292rcNTs3Q>
    <xmx:BeiHZ1KIL4AINR32KVLgwUN5uJ8jFrnq_8Vil0Inh5n3t0XOG5FS3g>
    <xmx:BeiHZ3BI7IKSt1O7R2hfeYmGhXkEQGDBBfvUqWIBblhGOne4DR3sPQ>
    <xmx:BeiHZzPmTZN4Y2NqOQxZRn954YFjF-ma7LZRbIyqjmBjyfB2HkeeAZ-m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 11:53:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aab1d698 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jan 2025 16:53:23 +0000 (UTC)
Date: Wed, 15 Jan 2025 17:53:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 03/10] compat: introduce new "zlib.h" header
Message-ID: <Z4foAvj_5meT-a4P@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
 <20250114-b4-pks-compat-drop-uncompress2-v2-3-614a2158e34e@pks.im>
 <CAOLa=ZTvW2T3rds3YN0m9iWQC+sAaSCsiRw+fo57FqqF24pMaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTvW2T3rds3YN0m9iWQC+sAaSCsiRw+fo57FqqF24pMaQ@mail.gmail.com>

On Wed, Jan 15, 2025 at 02:00:15PM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Introduce a new "compat/zlib-compat.h" header that we include instead of
> > including <zlib.h> directly. This will allow us to wire up zlib-ng as an
> > alternative backend for zlib compression in a subsequent commit.
> >
> > Note that we cannot just call the file "compat/zlib.h", as that may
> > otherwise cause us to include that file instead of <zlib.h>.
> >
> 
> TIL. This would be an issue if we added "compat/" to the list of paths
> the compiler checks for headers no? I couldn't find anything in our
> Makefile doing this, or did I miss it?

You did :) Most platforms don't, but we do with MinGW and Windows. This
is done in "config.mak.uname", which is probably why you missed it.

Patrick
