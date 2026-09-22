Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3C48EC85
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116293; cv=none; b=jGrGGg1aW7hDiiP1Ki5raHcgHFK4Szb+Sqolsz6rqnpr1Yi5fcubdt33hfVGoRREkeclwUny4NyKHVhC25ldubwkXzpmv7vfVDwQIAWq3tx58l/VXAoK5SqrTjHeltryC2u1Q9uyZ5WyEbqyEO+/lQD5uGbrgCP0VaulWufA5oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116293; c=relaxed/simple;
	bh=LtAkwnTUSb4eoIfPnPPjBZPe4sC5Hs69Et84EdQXQsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=St0505bDwgY11KHtsJJSjf4BTea8TQcCdw6z7asEBmAzNNXQJK6xgXvMygrxyYhhNPxC5w82DBPvOPsGwtIkNciRcTNLGhA0BWIvBKpt9YERR5nHmo617qsqgr0JbKIlqvnLxAF86c8C8rjmFgU9mYkPtsBImxbwl1UeuYbQzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ur8hwght; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur8hwght"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c294496989aso37847066b.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790116273; x=1790721073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OdFvMzdiQR4Am1DargeTQXYft0VC/BxK3HyEfoSvo9U=;
        b=Ur8hwght0X/HIwhLaxWtF3KwoFQlvH1Dt93isbu67FUlZyrqPkmy6/3kmCiCgYva+6
         j5WpD+N/A4BEHJCxoI+rPVerL2JvNsuQabEZe7pDRhaic+XpQhw8ba/VmMkY4M3i/YVS
         hjfvz2reZxpsnKRYb8r/poYCeCiDnFKHOsUTeaPQ1uwjHWm+KTG8YJJcMz+1Mq0V1ldP
         QrHBkPGdAHeym9up1vo2Bdm8KCqFVrofEv6xTn6HzVK0/MILq5knY91n5iL/hoPbacP9
         aOaUfq8ctwEII+g63Bg0ruArwcvX/W1xvjiKAY++L41XW7NHxFDdzjRyyqzPUxMPYiLt
         Pcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116273; x=1790721073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OdFvMzdiQR4Am1DargeTQXYft0VC/BxK3HyEfoSvo9U=;
        b=hjc5XRwyKoFkUp061WzGHhGwt42nv35O3mWSmt7E7/LYXgLVgaX9fD8rsuMOM0fsW6
         0PhNhwJENjqmI+jS9Qia4dqP4UBwujZGZsADBu/02+/jCZ22a5+rILq1wJ/uI3LIUUxd
         rCgLlpP1VmpfgVZmUUxxLY4SqbuG0EZ1aVA9hhH/tmKRdU84GwKvyGwT6s/SgrUr8fOs
         /dZsE2oVd6tIiKcZuRyl0Zzl3bu67ramyE0e5ZO47VcpaAlutbkPxx9AaNSVUmMQcwFp
         sl9GwCS4WRUg/xywCTFXINTx8uGTPvPoBrzPiI1QZZqwQihq7cS7U7YTSDT+K2VkZc48
         /5/A==
X-Gm-Message-State: AFuF++k5L/A8B42CM9BGrTRNGsQyMgR+EhXVuMVEVK9Gh4M6pkES/C6R
	K8FMTlQzCeaB3xpLtwKeKE32OuhznZt9fLaaSPAKw0K/jT8pJFkCbyBnHr84KGlT
X-Gm-Gg: AYBFou39ABw6v1q/8YZwnqEmoPeXZP8sBLyCl8aUAGxsz8xeVAylH7SqIFTRCmiQp/h
	7hM9+vSya5T+UEaj9ebF/Vqt1jE+8Vu0ZjJY2vBymRPXHd7CjXrBQbHN+zNcS+8IckFoiXOXMbf
	d0hCssc++UQpHFtgKovQly8IGSgF3QSBAui3bFHihD8KDxtYmZf4t63M2/2JJNoONL87Lr4V+GW
	ueUO4E+5aKBcIuVthhpz4lyS6Po9Laei52JQYw2P3hGjmnXaaT/AkPPiBnD+5UbBD/f2I4oNyXw
	d7lZxcamTt+C289DpFQ/kJIlSWHoNTmJjVKiU9paEq5ta8DCM+3yVk5EzTYXY0e1ZN3wCmAskyH
	aRgdlTFEYKArEOBuxb4sXm5EgrsIFr0QbIMezmHWUbnpCvk6iB0OSmgNxJ4vBPuHK0izKSFv14W
	33Pp45w48TfN/ipqmXllNDSQDsdc2TvpwcwUqyL8C/Ad8nJR+zfex46QDhwFCwum1AvfOQpZBuC
	iMzuDPQ330WWNnKnxlbl1G0ZPIOlTuX705FaUzbWKjAK67bYP9/nM04kVaSJ9AgCzr05mQpP/8k
	tlHqvtWeADb4VwzTuA/Vs0moDi+TJZRvVvswUD/9MyrUQ+pQ
