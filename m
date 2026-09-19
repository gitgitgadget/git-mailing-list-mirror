Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428FD374A0E
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848774; cv=none; b=ZmHjtAs9wIkCD0b+6HpxRHZDRqFjv3s2GjC7I0SNCcsVvD9FIzuqpXaVRPESWviXq5GhpyR9flyZJKwCTXZGwfRErtJvVasKsluadlkBwJ1h+8XE7o3u4kM7du9OlhtxCNDp39oWGy/C99lb5s5Cjo33Mzq8+ohtZrf56oRp3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848774; c=relaxed/simple;
	bh=ZMD2/DFxA8b6nDSmC0wEjkCFGtnZwffBVJSHJ/mJpeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KdmSwzf4LxR2v1xC5EOabjHbSBCc/zMQX/oX7ETc9yH1Y9ZO8gJ1E3BKtrK+pk8/zMNq4vEmFlaNR55Y6JPSCKzwtKncuXVDDXrVeO2mHC7OA/eotJDv1rirLa0AnXTLVEY9QC08/pRgJB71yOTdFpy1TYJ3tJP3t9WbsR5/zP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0JPmtMD; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0JPmtMD"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056be4d2so1440689a12.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789848770; x=1790453570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wtK8f/6o3dfvl+J+QHrIM6w8Uedk/0kZfhJpNnsBmNc=;
        b=N0JPmtMDrLZUeEpdGA/XjpkebphLtpaB/oZmsnxtulM87reIMEDknN+J/H/+hppWix
         PGTekV95ZN/LvFHhXj/FBuWyDgZnIJFWzuusbtpouB3sO3YjfgsA4lMQHOluNdHsiJnJ
         JXvHXOZv2loi1BsTj9VgOzPszEJgiNzlvZ3o9irYse2ByjJJGGV7wfMt8W6qGcYCjIVe
         oVGsqYmjX0JRbOfvs18PeGSJMsC65+8743jcKRnq/Ayf3/MAVqh5AtfLfQgsssTEz9Iu
         uWnduddG4YYbCKVM3WuEfyrbgAG37QQ1SaZioZ08MaY1ThGNk0+pEYJAnBklbJ3xeusF
         rsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789848770; x=1790453570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wtK8f/6o3dfvl+J+QHrIM6w8Uedk/0kZfhJpNnsBmNc=;
        b=oburrUG3EZ3y149SYyLLp2ZgBDi7Ny3LvDtfba95RhFWzW0feX2dw1Sqve25Iz9LQS
         WBOSOnFwnDNVPpgb+TSRV11n+KUYad3Wj23SLSrSkpmYOIooQzxwrd5e7vQEfIJH4tpt
         LFbukWvBc4WS37fVqqV+j5Bh2Ujkjr6QSRE2x9NszhF8EuaKnM13dKvAonFrTrfh9AW/
         YbxT+7UiHkrAC68Rn5DNQC0dfDGPr7IKgTYEj1dqxL5QMJrfOJY323ajlAG6y5EQPCXw
         kBZCyW8FoTWz3kyPflsmJueQLIztvVoybnQcdBA0LYOSF2ZCYsAVKx1ZAKY3ZZy0Hrzd
         c8Gw==
X-Gm-Message-State: AFuF++neIkE4316uXdutktUuHxIy8PhkeUFWZPPMOrLpT/BrIcVU5CMI
	zkDG8CpeK3+RxjtkmiPikAnXzl36wucHF/pEcERDyePs40XdZrphiI1MEy2tMhF5
