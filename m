Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696222425B
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270525; cv=none; b=lVuyAbcOx6YzXpkPLuqrW/tRXJDEZfWoslfWqGnZW8Z6yF0+xZcc5mJT7Q7j8X44ADj6hhPm7IjM0Zar8AbO1RxoFc8u4lpS99f93ScowIDJkIvqje0AtuQqKNUqPOZqMq4Q0oPx5pCPPYdIALt/C1xqWQLB7oknW91ySL75xBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270525; c=relaxed/simple;
	bh=RHH4TM3CHEd572w9cb1VSZZPhdqEZkVusQkjMp9ZQaA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RhcyXRtEIhZqVdigryMAqiWVfOgauZ3OZ4j9ds/1eIaodw1rvzb0D05DpRmT4YBeXVXJjHr/rFDQfipepEczuvtttzVloMp5Cp+08Gucrdi7Cjgf2ZBQqaD1+7XZg7bYJLHLa+MjjDwx8riSxSg7eRaG/MY/2VCGZtyF9SLSvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oaHgOVHH; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaHgOVHH"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4f59e61f295so211227b6e.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791270523; x=1791875323; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YtxMvhN8QqbSTqdeANm/SeoSrDIkYQEbSryLdwKpCW0=;
        b=oaHgOVHHc1PBhnSeTlFurlMQV7MipI0TERecwgcd+TSwhMXcrv+YfErrkC/CCRGgxZ
         mN7PpORdHjgAT7ylQwyAxQji0+Xzi2/yhxWeWilwPjn8JXVpsUz2aZbeFzyIRoIYb7Vd
         xJ90iu8L+zsKoNeyjLeH7Kjsj4WyOdA37p+accPfOehKoNioqfLnK+R72ML1MwYIlWZp
         +4f1BzWBAi04V1xhkm3I03qVcnkV/Ck6/SKlQnYC1tfUpSshk7LSsAmeuhCUUK/OYD1H
         RMSH/jcK24yqQjek/+R/d2My8Hb7JSK9ewwDmI/R8wuYE5WJAGFP9ornJMblcVA/52OE
         mQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791270523; x=1791875323;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtxMvhN8QqbSTqdeANm/SeoSrDIkYQEbSryLdwKpCW0=;
        b=bgYJuajyO5s/UB3Z18rtUuZBCBvH/S94uqUCyqIZrygS2GF3c4CvbMNL+WDi7a2HOP
         /QoQHUdAa1APELNe25P8RIa9nocv1mTBux5YXn/FgOIc0blesTcS+LsWbxrwv7Q7yXAs
         svyRwWfCw4tlujZEIvNSVLE3CZB8F7pzTwNHGQrJ+O0nqNf1lwTqvnlykOl4EccIhrvK
         NXPV2CFNJz8k5G43zRK18PMRtxurRouRJnUZseQzCA3kVCdyhyQe8asmJECyTuVaTL/j
         1Y+0ZnI2XIBwyYPrGahPNpa5d23s+3OsGUUbAvcv6ke4ECdlfwuiyWZdGwprmt8ZArps
         Ja+w==
X-Gm-Message-State: AFuF++km/fqH2rMl6P47PyJN3DHIbsadzOZb8Ea7W78c7Wl+2gJLMHNc
	Bn8KaPVnwf+1XOR3pjYG/FApJksBuKekrv3ykxaU7SEQ0w01FTPXCw352PXN59dB
X-Gm-Gg: AYBFou3wNhM3z4fOBptzoa0u9aNOHsIvShzBj0Qn6+5kJRZld931kbEanJ9ZgtKocz+
	2KQjz0oa7YYW+OXASbye9GYaHmJxiOR84Jk3Kc5M/JEfLE/HARzbZsTphDS64bX74MMpI0MfbAC
	Fw6I1fAIKUVIQUegeA131dYOlxnec9PuNw+TST3QEK+9x9n3J/MGHj8xBozNjnjvCZZDkhz934H
	Td6L2zJul5sZWSahvJYNrNC6vKUEFJP664SUGE8qfguQLAzWeh0MiL7ZgnURGUA6S+EBR+UUNEJ
	mv+UcuncgSeQkJDhg7Iuo+/ErU8mxq6BnU9bqlwF+ubUUWHu0uRvkmAGiXLtKCQO5zOOGhAqIOP
	UYEAuao0da8nVliGQF6Q3HMfAM+dOF1IY8snVLpdc+Jmi6F9Tl4+1Nr/1ujd/sZazgIo4cqpFxM
	xt4HIGdUZgUOh1AL0ffW+4F4ZpjVA+cNkjLqhCS1IQMMnOcaptYIhRmFT1Vti7W+r8ZiP+NpkwX
	ueq
