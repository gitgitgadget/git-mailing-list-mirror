Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8F2E9735
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762000; cv=none; b=NbihPYMq0uIHONogIqZPtw0EylR9QVnB02HgtakO25XEWMMNCt093ZyRKSwLTNymPKQOSbFdg1fOuxVCgU/2Ns7CdGwJ1hQuVPDQQ8NdvuOtGGkaF7JDbwOp6U6r47z6IQPSmK9ISCWclgzxeTncoFijcVHewRqULI/agSiVBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762000; c=relaxed/simple;
	bh=MwumWMFqxPPkb0BT2rrs3n0DhB97s6ASIRIL7I40MPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Im4KXJQts43cXUbdcAQRD+bgUxsbc5dsSGnt8cTEBGkaboEL1HPGgbgQV6D1biu5pZp0UhPWqiwLAbUU3ZPDtJc1Xte8BWtkpWxa49vRiCxcH+7na6jsQO80SIamP0ESQFrYdLa/4Z5kU0Z3cSBQTWmU0L/j7MotsD4ihg4WJgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a1aIVyQC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HgagHuZ0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a1aIVyQC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HgagHuZ0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 246D7EC0143;
	Thu, 21 Aug 2025 03:39:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 21 Aug 2025 03:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761998;
	 x=1755848398; bh=fq9d70Y1WFKEVqb2XaSjqzCtA9sO/2e5awcuXgDzO4Q=; b=
	a1aIVyQCkGYUxZ3t1Eo6xHMbhjvZxFHklilECx6aXbA2SIEwn7XReWBoPuv2H1tq
	+rmuI+ker9RSAOoAblJU5yBnxdSRD2ixieIOELAIzEpM2Qy1rmq7+lKwcA47etVF
	gg4WHh5CfvQZXLxWcP4Azsp6oLuTYrsQ4V/X1SchMJJ1meOotfUTbiKHMEnlEJaq
	qiUwLTwRHYEbwMbSwC4tCPKIJKpFnSQkYK38iFiXPXp9oWnfaErsmv9pT6OAgqjR
	r4O1HYwpSdEMEL/XPS7pgnpNOkSomnW9MbjTfXeFU3dGHjCitmlEe+bLtJGwrFkU
	wk22xfH8OsBV5Hb4KDbx7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761998; x=
	1755848398; bh=fq9d70Y1WFKEVqb2XaSjqzCtA9sO/2e5awcuXgDzO4Q=; b=H
	gagHuZ0FxLS43x6F6aMPJKz9uDiMjBiQJMOQA8zsmT1xoaWgef0ecLsxeytF+sJ1
	jjDMdyfoAPsmRweVsopuB68oupPYf4OKSUqGIfFNhJU3bLgxrI9b6RR/b8JcoVOd
	JRuU4lUnXwFodGJgIUZcmf6ktQU7nGKt0hfDcfqIacNH+tXZ+M8MwN5Y5ZX2MbDk
	qVCs+oZa/mVGwOKhQHunOt9JHEgacBa0o6oXh1hzqoWFK6lrTpmwxdWdCz+tqWDC
	qFOFU1Mu0gvy42eRoVqGJCjHj5x0mAzdGHPH1d5Y4zq1wGoBtf5oWZ3Brx/QbMCp
	S5s4hJbqOaMW1DODVygOw==
X-ME-Sender: <xms:Ts2maK3ANOSVHD_LttT00Ca_HyPgXZjXcaqOB57c-101xKnEv9kRUg>
    <xme:Ts2maAWAi2nNeRCudYdDj6bNvYqbjToReuteDHu-Ogrt397HJRfS2M7kws_j5aEu0
    szv9ymBRqLWswtlPg>
X-ME-Received: <xmr:Ts2maMWD0IiwppIDsyupPpDIeuZoqwtwb4x21ytohJ3Y4A1xfiLHFdKDm3wUQAHIYKfEHYk6YC7aTpka8mAMYoBsuQxKkTkDRdPQ02Ybdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:Ts2maHeUKFGZ4gLgZ15hMCBJ7fPXvzfbv6udITXarTt6sRQJC0N_Qw>
    <xmx:Ts2maNWh7x2rQNKDUNfY6ivKiNmNVmaeHVp2PILuMpsDd017aOumfA>
    <xmx:Ts2maIdPnF7IIcPm1AUHEHM14-piwpBM0jHNe0wAjIoMN948B1LJWg>
    <xmx:Ts2maBPno30V2OtwtYcuZMCS0kgxMBRAgwE57vMPxRhLl0PokeRWsw>
    <xmx:Ts2maO8f_qcC-2kIB-AVPo7F7u-_E4p7wJD4npcE6Pxs96i_K_ynD9YO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 839ff07b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:14 +0200
Subject: [PATCH v2 16/16] packfile: refactor `get_packed_git_mru()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-16-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

The `get_packed_git_mru()` function prepares the packfile store and then
returns its packfiles in most-recently-used order. Refactor it to accept
a packfile store instead of a repository to clarify its scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 4 ++--
 packfile.c             | 6 +++---
 packfile.h             | 7 +++++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1c24b84510..4e75f14df1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1748,12 +1748,12 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		}
 	}
 
-	list_for_each(pos, get_packed_git_mru(the_repository)) {
+	list_for_each(pos, packfile_store_get_packs_mru(the_repository->objects->packfiles)) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 		if (!exclude && want > 0)
 			list_move(&p->mru,
-				  get_packed_git_mru(the_repository));
+				  packfile_store_get_packs_mru(the_repository->objects->packfiles));
 		if (want != -1)
 			return want;
 	}
diff --git a/packfile.c b/packfile.c
index 19227ea0b3..8451467daf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1044,10 +1044,10 @@ struct packed_git *packfile_store_get_packs(struct packfile_store *store)
 	return store->packs;
 }
 
-struct list_head *get_packed_git_mru(struct repository *r)
+struct list_head *packfile_store_get_packs_mru(struct packfile_store *store)
 {
-	packfile_store_prepare(r->objects->packfiles);
-	return &r->objects->packfiles->mru;
+	packfile_store_prepare(store);
+	return &store->mru;
 }
 
 /*
diff --git a/packfile.h b/packfile.h
index 86ab70eef9..b87fa2df59 100644
--- a/packfile.h
+++ b/packfile.h
@@ -133,6 +133,11 @@ void packfile_store_add_pack(struct packfile_store *store,
  */
 struct packed_git *packfile_store_get_packs(struct packfile_store *store);
 
+/*
+ * Get all packs in most-recently-used order.
+ */
+struct list_head *packfile_store_get_packs_mru(struct packfile_store *store);
+
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a
@@ -217,8 +222,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-struct list_head *get_packed_git_mru(struct repository *r);
-
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
  * for speed.

-- 
2.51.0.261.g7ce5a0a67e.dirty

