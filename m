Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F247DD44
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400172; cv=none; b=OAWH9lWAt+aLI+XRWd9sRWvcJ2Hi+2LgN5mTLLrx/Dl3tyUkBVM80jBCpvGrkNTFahOVUiWOuZnqPuB5fZwSs8i9KNrVbryzw+lzwfsLO4z0Ki6UAOoQ37+vABk4MOX8GzOa7Gr21Fw4OJqM2g8XP4pY11j98rn/FxAvMfGAzcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400172; c=relaxed/simple;
	bh=ZYjIKUJe2h6BrJmGdChmdtq6/bDliMuaImgxnCrEy7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxkdO+bW+WdwAfpV8hLR35oIARm4iCrX3/aeg9JPkqDVEI8q/5HJpkpNjEVniJmfrXNoBFpffEkS+A8oL+A4McxRHQSrGkX0/EYfuno1cc7Wj057tr4FJ3ywuLtsg6+Hg05jmLJxLS75seolavsMFZFTp0dyo8ARPMI/c4DjOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rxPzgV/E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4kP2TaL; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rxPzgV/E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4kP2TaL"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E96A91D0008F
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Oct 2026 04:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792400170;
	 x=1792486570; bh=xhXA8c4zuvcjoezHADGaWtAjqZROvakE4u2zNP/YHC4=; b=
	rxPzgV/EKuo8r3mwb/V+r84uMBfmFSaTc1a/nGGoy/+K1dAWcPcKmyrV4xWnHtN7
	NyfeTlH83hAwHdMTqpPq7Oj3r92tLdAdvC5cYHWzSy3ATwi1S5lglGJmW0dnDpdN
	SA/EYW25XyEYNteWl4TzS+e0lpjRw6xmxJkJ26TnRFxTtpD/zdcPfCazcQydiOvk
	1XuWMnTg4PVa1OEVfvpTJBLFP8xwu4VJlt1eQTBzMtZSonS5gPxvCcMP0A+0tSTb
	YEzFAvSC3nuMUKqXClSy2JkEJO3elScJ4D2x4n+S0F3J9D7IlHcxYKo6Bpb0BLsZ
	nJusQnaD3LKUtVP3PzoPhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792400170; x=
	1792486570; bh=xhXA8c4zuvcjoezHADGaWtAjqZROvakE4u2zNP/YHC4=; b=k
	4kP2TaLlhxPbpNoSwux1jDTHjIWYtsvuTws4hxzqt03vy5SERoHqGYjNJ68b62Ws
	ewP4QxQiUw4g8zcMXYHPL5Qqq1ygZ+ddx63jkGgmeyNMYRLZMCRWgCQij+dDlsqj
	PAGf2sweCUXUy31ADP382Bdw2pHoEoHv3wZ7rtL7cKe45uXksFwGW5jNy150BCPi
	0CKEDr8bfe52piu1qPxSJQT4HH/f/sC26uvFv3F0kC7R/EozSpCibudx+io90m8U
	x5JR6RSZxxA0cAuDHuWA8ZXRSACnQi/5d6velR1r0mhY1mtxl0z8wc2MoviRL3l3
	egcBPN/h/GTKiY//iCYCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792400170; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XcjgY7Mu3w9RUOaGT6u1iVtFafCdub4FKS8W7fcXdNfHVQ2
	JxEQyX5qJ7jbmR3LYyUHAYa7JNCHTzPAMtQoQDirDx2rKs1cE4WZDWT3/Zy0Q7I3
	mjB0SoIk/pD679wMF7k7f8Vr473AfgRBr9bvJf2PAvCO+konyJRgagZM18NOubK1
	ai0P+N8uskzFNsSClxmoPP08Ru2Rj4NRY6sE4zGNxMv0b0URNh+N3T3WZ7eBpIK3
	/lFvLkN9EAXBaxmn2fT1mWUFIcLQBrJHkYXnLiTaXcNEI2Ey+G0jirIdZiB0neqy
	8BXnFmGq8JREkz9zrT2Yv8C9/oG9xXaTObh4yfg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jR+tUwqeFhDLKGYf8eriieYJ5HaEe1O2lAojoWennMk=:ZYjIKUJe2h6BrJmGdChmdtq6/bDliMuaImgxnCrEy7M=;
X-ME-Sender: <xms:KtvVao6vvbFO1eGjji-hDtX_2qyyRCPXCdonnwNh6ap6gH0sxMdvCA>
    <xme:KtvVag1oBbtg2kAfVXusAOCEGm8TtcqOuf_loek8KsOpVyHFiO8gt_-v6-QLAT0wv
    jjTJOd39h-QzM4XsUPrHz0bD7gl7726AP8EiZGp_JVj0mP9aW3n1A>
