Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF38293B75
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749493; cv=none; b=Whh8qrMyloyyh4mhs/9bWS1u9flOZk9MNhQUOgkFr2CTL4N3plUhoZ00odI/Tro840kirqC36tkwkYsgthEaTuuW/X4OCuGpDbx/Fkp8DyEkFoHKB9Zjfv6ZRXlXChXM/yQh1qglyoLw4Sn97BoLSEwbgJ/3QV/x4wfuvhLH6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749493; c=relaxed/simple;
	bh=4EEAxle4c3f8iGH+mrY/X3l67THBvHN3/Y2W29EavYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y+HFwQM/aPUM1m+leguuCGrgSh9nOTyryh30J0vVDthoPRRrNH44ViipnqqYmfurVPdskmQTuxUJFC763cw5+3yhB5lDYJg71M8EBxhLPPsqzlAIpqTHVAlAliVi2SC815f/10K4s58spt9/eEVZJjtQ892rgiADC+HqDbHdnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=daUO6i0E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DYgh3yCg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="daUO6i0E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DYgh3yCg"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B656E1400066;
	Wed, 24 Sep 2025 17:31:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 24 Sep 2025 17:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758749490; x=1758835890; bh=2Dtx0C3OQx
	fWrzVOPr93HhiUFwi2QlRIB+d4K4WfDok=; b=daUO6i0EgIyWETr7nawaSlJnOB
	jpxUBD3trzluvyBNGXKHEtNn7C5aVSkhXme7yLzIX6NbuaiKMj573i+2u8hnijob
	+5lZfnLP6OvoG4TmobEC/zxERARl05a9Tl/axRfZTSKd/lDVeFDZcthJrMpfy9Ck
	Ir6f5rV/edd4RaUVhKao+HzOmQ2Rcv0ppX25YkuMmEPFpSSbs0EE70A8Lz8ws9dU
	sODS8H8P4gajSqYZ1JDhotvepCFLnlEcHqIzKGENl7LKBAS+zW3BsnhJxMhDd2Nh
	gxgX1pykCQrB1iBIY/pqWV3wuUjYnxbBGJ2AWwIqVYHxKFhwbKO3rVMDLTBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758749490; x=1758835890; bh=2Dtx0C3OQxfWrzVOPr93HhiUFwi2QlRIB+d
	4K4WfDok=; b=DYgh3yCg6yO1gINVM4TZ+a1pIhA3vr/6pbaoCB8WM7CBjTftgTn
	X/oAndXHPEF2pyN+qUxxNSitsfmup7PsMXMww4nr1FN7+fbXHMTy1AY1g505S1Xx
	yVlVSnx1GSkXFHI4Drch1ROZng950h/CuSRficuJlUJrMQMonlKejpv7AOM/N+Pt
	JQGCdVuXmuaCR6aN2L6fqqFGg0cgkKUewLD9eH75riTmyQeall7xv7OFOtWKPS82
	ImRmUZkATG9KAFYeoEgaalne6mclfhV7qIlGho1Qo8R5GhdK2ckDCPMQwBhxrpI8
	M55ahROD3EFPY2Kunv0yzhafWmRb3mX6kBA==
X-ME-Sender: <xms:MmPUaIKrDvIiLD3wnS0jkaHY8I8jCtX9oZfrJVCuRxjVv38kJTsl5Q>
    <xme:MmPUaHPNlqSi8G3fkVInw97tujlKhr4nvYnSHrd6SVCIltPh2m36JC52X2c44kkCg
    orLbXvVW_y7Nc1yhZCa9TKpPyhS_fdl2UjO9PfniNpHNk-tq1tG-Q>
X-ME-Received: <xmr:MmPUaO6JW0TGI54RND8uDWFDMcluGN6QKWo3vs35zjNTec24OB-xhpypbr6XcabXLMSLS8eVAxaKYRr9qj1cj_GvURH1DngjmYLS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MmPUaB6sNlmPMrg9wq8E6VJclbMCNiwj85vpgtXRj0Ek6zWBsJsjfw>
    <xmx:MmPUaEHL0PIt53QKSBJ-DyLnCNM_VRyVvtr39XGB__YyyFLz-bbiWg>
    <xmx:MmPUaJXuJpiKUHqQFCsBSn8jusJBju4kccB8uBZKqIPJ3H318lTcjg>
    <xmx:MmPUaAXEDG2d3vtLVAgC0hcWl1VdzjJWmJjW0P-JOunZySbBnysf4g>
    <xmx:MmPUaIbSXlUR3xTX3AqIDkHrz-HeeHCcHy_v5r61vEBoyGoG4ieuHFGX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 17:31:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v5 10/13] xdiff: delete rchg aliasing
In-Reply-To: <CAH=ZcbAcvoXJYPHE=mcZSqPLuUPxKcSs-vd307X7uXi+aG3evw@mail.gmail.com>
	(Ezekiel Newren's message of "Wed, 24 Sep 2025 09:58:11 -0600")
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<7b0856108a29f42e5a4d3faf7489d5522b683f71.1758662670.git.gitgitgadget@gmail.com>
	<0bb4f30b-6737-43a2-9aeb-3903c0dc5ce6@gmail.com>
	<CAH=ZcbCf7bUTL=BwCD8B6-AVHZg+K3JafvksLQWUx2D-XR58wA@mail.gmail.com>
	<xmqqqzvvn9tq.fsf@gitster.g>
	<CAH=ZcbAcvoXJYPHE=mcZSqPLuUPxKcSs-vd307X7uXi+aG3evw@mail.gmail.com>
Date: Wed, 24 Sep 2025 14:31:28 -0700
Message-ID: <xmqqikh7k05r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> I have a question for everyone: Does preparing C code to be translated
> into Rust count as a valid reason for changing it? Provided that there
> is no violation of the Git style (or very small in some cases).
>
> If my intent was to keep this as C code forever I'd agree, but...

You'd agree that "I am preparing this for eventual rewrite" would be
a valid reason?  Or you are agreeing with something else?

> My
> other reason is that it more closely follows Rust paradigms. Creating
> multiple pointers to the same memory in Rust subverts the borrow
> checker's ability to keep track of who owns the memory.

Sure.  But looking at the use of rchg[12] in xdl_build_script(), if
they were "const char *", combined with the fact that they are local
and their addresses are never taken (to be leaked to our callers),
you wouldn't have much trouble with the current code, or would you
still have issues?
