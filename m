Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9A3E2740
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170551; cv=none; b=SKJx4FJdQN6/PaIV7hb3lEgdffJX5JHGQt+V9cJlBDKM5+RS7DTw0L2+N+I7yfiIvgjc4SkQABqJIkd7VuaN8kSYDSGdxlnk4FW7Orw7ueP+h+Cxc04X6ISwtZLGFX1Fd5ODzUAZGfswkXDbpUVkbFppCfs2LWCQG4zyv6k46T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170551; c=relaxed/simple;
	bh=i4azZDvLPesvK6HUIBcDXAQRaLVlSY2UPcVUuMqA7CY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tR9QXynBinEtQ0CVGCLsUpcCZY/VrURbqrQV8NHcG+zVJLFMFTjgubqmYFVCVmFRwH+wCBZA8sLGy45mqXEkXeXOxhpt8xkfIel5dXB+2xmqrAaB7YbtDdoCZaYmxBmFFjmNSmh4XH3QoIbB2Yn9/aIrNqNgisJt2BFrHY7TEHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mZbhR/MX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d8lR2/y4; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mZbhR/MX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d8lR2/y4"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 88A841D0015B;
	Mon, 31 Aug 2026 06:02:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 31 Aug 2026 06:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788170549;
	 x=1788256949; bh=mL8SSWuZiZSn4iZt7hbf6b4e4owHbrrfWks4lgkXYBI=; b=
	mZbhR/MXm4+X5VHnNFSTI6wmzGRg+qxCfR8HtgUtlv1964tC8bNyP3vJR4jQZQ32
	BFQA3weLUWXKkajiO4czf53IzRs1c5kdFhbDjZqao72cBnf41+gSUc0LV+PnYYTc
	Vo7DS/hvvvDDw8UJGn4IWOrzzvxMUj2TGMVjvzbNBUJ2zL9NLEG2aydUDiyOQ2NR
	VBHqJXALNOD4OWVfPxWw6RN/hkB8lL/XfWeBwSNseIu9AILOUqG9D917aWjsjIu3
	67sJspqKBxyQM6Sh+vmPFpZRZ846x5JsDFjGdOZEcmLS0iHPrkioB1iE8VznrKfU
	g0gGzYBN7EtxDhjYD7EelA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788170549; x=
	1788256949; bh=mL8SSWuZiZSn4iZt7hbf6b4e4owHbrrfWks4lgkXYBI=; b=d
	8lR2/y4V73iiOz6k9U0/FEr7Yq/sFJWJofBeDScXJ55mKyE4ULNZfgoIyYu7HTTC
	nJeVm4t33gGBE0tsUzKEwaEVLSNxcfLertpYXhBu4GPRDWwiosYPdTT04rE37EkM
	BCRfHGsBCcCfCqUT1k+neg9qKpZGs2OU7yOc5rLfLTwdvCMDFS//QXJge5ufZmQx
	oJMCnMPmQa7ytnMPPEv4ffTfVp4roqmr4cfPn284eDm+AYkxk13bVgcedV/oXHkY
	TL4lAR3bzjgkql5ONk8eEvUnPk73b0MGrwD+fw34xphwR6HdX+ANo6CowaHUB5QM
	xj/GPpSjooMwyXtoQMA1w==
X-ME-Sender: <xms:NVGVau3kOQCnFgYVtRvpqf3vEZnKMhE2l9O79d-8XZL80hzSknF4Ug>
    <xme:NVGVaoheoV4JYWIFCjtGOUsFWRCbAHSmaBa163cdKgY0z3yAJErGTpoCO5fk0OGR8
    bUF5l6jxykj0X9BhiHnMb-hHz_0y1Skc4yV5AbCGAXAukI-9jxQ_Q>
X-ME-Received: <xmr:NVGVakR4gY_5HWDaPJq5AScq0eodDB1MwjlunjW-Urfu-Hn5ATEqmDATvKerd_XXndlsSA>
X-ME-Proxy-Cause: dmFkZTGPWT7J6xreIdhg/j/OSdJ0QuD62Ne7uI35+kqcD+LTFxaTKCFDw4dMHYSMC05K+Q
    WClrHaQQ1OcdcONvht6OQ6eMr1M9ISDUCfEcOxAyZJuHRUrxIuVTdIQMneEfpJkMptoVIq
    TqLNe66LZMJ8rJRQE1P8b0+cWVinUPjYT8ir9Cg+vTGIK9+SZ7IUH6e6ZaE7qgyhCsm4iQ
    AlZx5Cf7gExeHW8io8NpOwHQPuUJyVgVHJT14dKAWiUjlGEi+R+ImQ/y3XEaud51PUnrAG
    Rphq6JD4Eu9oJQ5/G09OmtGjdmsVItKEb0hcQ4ha+x6ZC0i+AB7xIn4fKRjaz2OdXPSTfe
    VEgiVw0NlRs457wHkj8KOuBLCB/CWgOr5TJK6oeB6OsCCrOdwxGtuq5tSXBtxeO1GQPQeg
    5eXYeOMJMYAfHJOUCP2tyAMKFL0fwitcmRWQIlVKptcyN4V1DmKDJAa2+SbBn1XNaWHyOG
    0EdmJem5uvMVxvHic1FPZs+kWqA7ehmnEI5/rU2zHOHtCx67EQa7+ocMsgcnfrjmbVchlg
    R5POLcOceNMtXputPSiWAG6c6BfjVNRqFPR6H4XCgLTgeY2BXS7ce7TSk2nbqPnWqCcNTR
    9XDxG7CqWFDLvNxojJAtwhAY2eJvr+JrqEcWSU+BSAzZO5jET8jfVyub8PTw
