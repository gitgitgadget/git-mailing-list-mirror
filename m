Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF3F23B0
	for <git@vger.kernel.org>; Wed, 14 May 2025 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747188997; cv=none; b=jBGK7zVvL7lC4Ka6g0xlxcvxYb9pHT5NVcj3Ze/Ni5GU6/uI8U9DMDqnkh8l9IEVHCeYATmss+yXChvf3AwC5ONSZB0Z0Uqq/GJr91xcw/WO9gEKEBFl/8YQ7jmMyb5qMNYTF/nMpVqeRcOxmEKuCWTf1Knc5PHsi7SyDlY2kmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747188997; c=relaxed/simple;
	bh=s87AJ2+AXuV7veLQhqMNLdY2f2M1yrv+bzCPkbjcV+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui1RA0v8KdipK28MNiJXIntMUwaqiAK4+t63Slxkrm1gLi4ZaQfZ3zzKZFTaJ6dtw//Zo8jn7g9ppCS5pt/Atm0tziAZ1Ps9Op+icO7uSyTq4GFh7BJZM44UT645QKKPLTpz0lgkuXGBD4XtbaskRMN86elks9DHau9gU4H7iGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tLkKc3vp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D/pe0dpN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tLkKc3vp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D/pe0dpN"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 62547138016A;
	Tue, 13 May 2025 22:16:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 May 2025 22:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747188993; x=1747275393; bh=sgAkZ0Y4o+
	38FqZOlvgdPhuYYa7jIAgr1FZqqSMMNzI=; b=tLkKc3vpdYa/eRrtVpdyEQWmRr
	q89XLpv7nOY3exWC8I4vK1DuitjYtuWRoBPvya+z2MlRZrImLZoze1yTNPzt3M3j
	8oDt5P4NfCYvLbK9A7DiclX4JQRct8BF5/Gbrtt/SEjaEQNMzc+XSqAp6pujrXqT
	8o87qR+/O9KWYC2n1o3kxZovgVUOGg58D/DdeAUs1NXmYsia9eNsRgycVmBOqJNd
	G7R1QpmEp7hFVKJkFOupMyEbhX8d4Ccpd4LAVR9lBmeWF6lmKEEjWk3zTKl3xrBG
	KtrMhVewd8ALMz5etJGvnkilBBPw84JTuUQDMv7Kv/FI7HVNozIHb8CWnqqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747188993; x=1747275393; bh=sgAkZ0Y4o+38FqZOlvgdPhuYYa7jIAgr1FZ
	qqSMMNzI=; b=D/pe0dpNVCCHRezyUlvU1zgd/CDfFafAqXvj5PBdC1F8eRrjsyV
	ID0y2W17lMFL+5lIztGTA9rq27fhVztzC3yFPtW2Ei9wVKoWhvraNFJOdue6q7jA
	R9nZ7x6RZdQnXdt+o5ANCMS02rOS1lqysVpWtzzitsLH3tzvGQrFTVHHlOFuEkaG
	onafhTatBTl9k6Wwh4uPW8St/pSYiEKyewseDqWYPnTiSnhphyfkHzAxoE/i2B2C
	n5Yy9f+x4zXsAILwKouwKj/v2OkUBE7YzGLRSgE5bwCZff53egPdo/cx2sEszStG
	CBbmg5qMYj8cQYL2D5DDIvSSkZvI270a7bw==
X-ME-Sender: <xms:Af0jaHql4DCyy1w7SHu6GUDDSBhmfBagdIKW-ChwCdQkxKIjDSZG_Q>
    <xme:Af0jaBotwESM5qvG59pTCx8VvpZzG4tAnwNHlP-wxsYXFlg-uZ7J20TRDEruuRd6E
    6v4SO8wWxhriaILCg>
X-ME-Received: <xmr:Af0jaEPosAWw1OJgMeV5iLFmXeLTt6YVvqklj7SCOoJai4e4Xbnpq8wiMM-E0tat54-bpvSEgZgrN-HgPDp1Ydop2W7SdGK6noWi7wfIHZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdehjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Af0jaK6Cptl-VvqW9mg_B-1O47HudS-6scpfs092mh-N8AotN66xYA>
    <xmx:Af0jaG68-d2hqlQ-h78NtPi6nG7x3VXxkvv9AYzg10ykSiR_vCgqfw>
    <xmx:Af0jaCir7nxOT23FbTMXtAZajpJ-_2YxEYWfV3DajLrXJ_dQ6B0slw>
    <xmx:Af0jaI5h4oocfDDFSDJy_sIuT3HaVyoMpEycsGnKsYkcil9AhEc5nA>
    <xmx:Af0jaCIdCbMb2gA4d2wy1B0Hevp-L7tH4mi_WklaWUDjCLTIzOD8ty3c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 22:16:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f104b0b6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 02:16:30 +0000 (UTC)
Date: Wed, 14 May 2025 04:16:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitlab-ci: always run MSVC-based Meson job
Message-ID: <aCP8_YiMaFfv8P0D@pks.im>
References: <20250428-pks-gitlab-ci-execute-win-meson-v1-1-f68683552b9e@pks.im>
 <aCMNGUlfBcafn97s@pks.im>
 <xmqq4ixoh28d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ixoh28d.fsf@gitster.g>

On Tue, May 13, 2025 at 10:03:46AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Mon, Apr 28, 2025 at 11:32:12AM +0200, Patrick Steinhardt wrote:
> >> With 7304bd2bc39 (ci: wire up Visual Studio build with Meson,
> >> 2025-01-22) we have introduced a CI job that builds and tests Git with
> >> Microsoft Visual Studio via Meson. This job is only being executed by
> >> default on GitHub Workflows though -- on GitLab CI it is marked as a
> >> "manual" job, so the developer has to actively trigger these jobs.
> >> 
> >> The consequence of this split is that any breakage specific to this job
> >> is only noticed by developers who mainly work with GitHub. Let's improve
> >> this situation by also running the job by default on GitLab CI.
> >> 
> >> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >
> > While there has been discussion around whether we can in general avoid
> > some duplication in our pipelines, I think this patch makes sense
> > regardless to bring GitLab CI in line with GitHub Workflows. I haven't
> > seen the patch being picked up yet though -- I assume it fell of the
> > radar.
> >
> > Junio, do you have any concern with taking this patch?
> 
> As long as Windows stakeholders are happy with the change, I have no
> objection.  I didn't pick it up simply because Dscho didn't sound
> too happy, and I do not take "The code seems to be correct, but I do
> not like what it does" as a positive endorsement.

I don't think Dscho pays much attention to the GitLab CI anyway, so it
ultimately doesn't matter too much for him. This is not criticism by the
way, it should ideally be interchangable whether anybody looks at GitHub
or GitLab CI. So by making the GitLab CI run those jobs by default we
make the CI systems more interchangable.

I expect that this should help us at GitLab to decrease Dscho's load as
we would see the same kind of breakage that he needs to worry about
every day. And being the primary drivers for the Meson build system I
think it's only fair that we help out with fixing any issues that happen
in the Win+Meson jobs.

Patrick
