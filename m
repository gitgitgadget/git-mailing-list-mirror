Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D321442EA
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907712; cv=none; b=IquZVw5Upt7ho/UrO+VqR3uNoONgpknfZs0B4Ky/5FRS6ieJQYAYmmr2VFjKjFaL6pyqYjubPMAP0yWirZyn0RHR/SGkz07jT3PPXzQTN+9hlBSyIWGnu0sdKCGXMP9O2jSEy+B2pMi2u0N8+CvOQQcNjZIdG4DgcPScC4b16LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907712; c=relaxed/simple;
	bh=xCkH4kMNYtG7gRFuIn97PvbIOVIifywzwZqOuuJd1wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq3For7AlZq/Wc/h4UZaV58A1kENTqfWj/aITYXdmcIURk0kXOHOPIJbjXbG4G47tSQi4/jLpUPIvYyS1RhbRD3THH+gAgXYGuAeUh3yyKla9d+x9H9poJMMasXgoxDwc6ukWwZ2DpUS11ba0w9tA8EtmiBZGfGUKBtpIAvic9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsngS6dP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsngS6dP"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so6643980a12.1
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713907709; x=1714512509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUB6n1NsU2/7GWgTVD6aANG6lX22V95O/7uyuMDt2LI=;
        b=lsngS6dPPzmb0Txarryv9X0ydrEB27VRZVYn7bvP8ltkMtd8uGmxMBwo4USgeC2M5P
         Cd793+ghufjuAuuK3mZ9Bb3UlbSoxnme4iI92TJ7tNdFrCiLMY7gORfOBoprAyg80z17
         7eKXdl4RYKCUeQJcSFCYIDbdBym5Ssrnhu/LXdw2iH2iTUFD+BFFKehUqqjXqf4VajYh
         wtALmlh/cCRwCIZinyNUuhFCKY9oRsutPRzqlNqpIx4nTYXYzTyTMAVzVqm8Isx/OR11
         UA9M0SZcP3xfaG345Z2mZEVAtBfaMxxd8xhYeHO0Mw6O8gUB4Mj96Tm5KGe4Ee3JKNuO
         sS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713907709; x=1714512509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUB6n1NsU2/7GWgTVD6aANG6lX22V95O/7uyuMDt2LI=;
        b=t2U+caZhIr3HriWY4oxbYbtBXBlrwkXrWfQn74qrojV52dC9WNi+0XEJo1gq1gOkQ8
         m8s7s0EhTR/FQ325yXLWcHbr0esK/hVcJahOJjtJLQx9xqOLDqXtUN5Of1BpVylmWNZf
         gQHLUj63psLs4mDPYAKQxlxZVYE74bPrfbV46lWOTxFFF/d64XcLu9wilU/AaDJqfzU0
         kox7jYzrB5a0DsO7rqoL8ufY06RzK7i7vIjSg0xSOHa7kHjm5jrFlhJ074Hhz20TA7kf
         00GLLw8b+/9XCVB3c5ct+lqi6dQuzG0KLKMM45hq7BGDgWDRbmcuFqNTy5oSpSDgtPiM
         oToQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7RMgDq5EYNQw6EiTtz1kuruvzKmp2j8fGFTOrCl2vyCIam69MshuOmIJpNpbXAmIH6JbpqFBLbxjoIcDCVIAksO2+
X-Gm-Message-State: AOJu0YxEZnJm1DXrIDytUp9ly2QUzBiSviyOWkX3B6u+NyMLkPLmqhwX
	Mb0KnyiVW9EU58X0RKeDdgBCxtzDpZGgyM2N1EDCnUQs5mumzjYQ
X-Google-Smtp-Source: AGHT+IFkAyJ2xLrAPOgSChFJUnUbY8BmzY4+vY9LTeg+Yo8UP+zrLVCDRilf2LzSBCYNyst0izMKCA==
X-Received: by 2002:a17:906:2412:b0:a58:7493:2cc6 with SMTP id z18-20020a170906241200b00a5874932cc6mr456687eja.34.1713907708740;
        Tue, 23 Apr 2024 14:28:28 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:23ba:342:e06:b489])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090660d100b00a587236e646sm1864275ejk.174.2024.04.23.14.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 14:28:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 7/8] update-ref: support symrefs in the update command
