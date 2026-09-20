Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818D3F4DFD
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789901670; cv=none; b=ZDP3PQAe32NAgr2Hs3O+1LMnYZDPn20urncY5vLU9+cNGDxuxY9v7zNrD+kCB4ErrTkde6talq5sEufs/9JQl6xwy+XzlCWxN61K5Mr5oxC5t1DjEpjArcMEIWtnZiI5VgM4u0DIvfEQgS2tFrBKaff+M5cA06el/UlxFIeq5bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789901670; c=relaxed/simple;
	bh=WNVmrctR7Vr5I/zkyMzDav22TQ7+mt+ksDnl+YkcYBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKMFYx2iflMK6SqRg6WSSpxVBByJq8D1IgGwsMEia4PnGbX23oH6gXe/tz251ccUy163Jl4WEyaqm6Z7za//9Lu5pdyxPp4suNBhBNGh5184Ve4wFd17aHBfSHF1QKmbwJo/pEvZkoiUzuCEL5v/XIpzHigyilNn8BkLRFl0RzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ0K95Ec; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ0K95Ec"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7dbfso224625066b.2
        for <git@vger.kernel.org>; Sun, 20 Sep 2026 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789901667; x=1790506467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ud/Llf9QBJW58Hzxz4g0lDeWSqjbBunUOLBjm8Tyi4E=;
        b=HJ0K95EcDwctQIl2ihj68xRMSEzRWj4NSl55koCV7uK+FwB9bogu4Ga7QoIT39qkJd
         U7SSzCm87PeeeKbCQzuz0VqAnlvtpcYMmyOEaGYqJSREgXVZJdxWdaDs98Id8Toj6R+0
         5cYwlt2bD3FXZsDwtbxAPOlV21HuzIs4Fvclg9Z4ddjczhG0D60ydYOUCBZ5xUeWkYBh
         VYkbML1WuJeSyKw/fjVju8vDX34JzWLrxVAADOYobZ8VHSsD1wRrkaAtQBE8v13NARon
         2DiyvtseOFOIoM+rOEqz/1X9LsCFDt5PpA0uWvoCW5cqM1EnZUqAIJ1NHYMhWa48MEjN
         NQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789901667; x=1790506467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ud/Llf9QBJW58Hzxz4g0lDeWSqjbBunUOLBjm8Tyi4E=;
        b=k6npckJ+HBalXlicvvnPIJhOyhSVtfnW3razOJ6L2s0a03Lv/JbAikz98TTiJAxKkO
         Acz4RIk6xJRvLicBYg76g32/C9nnCYwcti3GiSMNglT32BlYlukeGEownIm/ot3rzNA1
         MhboO1PWcSMckSeaiDUIclioL/4/XtVSGwqbfLkZj4kVPbQbwaErq+RoNQIfQYYoG8K3
         FBLc6F4bRgJoRkeQGscPPI7B3m2nCmKz274cTWT0YXf0uZ67lDGrmktd9U2xY6fo8hq1
         DZymRH5bLlUC8tf0ym8yUIspAb/mQONhAtII1zXE3Nc/Gh42fgfqJPTUlAe/ffYRoJ+j
         sTOQ==
X-Gm-Message-State: AFuF++msrV6rKeY7EuwvfVu0NYr2fADFrkP/ZkMbqQVrj7xRINCDAdGn
	IyF+DkFhtnVETCpRtX8FyU/JNBdZb924F4kzxjogeNkGfC01+yD4R68c4D3JVH26
X-Gm-Gg: AYBFou3RKTM4nnhtBj+Bu5zlLqRn2qM6OggN0rrnVfIP7bpqQTvmfXmhHBpeJXbNcFw
	94jWlCgMwlcIiNAbbAwU0PeekeWIhiMbKyokdMZMTBaIFXo2hBL8tC9O7OGiWtuXngMwSOWyNjb
	qottz7RBKIVCHysARvKwP3vwmCEH2K5kzi8/DVCrc7c75G4wkgsm1LLyZflytMJitM99OoIj1Jq
	VO2SAOqFmcsGeAktjCOeG+DiEpw5Ybts4QDMRWcrt8+T1hzmzUZ5e34H7mDWOSHYECcyayojUq9
	ZLEnElTmqHQgzZ78pCtT8bczYNOo19BbWFNEsp7KMYBr/a4XgMIbcWjTZlgvP9SHowxKBRsoHOl
	Ktis3VglGTOSioHKTfh2XLMuX/g432AUCHTJpNHZ4dOa+e345DDqTqYSKhGL4Qtj7tb38v2zqGH
	HVn7raILNVOxmVJuYqbFjuzrsWGzvRvzHeMN4WVKHEtSt7aGhecDwWih+sTdmdJAQGYVNFUcmyN
	zezbl7lvSc3DUp8h6o5T5o/KLz4s4O046x+8u6Zji9QHQ7CCtogIw7HS3bihRgjPuYOzyqcSQ3l
	TYrT9OeovtKWFRLMwhdf3fIjzYN8LcTQu5XNSehCCvhA57gyxJVd5aNcSaeGZ7RukI8Oe5lCepv
	mhXo=
