Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F943C04A
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953711; cv=none; b=neyam1/Xs98QhxvxbmSYgb3K21tQoFnGP39JTaxLg3yioE/P2qZeHGvYfj0UnAm7KCnz+u3cd7Vzoc7yFsdMGpzsJDcqt5IK9Ujc6M4rLJVZytfCpg9Gph5pUSAvoJLg3amm6RVAP1gJKTz8v2Kqf/wEyFZFrXnLaXtVtu3Ucd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953711; c=relaxed/simple;
	bh=8R66K1/TE++z8ILCCvO6jhrY1q+agYj6BrW+aW278/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1Ehon6YrgidjBwSj62rzNu0vUiEaAc+odWFFUm1hOrK1MEEMpqwghS9ttaIYOuL+fTGnqnH+Rh33Up/iJ+vGT5xVb1quwSi+EeYatJA9rYWTfzD3l+aSMHwd7h3Ya0bOnzdvyf/2B3P0AAgEnTGLYMaJx7DAbDM4p3owohoxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DOzQzpKl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jLMVTTni; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DOzQzpKl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jLMVTTni"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B132E7A0044;
	Mon, 13 Jul 2026 10:41:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jul 2026 10:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783953709;
	 x=1784040109; bh=jtZ7jI2EHv/ZagtKz8627HFFTRshb1j3HCEwZPP+G/U=; b=
	DOzQzpKleLpvXNPEwGMin6YURcD7jHDFWBZQeR6oXS2Ie+B8OH5rGj3eXHeVQIVd
	5E5Nrd3L5siAIhRxymN/CeZSncUBVeq+yoqrgExuZpeLUIYeMdHELKOBJIBT26j+
	epOn+cr6MTqOXd/hBwSdbwIyVh9fVfqvGJUhl5DihoonlPw7wC6akg4qR4HfoElN
	km5sK8PXNCiQxpYxeew9sE1psJ7NTh86qPBiuYYv4okVZB/6Y6q4u1TTe456fmcT
	yrrlpnrcZF03IABPYGdaHELBsomI1fBkJbg2rEd49+g1taNsLOiVke8fKtDstma9
	xOEfhXeEaUO3ZJaiomA4Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783953709; x=
	1784040109; bh=jtZ7jI2EHv/ZagtKz8627HFFTRshb1j3HCEwZPP+G/U=; b=j
	LMVTTni6eLU7jlS+7EQlxFb/zm1fzw/97U6+Os8NfcV+X5zcGg2xGQqISRjAkOIr
	O58H1t1NhCj9VVf611Z1hsM4TOuZvvV4rA6IGA36e38KizdNRXmJSy878YYabV4V
	LdsDHHPBaybiY9bp4GPjWYZ1B8TvhVKGLtorVR0ev47Pl4B6oJbR16ekcahPVUAJ
	aq19NVo5jATxjFvblL/bohJdC+k7c3J3b+dHSrDp9wSt1uGcu3iCiSlqcVNQSk19
	yTZr36u9KcOmDjB0svZrdFPC3ZxTdXz36wWC3yJon6I/PvIntSAcj6aAASx7HCAn
	FDdm+yuK6ZO6euriAIkow==
X-ME-Sender: <xms:LflUamVxe-idmysvDD9LmqsvgDOhzszOU_yqR-DtMox-KCZIV-ikLw>
    <xme:LflUapfsuB44OBxcInjvJrxxOTHEbPoyRU_TRxw1rit0rdyFtnH3sFCV7DrbP_Klb
    CnI-RGgv3DcvphBA5AcRbw5y4eHgWDwuzgr7XmwrypWfywUhP9fhg>
