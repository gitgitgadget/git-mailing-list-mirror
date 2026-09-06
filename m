Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE902116F4
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788679514; cv=none; b=faHsTyq5GVofSkF+RORNW44C0Bb94c4KOEjkH9iiXzmKlP+WVEiurxE26QFVjN+Psn4PstiFRZnH0RWGJJ0ntd5FzCa1XZ6G+QczCQZOJ5m+fcuW/1e5y9ehDIDa07Slhm1Jb6JLo9ig7cE7TNg6r/H7eMzVrXVpiFp8690ApKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788679514; c=relaxed/simple;
	bh=J5q1gz1I3Yt2BwJIY56JzRg88hCSTfubx6KbXwvUq38=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e7rfHpos7Ck+03EIO1pG3KvzVX5hgzhkokhLNrMTURA+am+T0tByoXTlpoZwErEY3il9nqE2U14RiVS6sSJKVbA9AYpKgREzGCS0Ep04BE1He1GasQGkufymaxXYOOVwysICPx23uZ/CoZfYGZ51nco7FZ86du+Bm4pp90ob00s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX7EUap8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX7EUap8"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so1635320a12.3
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 00:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788679512; x=1789284312; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xX9q5wO0le1BBCZ0n2ZNSCMWbi6NmukhrV8bhpc5k3s=;
        b=NX7EUap8/ykg2v3Mu4I+Y11O4Op+pLjwDeO5RLrnixdCWtTAWSBGpiAyY8vd3o+msC
         SJXLi+yiaoIRzqVoKZmBrSOab7j9L6ujJKHLc2daRRzO1PZ60OSeXY9FSBJw+4dDosxG
         Jtm/XjB3p6hvcK5BLP3VlbIqh9lTak8btg+485wpRm4Nw73uKrogTP4KHhyFfWN+Eq8C
         +3nMZnsbczaezc3++gpVgAPgklTmed4ob/jRuTOjK0JOPJCrV4t+UJ/C439Uew7FDjUs
         9Vi0D9ea7k2gg89jJupA61HkSDaKKYPDnpzza6ayFEVD9LriySCJLiosAGzBxmmkhlTp
         k6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788679512; x=1789284312;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xX9q5wO0le1BBCZ0n2ZNSCMWbi6NmukhrV8bhpc5k3s=;
        b=POi34lCtmRd+alSrDUCG4OpbxFuQqyuFUQQvWQneveVNqOx7RQRzLvh9/HOqRHQ4Lb
         U77B2Hot2N5SvVlPxBKaiNPOjZCXBDxc5qqGrjOe2sOWRjbNe3ij0H5FEL2HzFxy9jiM
         h7bRWMXMdVsVUOKrxj/WsoFU8V2lE6FkwvcXyC42vM3AyqwT6S4rVftc1pPsQJOxADH7
         mYQuxAasIwGxrtp+6Ru2xAy+0h3Md/GHQhSR2uuseIjS/5BZx7IexhNllOmQRBRjbXRY
         EzdsXkjXJscR6w43+BOJG1/JitqWuL7LLf6xnHuwAivZ1377Cwzt8PZPlBJ+soNakt78
         QAiA==
X-Gm-Message-State: AFuF++m6XaYZM2OUdTyYINLHXJvaYWJZ18sMP9m293/KxSc6+0a5JQzb
	ujUfTBuisFwnzfFw6fe2v/wANtU8zqTyW7nvdrxhP/+uethzRqqWSdsGqKkcGvfm
X-Gm-Gg: AYBFou1juraHsAdROA0/DLA1FSzw8DT8Q+GNvfF6NthJuyUY08fvxB3m+CM9J8qjKix
	xjqrm1+lnfqIR6gpLhi7zA44go5rwI+FHIfd+j7sAluHTD03+j77I8a87CyG5J/uhfdCPScgyLF
	KPgdo7rQU9IKOw0dc9gQqAvL+xfTjXq3Kg+AB3LbamTWOo2alVikev7dUUwP7KXKxLC75FLsSj3
	C7mzVWM1FZhT8ktWOo9BSpic6jPewui+8YSu3ym+OZb4dU0bgKMMAi9yzKUSeve5F2dJXb6octE
	hpQmwfkwvZPd5uOVHiG/Pz4obftBYYRaRnAIn6NBCwCBPrpvEftmMJP/b6B3wlpUJoXejxdrES8
	KcjyS9qyU0/zK1EyLrVsLZp+1HQvFlg/g7zjeCnTkgiRcuzfBEjZjA2oY5MWxOHOeivkEeNqsUd
	ELLvuRxqEES/kHc8DAN/E0ZvCvWUOp4+p5bBEZObOJNd9sAWNu10PrJdt68RtAvpY=
