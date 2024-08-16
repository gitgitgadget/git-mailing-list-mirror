Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD0884DE4
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798237; cv=none; b=E+RdLMtoHGP9XoLinCPzVLYqUQpV8sK3UvdZ1Bm3dYzyqdvMSzjAk7x+C3Z6AbRH86Axvy9TbsjnJRztg0pdHmpu434DfPLJPGHeUx8OHub6iIjIicxJwQk0yNzWL2u/QzQKDlqvM5AlEtb24srSHayrrasKozrGIkyPOzvRv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798237; c=relaxed/simple;
	bh=gHLQlx+Co+hyw8zUUSSoe2uuZDoyrUIwr0uEV3hCbhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il9+exIj8WRLPVUkiHlljGisksc/NPcSBrTAM1AUZRCuHBTbGuE6UFVtb3TypCsBpbPbjXwM2C9SiIQIBlghq3GNpXPmBmCCirR68DqbK2iNJYiV40KAoihEus7qm7d6X9xMuItdQCPiCL2JFcMwhd0AxkuYa9lfDlPq/suDrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C1BPc3ln; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=opJ2wMUw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C1BPc3ln";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="opJ2wMUw"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5A71511449FF;
	Fri, 16 Aug 2024 04:50:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 04:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723798234; x=1723884634; bh=vKyaDuVmbB
	XuYCuhkjYQJSKQkd+DbsCtBNXhPyshXhY=; b=C1BPc3lnmIiOX6FXbIJFYItxap
	bQbJ20Ma7kZVbLWuxbNvQxAJgdLLDOI/Ix1zkKdk5g7MsPcwvF/dXRa4Vz8Cuwk7
	igSu3bAre022qtfXRPHZS92MxYReO8FSG0inRDAPiC6QRtgBvIvpmz6OIpONlsoP
	B4PZ+lvWBVlyHBsIuNX/WKNkz4cEFquNeLy3dWfGrLulF7DFlRctaWNfD4aJUxGM
	dEf4a1AMBwSFpHl6FE6YlfO262xgr6NCUT7erAdUO1JamB3fmg9712NC/GdoDY+P
	2DsS8LTP/yFw2TFcH7rZnkXN/6Chb9qD8bgGDE0lBnuR2mmbAzfMYSaH5McQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723798234; x=1723884634; bh=vKyaDuVmbBXuYCuhkjYQJSKQkd+D
	bsCtBNXhPyshXhY=; b=opJ2wMUwOG7ywGWvNh5d9TXj4miqeBgDVdI4DBS1Del+
	cvQ0IUi4Pdu03iiX5XEs48TnUTLGpRN7Kk/hZLOV84p7s5953wvg4eDKlVl7pqZ2
	mD8m+1y6xa3VJMH08BrkaDEwZzu4E74g34kxbfsM1bALmNYBcZWUnb+x1Ud7Vqcq
	623z/QRacVaVTK1Kiwyg1GJ6Wemk9EsX93BFV32l9EGlECDKSTckUFP2Ir6vBIt5
	JNxL6GGfctH0SScqOpypQd900jjKixPgHU8W0o9yQxzptPS2IIBo9isT7rrT6Lvo
	cVA/WsKBOWzNrJlWTCjeKqt8suup10coXkZXfvoBKQ==
X-ME-Sender: <xms:2hK_ZjxpGNUBhoLraaaeEsPg3WhWlRp5mrN4VSUBTNu0qXX-NkiTgw>
    <xme:2hK_ZrTSNv3Y7MnlhdCPj4OpffCHsf_Zx3AhYno53AstUhD150ZTro03ZRg5Y1u9s
    mgoTZrMxvPGTnqr6Q>
X-ME-Received: <xmr:2hK_ZtXG9V7WEOzDuR6XSz06JM2N1Y-XNwFUJS_-vRyYUABS3FWUewsjQ4-3hc34P_dceKies89Qvj9A05vej-7d2GRhi_oCDM-uXnfQbPSyP9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopegrvhhihhhpihhtseihrghhohhordgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:2hK_ZthyiIaww3r3O0aKheyKW1EClaffdhy-itqmDNl8wT5Etl9t7w>
    <xmx:2hK_ZlC6qkr9MCJHyJgmQi9K3MFwETbuKNro3UdNJLGxmUuz9i_CgA>
    <xmx:2hK_ZmLQu9Dqfn74bxXd8yg3nHnFtOtgslz_NQywOaRqLySGPCI6MA>
    <xmx:2hK_ZkBXJSaz4eyYsqCqaHKoYtRf5tgY9osw5T_kvmOLIpAJ7ydSxw>
    <xmx:2hK_Zo7sRPZwKB57AI_SY324RWa0wn0jAtyEi8ATVztcyCpB8fS-ERtp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:50:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c0dfa359 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:50:09 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:50:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Avi Halachmi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Avi Halachmi <avihpit@yahoo.com>
Subject: Re: [PATCH v2 0/8] git-prompt: support more shells v2
Message-ID: <Zr8SyWSHH1lAfyuc@tanuki>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
 <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
 <xmqq7cchtyfc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7cchtyfc.fsf@gitster.g>

On Thu, Aug 15, 2024 at 11:48:23AM -0700, Junio C Hamano wrote:
> "Avi Halachmi via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > This addresses review comment on part 6/8 (git-prompt: add fallback for
> > shells without $'...') which requested to use one form for all shells
> > instead $'...' where supported and a fallback otherwise.
> 
> I've read the series and they looked all sensible.  Will queue but
> I'd appreciate a second set of eyes before marking it for 'next'.

I did have a look, but honestly I wouldn't consider that to be a
qualified review. POSIX shell tends to get borderline unreadable, so I
don't want to claim to understand everything I've read.

In any case, I didn't spot anything grave.

Patrick
