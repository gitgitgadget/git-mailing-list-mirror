Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686331E84E
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065021; cv=none; b=iI/pMaVik+D8KF19+YCvOKvbysGTqL6yM30xxbXfn3t6r+Q5VYanbfXKpu6q2cSYYOBCs1kg5eAYPpZ+GDiu1txvPS7Bs6R+B5bTxeSv533ERTGzebux1vRHMTNu3K2dBDklqOMbQE7XFibGv4Pbd3g8fRVPABlMOyl5ACz8Tss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065021; c=relaxed/simple;
	bh=9doLdqCCR8VO8bHpSRG3evo3Ugo6OKckbno5wK5HnzE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pMvajgNdytP/EJXr7i1M5Qu4ra7DXpiPp9XqWGql1lmAiCAxWoFcTB0X6u8IOEEE6Jszl/KQp7Lsm+/FU0BHDe561kUFNKQiiaNkNYy3RbV3qwoX7w+8eXLskIc5SQnhEDg0Oy/a++4dL9lfVtUgs1aj17fY91oiwmKWPxGMX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4hL1PuB; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4hL1PuB"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d96243c91fso13065230eec.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065019; x=1777669819; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHCBMUFaxz36CYwWnIRQgJOAB030NGCGw9Gn6QtUMFI=;
        b=r4hL1PuByQcg1wgMgKPNO2pvdQUjVtS7jUjgzZYT6e0SXJyOgI7vnB1xNzdT5Z/TQW
         7zO+A5+iRqcxGLmBhHoRvF/bNilBn5PWKMnQXMmCiq/0VFWFF4MOoD8U9AK8hkPKyok/
         K/MnSkR6+5j4RiZLPoNlWSs5CaYrDv5zoUBr/pPMX78YahLszPmUW5uDYenpNECkqZFT
         3MaqdMXIbaxmlSsztNVtsdlEQlol5fPTDrxbhyyh8TsV1Z9vZ0gjalzlvx4tUV4YICtR
         viM6WZ5+81UL3SnUzR/00/lcTr83g09lM0NKPXquojmT1S2/QWNhC2vNRB48NNTip33e
         9fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065019; x=1777669819;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OHCBMUFaxz36CYwWnIRQgJOAB030NGCGw9Gn6QtUMFI=;
        b=FyLHXHKSj6BnMSuaUaYzZs4o9ZszblVTgtKLG+7kK9M4VVtUMs06tFh1hSrdmkEKz9
         rC9dRE240KzcudnWvc+k0r1kc7D6v4ZOmUpWiDJcedaDyPg2UEGl3qhMIuUEL/Jr+5Po
         55wBZTQ5Ny0IRyCM0jqwOKhRSXmP+ezLKJ16/+BMpLkS64QVx9H73hK6MbpbRcLhRNS9
         6/Ab8aeL310SbXVFNYNI6QGmgeFdh1OdDzGfG6weN79AMr4XyFJdGrF75AcKqaY1PnhH
         gJMmEGXorIYHKVonGKebNPQvm7RCXUhIs5UOwwtTGM9fhkbfxigCpKotZQvGJAoJI4nU
         PIhg==
X-Gm-Message-State: AOJu0YwvoiS4ai4iRbiKiIg0u0SlIQVTM+oK4Ifm/H7waH17XOY5JeQJ
	13M5HU7hS+IJHybB0BgxdRv4vI0aFxwV8u4Bhl/utGXTf6NoB92R00iGRY3dnA==
X-Gm-Gg: AeBDiesJVwOUjkWBxtOLRNSryxm+LB8hOEgrecXPGSITOhpmQyEfxlu6g640exOKA/7
	5Loo0Z+dhLZth23cr9N4q5bsp9BPf1FfSEShLYJtrQ1kjTQEvtwNlvU4hDWbk9qivejH/awFYwL
	B9lzTI2vo/hvWLS6R+fIwY6VcmM8JEanjjNSyn9mNZ3HQaiziJtp9G4awIAVqB2N8JlAH7WtjW6
	miVHMD3+zqHYoNHtfQeik2HntWmVrvwffQbakSpLyYekICJAL3i6FWd8TFv/am+TyJ+ORlcRgxN
	17PznNfu+pl3im+R1P3qgS9yRXTAMR7xAhHrOuLyECs9BfWN/2WDM+fnB+t3DvNovDAWMIKHXyr
	LyZrajrT+7GbMgEOQUTkLbB3r0az8klkxPX/BCkmXDXYZAsgqcxN1cym87Ra/xOT/4RbIxd+nfj
	PsGZkIdbe3z1aSvIozkqVA0zSIw42QXP+Oz80FIzrM12spA3fV9w==
X-Received: by 2002:a05:693c:2b15:b0:2d8:97d6:6abc with SMTP id 5a478bee46e88-2e47a105b1cmr20190162eec.22.1777065018541;
        Fri, 24 Apr 2026 14:10:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccd2564sm34643446eec.18.2026.04.24.14.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:10:18 -0700 (PDT)
Message-Id: <a428ce73281dd288f0c4f44c4f92c03129556b7f.1777065012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
	<pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 21:10:10 +0000