X-ME-Received: <xmr:LflUaiv5kumRibqDJT_tAbQ6xrBNrCUMRJ8w28xsDAFXmcLmzP95rhm8SCu1xt95MvSq6T7NcJeRnfZLBGT6KAtWdbh3N0UJgs2J67h5>
X-ME-Proxy-Cause: dmFkZTGn6tKk7yUEEDaQcAD5NnrbDs9+Jc2GaNrXe7GrrtJmjE5gyWDnOhf4+7nS4py03P
    l5qmkh0SoOOrRNpkdOuGZfY6MrMKnQb6IMuHenECYCDYu/4jQvITXA9up7o5myyDBe+LWR
    6PZ40ESf1kKbRkIcjld4t3oD6bOy3RvOFqAL0aM+pKPn2w3AazImWnEoJTT5R5DOm6qBem
    hAEZgHqwXRG8ZmkgXPpls7/ysIHqdYiJbLDhyMxIPircdziQ+x1RcJYaJxz9DUxteOKUAy
    HEhoWFbC8ZJDJPReOwdG0zIPqJ22iBIkcd1FNaKt4n0VoIFc+BvvsejFinEcl2wPoBhVHc
    XbSOJTZdFZlu9hzu0iv7Pp+MR6tMOEAnD/4kHrxKTGUmIMtVO4Y2hE9Vug6YKJwe50wDOc
    TIQ0qSiu+8SFmbhCIsTk64C+u5ryDMC7Wpcdr2f3DF90124SsJuIX22UyE0k3I9FkLlw5P
    TlZYUJBeIIRApAZgg2UxtCjpdMe6Obhc9s/hJdIxcZm8Vj85ytXAQnF78QHQLyk/mzr7UI
    UF2nhUUfdgADkvf7QBZQH3ufJSpvly+o0yhewn8OWTRiAaJL0pwx51In7yUgpkUIu1GTsv
    XQ/adINHVkM+yA4MkQ/tbaJxtX1ZOx4MwoHffXuJZ/LnX56RS0jsirwmYWJA
X-ME-Proxy: <xmx:LflUao_jtQKDy8SsYgc99qM62Nu2qA8CZaHvW76klCEvenMAOs_uzQ>
    <xmx:LflUat0azpCtLdEwB3RkTCuH92dgrfi8iZ_nTVzCkq45X2kU0GINBA>
    <xmx:LflUatBXnEEgWCWXos0sgZais_8-juxIzom_AVsaqIin25MKeybyQw>
    <xmx:LflUapeLbxBZGPvU_OQ-JX6vMZnW8EeArfTwy06dgd9BYxEJ5CP4jA>
    <xmx:LflUarTDhO34GpzuvxWtThLgTZC-VA4DQhbZuuaH1RomYGz59JN8aobN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 10:41:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e0e289f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 14:41:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 16:41:31 +0200
Subject: [PATCH v3 7/9] pack-bitmap: introduce function to open bitmap for
 a single source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pks-odb-for-each-object-filter-v3-7-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
X-Mailer: b4 0.15.2

The function `prepare_bitmap_git()` opens the first bitmap it can find
in any of the object sources connected to the repository. In a
subsequent commit, the "packed" object database backend will learn to
use bitmaps to answer object filters when enumerating objects. That
backend operates on a single object source though, so using a bitmap
that potentially belongs to a different source would be wrong:

  - The source would yield objects that are not part of the source
    itself.

  - The object source info would be attributed to the wrong source.

  - With multiple sources, each source would enumerate the same bitmap
    another time.

Introduce a new function `prepare_source_bitmap_git()` that only opens
bitmaps belonging to the given object source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 12 ++++++++++++
 pack-bitmap.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 72c8ae3228..09ba15d26b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -753,6 +753,18 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 	return NULL;
 }
 
+struct bitmap_index *prepare_bitmap_git_for_source(struct odb_source_packed *source)
+{
+	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
+
+	if (!open_bitmap_for_source(source, bitmap_git) &&
+	    !load_bitmap(source->base.odb->repo, bitmap_git, 0))
+		return bitmap_git;
+
+	free_bitmap_index(bitmap_git);
+	return NULL;
+}
+
 int bitmap_index_contains_pack(struct bitmap_index *bitmap, struct packed_git *pack)
 {
 	for (; bitmap; bitmap = bitmap->base) {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index ae8dc491ac..9f20fb6e56 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -9,6 +9,7 @@
 #include "string-list.h"
 
 struct commit;
+struct odb_source_packed;
 struct repository;
 struct rev_info;
 
@@ -68,6 +69,7 @@ struct bitmapped_pack {
 
 struct bitmap_index *prepare_bitmap_git(struct repository *r);
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx);
+struct bitmap_index *prepare_bitmap_git_for_source(struct odb_source_packed *source);
 
 /*
  * Given a bitmap index, determine whether it contains the pack either directly

-- 
2.55.0.313.g8d093f411d.dirty

