Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB74361DC3
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651762; cv=none; b=SqdbUGK6gXA5rU6GTzcoz4B0XRFhRACizvzCwTE9iIBPz0FpKg97LTu3TaE1qaeXLlL/rPIvGSlYoKeO095QCoU2L33Oi4d1UM3s1e/+my+spO3m0kTxFfkdsjWTWz/Ozz1Hhaw0iM9Zw7+pxO9xV+gomi6gn/CvQ92a149gPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651762; c=relaxed/simple;
	bh=DHzM2FX6j1j4eezC0A/uNXs9av9EPrIwlta8htJ3ZGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncSy+WDs2OoMU046TRtqdoea18QHvrlIGCGKNXOD5udEgXMSno3oVW6pvuU9H43mMi95bz74ddhiTm4mTxyPS/w1w6RBxXA1KMlZIhbuDLP42fhHBvnMClUju+vhl+po5kdm42C7Wx7L/9TOfr70ah1zpUeyiCzecOMo4Wi9CTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT6HIMtd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT6HIMtd"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caf228a910so3129805ad.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651760; x=1787256560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00vQQ+f/4RxGxwqvQcXKp/0Uzqko62qgxb6eWmG+F4o=;
        b=VT6HIMtdoOAZY4F992p6bfuasmQFEYQmnSSUw7GGqaLeGtJmYo41EVUXidmSmGayGy
         nUDVsriYBXbMcx6eCh/s2waH9zxpskzOqCHrkxeAUr2lF2Pn1u4MCZnwwhZzaa8EtwCY
         UzeG5+Rr53fviglpa19c24bH6vpxno35IZoY/2RyzlNEIC6XTG4j5XWOqXkCnqk1SC7l
         ZPndyPwz6d3V7CKTsUVlF8+oUuAxF8542IkvOGFbs741FpGLwz7P0DNDGRdyak5+FEf4
         hVw/DcreZ93uLeS6shYql/MXa2uEOGCdaZVGXyoj/lrIeDw6by7r1uD7Vv0yvSNyV7Lb
         94fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651760; x=1787256560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00vQQ+f/4RxGxwqvQcXKp/0Uzqko62qgxb6eWmG+F4o=;
        b=V0NS1tu1L2xh96MkF4DYumHY6k/DVfRzR0hCuCq2YjgV957Z2Hrg1qL6loXx2Sh39f
         mUPBBZM2etDo2SqskI4cbssZdw/9r2yH3ckxqLzRrk0qx7CFM3L+A/YNHffmrPXOa6ag
         Qhz+X0aQm0ENurcqPb0YCRMqNjW5NWICIchqdl64scy2JxJqwSGaAoVEmHgBHrbXVQuR
         xEqSUFsmzcPePzdE5Zc0Trg3/JgWo41yDtT1jEMq+bJxvGCLzMuYQTsKnYXU3Dst+yBO
         tX/I3m0Z0xuJPRgtQIve75KDjggkDaJ3IGgjAuKp4caLBt2z7B/YriuM8fsm0WpG/mkz
         1cNA==
X-Gm-Message-State: AOJu0Yzn7E2BCQSELcnbr1Wwq5xYFxTqaisUvbyKfUTWJSHK7+S2yK4V
	ByjbH+KFhlCWDw2CZbtG/T7RTejs7StGp2lx8qOVgAT9aeszu7dAgd2V1BRQK3Wf
