Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA543DA50
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769566; cv=none; b=Jn2k/tFug/GkrhsXaANENDbZI4IL121NkpqfLytVjYtIq+KhoRR4xqn5dj9vZshxA0Ze01j/k1NABs4SJGnp5kTgfpAtsMntRQXHKBaE8lGB6alqKUSEhQthDenbf01vkM0rqv0J82i1Vr8R2sH380GrIvZOLjw9CmMn1Vpf82Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769566; c=relaxed/simple;
	bh=0y+K1wNhledqbhOU5QURPJTDNzr9kPqhtDg85C6Km4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+9fdvXPwHftO0cRJnQP7xdI2a1TS/Osp1P9ZHfeva7nHN2ogaDwJkTmpgeh5Zcmm/gPP9cQ2YKEzMbGTccJ9+hY2+9fKJ7Q3fIY8Cwag3YGcrFfRxViAxkvJlK7LzDqxQ1c9O5odWe+YXL+ZzpPN8w2/AzKqIfXab1AhjvsplM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a5hsxPPE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CtLsGxoH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a5hsxPPE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CtLsGxoH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 623B21400212;
	Mon,  7 Sep 2026 04:26:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 04:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788769564;
	 x=1788855964; bh=FEyRWBpxaF0V9Tm3vmWSQXpCCkz+jXyOSZpeFEd/KS0=; b=
	a5hsxPPENpMD0V0cumfkpLRNZSPWzaItrS80autt0quih2rgcsbYaDnjyE4LgELg
	ZrOgeowHs5tT0gDu497MfKC18qo5IBwl7zDEH5JsUL8srAu4w1bI76dAaR0Xf9NL
	NSTaq8xwfVbMNekxtGrSHRpcYoKlWNS0rZIqrgQfCIlWn5TKTxbOom8lGhVkP12g
	4L8WWGppdjRBIB6P0zGLmjkLJ+E8yQ40l+UQ5E4o4CuLE3HpayjZLmLcjvNBqCGF
	UCBFqhyHhNLbyyUGTxlBChfhTxMuxRKk8WBkkJxmWyHlUK/Snw85oCn2+Px83Jrm
	D4xqoRqBigvgCG+fJvFbRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788769564; x=
	1788855964; bh=FEyRWBpxaF0V9Tm3vmWSQXpCCkz+jXyOSZpeFEd/KS0=; b=C
	tLsGxoH3jC+pFUHxUoxLFwDdXL5b5PiYWfcrpvL0cwTkEWbstdptYzkr+O+ke6p4
	Rhl8F8WJ5PSp8OJJofpCGFYxoW361xgc/zxPxvTL62oIoZxKAd2T6TxB+Q9PuJt8
	+uK3TrLv2/n0TVzRNmx8Qw63DVXlzPSU1Nv5ZWGi/QC0j6qWWPedMQIo1GQ1z1dr
	zeeOHBrLk10WLilnyhb6YIGXyxItlS3/2qiM68VW7nbtmaLGqSa0BTWUY2oDhDvk
	auMfcwxHH9V0mZlre09y3FdBLC4ggH/ANIFSe2QOMq451kkotG5MxlfZIh9qsqms
	+JK+RFB9KI18LaLBgYHTw==
X-ME-Sender: <xms:HHWeauZPDaLLtkxJmQmoyi3i5tppTKyrxfCkSPGDEZlvPSNt6aZ_Dg>
    <xme:HHWeaoZpqnTsw7jZR4QKjDTNZcVKRbGWdsHOin1CfwRleHl6A5D9ZKjGBH4rIAGib
    J9OKVCTzK6bfylWdX2isP5AMGZ29CryW4oLiMiggzypDKp26yOkUg>
X-ME-Received: <xmr:HHWeat9fz7CCi-VDER9bvyOk4JDh4NC1fA1b9IiWsHJZBfT4ON9-jw>
X-ME-Proxy-Cause: dmFkZTEKi7Tq2gM9kI04RZ7AxwxWYGlFfv7IpMvr6TFJshIykzk8cWZwrnl2r9BRAgYCGF
    svyVZ24paJqQTflWYnS1XUi6nxhcg5aUaz3lDZ4sP6CqkSSsvJAX1vGa1llKApY52k+tIp
    JUhgwCy9VKuEXQHpTZuR3yuGFLdoJIv1+RvEwC+02R4TGFHBGTVtLukA9AAdLbirgc4ORB
    9s5H/S5ZFboEvWTNS/GztHbTHvYByFqFeNQnbZtrMmRajkT54bqptIl/+dJTuh+le0o9LT
    EBAxQx9xRD0nrN1n1n1kdpD/T5PPCxT/87kY3rpi+OwggpbvfFnU8sST591vWsinZpqBLS
    nFKC1rrORKhVOx3mbU+9pDtTbZ+RrvzFxFOUCpa4FBcfFI5S5KizYN4GQ2UMKeDoWx8cKj
    MWgcRJGRyldZGPAgTT05gS2FbYn2RHHopqPy7RhM9M/RX5jDVeSWb0IaX9FVKyKKVVqyfI
    II+VrwshHr0BXORxK98to3JsjYUp3T3EKnq7fjAso2XQHS0TcPfTMlBu0QZWi9hbQPy77L
    wtrUGlgm1TMdwD2bdEflv7nOdaSQt8NLVA8oIi3o2I7E3L6fuZK2LxPRtpc+EfHNj0LtFW
    SfiVQl50VjMPnZuW9AWt3d0QucV4z8Ya4KNsOWD2HaWA4XfHd7CPpKhKvS0Q
X-ME-Proxy: <xmx:HHWeavg5IjVBzZaSqrly5qDWva8Lcs9SwErMYkYfq46F4L1a-EuFpA>
    <xmx:HHWeale0iI36wxaO5oain7tbFo6kLVOrcFGK7f-wPOOcd97yws5vMA>
    <xmx:HHWeaupABRZB1S-BSoIYlD9PSe14yoPg5ODqY-1vDYquKxB-gJeqUg>
    <xmx:HHWeaiDzMWTHQLTtIeZcDyzP841woibleXDs20AjUSVvl1isX3rj8w>
    <xmx:HHWeai-BEoIAF7kmnsGSlonVxmqOaAPvuThgXB7OTbPDU4jyFBq3z-7M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:26:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 577accda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:26:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 10:25:43 +0200
Subject: [PATCH v3 6/9] builtin/clone: move setup of alternates for
 non-shared local clones
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-pks-odb-write-alternates-at-creation-time-v3-6-735d0b5b3e00@pks.im>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
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
regressions. The second test ensures that we properly handle relative
alternates for a referenced worktree.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c            | 34 +++++++++++++++++++++++-----------
 t/t5604-clone-reference.sh | 25 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 011fc867c8..84c1317867 100644
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
2.55.0.1007.g17ff1f9808.dirty