Date: Tue, 23 Apr 2024 23:28:17 +0200
Message-ID: <20240423212818.574123-8-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423212818.574123-1-knayak@gitlab.com>
References: <20240412095908.1134387-1-knayak@gitlab.com>
 <20240423212818.574123-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'update' command in 'git-update-ref' allows users to set `<ref>` to
`<new-oid>` after verifying `<old-oid>`, if given. Extend this command
to alternatively take in `ref:<new-target>` which is used to update to/a
symref with `<new-target>` as its target. And take in `ref:<old-target>`
which is used to verify that the symref points to `<old-target>` before
the update.

With this the 'update' command can also now be used to:
- create symrefs
- change a regular ref to a symref
- change a symref to a regular ref

This command will also support deref mode, to ensure that we can update
dereferenced regular refs to symrefs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  10 +-
 builtin/update-ref.c             |  21 ++--
 refs/files-backend.c             |  14 ++-
 refs/reftable-backend.c          |   3 +-
 t/t1400-update-ref.sh            | 168 +++++++++++++++++++++++++++++++
 5 files changed, 198 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 1202769178..79e29fead6 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -61,7 +61,7 @@ still contains <old-oid>.
 With `--stdin`, update-ref reads instructions from standard input and
 performs all modifications together.  Specify commands of the form:
 
-	update SP <ref> SP <new-oid> [SP <old-oid>] LF
+	update SP <ref> SP (<new-oid> | ref:<new-target>) [SP (<old-oid> | ref:<old-target>)] LF
 	create SP <ref> SP (<new-oid> | ref:<new-target>) LF
 	delete SP <ref> [SP (<old-oid> | ref:<old-target>)] LF
 	verify SP <ref> [SP (<old-oid> | ref:<old-target>)] LF
@@ -82,7 +82,7 @@ specify a missing value, omit the value and its preceding SP entirely.
 Alternatively, use `-z` to specify in NUL-terminated format, without
 quoting:
 
-	update SP <ref> NUL <new-oid> NUL [<old-oid>] NUL
+	update SP <ref> NUL (<new-oid> | ref:<new-target>) NUL [(<old-oid> | ref:<old-target>)] NUL
 	create SP <ref> NUL (<new-oid> | ref:<new-target>) NUL
 	delete SP <ref> NUL [(<old-oid> | ref:<old-target>)] NUL
 	verify SP <ref> NUL [(<old-oid> | ref:<old-target>)] NUL
@@ -109,7 +109,11 @@ update::
 	Set <ref> to <new-oid> after verifying <old-oid>, if given.
 	Specify a zero <new-oid> to ensure the ref does not exist
 	after the update and/or a zero <old-oid> to make sure the
-	ref does not exist before the update.
+	ref does not exist before the update.  If ref:<old-target>
+	is provided, we verify that the <ref> is an existing symbolic
+	ref which targets <old-target>.  If ref:<new-target> is given,
+	the update ensures <ref> is a symbolic ref which targets
+	<new-target>.
 
 create::
 	Create <ref> with <new-oid> after verifying it does not
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index afab706cd7..175579148f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -210,6 +210,8 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
 	struct strbuf err = STRBUF_INIT;
+	struct strbuf new_target = STRBUF_INIT;
+	struct strbuf old_target = STRBUF_INIT;
 	char *refname;
 	struct object_id new_oid, old_oid;
 	int have_old;
@@ -218,19 +220,24 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	if (!refname)
 		die("update: missing <ref>");
 
-	if (parse_next_arg(&next, end, &new_oid, NULL,
-			   "update", refname, PARSE_SHA1_ALLOW_EMPTY))
+	if (parse_next_arg(&next, end, &new_oid,
+			   &new_target, "update", refname,
+			   PARSE_SHA1_ALLOW_EMPTY | PARSE_REFNAME_TARGETS))
 		die("update %s: missing <new-oid>", refname);
 
