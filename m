Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881C24DFEB
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190432; cv=none; b=Hx9TcUGyp4Izkjro/jmPG9U86J9kPEKIhEfUBrvSFe4zREj9siN9tI781/wDFQFHQqMNVmBEbAK9ztShjfMEL6PhObXyxxjyqeNRNRzCZLLPuHxV0NUFFiLb7Fxl2qAMFhXDhrNhKoS/o6/htL9nlg1GBsmmcneSOCh1H2n9e3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190432; c=relaxed/simple;
	bh=Wm0KrmTCDTTij6ehMfxJACbqakkw4mfv6poQ25K6/dc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EQriZflxmk9zyQd4EE8xLblLV9xJjdCnW8l/VyU5EiBJAsAZnLcyL/mz0IBgPNqAcyPQU/WGZXq0Gr4inyhwDpMn/mNe37TDwA1cek/wS0WREJcwEBcubzcGvXXLajWBJAtCnOGCuIW3Ncm/A45aKAG+Vh04wqf9aTuuqI296Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g9Kk9SVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3eVkg58Z; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g9Kk9SVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3eVkg58Z"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9485B11401D4;
	Wed,  5 Mar 2025 11:00:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 05 Mar 2025 11:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741190429; x=1741276829; bh=0EhiMxzpsP
	/NHEDnYPzzvSUDo/I6Sx1TWJzt9KyxxUU=; b=g9Kk9SVRGJtZ7qwzfcwhjyvfhW
	oIzhlk0EFRt2OMXvfW/TCoKm1zknISM5wjms2A/GSTz/OfDfIU0Wt0uZ5h/iiO8j
	qGVj00xsluxB1iMedFIE7c5mG+PHLkqIuW++1DBVsR7axRtnU4Vu/9L621z3YiEd
	v/3PBx++DUAV1WI70netWCn/EkRlRLeMbWcTWuMifn2K2PzyPAq5SLk65d7iXhV7
	N+UNFq2XT5pxk6DQTTTcFbsNlG6es2IQpTYMe7MJ2npCixXouPujpzceMuAxQKBC
	LTf6bZLRHP/zCKX120MFaLcfoYkt5S35I4gclDZ4dkkdU4IGvd4COcXB9J1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741190429; x=1741276829; bh=0EhiMxzpsP/NHEDnYPzzvSUDo/I6Sx1TWJz
	t9KyxxUU=; b=3eVkg58Zqmh4jIaRnidAdwnroOXXaZvwYqw75uekRm8dqVenU11
	lhTHSmV0WTXDCVXPtl7paoxjL5JsnmakD1VY6L1caGn16wqk63UhtxS6K3OzFnqy
	/9hSBSHJntyCk3AgGjnFZvYf4sk34FauQZOrVI7Y9NiMhmysi23/u1lLkTxg9RrS
	TlWMhZ9l41VqByAM1NEIlbPAKs5tMwhlaxosOUeG+2PKh0kWgUzsaDQgspmDL6kL
	lRcAvOxI1rsvwzsd1YsD/lE7pd+x+4EcKUXpWAIv/LaYwEe9OeGf2SKqQ4MEHDxN
	kqAevRfEqhmoXvOHSrde0c2LaED46V8Lsiw==
X-ME-Sender: <xms:HXXIZymNNxJzeNM9dRtbP0L2N5ZB_bdSYYUkZjmRTWEVJOOGCw1Mhw>
    <xme:HXXIZ50MPKKqSBUUNVYJZiKSi7uMegq2fx-SFPwz2OYLAnpkcJ84jWqPef4nd4PBE
    8s73LhxWFtGRM7n5w>
X-ME-Received: <xmr:HXXIZwrFAsVI525x4GZscIv5zIEgokh0W_XnU4bmBw8hFf89ogLn0MwN7ABlGYLaCahp4el_AkOktQiAP7IKPh1_7X6v9Ge2LSKj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvgdprhgtphhtthhopehgihhtqdhfohhrqdifihhnughofihssehgohhoghhlvghgrh
    houhhpshdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithdqphgrtghkrghgvghrshesghhoohhglhgvghhrohhuphhsrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HXXIZ2lNUPXcyGhfiiQ5_nLWig_2VoIC23QBaAEwAZzG355yCR0-DQ>
    <xmx:HXXIZw0QzT84MN_vH16reYSjVT0A1y-ElNH6VZ17gmIOgoqhiRb60A>
    <xmx:HXXIZ9sfnvmXyF1NKBZZBUrFZ4w6HVJX7PSdW4vBjG6QVRGnCFZNfg>
    <xmx:HXXIZ8XjcxMzx_NYV7p0JZkhhgtbKK60MUQeaBAUK1hMExU6dJBhEw>
    <xmx:HXXIZ0-S0xOAhk0NOc_N0HLq-_-WYsYzIvnfmnJ5C5BjWMOGvglrLYFt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 11:00:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git-for-windows@googlegroups.com,  git@vger.kernel.org,
  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.49.0-rc1
