Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B063BBA0F
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197492; cv=none; b=HZtyNfI9IuGW/wQSHCjXi1PTk529yhX134MFdZWTi/IjiK6xw7C8hK2EalPvnEqm0Qyn2O6XAxUwJXCc9esNLbjbDCatiWfxYIdYOKCqhUC8YkgogWDXHf8C8Ugg9/8NgxQX3M0OT117MLOs6AkXdvdyGPFWj1yWTzGc21C2eNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197492; c=relaxed/simple;
	bh=P17yOWMnFWi7LMIp15fVP/Mqcv0LCioJYUpg2gb7JUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a1MvjXEOcqUMlI9+RxNUOIsxUPQLusjHA4r3wFV9f8iIrNUdRJ0F23jlqq1XG2NkFxnRtJmh9yqv7D+83LYewvqmk7usd9QSsPmZdFIFpRJcpmvYiYGwqBE6k5bJaWXcTem1obxLaHj0uEbOh++aomxt9EzmjOPSmnqTAlDQUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2q74pFv; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2q74pFv"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so189674266b.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790197488; x=1790802288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zbmMZaf6CNErOOotaWOFqL4mQ8nJNmvVN9SIvnX+Ico=;
        b=T2q74pFvTMivYt989fq0GG2AGyHQvY0xJp8Xh9y5pFTwl8A/U9FFAgMe/vS5QedxO9
         EVK0W2d5frDbIXqWDuJ7tyBnSDsgSI6717fFmB+t3OHeUlsXK8nYx+McZOOMEkdv2VbP
         sm275mZQOFdKzUnj2+F3ToDVtodcl/T4DHRqOVc2DcK0yEqlp4DKKNSzU2+f1y/TexyI
         41V3+7Y3YoNFZo0IrnuhtSqD0+6bgsgE85r1+1L66LNhue9VuMaRO+yhdj71UR2CWjFX
         rRHDNuwuIsYB27YqOOH2j/X1Q//zd8+wkJ2cEfn2twRO/Nj/miW/GDueUcn/oHnbT5CW
         G+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197488; x=1790802288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zbmMZaf6CNErOOotaWOFqL4mQ8nJNmvVN9SIvnX+Ico=;
        b=iOvVej3wJP2Koy+DkW2i7jeV/sKXijxeLpmo7ZtyN3McLHNaKYOrY61uMNuyLE7QZL
         1+yQgr66htFy/534JWKY6AIikrmCg2NhkAQH8IL9jvA+Bqr21fa+m9UjqRg/4cuRm+kq
         xCaENmurUqGmP47qJ+NWgtKOFopOB9qZylLDgZ6goGJXyB9KbNPYEy57Wsid6z6xDtDC
         oKgSHUdV1QlAlxtW/ntRwH2mU8C3VCs80Mpob5DTAPndiQ8Tqmx1GYLytS1+RfZ6JiIt
         OZaa2/ZxoBYEGLRXG0Jq8wqlka7eS1MPdPZlotqaXrNnVr4fsY7vQtvP9Q6o0VvlmWiq
         AccA==
X-Gm-Message-State: AFuF++mKHqMtho/j2h9DGkIcfuhv59dHd3IDf7Chxzz2tuGFmHEc3X1l
	WAuIzGlIOZGaWpIItuA9eZ7e7DEZoY5YZnXESzj4JWONFXSohh7nuXsrKLXmTE1B
