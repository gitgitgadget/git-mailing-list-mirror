Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A402570
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730043560; cv=none; b=OG44ZIhNiORuBafomMjnmjhCF5lfeq6sDnnJjREJ8KTN3T3zvSrPXTgHnakkMfXb5p6SiIIEu24zsfERQYnCSboD0rlnpJDbkBmxrkJLf4qWoJgUoHE0jYVpgE9GIjNw64cFnPzASd3+g2ZsQ5EPN8GhmCsPnYyVn82toJ3xefs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730043560; c=relaxed/simple;
	bh=YqXW1DFZbq/8XaUQc83doprlyCXcqO0C2mKsYzs3Fh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjeRlzMyvNjCkDlk0ows4xYDgcD+8yXihtd3BLXYf0qa1ME/FjBu9fNrl2jcpparhewCMp7FtyPtVsy/hdt+LNIGTdBO54TrPG6lupLKdBn6Q6PLEe5i6recDJKoaZHXmfL6GVdcID5DAq7o/OelvYALtRJYyuEYn3vuATvLoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fXOwiBvj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VAPy/xst; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fXOwiBvj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VAPy/xst"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 625E425400D7;
	Sun, 27 Oct 2024 11:39:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 27 Oct 2024 11:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730043557; x=1730129957; bh=MTRkXvw6t0
	FSqOMZZJW27DpDqfh6nWVWSPW17/JpGEk=; b=fXOwiBvjWEZy4OPZsKDj9AGpqg
	RtVSJ8nQ+CvVNoMn+DGeGtnF22TEQTzw5m6UQDn2bxs6QQwp3uIKPv7IoAMBlW03
	LKzPSm/J8wNfc5vGI5R4R+cE7bhOY4czaV1rYHdaD9AF3QYzfIH/weF8+FGHzlJa
	gSDy5rTlcXM25j4IEvjrmKVcWeUrZiXFhlKQE2G6+vMLL2YJncVnpN3BeM26ja71
	3vaZJQpRHJOiTOSP8roryXg3zToNzKTk2wpsX5UcMQpZwnM9szsiLaAfrA5iUzwO
	nGG6oTmDykXqXcv6Q9dA1fxlgxZ8R9v4ljE1umBoTpb9kYbIH5iTgr/yLEMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730043557; x=1730129957; bh=MTRkXvw6t0FSqOMZZJW27DpDqfh6
	nWVWSPW17/JpGEk=; b=VAPy/xstPTQIIDUtahFL0EsGr+O13RAWxH+cW/Jdbe2y
	uyKCH+7exsgQ6WoVEFG2ZHyFMcEzR0Dsqarvc/XK80mlOiRNqJ3AybAMQTYxuBac
	7Jop5SGSzQHBhes5hdcDIJyZazjSLdHNX6I2xVOgyYBrG02hG8/UEu0KO0mJv+Pn
	9OgOXsS9YXjZTa0veVeu4BxqS7g5bcs2e7/RYmGma+fxJrceBYjCFe/wHLHgzj6s
	DlQMTL6Iw9McjJo64pQqih+p6FFRzPi22DHbDRj/dfOhmJ1NJs7RntNjR/t7PJXp
	ineFw3cxMZHY7Y7J0x8KAfcBXslNVl8CEjPXbWhNYw==
X-ME-Sender: <xms:pV4eZyXMX2y8ACnq4cauuyNxD4i95Errf2dai5TxiVJgMVyFU7ywCQ>
    <xme:pV4eZ-lFRcZCtn0ri95kbtE-Rl-igPNg3Mmv3jTYDUMLmosejjP83gZfR_DIIHsa_
    3BZUuBNfVlkSD3Q8w>