Subject: [PATCH v15 3/5] sequencer: teach autostash apply to take optional
 conflict marker labels
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add label_ours, label_theirs, label_base, and stash_msg parameters to
apply_autostash_ref() and the autostash apply machinery so callers can
pass custom conflict marker labels through to
"git stash apply --label-ours/--label-theirs/--label-base", as well as
a custom stash message for "git stash store -m".

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/commit.c |  3 ++-
 builtin/merge.c  |  9 ++++++---
 sequencer.c      | 38 +++++++++++++++++++++++++++++---------
 sequencer.h      |  4 +++-
 4 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a3e52ac9ca..28f6174503 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1979,7 +1979,8 @@ int cmd_commit(int argc,
 				     &oid, flags);
 	}
 
-	apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+	apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+			    NULL, NULL, NULL, NULL);
 
 cleanup:
 	free_commit_extra_headers(extra);
diff --git a/builtin/merge.c b/builtin/merge.c
index 3ebe190ef1..aacf8c524e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -537,7 +537,8 @@ static void finish(struct commit *head_commit,
 	run_hooks_l(the_repository, "post-merge", squash ? "1" : "0", NULL);
 
 	if (new_head)
-		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+				    NULL, NULL, NULL, NULL);
 	strbuf_release(&reflog_message);
 }
 
@@ -1678,7 +1679,8 @@ int cmd_merge(int argc,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
 					  overwrite_ignore)) {
-			apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+			apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+					    NULL, NULL, NULL, NULL);
 			ret = 1;
 			goto done;
 		}
@@ -1851,7 +1853,8 @@ int cmd_merge(int argc,
 		else
 			fprintf(stderr, _("Merge with strategy %s failed.\n"),
 				use_strategies[0]->name);
-		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+				    NULL, NULL, NULL, NULL);
 		ret = 2;
 		goto done;
 	} else if (best_strategy == wt_strategy)
diff --git a/sequencer.c b/sequencer.c
index ff5258f481..7c0376d9e4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4727,7 +4727,10 @@ void create_autostash_ref(struct repository *r, const char *refname,
 	create_autostash_internal(r, NULL, refname, message, silent);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
+static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base,
+				    const char *stash_msg)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
@@ -4738,6 +4741,12 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		child.no_stderr = 1;
 		strvec_push(&child.args, "stash");
 		strvec_push(&child.args, "apply");
+		if (label_ours)
+			strvec_pushf(&child.args, "--label-ours=%s", label_ours);
+		if (label_theirs)
+			strvec_pushf(&child.args, "--label-theirs=%s", label_theirs);
+		if (label_base)
+			strvec_pushf(&child.args, "--label-base=%s", label_base);
 		strvec_push(&child.args, stash_oid);
 		ret = run_command(&child);
 	}
@@ -4751,7 +4760,7 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 		strvec_push(&store.args, "stash");
 		strvec_push(&store.args, "store");
 		strvec_push(&store.args, "-m");
-		strvec_push(&store.args, "autostash");
+		strvec_push(&store.args, stash_msg ? stash_msg : "autostash");
 		strvec_push(&store.args, "-q");
 		strvec_push(&store.args, stash_oid);
 		if (run_command(&store))
@@ -4782,7 +4791,8 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	}
 	strbuf_trim(&stash_oid);
 
-	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
+				      NULL, NULL, NULL, NULL);
 
 	unlink(path);
 	strbuf_release(&stash_oid);
@@ -4801,11 +4811,14 @@ int apply_autostash(const char *path)
 
 int apply_autostash_oid(const char *stash_oid)
 {
-	return apply_save_autostash_oid(stash_oid, 1);
+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
 }
 
 static int apply_save_autostash_ref(struct repository *r, const char *refname,
-				    int attempt_apply)
+				    int attempt_apply,
+				    const char *label_ours, const char *label_theirs,
+				    const char *label_base,
+				    const char *stash_msg)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
@@ -4821,7 +4834,9 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 		return error(_("autostash reference is a symref"));
 
 	oid_to_hex_r(stash_oid_hex, &stash_oid);
-	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
+	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
+				       label_ours, label_theirs, label_base,
+				       stash_msg);
 
 	refs_delete_ref(get_main_ref_store(r), "", refname,
 			&stash_oid, REF_NO_DEREF);
@@ -4831,12 +4846,17 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 
 int save_autostash_ref(struct repository *r, const char *refname)
 {
-	return apply_save_autostash_ref(r, refname, 0);
+	return apply_save_autostash_ref(r, refname, 0,
+					NULL, NULL, NULL, NULL);
 }
 
-int apply_autostash_ref(struct repository *r, const char *refname)
+int apply_autostash_ref(struct repository *r, const char *refname,
+			const char *label_ours, const char *label_theirs,
+			const char *label_base, const char *stash_msg)
 {
-	return apply_save_autostash_ref(r, refname, 1);
+	return apply_save_autostash_ref(r, refname, 1,
+					label_ours, label_theirs, label_base,
+					stash_msg);
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
diff --git a/sequencer.h b/sequencer.h
index 02d2d9db06..3164bd437d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -235,7 +235,9 @@ int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
-int apply_autostash_ref(struct repository *r, const char *refname);
+int apply_autostash_ref(struct repository *r, const char *refname,
+			const char *label_ours, const char *label_theirs,
+			const char *label_base, const char *stash_msg);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
gitgitgadget

