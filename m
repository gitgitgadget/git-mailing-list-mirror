Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D881745
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619614; cv=none; b=PJ9cOyuBb5VxbvwlYABj5X5Kli2ByPcg23w+XrRckXmMk75J5DIvPSxXdLrME3iyBbFaniULgkPzXbl3R1hXaiaKkDC1HsVSwv+y9CxMXcq0IyvbKuDk8cJii5AsRKUA8/SF864P6hAeH11NkWY8Hoa+HaHCBrwFftcC4mjQvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619614; c=relaxed/simple;
	bh=3FgJO89iHBwrA420Fd8o6XQhIywNQZBIVFVlSO0r+Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMMJgr+ipifzEC2ROVPk6g8dJocotyHDMskK2y8dXw/DmG144Nm7lW69DRR9eDBQntoQ+tDmsseuM78q2RBQseryzZLM6jyl/k9dtWmrwaHxo/aDED4HOjxOCTow+1PmbuRKd2HiQrAR1Hbb1of3PTO6DN5uwN3nnIY9xAxVybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L9FGV5Xa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nl3qElIW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L9FGV5Xa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nl3qElIW"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B26F0114032E;
	Fri,  6 Sep 2024 06:46:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 06 Sep 2024 06:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725619611; x=1725706011; bh=SIcRaLgK7d
	m5qibFpy7j+hhe/NVjFq+677j30okXuu8=; b=L9FGV5Xah2tkYdlNPIEj13tRfd
	fDiagCvAiHYm36Knu1m+cz7hlwpOGPZxd2McccqOvs/QNr4lvSUbRoVP9jqmM3rQ
	aExROWhVbwIClcoNZqp08K0GrIZ66Dqw/O1lP9/ZNF2l63T92ue+NKTA/WsKO51m
	KOA1gWSr0WhTBJP6sK7CDKMspmlEbLGcmRUD3SKLMVcVY7XkEJeI+Ssc1ieQsSNf
	Rl/RC6Jgt+g4iGvrQaMyfrNf3d/oKkhDVcyZ8bSGIur5PImLPxMkVKQ68tycxLgD
	vfFMQpEmDHaB4/9nv5WvLAF45v6gEXdT/zDmHuBbqBMuPLD/MamHqVZEL7+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725619611; x=1725706011; bh=SIcRaLgK7dm5qibFpy7j+hhe/NVj
	Fq+677j30okXuu8=; b=nl3qElIWrNP/vcsPRfqtHTapx3umWG70hpi33QcqAcG4
	2JLLi2n323F6hmetXRGVsPZyf5TnIw/ADXdUn2ZV9gvj32bPP1UIRGcgTpKiTbuG
	YxAnHlCTYydf3WpYfBnsod2woQobRQ9KTcBOhpnQ4irl0gqUkFgXjHSkcjXossR6
	0FU3xJ/uKZM89M92GkUq3g0/UG2GH4BNqx2BBFc5rjyFFbs+cVnFUcrLeGIvvtN3
	9tZeGquaIyYcYeuKy61d1eNhFSga5V9UZvC3uEpPOfxJYCUnEEsTa3cbj4LD0mS5
	78TEGg52MuaROd3LQbcag3djyyyGKQOlNDahw0HDbQ==
X-ME-Sender: <xms:m93aZvobYbVEcY1T3SJ_uony1RSASzGz8HlEFJgwIGN0TStOggKVuA>
    <xme:m93aZpqh6VeVSMPS1Uf2nNVUSpHM1_n8_UshUnI4z_7ncBOdemMoAQz3Quvu8VuA9
    OP522yuSxLGC4BMlA>
X-ME-Received: <xmr:m93aZsOCAtMBO_6zr8WzEglRx7TbpiTKq8vKG3RO8U84FEQxxB5E2_iIz5IVSkUr6l_sMQgZnxO7Z4x5Z_rWWNUMwWU80_uDGQkcQIDNrUMq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekie
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:m93aZi5LNARXWtZFtS6fVlTa-aDwG-cE6EBNxubWeZk8smi0z9c85g>
    <xmx:m93aZu4aezRnOxDrY__Kd-IHCeJvNj7ypcfNSYMC6-SYsqo7yZuWrQ>
    <xmx:m93aZqjn6qpHmFMtEzn7INMOsTv7piVM1FCsRLrVmMkNpi5xsa9urQ>
    <xmx:m93aZg4ko4ODAPLcyM6liMKIeSzO5FSc5ph3Flgiw_ENOARCAMuxBQ>
    <xmx:m93aZp3mY4hWkWf6bO5_TfKYeM756dvxu7WOwhqEw7XSPCyvZrYgHZk4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Sep 2024 06:46:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fc914607 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 10:46:37 +0000 (UTC)
Date: Fri, 6 Sep 2024 12:46:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/3] builtin: remove USE_THE_REPOSITORY_VARIABLE from
 builtin.h
Message-ID: <ZtrdmW3R2GvUbOkN@pks.im>
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
 <17acc1e054c26b67659df17db828b106c005ffea.1725555468.git.gitgitgadget@gmail.com>
 <xmqqcyli2dnx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcyli2dnx.fsf@gitster.g>

On Thu, Sep 05, 2024 at 10:50:10AM -0700, Junio C Hamano wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: John Cai <johncai86@gmail.com>
> >
> > Instead of including USE_THE_REPOSITORY_VARIABLE by default on every
> > builtin, remove it from builtin.h and add it where necessary to
> > individual builtins/*. The next step will be to migrate each builtin
> > from having to use the_repository.
> >
> > Signed-off-by: John Cai <johncai86@gmail.com>
> > ---
> 
> We at least need the following fix-up in order to play nice with
> others, specifically Patrick's ps/environ-wo-the-repository, when
> the topic is merged to 'seen'.

I was wondering whether there were interactions with this topic. Thanks
for checking.

Patrick
