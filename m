Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33923218D2
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622679; cv=none; b=ecfjZsJLTXu9lwOyaza0JcIybqg1V41g8oen0u+r1pK6JHx2htTQgmPFFivuPYjFisNXn44TxneZru2+uZRGZbCCXRtRV3X7kZO1odEj0NXyyynZhYxZsw+MHcEj0vNkBdc20XJrDJNejIw1dKbxBijFTISJZFC5VX1rvuyfWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622679; c=relaxed/simple;
	bh=szCMnRNexz5L0O171gfIVlX6irvSRRf6kL1/SvQppn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6bsHumjFhDBZEixzsWGp2aS0MFjUmq3QSQF72Ux0kIco5BGmam+/E5gW6HPD+qCfvOGrC8pMdi6ia8BKB2c0X5cDpO1OeWgNaKaJ+yQbktjZljQjXThDuUZwljVxKHmRoLbt6OlTjzL3UYqWP57BHOS/HsEboYQEWpAZ+G86p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C9KXTS/G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZveBEzX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C9KXTS/G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZveBEzX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0501D1D00260;
	Tue, 23 Sep 2025 06:17:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 06:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622676;
	 x=1758709076; bh=+YGa+tFALUDDxEx/jLjbSsYR6kOgvYwOE7Ve1AeWp+I=; b=
	C9KXTS/G81/1bstltYXW7MDKaL7Y4w/U7wRomeDo1qfHMDzJ4cda3aFRzaA2+EkU
	OvibR/YRZppPfrLisJHn8h+bSrL6HSxTWhLb/bIMWC+oYpAtgT/3fsWtyftjNDqC
	/VTg3SU0pvhSPOsVFL5aOJW7mOvtns+QCFaWzu9pKJB2qz7JsbjMJWerNYfrmTcP
	TZMREgAJlhY6rTPx7wlCKn4chQiykdF+n0AQ5Dbrmo2WP8b8YIGXbUJHIPbUg989
	1TisQ/YSnprnb+F4F0JlCpdMvh6Z/1JjYg5oFmaqP8j+D0EsD6/N6fpeGDfoXGV3
	3PKgMJHBQaZWa99x5o1a+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622676; x=
	1758709076; bh=+YGa+tFALUDDxEx/jLjbSsYR6kOgvYwOE7Ve1AeWp+I=; b=E
	ZveBEzXfsrX4rdkeoDWRoUFfmgC7GbUSKgQT0mYYhvH7vmvI2IGgazWP4OjTa1c+
	ofP08AAX9OzshLTFSsI8oonuWOmS5mEOi4pTaLQDv5qwuXf3rQU+V/H10aZI2Wsl
	76T+eYi2hr1K8TnZR2PU60YK9jpqMbQROaxjaCcH1Vju+npH0mCNS4VElKMDW/kY
	upOHDU1qfi9kYLzuq4vzm8gdC583M7y8Lal65zMYh4FvlD9w6tLye1eIRbL0x/FO
	UPeI4RCl4O071aVMgFYWQjs5dP0HkfdDjP9NiQlszeAnj27T3EKGyPYzhViFj0Pm
	/TTK6oOGS+hG93xELR/ww==
X-ME-Sender: <xms:1HPSaGSWkBBL2DxrY3e5HX-JCLjHI1yaWAU9-5li2KTTEeHsuXmPLQ>
    <xme:1HPSaEM7oZnz4XWy96IhHE-fHfRvBA-HfUo_-cFojYAgw6Hi-rgyy8YMltGDWd51B
    zKPYKtqp_oZRn15ohcjwdRGm2NBQHY03p33gtf3bh6h-T_Y2OVf>
X-ME-Received: <xmr:1HPSaETdleTLoXdp61yHVOdLEt6mT4iHfMK9vCj6IUb_p3X-3qcSr4b9zWRW2Dazk4JbKZ5TKWvRGgW0byOzIX_T_s_FEvgDDJlFLCuGnlbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomh
X-ME-Proxy: <xmx:1HPSaCgdwFEDkIuIWWhy7SBuHHxeAKdrQHfXco_I0zYnnlD6f8inLg>
    <xmx:1HPSaN94DoleggiVD62RQlEddbNeNaENJDhs1BpQ3QlBVonS2mSOdw>
    <xmx:1HPSaJFHXjkMOgSp0np_HsgmWHs03rCmoWXEn61jC3FPbe4a0PHSkA>
    <xmx:1HPSaAnD6td5Ypd-EFfbvDDu_Iwd3D9y523BpKwWSH3en_-dZoo6fQ>
    <xmx:1HPSaMpQLgXKzkCGam_E9v4jjtfKBb3mF_90uR_NZSEJRWpfI9bOigO->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4408547 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:14 +0200
Subject: [PATCH v6 15/15] packfile: refactor `get_packed_git_mru()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-15-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
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
index de351b757a..61bbbdfb83 100644
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
index cd5431b6aa..5a7caec292 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1048,10 +1048,10 @@ struct packed_git *packfile_store_get_all_packs(struct packfile_store *store)
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
index 1afb9cd664..e7a5792b6c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -148,6 +148,11 @@ struct packed_git *packfile_store_get_packs(struct packfile_store *store);
  */
 struct packed_git *packfile_store_get_all_packs(struct packfile_store *store);
 
+/*
+ * Get all packs in most-recently-used order.
+ */
+struct list_head *packfile_store_get_packs_mru(struct packfile_store *store);
+
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a
@@ -232,8 +237,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-struct list_head *get_packed_git_mru(struct repository *r);
-
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
  * for speed.

-- 
2.51.0.536.g15c5d4f767.dirty

