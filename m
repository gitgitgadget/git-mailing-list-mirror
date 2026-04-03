Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492529E117
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196152; cv=none; b=m8bGBOajHy2diFiegvu0ww598HiOgSw6P/X8qhL63D6SRyZoX5oTXxPWwaY31TJGfkTLOO1sxZ9vjWKa3Of5B0yYXfU1HFK2Pe7oAoadd1NxW+0EvmC1Hjg1fLlN47MWdqx7MMKtSLJVaO/uRERIoJYY0j81ZLUrc2OG71gH+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196152; c=relaxed/simple;
	bh=wyTHodZAEisKrnw7PiXoEsmhNp/CuGHTjmskqAb8rmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgBwbbBDqm7BmsgtoDFF14Phxda/c9L/x2s+GKv1TQrlLlVbWhoPD2VBnu/9EIzDDwQup0l7y5lFafLUnNy3BEJV734y9e3/xmmLSQ+hdtkxSV9uwScBM4SMT6Auyjz/OPN9EUsbPzySdIDMo4qMrl9BcWgiYoC1UqE0uanAv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MioAlxRy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L5ssVrCX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MioAlxRy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5ssVrCX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB73F7A00F1
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Apr 2026 02:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196142;
	 x=1775282542; bh=WN6BAYdZ8D+DmNiZ/QSKJo549Gyi+VfIH0W4V6LjIT8=; b=
	MioAlxRyav550vDMp5/+0yOh8HLDa0YNN3FqCI4HmSKsQFzhJ0rdwxuEo/s9wOoi
	KDfQpJrdtrxsxkTZt/uk58Iv8m/M5e+fT+NMyE2EyK8ZPBFIBt4woMfD9G4n7uAd
	xQkKIHWVmqJ6VBHJy22h4d7NaB2HlPvGCCnzAuRlvFfJnhd1PqD8/tNNeFhj5OGd
	PxPFcCLBmJrT9kMIyv+DjBV8DAtzlEfps8F65R9ZokB2njOJYjB2SduJBlls/9eX
	F7wdHNl510HFsvtJiYlTtXpxqjNtEzp/ckAXEae3JJMzyliYigA2cI8O2ZCta/IX
	y9cMnboajxOTVbv1Jog5yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196142; x=
	1775282542; bh=WN6BAYdZ8D+DmNiZ/QSKJo549Gyi+VfIH0W4V6LjIT8=; b=L
	5ssVrCXUZekpvxjok0Sl/vjv4cTV3TxLuLwqrMniG6w3jCajCwC/0udSfVP5NGLA
	bWE8+x1X99rcbVIjbDJYEljEx+GsLfNyXzqyITBPs8hKL78zRydI2Iv3AX0tmhe6
	6Otc4Xx05gQuaT64jfALD+TISGhM3m96ub3GnKR0Zc6ASs+NRCuJbVs94vNJglgW
	QaLNzhMTYywbRRlBZyW/mQK2XTdC+BnBQ+JABVwgPyMRFnrIMjL/2gc1Yxg4G/FH
	vdiOw4UKqqL+QxIgzISJwWyuIgo4S4szE1tEKTwPaofZULG6zXU6yezeN1qWl8KW
	o/PxggwrNG5CmuV+Q5dMA==
X-ME-Sender: <xms:7lfPab3-GS7oQ4tcgf0NHlzvF8jVLeANOHBvkbnRMZ3Wao5RrGHCkQ>
    <xme:7lfPaRBZy17qSYQbDpSJoKRWHsoXuyPVYBf4HeSfXxF6Ftxxuxchd9nhBjZ33yh85
    26RRECsUS6WdlwN_wYMxqIVYR1ydeXbN7ruN4E6TNRFZLDOM7NTtA>
X-ME-Received: <xmr:7lfPaRi3e4Vzs5CP2k9FnDoZ5qplnAeO1uCrHSX98ycGCb-HwNTbr2W-EONaM973yr6_Fa7hO7gVe61JsI1b_AWOq9bSINaMz_QoRHdCnpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:7lfPaV8Gwv7Sy1OWJM2GjIOjiJFDDZebwRFjHxjs13tiiplTiTs-Rw>
    <xmx:7lfPad8FD63s9cqV8XDW3bBHcm3GxohaTajAX7Qxcl3jS2tMNvCs3g>
    <xmx:7lfPaeDG6rtLFgXkXk-eCvTv0ZvRRcawDj8FLWWeKLAoPcgF3r0XNg>
    <xmx:7lfPadz2IpftkdUgjr27osMtFyO0q11MGzsCgN7a4-Gq6Zx6pWhUFA>
    <xmx:7lfPaZGrUBjGHD_xBmdie-9tjGOulMEcqsK-KB9lvsCGK6OCNGnd8yCK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76403e30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:50 +0200
Subject: [PATCH 03/16] odb: fix unnecessary call to `find_cached_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-3-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

The function `odb_pretend_object()` writes an object into the in-memory
object database source. The effect of this is that the object will now
become readable, but it won't ever be persisted to disk.

Before storing the object, we first verify whether the object already
exists. This is done by calling `odb_has_object()` to check all sources,
followed by `find_cached_object()` to check whether we have already
stored the object in our in-memory source.

This is unnecessary though, as `odb_has_object()` already checks the
in-memory source transitively via:

  - `odb_has_object()`
  - `odb_read_object_info_extended()`
  - `do_oid_object_info_extended()`
  - `find_cached_object()`

Drop the explicit call to `find_cached_object()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/odb.c b/odb.c
index d321242353..21cdedc31c 100644
--- a/odb.c
+++ b/odb.c
@@ -774,8 +774,7 @@ int odb_pretend_object(struct object_database *odb,
 	char *co_buf;
 
 	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
-	if (odb_has_object(odb, oid, 0) ||
-	    find_cached_object(odb, oid))
+	if (odb_has_object(odb, oid, 0))
 		return 0;
 
 	ALLOC_GROW(odb->inmemory_objects->objects,

-- 
2.53.0.1323.g189a785ab5.dirty

