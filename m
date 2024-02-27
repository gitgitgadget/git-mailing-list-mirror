Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DD513B7AB
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042790; cv=none; b=eH0/A7j1w4+vdE5Jq1ekMQ+dIxsSwY3+m9MjxWEUw0l08OeKedn217TV6mf5Q7BsfEJbbUv4oOIZOSRx9HfCYAEijZhmEbRL1vR1JsJwFWZnwY2Bf+xCoGeZzK82wKo5yQuOSFauo9bOUd0xcn50QJjWvSZ6lPv48UDfWzmPJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042790; c=relaxed/simple;
	bh=28ctFJeQBobxeU+Ty3WMrXeNmVH7aNp/tjtmMM9ZT8E=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Tm6qhV0ml2vvrdsTW4kMmoHZtVXUw3/pHIDpzBnAdGkDmUkNwZ3hqNTd+fsHVDM+IciGcefDqiLydJ0HOgbD0px8jQeAsqMrJSZr/nqWeqgZrIO/4FNj6O17CBbHV4CRE6UAWYRQeHABd3w7vsgK8drc9JeAk3Bt0Ya/pT1LDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edrSwUNJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edrSwUNJ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512bd533be0so5216241e87.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709042785; x=1709647585; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OE37wztyeBzo5stTOJOqgZmwXoutK2vDy4G3rxqoVtI=;
        b=edrSwUNJeltvbSmqrFZiOxLsQGflls1HO0HUPmHFUkBkgwGoUTNP5ywtcH1d8ITqpm
         +g6ZXLUDl56SjELBQLUEJAOMdP29Tf6z1fi72+4KBHvaIRVZ6pnRkZDBAaVgFdiAtfsw
         HwzcSQOYMw4/I36Z2oopRiSZk0ESrfS55uMDnuYi31mnrdXWNbEl9JvOaOjNqQRs1tfi
         SNoSXCjxWlTuuaSH/bW2YBtvxwThrkm7gKSeSY0fxdbR9UN7y929ehk88OOlvB/EEaf5
         ogwQCIa2R2TCRF//hZsybtfFJWcibPwfJqg4FiE3dnDHN0FyMBmrqCKI6R00VTc+Ofxj
         smTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709042785; x=1709647585;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE37wztyeBzo5stTOJOqgZmwXoutK2vDy4G3rxqoVtI=;
        b=JgdGOn5s6+yKJxdkzrXFgi2v9hiMhdc1ILXmh2iHbJ9mNzwABck6bUt5POtqulebsb
         VjYatoHalMgLrGmk5gxVxqSEbiIHcEOtd0wigqGw1DSwaRnL/p9r4eu2G4FFkXuFn2E1
         9pDjNJoNBsp0xRBtY0VbezfqIOQ1dPRwCXOOHgbalv0eujBPz44lgl4B2DvG5f6QOWEG
         Hv716SKaOxsFHuWnN/Kic/YuMp1URbsVRLsq8XLK48AclXzky2V8++v/RB83X8v3Pq3V
         5RCDFHfKeN6+jokt/8xiyDogkKq4oT8GwecBMleTSz+OnwsIFU6S23tr+XLteeaqhIH0
         J7Eg==
X-Gm-Message-State: AOJu0YxHMaXz+Hjws8seyhJQ97zSsHb/5Yv2HdfDN8WC1VioKoEN19fk
	fkaV55pKyrZEx0GaO+9A83QmeEutoN9pjXzQugydH4XESlPJdxKGH70Lcv9A
X-Google-Smtp-Source: AGHT+IHXiY89VZmTgYwoXVaHckaWr915UoxnzlpyPlByGApoQNiaaVn2ZWCKiho9SegGbnn7h6EVPg==
X-Received: by 2002:a05:6512:3449:b0:512:d4ac:f44e with SMTP id j9-20020a056512344900b00512d4acf44emr5227598lfr.64.1709042784979;
        Tue, 27 Feb 2024 06:06:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w27-20020adf8bdb000000b0033deaf53858sm2445437wra.61.2024.02.27.06.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:06:24 -0800 (PST)
Message-ID: <pull.1678.git.1709042783847.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 14:06:23 +0000
Subject: [PATCH] rebase -i: stop setting GIT_CHERRY_PICK_HELP
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Setting this environment variable causes the sequencer to display a
custom message when it stops for the user to resolve conflicts and
remove CHERRY_PICK_HEAD. Setting it in "git rebase" is a vestige of
the scripted implementation, now that it is a builtin command we do
not need to communicate with the sequencer machinery via environment
variables.

