Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2554BD4
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808373; cv=none; b=CqkJ1MmKp1HaucSsK/ViB1pIbhOEoZoM8vYjmaI2TfciD8YYjzWs1FCeALibJCigpHGYq250fWCDD8jC+2OpBxt9AKtredvF/OTB7uirerK5zDTxxevj/0pq54Qs0TeK7vvmLk8/QCZQVsi/FV7JvHso1fFRG3u0PRZLLJbNIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808373; c=relaxed/simple;
	bh=DgfJzw3ZUbhBNnt+jIm0ZZX4J4DLSxegTEfxNlYXg78=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWLWBEyz/nI4daHB//5z4FkRHV/HOykPQjVGSWheqBMjNhGudkHjItGKjeZB9LadxMvQlO03ifGcD56/TRfFZXxNJOiCuMJXzGJw7UMQBGAarbjpu+A7VI6z5TWnsr6SytjVX+3yZAP9ojNxLnnmEX82mE55JDyEjyzKZzqchb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RK5t42uE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OyDMCZ67; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RK5t42uE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OyDMCZ67"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E19BF1151BEE;
	Fri, 16 Aug 2024 07:39:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Aug 2024 07:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723808370;
	 x=1723894770; bh=bOPjemaRWS3/zyIGjYkrzBtQeFFGQv1tVzTGcY+vn2g=; b=
	RK5t42uEqKwCXaaBvwyiF85PyMKutaLF7QQyzcXXzffdtmU7OCXJukSNloyVGt1j
	3WZie2CCtq7SjLffCUmWA8v620nBfInK6PlSJifIRVavBU9D8u05rpPPzhv7qj2K
	qbkO9oQVYOFGP79RkTb422xXSClMv1jZb/45BepKypD9PSFcl9SOkDcOuFh6oCBG
	DBvVmoqZbLDcbNUwrJHQv33Fe7CoYue+8pr1KKXFwEFwQzL+bTp178jn2GEbGr3T
	cIy3puZsuJUJdJAh4OVDW6T/GsXfQQG0rJwpRSxvPlk5gdhBI2YWSjd/kS72h3by
	E/UpZA85ru7FpwhjmiXrKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723808370; x=
	1723894770; bh=bOPjemaRWS3/zyIGjYkrzBtQeFFGQv1tVzTGcY+vn2g=; b=O
	yDMCZ67Fu6ILzUUpXRfuqzeINTmCahujUOvzfgVpMj0EiMef3QZdzXvnlnk5XuiI
	yMcEfyxOUp/nUiRG9rB1MOtWJ4tZBDgVuE37MH4MPErtSMEoXQEgt0nVep0mYFa8
	vKVBv9AV1W4bnKMg+mzEEKPe8zS+YyVfzm5pIGc8bgv4KZj4F4pAolY1w1lo2CGa
	xJ5W6+wiCo6W5WFSr3/aFNFMMQ44CKVkgaCQgkOBteaAsi0oSOnh0fkCqOrUwT2f
	M4ljxRcLkbtTRK+WTO2/e2+rcvVbLH7A/14Bnq1ai1xTcnTtvtwl601Tx5qnPy0v
	NryRlLcnOTBNXEoZ3Fw6Q==
X-ME-Sender: <xms:cjq_ZqnOPiVM4TEkq6VlgPDmaNtj0O-f8suwNJz5Sr2F_kNWWpDG0g>
    <xme:cjq_Zh3wK6O3UyAIysqTxBDyb9diy4NWBly9tQdhXc-zXRfLUPePLe2obqg9EBSWb
    njlD_VDl7DPbbdPmA>
X-ME-Received: <xmr:cjq_Zoqii2sOEtM4H8uEmgge-IFgJyA_zJ3MT5vs4TWQgo6QZxedYdSwI5EhUoQDSRlz70kRTIhdpIWez4EOxONmfJNlfy-Mx6S4fh5Pe85dyTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepleehfffggeeiueefheeitefhgeevjedvvdejtdeuudev
    vddvtdektdfggeejffeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegushhimhhitgesmhgrnhhjrghrohdrohhrghdprh
    gtphhtthhopehjrghsohhnseiigidvtgegrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgtphhtthhopehsphgvtghtrhgrlh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhn
    vggtohdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtg
    homh