X-Gm-Gg: AYBFou3Fvxj8dMTZMxM8aJeabO1we5gqz7iWBTPo8G3aExOTkXNlGt9DVKp0hg64B1w
	SZZfylEb9H2PEiCHIryv89G4sfgzKLocHlnd0GhWzEjyfez8WyMSsGFkarhSz81isbiFoYPhDz7
	jOVG6E462yVkpFAPVCOp+oJ6XpoNGzwJfbz8By4QFuDIH43KlE2K8tIqZbqJK4W+6/t8wRzyjpk
	VZRl/WOkX7lxCck7iTP2kZgXJc1XYvkDdovijiUwGrhZ7v3dhvCiMNAo27vUxwzkHTCyHT82JC7
	fIetZAgGA7ECrq7lccgCaM0kuMl5KbvqbRRIX+V1jf3zS0Hz5GONkz6GrTShZ9s+vpUxfaBiB2U
	E1VtlEPOU7XxUm15krgt+FhkYLOuUmKbiAGo+Xk3snQ6rHgQ3is7AvOrRKHRtJAzvWJjgM+4oZ6
	Py4jDhhLzcT78q0BvygwR9KYJkNVeJH+3trSIrIATtGlZvSdBwnlC5wIRkFJ9p+pDGKELGLHIlB
	NYmBHjRwtdaCQ6mTFeP+HBmiCLcVtDVi3FICYxF2TY+TWMYi2rWpw49YB0zqSTiPTchc34FxFT9
	oRQ1wXCUzXWvhrz80zVJsA8t6ZJIGNhwSXpstoVjOYFFelGn
X-Received: by 2002:a17:907:d408:b0:c29:3821:ae6c with SMTP id a640c23a62f3a-c2ac2606943mr25370066b.37.1790197487960;
        Wed, 23 Sep 2026 14:04:47 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae60e4c8sm189325366b.26.2026.09.23.14.04.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 14:04:47 -0700 (PDT)
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
Subject: [PATCH v5 3/3] fetch, remote: retain old OIDs when pruning refs
Date: Wed, 23 Sep 2026 23:04:42 +0200
Message-Id: <541da44c371807e22a368cbc60b6fc26be7c64a3.1790196627.git.maciej.ciemborowicz@gmail.com>
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

get_stale_heads() records the current value of each stale local ref in its
new_oid member. The pruning paths discard that value and request
unconditional deletion, so reference-transaction hooks receive a null old
OID.

Pass the recorded values into the deletion transactions. If a ref changes
after the stale scan, reject that deletion and preserve the new value.
Non-atomic pruning uses refs_delete_refs(), whose partial-failure mode still
deletes unaffected stale refs. An atomic fetch remains all-or-nothing.

Continue reporting successful non-atomic deletions when another deletion is
rejected, but do not report the rejected ref as deleted or use it when
checking for newly dangling symrefs. Use the rejected-ref list returned by
refs_delete_refs() so reporting reflects the transaction result without
additional ref reads.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 builtin/fetch.c                  |  30 +++++---
 builtin/remote.c                 |  44 +++++++++---
 t/t1416-ref-transaction-hooks.sh | 116 +++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+), 16 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 11caa6b4a..95789edb8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1471,22 +1471,29 @@ static int prune_refs(struct display_state *display_state,
 	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
 	struct strbuf err = STRBUF_INIT;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
-
-	for (ref = stale_refs; ref; ref = ref->next)
-		string_list_append(&refnames, ref->name);
+	struct string_list deleted_refs = STRING_LIST_INIT_NODUP;
+	struct string_list failed_refs = STRING_LIST_INIT_DUP;
+	struct oid_array old_oids = OID_ARRAY_INIT;
 
 	if (!dry_run) {
 		if (transaction) {
 			for (ref = stale_refs; ref; ref = ref->next) {
-				result = ref_transaction_delete(transaction, ref->name, NULL,
-								NULL, 0, "fetch: prune", &err);
+				result = ref_transaction_delete(transaction, ref->name,
+								&ref->new_oid, NULL, 0,
+								"fetch: prune", &err);
 				if (result)
 					goto cleanup;
 			}
 		} else {
+			for (ref = stale_refs; ref; ref = ref->next) {
+				string_list_append(&refnames, ref->name);
+				oid_array_append(&old_oids, &ref->new_oid);
+			}
 			result = refs_delete_refs(get_main_ref_store(the_repository),
 						  "fetch: prune", &refnames,
-						  NULL, NULL, 0);
+						  &old_oids, &failed_refs, 0);
+			if (result && !failed_refs.nr)
+				goto cleanup;
 		}
 	}
 
