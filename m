Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C3270570
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834449; cv=none; b=GCBDRjZMlO+CCuRttx/tq/Q98rfkW8tumyrb8901ddtuZphOSF2FXQ//+CYSjOPmP7rz5IH0vdIPsvbWF+gh4NV/BKeQGb4CeqihpbGBI7k1o+QNs1ukeusu3W1XVVYj9Qk8gVGOX6dhLIj8sL7Q1Hw9tnvwT+GXNmOOa//OPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834449; c=relaxed/simple;
	bh=RalzPiNWet5pT54ovJh/qO4R/SB5XKqAFcx2G6pD8xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyPMj+ZGKD8gzLGYLNe3vuGLJCara1tLhehVIbE6PR0h0DJYimkJXzhTh6EAvsS3oTpgV6w5p8y73JrhzJcZgv+zaUbbaRESk6DhYerPIsY5ImTsWS1NYoiBB93GEUkWjUWFGT5uUtkGJ1Hu8HWz0SvIPtastpQu/+5deWOzvFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hbMOXkzd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VD3HfUEM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hbMOXkzd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VD3HfUEM"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BAAC513804AF;
	Wed, 21 May 2025 09:34:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 21 May 2025 09:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747834445;
	 x=1747920845; bh=Ttvs0N8Cdlu2IxIzp4zv2cZ2KXFUGBHJWoWwczCeU40=; b=
	hbMOXkzdMA7DoZ9kk6dAQc/WU1WviIBQmquRo+FFE3G93Cd2RcHjGixJ6ar6ln3n
	zN2WGpoV1yCu6gNgDilIq7NcUuY3loMY9LYGMwZ6ak+T48QjjOo9oaHdwLv18uaj
	LksJJnb/IJL13k3YdEiZL1mu6SBXm9SHJshkGRoB5eyvd1vaflvbCwCLNGALL7bw
	Dvi0OgFqHrW8Wlsbpu65+h6ttYbhnvEgpXbjzogMGfRh2Jr/8Xgui657z+EpkUYL
	oV0/bU8ftQD35a8i77NoZkJMpHwidPGAe9/Re2FK0BqNh19TFuwIrFZiishIU+Ez
	beQn31vWduIMYEL/oBgeQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747834445; x=
	1747920845; bh=Ttvs0N8Cdlu2IxIzp4zv2cZ2KXFUGBHJWoWwczCeU40=; b=V
	D3HfUEMFp+EWynM6euv0d47MrjP3LyKfyOrOh2zf/rbHQJlEI/awIKZP8FwrFD8I
	a7HPFdYLvCOHSriW74I0eq1KIBAcT7q4dU21ufompC80movfjZl1U46kQ+5NW0aP
	Yl2lKmRv+Q/r2x9lRlBifij90MnZ2pe5Siq5wennKxdDhA37suo50X1+H3aOO6dn
	ydngHsQ9eSkGPQQ0Oobv3+F0M9tAPbkWJ6mrq6GiTugVHbuxBTavk1SLrmXvlfpk
	nVV59ei7+xnQHz2mXTvdRy1sG4vPE4vX2XqoxZLgugVjhmwotw8Sat3VpNE480a5
	TaDQqfBHShRfzPFNX4LsQ==
X-ME-Sender: <xms:TdYtaGJKSz7r9yA_YJZu93JpmMjQStita7vHN02Rsgs2B7i_XDM8ww>
    <xme:TdYtaOLTMAE8upv52wdN_a70CKhzdEkJSGp2LFiKiuXki6adsjXFH5SmCg-LQXbtt
    Ug-n9NTzykabbbWbg>
X-ME-Received: <xmr:TdYtaGub36fPu_NSr4-jLqwNHSlRg82cp-AKMKeWq5zHGgnlg0IIspCCJzWiXvb5hv3nmgT5jMMyuOWsqCTgO8KPA_OmMWTemmKq7PqSggIPCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefvdduucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhgg
    tggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheei
    teekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:TdYtaLa6XrUZxRa8ZCk6TThbMLOEHBLR0c4u9Zgy_LBNQ1r1blAuJw>
    <xmx:TdYtaNbHIIXhWzzmHDTIFVUKn8yqAhk_RSMOL9r8gA5FurKXpqNQ2Q>
    <xmx:TdYtaHD2rXC_cnPwPOEmxJRgqKvGvDPj2uE8C93iPBEN774s8NS5HA>
    <xmx:TdYtaDYfWAc65Mx6331NZ2wXF8UPXTKHHEAL755gNHIbCsJFIqU2BA>
    <xmx:TdYtaMbEQ5diWdKxJeApXgOEgq_kFT6VMzQHVN4-XQgJ47EoMqK5rhU4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 09:34:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83a9d401 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 21 May 2025 13:34:02 +0000 (UTC)
Date: Wed, 21 May 2025 15:34:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Calvin Wan <calvinwan@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/4] editor: use standard strvec API to receive
 environment for external editors
Message-ID: <aC3WSePH3-7jJk-5@pks.im>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-3-ben.knoble+github@gmail.com>
 <aC2HF1VEosDMY_A2@pks.im>
 <CALnO6CDGGiw2HJTjfhvnmLQpQYDJqQux7UdO1tv0c9-LqNXMxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CDGGiw2HJTjfhvnmLQpQYDJqQux7UdO1tv0c9-LqNXMxg@mail.gmail.com>

On Wed, May 21, 2025 at 09:26:50AM -0400, D. Ben Knoble wrote:
> On Wed, May 21, 2025 at 3:56 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> > > Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The order of these trailers should be reversed -- your SOB should always
> > come last.
> 
> Thanks; I didn't know that! (Aside: rebase --signoff seems to add SOB
> even when it's already present. Is that a bug in rebase --signoff or a
> misuse of the trailer on my end? Setting "trailer.ifExists =
> addIfDifferent" didn't seem to affect it.)

git-rebase(1) assumes that your SOB comes last, so that's probably why
it re-adds it :)

Patrick
