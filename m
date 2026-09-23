Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C9C3A5E89
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197491; cv=none; b=eUqDwJ1IcCIszzTOCdwp0ogmwz6bPsRjLqsBr2V7W+ponIXDuzbIdsRnpDz7Z2+xrATsu1cpbNfKZRdychdLDl4p6a1xO/Dd+tTOLVHhtwZoaGzt/6yXKReJztEj3kPuqdvs3odkyroSNlwoepfgpNbWFaSb3WDHfgwsIAb6A54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197491; c=relaxed/simple;
	bh=q3qn/mIjY+WY+IgESaS66VphyoT/N3kRFXZuhqaBDX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fu+49+r8BLGdJNER/tmdDdoGOpW/J87SjqAa36+Sf0AtgfWcgMLMperB5P5YfH+xUDjqPN7O6HWjiF0HuZBjDjvNESgb8B6MpP/J5SxbdSE3UrA6Ep0JlZIbpRtkZ3Nwq/S1GQAXy42lMJ/X+FgarAls+VqQNPGK1Hs0rVR1p6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaSknPZ0; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaSknPZ0"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a4aso190297166b.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790197487; x=1790802287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LX33zgcZirjlNVT7JeEQxlYO0oYEHIgzqp//XtwDxz0=;
        b=AaSknPZ08w7fKOIvgirOnNuyIz7hsqHeLz+zQ0zzcUe1iX6PH1jBIbOVclXwbAFPP7
         x5ImLvg3u2/GwP9FsFxXASobLVmy/tUJwLH2T0MwXG6n6GNTPgIE0TiPlY6IKTkhWift
         mylnQWNqS7HTcHq+T/inzDPN0ehcBpyKKraz+vOV3nK3Ko09q9KMLUp2tlHTjcTR48Pf
         fnbqIaJpr50Pw9uZViA0PrUaIQVk0SOpGTgROJ+/9pbs8poyX0aaWkaJ93jTzZGpKq3A
         iUVqsYA/7AT4JgYp9ce+Nx+22bbQ5cAN3cQ+GYx/3Xni0lC+jrL+2ngoR3B+cFJRoLTg
         oMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197487; x=1790802287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LX33zgcZirjlNVT7JeEQxlYO0oYEHIgzqp//XtwDxz0=;
        b=U0KudqIS6NCUffyQPCSZNQq5OgApuARV133hm54KN/fDQjBA7XWCceTs22/WGToOh5
         BYQQOufB1qeMqm3FDcr3jAorvMIWlDiirZgCaVNDPmeZlfv1mdzLG3RSqlTTjYMah9/L
         i3hmlxxnRYnx+uQnUMVnY3CkylgmEhw0M8rEPrHllQg783fnBUrc1SCn7dT1Y1yD75sW
         NE8I/HdAgoF+8lOurEUs/TBYrTXxxFYcF/4bX9WVMveHZLFN6e6U49zbAAx4L89a2a+D
         Ai1lBzSH4MJ66ohfBPw8AOwxTqW31H3DLDP3ZoSL2pT33SQ4dnhe9GNs1olsuk1Ydrio
         VrlA==
X-Gm-Message-State: AFuF++lK+Eoed4KDRFppnZ/dtMH5DkeInwoP+XupsPpr8eIG7HklnOTk
	a91byyCl1/iXD+pRLydBgKfXaz2jY5UW/InOu4xv6dz58HDpnBn523J2o9Lk7mN+
X-Gm-Gg: AYBFou2k21gFzRzmCLfavaUAD4EI+bPGcqF8l7MYw9030ptGUx0qrcUZcuxX1C0yWyZ
	Y2Z0MoZYapL6X3PJYbeM6xsFo7uE2GQ/zfeIn897GfWHvxdHfnPAYsAkR0en9kKdC9jjWYnIjIz
	CBpO4dTSFRw1tzl5Lbq8UkROwTOt2oneSwZdi0CTmGMUvkGjEdFLILpT930w6XFYQGj7lbpdHNG
	GOjV80s39+mdx6pkn2LmedVVktfY3wdZn5rqfBRQ9od9+6mGY/nPBMouZpd1DiBUlnE0k7rvXcw
	5CRjVCIIM/ZPteXWKfbWpy7CL78XCNKuQOmRyikf/o3hb/5bdpzfW5/T29Va0jdLDGoZxklOxbK
	/sVXjWeVB8VD9OXy1I5Xy1pK/XBveWC9ECLmzqLNkMLX3TnxvlhT/MQFh/NtetX/+ceVaOMsEJC
	/+EWxtKq4keKHmQM0js9c47HmHa7qhrkozW3IPD2hTFl4+FVXLD76aB8FBxqYBav0YIFkWO/JmO
	VoAr0upBv8ZVH4Hy3rtq8HSZOXF115xE74kJUcjQdvARFX5PQLwiSHVfMDn01s8y1agtPK3SmBK
	zWyCyI+0OcgHAfIoj2iJS6n8xeMthwGdBMv48+ImYNo8BUT5gYjPDkP/5KQ=
X-Received: by 2002:a17:907:94cd:b0:c26:3478:fbb0 with SMTP id a640c23a62f3a-c2ac226d40amr30663666b.11.1790197486964;
        Wed, 23 Sep 2026 14:04:46 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae60e4c8sm189325366b.26.2026.09.23.14.04.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 14:04:46 -0700 (PDT)
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
Subject: [PATCH v5 2/3] branch, tag: retain old OIDs in batched deletions
Date: Wed, 23 Sep 2026 23:04:41 +0200
Message-Id: <6a8401c448f527fd80c162908a2736811a723096.1790196627.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com> <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
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
index baccefc77..4ce1407bc 100644
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
-			     &refs_to_delete, NULL, NULL, REF_NO_DEREF))
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
index 40157e834..07116664d 100644
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
-			     &refs_to_delete, NULL, NULL, REF_NO_DEREF))
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

