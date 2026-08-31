Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA673C10A4
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158805; cv=none; b=j3BtDcTtsGWzqP+GFShlNX3+cAtTzQdAQiuCV7US64jzcPfIxAyLmjOtgPk5TCt9diE+RGEx5azaQKwPE2Pld9LpuL5HM02XpFsfawh2g3rYfImgN7N1gCl95XnSNZMW4bpA1KBf1j4oE3Et/kuJ81VLZoFd2PZt21YH9LNcH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158805; c=relaxed/simple;
	bh=5qr67hyGAGHdnJ3dv6mQ9aP4LL66h+d3U0sVG8oRSSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHe2CT7le1YCJ5L4S0gMBRykqlfvkze54KOwcEM7S3cO8UQaO8mf290/fSBLiUcqnMyN0K82cIyk/xm9Tm/HW2DsRrNH2g/CVJJYEi2v7mHjI4nxPaDv9evubeNVLQAqOz1SYsiPkxohO8eCTzQQfWp96U3pRmAuXWF/zRWZyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ejh+pZ7C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EtHxlZCq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ejh+pZ7C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EtHxlZCq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BA271D00139;
	Mon, 31 Aug 2026 02:46:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 02:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788158803;
	 x=1788245203; bh=0N14j505uuUN4/eqLycJ2qRedO2aKGCZaAgp+UbHeiA=; b=
	Ejh+pZ7CZ4kpIp/KBlPUYx508STRjOigD7BzL/Kuq/8E2PodWuNNP9EdwQckUUu+
	JJSwXc0vtsKPIUSFdtrPwroJvoGA7+3C3qZVE5VdmAuyCGrdY6HLYaDXZSeyIzMC
	inTTVjA+zejD8ZanQuJ33BxaLyL52MJzpDFtXdt7qBbfn4SBwaIdM+tkV64xEiuL
	X0Q9jySmA7FLmxLbaX8Cb4yvKjlcvlRYMEVeFmRq/ddKXcg+1m+wrNdI7QlQ7KDY
	ORvf51JN7cxpdgWpifZ3GhACuce2/SnA7fTdV3g8D8IfjRI2LGXIdPkE9SmN5w8B
	/6feyT/K3jaM0spawNaDZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788158803; x=
	1788245203; bh=0N14j505uuUN4/eqLycJ2qRedO2aKGCZaAgp+UbHeiA=; b=E
	tHxlZCqxbPz3gCV+1VZo8nMOuGMEp7jWrKoeUTNZoHLf1kh/2pU3iT92Hpxcm6I7
	Gukem+6tShMySXg6GxFKW0Prf6DxhwW1NH9zz8rGahs1tMa7/P2a24eQj0B8xtL2
	Ty3eLmcb3AEjSpZ+Qq7ijx/gvNntuyXshQ/gQQMxyt8LIFo+LZN3+O3WVmbPTaoS
	w8zjRs+l7fWozfvQCVrjWrSBPWfaQSN9Am2eCtyjP25WcU4526nrHPromByDc+D3
	MLF5PbKNkxttl+0kWdDhpRey7T9H3F06miU/tAptwgyxAKBWxicq90lVlU5ob8K4
	bZzWq353mdJ9n8+y0YoNw==
X-ME-Sender: <xms:UyOVatGPavoNonDww_mSdrPFz5QN6j1K3DCUf7S6LGWdV5vSjGKGIg>
    <xme:UyOVaoWh1AdtHufsRk80CVvZaGberbM6dm2qODYbmQr-yF8J4iD73vU-vJvKTM8dy
    a3yy3SjUIz1mPTaJssmXlKpKrthVjHI-VUJ8aI1lXOXP5qhN1air8Q>
X-ME-Received: <xmr:UyOVasw5i8_sFpTC8OryLyXJSWKGfN-DZE1vKhbj9bqcRoZUfdjs9vCrE2kkfe8cHSjb5Q>
X-ME-Proxy-Cause: dmFkZTEOTeXxBa25y61FnB8jRofxSjsJVtrG0nhg/PuD6FL9hO0A1cjVX8icF5GcsxdZVt
    lfgNOESCbVLXLKMHZSbIkwfRSmk6he82udMuo5Rvt/PKwMnAvi8hn5itWaVPHASCgi3k/k
    7iHNUoRjYQCsePgICAWWaJp46IyU06CCtIb9bSeTzs2ZbNp/Dq3bKNt2jdIKxsr0fJ8Zic
    Bnuaj/o3hD6ftxsa6DLeoQA2DbEAWoAsbcuNvVhHMnGqIcZDHnuIW8wL3ZTG+aQO4MeKPb
    ODelvfcIpvqgHVw+2kbMz4SUSgfv7/qTBpohbGTrAWqEBlGOf0147mOEooA3GXgsmlRBRp
    ich8VTjaHQx3NKstjeEREyZa/2p2Y0cnvPnT/P57G5hPP97k/rMKK84plRRABKCNDFMVBz
    VMFbAbiWAB6qR5RbIabMQJFNU87HjJOhCWLHdWfyvQPzmBBAu7rbuC3jompVF9OVARKzkj
    9ElKujr9hvSIxv5YCw4ZBtypWkLUGbBsVzVznZtZXMBiHQ2Vh5lp/qCtLezznwzlFe62Ls
    S1wGEDlbPDLo46WsOvRG+rK5saXfRhYGGwc6xYhEupxnJLQFQfceeheA0B2uIMyWh5axdm
    reycsw8gY7gfnk44SkOS/YBO/MO3ywUKqueq4ctopn20PmBSr5DSFicDwntA
