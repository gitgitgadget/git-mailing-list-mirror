Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761585013C4
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863294; cv=none; b=kB6dnwNSFzWknXMxo76tMaGCdxjoqIxWzAzI0T6DmzRtEcD7acl+xmStt8Fm9tHUOergzhef1hGrL+snrN5h52w1RK1Crlwwt6wcaS2h718/dIoo22RVTw6Mt6sITQ3IankWAsBpkfqmt2h1oM3co2487hJiXqokLNE5+IEqJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863294; c=relaxed/simple;
	bh=C58yXp99dbZlCQnOcVlm4KjmAZtkFcdElWlyi6s21zg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mEbm5jIB7ZGDzxQbIw8yTVGyYoG1/mPZlCNJSpoA1V7n1IOqxKVibBduZedBL4RqbEObPWP1KZ/xk7EsXptU52v39fXhpsmCQxShpxsO+ad2qHi82ZyVoJIDpm+IAA89aaECM+M6xFR07CTgdqyP1mRjzP/erU+38t1jmQNqGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa2+3f7r; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa2+3f7r"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso5097282a12.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 03:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788863292; x=1789468092; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kh1yUIJMBvaWHzPKFI/EzySDVrxu2Xp2C9Az6jqUM54=;
        b=Sa2+3f7r7Tn5KLcFMI+ge8UCKy8D7Qk6kECU6/oFXEtpfiP/C0I0Ukgju4sZ7Sai3+
         M7l2UYNXvMyw+aC24Us9WbmA4oesmEp5ONe2Q97xgKa00H5+iL7NuOxM1nZdpTw9h74N
         QtzJ4CAEiCnM/xMBRCp7lVm0csBZPG+FC7xoCqckI4XIJhf0uanjjmAh3pcCK+riBeiz
         J1IJhG8a4FRpcANUtdTHlUP5SwXg5TsjOlHiLECmX9D10iRqaC/1ganRrdMGV6QRAMMZ
         6woDmycMUxhEHtCQ9UL5rH8U4idyNPoWJPKPnfhFA8w0etlM0lUfpfM0MnrRQs4X9PJs
         AOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863292; x=1789468092;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kh1yUIJMBvaWHzPKFI/EzySDVrxu2Xp2C9Az6jqUM54=;
        b=QC4CMrRpQ4kZCfUtQuUHpSr/mFF0+3EYyl4mZOMQJcZGle8JYV9uNio73T5n9vbbOD
         M+w6iekhoNmetrHSPKeqj3QAZCHYlPSjM06ebSF65742zm/uIPPfbC43JpaFy8QROVRV
         m8Uh1GJs/GwV1YDJIGR1K7uMETf6w4FOKPAkNeqoBR6mDeYrpdDWUe0Wa6PmGUli9jYA
         58n7o52jDtd0uE+zc0U0s5D9+ZFagn+KTMjdRasw7z3fPwnAAdtaRg/OXjd5c5ghf3JJ
         3n4/qsN9+fCK8JOjha+XPiOCC+cBE7/O6NxdxmftEjTqeeBMkDX0hRyjd31WiECQIzr7
         VocQ==
X-Gm-Message-State: AFuF++npVZUc4L/i5c8nwJPgUUvsc6/1TNIbEnCVx/FsC+Y90Qh0nPJs
	b0keTcn4PLZ0oMGRgDh46H8Tc9poGSaKyNJcXDBuWvI9QwZZEcvqCtQGQU5mGQ==
