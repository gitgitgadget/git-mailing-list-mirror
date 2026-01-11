Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E7022AE65
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768111158; cv=none; b=JZAxldDsKJZyXwmLwS1OOZV4MV/IpLmKNxTXrvJfT/24BQpkDBckz2Qiz4e3Ctn6HFqnuitTqUtRQK32yRMLphIqIEcp5x0qh0XIW32uWJ6lZUr1DtIoSRNTemGIOnLXK7NSTCQ6rSHa0Q3YT0+G7102yvWiqWdkFwSxdEo2Ngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768111158; c=relaxed/simple;
	bh=zxENQ5cew6MsqC0tpoFENOgeQIjrfcRfsnBquk9oXoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPWB2wTdaC7V1gb2996teweWX+tY7mokC0ucwJeqMCpGOKyn9QkmdMtVWA+P+dy9y6QXZwgldRZA0HS1iPCAmJNXSHPnA7xR0QXSuQpOyZBwlBGGAlYEyDCZ5pW3CWK+nLeOIPcRrdM63IQ+dQf406msXq1XGlH4TY2/mD04Z2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha/QWNiE; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha/QWNiE"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso5551724eec.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 21:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768111156; x=1768715956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/+lM8pslBlcCZrHiHMv5Nsd/OVY3buM7bJE30Jji6Y=;
        b=ha/QWNiEXyM2wL94IhoWE/KeKQSSNSt8hPrOWMhjrULIswSvFpsOkw3zmzN9uxalmM
         zu5j9y4q5ACzXELaoJVkyjK8O4De9637UNUNXNygjB/UV5owgF5UoTejAR20e+Doylyh
         PHvHnG+6CketOWe9/XHr8DCNFrQCHDWUnhqHaGvQE+qKMWA4wgW/fSBaMaaX3by66hQO
         Gfl+mb0sOFJ7NZGiFuotWsHaqA/qbseai+8F2dLDbR2txgCa3+WoDoOiYAcAcy22Z0jy
         npy5pFz5hDg8L9uRqQIoK0qF9Zr26U7xfuTgCS3HA49ZCDqMQ+esoPFwc4eIcuL74ef7
         0ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768111156; x=1768715956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B/+lM8pslBlcCZrHiHMv5Nsd/OVY3buM7bJE30Jji6Y=;
        b=FYIMH/1tbV9ShbkX00fC86PrIvd7xbMMb793TpOk7YJQWAX09W3WqXnkuN0guVwuM2
         loeDKy/pXZddQVXIYjOcbv7HvlOVXBv4/MRxkbAuI70FsH8T5ig2cuuqEegv0tPlEw+E
         3omNhb0BvZ+phWOMxEwrxkxx3/seZNj8LjY9Fex/chz17Kk640xNDKAxTIx0ij1BD+S0
         eiu2gCvZBmFwwBRq1G22SwRbzvHDV48QsF6I3mjSHjXyEs/cL2o/iJL87dqKZ6x4VmBV
         Cuni84BicZ3N5X1a/CI2ahocLQ00n6NddRC1d3oBWOcxwgelRlsum51seFpMUFWcbA9n
         EH4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUfVg/q6o1qXgxRecrLIuiWfw3RjI2WXtqK/6UMj6Rcl9roPX/8P5fqsMlnk49CqnWPHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcP/0Ahr2gECycymRzi3DgPsNaxRjWqxrNrtWgN7dLc9eJ69SR
	D41B6jBuXX72+zZGFOSQEJq9ZnaKvARSpPlOqEcFkNeJgdsCeNcfXiTb
