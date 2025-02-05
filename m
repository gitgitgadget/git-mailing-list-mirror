Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A22227BB7
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738500; cv=none; b=E+540ODX8p16h2gWh8XFxErUamQkNexy5in6fQytRYmHSrhXL8iBpSz34w3Dt9TYriplcIJuyQ/buUaHr51T4Fii/5U+PnVmm0Tpw5qRiGywtKpQXtbbJd7loIRDRomz/Yc2twUZ5jW8yTpYCCwEZNub+MiYJ2P5FZYKuVb4Jr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738500; c=relaxed/simple;
	bh=BiyCFOvFuHQIrxttcqmaHU8fO1vLYg3ufoIne4eapjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/ZFq781OMCmQdTSyKXb8+oakYu4Cq54rXGWieLjL+f1cdPOVqT5y0UyDy82XZeSaltLog+zPA2/dUOUXW7CBLYuKpsi5asduMGt1BT+y85RrYBfUyrUtMXcGtiWU+oHBj+uQQylcbHMV4Mv8cMH7/iPvJ/Anvizsq4tlLk2ABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nutpyUgq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0EqBkY+u; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nutpyUgq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0EqBkY+u"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5705C13801CF;
	Wed,  5 Feb 2025 01:54:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 05 Feb 2025 01:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738738497; x=1738824897; bh=aJ577kDIPm
	n/Axdrt72cMfRELVOrb/1n5WoCPg1HSlA=; b=nutpyUgqs/UbOFAjOPt5Kbmtdh
	7F3VdnB68yxRoY4vGSedNc9heKSAwrsLM5QH74InOw28K2O/GHXHqk6jGWV39oik
	5MogmL/kslJg1HZmKdYcTrCkuErhaTbIRsocKxV2ZYj738y9TVEtHdezz1bQRwB/
	b0QU5n2mxQNkyOkLvQcrJCMlw3P7XRKVKn3BMxp/Tx2+6aeBs5k4EhCY0huTKUnX
	wiIlD2wJOux1fgyLctw5++VUBe9rOfWRUcWEu+vkB+1tquM0KENP0WfBNb16YSHh
	GV2M27r1VJjum0JTSW4QZOkP9Qb1Cnpvnx4CpSDt1+RMN9woivUEFvbH1ZtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738738497; x=1738824897; bh=aJ577kDIPmn/Axdrt72cMfRELVOrb/1n5Wo
	CPg1HSlA=; b=0EqBkY+ureJeTewdD7vgMtpyZc57Kg/TJZbL56a4p9tATiZLgG3
	nDnMGwCOoEO7s94y9FcF0lBQHTf3hVy607yRYhKqFRj1niuc1ms3BNeLqeZpH95F
	u4CGMT0vHWfduXlQUB76pe25uQglx75Y5qTrn+1NEoAw3d1uB5qy5ie+nYZ1CUpk
	N+I3teUTLRCa6j8YYI1XNKKyKrVy1cJMt0x6qyfHXPAF0TUpPQSIjHsZOONsAnZj
	Q//dJiVQ6PAL6RKcG6CFl+tcSXsedoKdgtkJ97tAv6oV1lVP0e0kQhRLWqwGj9HH
	XOc7tw/Bz7QdM48tnay14XTOGWbRMJxh0Ng==
X-ME-Sender: <xms:QQujZ7kXsaqkbnIl1yBQWkxg8rIX8yR_dKLJ64vrSl0IBtNo9kkDRg>
    <xme:QQujZ-1rOV2xkFchMINNUZ_Zupt2Nr2T_fAqhZ3VUt4d2bkMV44_0eohrIibtlLx2
    6I4LVmJoADSxYhSdw>
X-ME-Received: <xmr:QQujZxo6RkTmJfBNTcDkSWDRohI01ObvCnlwyT2fvrhFqoL7-jKMiRFl0_9XtRhmYVSAPh8fN3PA9f4CsOWdFxrEkESCum1fFcMJMyxLwB7RHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrnhhu
    vghlrdhpohhrrdgrtggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:QQujZzmF9Yp4TtfYjxZDC2CETbc9dEGM9Jj6324gT_ylvVrtfDY0dw>
    <xmx:QQujZ52zCjt-3pR5WAssKdjT4zYLNpEKih8vx3Dd1XSz6IiuxZVhxA>
    <xmx:QQujZyskkPzbTc4ifQebE5pge6q_HWpc5SL-4sC5LRRxufngSuaWVg>
    <xmx:QQujZ9WZHx40T4CQc9pHmedUFblvNF2m5drzGpJW-r4UFz3rP4N6yA>
    <xmx:QQujZyzE6ukHao5iCM3RM6aTSU0f5wlr-HgTHx0NA-UoyuxOfbI34emr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 01:54:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7382a062 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 06:54:53 +0000 (UTC)
Date: Wed, 5 Feb 2025 07:54:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Manuel =?utf-8?B?UXVpw7FvbmVz?= <manuel.por.aca@gmail.com>,
	git@vger.kernel.org
Subject: Re: Usability issue: "Your branch is up to date"
Message-ID: <Z6MLOA3mJGbPFBae@pks.im>
References: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
 <xmqqh65b2ci3.fsf@gitster.g>
 <xmqq34guzi0f.fsf@gitster.g>
 <CAPpV+Oaq3d3oNE-V3pnpQRNrGCoZr52uY91QtWYxcu1tgG_QXg@mail.gmail.com>
 <xmqqseottxld.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseottxld.fsf@gitster.g>

On Tue, Feb 04, 2025 at 09:43:10AM -0800, Junio C Hamano wrote:
> And the last step is where the remote-tracking branches are updated,
> together with their reflog (if enabled).  Because that step does not
> even see the remote-tracking branches whose value do not need to
> change (filtered out earlier to help reduce the number of refs fed
> to the object transfer machinery), the "drop no-op early" part need
> to be designed differently (e.g. mark them as no-op, so that the 
> object tranfer machinery can notice them and ignore) and then the
> "update refs" step can see these no-op updates.
> 
> I do not think writing the "no-op" reflog entries should be done at
> a step separate from the step that writes the real ref updates, as I
> suspect that such a separate update scheme would have a funny
> interactions with "git fetch --atomic".
> 
> So, do I think it could be possible?  Sure.  Do I think it would be
> too hard as a rocket surgery?  No.  Will I jump up and down excited
> and start coding?  I am not interested all that much, but I can help
> reviewing patches if somebody else works on it.
> 
> There may be some other downsides (other than the cost of storage
> and making the reflog noisy) I haven't thought about, which need to
> be considered if somebody decides to work on this.

One thing to consider is that some remotes tend to have many thousands
or even hundreds of thousands of references. Updating timestamps for all
of them could be quite inefficient depending on where exactly that data
is store. If it was in the form of no-op reflog entries, the "files"
backend would have to touch as many files as the remote has references.
Consequently, even if only a single remote ref changed, we'd potentially
have to update metadata on hundreds of thousands of files.

So I'm not sure whether such a schema would scale well enough in the
general case for large repos.

Patrick