X-Received: by 2002:a05:6808:191d:b0:4f3:f7da:3e55 with SMTP id 5614622812f47-4fb415cd245mr528035b6e.62.1791270522654;
        Tue, 06 Oct 2026 00:08:42 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.187.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4facb18966fsm1734679b6e.14.2026.10.06.00.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:08:41 -0700 (PDT)
Message-Id: <740bf17e1360f698402203654643e4ca585754a9.1791270504.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
References: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 07:08:23 +0000
Subject: [PATCH 5/6] push: offer a force push after rewriting pushed commits
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

After amending or rebasing commits you already pushed, "git push" is
rejected with a hint to run "git pull" first. Pulling merges the old
copies of the same work back in.

When the rejected remote tip is a commit your branch pointed to before,
according to its reflog, the remote carries no work you have not seen.
Name the branch and offer a force push next to the pull:

  hint: Updates were rejected because 'origin/topic' has diverged
  hint: from your current branch. Use 'git pull origin topic'
  hint: to integrate the remote changes, or replace them with
  hint: 'git push --force-with-lease origin topic'.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/push.c           | 17 +++++++++++++---
 t/t6040-tracking-info.sh | 18 +++++++++++++++++
 transport.c              | 42 ++++++++++++++++++++++++++++++++++++++--
 transport.h              | 13 +++++++------
 4 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 82435beab5..d918723d43 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -301,6 +301,12 @@ static const char message_advice_pull_from_branch_before_push[] =
 	   "from your current branch. Use 'git pull %s %s'\n"
 	   "to integrate the remote changes.");
 
