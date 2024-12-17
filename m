Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8B17BEA2
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465839; cv=none; b=YREaxnrup9tPa3QmTHt9JbsCNlWDch/7j0oamtqk0Vd1elvXklOduxx4+e4wzHctHuFIHzcK8GG2e+kPwb/HO872qNW4DJlQBvaGhOVh3hL5T/ze5w5Pt5iX4UY3y25ocd/z0wQb5SgKM8CpI3gC57vS91FFz+0xBGaZe5mwIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465839; c=relaxed/simple;
	bh=731oHNGxt/pME4wwKYnj6ENay1rOsacV74coSskhFgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SPXeu5xO8CiDZ31ytShLHt+VDeqIpOL8O8L10Jphf8OgegaprQV+Rk0IobKwfRA9K7wiFqZoA5dK6yEVjc0HWsJ0AzBxbxtHnPh9/MMJJEymgVbP7736zbYYIbnrrXrpveGyyyvilAv7moMu/ySot9rCJTMBDNv5Wzx0riFtuHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kVTabZz0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IfnPh1+t; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kVTabZz0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IfnPh1+t"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B8D981140107;
	Tue, 17 Dec 2024 15:03:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 17 Dec 2024 15:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734465836; x=1734552236; bh=VP3kKoGKze
	bfi0vO9b+haEYhoynJcK6sf07q7OKyGeg=; b=kVTabZz09huPCrIdTrPH/SljOy
	jIdVcBWEAtm+IIvRYL8V6yyDbDJLuodvOD/tPptbLdbjAt7N1cpvME9/BAHWOwv0
	twFUqTMqSSana8WWt7VTH48WiZbRkYAiDdnluKzQTVCZUKpHphe0LOyyDt7kvE4s
	mTPq1PW3SMxXJxv9yWy+YjB6zowoqmmQ2DRyW8fT5CRlJabJH4OwvVnPzFeRWN12
	fAw44wOhASJwS+berEVkXxxp0IzByWCnscHqRuZ5Q4RkZoG3/2HKKLgV6VQnev/3
	9JlqvqWy3Gul6Apn+37i9QMlhwpizAnwM1sy4VwkRbOKBl89zFAyJSexTlfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734465836; x=1734552236; bh=VP3kKoGKzebfi0vO9b+haEYhoynJcK6sf07
	q7OKyGeg=; b=IfnPh1+ttxDC4fbTrXqQZeBtggUKgptTZNf781FHiuA0pPBZkfq
	DwUWEnCm4rTxCH7PM+u1jHot8cWZ3qoaK/u9+ko8hJM/Ad95YvrXKwxVnQFk936F
	d1sTAgRhmzKzhS/cjLfBW4hRGQPfetjuHtHZnxNGPSxEwbOzQzEzZnHFIORjspHV
	CLgvUE46zqc1E5svQi+U1E2BLTIAsxW8T6l2BnQBUbpPi+OOKSDnBU95CRcRm0Pq
	ieevrJjXIFVT/vFd1Ff8T3wrYpHa2iJ+mFGvuOEccZZfYlO7mnH1A0/szpBV2/bf
	/7RyB3O/uczGwCW8eA0rNkOOCiRS2aJ84Rg==
X-ME-Sender: <xms:LNlhZ3URRNtmhvhdYCg9I1m8D86RQmvUmasSE_KOZVL7QlxoH2VqOQ>
    <xme:LNlhZ_mofFnCDKBgSF_6rJ98DCElbTLvBfUcz6pA5-57bL5goY91aG3jAEsvG9zsr
    bK7CYxXEwxTZAbzBw>