X-Gm-Gg: AYBFou2Z4hfmG2XQY9/JpJPUVxIvvq7k1cgrMHJozLBKJlfTt13/moiNAQciMf6TWVJ
	qCrKrCyC1D3zG/0URAuBiI2WY86MWBsW/vLhTPcxcAym3oQpNGH2dyNYfqpAAVeRdPJIBNjT+pO
	q9EueT2vNCQjHsd2+vTlOE3ngIxXlUxxjJFkkctV97IECxsf2q7YmM7TKJBt7fDQxFtV+OYDjiA
	42AVudCAc1sp9o80ntzovORpCrUP6bBglMVW6EuNmPsIBdRuVdzGz2hs6krh7VT0tVE0fEuUEat
	L7nHIrUqg/pQ5M1f5cM/zu19SB0rsPnVf1Gl4UDm7siuHu3z51zOnIzmZJU3L4WWi4tautq2YnU
	Aua9hP406gE/J9Ts0wOXumpo2qbUkurSL4yzH+0JjclIu1xx9xsUOwwFWUqf09g00WgtWuqJTr7
	LBJ1PXU1Ddtn+DMhDB1kWN+YfsQjeEIGEfnAi0JAIF3KDJubkNgEyGYy/H/0iKwQ==
X-Received: by 2002:a17:90a:1c96:b0:39b:66ee:a14 with SMTP id 98e67ed59e1d1-39b66ee3442mr11889248a91.25.1788863291708;
        Tue, 08 Sep 2026 03:28:11 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm28748005c88.8.2026.09.08.03.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:28:11 -0700 (PDT)
Message-Id: <68a728c5f43fdd7772a397954cd9f1a602614856.1788863286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v3.git.1788863286.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v3.git.1788863286.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 10:28:05 +0000
Subject: [PATCH v3 2/3] rebase, cherry-pick, revert: run auto maintenance when
 done
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

"git commit", "git merge", "git fetch" and "git am" run "git
maintenance run --auto" when they are done, and so does the apply
backend of "git rebase". That repacks the loose objects they wrote
once there are enough of them, expires old rerere entries and does
whatever other housekeeping is due.

The merge backend of "git rebase", "git cherry-pick" and "git revert"
do not. They create their commits in process, so auto maintenance
runs only when they spawn a command that runs it on its own. That is
the "git commit" for a resolved conflict or an edited message, the
"git merge" that "--rebase-merges" spawns for an octopus merge, a
strategy other than ort or any strategy option, and whatever an exec
runs. A sequence that needs none of these never runs auto
maintenance. One that stops for conflicts runs it after each
resolution, in the middle of the sequence.

Run it once when the sequence is done, like the apply backend does.

The apply backend leaves that to builtin/rebase.c: "git am" skips
auto maintenance in rebasing mode, and finish_rebase() runs it once
the patches are applied. Do the same for the sequencer, from
builtin/rebase.c and builtin/revert.c, because the sequencer itself
has no single place where every sequence ends. A sequence of several
commits ends inside pick_commits(). A single cherry-pick or revert
never creates the sequencer's state directory and returns to its
caller as soon as its commit is made. "--continue" and "--skip" have
entry points of their own. Nothing but those two builtins starts or
continues a sequence, so that is where we run auto maintenance.
run_specific_rebase() runs it for the merge backend once the
sequencer has returned successfully and removed its state directory,
which it keeps while the rebase is stopped. run_sequencer() runs it
for cherry-pick and revert when a pick, a "--continue" or a "--skip"
returns successfully.

For the user, a sequence that never stops now runs auto maintenance
once when it is done, where it never ran it before. That is the same
"git maintenance run --auto --detach" as after "git commit": it
detaches into the background by default and does nothing unless one
of its tasks is due. The runs from the commands a sequence spawns
stay for now. The next commit removes them, so that a sequence runs
auto maintenance exactly once.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/rebase.c                | 13 ++++++++++---
 builtin/revert.c                | 19 ++++++++++++-------
 t/t3418-rebase-continue.sh      | 12 ++++++++++++
 t/t3510-cherry-pick-sequence.sh | 23 +++++++++++++++++++++++
 4 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 10a306310c..535db60181 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -762,9 +762,16 @@ static int run_specific_rebase(struct rebase_options *opts)
 
 	if (opts->dont_finish_rebase)
 		; /* do nothing */