+static const char message_advice_pull_or_force_before_push[] =
+	N_("Updates were rejected because '%s' has diverged\n"
+	   "from your current branch. Use 'git pull %s %s'\n"
+	   "to integrate the remote changes, or replace them with\n"
+	   "'git push --force-with-lease %s %s'.");
+
 static const char message_advice_checkout_pull_push[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
 	   "counterpart. If you want to integrate the remote changes, use 'git pull'\n"
@@ -328,7 +334,8 @@ static const char message_advice_ref_needs_update[] =
 	   "remote changes, use 'git pull' before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
-static void advise_pull_before_push(struct remote *push_remote)
+static void advise_pull_before_push(struct remote *push_remote,
+				    unsigned int reject_reasons)
 {
 	struct branch *branch = branch_get(NULL);
 	struct remote *remote = NULL;
@@ -349,7 +356,11 @@ static void advise_pull_before_push(struct remote *push_remote)
 		tracking_name = refs_shorten_unambiguous_ref(
 			get_main_ref_store(the_repository), tracking, 0);
 
-	if (tracking && (!upstream || strcmp(tracking, upstream)))
+	if (tracking && (reject_reasons & REJECT_NON_FF_HEAD_REWRITE))
+		advise(_(message_advice_pull_or_force_before_push),
+		       tracking_name, remote->name, branch->name,
+		       remote->name, branch->name);
+	else if (tracking && (!upstream || strcmp(tracking, upstream)))
 		advise(_(message_advice_pull_from_branch_before_push),
 		       tracking_name, remote->name, branch->name);
 	else
@@ -435,7 +446,7 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 		return 0;
 
 	if (reject_reasons & REJECT_NON_FF_HEAD) {
-		advise_pull_before_push(remote);
+		advise_pull_before_push(remote, reject_reasons);
 	} else if (reject_reasons & REJECT_NON_FF_OTHER) {
 		advise_checkout_pull_push();
 	} else if (reject_reasons & REJECT_ALREADY_EXISTS) {
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 9eb810e158..b53034ba36 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -863,6 +863,24 @@ test_expect_success 'push to the upstream branch' '
 	hint: use ${SQ}git pull${SQ} before pushing again.
 	hint: See the ${SQ}Note about fast-forwards${SQ} in ${SQ}git push --help${SQ} for details.
 	EOF
+	test_cmp expect actual &&
+	(
+		cd test &&
+		git pull --rebase &&
+		git push &&
+		echo amended >mine21 &&
+		git commit -a --amend --no-edit &&
+		test_must_fail git push 2>../actual
+	) &&
+	cat >expect <<-EOF &&
+	To $url
+	 ! [rejected]        feature21 -> feature21 (non-fast-forward)
+	error: failed to push some refs to ${SQ}$url${SQ}
+	hint: Updates were rejected because ${SQ}origin/feature21${SQ} has diverged
+	hint: from your current branch. Use ${SQ}git pull origin feature21${SQ}
+	hint: to integrate the remote changes, or replace them with
+	hint: ${SQ}git push --force-with-lease origin feature21${SQ}.
+	EOF
 	test_cmp expect actual
 '
 
diff --git a/transport.c b/transport.c
index 25e2c14a7b..630dd699db 100644
--- a/transport.c
+++ b/transport.c
@@ -891,6 +891,42 @@ int transport_summary_width(const struct ref *refs)
 	return (2 * maxw + 3);
 }
 
+struct reflog_has_tip_cb_data {
+	const struct object_id *target;
+	int found;
+};
+
+static int reflog_has_tip(const char *refname UNUSED,
+			   struct object_id *old_oid UNUSED,
+			   struct object_id *new_oid,
+			   const char *committer UNUSED,
+			   timestamp_t timestamp UNUSED,
+			   int tz UNUSED, const char *msg UNUSED,
+			   void *cb_data)
+{
+	struct reflog_has_tip_cb_data *cb = cb_data;
+
+	if (!oideq(new_oid, cb->target))
+		return 0;
+	cb->found = 1;
+	return 1;
+}
+
+/*
+ * Was "refname" ever at "oid" according to its reflog? Then a remote
+ * sitting at "oid" carries no work we have not seen, only commits we
+ * have since rewritten, for example with 'commit --amend' or 'rebase'.
+ */
+static int local_ref_used_to_be_at(const char *refname,
+				    const struct object_id *oid)
+{
+	struct reflog_has_tip_cb_data cb = { .target = oid };
+
+	refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository),
+					 refname, reflog_has_tip, &cb);
+	return cb.found;
+}
+
 void transport_print_push_status(const char *dest, struct ref *refs,
 				  int verbose, int porcelain, unsigned int *reject_reasons)
 {
@@ -925,9 +961,11 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 			n += print_one_push_status(ref, dest, n,
 						   porcelain, summary_width);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD) {
-			if (head != NULL && !strcmp(head, ref->name))
+			if (head != NULL && !strcmp(head, ref->name)) {
 				*reject_reasons |= REJECT_NON_FF_HEAD;
-			else
+				if (local_ref_used_to_be_at(head, &ref->old_oid))
+					*reject_reasons |= REJECT_NON_FF_HEAD_REWRITE;
+			} else
 				*reject_reasons |= REJECT_NON_FF_OTHER;
 		} else if (ref->status == REF_STATUS_REJECT_ALREADY_EXISTS) {
 			*reject_reasons |= REJECT_ALREADY_EXISTS;
diff --git a/transport.h b/transport.h
index 39193d0077..87944fcd92 100644
--- a/transport.h
+++ b/transport.h
@@ -252,12 +252,13 @@ int transport_set_option(struct transport *transport, const char *name,
 void transport_set_verbosity(struct transport *transport, int verbosity,
 	int force_progress);
 
-#define REJECT_NON_FF_HEAD      0x01
-#define REJECT_NON_FF_OTHER     0x02
-#define REJECT_ALREADY_EXISTS   0x04
-#define REJECT_FETCH_FIRST      0x08
-#define REJECT_NEEDS_FORCE      0x10
-#define REJECT_REF_NEEDS_UPDATE 0x20
+#define REJECT_NON_FF_HEAD         0x01
+#define REJECT_NON_FF_OTHER        0x02
+#define REJECT_ALREADY_EXISTS      0x04
+#define REJECT_FETCH_FIRST         0x08
+#define REJECT_NEEDS_FORCE         0x10
+#define REJECT_REF_NEEDS_UPDATE    0x20
+#define REJECT_NON_FF_HEAD_REWRITE 0x40
 
 int transport_push(struct repository *repo,
 		   struct transport *connection,
-- 
gitgitgadget