@@ -1494,18 +1501,25 @@ static int prune_refs(struct display_state *display_state,
 		int summary_width = transport_summary_width(stale_refs);
 
 		for (ref = stale_refs; ref; ref = ref->next) {
+			if (string_list_has_string(&failed_refs, ref->name))
+				continue;
+
 			display_ref_update(display_state, '-', _("[deleted]"), NULL,
 					   _("(none)"), ref->name,
 					   &ref->new_oid, &ref->old_oid,
 					   summary_width);
+			string_list_append(&deleted_refs, ref->name);
 		}
-		string_list_sort(&refnames);
+		string_list_sort(&deleted_refs);
 		refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
-					   stderr, "   ", dry_run, &refnames);
+					   stderr, "   ", dry_run, &deleted_refs);
 	}
 
 cleanup:
 	string_list_clear(&refnames, 0);
+	string_list_clear(&deleted_refs, 0);
+	string_list_clear(&failed_refs, 0);
+	oid_array_clear(&old_oids);
 	strbuf_release(&err);
 	free_refs(stale_refs);
 	return result;
diff --git a/builtin/remote.c b/builtin/remote.c
index 840c842e2..2d9ee6db1 100644
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
@@ -1627,6 +1637,9 @@ static int prune_remote(const char *remote, int dry_run)
 	int result = 0;
 	struct ref_states states = REF_STATES_INIT;
 	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
+	struct string_list pruned_refs = STRING_LIST_INIT_NODUP;
+	struct string_list failed_refs = STRING_LIST_INIT_DUP;
+	struct oid_array old_oids = OID_ARRAY_INIT;
 	struct string_list_item *item;
 
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
@@ -1639,17 +1652,27 @@ static int prune_remote(const char *remote, int dry_run)
 	printf_ln(_("Pruning %s"), remote);
 	printf_ln(_("URL: %s"), states.remote->url.v[0]);
 
-	for_each_string_list_item(item, &states.stale)
-		string_list_append(&refs_to_prune, item->util);
-	string_list_sort(&refs_to_prune);
+	for_each_string_list_item(item, &states.stale) {
+		struct stale_ref *stale_ref = item->util;
+
+		string_list_append(&refs_to_prune, stale_ref->name);
+		oid_array_append(&old_oids, &stale_ref->oid);
+	}
 
-	if (!dry_run)
+	if (!dry_run) {
 		result |= refs_delete_refs(get_main_ref_store(the_repository),
 					   "remote: prune", &refs_to_prune,
-					   NULL, NULL, 0);
+					   &old_oids, &failed_refs, 0);
+		if (result && !failed_refs.nr)
+			goto cleanup;
+	}
 
 	for_each_string_list_item(item, &states.stale) {
-		const char *refname = item->util;
+		struct stale_ref *stale_ref = item->util;
+		const char *refname = stale_ref->name;
+
+		if (string_list_has_string(&failed_refs, refname))
+			continue;
 
 		if (dry_run)
 			printf_ln(_(" * [would prune] %s"),
@@ -1657,12 +1680,17 @@ static int prune_remote(const char *remote, int dry_run)
 		else
 			printf_ln(_(" * [pruned] %s"),
 			       abbrev_ref(refname, "refs/remotes/"));
+		string_list_append(&pruned_refs, refname);
 	}
 
 	refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
-				   stdout, " ", dry_run, &refs_to_prune);
+				   stdout, " ", dry_run, &pruned_refs);
 
+cleanup:
 	string_list_clear(&refs_to_prune, 0);