-	have_old = !parse_next_arg(&next, end, &old_oid, NULL,
-				   "update", refname, PARSE_SHA1_OLD);
+	have_old = !parse_next_arg(&next, end, &old_oid,
+				   &old_target, "update", refname,
+				   PARSE_SHA1_OLD | PARSE_REFNAME_TARGETS);
+	have_old = have_old & !old_target.len;
 
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname,
-				   &new_oid, have_old ? &old_oid : NULL,
-				   NULL, NULL,
+				   new_target.len ? NULL : &new_oid,
+				   have_old ? &old_oid : NULL,
+				   new_target.len ? new_target.buf : NULL,
+				   old_target.len ? old_target.buf : NULL,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);
@@ -238,6 +245,8 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	update_flags = default_flags;
 	free(refname);
 	strbuf_release(&err);
+	strbuf_release(&old_target);
+	strbuf_release(&new_target);
 }
 
 static void parse_cmd_create(struct ref_transaction *transaction,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f5e271a442..59d1ab3eeb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2386,7 +2386,8 @@ static int split_symref_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
 			&update->new_oid, &update->old_oid,
-			NULL, NULL, update->msg);
+			update->new_target, update->old_target,
+			update->msg);
 
 	new_update->parent_update = update;
 
@@ -2610,7 +2611,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		}
 	}
 