X-Gm-Gg: AY/fxX6U6qY8lryU/D2JDd5EvIK/OTpWSqeMngNjZefIb4H1uCbfiErvhXg8joDRh8u
	zXL7yfFZLgACvV4IrtIAir3mLEXrDcjxp8OcwiSgJ6Gs+Gcu6PLKwCpY4VtieX6uEhwRyUgjKCv
	TBd2yfI/rfrHDi4FEuqqzTzpT26AOqsMKAm2QWmyb8ehsXTjbaqfZ+Tj8wngw+OsDhseFsoFWTD
	SC+FJjJeMkAaqsR1APj3jI0g6diSDUxOYbK+2bRSdnOMeZUxSqLZexijjEQ607P1Yn4/D8abzqp
	fp75eOkqyXL/h+XEITBD2KkdQiZgcJzRbH/QGfSZ/+P4QRwdBqH/PXE9nQyZh4z+hMKC3eCSRC2
	XXJyZNXX0cAVJG3tXqTNTI4kU5l4EJqXWlUmDn3LsDqD03ZHNNcSXnvSJnyNF0qgrQ7sR28aVZ7
	7mKAzjZXuLpRXsWFBgZm6/4aG1XyD/69M=
X-Google-Smtp-Source: AGHT+IETP+tdfHkqpmTgxNkloq47xBO4IcFo60owLlATixcWO5koYj9BDQC7Hp9LM0JffIybdDLDRQ==
X-Received: by 2002:a05:7300:8b84:b0:2b0:51a7:509a with SMTP id 5a478bee46e88-2b17d2baf30mr13088981eec.33.1768111156285;
        Sat, 10 Jan 2026 21:59:16 -0800 (PST)
Received: from PW0EDBZC.hsd1.ca.comcast.net ([2601:646:9e00:ecc0:93a8:3b8e:dd1c:9340])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b13bdsm13215133eec.24.2026.01.10.21.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 21:59:15 -0800 (PST)
From: Elijah Newren <newren@gmail.com>
To: Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH v9 9/7] history: fix detached HEAD handling
Date: Sat, 10 Jan 2026 21:58:59 -0800
Message-ID: <20260111055859.408891-3-newren@gmail.com>
X-Mailer: git-send-email 2.52.0.410.g227cdbe8e36
In-Reply-To: <20260111055859.408891-1-newren@gmail.com>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
 <20260111055859.408891-1-newren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default behavior for history is to work on all local branches.  When
HEAD is detached, it should be treated like a local branch as well.
The primary fix for this is just to make sure that in addition to passing
--branches to the revision machinery that we pass HEAD as well.