X-ME-Proxy: <xmx:NVGVapjQpys7FjQ-9BMe-2DK6fPZOnaLVqjzdPmAuLak5wJsCxr3Vg>
    <xmx:NVGVak7cXeLdo1elH46iEuuZIATwmc_V4QF-BzQAK53H8VfeKB5URQ>
    <xmx:NVGVamBiXny8IByC8MgZuDoaii3Q1owHD4WIGISyO7FYPPOPhAtTEA>
    <xmx:NVGVarYs5R73a79MyTPmWPjxGJiP49gxpk-V-T1nH475kXVZZNvw7g>
    <xmx:NVGVauKhkyzvM_KCmNtcOhvrJ7gSlp3k-IpNmvWefo8RHLB1FXx4lDcb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 06:02:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7107951e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 10:02:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 12:02:09 +0200
Subject: [PATCH v2 5/8] builtin/clone: move setup of alternates for
 non-shared local clones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-write-alternates-at-creation-time-v2-5-aecd2382ba1c@pks.im>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Similar as in the preceding commit, move the setup of alternates for
local clones with "--no-shared" into `collect_alternates()`. With this
step, the complete setup of alternates is now handled by that function.

Note that besides moving stuff around, it also fixes a bug: previously,
we did not know to resolve the referenced repository's common directory.
Consequently, when referencing a worktree we failed to resolve
alternates. But as `collect_alternates()` already knows to resolve the
commondir for "--local" we can simply reuse this resolved path for our
purpose.

Add two tests, the first one of which exercises this bug to avoid future
regressions. The second patch ensures that we properly handle relative
alternates for a referenced worktree.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c            | 34 +++++++++++++++++++++++-----------
 t/t5604-clone-reference.sh | 25 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 08c8f5a94f..2e3473fddf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -181,7 +181,7 @@ static int add_one_alternate(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static void copy_alternates(struct strbuf *src, const char *src_repo)
+static void read_alternates(struct strvec *alternates, const char *src_repo)
 {
 	/*
 	 * Read from the source objects/info/alternates file
@@ -195,29 +195,41 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	 * to turn entries with paths relative to the original
 	 * absolute, so that they can be used in the new repository.
 	 */
-	FILE *in = xfopen(src->buf, "r");
+	FILE *in;
+	struct strbuf path = STRBUF_INIT;
 	struct strbuf line = STRBUF_INIT;
 
+	strbuf_addf(&path, "%s/objects/info/alternates", src_repo);
+
+	in = fopen(path.buf, "r");
+	if (!in) {
+		if (errno == ENOENT)
+			goto out;
+		die_errno("could not read alternates file '%s'", path.buf);
+	}
+
 	while (strbuf_getline(&line, in) != EOF) {
 		char *abs_path;
 		if (!line.len || line.buf[0] == '#')
 			continue;
 		if (is_absolute_path(line.buf)) {
-			odb_add_to_alternates_file(the_repository->objects,
-						   line.buf);
+			strvec_push(alternates, line.buf);
 			continue;
 		}
 		abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
 		if (!normalize_path_copy(abs_path, abs_path))
-			odb_add_to_alternates_file(the_repository->objects,
-						   abs_path);
+			strvec_push(alternates, abs_path);
 		else
 			warning("skipping invalid relative alternate: %s/%s",
 				src_repo, line.buf);
 		free(abs_path);
 	}
+
+out:
+	strbuf_release(&path);
 	strbuf_release(&line);
-	fclose(in);
+	if (in)
+		fclose(in);
 }
 
 static void collect_alternates(struct strvec *alternates,
@@ -242,6 +254,8 @@ static void collect_alternates(struct strvec *alternates,
 		get_common_dir(&commondir, src_repo);
 		if (option_shared)
 			strvec_pushf(alternates, "%s/objects", commondir.buf);
+		else
+			read_alternates(alternates, commondir.buf);
 
 		strbuf_release(&commondir);
 	}
@@ -320,11 +334,9 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 			continue;
 		}
 
-		/* Files that cannot be copied bit-for-bit... */
-		if (!fspathcmp(iter->relative_path, "info/alternates")) {
-			copy_alternates(src, src_repo);
+		/* Alternates were already handled earlier. */
+		if (!fspathcmp(iter->relative_path, "info/alternates"))
 			continue;
-		}
 
 		if (unlink(dest->buf) && errno != ENOENT)
 			die_errno(_("failed to unlink '%s'"), dest->buf);
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 39a0c318df..9e4b98fdb8 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -383,4 +383,29 @@ test_expect_success 'dissociate from repo with commit graph' '
 	git clone --no-local --reference graph.git --dissociate orig clone
 '
 
+test_expect_success 'local clone from linked worktree carries over alternates' '
+	rm -fr base derived derived-wt dst expect &&
+	git init base &&
+	test_commit -C base one &&
+	git clone --shared base derived &&
+	git -C derived worktree add ../derived-wt &&
+	git clone derived-wt dst &&
+	echo "$(pwd)/base/.git/objects" >expect &&
+	test_cmp expect dst/.git/objects/info/alternates &&
+	git -C dst fsck
+'
+
+test_expect_success 'local clone from linked worktree resolves relative alternates' '
+	rm -fr base derived derived-wt dst expect &&
+	git init base &&
+	test_commit -C base one &&
+	git clone --shared base derived &&
+	echo "../../../base/.git/objects" >derived/.git/objects/info/alternates &&
+	git -C derived worktree add ../derived-wt &&
+	git clone derived-wt dst &&
+	echo "$(pwd)/base/.git/objects" >expect &&
+	test_cmp expect dst/.git/objects/info/alternates &&
+	git -C dst fsck
+'
+
 test_done

-- 
2.55.0.979.g7e5102b832.dirty

