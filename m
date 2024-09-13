Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418F417FD
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 05:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726204621; cv=none; b=RF0hcJ/MpaSH/kTKMc/iA+bca6NHx7w/IpYuwEiTMkWyXDtBGNuEYezQfyDtdl4M9pcMq53ePBlzlMzsQ5Z4eO7KLBwDztfthR0tgfZmpK7MIawAI6fJh70FBkMVFSo/TBgSI6VZBcduVdif1d2aLMEHHRculU8REmmxmHGQG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726204621; c=relaxed/simple;
	bh=QRWPNKT1Kszu4dFOJMgrSGyxqm1CJOquEoT/ihSzEmk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mW9sSHMS8C9MSQsHw06/MQ2B0Ye19OEdjEbJrTaOsFxLtvfXSjfYLwb5O9v/QxR9kWA038DtPI/oAM0i5HkMkytUfRVpJCecL9R+mIz3iFuuaesG17Wx7WEEhNISJAEaKvcjHjm5J78wBMi3KKEdHAdciXvtfSiskcIKLEtHPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iy5Qxorx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqLPZmoE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iy5Qxorx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqLPZmoE"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D2B5114055A;
	Fri, 13 Sep 2024 01:16:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Sep 2024 01:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1726204618; x=1726291018; bh=iS1NPLN3MRLE8+0NhWP5UBPvzpSVHvBG
	zc4UX4B6FQQ=; b=iy5QxorxZfo6LuEZtAmvW1mQVC+MFQI1vdaX/ciJB6y7wwg2
	lACv1bTt1P4yzlmAR1og2tJKUBZgXWWroLeUELKck3gGU19NXFyYwLd3j2kxhQiO
	jANT0cHA3Hf1K2tgBGZYEGicpQeSoGzmG/FRdCgt0kZRdvjQIs3OJdrE/EQyxqcY
	wJmKGaUKC9lUDTk0/BcaKiukKOr8zNj4g5ZRP83dsfB0cqnxS4pID+pwDu89TVBv
	UEvTeYNFAxKrhxEGRm9B2iL8QZKsfMS/77+jv07+ynV9Iimq8lCu040hLBF2wrwG
	4l8b+LofYoCJ3GHKLMeh+XgSIE7ayutNMA1Hyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1726204618; x=1726291018; bh=iS1NPLN3MRLE8+0NhWP5UBPvzpSVHvBGzc4
	UX4B6FQQ=; b=gqLPZmoEkACYmxrvgkKjD5tQgpIJCnFHsD4mgDeZyT9w7fb4s8r
	t+g21Pp3yROp2R3PkIqwmXWoFdhsNUvRXIBtqbsGbIgVeJmrFWn88L3OKdHpkufk
	tI8A3lrC0tqW7lahxPxy/mYniE+Ok1sO1sXDpb+eABr4r14uVkLxThadJgQsJ5Y0
	JicolLMdWVgRrneALGRprObYsNmniH+BYtO1ecgnkCoJWQHAHBMfhsJQ1KIUQTZs
	TeaxOA43ICu8ElfUPX2EFYwohK0uKXVE6xdZ+Yqxb5nji9jbHuW4//sYwl2Y3mq4
	3wGD06qGlC1zqxjoN3kwNdqlWK5zaYWyG5w==
X-ME-Sender: <xms:ycrjZr679uE51LMp_Yq7Igq8MDmcBrr0XTfmK1mBtEEBzcxh4qb3Yg>
    <xme:ycrjZg7A2AGdAt0qV3pk6ic0vzjFzsuUGFlsjfIZNKvcgSbM965ErSctYXmlvykZh
    lcxktgNgiDzLJ7n8A>