X-Gm-Gg: AR+sD11sBHiZNW4OTQ6XDomiyNoTneTzj6q1N4ucoR3z0yjJZVPs5+VHZIp1qlQSPGj
	AQTc/Lrw11ZG8xVDNkPWizeIqmNiutcF90t5oK67HoJEn8b4a/4NAvxBY/+FfoD8a8L8za8GSzc
	pBDQtCoZvi0KxEokl3ivZCp0Qv4Es18/4rHFj0mZhLXEQSZ9Wcgg29wyw6DFuzMoxqN+aV9gvln
	DfUUOK+kBxHmsmYSxz8VSn6Vb3zJTzAEqidcjEyFp3pKjN6JignuI6gq1pDUailnlDkuG/k0yoR
	HySuCB8LEbPLPVjAgCltrKUklbnSEMuUEcYTjUqwiOPhIi+uV+y8EIiTX4+oHr7Jf9wdR6dqxzt
	fRSY30Od2RhDGgw2j9+Lccs6xLj0mcVouCyFV3YW3FgNWK+MlPMtEAhmhvFP2Ybt7E0snLE2qn7
	Rr+935ykhtY6NWfFXIGuPNNJawWenKbk6Vgb7VR27wkyCP5FpT4h3tUbP29n7sTpBSnjfpus/4U
	WSflTqUpVqLjjKjk5i/gpqLZrE7rwEtpFZP+8hdjVX1KG4MSrX7HBR4UTwKK2g8xo9OWdXhOS/Z
	fPPtm7Vj0yGFHjyBSZS//g==
X-Received: by 2002:a05:6a21:150b:b0:3b4:605c:2163 with SMTP id adf61e73a8af0-3cc71af19d8mr344875637.4.1786651759752;
        Thu, 13 Aug 2026 13:09:19 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:ad47:4055:841d:89ad:96b0:2f73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm1533440c88.6.2026.08.13.13.09.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 13:09:19 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v5 6/6] builtin/repack: add guards for --drop-filtered
Date: Fri, 14 Aug 2026 01:38:30 +0530
Message-ID: <20260813200830.84348-7-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
 <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--drop-filtered removes local promisor blobs. That is only safe when the
repository is not mid-operation and when the blobs are not actively in
use, so add two guards, both skipped for bare repositories which have
neither a worktree nor an index.

First, refuse to run while a merge, rebase, am, cherry-pick, revert, or
bisect is in progress. During these operations the working tree and
index are in an intermediate state, and rewriting packs and deleting
objects underneath a half-finished operation is unsafe.

Second, refuse to drop a blob that the current index references. Such a
blob is needed by the working tree, so dropping it would only cause the
next command that touches the worktree to lazy-fetch it straight back,
reclaiming nothing. The offending path is reported so the user can see
why the drop was refused.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 Documentation/git-repack.adoc   |  9 ++++++
 builtin/repack.c                | 52 +++++++++++++++++++++++++++++++++
 t/t7706-repack-drop-filtered.sh | 35 ++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 130249a139..a1f9e64f66 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -204,6 +204,15 @@ and with bitmap writing (`-b`/`--write-bitmap-index`), since filtering
 breaks the single-pack closure that bitmaps require. A bitmap setting
 coming from configuration is silently disabled for the duration of the
 command.
++
+As a convenience, since dropped objects remain recoverable by lazy fetch,
+`--drop-filtered` refuses to run while another operation
+(merge, rebase, am, cherry-pick, revert, or bisect) is in progress, to
+avoid a surprising network fetch mid-operation, and refuses to drop any
+blob that the current index references, since such a blob would only be
+lazily re-fetched by the next command that inspects the working tree.
+These checks are skipped in bare repositories, which have neither a
+working tree nor an index.
 
 --dry-run::
 	Only meaningful with `--drop-filtered`. List the objects that
diff --git a/builtin/repack.c b/builtin/repack.c
index a5f13fdd87..c4360382c1 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -17,6 +17,8 @@
 #include "list-objects-filter-options.h"
 #include "oidset.h"
 #include "hex.h"
