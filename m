Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208513D245
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917959; cv=none; b=sdo0AliIV5rRAZQV80THquxCuKG6StgTYfxMGWeG/KNSovCVaJ/vniFAzLw9rHAOXoCEX5R+2L+ZhPJFOgOw0nsIr3Tk5YPTdq1SqlzQrzZv/EfWSYkWKrzWweh9R0pRum4TI43IQDP8cjJAJac88Qs5MazEhbm6bgRCpxB2MkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917959; c=relaxed/simple;
	bh=VtYlBxIbTjmUJcrZYHjrTO0GoXvKa9wlZ5nom3pvn2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVkkTKnAQmu+oiQZzZB70LfhV48UjCLCCuZV1z3Dpd2DwfT60diKP1v7hsFs7EaW00mHwhi33s29/Thq1y/C7BfI6uRF8EBaU+ekSPjdckTdqHEwn6Hd/bSnbXy5ut6eusD4X1cFxSDkOZI08d7p3Ly7HQQYzUtLPzmeV83zfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZgjqEiVY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HaS7sxV2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZgjqEiVY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HaS7sxV2"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E44AB2540166;
	Mon, 18 Nov 2024 03:19:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 18 Nov 2024 03:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731917956;
	 x=1732004356; bh=cDPvldiHwWR3f+Q8tIzKQnHdFG0M9ugZEbOrK7RbwhI=; b=
	ZgjqEiVYSBQsAxhMLyESHo2qa8ntT0U7YqNZXb/CAU6gRpfyCQtbwYjgq658qBsZ
	JRlQd2Rlnc0+U8u7CoCioUWb4IxfVEXizn8fA6uTT2uQlGwhMKIYe0tVmkHiLaZ9
	skocAQmxludESOGa95nmB8HlQ5VvYFYyGNEqaV1PPHRng6N64IklYV7nlIlQUG8h
	ohhC77Ihz7E51G7rana+o45PWiCySqaAvxtEcejjgvSNcFaGFjovfKtnz23NxsZS
	1rX2OM5F+siL4Y93uj08hMfdHIFpXp9id6ZeRxj4sI9D9Yp1Wa+RBsRzX/ptOIL8
	CU+0REvXdcUtJzLMK8xFeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731917956; x=
	1732004356; bh=cDPvldiHwWR3f+Q8tIzKQnHdFG0M9ugZEbOrK7RbwhI=; b=H
	aS7sxV2VepPbB3nycG9kjOasMgO07JBKP7E+MoSt0Lpz00InllBur9hHYI78ziN8
	s/rqJX07lv/G10vgo2tOMOJZtm6/OdAjc1Z6901BRViSGVow6wWiXPMLuyIdCo3F
	/MrzoWdAvw1RFamU4N/Hmn7Wi2Nk20QtBo7Phe7+y/JqCA/G5ZAmrNg7XIpKyt71
	Q5CJrqImE15g/lrpTniDendAQQgaHVh/6az1rlPsZpSrE4LtlseLZaSNB/gxSIxC
	uv7yaoQ0uIz+0tq+a7GU1hqfnWC5ZH3K617gIvpgRvCR1bqorf5XL32cX0527UHk
	ZDccNnOI/wISb6xZj3QgA==
X-ME-Sender: <xms:hPg6Z6mlHA3Mo_GQoJFczOtU9s7LtsU7qDKWao9eti6Lhk1IeiVinA>
    <xme:hPg6Zx17yt8ypEk8ibnJP-kMeEvlFqq5LvYHcpUHbAk-8vsy_uSindrPihIg2eS3L
    fv5TH4sDkY-PIuzWQ>
X-ME-Received: <xmr:hPg6Z4rR7s97SSQ2ZxiFDLl4CpInSNj_Az0b93_t1qJRSlXTnRim0oxIFynCj9-jw3QdkLWMAgxJa0ADeNgsIc2S-V5aCQ_7ETcWNJBtoVswY-Iq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghksegvnhhrghekrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigv
    sgdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hPg6Z-mfDDVEoru4T1p4ilrADmqyMSm_Y1QiygjDKI0eYEbDE5qMeA>
    <xmx:hPg6Z40wG6Ous67rcioXMksGv3iQ38WiwZ-8UnfmJ419lLKJKGmp6A>
    <xmx:hPg6Z1v2FGmZG_HnNKxBw-S7mYMuWcqJvQRLNoA83Wd58HU5pilRkw>
    <xmx:hPg6Z0U4xAsZEzwf0_vgXX3hOg0NvOSDgLFcADbyB1J5ThtqonPgxw>
    <xmx:hPg6Z7SqKLUmANJb94iefgXn5RMjeWzABQ1L-58Yc_7XV544XxtM1wpv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 03:19:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fa493ad2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 08:18:26 +0000 (UTC)
Date: Mon, 18 Nov 2024 09:19:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Attila Kerekes <ak@enrg8.com>, git@vger.kernel.org
Subject: Re: malloc: *** error for object 0x1: pointer being freed was not
 allocated on MacOS with git 2.47.0
Message-ID: <Zzr4cgk_5MJNcHm1@pks.im>
References: <5FFE9429-7496-429F-BEC5-9D00C8409AC3@enrg8.com>
 <4ca84916-c5f5-4d52-8f6a-08b729bb66b8@web.de>
 <xmqq34js1kd2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq34js1kd2.fsf@gitster.g>

On Sat, Nov 16, 2024 at 02:23:53AM +0900, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> > This is a known error.  Commit c95547a394 (builtin/gc: fix crash when
> > running `git maintenance start`, 2024-10-10) fixes it, but has not made
> > it into a released version, yet.
> 
> Thanks.
> 
> There are bunch of topics that could go to 'maint' and be part of a
> maintenance topic, and this certainly looks like one of those topics
> that can go into 2.47.1 someday.  The usual source of candidate
> topics I use is messy and unusable for some unknown reason, but
> offhand I think these are safe and sensible to merge down to
> 'maint':
> 
>     ds/line-log-asan-fix # 1 (2024-10-10) 
>     jk/fsmonitor-event-listener-race-fix # 2 (2024-10-15) 
>     ps/maintenance-start-crash-fix # 1 (2024-10-18) 

Other candidates that fix regressions:

    jk/fetch-prefetch-double-free-fix
    tb/multi-pack-reuse-dupfix
    pb/clar-build-fix
    ps/upgrade-clar
    wm/shortlog-hash

I think that we have accumulated enough topics by now to warrant a
2.47.1 release, but will of course leave that decision to you.

Thanks!

Patrick
