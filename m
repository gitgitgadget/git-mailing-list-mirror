Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F4147C79
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770388; cv=none; b=iKxScxb3/4WxjFb3coQncNqXA0xABEbIzdBNkO7mAzT61LiB5MlzGH1ZijyT8VDGt4Xt1/gWybB0dVsm5/JrUZ67Cr554fYsoCO7ORud+CdJSJiCbCmxFSRmqPE9LAdDiiPlc3A5hytBvE3f38UT4kPcVgis6NJIyTUFJjoL40k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770388; c=relaxed/simple;
	bh=YqXW1DFZbq/8XaUQc83doprlyCXcqO0C2mKsYzs3Fh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/gD0HUy3P4Bc1U8BuiqqnlzW7YLAlYTa3JHX2hfz+yiJ+ZPASJlIyEWQ4ACkR1Uz9tz6p52a3GVnJwlKCyuLlS/LYHLqitnavk5XlO93Ea0+67bzfgE1L0gBUgwJNrD6Z1e0POhcG1QVRoUvsZXyK3IlKOu/VxK9Ori7yQLFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KiQ3ebxU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I5WyukWA; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KiQ3ebxU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I5WyukWA"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id E173A13800D4;
	Thu, 24 Oct 2024 07:46:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 24 Oct 2024 07:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729770384; x=1729856784; bh=MTRkXvw6t0
	FSqOMZZJW27DpDqfh6nWVWSPW17/JpGEk=; b=KiQ3ebxUegYFmy/p/E2B7YZDXh
	qwN4Y2+eMrlFnc4DBn6DBN4rmksuzVeKrH6mulW48AH1fMvwCeEs2uEGHqAKGr2t
	IbYHRPgKy+cU38l9ZTZF44v5G3ZdPSzepUjTdRg6rAJ2nUp5qscaZ1bE5MwSfYtV
	7MyZBGmB2N6YC2QAHgkeaZyKl5zmU1ocdfU3CIJGRAAJ8WS9xLEShPXgkJD+zV1j
	FMCZsx/ajbck1rubqSllOUrSe2i1SX+JBsOdq724HGCkmE1NfWgHlU8+M0n7fVI0
	oPQrMZxZVIPWHZEMqYx0ozL5ZB7G0S/bT9GP+WcYq98q6/GkDoVm6RArqBcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729770384; x=1729856784; bh=MTRkXvw6t0FSqOMZZJW27DpDqfh6
	nWVWSPW17/JpGEk=; b=I5WyukWAFg+Ld9I0q6B2GkmuxGpY7rPsO/DoyHULfKtW
	H/m3bqYVGkafbKS6+8ZZJQF9LDoDGHPIjfDGZx2jEnzzEbZg4NznkQZMA5sSmvYX
	Jyp8eaojo4qQpgeiwBObn6Y+hiZIax+HdvMGuQD2Y0P8aW6qAFrT8UJcUpWtRa1l
	YQGodLiNoe3AtFif39Oe5yLkfrWC08GnhgA2DWNcDCbJpgsQEwke2x8Zb0aQcx5g
	SueGA5x7cYBNG/ilmV9jDSE5MKKEHWYx/zj3sEvxP9xO4jFFABrbTRsmpyE7ChYl
	nJ3khsN5CrMeKI1/3OmreO43H5YPFVGSaTLNs+OWvg==
X-ME-Sender: <xms:kDMaZ_-W-4ts1rZOlKEV3BEGniW6lmjhl6GuM7dtXFitpQisF5UYHw>
    <xme:kDMaZ7uA0kDOmaNrgZpfTTag-ul2WF0sIjf-KbftpiZk0CPjiQEGMEpswllJBQoDR
    HEJgNgQmpMRxMuUIg>
X-ME-Received: <xmr:kDMaZ9ApDYdmM85XNP-mB8U21wmf4SXj5ydKgqo2HUIBNu-aBjaRovF89yME2GV6BMwKC9b4vVJdn8nI3FJuLQgabQfhwjasSK76f_TERg6yQlHP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:kDMaZ7cZz4Sbwv7pW4IlJJeW0iEHITqHXUWZATFbhEF9huoWgKniiQ>
    <xmx:kDMaZ0MhQEA-HyWxEPSSED_RMgTAv0kwOLktSInirEgzUK2FN9MRoA>
    <xmx:kDMaZ9n32j2TEuw7zAOeCQkfQKMEzvk4CBq6doZwfNP8h0yVryabiA>
    <xmx:kDMaZ-sOki2PTIWDlRzCisxToNXA5Q6q6U1R5VY7BSdS4XUCvj9EQw>
    <xmx:kDMaZxpwAAkug8b54xdJsYh7v2vRdPuqjoEFPe_VlavQe-srsz3OdSft>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 07:46:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fd86691b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 11:46:26 +0000 (UTC)
Date: Thu, 24 Oct 2024 13:46:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 1/3] compat/mingw: share file handles created via
 `CreateFileW()`
Message-ID: <63c2cfa87a4a3c44367acdc1f7cdb57289b4b761.1729770140.git.ps@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <cover.1729770140.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729770140.git.ps@pks.im>

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

