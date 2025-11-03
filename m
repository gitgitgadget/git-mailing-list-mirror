Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DDC2C11EF
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155635; cv=none; b=i9qydKJvArIix9QzMsR4JyubccfshPPlP3aqqosbVOotb89FhfMmK2Rubi2qhhi27NxQ7IAR7gJ9zEMv70FvcCBI7C0fqQMnm16tZLffs+CGR11Hlm+vsS9uttGRwGVLUtNl9DqOfWbOKBRtmq4nakT89ekNy8O1/nhqFo4uCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155635; c=relaxed/simple;
	bh=TkPo0aOy7FV4hAt25zjgXGKxVo1riuEq8XmLZNemv6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ0NygZ8KXTQnDq8w/PKEuln+3O9/NP3sKPNKplFBL7Cf9FVCiJb0+O9hVzA74h5hhrP3SVLFYYpsKw3qsm9VRfpMqPDp1ITULIKuNaNfBK5V/znxtO7jwI69YCgQby2SG9IQie98+bbNGRmGj2VHtCqrSWAVOoWvsrliVYw7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A0yvNdbg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFEmj1jB; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A0yvNdbg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFEmj1jB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C5017A00EC;
	Mon,  3 Nov 2025 02:40:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 02:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762155632; x=1762242032; bh=+7g1Mp5w+F
	1VTInjybA3HQgj9NB+NqGMPT9jbaNkKx8=; b=A0yvNdbgwMz4NpgnAG1zYmlOG6
	WiD8aC5EsKJJwdLJQmOZRuvspufsXwJDCwbRiLlFfT89A8ZovvOiA+BxCT1Jr6oP
	3OW5kO1bQB6L2lgNEUPsHTdrckWVTc46BEjWdsaFgGpNaVZ/0wn4cW46b/iW4pg7
	o4WW6pCQvbq2qJRjCqgpg5ufmvKZCvUK4R3Hnba9SZ9V6hK5Dixjd6hQ/no6PZxB
	uPtrzulmPTWrU6speWyum0uzom078QXaZbtQ1HdBPEI6tqvBhyudMD0UJL33EPTR
	YRWta1EV76Fck6eI2sheJCouyGb+cOzy3eGq1CwaWNBp+67/PGzJic0s7eMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762155632; x=1762242032; bh=+7g1Mp5w+F1VTInjybA3HQgj9NB+NqGMPT9
	jbaNkKx8=; b=VFEmj1jBrcGWhwYnATxKKGdxyv0T3xPORDhf6jPXx0ND1eHuc1r
	XxDrtC1/R0yZc78mzyMiwMGXk4HAm0M1PV2LK/9+/wiusfeieAwLqDyfDGn70Wej
	7lx3gkB4FXvW83exfB46UJb3h8joMoP+4rZx2lqwVS8aaGRb5fAeDwbw7jVfZdF0
	ZqXflMOiZfCgh6bh+0/+FdAk5S9PcbsAgVfTrvBEwl30ulnHVIPpFk6Hm4Pq8KYe
	o1P/uXat1uUGUDPnOw6cjtuuwL7zjVwnxjGIghUlEPrcJYGZWlRnTI9Kt9aLZMu4
	wFsMzibyJ0rupfYeGrm8XTlC2BPnVJsG6sg==
X-ME-Sender: <xms:cFwIaR_qGzViMDEZKmrDJmHRQLwO0V9RuuN3VsQ8RnkP3xXfLyDavw>
    <xme:cFwIaZbKP185ZHT9scQHfgKcj95J4ZcvdFbWK989euAjqucVAsGTiuGSgov-02AzF
    loCpU-9JJ1-BRasy7rzLqCPwtiU_i6Cc8y34kakeS0ACQzyOugi7A>
X-ME-Received: <xmr:cFwIaY1gN_1MXunumgdkLbzO2Ua9o2QHJvd_VSEsAIaNz6av0LaMT-GY307hC8rgwhJvCb7I1VZgU4SNM62cbUu4WeFqkdY3CYBuCPAQiNEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrg
X-ME-Proxy: <xmx:cFwIacY5PL1fZKVauJtQ6EFirJx_kkBXTdE2S-p51XFahU_dZEy-FA>
    <xmx:cFwIaYJMiguaG703A4Sd5yRSjFbxl0vR6ABrhfvNq9Km6LxpGyovXQ>
    <xmx:cFwIaTF-p_2-o_oh-UqFZY8i0OWmfgKqyIKt592WhPwJN9Axz_DoGQ>
    <xmx:cFwIaXs35VyW1cIV0kNAIvqsuYFTEpmkqNxiGQAewvNhPQ_o6lBEqQ>
    <xmx:cFwIaSjnvdVG92IMH8tdYIfUtIyhazbi-ZN11eUKEqqYvRspqq-zGO1q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:40:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 646053b8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:40:31 +0000 (UTC)
Date: Mon, 3 Nov 2025 08:40:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
Message-ID: <aQhcbHJjiI5GtV6Y@pks.im>
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
 <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
 <xmqqtszf2kro.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtszf2kro.fsf@gitster.g>

On Fri, Oct 31, 2025 at 07:44:43AM -0700, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
[snip]
> > +[[commit]]
> > +commit::
> > +    A commit contains these required fields
> > +    (though there are other optional fields):
> > ++
> > +1. The full directory structure of all the files in that version of the
> > +   repository and each file's contents, stored as the *<<tree,tree>>* ID
> > +   of the commit's base directory.
> 
> "base directory" is a new term; I think we most often use
> "top-level" directory (in various spellings).
> 
> $ git grep -e 'base directory' -e 'level directory' Documentation/

We'd refer to the top-level directory when talking about the worktree.
But what's referenced here is not referring to the worktree, but to the
commit's tree. And here I think we rather consistently use "root tree",
don't we? Our docs already mention "root tree" in several contexts.

Patrick
