Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495C2EACF3
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901997; cv=none; b=hX7mVqT5UHHBK4bxqeRz587hfVHCsieuz9kxXqftfmDdlbErRWLLuyCCdjfWLESd/gVqhLyOk+VR8BX2DDe+2mQrbC1I0lzPDX1x/13asil22dGz/w6ki9z/eGRe0C5Ea/NCwdiap4kxJONYSNIVBRM5dyqGPqQwu2ACvaZVnl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901997; c=relaxed/simple;
	bh=BxcJEO4MwOHpncwrfTTIQ4BipeVdgL1hWwsLMShpu6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgjOTrBPgqLLq5GLAYoNtjZ7jmisSTVgDtwg5H27SvDFvXjf9iIsxghoFKCtRydNges5jflOTKmehpcj1sXqpW7BKw376G9vUbYmHLr8BfKiNm24LWmrupkgkT+HldpGQmEbOyCzOEJxmp3StlylSxvRg/fCfSP0GqdvMqHk8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eBoC0dDQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=er5sqfb3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eBoC0dDQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="er5sqfb3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7AAFEEC0329;
	Wed,  3 Sep 2025 08:19:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 03 Sep 2025 08:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756901994; x=1756988394; bh=hZ5rg6Dkl/
	mEJ2rEZiy6VhdO12jRZkAWOy62u4Z1j1k=; b=eBoC0dDQfrI40hDSzDXR4xc+3+
	jBq61isu0x7eN7gOZQRt6uLeYU1hy4SSkm/7ca9ellySpUHbEkr/L4yq+ffTKXu4
	QAtjtGiGxkL4rYdUrlmrLc6H1qBl5lwbhIGwkx+dKj7mHfPNRlzRiJieGJS03DiB
	TqNybJYiCHW9lHUpeKPQ7SaFIVT7RelwyonZ7Mk/rie/4Bsmfh4XXt5lbF3pclIJ
	RX7vh/b5sRNmSmwUZ51tCL5FhA/TtCBqGBZpghSWVcbjnmE9VwWq6WZBLzkvlu04
	cVpTtbxfFXrIa/ItC6PcBkEwOPvK6qHT2+zFPPtZlL/AVsqH3B6WLVdNjeHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756901994; x=1756988394; bh=hZ5rg6Dkl/mEJ2rEZiy6VhdO12jRZkAWOy6
	2u4Z1j1k=; b=er5sqfb3ueOdgAYzyZlDaeF5i9Sra2vryy8zWzA3R/yFT9j2ZLB
	pfjGqMx8Qai9Ljq3Z+iPgdFyGIoBr21/+Zy3ahUP7V4eRcKFBPF7m7zfarK9tCTc
	A4LAFZVg4AD6EGGLvrjtswSEsFftgTh26U2Klu+YL/r21k/NeqESrmUce2cfVlRs
	9ZU8wYKaXRth9N5lTFXa8Li6L0qZU0dBTddUKWzrV8k130ZMkPkwDtZ0yjxyCV2l
	Yqw/imbrMV6hSewxMIBlyXDP10Bo79z93fUKBvUYDjAu+hyUwIwT7FnGt7+xnPFr
	JSb7wEOH0Zrdqr04jTfdZJS8/XOOXMolt8A==
X-ME-Sender: <xms:ajK4aEwVXi2XrTfmpLHAAzYF7SEh0zYm0c1qzk6g20vzhx3xnfROaA>
    <xme:ajK4aF01hU0O_lcw-LXZVjTRuTbYEvCWEVpZbkNiUar3Q3gmcnKcxQmMhPUJ3R6ws
    bBTfzZmgCYbm7CiHQ>
X-ME-Received: <xmr:ajK4aMy0FBZeOHAm1rg2H3nflN-iN1XaVVbXusnHRIRRTIblXQTSZVlQVJKxpWiNqxUUpi3YI8JjHF7NnZ9NvGp2ZI_B9eV-bSICRv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    jhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgrrhhtih
    hnvhhonhiisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ajK4aEEXBd0Deb_A8-0AMe4iyO7niLjoG7b3jnrcDBASeBdmUW-yIg>
    <xmx:ajK4aHasSM4L61WgKW-YpIHN3aS81m7qAMxZMA669_Heh2sYp7gLIw>
    <xmx:ajK4aODNheTiwxmBsakkF23CFAudrc0oIZif4G9YH7FiMXDv-A4jMQ>
    <xmx:ajK4aHnj2BwdIeONjvdiEu-UORjhVkLGbsmVix83568yYrMApR-Lsg>
    <xmx:ajK4aJqliacMdZj2ICAe7tMLmLAT8ZEISJ0eCnfhDHtVBPMOPH1vIiMm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 08:19:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 051b738d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 12:19:52 +0000 (UTC)
Date: Wed, 3 Sep 2025 14:19:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v2 05/16] cache-tree: allow writing in-memory index
 as tree
Message-ID: <aLgyZdXV7TUIx_y9@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-5-964ac12f65bd@pks.im>
 <xmqqjz2rs6fk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjz2rs6fk.fsf@gitster.g>

On Mon, Aug 25, 2025 at 09:38:07AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The function `write_in_core_index_as_tree()` takes a repository and
> > writes its index into a tree object. What this function cannot do though
> > is to take an _arbitrary_ in-memory index.
> >
> > Introduce a new `struct index_state` parameter so that the caller can
> > pass a different index than the one belonging to the repository. This
> > will be used in a subsequent commit.
> 
> Nice.  
> 
> I wonder if this would also allow us to simplify the code paths for
> "git commit -o <pathspec>", where we use a separate temporary index
> that gets populated afresh from HEAD, grab the new snapshot for the
> paths that match the pathspec, and write it out as a tree to be
> wrapped in the new commit (and then the real index is also updated
> at these same paths).
> 
> I guess the code paths need to expose what is in the temporary index
> to hooks, which means the index file needs to be written out to an
> actual on-disk file, so the picture would be a bit different?

Well, the sequencer itself is also writing out the temporary index to
disk. Took me quite a while to figure out why the index I wrote always
turned out to only contain a subset of the changes I wanted. So I don't
really see a reason why we couldn't use the infra for other commands,
but cannot say whether or not it would end up improving the status quo.

Patrick
