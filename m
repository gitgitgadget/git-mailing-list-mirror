Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEC16EB76
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316398; cv=none; b=tdR4Oom3cHyL0WaU3ZAyFzvHkzUhauIARSDDnhjlKXMMU1Y4NYkD91eVW7uLD5x4pENlid+4OChhYarinyzMQhTnOaB2zYKjL/Z0W9U51J+vEyfgGb+ycnylAn292c2vpj1JFDWBTbu/ifHc75aJ24irNSOpwfeYriGq8sBSUDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316398; c=relaxed/simple;
	bh=QzO5IxmqtMFdedb9m4iIe5DcP5E50iyRxEqagWvpTtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1MMI40ozy5VaDbGswCVmR/+1h3rwURPISIEvzCSL/rEs0c1+LUrHPSRQt9cKwmmS1CsD26GZKkGayndq1viEDDEzKwnQQkBxR51sYyQOt3M84pDNh7Xbo6T21Rz6vKqO3wZuX9c9YBzj8XIsyRQMeY4fuIjTbL7fRNt6C6lfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wjj17MKD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tX+x+/Gu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wjj17MKD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tX+x+/Gu"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B258F1151BEF;
	Thu, 22 Aug 2024 04:46:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Aug 2024 04:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724316395; x=1724402795; bh=Np+CDqq9vq
	aFdFTAZ4s8Cz5eWS+Rqk7+cnxaSQ/I7Kw=; b=Wjj17MKD18Ni0rWiEDo2netjMU
	BEhSRWQwVTNG6sV87kkclVnjql96iGt+Eej1V6U2uDV8Yvf2ExgQ56HmYkAQI74a
	SDGkrbJLS46bbEeOhJmvTQmZWVuqYqzUcVXI3mdlyc4FSypomwWl6S+TvmiBgZy1
	I/9hxMWxQvqkZDIOosqV5O+Gks4Q5EqaXFeSJ3c7+G06RjLk8ZenoWptddoKoLae
	9KgYKg902zVY0Le73pN6U585IklRuVWMdfUpDaBMHdXZDKm/A21hFnF7JJzVzBpc
	GXlwx80v/rfzc/vSXxGporHdaHsSxvd0YVwBwM39+27GZP1ewvUw3mJ1Sc1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724316395; x=1724402795; bh=Np+CDqq9vqaFdFTAZ4s8Cz5eWS+R
	qk7+cnxaSQ/I7Kw=; b=tX+x+/GuxwnUayEAtNjJ/R7SPtCaEHH/GS9F4inJ9zkK
	ZFqgj4cyQWPgjUH4mXaAPrhP13iCe8OiL1DHtz4myoPI2ahRroJmuLuEBmjfXymz
	dMHwsuz28BFUKP3DCAEUZeBEyuzWp3upZeo25eMXcj3MBQZkuOHR+RX38lat+4es
	IZiuKbIafOzkowejGZqYX8esgn5ggFzJ9XaK+xF+TMps8Kmb+d/RVDA0uXYMBXbM
	b9yOFoSo9fk/3Gw3IqdxLA9R6NVSoQjUTvRFF3mMHd00KoLS0UsUWrlc4rDTsTyR
	mvCp8DfZWf8WZPhuxxGJBWU/jHIKkK/9R85w3yv/Kg==
X-ME-Sender: <xms:6_rGZjci9otWD02fItJwIvOLK55j8vu95QeEZP1216jmp16Tsr3VjQ>
    <xme:6_rGZpMXND8ceoiVRkldO1ZxWHgwjAMITDsvyct6_umv3W1HMrTgx1hkoDokCH9eh
    fjd78L4mFmOCnWP4Q>
X-ME-Received: <xmr:6_rGZshzQONECoQUyj-A9MA7jvWODCeEnPdd8b4S7oUNs44on8j27c0VaQumeyNhT240OR6bhd_qOx_uv1XbW3rm8OJSBL78R7ExDqI4DYE9g2c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6_rGZk9ouhsMRWMHUDVFfLaMSD4cPsVKHdpOkfcBL9nwT1bj5WbcRw>
    <xmx:6_rGZvsnLS_LzbU5zSPuu8nWIOFpt6SVvBACrUZrz7cv7TivgMQjkw>
    <xmx:6_rGZjEkcK5el-WXzvsM6YY_ZGlbC0mWAczo2HVX0lwj_bj6O1Is5w>
    <xmx:6_rGZmMADVSAWN5ujCmAPI11R4NU7i47ZBjtLm143xpjRWxl1fbmZA>
    <xmx:6_rGZpIYK8n_BD6z6VjLAztDYZGhAhAoa6CnYDj3FwrjUk2ihEKYiFZS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 04:46:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b56e5177 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 08:45:58 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:46:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v1 2/4] ref: add regular ref content check for files
 backend
Message-ID: <Zsb64NTyqc_oHNFO@tanuki>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <ZsIM2DRDbJsvNjAM@ArchLinux>
 <xmqqed6j9m24.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed6j9m24.fsf@gitster.g>

On Tue, Aug 20, 2024 at 09:49:23AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > We implicitly reply on "git-fsck(1)" to check the consistency of regular
> 
> "reply" -> "rely", I think.
> 
> > refs. However, when parsing the regular refs for files backend, we allow
> > the ref content to end with no newline or contain some garbages. We
> > should warn the user about above situations.
> 
> Hmph, should we?  
> 
> If the content is short (e.g., in SHA-1 repository it only has 39
> hexdigit) even if that may be sufficient to uniquely name the
> object, we should warn about it, of course.  A file that has
> 64-hexdigit with a terminating LF at the end may be a valid file to
> be in $GIT_DIR/refs/ hierarchy in a SHA-256 repository, but such a
> file in a SHA-1 repository should also be subject to a warning, as
> it could be a sign that somebody screwed up object format
> conversion.
> 
> But a file that has only 40-hexdigit without a terminating LF at the
> end?  Or a file that has 40-hexdigit followed by a CRLF instead of
> LF?  Or a file that has the identical content as a valid ref on its
> first line, but has extra stuff on its second and subsequent lines?
> 
> What does the name-to-object-name-mapping layer (aka "get_oid" API)
> do when they see such a file in the $GIT_DIR/refs/ hierarchy?  If
> they are treated as valid ref in the "normal" code path, it needs a
> strong justification to tighten the rules retroactively, much
> stronger than "Our current code, and any of our older versions,
> would have written such a file as a loose ref with our code."
> 
> "What are we protecting us from with this tightening?" is the
> question we should be asking ourselves, when evaluating each of
> these new rules that fsck used not to care about.

I'd say filesystem corruption, buggy implementations and compatibility
with other implementations of Git. The format for refs does not allow
for any other information than either an object ID for plain refs, and
the referee for symbolic refs. The fact that we do accept that is a mere
implementation detail because we reuse the same function to parse refs
that we also use for pseudorefs. And these _can_ have additional data.

So any reference that contains additional data is not a proper ref and
thus should be warned about from my point of view. No Git tooling should
write them, so if something does it's a red flag to me.

Patrick