X-ME-Received: <xmr:pV4eZ2ZyeiCdl2n814HBUv8hZIpF56TTRWh-2SqUOifolX7oJsagFZ5tN0WjK2Sozg15X9yoST8g1777ENxkPnc2UqJsbkQu4ubMe0Vkg_t0uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthho
    pehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pV4eZ5XF1QXhzVsQ8k5jKR1DLRwjYwAUQRwYedaDGYQ1PV3XUSrccg>
    <xmx:pV4eZ8nCKCPh__CnWha_7u5gCIGcuAj6ejhQlzVGgoATs9o56cMC-g>
    <xmx:pV4eZ-chjvdtONACevvMTUwrkfffPjsvOrttZRQulBesscC5JIaCsw>
    <xmx:pV4eZ-GKix9iDCHxx1WKOen2ZqY8BByLhdrzPB59KBGDxxZddOScPQ>
    <xmx:pV4eZ7tSo5ggWPE3afl30r1C-li7Hp381xJutWKyIRaPZN4xIrB2Hxup>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 11:39:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5054d85f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 27 Oct 2024 15:39:11 +0000 (UTC)
Date: Sun, 27 Oct 2024 16:39:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 1/3] compat/mingw: share file handles created via
 `CreateFileW()`
Message-ID: <63c2cfa87a4a3c44367acdc1f7cdb57289b4b761.1730042775.git.ps@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <cover.1730042775.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730042775.git.ps@pks.im>
X-TUID: eEfurap1rNPL

Unless told otherwise, Windows will keep other processes from reading,
writing and deleting files when one has an open handle that was created
via `CreateFileW()`. This behaviour can be altered via `FILE_SHARE_*`
flags:

  - `FILE_SHARE_READ` allows a concurrent process to open the file for
    reading.

  - `FILE_SHARE_WRITE` allows a concurrent process to open the file for
    writing.

  - `FILE_SHARE_DELETE` allows a concurrent process to delete the file
    or to replace it via an atomic rename.

This sharing mechanism is quite important in the context of Git, as we
assume POSIX semantics all over the place. But there are two callsites
where we don't pass all three of these flags:

  - We don't set `FILE_SHARE_DELETE` when creating a file for appending
    via `mingw_open_append()`. This makes it impossible to delete the
    file from another process or to replace it via an atomic rename. The
    function was introduced via d641097589 (mingw: enable atomic
    O_APPEND, 2018-08-13) and has been using `FILE_SHARE_READ |
    FILE_SHARE_WRITE` since the inception. There aren't any indicators
    that the omission of `FILE_SHARE_DELETE` was intentional.

  - We don't set any sharing flags in `mingw_utime()`, which changes the
    access and modification of a file. This makes it impossible to
    perform any kind of operation on this file at all from another
    process. While we only open the file for a short amount of time to
    update its timestamps, this still opens us up for a race condition
    with another process.

    `mingw_utime()` was originally implemented via `_wopen()`, which
    doesn't give you full control over the sharing mode. Instead, it
    calls `_wsopen()` with `_SH_DENYNO`, which ultimately translates to
    `FILE_SHARE_READ | FILE_SHARE_WRITE`. It was then refactored via
    090a3085bc (t/helper/test-chmtime: update mingw to support chmtime
    on directories, 2022-03-02) to use `CreateFileW()`, but we stopped
    setting any sharing flags at all, which seems like an unintentional
    side effect. By restoring `FILE_SHARE_READ | FILE_SHARE_WRITE` we
    thus fix this and get back the old behaviour of `_wopen()`.

    The fact that we didn't set the equivalent of `FILE_SHARE_DELETE`
    can be explained, as well: neither `_wopen()` nor `_wsopen()` allow
    you to do so. So overall, it doesn't seem intentional that we didn't
    allow deletions here, either.

Adapt both of these callsites to pass all three sharing flags.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/mingw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0e851ecae29..e326c6fcd2d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -502,7 +502,7 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	 * to append to the file.
 	 */
 	handle = CreateFileW(wfilename, FILE_APPEND_DATA,
-			FILE_SHARE_WRITE | FILE_SHARE_READ,
+			FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
 			NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
 	if (handle == INVALID_HANDLE_VALUE) {
 		DWORD err = GetLastError();
@@ -1006,7 +1006,7 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 
 	osfilehandle = CreateFileW(wfilename,
 				   FILE_WRITE_ATTRIBUTES,
-				   0 /*FileShare.None*/,
+				   FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
 				   NULL,
 				   OPEN_EXISTING,
 				   (attrs != INVALID_FILE_ATTRIBUTES &&
-- 
2.47.0.118.gfd3785337b.dirty

