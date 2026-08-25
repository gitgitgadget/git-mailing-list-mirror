Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9300483BE8
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668237; cv=none; b=HPPxow3WGHIfvxs9skPhqZgW+PxGraDWyIaYKtvhQHamioVkRqeTv8MY8uDawGzwn3/AyfR0cZQ0yeWOCwvKGikLEfgkmfj+uoFVtY4lipg7wRCeo4c7GiRGkGKH3ptN6v+XiXIKU9vEttBPI05kUJv1odiRurCfZujriyzLy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668237; c=relaxed/simple;
	bh=P3F29errDY3TpTASswVBqES4hJsEImjqW9LunCxHqi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVmKEEGtU64+HFsWODVO/Z3A0UB310zpnTiLVI2WApf3lO9BQlyi3d99gqGQ4Vd/5ZJol7V0jXT9WngMDUGO4hQSHElXzCJ+fAITK2RDLWN6VwfqwL8XFfXpazuZgGtPbRVa1ie3c/fFgvhQSVY4D9tYgIrIuuPG7+Rr9VewPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bSm3R3Fc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SoYffRt5; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bSm3R3Fc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SoYffRt5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 111341D00123
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 25 Aug 2026 10:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787668234;
	 x=1787754634; bh=3RCVuM1jcvPA08+ezlyoMJzuawhHIWiMygUHXVmuISU=; b=
	bSm3R3Fc0wIh/vFzZsIoGLzL/n91dLOBsCR0gt5AMfV+z++sou/nBm2D7ZS4vRMm
	W+YVwkDv8garlN5DtRadt2QuX1c1GTT1MhKb3DSAB3XovwQch6Hwcj6TYDgHxyjD
	8as6tbvxAsYM74A6khAzHn2dT3uqljCuCJ/y7hGmsWmiCPL3RaF2IGAWTTmdl4c1
	drWNBKlH5wsu78Yc0ip8/rBvKhJgpIKHcKW9OPrOYynRdLx598jAHfxomIj93WkG
	r3OzCxbmZcyWEgdqsKjcjLCLftNT+iK18drhXnfY+inN9zTbjecoQWUrm5eolvrT
	UHeQBX7vj363uDH9hpEzKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787668234; x=
	1787754634; bh=3RCVuM1jcvPA08+ezlyoMJzuawhHIWiMygUHXVmuISU=; b=S
	oYffRt5KbOCU0NBy+dY9hM4IDCv3/yHf5lPUs7xkKO3oMDyOYYQsuFjqPtskBWjH
	qEBEPj2/9s4y2zVlCDEaf6DNmT3V5hM23YiJ6m/eu/JXxHwhlXnXmQajhuXesJ9W
	YhpeEk1/9spsROHZyJkxfkg30Ahz/OdlPt3ep8ZTKYfAXXydWa/u5OlOSj3IR7+z
	R+BtBBFP/OwXsQm08iO7pxGawSkevylGQZP6Xkb/WJjqlwrm9xjNdhVUAE0t4Exy
	3osLqykgMIrAJjN/QNaY950bAjwo45IlWGI4re2ZUrThD3/kua/2qUWMKgmL/3Ws
	sMg284HSjzcMRSqBnbmPA==
X-ME-Sender: <xms:CqeNaqC6SiKNrP6clmwIl6XoRK7GNhW-5VkLuuXe9TDQWiPn2A8tqA>
    <xme:CqeNardKnS--LkSUb7Kx0F4S75W2-LdgjJb2qxTi1kI_IqugQpu9EX4ymcn3aaL58
    3kS2BgRY57jh4iBCJZPVmMMdhxlWLsYNZV16Z3jY1HiC0NbE0ePNw>
X-ME-Received: <xmr:CqeNajOl76Uk6ix0z7YeJeCNLSq7dkMtnT8ygd0YM3Dp3b3PaHB2voOxWLptSY140ZYA7V_veUV0sbdjft061tUFDRq7GR8N5bAaNZ1xRg>
X-ME-Proxy-Cause: dmFkZTFKcZKZ/40TckMd0yUfo6v0q0OYvralKxnx+iajcqxEVjRQCBPtm6fPnTJmTilAm8
    9hfB4zn2moFCITF72Vc3Z1DSrYI2TOnVfuGDJN7XvZ2uzid0CGFuiBLEXD5wJqMYT4BFj4
    b6MB1JqC4Erme++/wggdomTeSm1c96Jowi/nqUOh2+3kgedQL78RIVfBRqKAfR5MaEsXJm
    1QA6m4S0NZaVCwJTBlcvfx4j0eI7oHOqzII3YBlr1t56AJozibD3M/ErTe42/AQZ/18T/o
    XmOzMmX1y+QJKJP0OUMpf0/2wMCmu/1ZQA6LnKpKxp06rdRuMJvElgpNtsfhM1PqnTwUBl
    TpndLuWI2IR/gBurKX2ccQXP40zUq3LXoHsMHtkNTTx5bFJNqcD7xVm/mzfh9kHn3GsZXZ
    ZfogUUcOEdb9j0ZcOemn7LcHvCiVyGYoJZQvw4rlHg0k577kSODt3S9QHC0qfiRiSBfTG5
    oEAaDeqcMrnu9o0Vs9alailPZYN3DFANi+bvrSk34s6XrX6XfJOOKhe7SmtQwOawoihSVq
    SE2MLem/HoXTm6wrptDGTyjYvGghjqR8hXJVICeR9iR+2qDHKDG0D/1rwU3UM4rWnIkk6j
    KRno2br4hCL0S7A528adoc01TKrzHzITy+jTmdFthzpSU7VtGuIFLVjrXp2w
X-ME-Proxy: <xmx:CqeNat6p7uLR3qHFtbklJMdOuw9LzFMMV6nyKIdpgNVqLlyIxZ7caw>
    <xmx:CqeNavK8CMpl8rQZ9qNyHqz8wgyIAsYqTk0TIcRyEmgg___O_yCDDA>
    <xmx:CqeNavfLPKwSCJDd-9utVg4N74kX02UXlnCYivuy7F-xcI9D5jG9Ew>
    <xmx:CqeNaqfL1T3DWKHb2tcWPOjo-lBR_jHNvhr110yvSNkjwNR4-0mSvg>
    <xmx:CqeNatAseRbX50E4Kz87cI_4zdKxegZB0OY_O4jDrm4vipTFmzsBaHfh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 434787d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:30:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:30:11 +0200
Subject: [PATCH 09/10] builtin/fsck: move multi-pack index verification
 into the packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-source-fsck-v1-9-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.55.0.822.g20453c30eb.dirty