X-Received: by 2002:a17:907:3e0f:b0:c27:420b:7c90 with SMTP id a640c23a62f3a-c2a1588651fmr645296766b.48.1789901666743;
        Sun, 20 Sep 2026 03:54:26 -0700 (PDT)
Received: from localhost.localdomain (138.54.classcom.pl. [195.150.54.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a35239469sm170989666b.6.2026.09.20.03.54.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 03:54:26 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 2/3] branch, tag: retain old OIDs in batched deletions
Date: Sun, 20 Sep 2026 12:54:21 +0200
Message-Id: <d00fdeba2f673cf5a174f919452694c733736e84.1789901584.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before 8198907795 (use delete_refs when deleting tags or branches,
2021-01-21), branch and tag deletion passed each resolved old OID to
delete_ref(). This prevented the command from deleting a ref that another
process had changed after it was inspected.

The conversion to batched deletion dropped those old OIDs. Besides making the
deletions unconditional, this causes reference-transaction hooks to report
zero as both the old and new OID.

Both commands still resolve the old OIDs before starting the deletion. Pass
those values to refs_delete_refs(). This restores the old race protection and
lets hooks receive useful old values without adding any ref reads. If a ref
changes concurrently, the transaction fails and preserves the new value.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 builtin/branch.c                 |  6 ++++-
 builtin/tag.c                    |  6 ++++-
 t/t1416-ref-transaction-hooks.sh | 44 ++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f1abeb681..9f03ebc09 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -16,6 +16,7 @@
 #include "commit.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "oid-array.h"
 #include "remote.h"
 #include "parse-options.h"
 #include "branch.h"
@@ -230,6 +231,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct oid_array old_oids = OID_ARRAY_INIT;
 	struct string_list_item *item;
 	int branch_name_pos;
 	const char *fmt_remotes = "refs/remotes/%s";
@@ -314,6 +316,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		}
 
 		item = string_list_append(&refs_to_delete, name);
+		oid_array_append(&old_oids, &oid);
 		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
 				    : (flags & REF_ISSYMREF) ? target
 				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
@@ -323,7 +326,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 
 	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
-			     &refs_to_delete, NULL, REF_NO_DEREF))
+			     &refs_to_delete, &old_oids, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
@@ -342,6 +345,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(describe_ref);
 	}
 	string_list_clear(&refs_to_delete, 0);
+	oid_array_clear(&old_oids);
 
 	free(name);
 	strbuf_release(&bname);
diff --git a/builtin/tag.c b/builtin/tag.c
index 40874a292..0a3eb70fa 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -119,11 +119,14 @@ static int delete_tags(const char **argv)
 {
 	int result;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct oid_array old_oids = OID_ARRAY_INIT;
 	struct string_list_item *item;
 
 	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
+	for_each_string_list_item(item, &refs_to_delete)
+		oid_array_append(&old_oids, item->util);
 	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
-			     &refs_to_delete, NULL, REF_NO_DEREF))
+			     &refs_to_delete, &old_oids, REF_NO_DEREF))
 		result = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
@@ -137,6 +140,7 @@ static int delete_tags(const char **argv)
 		free(oid);
 	}
 	string_list_clear(&refs_to_delete, 0);
+	oid_array_clear(&old_oids);
 	return result;
 }
 
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 4fe9d9b23..01b5ba8c4 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -14,6 +14,50 @@ test_expect_success setup '
 	POST_OID=$(git rev-parse POST)
 '
 
+test_expect_success 'hook gets old values for batched branch/tag deletion' '
+	test_when_finished "rm -f actual" &&
+	git branch to-delete PRE &&
+	git tag delete-tag POST &&
+	git pack-refs --all &&
+	test_hook reference-transaction <<-\EOF &&
+		if test "$1" = committed
+		then
+			# Ignore backend-internal zero-to-zero records.
+			while read -r old new ref
+			do
+				case "$old" in
+				*[!0]*)
+					echo "$old $new $ref"
+					;;
+				esac
+			done >>actual
+		fi
+	EOF
+	cat >expect <<-EOF &&
+		$PRE_OID $ZERO_OID refs/heads/to-delete
+		$POST_OID $ZERO_OID refs/tags/delete-tag
+	EOF
+	git branch -D to-delete &&
+	git tag -d delete-tag &&
+	test_cmp expect actual
+'
+
+test_expect_success 'branch deletion rejects a concurrent update' '
+	git branch delete-race PRE &&
+	test_hook reference-transaction <<-\EOF &&
+		marker=$(git rev-parse --git-path delete-race-once)
+		if test "$1" = preparing && test ! -e "$marker"
+		then
+			>"$marker"
+			git update-ref refs/heads/delete-race POST
+		fi
+		exit 0
+	EOF
+	test_must_fail git branch -D delete-race 2>err &&
+	test_grep "is at $POST_OID but expected $PRE_OID" err &&
+	test_cmp_rev POST refs/heads/delete-race
+'
+
 test_expect_success 'hook allows updating ref if successful' '
 	git reset --hard PRE &&
 	test_hook reference-transaction <<-\EOF &&
-- 
2.39.3 (Apple Git-146)