However, that doesn't quite do the trick, because we also process the
"decorations" that point at commits that we have processed, and we do
this in two places -- in replay_revisions() as we replay commits, and
in handle_reference_updates() when there are no commits to replay
because the commit at the tip of the revision range was the one edited.
In both cases, we previously keyed off of DECORATION_REF_LOCAL to make
sure we only looked at local branches.  Now, we need to also pay
attention to DECORATION_REF_HEAD.  However, in order to avoid doing two
updates to the same branch (which will the ref transaction framework
would throw an error on), we need to only pay attention to
DECORATION_REF_HEAD when we have a detached HEAD.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/history.c         | 15 +++++++++++--
 replay.c                  | 18 ++++++++++++---
 t/t3451-history-reword.sh | 47 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 60c5b5c5c76..dd0df89c94e 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -183,10 +183,18 @@ static int handle_reference_updates(enum ref_action action,
 	struct strvec args = STRVEC_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct commit *head = NULL;
+	char *head_ref = NULL;
+	bool detached_head = false;
 	struct rev_info revs;
 	char hex[GIT_MAX_HEXSZ + 1];
 	int ret;
 
+	head_ref = refs_resolve_refdup(get_main_ref_store(repo), "HEAD",
+				       RESOLVE_REF_READING, NULL, NULL);
+	if (!strcmp(head_ref, "HEAD"))
+		detached_head = true;
+	free(head_ref);
+
 	repo_init_revisions(repo, &revs, NULL);
 	strvec_push(&args, "ignored");
 	strvec_push(&args, "--reverse");
@@ -234,6 +242,7 @@ static int handle_reference_updates(enum ref_action action,
 		strvec_push(&args, "HEAD");
 	} else {
 		strvec_push(&args, "--branches");
+		strvec_push(&args, "HEAD");
 	}
 
 	setup_revisions_from_strvec(&args, &revs, NULL);
@@ -278,9 +287,11 @@ static int handle_reference_updates(enum ref_action action,
 		     decoration;
 		     decoration = decoration->next)
 		{
-			if (decoration->type != DECORATION_REF_LOCAL)
+			if ((decoration->type != DECORATION_REF_HEAD ||
+			     (action != REF_ACTION_HEAD && !detached_head)) &&
+			    (decoration->type != DECORATION_REF_LOCAL ||
+			     action == REF_ACTION_HEAD))
 				continue;
-
 			ret = ref_transaction_update(transaction,
 						     decoration->name,
 						     &rewritten->object.oid,
diff --git a/replay.c b/replay.c
index ea300e3c36c..7c98b1d1044 100644
--- a/replay.c
+++ b/replay.c
@@ -151,11 +151,20 @@ static void get_ref_information(struct repository *repo,
 static void set_up_replay_mode(struct repository *repo,
 			       struct rev_cmdline_info *cmd_info,
 			       const char *onto_name,
+			       bool *detached_head,
 			       char **advance_name,
 			       struct commit **onto,
 			       struct strset **update_refs)
 {
 	struct ref_info rinfo;
+	char *head_ref;
+
+	*detached_head = false;
+	head_ref = refs_resolve_refdup(get_main_ref_store(repo), "HEAD",
+				       RESOLVE_REF_READING, NULL, NULL);
+	if (!strcmp(head_ref, "HEAD"))
+		*detached_head = true;
+	free(head_ref);
 
 	get_ref_information(repo, cmd_info, &rinfo);
 	if (!rinfo.positive_refexprs)
@@ -271,11 +280,12 @@ int replay_revisions(struct rev_info *revs,
 		.clean = 1,
 	};
 	char *advance;
+	bool detached_head;
 	int ret;
 
 	advance = xstrdup_or_null(opts->advance);
-	set_up_replay_mode(repo, &revs->cmdline, opts->onto, &advance,
-			   &onto, &update_refs);
+	set_up_replay_mode(repo, &revs->cmdline, opts->onto,
+			   &detached_head, &advance, &onto, &update_refs);
 
 	/* FIXME: Should allow replaying commits with the first as a root commit */
 
@@ -317,7 +327,9 @@ int replay_revisions(struct rev_info *revs,
 		if (!decoration)
 			continue;
 		while (decoration) {
-			if (decoration->type == DECORATION_REF_LOCAL &&
+			if ((decoration->type == DECORATION_REF_LOCAL ||
+			     (decoration->type == DECORATION_REF_HEAD &&
+			      detached_head)) &&
 			    (opts->contained || strset_contains(update_refs,
 								decoration->name))) {
 				replay_result_queue_update(out, decoration->name,
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index cd5883051d6..7ddbab8e676 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -77,6 +77,53 @@ test_expect_success 'can reword commit in the middle' '
 	)
 '
 
+test_expect_success 'can reword commit in the middle even on detached head' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third_on_main &&
+		git checkout --detach HEAD^ &&
+		test_commit third_on_head &&
+
+		reword_with_message HEAD~ <<-EOF &&
+		second reworded
+		EOF
+
+		expect_log HEAD --branches --graph <<-\EOF
+		* third_on_head
+		| * third_on_main
+		|/  
+		* second reworded
+		* first
+		EOF
+	)
+'
+
+test_expect_success 'can reword the detached head' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		git checkout --detach HEAD &&
+		test_commit third &&
+
+		reword_with_message HEAD <<-EOF &&
+		third reworded
+		EOF
+
+		expect_log <<-\EOF
+		third reworded
+		second
+		first
+		EOF
+	)
+'
+
 test_expect_success 'can reword root commit' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.52.0.410.g227cdbe8e36