In-Reply-To: <1MmDIo-1tPXph2dbU-00pKOM@mail.gmx.net> (Johannes Schindelin's
	message of "Wed, 5 Mar 2025 15:52:33 +0100 (CET)")
References: <1MmDIo-1tPXph2dbU-00pKOM@mail.gmx.net>
Date: Wed, 05 Mar 2025 08:00:27 -0800
Message-ID: <xmqqv7snlb6s.fsf@gitster.g>
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
> I hereby announce that Git for Windows 2.49.0-rc1 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.49.0-rc1.windows.1

Thanks, as always.

> Changes since Git for Windows v2.48.1 (February 13th 2025)
>
> Due to persistent maintenance challenges and the community's limited
> engagement and usage, git svn support in Git for Windows will be phased
> out over the next few months.
>
> Git for Windows v2.48.1 was the last version to ship with the i686
> ("32-bit") variant of the installer, portable Git and archive. Only
> 32-bit MinGit will be built for future versions, until April 2029.
>
> New Features
>
>   * Comes with Git v2.49.0-rc1.
>   * Comes with OpenSSH v9.9.P2.
>   * Comes with PCRE2 v10.45.
>   * The previously-experimental --full-name-hash option has been
>     accepted into upstream Git as --name-hash-version=2 and is no
>     longer experimental.
>   * The git backfill command has been accepted into upstream Git; Its
>     --batch-size=<n> option has been renamed to --min-batch-size=<n>,
>     though.
>
> Bug Fixes
>
>   * A change in upstream Git v2.48.0 broke renaming symlinks, which was
>     fixed.
>   * On a recent Insider Windows version, users experienced the message:
>     "Cygwin WARNING: Couldn't compute FAST_CWD pointer", which has been
>     fixed.
>   * A bug has been fixed that, when calling git add -p from VS Code's
>     internal terminal, after using the edit command, caused the
>     internal terminal got stuck and no further command was accepted.
>
> Git-2.49.0-rc1-64-bit.exe | 81bf3f20c85c0ca82de760da8ac28eec53523edfb24a7c71f925e1c1e11bbe40
> Git-2.49.0-rc1-arm64.exe | 1b527f8e80c10a09d561908fd8cbe8acefb47bd1f61da5048188808deed64183
> PortableGit-2.49.0-rc1-64-bit.7z.exe | b387c7ae0ce0eb751e5ca812fd47dddc8b53f0cc1148b4ba67b66071e5933f1d
> PortableGit-2.49.0-rc1-arm64.7z.exe | 80a7a186150ff22b695e54b20e55684f6c1a6abeaf2f32c9c256263a8901465d
> MinGit-2.49.0-rc1-64-bit.zip | bc0d31dcb8a04eb5b0645ef92f132c3e3b184817b3d840806c06accb51e47ef7
> MinGit-2.49.0-rc1-arm64.zip | c0244edc063ccb23aa425c88a591d2e90e6967725e168070ca64aea55e78ebb1
> MinGit-2.49.0-rc1-32-bit.zip | b7edc701e8b874bca635896e0e9653bf1be5f6098d7046120c9a1a9af2f7844f
> MinGit-2.49.0-rc1-busybox-64-bit.zip | dbeef21bf998c8094a936180251b51731040fccd0fa414c68a37b475b2ecebea
> MinGit-2.49.0-rc1-busybox-32-bit.zip | aa516fe9904c406c29d9f030e80bf17de08aae009124fffad0249afd669da756
> Git-2.49.0-rc1-64-bit.tar.bz2 | 65c1104bda7fa199829967a3f941c482721b983ffdb1132e76d2282a0e3f8c01
> Git-2.49.0-rc1-arm64.tar.bz2 | 528e9c6759f30367e2cac04231c141d7973240ed7212d521bd2495d25878736a
>
> Ciao,
> Johannes