X-Received: by 2002:a05:6a21:50a:b0:3cd:9dea:2be1 with SMTP id adf61e73a8af0-3da3977940amr22599471637.0.1788679512023;
        Sun, 06 Sep 2026 00:25:12 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.15.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b9f68e4sm19648947eec.24.2026.09.06.00.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 00:25:11 -0700 (PDT)
Message-Id: <ae821ce0784286486fe76117b90bce78610ea37f.1788679500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
	<pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Sep 2026 07:25:00 +0000
Subject: [PATCH v3 6/6] send-pack: advise splitting incomplete shallow pushes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When several refs share a pack, an omitted shallow boundary reached from
one ref can exclude an object needed by another. Pushing each ref
separately recomputes the pack and avoids that interaction.

When such a multi-ref push fails after excluding a boundary, suggest
separate pushes. Gate the message on advice.pushShallowBoundary.

Assisted-by: Claude Opus 4.8
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/advice.adoc |  5 +++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 send-pack.c                      | 26 ++++++++++++++++++++++----
 t/t5538-push-shallow.sh          | 31 +++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 81f80a9274..6bb6955246 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -99,6 +99,11 @@ all advice messages.
 		a configured remote but looks like a `<remote>/<branch>` ref,
 		suggesting that the remote and branch be given as separate
 		arguments.
+	pushShallowBoundary::
+		Shown when a push from a shallow clone is rejected because
+		the remote could not unpack the pack, hinting that a shallow
+		boundary may have omitted objects and suggesting the refs be
+		pushed one at a time.
 	pushUnqualifiedRefname::
 		Shown when linkgit:git-push[1] gives up trying to
 		guess based on the source and destination refs what