X-Gm-Gg: AYBFou04NXd4FI0JHPkAAFZPBxYEjyQ3/N1PHYoINIV97HKd13azYQZR8gmC0BIzz1B
	okHxG0+jRnUtZBBoGWLkxrKACDjC90R45g7oxugI4rQKJ0YTA51y+Ai4rXv2rKB4MhYZ9SrRMuP
	MNK9rvq9oqfnB06fM/PCwcillCDQNJLAMI3cMcO2tAoYCwClWer0BAlifDvD433snqNiU0UscOT
	mEiMBaRMrZtRISXLDFtbQI4CCjwhzgr72G8GmgOaj6Dsis2l18bddvG0Zu4fWkq9yj53vTtqTPt
	GO1oV05oWa5QdTOkGmsaC3kuLQzLArbDqWo+s9U4ctkChnJpBbmuSPJxLuEvET+Fh77Q9IEt/wh
	xLjc30tJpL7Qe9NyYGTHTZU35haSpRo7OY2nWDjNtrhD8XcB2p8y+oIaTZSDzyRv7MqtWZXX7eD
	BFVbGdSeuV9ilNX6+jvZH2ubXCvd8IwH5FEV/oM8Z3XqtatvJQWtAsLnaUg7MJbI9rqNXx5DUgq
	DvKIYcu07/YERj4PJdW1JswxR8kIKr8dIwRzx6G1tlqxtXyhdGY0PzdDIf0RbEjdPtOnXMQLJND
	9Vk8RuxCA2bKNJLhpFsZNMUCade+C8TcZ9d/8hiFak5OGMM5Rg==
X-Received: by 2002:a05:6402:4284:b0:6a6:b2b9:61fd with SMTP id 4fb4d7f45d1cf-6aa4fea3cd5mr5600801a12.17.1789848770480;
        Sat, 19 Sep 2026 13:12:50 -0700 (PDT)
Received: from localhost.localdomain ([37.31.48.107])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67d81625sm1723336a12.5.2026.09.19.13.12.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 13:12:49 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: [PATCH 3/3] fetch, remote: retain old OIDs when pruning refs
Date: Sat, 19 Sep 2026 22:11:58 +0200
Message-Id: <20260919201158.43415-4-maciej.ciemborowicz@gmail.com>
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

get_stale_heads() records the current value of each stale local ref in its
new_oid member. The pruning paths discard that value and request unconditional
deletion, so reference-transaction hooks receive a null old OID.