-	else if (opts->type == REBASE_MERGE)
-		; /* merge backend cleans up after itself */
-	else if (status == 0) {
+	else if (opts->type == REBASE_MERGE) {
+		int quiet = !(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE));
+
+		/*
+		 * The sequencer cleans up after itself. Its state directory
+		 * is gone once it is done, and stays while it is stopped.
+		 */
+		if (status == 0 && !is_directory(opts->state_dir))
+			run_auto_maintenance(the_repository, quiet);
+	} else if (status == 0) {
 		if (!file_exists(state_dir_path("stopped-sha", opts)))
 			finish_rebase(opts);
 	} else if (status == 2) {
diff --git a/builtin/revert.c b/builtin/revert.c
index bedc40f368..52100a20cb 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -8,6 +8,7 @@
 #include "gettext.h"
 #include "revision.h"
 #include "rerere.h"
+#include "run-command.h"
 #include "sequencer.h"
 #include "branch.h"
 
@@ -116,7 +117,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	const char *strategy = &sentinel_value;
 	const char *gpg_sign = &sentinel_value;
 	enum empty_action empty_opt = EMPTY_COMMIT_UNSPECIFIED;
-	int cmd = 0;
+	int cmd = 0, ret;
 	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
@@ -264,18 +265,22 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	free(options);
 
 	if (cmd == 'q') {
-		int ret = sequencer_remove_state(opts);
+		ret = sequencer_remove_state(opts);
 		if (!ret)
 			remove_branch_state(the_repository, 0);
 		return ret;
 	}
-	if (cmd == 'c')
-		return sequencer_continue(the_repository, opts);
 	if (cmd == 'a')
 		return sequencer_rollback(the_repository, opts);
-	if (cmd == 's')
-		return sequencer_skip(the_repository, opts);
-	return sequencer_pick_revisions(the_repository, opts);
+	if (cmd == 'c')
+		ret = sequencer_continue(the_repository, opts);
+	else if (cmd == 's')
+		ret = sequencer_skip(the_repository, opts);
+	else
+		ret = sequencer_pick_revisions(the_repository, opts);
+	if (!ret)
+		run_auto_maintenance(the_repository, opts->quiet);
+	return ret;
 }
 
 int cmd_revert(int argc,
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index cb5c3a1cb5..025787b5f2 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -395,4 +395,16 @@ test_orig_head () {
 test_orig_head --apply
 test_orig_head --merge
 
+test_expect_success 'rebase runs auto maintenance once it is done' '
+	git checkout -b auto-maintenance topic &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
+		git rebase -x false main &&
+	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
+	echo resolved >F2 &&
+	git add F2 &&
+	test_must_fail git rebase --continue &&
+	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
+	test_subcommand_flex git maintenance run --auto <end.txt
+'
+
 test_done
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 5777dff496..2bea55c3b6 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -721,4 +721,27 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 	test_line_count = 4 commits
 '
 
+test_expect_success 'cherry-pick runs auto maintenance once it is done' '
+	pristine_detach base &&
+	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick picked &&
+	test_subcommand_flex git maintenance run --auto <single.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/sequence.txt" \
+		git cherry-pick anotherpick yetanotherpick &&
+	test_subcommand_flex git maintenance run --auto <sequence.txt &&
+	grep "\"child_start\".*\"maintenance\"" sequence.txt >maintenance &&
+	test_line_count = 1 maintenance
+'
+
+test_expect_success 'cherry-pick runs auto maintenance once a stopped sequence is done' '
+	pristine_detach initial &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
+		git cherry-pick base..anotherpick &&
+	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
+	echo resolved >foo &&
+	git add foo &&
+	test_must_fail git cherry-pick --continue &&
+	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --skip &&
+	test_subcommand_flex git maintenance run --auto <end.txt
+'
+
 test_done
-- 
gitgitgadget