X-ME-Received: <xmr:LNlhZzYA0MTdBDrCGjnY7BdVcxX1-6l1pEpxpXBw_C8de_Cf_H9RgzkFCUgGQHZ5swq_UdyumuNRgVn_hrbji5uT1hyaSTa6dAJo6jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtqdhfohhrqdifihhnughofihssehgohhoghhlvghgrhhouh
    hpshdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithdqphgrtghkrghgvghrshesghhoohhglhgvghhrohhuphhsrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LNlhZyUHbPe-Sx4U4Hir5XogfdAAReqOE710Tq8v06CwG6RV4hMKDg>
    <xmx:LNlhZxkNyk_DngkyG3FTCs4h1NNLZnjbttLr-DvXu0M6PE-118f51w>
    <xmx:LNlhZ_elvsLpI4_rtWjfTpOqXThkyv-eQbx9LBcNSxuutb-5Nb66Pw>
    <xmx:LNlhZ7ElmtgdUikU034za8FUgqZEaNg7Yj9MoAhR2mD7__vk_VGmdA>
    <xmx:LNlhZ0vfKsNIelo9kQdxwMU9k3dqliR99fKNUYXx5p9TnE-uG8CixOWt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 15:03:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git-for-windows@googlegroups.com,  git@vger.kernel.org,
  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.48.0-rc0
In-Reply-To: <1M5wPh-1tUOUB0QmJ-00HLAH@mail.gmx.net> (Johannes Schindelin's
	message of "Tue, 17 Dec 2024 13:48:19 +0100 (CET)")
References: <1M5wPh-1tUOUB0QmJ-00HLAH@mail.gmx.net>
Date: Tue, 17 Dec 2024 12:03:54 -0800
Message-ID: <xmqq34im13h1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.48.0-rc0 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.48.0-rc0.windows.1
>
> Changes since Git for Windows v2.47.1 (November 25th 2024)
>
> New Features
>
>   * Comes with Git v2.48.0-rc0.
>   * Comes with cURL v8.11.1.
>
> Bug Fixes
>
>   * The installer now correctly blocks the installation on Windows 7
>     and Windows 8 as these versions of Windows are no longer supported
>     since Git for Windows v2.47.0
>
> Git-2.48.0-rc0-64-bit.exe | 553815da6a9652516a3162bf4bea4b60e13bfc3da710af60c034ee673bc92e93
> Git-2.48.0-rc0-32-bit.exe | be45795f4deca6e6bc68c75bbc891b46b890347d53738d26ebde276a487f8bb3
> PortableGit-2.48.0-rc0-64-bit.7z.exe | a94687e8d822b50f9ffcaed49d9e1a4836c50447ea8ce3fecc556214536473b0
> PortableGit-2.48.0-rc0-32-bit.7z.exe | 4c8f62b2738326b7ec1db4a4c2c899792cdff6e48da6bea94ef24f0ed21ba5ef
> MinGit-2.48.0-rc0-64-bit.zip | 981516b24ad7a83f44c6e7dd20ef70f60ef1f1e97772a1ecc9cd7ff7287c4cf9
> MinGit-2.48.0-rc0-32-bit.zip | 63d86253c3654bb2310e71d6376dd8b986254b94c3c8e91add62548faba45e34
> MinGit-2.48.0-rc0-busybox-64-bit.zip | f1bc9a83f59907690c954dc429ede14dae8ede7f0602628a5f0c34878c54d0ce
> MinGit-2.48.0-rc0-busybox-32-bit.zip | bb2a3f6dbe5330aa1cf51c34387ede08f1ebf8035b30135f9316469c2d230565
> Git-2.48.0-rc0-64-bit.tar.bz2 | 0459027325f1bb353ced02bfde2f007e6e5c7dc61d7ebc9205eea4a033a3c99d
> Git-2.48.0-rc0-32-bit.tar.bz2 | 8abcc6c10767b6031d2171ef1288f9a79f1974424245e73b17867c13b409a26f
> Git-2.48.0-rc0-arm64.tar.bz2 | 3d5ad1d678e273451358553c69a33b0d49696314a397a61b7ea164c79dd3455b
> Git-2.48.0-rc0-arm64.exe | 5e7eec6217fd4f2612d6a745073044d4a49fdc730273885a996fbd86cc496b4d
> MinGit-2.48.0-rc0-arm64.zip | 11b64e06c885a3a10c566649578e7897275f67c30aa6f4c8321469febd2d8fb9
> PortableGit-2.48.0-rc0-arm64.7z.exe | 291f12d7c0acf59a22f939ffad8b2f3559f96b9780161d60ee92d5d4f3c8a044
>
> Ciao,
> Johannes

Thanks, Dscho.