X-ME-Proxy: <xmx:cjq_ZumclwYDEOIFyESAO_OgHydvrplill12sVjwUA_8kSp2FlCW2w>
    <xmx:cjq_Zo3plvZhjqCkWT1QikUW_JyR2hI23__tDPV9Z1384TMqn-v4gQ>
    <xmx:cjq_Zlu7-Kja0xD6CphE3hNyGM64ujxuZPuIUnUfrG_HGC3BBpzKNg>
    <xmx:cjq_ZkUZvX58xjyFW30XSgnX70-TCDRzpR6UDNAM5KeC9gD0TQN1lQ>
    <xmx:cjq_Zj2y0imee93M-0s3mJPRa2qRlog4nAkbfvskNQxQCOY4If9KgFqD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 07:39:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e2e24866 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 11:39:03 +0000 (UTC)
Date: Fri, 16 Aug 2024 13:39:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com, mh@glandium.org,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
Message-ID: <Zr86bF3y_YMZx0CQ@tanuki>
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <Zrdn6QcnfmZhyEqJ@zx2c4.com>
 <6398d60387a6607398e4b8731363572e@manjaro.org>
 <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
 <xmqq5xs688cz.fsf@gitster.g>
 <CAPig+cSVNqBPjV3_41f6Ag2X4+-q4HidEo0D=1UaMG-Kv7pa5Q@mail.gmail.com>
 <k4cokm5xtwazlv44ys2uzmrfufubbq7tcmcwzasuccog3zcojf@4ftvda4nfqxj>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <k4cokm5xtwazlv44ys2uzmrfufubbq7tcmcwzasuccog3zcojf@4ftvda4nfqxj>

On Mon, Aug 12, 2024 at 02:32:12PM -0700, Josh Steadmon wrote:
> On 2024.08.12 05:03, Eric Sunshine wrote:
> > On Mon, Aug 12, 2024 at 4:15 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > The original iteration had this:
> > >
> > >     * bikeshedding on the name (yes, really). There is an active, unrelated
> > >       CGit project [4] that we only recently became aware of. We originally
> > >       took the name "cgit" because at $DAYJOB we sometimes refer to git.git
> > >       as "cgit" to distinguish it from jgit [5].
> > 
> > A tangent: Speaking of external/other projects, I don't think we've
> > seen an explanation yet as to why this Rust wrapper is proposed as a
> > `contrib/` item of Git itself, as opposed to being a separate project.
> > 
> > I can only think of two possible reasons why they might want it in the
> > Git project itself...
> > 
> > (1) Easier access to the library portions of Git ("libgit") since that
> > portion of the code is not otherwise published as a standalone
> > library. However, a workable alternative would be for the Rust wrapper
> > to carry its own "vendored"[1] copy of Git. This would also ensure
> > more reliable builds since they wouldn't have to worry about the
> > "libgit" API changing from under them, and can adjust for "libgit" API
> > changes when they manually pull in a new vendored copy. Hence, I'm not
> > convinced that this is a valid reason to carry the Rust wrapper in
> > Git.
> > 
> > (2) Perhaps the intention is that this Rust wrapper work will allow
> > Rust to be used within Git itself[3]? If that's the case, then
> > `contrib/` seems the wrong resting place for this code.
> 
> Neither, actually. We hope that by keeping the crate definition in the
> main Git repo and by allowing developers to optionally run them by
> default as part of CI and `make test`, we can catch breaking bugs as
> early as possible. We're also hoping that we'll get more attention from
> interested developers by staying in the main repo rather than in a
> separate project.

That to me raises an important question: who is the one fixing breakage?
Hypothetically speaking, if I continue with my refactoring spree to drop
`the_repository`, do I also have to fix the Rust bindings that I break
as a consequence?

Patrick