X-Received: by 2002:a17:907:86a0:b0:c1f:983f:d8a with SMTP id a640c23a62f3a-c2aadf13effmr51879966b.24.1790116273179;
        Tue, 22 Sep 2026 15:31:13 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5524sm20847566b.21.2026.09.22.15.31.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 15:31:12 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: [PATCH v4 2/3] branch, tag: retain old OIDs in batched deletions
Date: Wed, 23 Sep 2026 00:31:09 +0200
Message-Id: <918c97d2b4589f6616de33dced7471119ba86fde.1790113781.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
References: <cover.1790079917.git.maciej.ciemborowicz@gmail.com> <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
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

The conversion to batched deletion dropped those old OIDs. Besides making
the deletions unconditional, this causes reference-transaction hooks to
report zero as both the old and new OID.

Both commands still resolve the old OIDs before starting the deletion. Pass
those values to refs_delete_refs(). This restores the old race protection
and lets hooks receive useful old values without adding ref reads. If a ref
changes concurrently, reject its deletion and preserve the new value.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 builtin/branch.c                 |  6 ++++-
 builtin/tag.c                    | 27 ++++++++++++++------
 t/t1416-ref-transaction-hooks.sh | 44 ++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c9f259d04..4ce1407bc 100644
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
@@ -248,6 +249,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct oid_array old_oids = OID_ARRAY_INIT;
 	struct string_list_item *item;
 	int branch_name_pos;
 	const char *fmt_remotes = "refs/remotes/%s";
@@ -342,6 +344,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		}
 
 		item = string_list_append(&refs_to_delete, name);
+		oid_array_append(&old_oids, &oid);
 		item->util = xstrdup((ref_flags & REF_ISBROKEN) ? "broken"
 				    : (ref_flags & REF_ISSYMREF) ? target
 				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
@@ -352,7 +355,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 
 	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
 	    refs_delete_refs(get_main_ref_store(the_repository), NULL,
-			     &refs_to_delete, NULL, REF_NO_DEREF))
+			     &refs_to_delete, &old_oids, NULL, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
@@ -377,6 +380,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(describe_ref);
 	}
 	string_list_clear(&refs_to_delete, 0);
+	oid_array_clear(&old_oids);
 
 	free(name);
 	strbuf_release(&bname);
diff --git a/builtin/tag.c b/builtin/tag.c
index 40874a292..07116664d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -105,28 +105,38 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 	return had_error;
 }
 
+struct tags_to_delete {
+	struct string_list refs;
+	struct oid_array old_oids;
+};
+
 static int collect_tags(const char *name UNUSED, const char *ref,
 			const struct object_id *oid, void *cb_data)
 {
-	struct string_list *ref_list = cb_data;
+	struct tags_to_delete *data = cb_data;
+	struct string_list_item *item;
 
-	string_list_append(ref_list, ref);
-	ref_list->items[ref_list->nr - 1].util = oiddup(oid);
+	item = string_list_append(&data->refs, ref);
+	item->util = oiddup(oid);
+	oid_array_append(&data->old_oids, oid);
 	return 0;
 }
 
 static int delete_tags(const char **argv)
 {
 	int result;
-	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct tags_to_delete data = {
+		.refs = STRING_LIST_INIT_DUP,
+		.old_oids = OID_ARRAY_INIT,
+	};
 	struct string_list_item *item;
 
-	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
+	result = for_each_tag_name(argv, collect_tags, &data);
 	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
-			     &refs_to_delete, NULL, REF_NO_DEREF))
+			     &data.refs, &data.old_oids, NULL, REF_NO_DEREF))
 		result = 1;
 
-	for_each_string_list_item(item, &refs_to_delete) {
+	for_each_string_list_item(item, &data.refs) {
 		const char *name = item->string;
 		struct object_id *oid = item->util;
 		if (!refs_ref_exists(get_main_ref_store(the_repository), name))
@@ -136,7 +146,8 @@ static int delete_tags(const char **argv)
 
 		free(oid);
 	}
-	string_list_clear(&refs_to_delete, 0);
+	string_list_clear(&data.refs, 0);
+	oid_array_clear(&data.old_oids);
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