-	if (update->new_target) {
+	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
 		if (create_symref_lock(refs, lock, update->refname, update->new_target)) {
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
@@ -2628,12 +2629,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		 * phase of the transaction only needs to commit the lock.
 		 */
 		update->flags |= REF_NEEDS_COMMIT;
-	}
-
-
-	if ((update->flags & REF_HAVE_NEW) &&
-	    !(update->flags & REF_DELETING) &&
-	    !(update->flags & REF_LOG_ONLY)) {
+	} else if ((update->flags & REF_HAVE_NEW) &&
+		   !(update->flags & REF_DELETING) &&
+		   !(update->flags & REF_LOG_ONLY)) {
 		if (!(update->type & REF_ISSYMREF) &&
 		    oideq(&lock->old_oid, &update->new_oid)) {
 			/*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e203c697f2..a00f55802a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -908,7 +908,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				new_update = ref_transaction_add_update(
 						transaction, referent.buf, new_flags,
-						&u->new_oid, &u->old_oid, NULL, NULL, u->msg);
+						&u->new_oid, &u->old_oid, u->new_target,
+						u->old_target, u->msg);
 				new_update->parent_update = u;
 
 				/*
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e85d08ce5c..5b2d23da37 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1360,6 +1360,7 @@ test_expect_success 'fails with duplicate HEAD update' '
 '
 
 test_expect_success 'fails with duplicate ref update via symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
 	git branch target2 $A &&
 	git symbolic-ref refs/heads/symref2 refs/heads/target2 &&
 	cat >stdin <<-EOF &&
@@ -1813,6 +1814,173 @@ do
 		git reflog exists refs/heads/symref
 	'
 
+	test_expect_success "stdin ${type} update symref fails with too many arguments" '
+		create_stdin_buf ${type} "update refs/heads/symref" "ref:$a" "ref:$a" "ref:$a" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: ref:$a" err
+		else
+			grep "fatal: update refs/heads/symref: extra input:  ref:$a" err
+		fi
+	'
+
+	test_expect_success "stdin ${type} update creates symref with zero old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "update refs/heads/symref" "ref:$a" "$Z" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} update creates symref with empty old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "update refs/heads/symref" "ref:$a" "" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} update symref fails with wrong old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "update refs/heads/symref" "ref:$m" "ref:$b" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		if test_have_prereq REFTABLE
+		then
+			grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected $b" err
+		else
+			grep "fatal: cannot lock ref ${SQ}refs/heads/symref${SQ}: is at $a but expected $b" err
+		fi &&
+		test_must_fail git rev-parse --verify -q $c
+	'
+
+	test_expect_success "stdin ${type} update symref works with right old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "update refs/heads/symref" "ref:$m" "ref:$a" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		echo $m >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} update creates symref (with deref)" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "update refs/heads/symref" "ref:$a" "" >stdin &&
+		git update-ref --stdin ${type} <stdin &&
+		echo $a >expect &&
+		git symbolic-ref --no-recurse refs/heads/symref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+		grep "$Z $(git rev-parse $a)" actual
+	'
+
+	test_expect_success "stdin ${type} update regular ref to symref with correct old-oid" '
+		test_when_finished "git symbolic-ref -d --no-recurse refs/heads/regularref" &&
+		git update-ref --no-deref refs/heads/regularref $a &&
+		create_stdin_buf ${type} "update refs/heads/regularref" "ref:$a" "$(git rev-parse $a)" >stdin &&
+		git update-ref --stdin ${type} <stdin &&
+		echo $a >expect &&
+		git symbolic-ref --no-recurse refs/heads/regularref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
+		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+	'
+
+	test_expect_success "stdin ${type} update regular ref to symref fails with wrong old-oid" '
+		test_when_finished "git update-ref -d refs/heads/regularref" &&
+		git update-ref --no-deref refs/heads/regularref $a &&
+		create_stdin_buf ${type} "update refs/heads/regularref" "ref:$a" "$(git rev-parse refs/heads/target2)" >stdin &&
+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+		echo $(git rev-parse $a) >expect &&
+		git rev-parse refs/heads/regularref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} update existing symref with zero old-oid" '
+		test_when_finished "git symbolic-ref -d --no-recurse refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref refs/heads/target2 &&
+		create_stdin_buf ${type} "update refs/heads/symref" "ref:$a" "$Z" >stdin &&
+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+		grep "fatal: cannot lock ref ${SQ}refs/heads/symref${SQ}: reference already exists" err &&
+		echo refs/heads/target2 >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} update existing symref to regular ref" '
+		test_when_finished "git update-ref -d refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref refs/heads/target2 &&
+		create_stdin_buf ${type} "update refs/heads/symref" "$(git rev-parse $a)" "ref:refs/heads/target2" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		echo $(git rev-parse $a) >expect &&
+		git rev-parse refs/heads/symref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+		grep "$(git rev-parse refs/heads/target2) $(git rev-parse $a)" actual
+	'
+
 done
 
+test_expect_success "stdin update symref (with deref)" '
+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+	test_when_finished "git update-ref -d --no-deref refs/heads/symref2" &&
+	git update-ref refs/heads/symref2 $a &&
+	git symbolic-ref --no-recurse refs/heads/symref refs/heads/symref2 &&
+	echo "update refs/heads/symref" "ref:$a" >stdin &&
+	git update-ref --stdin <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref2 >actual &&
+	test_cmp expect actual &&
+	echo refs/heads/symref2 >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+	grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+'
+
+test_expect_success "stdin -z update symref (with deref)" '
+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+	test_when_finished "git update-ref -d --no-deref refs/heads/symref2" &&
+	git update-ref refs/heads/symref2 $a &&
+	git symbolic-ref --no-recurse refs/heads/symref refs/heads/symref2 &&
+	printf "$F" "update refs/heads/symref" "ref:$a" "" >stdin &&
+	git update-ref --stdin -z <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref2 >actual &&
+	test_cmp expect actual &&
+	echo refs/heads/symref2 >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+	grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+'
+
+test_expect_success "stdin update regular ref to symref" '
+	test_when_finished "git symbolic-ref -d --no-recurse refs/heads/regularref" &&
+	git update-ref --no-deref refs/heads/regularref $a &&
+	echo "update refs/heads/regularref" "ref:$a" >stdin &&
+	git update-ref --stdin <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/regularref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
+	grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+'
+
+test_expect_success "stdin -z update regular ref to symref" '
+	test_when_finished "git symbolic-ref -d --no-recurse refs/heads/regularref" &&
+	git update-ref --no-deref refs/heads/regularref $a &&
+	printf "$F" "update refs/heads/regularref" "ref:$a" "" >stdin &&
+	git update-ref --stdin -z <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/regularref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
+	grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+'
+
 test_done
-- 
2.43.GIT