X-ME-Received: <xmr:ycrjZieyHq5FBmpHnV7JwOm0jFrF4RvHewt7gFD1UMVPxlOYdxDmlm-soy68Pi_Dw6CHZnlIw_hKOSM7RVkkY5kLiBCEu42qcoD4cFVdPN1rAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejiedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepudduiedvhfegueffkeetuedtkeffleehkeduhfdvgeejjeeh
    uedvudeiieehgfetnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdqshhmrghrthdqhh
    htthhpvddrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepuggrnhhivghlsehhrgiggidrshgvpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ycrjZsJQ-An-4Jbj36Or9j8pQCUn7z0N-WBROv-HcDtCafabpsaCvg>
    <xmx:ycrjZvJyZELazC_8xyaxhhaCN5Fx1tyxuyl2_6sUlIRH-nKUp_E8MA>
    <xmx:ycrjZlz5CNi2_Frfbr79rKOcbTlOq6uhkB6-jjdnb-UK7MZuxbuuOg>
    <xmx:ycrjZrJlSCdcExz47xZhQrGNmAyQ-HfRFav5WYUCGaMk_UWmC2-WkA>
    <xmx:ysrjZmUsHJp8BM3stru_KyHzKymRwfKTJtjDwlhd1S0ChuKfqYZatLn_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 01:16:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e227979e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 05:16:44 +0000 (UTC)
Date: Fri, 13 Sep 2024 07:16:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Daniel Stenberg <daniel@haxx.se>
Subject: curl 8.10.0 regression breaks uploads with HTTP/2 and http.postbuffer
Message-ID: <ZuPKvYP9ZZ2mhb4m@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I noticed that GitLab's CI started to fail consistently with our
Alpine-based builds in t5559.30. After investigating a bit I couldn't
notice anything obvious on our side changing, so I checked whether
Alpine itself updated any packages. And indeed, it updated to curl 8.10
yesterday.

I first expected this to be musl-specific, but I can reproduce the issue
on my glibc system, as well. The issue bisects to 35bf76628 (http2:
improved upload eos handling, 2024-08-04), which checks out with the
symptoms.

Reproducer in the Git project:

    ```
    $ make
    $ cd t/
    $ ./t5559-http-fetch-smart-http2.sh --run=1-4,30 -ix
    ```

Apache logs:

    [Fri Sep 13 05:10:57.153872 2024] [ssl:warn] [pid 1435033:tid 1435033] AH01909: dummy:443:0 server certificate does NOT include an ID which matches the server name
    [Fri Sep 13 05:10:57.156090 2024] [ssl:warn] [pid 1435035:tid 1435035] AH01873: Init: Session Cache is not configured [hint: SSLSessionCache]
    [Fri Sep 13 05:10:57.157052 2024] [ssl:warn] [pid 1435035:tid 1435035] AH01909: dummy:443:0 server certificate does NOT include an ID which matches the server name
    [Fri Sep 13 05:10:57.158122 2024] [mpm_event:notice] [pid 1435035:tid 1435035] AH00489: Apache/2.4.62 (Unix) OpenSSL/3.0.14 configured -- resuming normal operations
    [Fri Sep 13 05:10:57.158140 2024] [core:notice] [pid 1435035:tid 1435035] AH00094: Command line: '/nix/store/r2vzwkm8xvzdkfyqc9m3b3cc6q6jdly4-apache-httpd-2.4.62/bin/httpd -d /tmp/git-tests/trash directory.t5559-http-fetch-smart-http2/httpd -f /home/pks/Development/git/t/lib-httpd/apache.conf -D HTTP2 -D SSL -c Listen 127.0.0.1:5559'
    [Fri Sep 13 05:11:57.434888 2024] [cgi:error] [pid 1435039:tid 1435046] (70007)The timeout specified has expired: [remote 127.0.0.1:53154] AH01225: Error reading request entity data
    [Fri Sep 13 05:11:57.545789 2024] [mpm_event:notice] [pid 1435035:tid 1435035] AH00491: caught SIGTERM, shutting down

Most lines are expected, but the second-to-last line mentions an expired
timeout. So I suspect that with the mentioned commit, curl does not
detect the EOS correctly in all scenarios anymore. This only happens
with HTTP/2 -- the tests continue to work just fine with HTTP/1, which
we execute via t5551.

I didn't dig much further than that.

Patrick
