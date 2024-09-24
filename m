Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E12E859
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156028; cv=none; b=OAHYsrFoAiAdEQXB8EMK1OvWT5Tl86OTN8QPq/zkz7i3BZd9vNxdFzLxWCJzxX2YgE+gTfcxCc/gpkJjWGhGIH/BW0A6j0RQNvnJsQzleBtYLLXSBLsKYmpYrEoFtWiINqRInKB37JGJXAUWw/nNC4ZtGBXVKBMkdVk+LsWX9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156028; c=relaxed/simple;
	bh=vDXLQL1pkWeDRF1yr0G7wR+yoyeVAWcehjsQvxQsuQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsrbPdFejfHGMKUpt9VZs+DJfq9g7mc2jzu42UJEd5BERlBQS4PzjiXIE9126qRujHStqkPo0AAM17tydRQtnerqlhtuUgY074q79MGphSzSyEedr2XXEd8bAq06dipToP6uy3Yz+aKUa/HWJpqbU8AqdiB2fLG9juMFlwQnW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZxuOPnzh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YFtxLhLg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZxuOPnzh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YFtxLhLg"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A90C1380494;
	Tue, 24 Sep 2024 01:33:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 24 Sep 2024 01:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727156025; x=1727242425; bh=lF6GRH+s/V
	gTz3mRFGBGCzYI00iApX2z7W2iKNXml8Y=; b=ZxuOPnzhQev6HtTWwD492yjtRm
	+VSyxa72B4oi16XdZsd26a1nCf6h4L8G5VW+T+LlIjyM28rwxsIx1bYpt7LS0+mT
	LAiHAeU7b5w/pIhjCavtXcCfg8QE6J64mG0C7dwjgdLKQSpcDCvvGPW3POOG9RFT
	Az2ZFSwh//oT8Qqv4NEKpKbHT+iA5PzEE4QHKQkgL0tq0hcJnEQC6szOnEfNw1I2
	vpXcw6+skipRR5mdG09QZR6pCSZyPQUbnWw+VJbgb6BpAxKoSH3wBaBCjCpQ3sBK
	Ao6sSG2C55nUuzs7skdpIt1UdQO+/14FtJKdp9yYw/jwjdR8OUFPyEG5wTgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727156025; x=1727242425; bh=lF6GRH+s/VgTz3mRFGBGCzYI00iA
	pX2z7W2iKNXml8Y=; b=YFtxLhLgh/Mjc885VNuf4b71Cr8rU8nGiPJ3+xIBUbO2
	sW0Wz4JKbFcd0ZsCxQLt0N2xjH7mMTgCoL8IC4Xap4GGh93hkhIxVGrAUvEtGSQ9
	rDYWe9ELbOLSuEXC1DfkxAgvTu2y8IGgTDO6S8YCtX8h2M2IjSECFHzjXm/n3kTf
	eVkLp4pZ5LGy7QWUB2Aff6D2waidV/KzT1aXHU9XJdYxMEwlOHWoMK33k3OTj+eI
	9+agAg9k81szVObNobT/2sZOqt0jVoaD2+9xX0tjb+DUPfjcMdIxECDH84RN+fdB
	s3Unj/HkYrQoTBKe5ISC+zrMejTExh4MBxVAQGZpBw==
X-ME-Sender: <xms:OU_yZpaBqrc2eskeiqtfJHMb7ZbIk4FixlgdIidGaFClm6jBl5UOaQ>
    <xme:OU_yZgYNRDaHJF4rEIgueldFeSXG7FvHZVweKHQlyHZ0y_JgH0zTJtZ9ftPga4WJO
    DCfSOv66lbY1ypa7g>
X-ME-Received: <xmr:OU_yZr9HlWu017GAPCI5mkunrZUwbNZDSuEXx2KzLeRBLu7u9VEJBvDAuGEejEfP_djjl6Ty4xpMFRrRoIl6soRohuPHswR5YbxDIe-z9DMRTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmvghssehjrg
    hmvghslhhiuhdrihhopdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:OU_yZnqS_PfvGIOmGpYMs7H3POSciTMPTErGWGQPOJSPlT50tIjBeg>
    <xmx:OU_yZkq-35Jjeyrz1mANrZVlSa7lcfHe_W_FwEdppElnHZhgU7cW9Q>
    <xmx:OU_yZtQdWaesl4qCjLPmxeRXboG6IMT1hl40H-7eMJ_zOCx4kFrNow>
    <xmx:OU_yZsq8yxvX5-WDcdh0a3wacvLVaBqziTgR2UL4x-8rh6asNSeuOQ>
    <xmx:OU_yZpCaomICnlEbxiMY0x2kNISZ_kglfleaN7yI8irXATHIHUEnAxF1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 01:33:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b02a41d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 05:33:10 +0000 (UTC)
Date: Tue, 24 Sep 2024 07:33:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>
Subject: Re: [PATCH v3 2/3] reftable/stack: allow locking of outdated stacks
Message-ID: <ZvJPLB-VitzqEMbY@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726653185.git.ps@pks.im>
 <6130565498e51ce3228d6fe5bc5f0b83c0db9182.1726653185.git.ps@pks.im>
 <xmqqzfo2gprt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfo2gprt.fsf@gitster.g>

On Fri, Sep 20, 2024 at 11:10:14AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >  int reftable_stack_new_addition(struct reftable_addition **dest,
> > -				struct reftable_stack *st);
> > +				struct reftable_stack *st,
> > +				int flags);
> 
> We usually use "unsigned" for a flag word, i.e., a collection of
> flag bits.

Oh, yeah, this was a mere oversight. The topic hasn't yet hit next, so
let me fix this in a final reroll.

Thanks!

Patrick