X-ME-Received: <xmr:KtvVatFm5yoVcrIjXdQJZvE84V_eda_siMKwABLz3WlKSTi0Vlnf7A>
X-ME-Proxy-Cause: dmFkZTG23idctCybf0+Q/l30SdoKiCOHSSle9HRu+3X9JZZgVo8nvJv+b9ldcx2nfgzyr8
    SP87B1b17rPQ3OJUrRXQkeVVK411shVkI/u5Rel7mhVGXxmcv9NDeVwwbePnCOFaKtl9qE
    XMEeSZ0cXcpOIlFM80wQDUMHoLrM2ar/kJnUkw6Foyh3YExP7HzhFD6liMtUnyuLBud/Mi
    nyE0OUyZv57vSpdaVxZhpeeiLY+sFeFN0s3TBEeXmHizJNiqky43z0Qa8ObKvaHAXiAIJg
    k9hrD8K6RAyMO821uT1I7iuHPSksXnmtAjtM5Rym9XGb+Pa5PbO6m9drHVma1yG1d09yQ1
    JwracTbWfRVz/MBe6Xa2C7STdAv3RX9aYrCKgLwxAl4dolyjJ3MrSQBRirQJN4NFdufMYy
    uP8A+XOOE4lT7yijOvvQPrRdJOXatzcCUZP9j7c5Irn54PntQD4gX5+FtAEgAakuiQ2eoa
    FKQtz2GOahthQwcVOGWok2wFBLwV457Jz4fNmmlELiS1T/QmhFT6Pzevg0DULcibEnrRbO
    tQfas6hCek0s0b/OPPs+4+GQMPoVKTvqJD86j5Q/4bd4c4kb432VnhCiZUDTxfSJC9KHzp
    sQhCiUWXeSBsGQEN178Yvg+dlNUhsvzhE4qPA8YeDd48YFeiQzIb6Ox5EI8g
X-ME-Proxy: <xmx:KtvVaiQOCJoWVP9zmOrCASU0Vuk6OAMrAsrdj4_vl8D2Z1L2t3mgDA>
    <xmx:KtvVasBSd7T3JbyUTqFO35xw65qOEpRSSsC8Ot7jtvyUmHV8UyTyuQ>
    <xmx:KtvVaq2o0ZV11bwvvwpg9R14PmLFopTAOI7MorXrMivTe5GApcDfkQ>
    <xmx:KtvVaiVJS7wAdZpyWfKf2RrwMMC0cE8F8EBUWArp_qk1za8YcbxjWw>
    <xmx:KtvVapYubHaQhq8V0xKJRANcAXvKBvEdEaoMNrI_LkxN8QAKWoUfxd7U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 052ad239 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Oct 2026 08:56:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 19 Oct 2026 10:55:56 +0200
Subject: [PATCH 1/7] loose: drop unused `repo_write_loose_object_map()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-pks-odb-extension-v1-1-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
In-Reply-To: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The function `repo_write_loose_object_map()` was introduced in
23b2c7e95b (loose: add a mapping between SHA-1 and SHA-256 for loose
objects, 2023-10-01), but it never had any callers as loose object maps
are instead written incrementally via `repo_add_loose_object_map()`
whenever a new loose object is created.

Besides being dead code, the function also hardcodes the location of the
"loose-object-idx" file as "$GIT_COMMON_DIR/objects", whereas both the
reader and `repo_add_loose_object_map()` derive the location from the
loose source's path. The function would thus disagree with everyone else
where the loose object map is supposed to be located when the object
directory is using a non-default location.

Remove the function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c | 46 ----------------------------------------------
 loose.h |  1 -
 2 files changed, 47 deletions(-)

diff --git a/loose.c b/loose.c
index d6a2bb5ba3..7e26a04ec0 100644
--- a/loose.c
+++ b/loose.c
@@ -123,52 +123,6 @@ int repo_read_loose_object_map(struct repository *repo)
 	return 0;
 }
 
-int repo_write_loose_object_map(struct repository *repo)
-{
-	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
-	kh_oid_map_t *map = files->dirs->loose->map->to_compat;
-	struct lock_file lock;
-	int fd;
-	khiter_t iter;
-	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
-
-	if (!should_use_loose_object_map(repo))
-		return 0;
-
-	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
-	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, path.buf,
-						    LOCK_DIE_ON_ERROR, -1);
-	iter = kh_begin(map);
-	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
-		goto errout;
-
-	for (; iter != kh_end(map); iter++) {
-		if (kh_exist(map, iter)) {
-			if (oideq(&kh_key(map, iter), repo->hash_algo->empty_tree) ||
-			    oideq(&kh_key(map, iter), repo->hash_algo->empty_blob))
-				continue;
-			strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)), oid_to_hex(kh_value(map, iter)));
-			if (write_in_full(fd, buf.buf, buf.len) < 0)
-				goto errout;
-			strbuf_reset(&buf);
-		}
-	}
-	strbuf_release(&buf);
-	if (commit_lock_file(&lock) < 0) {
-		error_errno(_("could not write loose object index %s"), path.buf);
-		strbuf_release(&path);
-		return -1;
-	}
-	strbuf_release(&path);
-	return 0;
-errout:
-	rollback_lock_file(&lock);
-	strbuf_release(&buf);
-	error_errno(_("failed to write loose object index %s"), path.buf);
-	strbuf_release(&path);
-	return -1;
-}
-
 static int write_one_object(struct odb_source_loose *loose,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
diff --git a/loose.h b/loose.h
index ed663ac550..41c4b46818 100644
--- a/loose.h
+++ b/loose.h
@@ -22,6 +22,5 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
 			      const struct object_id *oid,
 			      const struct object_id *compat_oid);
 int repo_read_loose_object_map(struct repository *repo);
-int repo_write_loose_object_map(struct repository *repo);
 
 #endif

-- 
2.56.0.269.g68944adf51.dirty

