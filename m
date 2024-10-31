Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD11386C9
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395574; cv=none; b=kAGH573eHWaPjw/3VoGh42LFeykUDKhhYjm00doEo2YHnAWLuZIetHKHjdBERr+86uLNsKGyDs2fDVZEXEy+5ZGrfC0R+kkYtrymqsPz5csBG6C+pF/gbmUblJAh6oIicPVufcUQ2WQCP1sU+TF774CXx5zXfuJiTmL692eHwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395574; c=relaxed/simple;
	bh=BiWTipnlTA6qGqN2MfAwt+E+N1id1gfPeQ1m6C0dVy8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hme2oUTAwRNvYMTLjcMVHkG9wBpCOW0ugBEFBBSpRgvs4aVhoq5496pVoTX8QmhoocukATCnjE6fX5ZdruGBZUUK3w9tSLpj0ekegcWitBpMuEyQNnJVQlCcCz5MisSe1+VWLSoQyOGAiv0yw+IMunPDqYksAsh6WoZlYN/YYlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BQP/Q9+i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lbEIVDRh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BQP/Q9+i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lbEIVDRh"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F0FC82540172;
	Thu, 31 Oct 2024 13:26:09 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 31 Oct 2024 13:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730395569;
	 x=1730481969; bh=JJm3QKAPz5upM3L4Olr3s8WL/C59CESje8WSXHbN6w4=; b=
	BQP/Q9+iFkF27ALDA57tI7ErwXKEjgPdsbrbdA70SPLT+h4MJUd9qnUPP3+GqMF+
	eHOsBEJFZiwF8nEuYHuYbqxDKNdZM05j+sMKqM7x2p37M6e6mvsvuK5Px3JJ7EFq
	BuK/HWUFfxJj/NlsmNEKj96mBwzCUsXTc9HanEOGSLhijnEy5nTOyKL9aDpATeux
	k1xWidDNLNOimHVcqmfqRD+NwuSsCTO/jCt7Prf81rag+ZTvzdHlGGDYIIjxOK/S
	Lwdrb8KuXGqVlZJKVJZBOAiBBZyB3hYmplsQcl25gO6Mzlw0mZ93S4dhF7ttA8Gc
	hD6qxLyHLckwuLJ1f/mNEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730395569; x=
	1730481969; bh=JJm3QKAPz5upM3L4Olr3s8WL/C59CESje8WSXHbN6w4=; b=l
	bEIVDRh9lHRRxhllkK9wDwI0pMZzGBZ3yzUp5Ofr5gPjTzC9zudtvNfq7PxZK6TL
	XAebqOu/UoyR9h2vTpRIVgYLbAp7Wn6pYDWfpEMnFojgG851ITYjLnHkn0MkrA7l
	V+myFl/bQnAP7gkO+THPkNBN2H8Fu/eRHNRBU+m+U1xDOWz+FFhb7A5rMsEF6mIZ
	gECljtDyY2hrHABS55V4SYLVE1ejvEef5738sSSoJuoieJt+2PNjlxmC1PDi+64x
	RIW4GBRP5+s9yTNFgYAShAWDbPgCRPx+r9j9p3YjUMk0wd8rRDIMGep52C6ZOuUm
	kqKNf47lJLnpiaAxjVBAw==
X-ME-Sender: <xms:sb0jZ15Z-oFdE-P6h2srhCui92JYpNTnYMktYcinnhKA7CDkcuVTjgk>
    <xme:sb0jZy6dgHKTJYGng0AujJj8x5078TI3XVdr5ligXeZFMOVjA0Pk_hvi1YrSUmxoh
    0mRWNDin0jokE5ojA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekjedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sb0jZ8eYwg_d7p_bwC_YfrqTAWFihNN9BPaaxhINXl7c8MRiVO96LA>
    <xmx:sb0jZ-JCdTl5ccd2tnN7fefe4TyN8N8CYlBVYnTzP7lJCfXmhkdrYA>
    <xmx:sb0jZ5JKoLE7VgIF4QYGtkoXL22nh3yMXG9Njnz_QVJ9_0nFIGbSqw>
    <xmx:sb0jZ3yIvX93g3GqzWftdn9oYjiZisgy1IxzTuhcXI_MX9YP4t_3Fg>
    <xmx:sb0jZ50ByNL6b3YNMt464HAUR2pajMyXVMzbuThIfqlNnmdwnDPfyFr9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 24DFF780068; Thu, 31 Oct 2024 13:26:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 31 Oct 2024 18:25:48 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Taylor Blau" <me@ttaylorr.com>
Cc: git@vger.kernel.org, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <be0a2b2e-ed22-4536-aa98-caafda13c145@app.fastmail.com>
In-Reply-To: <14993bd1-034b-40ac-a991-cc3eabc956be@gmail.com>
References: 
 <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <ZxlEJ+44M8z03VOj@nand.local>
 <20cca28c-cc0f-4bfa-bc1c-6a3dd6bc25a8@app.fastmail.com>
 <14993bd1-034b-40ac-a991-cc3eabc956be@gmail.com>
Subject: Re: [PATCH] sequencer: comment checked-out branch properly
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024, at 17:30, Phillip Wood wrote:
> The diff below shows a fix and a new test that fails without the
> sequencer changes. The fix is based on master, so it might need
> updating to go on top of Junio's series. The test could probably
> be improved to use the existing setup.

Thank you!  That those lines apparently worked had kind of been
bothering me.  It=E2=80=99s nice to get some clarity on the issue.

But shouldn=E2=80=99t there be a signoff somewhere if I am to incorporat=
e that
diff into the series?  Or is the signoff implied?

--=20
Kristoffer Haugsbakk