diff --git a/advice.c b/advice.c
index 63bf8b0c5f..3701672048 100644
--- a/advice.c
+++ b/advice.c
@@ -70,6 +70,7 @@ static struct {
 	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching" },
 	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate" },
 	[ADVICE_PUSH_REPO_LOOKS_LIKE_REF]		= { "pushRepoLooksLikeRef" },
+	[ADVICE_PUSH_SHALLOW_BOUNDARY]			= { "pushShallowBoundary" },
 	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName" },
 	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected" },
 	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward" }, /* backwards compatibility */
diff --git a/advice.h b/advice.h
index 66f6cd6a77..b2e281baa5 100644
--- a/advice.h
+++ b/advice.h
@@ -37,6 +37,7 @@ enum advice_type {
 	ADVICE_PUSH_NON_FF_MATCHING,
 	ADVICE_PUSH_REF_NEEDS_UPDATE,
 	ADVICE_PUSH_REPO_LOOKS_LIKE_REF,
+	ADVICE_PUSH_SHALLOW_BOUNDARY,
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
 	ADVICE_PUSH_UPDATE_REJECTED,
 	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
diff --git a/send-pack.c b/send-pack.c
index 8a7cedf65a..4fa17810a7 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "advice.h"
 #include "config.h"
 #include "commit.h"
 #include "date.h"
@@ -161,7 +162,8 @@ static int append_reachable_shallow_grafts(struct repository *r,
 static int pack_objects(struct repository *r,
 			int fd, struct ref *refs, struct oid_array *advertised,
 			struct oid_array *negotiated,
-			struct send_pack_args *args)
+			struct send_pack_args *args,
+			int *excluded_boundary)
 {
 	struct odb_generate_pack_options opts = ODB_GENERATE_PACK_OPTIONS_INIT;
 	struct odb_pack_generator *generator;
@@ -191,7 +193,8 @@ static int pack_objects(struct repository *r,
 	/* Exclude reachable shallow boundaries from the pack. */
 	if (is_repository_shallow(r) &&
 	    get_exclude_boundary_mode(r) == EXCLUDE_BOUNDARY_YES)
-		append_reachable_shallow_grafts(r, refs, advertised,
+		*excluded_boundary = append_reachable_shallow_grafts(
+						r, refs, advertised,
 						negotiated, args,
 						&opts.haves);
 
@@ -607,6 +610,8 @@ int send_pack(struct repository *r,
 	int push_options_supported = 0;
 	int object_format_supported = 0;
 	unsigned cmds_sent = 0;
+	int excluded_boundary = 0;
+	int pack_contributing_refs = 0;
 	int ret;
 	struct async demux;
 	char *push_cert_nonce = NULL;
@@ -742,8 +747,10 @@ int send_pack(struct repository *r,
 		default:
 			continue;
 		}
-		if (!ref->deletion)
+		if (!ref->deletion) {
 			need_pack_data = 1;
+			pack_contributing_refs++;
+		}
 
 		if (args->dry_run || !status_report)
 			ref->status = REF_STATUS_OK;
@@ -832,7 +839,8 @@ int send_pack(struct repository *r,
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	if (need_pack_data && cmds_sent) {
-		if (pack_objects(r, out, remote_refs, extra_have, &commons, args) < 0) {
+		if (pack_objects(r, out, remote_refs, extra_have, &commons, args,
+				 &excluded_boundary) < 0) {
 			if (args->stateless_rpc)
 				close(out);
 			if (git_connection_is_socket(conn))
@@ -878,6 +886,16 @@ int send_pack(struct repository *r,
 		}
 	}
 
+	/*
+	 * Per-ref pushes prevent one ref's boundary from excluding objects
+	 * needed by another.
+	 */
+	if (ret < 0 && excluded_boundary && pack_contributing_refs > 1)
+		advise_if_enabled(ADVICE_PUSH_SHALLOW_BOUNDARY,
+			_("A shallow boundary may have excluded objects needed by another ref.\n"
+			  "Try pushing the refs one at a time, e.g.:\n"
+			  "  git push <remote> <ref>"));
+
 	if (ret < 0)
 		goto out;
 
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index e52f3e50e2..f2a84eb227 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -343,4 +343,35 @@ test_expect_success 'push to a shallowUpdate receiver rejects a rootless snapsho
 	git --git-dir=seed-receiver.git rev-parse --verify seeded
 '
 
+# Splitting a multi-ref push recomputes the pack and avoids exclusions from
+# one ref stripping objects needed by another.
+test_expect_success 'incomplete multi-ref shallow push advises pushing refs separately' '
+	git init hint-origin &&
+	git -C hint-origin checkout -b A &&
+	test_commit -C hint-origin --no-tag has-shared sh shared &&
+	test_commit -C hint-origin --no-tag A1 &&
+	git -C hint-origin switch --orphan B &&
+	test_commit -C hint-origin --no-tag B0 &&
+	test_commit -C hint-origin --no-tag B1 &&
+
+	# Strict checking rejects the incomplete pack before connectivity.
+	git init --bare hint-receiver.git &&
+	git --git-dir=hint-receiver.git config receive.fsckObjects true &&
+	git -C hint-origin push "file://$(pwd)/hint-receiver.git" \
+		B:refs/heads/B B:refs/heads/A &&
+
+	git clone --depth=1 --no-single-branch \
+		"file://$(pwd)/hint-origin" hint-client &&
+
+	git -C hint-client checkout A &&
+	test_commit -C hint-client --no-tag cX &&
+	git -C hint-client checkout -b topic B &&
+	test_commit -C hint-client --no-tag reintroduce sh shared &&
+
+	test_must_fail git -C hint-client \
+		-c push.shallowExcludeBoundary=true \
+		push --force "file://$(pwd)/hint-receiver.git" A topic 2>err &&
+	test_grep "shallow boundary may have excluded objects" err
+'
+
 test_done
-- 
gitgitgadget