Carry the recorded values into the deletion transactions. This reuses data
collected while finding stale refs and therefore requires no additional ref
reads.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 builtin/fetch.c                  | 11 ++++++---
 builtin/remote.c                 | 30 +++++++++++++++++++----
 t/t1416-ref-transaction-hooks.sh | 42 ++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d202147b21..a982d7541f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1452,14 +1452,18 @@ static int prune_refs(struct display_state *display_state,
 	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
 	struct strbuf err = STRBUF_INIT;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
+	struct oid_array old_oids = OID_ARRAY_INIT;
 
-	for (ref = stale_refs; ref; ref = ref->next)
+	for (ref = stale_refs; ref; ref = ref->next) {
 		string_list_append(&refnames, ref->name);
+		oid_array_append(&old_oids, &ref->new_oid);
+	}
 
 	if (!dry_run) {
 		if (transaction) {
 			for (ref = stale_refs; ref; ref = ref->next) {
-				result = ref_transaction_delete(transaction, ref->name, NULL,
+				result = ref_transaction_delete(transaction, ref->name,
+							&ref->new_oid,
 								NULL, 0, "fetch: prune", &err);
 				if (result)
 					goto cleanup;
@@ -1467,7 +1471,7 @@ static int prune_refs(struct display_state *display_state,
 		} else {
 			result = refs_delete_refs(get_main_ref_store(the_repository),
 						  "fetch: prune", &refnames,
-						  NULL, 0);
+						  &old_oids, 0);
 		}
 	}
 
@@ -1487,6 +1491,7 @@ static int prune_refs(struct display_state *display_state,
 
 cleanup:
 	string_list_clear(&refnames, 0);
+	oid_array_clear(&old_oids);
 	strbuf_release(&err);
 	free_refs(stale_refs);
 	return result;
diff --git a/builtin/remote.c b/builtin/remote.c
index 13d3cc52dd..7b0ad13342 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -17,6 +17,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "odb.h"
+#include "oid-array.h"
 #include "strvec.h"
 #include "commit-reach.h"
 #include "progress.h"
@@ -380,6 +381,11 @@ struct ref_states {
 	int queried;
 };
 
+struct stale_ref {
+	struct object_id oid;
+	char name[FLEX_ARRAY];
+};
+
 #define REF_STATES_INIT { \
 	.new_refs = STRING_LIST_INIT_DUP, \
 	.skipped = STRING_LIST_INIT_DUP, \
@@ -410,9 +416,13 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	}
 	stale_refs = get_stale_heads(&states->remote->fetch, fetch_map);
 	for (ref = stale_refs; ref; ref = ref->next) {
+		struct stale_ref *stale_ref;
 		struct string_list_item *item =
 			string_list_append(&states->stale, abbrev_branch(ref->name));
-		item->util = xstrdup(ref->name);
+
+		FLEX_ALLOC_STR(stale_ref, name, ref->name);
+		oidcpy(&stale_ref->oid, &ref->new_oid);
+		item->util = stale_ref;
 	}
 	free_refs(stale_refs);
 	free_refs(fetch_map);
@@ -1627,6 +1637,7 @@ static int prune_remote(const char *remote, int dry_run)
 	int result = 0;
 	struct ref_states states = REF_STATES_INIT;
 	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
+	struct oid_array old_oids = OID_ARRAY_INIT;
 	struct string_list_item *item;
 
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
@@ -1639,17 +1650,25 @@ static int prune_remote(const char *remote, int dry_run)
 	printf_ln(_("Pruning %s"), remote);
 	printf_ln(_("URL: %s"), states.remote->url.v[0]);
 
-	for_each_string_list_item(item, &states.stale)
-		string_list_append(&refs_to_prune, item->util);
+	for_each_string_list_item(item, &states.stale) {
+		struct stale_ref *stale_ref = item->util;
+		struct string_list_item *to_prune;
+
+		to_prune = string_list_append(&refs_to_prune, stale_ref->name);
+		to_prune->util = &stale_ref->oid;
+	}
 	string_list_sort(&refs_to_prune);
+	for_each_string_list_item(item, &refs_to_prune)
+		oid_array_append(&old_oids, item->util);
 
 	if (!dry_run)
 		result |= refs_delete_refs(get_main_ref_store(the_repository),
 					   "remote: prune", &refs_to_prune,
-					   NULL, 0);
+					   &old_oids, 0);
 
 	for_each_string_list_item(item, &states.stale) {
-		const char *refname = item->util;
+		struct stale_ref *stale_ref = item->util;
+		const char *refname = stale_ref->name;
 
 		if (dry_run)
 			printf_ln(_(" * [would prune] %s"),
@@ -1663,6 +1682,7 @@ static int prune_remote(const char *remote, int dry_run)
 				   stdout, " ", dry_run, &refs_to_prune);
 
 	string_list_clear(&refs_to_prune, 0);
+	oid_array_clear(&old_oids);
 	free_remote_ref_states(&states);
 	return result;
 }
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 8d400cd7ac..39bdc1bc26 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -42,6 +42,48 @@ test_expect_success 'hook gets old values for batched branch/tag deletion' '
 	test_cmp expect actual
 '
 
+test_expect_success 'hook gets old values when pruning remote refs' '
+	test_create_repo empty.git --bare &&
+	test_create_repo prune &&
+	git -C prune remote add origin ../empty.git &&
+	test_commit -C prune one &&
+	one=$(git -C prune rev-parse HEAD) &&
+	test_commit -C prune two &&
+	two=$(git -C prune rev-parse HEAD) &&
+	git -C prune update-ref refs/remotes/origin/remote-prune-z "$one" &&
+	git -C prune update-ref refs/remotes/origin/remote-prune-a "$two" &&
+	git -C prune pack-refs --all &&
+	test_hook -C prune reference-transaction <<-\EOF &&
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
+	(
+		cd prune &&
+		git remote prune origin &&
+		git update-ref refs/remotes/origin/fetch-prune "$one" &&
+		git fetch --prune origin &&
+		git update-ref refs/remotes/origin/atomic-prune "$one" &&
+		git fetch --atomic --prune origin &&
+		cat >expect <<-EOF &&
+			$two $ZERO_OID refs/remotes/origin/remote-prune-a
+			$one $ZERO_OID refs/remotes/origin/remote-prune-z
+			$one $ZERO_OID refs/remotes/origin/fetch-prune
+			$one $ZERO_OID refs/remotes/origin/atomic-prune
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'hook allows updating ref if successful' '
 	git reset --hard PRE &&
 	test_hook reference-transaction <<-\EOF &&
-- 
2.39.3 (Apple Git-146)