+#include "wt-status.h"
+#include "read-cache-ll.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
@@ -317,6 +319,33 @@ int cmd_repack(int argc,
 		if (!repo_has_promisor_remote(repo))
 			die(_("--drop-filtered requires a promisor remote"));
 
+		/*
+		 * Refuse to run while another operation is in progress. A
+		 * dropped object would just be lazily re-fetched when the
+		 * operation resumes, but triggering a network fetch in the
+		 * middle of a half-finished
+		 * merge/rebase/cherry-pick/revert/bisect is a poor
+		 * experience, so this is a UX convenience rather than a
+		 * safety measure. Bare repositories have no such state, so
+		 * the check is skipped there.
+		 */
+		if (!is_bare_repository(repo)) {
+			struct wt_status_state state = { 0 };
+
+			wt_status_get_state(repo, &state, 0);
+			if (state.merge_in_progress || state.revert_in_progress ||
+			    state.rebase_in_progress || state.bisect_in_progress ||
+			    state.cherry_pick_in_progress || state.am_in_progress ||
+			    state.rebase_interactive_in_progress) {
+				wt_status_state_free_buffers(&state);
+				die(_("--drop-filtered cannot be used while "
+				      "another operation (merge, rebase, am, "
+				      "cherry-pick, revert, or bisect) is in "
+				      "progress"));
+			}
+			wt_status_state_free_buffers(&state);
+		}
+
 		write_bitmaps = 0;
 
 		/*
@@ -332,6 +361,29 @@ int cmd_repack(int argc,
 		if (ret)
 			goto cleanup;
 
+		/*
+		 * Refuse to drop blobs that the current index references.
+		 * Such a blob would only be lazily re-fetched by the next
+		 * command that touches the worktree, so dropping it reclaims
+		 * nothing. This guard just avoids that churn. Bare
+		 * repositories have no index, so the check is skipped there.
+		 */
+		if (!is_bare_repository(repo) && oidset_size(&drop_oids)) {
+			struct index_state *istate = repo->index;
+			unsigned int i;
+
+			if (repo_read_index(repo) < 0)
+				die(_("could not read the index"));
+
+			for (i = 0; i < istate->cache_nr; i++) {
+				const struct cache_entry *ce = istate->cache[i];
+
+				if (oidset_contains(&drop_oids, &ce->oid))
+					die(_("cannot drop '%s' (%s): it is referenced by the current index"),
+						ce->name, oid_to_hex(&ce->oid));
+			}
+		}
+
 		if (dry_run) {
 			struct oidset_iter iter;
 			const struct object_id *oid;
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
index 80c695742f..cb36115834 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -147,4 +147,39 @@ test_expect_success '--drop-filtered removes the promisor blob locally' '
 	test_grep "$SMALL" present
 '
 
+test_expect_success '--drop-filtered refuses when a merge is in progress' '
+	test_when_finished "git -C repo merge --abort || :" &&
+
+	# Create a conflicting merge so wt_status reports it.
+	git -C repo checkout -B mergebase base &&
+	echo one >repo/conflict.txt &&
+	git -C repo add conflict.txt &&
+	git -C repo commit -m one &&
+
+	git -C repo checkout -B mergeother base &&
+	echo two >repo/conflict.txt &&
+	git -C repo add conflict.txt &&
+	git -C repo commit -m two &&
+
+	test_must_fail git -C repo merge mergebase &&
+
+	test_must_fail git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k --dry-run -a 2>err &&
+	test_grep "in progress" err
+'
+
+test_expect_success '--drop-filtered refuses to drop an index-referenced blob' '
+	# Create a large blob, add it to the index and make it a promisor object
+	# so the index references it and enumeration picks it up.
+	test-tool genrandom idx 4096 >repo/tracked-big.bin &&
+	git -C repo add tracked-big.bin &&
+	OID=$(git -C repo rev-parse :tracked-big.bin) &&
+	printf "%s\n" "$OID" | pack_as_from_promisor >/dev/null &&
+	delete_object repo "$OID" &&
+
+	test_must_fail git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k --dry-run -a 2>err &&
+	test_grep "referenced by the current index" err
+'
+
 test_done
-- 
2.54.0

