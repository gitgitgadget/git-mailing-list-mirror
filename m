Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D864421887
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470109; cv=none; b=YA1ZN0NuDLy1qRkA7VQEOshbUkYdcLeZ595E6peAsD936SRmus2dTuNRGKiYhN/Nsr9y51VbEMsGSDYVT9LOoZbe6oKV2GjtKwHVHUJmKclnEychAZs8550zgjb9cQO2YPVQSEw0dG/nIUOm/UJCNvbJxCtQ8jX+0e9G3X1wbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470109; c=relaxed/simple;
	bh=EaL1Na9RX4DDpJpLnWLULt75YKZQj4iS5AfVTUkSmZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I8l01utujOChwlwwKc9vSwrCtuvPzWCBF1dP47VL5OhnAz2kOhiA4zVWQUT82XZW3nwl2LPsCbFQZ4mg9zayYx08L+yR2j9JLIM4I0kfXSQXYB/dU8ngRfDgjHa9VAuO8oWgmxTbNFnN5Oq+Rr3wLQiJbKzeEQJXAmJ09ujrGLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hcPMF+j+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eMeqlvRy; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hcPMF+j+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eMeqlvRy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3DDD7A0250;
	Mon,  2 Mar 2026 11:48:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 11:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772470106; x=1772556506; bh=XACEXIIcbi
	Qrlrjt9UNjGEIbnK6zVM2/cQsORvpdp3Y=; b=hcPMF+j+CdRWO86gdvL/pfCCGi
	GzjIlk7NQCROR/6zGOT6JHiNmkDd9UEqW/B4fVScnatgVbLyCR564+4fPCyS8JsV
	s35tIB9ULZdo1N+qZpc8bje9t1i1Rkxm7Ko1IOwHRVc/QIRETZaXtQ99Lh8L9AVb
	uaytlVFvTg30ohabiKuYmD4UtAv+vRHEqhlf47SXXwIB5twc+WOyeHrA91T/7DPI
	weIL7uKCtm75b6jCrX9Dx7iturE0heoTOFgWOJr3u1ZqmbJ6Jrghh/yO3h9vXvdc
	uauulVF3ctCv0k634iWQJed5ewCLnXL909M6quowmREYiSkA2WUoPVh4SepA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772470106; x=1772556506; bh=XACEXIIcbiQrlrjt9UNjGEIbnK6zVM2/cQs
	ORvpdp3Y=; b=eMeqlvRy9llQ5Mwyb85VDrA4RQayjPEcNsy+hX443YxmXYYbIvd
	W5rSUlMnOLJYYAg2u89WTcdUYchJ9HeeACGz9BXJLbytUfyEVikdnUtxvuPOlHIx
	ed7k3WytNCNRkFpFcaFi8D16clPV9qebNdmk4jly6VfNmPJhA6CBzS0421bx2xDd
	wVP22r0lrW4uVxVTctRU9ePe+Uj2+thSJpYK1g40z/0oM3AH4pHShZX+gOj+adm+
	GUfVKLFsI6KX6Z713vXM4KuxngBYI5tjJyqU+lyeYXRTsiDWWUo2kwWcWk+r1kkb
	JqmrIo+O/+Jo3qNuqzzgzbtA29xnVbcl1hQ==
X-ME-Sender: <xms:Wr-laV7VI-24lV7Eh9ItJr9dcdcOENwKfrnY4DvfKX3Etpf3iOHoiQ>
    <xme:Wr-laR9IBe-8X3xUEtTyjiKT9jWpJuRRijWnuL17VDpI4gAdPvYysGxU-qElYl93X
    w-pipGL8b2DfWp-1YItuIpWga84FapKQRG5H3QuswjYqO5vffzvOA>
X-ME-Received: <xmr:Wr-laSpNLHbDwTEBmyxSLz7Z-TRbHlXTAYrggbrvyG15ByeyzCJUDQcIfIsrmbqY-_rfT7g8uvrOPTYb1Fap6uOjwTEUHV3seg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Wr-laaq00SGxVfCi86hLz8XBQAh0fd-GT-GO4kr2EVWG-A3Y4HnB-A>
    <xmx:Wr-lad02ke9sIZ3Dd7X3sJQmL2YI-qBLOJ1qy-7ehxUZpRmtMfjzXg>
    <xmx:Wr-laQHokpKfJnkKXqUx0_gte9BOIX590ru54tJ55Z9f9DrNFqn9DA>
    <xmx:Wr-laQH_rKbD4hQi3U4_ucQJ4h3npsVn4W0b5fO0ivg7tqlnnQNHBg>
    <xmx:Wr-laR8A3vatehApXxMANyU-rlKMnkyi52GDAp9x0QT1MYjHEweSnP2b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 11:48:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 00/12][next] Specify hooks via configs
In-Reply-To: <20260301184500.1488433-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Sun, 1 Mar 2026 20:44:48 +0200")
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
	<20260301184500.1488433-1-adrian.ratiu@collabora.com>
Date: Mon, 02 Mar 2026 08:48:24 -0800
Message-ID: <xmqqy0ka2n53.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Hello everyone,
>
> v3 addresses all feedback received in v2 (details below, including range-diff).
>
> This series adds a new feature: the ability to specify commands to run
> for hook events via config entries (including shell commands).
>
> So instead of dropping a shell script or a custom program in .git/hooks
> you can now tell git via config files to run a program or shell script
> (can be specified directly in the config) when you run hook "foo".
>
> This also means you can setup global hooks to run in multiple repos via
> global configs and there's an option to disable them if necessary.
>
> For simplicity, because this series is becoming rather big, hooks are
> still executed sequentially (.jobs == 1). Parallel execution is added
> in another follow-up patch series.
>
> This is based on the latest next branch because it depends on some
> commits which haven't yet landed in master.

Please don't depend a series on 'next'.  That will make your topic
taken hostage by _every_ topic there.

Besides, the ar/config-hooks topic has been in 'next' for the last
few days already, and it is time to go incremental updates.

Thanks.