Move the conflicts advice to use when rebasing into
sequencer.c so we do not need to pass it via the environment.

Note that we retain the changes in e4301f73fff (sequencer: unset
GIT_CHERRY_PICK_HELP for 'exec' commands, 2024-02-02) just in case
GIT_CHERRY_PICK_HELP is set in the environment when "git rebase" is
run.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase -i: stop setting GIT_CHERRY_PICK_HELP

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1678%2Fphillipwood%2Frebase-stop-setting-GIT_CHERRY_PICK_HELP-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1678/phillipwood/rebase-stop-setting-GIT_CHERRY_PICK_HELP-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1678

 builtin/rebase.c | 14 +++-----------
 sequencer.c      | 14 +++++++++++++-
 sequencer.h      |  2 ++
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b086f651a6..d0cc518c931 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -567,13 +567,6 @@ static int move_to_original_branch(struct rebase_options *opts)
 	return ret;
 }
 
-static const char *resolvemsg =
-N_("Resolve all conflicts manually, mark them as resolved with\n"
-"\"git add/rm <conflicted_files>\", then run \"git rebase --continue\".\n"
-"You can instead skip this commit: run \"git rebase --skip\".\n"
-"To abort and get back to the state before \"git rebase\", run "
-"\"git rebase --abort\".");
-
 static int run_am(struct rebase_options *opts)
 {
 	struct child_process am = CHILD_PROCESS_INIT;
@@ -587,7 +580,7 @@ static int run_am(struct rebase_options *opts)
 		     opts->reflog_action);
 	if (opts->action == ACTION_CONTINUE) {
 		strvec_push(&am.args, "--resolved");
-		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+		strvec_pushf(&am.args, "--resolvemsg=%s", rebase_resolvemsg);
 		if (opts->gpg_sign_opt)
 			strvec_push(&am.args, opts->gpg_sign_opt);
 		status = run_command(&am);
@@ -598,7 +591,7 @@ static int run_am(struct rebase_options *opts)
 	}
 	if (opts->action == ACTION_SKIP) {
 		strvec_push(&am.args, "--skip");
-		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+		strvec_pushf(&am.args, "--resolvemsg=%s", rebase_resolvemsg);
 		status = run_command(&am);
 		if (status)
 			return status;
@@ -672,7 +665,7 @@ static int run_am(struct rebase_options *opts)
 
 	strvec_pushv(&am.args, opts->git_am_opts.v);
 	strvec_push(&am.args, "--rebasing");
-	strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
+	strvec_pushf(&am.args, "--resolvemsg=%s", rebase_resolvemsg);
 	strvec_push(&am.args, "--patch-format=mboxrd");
 	if (opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE)
 		strvec_push(&am.args, "--rerere-autoupdate");
@@ -700,7 +693,6 @@ static int run_specific_rebase(struct rebase_options *opts)
 
 	if (opts->type == REBASE_MERGE) {
 		/* Run sequencer-based rebase */
-		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
 		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT))
 			setenv("GIT_SEQUENCE_EDITOR", ":", 1);
 		if (opts->gpg_sign_opt) {
diff --git a/sequencer.c b/sequencer.c
index f49a871ac06..76027ad5f5c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -461,10 +461,22 @@ static void free_message(struct commit *commit, struct commit_message *msg)
 	repo_unuse_commit_buffer(the_repository, commit, msg->message);
 }
 
+const char *rebase_resolvemsg =
+N_("Resolve all conflicts manually, mark them as resolved with\n"
+"\"git add/rm <conflicted_files>\", then run \"git rebase --continue\".\n"
+"You can instead skip this commit: run \"git rebase --skip\".\n"
+"To abort and get back to the state before \"git rebase\", run "
+"\"git rebase --abort\".");
+
 static void print_advice(struct repository *r, int show_hint,
 			 struct replay_opts *opts)
 {
-	char *msg = getenv("GIT_CHERRY_PICK_HELP");
+	const char *msg;
+
+	if (is_rebase_i(opts))
+		msg = rebase_resolvemsg;
+	else
+		msg = getenv("GIT_CHERRY_PICK_HELP");
 
 	if (msg) {
 		advise("%s\n", msg);
diff --git a/sequencer.h b/sequencer.h
index dcef7bb99c0..437eabd38af 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -14,6 +14,8 @@ const char *rebase_path_todo(void);
 const char *rebase_path_todo_backup(void);
 const char *rebase_path_dropped(void);
 
+extern const char *rebase_resolvemsg;
+
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
 enum replay_action {

base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
-- 
gitgitgadget
