Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71B3033F7
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848771; cv=none; b=bs/rUsuJQNFihnJ5u2dOmrnwAkmO4YtRPRAvt+4qqx/t/5dtw3iRHj/5ZLTtMeajg5W9Y84wW+a8SMDn8qbx7g9R5cx3BxbNe36Gzd8vfsUeM/yy5kEM4Nh+mB7pFFMEgytcULNmeLEfGoNewuXt+YeRBO73Xiyv2g7lQlr/hp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848771; c=relaxed/simple;
	bh=8MxC/vnb8DYpMcZYDXOeWajSYozvU7bCe5ftSsVrf6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qNn70QeIy+4P94QeQ7bu2E0EFfAW8JU95ZPJ+XmcbuGIJJXWH9s4sHRxWbARD2xn0zyDsUTWImEQD75PlP+1beSGnXG2rYto/FP14sSF4ue8gNsnGIP8JANZGIcaask80+pvYXVPMy+/tCzJtwF9qtWWyMjR17Nzn8XCefnFS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky4h0/i9; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky4h0/i9"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a99c5de614so2368385a12.2
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789848768; x=1790453568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OPbv2BRHLxzPOe1/vca0l+ECBDzug0FIwNuhoSLLeRI=;
        b=Ky4h0/i9PdZFTjGCVJmEtScpDerc5pabM6aJuB55h+HR2z7gWdQY26kxNF13rMKkRm
         Ipgnh0V22rqf1GbVl+u1UO2+GKTV7XyDPf7jmnbzhwAO86XOhmNv/1Rdb1thjj1tLyYI
         To+D2As6ACtitTBMq4iG5YoJJ88GRXLYKVK+4sVJTK0QqmPWQIKBgUDgq/iL5brBOWQA
         KUrGvFDpl7bC52X82hcLOK/o6YcBFKjawM1YdJucFHI9gaiJs0E2DnjUVgHnvOQNBhgy
         U19ynCYQnGJ0DU6bC+tR/5FBNKS/732yB9sfdY81R7gkP+wSUIme743jOa26onyh+Uv/
         MV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789848768; x=1790453568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OPbv2BRHLxzPOe1/vca0l+ECBDzug0FIwNuhoSLLeRI=;
        b=DcrKY4nXYL5Fc2JF62IEWNBdjMgPclE/TgPxMMZzEpykCSuFwP0i9xe387tObETmQl
         s+MPyRMNY05DHOhmU6RUtemuRil/6O5WD0c2eSFhPzP8F5GJOwoZVZ4Xx28VvQbjUzfH
         rzZBGS3PlWIzeG3JhffYPf5paXlpPZGn4y9e5hXoOIF52IYGNPb0f/5YF8SPoguPaM+9
         yHdADKaOsUntYad/5rpzeno9h4jXhZlSQdSCWJWePw51KwdkRWSuXabgjfd5ifPIg2xJ
         gae6nL4x3EL17QrKa4yul0XxD3LUqsF4bYaJBWR7ujhaBLSAP57sG7xAcnDvZ3aN23Ia
         uDew==
X-Gm-Message-State: AFuF++lv4hHWl5nSftbIqk1aZAsMkMYk87cPy9ZwgCBeP097gIn6903B
	phjwVQ/NlM/K10/PzEHQtPdJkRhUBmcQC6boTVkIxhmSSheZ4xiTf/kTcqXsecXh
X-Gm-Gg: AYBFou0mTUMtRyfSG/0bgY4XN1oJCQhFBxeCsRnaYfCWBeb8FJePUvlrH9ynrG0t5Ly
	xNRX0I1cjE5WeozXd3AwG1ciuW6MwKFVKqnJ7uUv0l8Z3//wmU8KA9nXhKqM3cOfKmPhd9SlNUu
	8fIHQ++o/BlrYBaiBT5xeGkZffqv8Iof/aM2edmPXnKOYxqkcxcvAg6EDFmaoqqFB52CsKhuApn
	k/DufmFGnKD1VFtKZg0D+onsOhKmPkw4L9sqvNGKQfKRLIrPiYNnhIBMKSW1B8O2pMo6pWPhJ5D
	PCZUxUhnoWl90GGeSWBqHYOrg0iHtyHDA0d4UVrvrAoE95ieJWoLht57+cmgfFL4W+zlDPVH1XE
	1oQhDKgJNyo6458XJSU71j/YOBfDHTCyvL2JFQZB6yuq2Vgyp5a8itn/2o2hlLm+UJN5shRzxYC
	ibV+FrrWMg1jAfi5mBFDQK0pNzfMijeI4ExYlqzqfX1EF+spZKTFwt/2EVpmGmkES9pfz5t/xAs
	BAKVpNIDQqDoCAFbM799vs119g8fAd6Xw6DAidYuyGU7Hv5R0V57zRldIoPcbH1TjH9JySoPuj7
	2jD9d0bCdtMaRMvBC4s17BZXY0nB3OzyEEMYS8jvrlO7EgXTjQpGTfa/5iNM
X-Received: by 2002:a05:6402:2486:b0:6aa:734b:1a25 with SMTP id 4fb4d7f45d1cf-6aa734b1b76mr1700616a12.31.1789848768084;
        Sat, 19 Sep 2026 13:12:48 -0700 (PDT)
Received: from localhost.localdomain ([37.31.48.107])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67d81625sm1723336a12.5.2026.09.19.13.12.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 13:12:47 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: [PATCH 2/3] branch, tag: retain old OIDs in batched deletions
Date: Sat, 19 Sep 2026 22:11:57 +0200
Message-Id: <20260919201158.43415-3-maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260919201158.43415-1-maciej.ciemborowicz@gmail.com>
References: <CACQ=SRHthWOLVXmY6wgknOPgpQ+oB1vV-Q0AL=mK9mXb2Xy9Nw@mail.gmail.com>
 <20260919201158.43415-1-maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 8198907795 (use delete_refs when deleting tags or branches,
2021-01-21), branch and tag deletion pass no old OIDs to the ref transaction.
As a result, reference-transaction hooks report zero as both the old and new
OID.

Both commands already resolve the old OIDs before starting the deletion. Pass
those values to refs_delete_refs() so hooks receive useful old values without
adding any ref reads.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 builtin/branch.c                 |  6 +++++-
 builtin/tag.c                    |  6 +++++-
 t/t1416-ref-transaction-hooks.sh | 28 ++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f1abeb681d..9f03ebc095 100644
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
index 40874a2923..0a3eb70faf 100644
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
index 4fe9d9b234..8d400cd7ac 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -14,6 +14,34 @@ test_expect_success setup '
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
 test_expect_success 'hook allows updating ref if successful' '
 	git reset --hard PRE &&
 	test_hook reference-transaction <<-\EOF &&
-- 
2.39.3 (Apple Git-146)

