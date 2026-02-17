Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE61A9F91
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360063; cv=none; b=JaAcUsaY6hAnNmas38UqixFrImsZUqwoR8Kvr+x8fespKGx8V31c7RS43OjvDF0MnyMhAzsc9OwNiZAVl4ddyk3gf/3lcwL9Uyor2sveMti4b45ovoA3awAJb7c4MNWIFW4t13IfTYka+jhS1W6Ya2QmFT6sVR4NaXI2SxLc3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360063; c=relaxed/simple;
	bh=thEeF1E5j74t/1lhP/kw4UR9iPqIzYiHiubdpj3EzW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jfarrIiNJcErHIb9F68bnrA4VVwdPIP+sTAtMO26MYZM9u5NJ4l21Qls40hb23DB7y+OtZai04BJta7iw6uDOYhIUN2TQORZDDe5BfPh+F0Cyj0FAZSQ1gMdG2pj3UxR2tflINkzndO4JNPtDOROTRFyMCzQSpANJmNfxzVEpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C6IdbWEh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uxZ4w81T; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C6IdbWEh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uxZ4w81T"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A8C2C1D0013D;
	Tue, 17 Feb 2026 15:27:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 15:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771360061; x=1771446461; bh=WddOTFv+Cd
	Z8DtDuYyAJEl92jSyZbWSwagj60syzbpA=; b=C6IdbWEhrk/g3yXLw6idQNiQXx
	lGL5qA8IVW96t3lxtknfXLHLATekgKFNhZiqdvlLTdfTJymgDVXXSr7MjacNx2a3
	Yc9tfVtPUfvMpx0PyesdUdHmhFMivXSNsK5BDM/TFwzYTD+SzRMbw9BqKeyf8jPV
	5IaZ2H4ciIzbTAiayG5LEAM482Lx1E/x8pelSY/iFtDwJLczhMrDVSFc95uDKEc5
	iI9A/UecJEP9gFqb8Bul1COmuRQzAL++vIGFcbgOMDt1sNUN1Ra+tWkB0IAe+KAe
	IUMc/PPOySwww4JnghlHTds3F8CWpysvz7cndBceNRz2sUbFzOzyu6oWdRtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771360061; x=1771446461; bh=WddOTFv+CdZ8DtDuYyAJEl92jSyZbWSwagj
	60syzbpA=; b=uxZ4w81TmZWJBejtkNX5dAjY1zfReFhLHB06kQ1QMsHAqPDqktQ
	q0Ag35vVisC1QGRxsb/d+vk6jNI47vqn3ezRruFbyVrNLXqgv2K6zjCGDjWwlz9w
	y/AYGD/0kpWHMTj8dSLPVMK9CfsCO4Tui8N7b2Q+Hy27M2+BD0YthAB/7twlgTMl
	QEwcR0KS1+S42D/ZyHSa07avykTdjYiP87FjAXopEpEIwfG6l4FucGky0x8Ir78e
	CVDNs0rtKTmhoeXK/nUALGqER2cJuvpl1v915KYVfCLIyrmePIm7qXIUBfN0GSQ4
	6eTpLbULs4u587KWgcE92OSQr9ENKfyl+pw==
X-ME-Sender: <xms:Pc-Uad8xdRmMiv2RYGim27P2kt2M8a9c39Jw0fZZOojtvv8jx_NPyA>
    <xme:Pc-UaVbXuXS04QuADwwnbjW4RDTv_uwye--cAzV7yvp8g5ruKZafFu0UKKIpPlL_d
    xj37YPyWyzgbALSjg2tmgtz4g7afW527r_tu6gxWyX5tK2Xk8JWtw>
X-ME-Received: <xmr:Pc-UaU1OowqOLgk7pVieGpeMfoI0XWb65svHk1wi_JGXKG2YTBYZPGgFxaI0yo8W3ZpjXL-F4qYznCHlp9ligsdaYOkIb1dSWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehjohgrqhhuihhmrhhotghhrgdrtg
    homhdprhgtphhtthhopehjohgrqhhuihhmsegrmhhuthgrsghlvgdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Pc-UaYb0yhjWMP4r6iAmpBazgHWiz6XPZwt5AwijkOSDZUPKWnrLsg>
    <xmx:Pc-UaUJQGOyyKuNmA3FlIRUuM-uTTbyDcHqrcGsRsLCbVgDbKoKbUg>
    <xmx:Pc-UafGWfSZqpZlhVF9DKq4v9a7ASeOjIJ3UU7zz61g5-ozL2d6kTw>
    <xmx:Pc-UaTtBSmv5obZJgipA0gH2kNc9r2CbBq1GaGoLMH8zS4SyjxOkbQ>
    <xmx:Pc-UaQSmCZzbRwAbGQ9tQ_WKihOLWP4GL_gmFsZom3n5qKBlYc07i0EW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 15:27:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Joaquim Rocha via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Joaquim Rocha <me@joaquimrocha.com>,  Joaquim Rocha
 <joaquim@amutable.com>
Subject: Re: [PATCH] apply: strip ./ prefix from --directory argument
In-Reply-To: <aZQhnIcPa9sCPpBb@pks.im> (Patrick Steinhardt's message of "Tue,
	17 Feb 2026 09:06:52 +0100")
References: <pull.2198.git.git.1771002510709.gitgitgadget@gmail.com>
	<aZQhnIcPa9sCPpBb@pks.im>
Date: Tue, 17 Feb 2026 12:27:39 -0800
Message-ID: <xmqqzf579kuc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> While this change here fixes your observed issues, the next person might
> run into a totally different one. So more generally, I think what we'd
> rather want to do is to fully normalize the path. How about this
> instead:

Sorry, but I am confused.  Why isn't "don't do it then" a good
answer for a case like this?

>
> diff --git a/apply.c b/apply.c
> index 9de2eb953e..8946b133a3 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -5002,6 +5002,7 @@ static int apply_option_parse_directory(const struct option *opt,
>  
>  	strbuf_reset(&state->root);
>  	strbuf_addstr(&state->root, arg);
> +	strbuf_normalize_path(&state->root);
>  	strbuf_complete(&state->root, '/');
>  	return 0;
>  }
>
> `strbuf_normalize_path()` drops "." components, removes ".." and it
> squashes multiple directory separators. So it handles your specific use
> case, but also others.
>
> Thanks!
>
> Patrick
