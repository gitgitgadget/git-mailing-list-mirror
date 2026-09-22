Received: from mail-ej2-f38.google.com (mail-ej2-f38.google.com [74.125.228.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698C53E316
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079979; cv=none; b=uVaBX0MI52gWVbOE7OTGjBGk2WCKvRoOwHg5W238ZS6iSUvvERy/rp/RabkJn1PLWACrOwNOyUj1UBtJYhmIqVQ89nMu9V8Peb1Yy2Hrr6/thXTjI83jPkuzvA4Dmre/APuTEqw45nUkHIWCi8WoAuox5rWOozT2QMdajA/TNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079979; c=relaxed/simple;
	bh=vZjfcEklxkyhH9z+/6EwL/lXnRRVeN/uFrwnY8M30gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tN5V05TGxE6L0ginizqDGNFhZ9XDbc5fkEM+b0yTuQiIPDsihgeJW35VTBhHHd3YnN+Vg1X38aYEYLreO1cSLYxMu+uk247WD96FNJ+kmk0UZcTBiu3VooKWItev/80XybTc+49KJjWkBeMcrPiS9VoN/mbY93d4PMJYhEowYzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oMI2+Ujk; arc=none smtp.client-ip=74.125.228.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMI2+Ujk"
Received: by mail-ej2-f38.google.com with SMTP id a640c23a62f3a-c254f560398so614363766b.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790079975; x=1790684775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1IuLuzObcu/JeyXqYW6DH4JuSp/9tCpvq4UNWOuKzNw=;
        b=oMI2+UjkoBudyZzX2jmVujXlLJ/8/TMIlOG8/l1WngMxX8uxPHWVuYtHRUYjpP43wg
         YKaAlDLymVnPdiTzUTGVKhJs0DmemqlPIC1QJhxW3iOCAZ7QFNDbtT7/8hpTVm7RlUN8
         6YhIY/RS9jJ2bJBXsglj1qnBrjeZhsJoT3aVIRoIohbeVKhu5drmpcwJC/ohQ0eCRrHU
         XUXFIQ6cWbPO8Vuwyo0HrbauW/qp9GHYDdG80XNo2P8Mom3hFe73fXyRx4RyEcSWdsjE
         NjlAC1uvGAHzS4rLcKZioR1b6sH/GAcuM5FcWt3CplqUbnLbA6BsEwFtZEvuAPipWK06
         v8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079975; x=1790684775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1IuLuzObcu/JeyXqYW6DH4JuSp/9tCpvq4UNWOuKzNw=;
        b=aos2mDUZc1fvLGjoYiEA8jxKR+UZvkXy5BqqS081vLMmCGLdvEj1eWczfZz4eNklM9
         6EzCJbZUMDdAD/VhMRa1dB1bG1Kd2+oinapEqC5MJHBlTmCQfBFRZPUZ/MuyNMmcAy4t
         xn+AAFQd9Hmd9cZhGQreElxoQn8em734HIFSNqESW5sD8J2Cmk7LNTRc4ujD74hIkA9t
         OeFpausie3I0OCuNohrS/RfXgEgOIMQE3r2K970vyO9DZCmdC34oUgGysksKct3LrfqU
         1JJsZVITBMGi55exyII4vQmRwJ9JMVwNlqFv7O3UH0gz/ePzYVONzXa7KS5gi7GuWYEU
         /ceA==
X-Gm-Message-State: AFuF++m1zcsXm2nbqwXNHWKO9NaZKT0Mga9q+Qj+BT5AtbA7HXxpJ6sA
	hOuYt4eiyFdae7q3P8iWGixVEp2DzgCfZ5NKZkjhQlDFQm+YzILC7e+MqSkLeDvj
X-Gm-Gg: AYBFou3qAV5np3ttN82QM+8dH1EeCxvefRrrd/SI0tzHHq0IZkPPKudBvfncR/ZggS8
	RP7yJbj7mgi45FT26a3oPnl+g445wETLW1ek1oPT8LXu5HaCJxgOJrLHDe2Mnl+S0IJ3luPQPw5
	7MJ7IEOdIFIm2hJYQmRbPz7FRi+t+vANP9UM00HF+0n8CyZ7RL64Z2VpdZOPHtKIICTKkzOcl1H
	IlInHfIAvR0nIGkt1MHP+x9xz1G1ATOs4NshN6tkMGA+BsC2gHQ/R1PfGtIKZ7ncrg8v4/Q+3Qu
	euDUnV4jFOkTI4nDv0/pisYYX5Rl3MhBsMo0+3O8yIgebZ9QMvFI0P8pufzI66pgoTaTmG/cfee
	DGNVdgINn/0s5WDYPJKDXZyOuMjK+E5Qytm5tAll4rDcFm02PhFdvX3wQgQW8Y3V+Z3VoNFgKzo
	+2ygvOS3Bz6c7REYSkr4Vn8EtTgHm79LgwXHlxs6bGml/lgicvxPqfpffL1bnTI1ESP1CnGMv5+
	Wzn42EKfzh+tOsJVR5SFlTQ4tHsRN4z+4ikjWTfv3Lk7ah/oxpxbZRrftlU+nfbwT1bqbwlgUcj
	M6J4REuOFsahq7XjJquZyC2gr6DvjM6ot9cylgVd6kiRvNs6
X-Received: by 2002:a17:907:3ea1:b0:c29:60c1:7e55 with SMTP id a640c23a62f3a-c2a157f77c3mr1209816066b.12.1790079974828;
        Tue, 22 Sep 2026 05:26:14 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c54f30dsm77322566b.17.2026.09.22.05.26.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 05:26:14 -0700 (PDT)
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
Subject: [PATCH v3 3/3] fetch, remote: retain old OIDs when pruning refs
Date: Tue, 22 Sep 2026 14:26:09 +0200
Message-Id: <3f3062252ac1aa057b9ee9a2dd9892e629ba7a82.1790079917.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790079917.git.maciej.ciemborowicz@gmail.com>
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com> <cover.1790079917.git.maciej.ciemborowicz@gmail.com>
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

Reuse values collected while finding stale refs, avoiding additional ref
reads. Avoid reporting deletion status when pruning encounters a rejected
update.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 builtin/fetch.c                  | 21 ++++++---
 builtin/remote.c                 | 34 +++++++++++---
 t/t1416-ref-transaction-hooks.sh | 80 ++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b662216bf..2a59ac10f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1471,28 +1471,36 @@ static int prune_refs(struct display_state *display_state,
 	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
 	struct strbuf err = STRBUF_INIT;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
-
-	for (ref = stale_refs; ref; ref = ref->next)
-		string_list_append(&refnames, ref->name);
+	struct oid_array old_oids = OID_ARRAY_INIT;
 
 	if (!dry_run) {
 		if (transaction) {
 			for (ref = stale_refs; ref; ref = ref->next) {
-				result = ref_transaction_delete(transaction, ref->name, NULL,
-								NULL, 0, "fetch: prune", &err);
+				result = ref_transaction_delete(transaction, ref->name,
+							&ref->new_oid, NULL, 0,
+							"fetch: prune", &err);
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
-						  NULL, 0);
+						  &old_oids, 0);
 		}
+		if (result)
+			goto cleanup;
 	}
 
 	if (verbosity >= 0) {
 		int summary_width = transport_summary_width(stale_refs);
 
+		if (!refnames.nr)
+			for (ref = stale_refs; ref; ref = ref->next)
+				string_list_append(&refnames, ref->name);
 		for (ref = stale_refs; ref; ref = ref->next) {
 			display_ref_update(display_state, '-', _("[deleted]"), NULL,
 					   _("(none)"), ref->name,
@@ -1506,6 +1514,7 @@ static int prune_refs(struct display_state *display_state,
 
 cleanup:
 	string_list_clear(&refnames, 0);
+	oid_array_clear(&old_oids);
 	strbuf_release(&err);
 	free_refs(stale_refs);
 	return result;
diff --git a/builtin/remote.c b/builtin/remote.c
index 13d3cc52d..a99d18832 100644
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
@@ -1639,17 +1650,24 @@ static int prune_remote(const char *remote, int dry_run)
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
-					   NULL, 0);
+					   &old_oids, 0);
+		if (result)
+			goto cleanup;
+	}
 
 	for_each_string_list_item(item, &states.stale) {
-		const char *refname = item->util;
+		struct stale_ref *stale_ref = item->util;
+		const char *refname = stale_ref->name;
 
 		if (dry_run)
 			printf_ln(_(" * [would prune] %s"),
@@ -1662,7 +1680,9 @@ static int prune_remote(const char *remote, int dry_run)
 	refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
 				   stdout, " ", dry_run, &refs_to_prune);
 
+cleanup:
 	string_list_clear(&refs_to_prune, 0);
+	oid_array_clear(&old_oids);
 	free_remote_ref_states(&states);
 	return result;
 }
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 01b5ba8c4..8b52f2366 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -58,6 +58,86 @@ test_expect_success 'branch deletion rejects a concurrent update' '
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
+test_expect_success 'remote prune rejects a concurrent update' '
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
+		test_grep ! "\[pruned\]" out
+	)
+'
+
 test_expect_success 'hook allows updating ref if successful' '
 	git reset --hard PRE &&
 	test_hook reference-transaction <<-\EOF &&
-- 
2.39.3 (Apple Git-146)

