Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CBB1C8629
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179857; cv=none; b=KIpWWGDHzJA/5iteTTSn+5DEBRpLO5Mu820eyIj7s3J2jFsYBTfXmFms2Un5uqvaqJxPyJkVzPFIv0ywDNeMIadD5i/2QwL18Y0sUjTxRW7OmnI7Vh/YptFMcK/Q21fXACdn+jxnO/XRJS3u6Qw2bN/wDdU91T88+7SbO0fPXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179857; c=relaxed/simple;
	bh=Ev95t7KYKUtJtpXiBTCFgqCGsnIfkXouyrf7etcfFlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYaU5CWo1iYjzRpjLxpgwm0cK6px1gMf3dVreHXXEKAnMLr56XCEuJutS72L0sgrwygg/7hrh/CnxnRQGQ0QK3zuoOTAg1i+tmajZFpjtv4I7Bl/Y+IPZNOnl5wgJGVDP5kjVT2/owAC3BdB8TZMsBFCnoors/X6BM+pY1VTZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jQ3bdeFL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gFEik9ew; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jQ3bdeFL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gFEik9ew"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 346EC1380FF0;
	Fri,  2 May 2025 05:57:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 02 May 2025 05:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746179854; x=1746266254; bh=E0V2h0O+Vl
	/64qUxoJHvmtF9Wp9PxUFf3zdUOUtwfyE=; b=jQ3bdeFL6JAJZxjyJ0B5Pj/gk4
	aPqwD1MNAYulJ7zlLf6lJBigODTFdoqO26GSor1AVtQEJGz7sEO5EXsiVcqAoLH6
	y9Tglt//S6Tpy7hakBJeo3fCiKP3jgrmqRxqa/YnOySspY2b7i4G5Y6DFbj4yy1K
	h0qHIMqPUrhkw0iyTRhWsw+U3Xt6/Q68PgzfXZxnMmpyHV9jGHUF3x6NXM2+J/v/
	uEaxjZUjJiWmjYKN4vZmRKAZ7PTmWzg+mvTDAboYYW3hA7BvY0uIQ2CkgUN7Bo+u
	l6Okvg1vmIIUdyLhHdRNEv/f0i2UHFwgdv0U6p3Ch7ClT/qBZg2QUvLq8v3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746179854; x=1746266254; bh=E0V2h0O+Vl/64qUxoJHvmtF9Wp9PxUFf3zd
	UOUtwfyE=; b=gFEik9ewxFUoxBLWspsSTXKzBDj6oxlyFKHn0L2T3NAphiMCxX6
	pvrfAbT8MAHsZvF5gN0u8/vZL2zfSFa17FfiABQO0j0V/qtRks9BpFsLXbZsauM1
	WsVZ1VEkiX8NhSOfadRNC1bOFrHsrFvX/PDsbDgufLjkp0oGccdgHmAJIh+SX/Wg
	odFaDISujIAewx3xtmlrGl5Vcx6uPIfbbuiX8LLFSgRDpap+farNChdvqrS0BRt3
	HOhZXAzlRP5xeB+nob8Qqf6evPTm6tpYESyEc9A2iDuDqzWTsFgGncLD6OxGcR2i
	FDEBVnK6WM5tHRXSum+lnyDCpOxa6x05J/g==
X-ME-Sender: <xms:DZcUaEykUl5Veox3cYRDBhXrQjVNcJ8OT_gKKtUoviMkaPTZJrrHbw>
    <xme:DZcUaIRY0g5YI3pT9DmwOnF4ivU9ounlHMVoF-x18pmzeNta1GURIYHyu1l-kYxty
    7fu8ItQIy_jsDHwSQ>
X-ME-Received: <xmr:DZcUaGWgJlQMUrM9uYqMmyFCEu5gu9uzGF9qb_F0ETHuIUc2wiwHYkoiaGtuVwcvyRry-wH5nt38AFjVEYQtwTAEucLd4ws7cEynS9gkRJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:DZcUaCh1jEA4XaE-068UpldyLylAF8EsOuFDKkP2XTVOMUbYxOJx8Q>
    <xmx:DZcUaGCWM5qnK2kFblZRcEtBUAYPye2TqnUulveX72h3gE9IybeOiA>
    <xmx:DZcUaDLjd2KQS2yuj4bkNVqdO5Xla0FfMtup6c3WUyVSynayIZkJEw>
    <xmx:DZcUaNA54OPqazQomKpgri5Bi-ILvBBx7aNfDiKbxHD_Up_D-aqk8Q>
    <xmx:DpcUaMH3XRuJQuY9nyN3BSSsMhUpINMWTqaGN8Y7Wz8YppAyIe91QQzW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:57:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af1092b1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:57:31 +0000 (UTC)
Date: Fri, 2 May 2025 11:57:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 09/10] t/unit-tests: convert reftable stack test to
 use clar
Message-ID: <aBSXBv0oPOXpfC2i@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-10-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429175302.23724-10-kuforiji98@gmail.com>

On Tue, Apr 29, 2025 at 06:53:01PM +0100, Seyi Kuforiji wrote:
> diff --git a/t/meson.build b/t/meson.build
> index 756cb2a2dd..8fa00fc9ef 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -1102,7 +1102,6 @@ integration_tests = [
>  # sufficient to catch missing test suites in our CI though.
>  foreach glob, tests : {
>    't[0-9][0-9][0-9][0-9]-*.sh': integration_tests,
> -  'unit-tests/t-*.c': unit_test_programs,
>    'unit-tests/u-*.c': clar_test_suites,
>  }
>    actual_tests = run_command(shell, '-c', 'ls ' + glob,

Okay. Ideally this would be moved into the next commit where we remove
the infrastructure for our old-style unit tests, but we can't because
the glob matches nothing anymore and thus causes an error.

Also, we have a "check-meson" target in "t/Makefile". Don't we have to
remove unit tests from there, too?

Patrick
