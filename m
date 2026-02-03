Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285421ABB9
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145230; cv=none; b=GWH6wRzgLZmA4DGMAgxsCH4/ZsfU3/RMBW/nLwvCf2duMIXpB536NAuO2oWlIL1Sfy5Tv8P8vR9CTFlGZQDkxEckpVNhk2ykSP6THXbvln62PKXZJtNZHhr+LvIoScQ5JV4+Mk1M9NNazphW+HMC1nzGHkWESxAb7Rd9bpLln1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145230; c=relaxed/simple;
	bh=9yWxXUpikdVoJ/h0kGfNvYKgPGd/96aP176+rfS493w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PaD9tBJUG8zSojhHNk9bAvaysM/73mS8M1UeY3osMC2O5S7+o2LtY27OaoPNZ1h9swkfvoFxxaprRTbdXa68RdjBRbWBeMgROwNU8SpYC6ysALlDKf6BzjHEbXCArfaZ9w5OUyOYBU16c/gLHdRNxNBKNepF1ue517CP4Idv15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bwPe39mZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y06VyPdb; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bwPe39mZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y06VyPdb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 166771D001A0;
	Tue,  3 Feb 2026 14:00:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 03 Feb 2026 14:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770145226; x=1770231626; bh=+zOESmaEPW
	FVFpcCayCIu8kORHRdwOvhGh7G7XlXLYM=; b=bwPe39mZqPLWeKBdhFQEeTquF3
	zDcn450jW4SDdCyeILWx9aod5ewxHdzcylUbtprYVvhrrnl9L9yXNfHEOU5iUOXE
	Fcef26s6rhvFsvCfe/iETAUNnZE2zq0G51X4l3OVYdUOB2bW6ZMzP13axo4h03in
	kALV1W5gRKVRfoCJJb6OKWDXImRM27hXgyk0qGW04P6AnFSM+Xvtn8qkL4uhWHs6
	RKoEmryrqQHxSVtFDdgDkOyJFLPq9z65uMtKTjOXYAoy4Rplof0Ez4TFM2GFmhbc
	DrqEndQl8JazECzz9KD7qKS17dOzMkROGBpb7U48gWjHDyRCo2dOsI7SitUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770145226; x=1770231626; bh=+zOESmaEPWFVFpcCayCIu8kORHRdwOvhGh7
	G7XlXLYM=; b=Y06VyPdb1LbMlKcwPA/1lZo0WimXFPsFw/4Umg5c6SwSoK/68LV
	mUaQNdB/tdmPJ27DhcREWFlDgXx1ixCTTVt4Y+aJQmq/HC7mf7fNe2LV9Ojiu5Zq
	dtM7H8nDxL3dMe+jIPlRBBw39EnUaxNvRtMv/W6F0vH47kI7rCcf9rHy0JzMSCM3
	XUXIe0y2k4MPjArxvxTAJjQxQ+VeY1CSPSAiP56FcKco+l0tSt1vF5kMM1iQdq6c
	nV/lPIf2WA4rMMRwgblgUXVzm1y1ZaooX0jDbokDgN0Fj5GQgSXyJLKilhdJFmdO
	/j/ra2H7Kj2qDAFHkurSuiM/aqr0T3WoN1g==
X-ME-Sender: <xms:ykWCaQjH35XGuhzVJoCF7qTcFD3vEpSgW2SyfJeZQVdx5zJsfY60xg>
    <xme:ykWCaVnVRMArkG_oLYi5YmC953FFsUhkgMcHN7g22LOo-GmaW5OdhykBbqKUHV5n2
    LZR1o-hvFSerEdUTelX8-PvtZjbQD50OUr26ze72ZvBHes2SNpHPA>
X-ME-Received: <xmr:ykWCacgFrwRc081ZitXzyTNmPpyXJnTVNnJhaAx9UhQ4bqyRUXJ483uR_VJ_Y6AzwV9yNPMXjpTNeChTmP3NbZdbb3BydXnOrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepohhpoh
    hhohhrvghlsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:ykWCaYEnjDJw8khObEihBzRAk_YmrcrzLGZwLeT6azwnU_fkn95eFg>
    <xmx:ykWCaeuPNBaWonu31zIy36ey-foDA9SWoQR1T-OLA39cZs5kM036JQ>
    <xmx:ykWCaZfgVP19M7Gq2mbUnn_XTXYP-8eehza9Ls2bqFXkrvv1accfBA>
    <xmx:ykWCaUmz369i8ESubLlLU2wI79d8XpPFGCPWiDV-Q7_V5afLO26Cfw>
    <xmx:ykWCaSNAZ-sF3HOYZoInKX_Ush1AwpFLyztMXqpgf3dcfvmX_Rnjg2S_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 14:00:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Andreas
 Schwab <schwab@linux-m68k.org>,  Ondrej Pohorelsky <opohorel@redhat.com>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <22d81c06-6ef8-dadb-5f1c-cd9461bb290d@gmx.de> (Johannes
	Schindelin's message of "Tue, 3 Feb 2026 08:12:47 +0100 (CET)")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
	<aWD2x154F5f-c3pL@pks.im>
	<aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
	<20260115211448.GF1053259@coredump.intra.peff.net>
	<aWlz-0AOlsFLaBO9@fruit.crustytoothpaste.net>
	<xmqqo6m6vdf8.fsf@gitster.g>
	<22d81c06-6ef8-dadb-5f1c-cd9461bb290d@gmx.de>
Date: Tue, 03 Feb 2026 11:00:24 -0800
Message-ID: <xmqqo6m5sldj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Just this point, as I do not have time to deal with this topic right
now.

> The concern about Japanese ISO encodings colliding with control bytes is
> theoretical at best: sideband messages are prefixed with the ASCII string
> "remote: ", so any such encoding would already be broken today.

This is false.  

ISO/IEC 2022 is designed to allow mixing different encodings
(including ASCII), and it is a common practice to mix in a Japanese
string (or any of your choice) enclosed in a pair of "ESC $ B"
(note: 'B' is for Japanese, but other character encoding can be
specified in the same string by using a different letter here) and
"ESC ( B" to go back to ASCII.  So if you throw "remote: " at the
beginning, that comes out in ASCII.  The payload may have ISO/IEC
2022 encoded "foreign" letters, but again, they are closed with "ESC
( B" to switch back to ASCII, if you add random junk (like "..."
perhaps) after them in ASCII, your random junk will come out in
ASCII just fine.
