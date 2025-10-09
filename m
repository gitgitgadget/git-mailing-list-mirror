Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7FD2D7805
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996926; cv=none; b=cIopsrlVtqgkJLS/Y7SbHoRdxTQcg+NOIdIEJimDmHmMvS+9Nw+UtotdwaLt527yce/prv4MslHyytK9FPNzBS6j3JoEhnJd3+SUKOGzkB81dvXdj9h5AeglVbFyMx0RqLMPvLNCIfJ8p2pqolR7Mcnbe9oeXj8KMbd213ZskZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996926; c=relaxed/simple;
	bh=TSuNgbRJeWgoTNoutsrYrfnMLoWMPnRsB3Hoj85mUh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHmRAOiu2KkCpFW/glzb/N0i6Tjz91NlLRLds59oK55tas/xOZFZFMp5+cDNLxXoBfVG/R+vUzpiWcGHBzVmqTABaM14nqUNXZVnVTWXVK9ilmFs/NPh9C/DiZ/hQ0ko8taGi+3/utFXWreZTiB8miofB7UBZuVTlciCOs6VTIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rmSQSxsv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MP8VAZn9; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rmSQSxsv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MP8VAZn9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A4C481D00168;
	Thu,  9 Oct 2025 04:02:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Oct 2025 04:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759996923;
	 x=1760083323; bh=9n8puzOQ8ctXdKmSFSsnwYmZtVG9EmgdiUe7Usv3wXA=; b=
	rmSQSxsv+ShkqAmX+d8rLbveOVUSVKq9p8OupkPIncIWj0Qm5zAv+7q8LbUIza3s
	0w8BAjg27UNydXb0NTd+9e1LjlGlfH9nWaSozbKqo+60dOW/SVOCCwnF+vAu6W3y
	VvFdodEE0MKCvVc7h3q2BxgQ2SHCO+81o42sljY2S+shAzfOcgtD1HiuqlzJAADu
	eS59hV+37DOOI2Bm8idqlKCa4CNKotu/vvJwq83544ZHS0u/KudPMLVRrYE12ely
	8D9Yq/mPsm4UsMZ10CKQebN29MJXrjYEjPPQv44QlJZiUUeydltVOmeMUdOCrbcc
	a33SKYxy3U69vnFuUgD6Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759996923; x=
	1760083323; bh=9n8puzOQ8ctXdKmSFSsnwYmZtVG9EmgdiUe7Usv3wXA=; b=M
	P8VAZn9DqyfRWinvZ36D42+eAc+63aG7Ppl02UWy3wVuu+R3c6RUh76zTI2GGj0l
	YB1kCAdPS00CBhuePetHRP9vGtlpTaukCn9xlDL26xtOpyb+voB+UZTFm+EVVlHa
	gHf9Vb9NYOBnh39IkEreLWAevRL07Flpj2fzsiHABFxIp1gxNmbq7osC2b1srkdb
	I8N0PWUDzCBs+l6vdKAVlu/SymOPh5FgrEBHLI4hp75ZFnjIIFz8SqAKXEX4q2Do
	5n1vc/LBCjWy2zFjd36OeY90Ta3R/oXhK7y3dw6bz62QSQN5nm41vjSCrn0PZb7v
	9xgagjFwampJdUlul8HIQ==
X-ME-Sender: <xms:-2vnaLra9EpSrgxyCxcyC_Wr8aQt95vhL9g1t6FJsifv19dcK7Zr1Q>
    <xme:-2vnaLrcz64R-HClBIV7WLQohanpdUyZMvWxQ_p5jwruB8R9NrJ7qS375-V28bjcj
    z5_1DdqycX7zLzKTbEOJsDlJTetxbxDsR6TLjLQclIKBbACBrvUtQ>
X-ME-Received: <xmr:-2vnaF0NkSpMrhGV7kd4lhOXZBojSTYdoKjyHklKTLzVSFDU4qfg6pefODLp1SIJe_3-AlUZXFRI3ZLtUnbDeojFmq67UzsOc8hMEoAkILI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:-2vnaKCHWpF-U9a7V_91vXozAfFawYB5PCOAiP7dQqQ3za9Heaen2w>
    <xmx:-2vnaNf8q-oYWWsY7c-0NhI1quAUAxwX7d7kl_AcDIZFON40fWVj6A>
    <xmx:-2vnaPi8L5aZA1ivRH4lkUY6-LSaHOGf4FlDSxfhjbBOzVZRP3iXVQ>
    <xmx:-2vnaFr4TvYvqi6iHg0ejkSSc2W_KRBz50HWn9LrKCEc6uzrpP1JMQ>
    <xmx:-2vnaEykL6976j33DTKr-ClRR2_3T61Y0MHUV7P_9b3GWF4gUs4RTvub>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 04:02:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64d4082d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 08:02:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Oct 2025 10:01:40 +0200
Subject: [PATCH v2 6/6] packfile: rename `packfile_store_get_all_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-pks-packfiles-convert-get-all-v2-6-0d73b87ce711@pks.im>
References: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
In-Reply-To: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

In a preceding commit we have removed `packfile_store_get_packs()`. With
this function removed it's somewhat useless to still have the "all"
infix in `packfile_store_get_all_packs()`. Rename the latter to drop
that infix.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c  | 4 ++--
 builtin/pack-objects.c | 4 ++--
 packfile.c             | 2 +-
 packfile.h             | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b1d5549815..fea914cf9e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -976,7 +976,7 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_oid_pack(&oid, packfile_store_get_all_packs(packs))) {
+	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1177,7 +1177,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
 
-	} else if (find_oid_pack(&oid, packfile_store_get_all_packs(packs))) {
+	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 50618e1073..3a19bddd57 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4394,7 +4394,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 	struct packed_git *p;
 
 	p = (last_found != (void *)1) ? last_found :
-					packfile_store_get_all_packs(packs);
+					packfile_store_get_packs(packs);
 
 	while (p) {
 		if ((!p->pack_local || p->pack_keep ||
@@ -4404,7 +4404,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 			return 1;
 		}
 		if (p == last_found)
-			p = packfile_store_get_all_packs(packs);
+			p = packfile_store_get_packs(packs);
 		else
 			p = p->next;
 		if (p == last_found)
diff --git a/packfile.c b/packfile.c
index ab5859518d..1ae2b2fe1e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,7 +1027,7 @@ void packfile_store_reprepare(struct packfile_store *store)
 	packfile_store_prepare(store);
 }
 
-struct packed_git *packfile_store_get_all_packs(struct packfile_store *store)
+struct packed_git *packfile_store_get_packs(struct packfile_store *store)
 {
 	packfile_store_prepare(store);
 
diff --git a/packfile.h b/packfile.h
index 49484a9b09..c9d0b93446 100644
--- a/packfile.h
+++ b/packfile.h
@@ -142,13 +142,13 @@ void packfile_store_add_pack(struct packfile_store *store,
  * repository.
  */
 #define repo_for_each_pack(repo, p) \
-	for (p = packfile_store_get_all_packs(repo->objects->packfiles); p; p = p->next)
+	for (p = packfile_store_get_packs(repo->objects->packfiles); p; p = p->next)
 
 /*
  * Get all packs managed by the given store, including packfiles that are
  * referenced by multi-pack indices.
  */
-struct packed_git *packfile_store_get_all_packs(struct packfile_store *store);
+struct packed_git *packfile_store_get_packs(struct packfile_store *store);
 
 /*
  * Get all packs in most-recently-used order.

-- 
2.51.0.764.g787ff6f08a.dirty