X-ME-Proxy: <xmx:UyOVauMsH8xJlvUlU4_ttAJO9QznFS6XWes52KwTsJIbWeak0EWBUQ>
    <xmx:UyOVal6MpBCE4hyPTxGMaUAdfd9bOQQ3iKNK_adMF5tTbuvkNU29aQ>
    <xmx:UyOVanMjbHRx9X2IojGvoo5VZDiUtUbmhXdfonGQunnSLK6AidaAaA>
    <xmx:UyOVarkcff1Kn2qcOZuTYv7b8lPMpW6QVwUjQbqhPyW5BT4uD_CuPw>
    <xmx:UyOVat1fonSuoPyV_i1zS3wvrE8BtT5VRzr29ckzQWSL4xUKcFEWqk4g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:46:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d9f8f81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:46:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 08:46:23 +0200
Subject: [PATCH v2 09/10] builtin/fsck: move multi-pack index verification
 into the packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-source-fsck-v2-9-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
In-Reply-To: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The checks for multi-pack indexes are hosted in `cmd_fsck()` directly.
These checks are obviously specific to the "packed" backend.

Move the logic into `odb_source_packed_fsck()`. As in preceding commits,
this means that we now properly honor both "--connectivity-only" and
"--no-full". Furthermore, we drop the dedicated `ERROR_MULTI_PACK_INDEX`
bit and instead use the generic `ERROR_OBJECT` bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c              | 18 ------------------
 odb/source-packed.c         | 27 +++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh | 13 +++++++++++++
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2f7d29aa56..7eaea340b0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -48,7 +48,6 @@ static timestamp_t now;
 #define ERROR_REACHABLE 02
 #define ERROR_REFS 010
 #define ERROR_COMMIT_GRAPH 020
-#define ERROR_MULTI_PACK_INDEX 040
 
 static const char *describe_object(const struct object_id *oid)
 {
@@ -1085,23 +1084,6 @@ int cmd_fsck(int argc,
 		}
 	}
 
-	if (repo->settings.core_multi_pack_index) {
-		struct child_process midx_verify = CHILD_PROCESS_INIT;
-
-		for (source = repo->objects->sources; source; source = source->next) {
-			child_process_init(&midx_verify);
-			midx_verify.git_cmd = 1;
-			strvec_pushl(&midx_verify.args, "multi-pack-index",
-				     "verify", "--object-dir", source->path, NULL);
-			if (show_progress)
-				strvec_push(&midx_verify.args, "--progress");
-			else
-				strvec_push(&midx_verify.args, "--no-progress");
-			if (run_command(&midx_verify))
-				errors_found |= ERROR_MULTI_PACK_INDEX;
-		}
-	}
-
 	free_snapshot_refs(&snap);
 	return errors_found;
 }
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 2b5dc502f5..9f42552377 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -14,6 +14,7 @@
 #include "packfile.h"
 #include "pack-bitmap.h"
 #include "progress.h"
+#include "run-command.h"
 
 static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
@@ -897,6 +898,29 @@ static int verify_reverse_indices(struct odb_source_packed *source,
 	return res;
 }
 
+static int verify_midx(struct odb_source_packed *source,
+		       struct odb_fsck_options *opts)
+{
+	struct child_process midx_verify = CHILD_PROCESS_INIT;
+	int ret = 0;
+
+	if (!source->base.odb->repo->settings.core_multi_pack_index)
+		return 0;
+
+	child_process_init(&midx_verify);
+	midx_verify.git_cmd = 1;
+	strvec_pushl(&midx_verify.args, "multi-pack-index",
+		     "verify", "--object-dir", source->base.path, NULL);
+	if (opts->flags & ODB_FSCK_PROGRESS)
+		strvec_push(&midx_verify.args, "--progress");
+	else
+		strvec_push(&midx_verify.args, "--no-progress");
+	if (run_command(&midx_verify))
+		ret = -1;
+
+	return ret;
+}
+
 static int odb_source_packed_fsck(struct odb_source *source,
 				  struct odb_fsck_options *opts)
 {
@@ -912,6 +936,9 @@ static int odb_source_packed_fsck(struct odb_source *source,
 	if (verify_bitmap_files(packed))
 		ret = -1;
 
+	if (verify_midx(packed, opts) < 0)
+		ret = -1;
+
 	return ret;
 }
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 68143cb5b7..20b010c33b 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -573,6 +573,19 @@ test_expect_success 'verify incorrect checksum' '
 		$objdir "incorrect checksum"
 '
 
+test_expect_success 'git fsck --no-full checks multi-pack-index, --connectivity-only does not' '
+	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 10)) &&
+	corrupt_midx_and_verify $pos \
+		"\377\377\377\377\377\377\377\377\377\377" \
+		$objdir "incorrect checksum" &&
+
+	test_must_fail git fsck --no-full 2>err &&
+	test_grep "incorrect checksum" err &&
+
+	git fsck --connectivity-only 2>err &&
+	test_grep ! "incorrect checksum" err
+'
+
 test_expect_success 'setup for v1-specific fsck tests' '
 	git -c midx.version=1 multi-pack-index write
 '

-- 
2.55.0.979.g7e5102b832.dirty