+	string_list_clear(&pruned_refs, 0);
+	string_list_clear(&failed_refs, 0);
+	oid_array_clear(&old_oids);
 	free_remote_ref_states(&states);
 	return result;
 }
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 01b5ba8c4..e7c16cd87 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -58,6 +58,122 @@ test_expect_success 'branch deletion rejects a concurrent update' '
 	test_cmp_rev POST refs/heads/delete-race
 '
 
+test_expect_success 'hook gets old values when pruning remote refs' '
+	test_when_finished "rm -rf empty.git prune" &&
+	git init --bare empty.git &&
+	git init prune &&
+	(
+		cd prune &&
+		git remote add origin ../empty.git &&
+		git commit --allow-empty -m one &&
+		one=$(git rev-parse HEAD) &&
+		git commit --allow-empty -m two &&
+		two=$(git rev-parse HEAD) &&
+		git update-ref refs/remotes/origin/remote-prune-z "$one" &&
+		git update-ref refs/remotes/origin/remote-prune-a "$two"
+	) &&
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
+		one=$(git rev-parse HEAD^) &&
+		two=$(git rev-parse HEAD) &&
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
+test_expect_success 'remote prune reports deletions around a concurrent update' '
+	test_when_finished "rm -rf race-empty.git race-prune" &&
+	git init --bare race-empty.git &&
+	git init race-prune &&
+	(
+		cd race-prune &&
+		git commit --allow-empty -m one &&
+		one=$(git rev-parse HEAD) &&
+		git commit --allow-empty -m two &&
+		two=$(git rev-parse HEAD) &&
+		git remote add origin ../race-empty.git &&
+		git update-ref refs/remotes/origin/race "$one" &&
+		git update-ref refs/remotes/origin/other "$one"
+	) &&
+	test_hook -C race-prune reference-transaction <<-\EOF &&
+		marker=$(git rev-parse --git-path prune-race-once)
+		if test "$1" = preparing && test ! -e "$marker"
+		then
+			>"$marker"
+			git update-ref refs/remotes/origin/race HEAD
+		fi
+		exit 0
+	EOF
+	(
+		cd race-prune &&
+		two=$(git rev-parse HEAD) &&
+		test_must_fail git remote prune origin >out 2>err &&
+		test_cmp_rev "$two" refs/remotes/origin/race &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/other &&
+		test_grep "\[pruned\].*origin/other" out &&
+		test_grep ! "\[pruned\].*origin/race" out &&
+		test_grep "could not delete reference refs/remotes/origin/race" err
+	)
+'
+
+test_expect_success 'fetch prune reports deletions around a concurrent update' '
+	test_when_finished "rm -rf fetch-empty.git fetch-prune" &&
+	git init --bare fetch-empty.git &&
+	git init fetch-prune &&
+	(
+		cd fetch-prune &&
+		git commit --allow-empty -m one &&
+		one=$(git rev-parse HEAD) &&
+		git commit --allow-empty -m two &&
+		git remote add origin ../fetch-empty.git &&
+		git update-ref refs/remotes/origin/race "$one" &&
+		git update-ref refs/remotes/origin/other "$one"
+	) &&
+	test_hook -C fetch-prune reference-transaction <<-\EOF &&
+		marker=$(git rev-parse --git-path prune-race-once)
+		if test "$1" = preparing && test ! -e "$marker"
+		then
+			>"$marker"
+			git update-ref refs/remotes/origin/race HEAD
+		fi
+		exit 0
+	EOF
+	(
+		cd fetch-prune &&
+		two=$(git rev-parse HEAD) &&
+		test_must_fail git fetch --prune origin >out 2>err &&
+		test_cmp_rev "$two" refs/remotes/origin/race &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/other &&
+		test_grep "\[deleted\].*origin/other" err &&
+		test_grep ! "\[deleted\].*origin/race" err &&
+		test_grep "could not delete reference refs/remotes/origin/race" err
+	)
+'
+
 test_expect_success 'hook allows updating ref if successful' '
 	git reset --hard PRE &&
 	test_hook reference-transaction <<-\EOF &&
-- 
2.39.3 (Apple Git-146)

