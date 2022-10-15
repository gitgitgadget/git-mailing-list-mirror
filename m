Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F181C433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 13:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJONER (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 09:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJONEP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 09:04:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE1C5302C
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 06:04:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bp11so11424335wrb.9
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3QOQ9Wd2NaZ1pTWKh7wTNYwWNXdAeniZ1nrYsNp4o2Q=;
        b=HFiwAAW1PJ5PSGFfHwHbso4j2bdcuYEPefBe11Q7AODMxsxgoLy8LauLYPBE5SEQ17
         r6JfJMhgRrT1qoW1r+GXeuV1IubKhN42WZJ/NzfwXo1bO1GmosqdfESJxuyPNoGa2Cks
         aMoSNvBnUB6QNDoGkyuT8AW+mfvh6vQV0ChznDazvDh1zHVGWvp2suTIJIA3SD/5qt1z
         Bsustxlvi13MXH+68w30w0w8c/MLvSQShGyeZruYnWNdut/gRpJHCQjA6il6lHTg2grl
         v4bVBaqQR0RwPCzFAGUvXDLYEygjM54qHzOd9auDFf4alLuxrtVzWEeF3RAezjqP9YoX
         LPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QOQ9Wd2NaZ1pTWKh7wTNYwWNXdAeniZ1nrYsNp4o2Q=;
        b=umIlXyGnY/bOEVvaD4Bj+EWRDFd1bYi9ADY58Xf2Do5qcJh/35quF0QFbw9m/m97Th
         SDwYnBYtNcF14vANX8aoazasY8Q+JiThAh7Yr7XNxASt5Tgf+9vXXf/tKLAOJhapPWgH
         kapp/Wa3QTqQmj9Rc1aiX+3t1FZdKwb2NanT6Xu8Vq9E1w7G4MpdAafc5ISOy3xQnFEY
         INxJMyFn8NThH1VFMAMfxV4wtFILZai9xkKSf9fNZl8IChtFCZjwp06w1SOAEdHdrwMy
         G1kbAb2Ysug0AwAsmBPI35yh0Uyx330km3WnVEj1b946VUZZwROuY9Pj/cRtZfrgdSad
         mFzg==
X-Gm-Message-State: ACrzQf1foh4X1FQ6gByBDyWpV60wKazdVDev+yCSRyPcn3pcvHFMEyHF
        JdNSLbRByS2/mwWytHwm3hl0PDEfcKA=
X-Google-Smtp-Source: AMsMyM6dN7rk1siEYFZwlv2Rhj5+4qguEbqT03KgZLQtDSD2SGqafMXe9k8ku16+r53JqiX1iiIxJQ==
X-Received: by 2002:a5d:47a9:0:b0:22e:3beb:dc3a with SMTP id 9-20020a5d47a9000000b0022e3bebdc3amr1499659wrb.654.1665839052392;
        Sat, 15 Oct 2022 06:04:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003a531c7aa66sm5146991wmb.1.2022.10.15.06.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 06:04:11 -0700 (PDT)
Message-Id: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
From:   "Rudy Rigot via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Oct 2022 13:04:10 +0000
Subject: [PATCH] fsmonitor: long status advice adapted to the fsmonitor use
 case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rudy Rigot <rudy.rigot@gmail.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rudy Rigot <rudy.rigot@gmail.com>

Currently, if git-status takes more than 2 seconds for enumerating
untracked files, a piece of advice is given to the user to consider
ignoring untracked files. This is somewhat at odds with the UX
upsides from having fsmonitor enabled, since fsmonitor will be
here to take care of mitigating the performance downsides from
those untracked files.

I considered just suppressing that piece of advice entirely for
repositories with fsmonitor disabled, but I decided to replace
it with another piece of advice instead, letting the user know
that this run may have been slow, but the next ones should be faster.
Of course, please let me know if the phrasing can be improved. To
keep consistent with other pieces of advice, this new one can be
hidden with a new advice.statusFsmonitor config.

If the repository does not have fsmonitor enabled, or if the new
piece of advice is hidden by config, the behavior falls back to
today's behavior: show the message advising to ignore untracked
files, as long as it wasn't disabled with the existing advice.statusUoption
config.

Test-wise, I tried to figure out ways to mock the behavior of a
slow git-status, but I couldn't figure it out, so I could use some
advice. I tracked down Commit 6a38ef2ced (status: advise to consider
use of -u when read_directory takes too long, 2013-03-13), and it
also didn't have tests, so I'm questioning whether it can in fact
be reasonably done. Thanks in advance for any guidance.

Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
---
    fsmonitor: long status advice adapted to the fsmonitor use case
    
    Currently, if git-status takes more than 2 seconds for enumerating
    untracked files, a piece of advice is given to the user to consider
    ignoring untracked files. This is somewhat at odds with the UX upsides
    from having fsmonitor enabled, since fsmonitor will be here to take care
    of mitigating the performance downsides from those untracked files.
    
    I considered just suppressing that piece of advice entirely for
    repositories with fsmonitor disabled, but I decided to replace it with
    another piece of advice instead, letting the user know that this run may
    have been slow, but the next ones should be faster. Of course, please
    let me know if the phrasing can be improved. To keep consistent with
    other pieces of advice, this new one can be hidden with a new
    advice.statusFsmonitor config.
    
    If the repository does not have fsmonitor enabled, or if the new piece
    of advice is hidden by config, the behavior falls back to today's
    behavior: show the message advising to ignore untracked files, as long
    as it wasn't disabled with the existing advice.statusUoption config.
    
    Test-wise, I tried to figure out ways to mock the behavior of a slow
    git-status, but I couldn't figure it out, so I could use some advice. I
    tracked down Commit 6a38ef2 (status: advise to consider use of -u when
    read_directory takes too long, 2013-03-13), and it also didn't have
    tests, so I'm questioning whether it can in fact be reasonably done.
    Thanks in advance for any guidance.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1384%2Frudyrigot%2Fadvice_statusFsmonitor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1384/rudyrigot/advice_statusFsmonitor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1384

 Documentation/config/advice.txt |  3 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 wt-status.c                     | 23 ++++++++++++++++-------
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index a00d0100a82..e8ebcf1b023 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -57,6 +57,9 @@ advice.*::
 		and that calculation takes longer than expected. Will not
 		appear if `status.aheadBehind` is false or the option
 		`--no-ahead-behind` is given.
+	statusFsmonitor::
+		Shown when the linkgit:git-status[1] command takes more than
+		2 seconds to enumerate untracked files, and fsmonitor is enabled.
 	statusHints::
 		Show directions on how to proceed from the current
 		state in the output of linkgit:git-status[1], in
diff --git a/advice.c b/advice.c
index fd189689437..448b11ef273 100644
--- a/advice.c
+++ b/advice.c
@@ -69,6 +69,7 @@ static struct {
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure", 1 },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1 },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning", 1 },
+	[ADVICE_STATUS_FSMONITOR]			= { "statusFsmonitor", 1 },
 	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
diff --git a/advice.h b/advice.h
index 07e0f76833e..a458619a160 100644
--- a/advice.h
+++ b/advice.h
@@ -43,6 +43,7 @@ struct string_list;
 	ADVICE_SEQUENCER_IN_USE,
 	ADVICE_SET_UPSTREAM_FAILURE,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
+	ADVICE_STATUS_FSMONITOR,
 	ADVICE_STATUS_HINTS,
 	ADVICE_STATUS_U_OPTION,
 	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
diff --git a/wt-status.c b/wt-status.c
index 5813174896c..d6c7f0fa21a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -18,6 +18,7 @@
 #include "worktree.h"
 #include "lockfile.h"
 #include "sequencer.h"
+#include "fsmonitor-settings.h"
 
 #define AB_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -1814,6 +1815,7 @@ static void wt_longstatus_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(s->repo);
 
 	if (s->branch) {
 		const char *on_what = _("On branch ");
@@ -1870,13 +1872,20 @@ static void wt_longstatus_print(struct wt_status *s)
 		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
 		if (s->show_ignored_mode)
 			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
-		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
-			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
-					   "may speed it up, but you have to be careful not to forget to add\n"
-					   "new files yourself (see 'git help status')."),
-					 s->untracked_in_ms / 1000.0);
+		if (2000 < s->untracked_in_ms) {
+			if (advice_enabled(ADVICE_STATUS_FSMONITOR) && fsm_mode > FSMONITOR_MODE_DISABLED) {
+				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+				status_printf_ln(s, GIT_COLOR_NORMAL,
+						_("It took a while to check your git status this time, but the results\n"
+						"were cached, and your next runs should be faster."));
+			} else if (advice_enabled(ADVICE_STATUS_U_OPTION)) {
+				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+				status_printf_ln(s, GIT_COLOR_NORMAL,
+						_("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
+						"may speed it up, but you have to be careful not to forget to add\n"
+						"new files yourself (see 'git help status')."),
+						s->untracked_in_ms / 1000.0);
+			}
 		}
 	} else if (s->committable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),

base-commit: d420dda0576340909c3faff364cfbd1485f70376
-- 
gitgitgadget
