Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C611F462
	for <e@80x24.org>; Sun, 16 Jun 2019 08:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfFPIXu (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 04:23:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33589 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfFPIXu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 04:23:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so2831561plo.0
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 01:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9YtesxB9C+QY9/Ffpf6BFsi5V3DahDDmTM7TVcLlWM=;
        b=etneDILG+hDDIuIIgOi8uH0H5SUHvwq+JRnMmndbZPY15t8OwVWaiDiaEVvzaENuvt
         EXtNxMhFmW/4Trj4ua8tn3rI8DKoyQZri+ZMXHDNWejH7gC02gkFjwxp6BdckgfUCs3c
         Bz7+fQcdSB9Gg2XGJWLtRxggB6RiqNbkKgC75cdAPwNSIoY78EiHYwJQ8+i0tIPd+XTc
         i2sfXAwN/0hvrlDu9QuSTXMIZyF+0FTivUeZOmFzhygT7Cxxdq7YpZGsIy76P7Elcrxw
         TBjhe1blX2ip/kIy4xjZo5bRZvACvklOcumTTFCDDsMMqhusp4nOm4WAh/aUDghJnkVF
         qjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9YtesxB9C+QY9/Ffpf6BFsi5V3DahDDmTM7TVcLlWM=;
        b=MUPf73TOihgI9WlozjVwtim9sUCRlJZcyJ0dJ8J6PwZTjUZRXN8hSvUXMx85hi1VUm
         YSAw8AzFcDHdlEBz0bVo/sI4/OsXhX2x2FWgjwmFbL+JRMWfk3e2mHQeuYiCjYpYFAzN
         9NAuxO6DktnjTPMZbSGyPmqMcmpERY0eCPO1ZZqBbUPIqfDwrAWWDdc6rgmfjjgPNshf
         UTxog4GyUBmhICdbyvKboAphyU7cKxtfCePZEF8fxPckxjcDa/xT0OFqy/GWaEDqQtzG
         rM14GycxPGQ91iiqF+bg2/b615E8cmf24ybbmRAlJPdWtXb8j2nXxmN+A93QHc635Vqv
         7X3A==
X-Gm-Message-State: APjAAAVQXWmYUnyyKeDfBpPjZ7a6udIPLvC05yqulqhrjaqOEe8PC9OY
        rbkCcXKY1heik1RsnrpQYaA=
X-Google-Smtp-Source: APXvYqzrFeSTD3Ygo3HHgY+A94bWgMEFbXMJmIc+7GoYzhl9ksxt5co78yU7S2sp9HG0TvXkI6wCwg==
X-Received: by 2002:a17:902:e490:: with SMTP id cj16mr100200606plb.136.1560673429285;
        Sun, 16 Jun 2019 01:23:49 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3105:6dd7:b496:8be7:332f:b415])
        by smtp.gmail.com with ESMTPSA id x128sm1471972pfd.17.2019.06.16.01.23.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:23:48 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v4 4/4] cherry-pick/revert: advise using --skip
Date:   Sun, 16 Jun 2019 13:50:40 +0530
Message-Id: <20190616082040.9440-5-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit introduced a --skip flag for cherry-pick and
revert. Update the advice messages, to tell users about this less
cumbersome way of skipping commits. Also add tests to ensure
everything is working fine.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
changes:
    - Use test_i18ncmp instead of tmp_cmp

 builtin/commit.c                | 13 ++++++++-----
 sequencer.c                     | 11 ++++++++---
 t/t3510-cherry-pick-sequence.sh | 20 ++++++++++++++++++++
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1c9e8e2228..1f47c51bdc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -60,15 +60,18 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
 "\n");
 
 static const char empty_cherry_pick_advice_single[] =
-N_("Otherwise, please use 'git reset'\n");
+N_("Otherwise, please use 'git cherry-pick --skip'\n");
 
 static const char empty_cherry_pick_advice_multi[] =
-N_("If you wish to skip this commit, use:\n"
+N_("and then use:\n"
 "\n"
-"    git reset\n"
+"    git cherry-pick --continue\n"
 "\n"
-"Then \"git cherry-pick --continue\" will resume cherry-picking\n"
-"the remaining commits.\n");
+"to resume cherry-picking the remaining commits.\n"
+"If you wish to skip this commit, use:\n"
+"\n"
+"    git cherry-pick --skip\n"
+"\n");
 
 static const char *color_status_slots[] = {
 	[WT_STATUS_HEADER]	  = "header",
diff --git a/sequencer.c b/sequencer.c
index 95fa19a118..6e8afe8f22 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2655,18 +2655,20 @@ static int create_seq_dir(struct repository *r)
 	enum replay_action action;
 	const char *in_progress_error = NULL;
 	const char *in_progress_advice = NULL;
+	unsigned int advise_skip = file_exists(git_path_revert_head(r)) ||
+				file_exists(git_path_cherry_pick_head(r));
 
 	if (!sequencer_get_last_command(r, &action)) {
 		switch (action) {
 		case REPLAY_REVERT:
 			in_progress_error = _("revert is already in progress");
 			in_progress_advice =
-			_("try \"git revert (--continue | --abort | --quit)\"");
+			_("try \"git revert (--continue | %s--abort | --quit)\"");
 			break;
 		case REPLAY_PICK:
 			in_progress_error = _("cherry-pick is already in progress");
 			in_progress_advice =
-			_("try \"git cherry-pick (--continue | --abort | --quit)\"");
+			_("try \"git cherry-pick (--continue | %s--abort | --quit)\"");
 			break;
 		default:
 			BUG(_("unexpected action in create_seq_dir"));
@@ -2674,7 +2676,10 @@ static int create_seq_dir(struct repository *r)
 	}
 	if (in_progress_error) {
 		error("%s", in_progress_error);
-		advise("%s", in_progress_advice);
+		if (advise_skip)
+			advise(in_progress_advice, "--skip | ");
+		else
+			advise(in_progress_advice, "");
 		return -1;
 	}
 	if (mkdir(git_path_seq_dir(), 0777) < 0)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index dc0ac8343c..0e8adc95fc 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -172,6 +172,26 @@ test_expect_success 'check advice when we move HEAD by committing' '
 	test_i18ncmp expect advice
 '
 
+test_expect_success 'selectively advise --skip while launching another sequence' '
+	pristine_detach initial &&
+	cat >expect <<-EOF &&
+	error: cherry-pick is already in progress
+	hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
+	fatal: cherry-pick failed
+	EOF
+	test_must_fail git cherry-pick picked..yetanotherpick &&
+	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
+	test_i18ncmp expect advice &&
+	cat >expect <<-EOF &&
+	error: cherry-pick is already in progress
+	hint: try "git cherry-pick (--continue | --abort | --quit)"
+	fatal: cherry-pick failed
+	EOF
+	git reset --merge &&
+	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
+	test_i18ncmp expect advice
+'
+
 test_expect_success 'allow skipping commit but not abort for a new history' '
 	pristine_detach initial &&
 	cat >expect <<-EOF &&
-- 
2.21.0

