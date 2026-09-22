Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29243E08F
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116298; cv=none; b=kFT4i1WebosSRE8C8Z4C5b0xfRng+DtfNWiIpGkAmBe4X2CTlp96jXQ9gypuucM3N53kG1pwuz/52+0ZlApm78xyUlAc8NFVyqv/5FpIlt4w8BIIyqM5WeMACGeacQX5wbKAYLJUdktiDCqVhVo73Jsm3PM2vZk0FGEVu8H1nj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116298; c=relaxed/simple;
	bh=RcUp/3/8Cjgwou7kkhBy0ItVQgimP0gAMdmrjcTy/RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZjIrd0rF64vUELGpY40lFeR4zuqFp64gaO4Yn8Rzh6qCCG59l0fTlRgw21RKAy73g/+3PX3jIsnC8cRKhM3FmOL9PeXXe2Oza2tH4neC/ItSDcEDmNuzaN2fnnpUaWMJr9nSK4tKUdaW3rlEMb46hLqMPnzOvEjnAag8MF1PNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFkwDPBP; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFkwDPBP"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55eff0so42820466b.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790116274; x=1790721074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hFQoS5J2CeEBCNnrgJ/joLQWVMUZlg256yjOCYoIlpk=;
        b=bFkwDPBPgSZ5U1JoFxeaXT7vhZ2prQ/qnTGsmwFJspYm2hh8bWqZ+lgCBAHvndkSrC
         Fe0OQMcz5w46uE93WdpSRtgTJHwhuAQlIslJb1SxFSNAzq9be5mOaDuhKOYje9g0BXxh
         msI58QvLgvQ9+F6lihWURSHEqABkdv5Pn/ODmk5G7EdRMQnUKL+onZUo//Nb68lHTGXm
         +VbEDdyy3vNDpYncLE5chs2UkcvpKrmHS/L+dbKP5uICZLny3SipVgzbRPO9+ySLrjgX
         oQQqq0G7EfCVC5Ag11HzjlWG+84y4MiPbgIQVP2+pqmts9auQk65L/eqhpzDd7dcnK1E
         67Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116274; x=1790721074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hFQoS5J2CeEBCNnrgJ/joLQWVMUZlg256yjOCYoIlpk=;
        b=L2JcWxtjqGj6tsS73CH7GnxcGmWgEe7KmPWHtLkpoTY9+8rstF7ADS39EPuhKZZUCg
         PWnnNCu+ybfST8O29hjz4jC/aG/gZh3PXiqZeOMSJTx5F4iDYalIRa1Nd5W0snWEf8q9
         dUNHlF5LzdwdW9veabhDrY+VksAE7KMcQi/13z0H4M+neHpx/3E3MDXw0K0+Gz7AJdw8
         sGCwIJ+pt/CqQFWDPVM2JwlYpIOJnlzEeGMLcrrAgladkF80y5jIneUbzknSgQWmuqVy
         hNxVwH0fdYeiFMK9/Va9dI3NK9jqUY993YQ2M7Cgr5byqSi6ibB1t6flh/5SbRxveSND
         jB7Q==
X-Gm-Message-State: AFuF++n42C6niN7s743i1WOoxEjjwzVsOiLye5aeUCYGPyZBptn8oCCd
	XQdbX2AMzWpiCuNi7R0/NVsDFeajkFUS+reryKYKLinnikPOFSQRjUr94AFOYpcj
X-Gm-Gg: AYBFou2LRscr/fNkabtpDCvdXhy7fKR5Yj/q8Jf5ua6MP0/gCIrM5moOAvcDTy8nIfQ
	fCR/sq3899iyqsNbBL8zv2hI/fPMb9AQATb83j+zs1t8YnxTf/C0+l8TONfcZ1doFgZ/j4bX8p1
	BPqPoB3oGuiPJXQpehg0qMIF+gHx2DoZLktNTRktBwa8SsFk52W5uCaR5zt2DVUc2641pWxymmS
	CKzglO9HyVUmbYGI5Fv5R9ggW9ZPOmH6HuPCgUtPtEGi4fMzLziCUZbgWmgvK3xz5XOx55Hn11T
	ecQQJDIVHtiFHLcmxDcytuAi5JwKQyZJlZuUsxWsjHrrPjdVU6oANeoZ2IMyPFHQZNkcBenHl2L
	WSVeBCJotA7PEyorAEg6+1rts0RoKuuD5WyGBp+lJEv0WU8IUEiRHfKxeDst2gHuppIN1HfiyQp
	L+W6dRcGdIWNcUfBsBHAYY8zGhcnav1E/YnBf8EADFa11+pX4MZ/c5uVuwAnh/fKrIf95IdZvFa
	iZUKaEAKA86ECm9CgBEdms3aOE87I8zKrs3gcPUFoCpP7dfZQdicX5DhcGu8HIdy4A202WHmkS2
	yv7AC7+s6PjKI6y1XwK7Ei7j5InMEx3KSnkr5KD9tFOHiL9O
X-Received: by 2002:a17:907:9347:b0:c19:45e3:2f57 with SMTP id a640c23a62f3a-c2aadcf59cfmr51365766b.9.1790116274344;
        Tue, 22 Sep 2026 15:31:14 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5524sm20847566b.21.2026.09.22.15.31.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 15:31:13 -0700 (PDT)
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
Subject: [PATCH v4 3/3] fetch, remote: retain old OIDs when pruning refs
Date: Wed, 23 Sep 2026 00:31:10 +0200
Message-Id: <6f34853c79625794d2eb364d227660be57d1539b.1790113781.git.maciej.ciemborowicz@gmail.com>
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
index b662216bf..95789edb8 100644
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
-						  NULL, 0);
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
index 56b06845b..2d9ee6db1 100644
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
-					   NULL, 0);
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

