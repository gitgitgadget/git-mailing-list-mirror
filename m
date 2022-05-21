Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BABDC433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 17:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbiEURPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 13:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiEURPO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 13:15:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A01666A9
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:15:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k26so6049879wms.1
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70xy1n2gDIvv+iETV/rv+1NlvCJQ2K0m5huNto1lIYw=;
        b=IGo0/WArEIciKnTvs64+ez+mRNsGgaT8o59mNLg6pZeOw/0jOdeIHfO+NTjZJgKUoi
         cn7uF1VG/tToARXH4LYf5Dh+okey5zR92LutD2Cw7pYS1qOT6RxeymswInUSDAXojZzp
         GOoU9nehKgn94+1TMAbLPVZd/Ti4pc1oR0qV5l31PE/2FG8aibnqxwHqXdLAOTr35AKn
         7oON0MnpBk9KGf/dfiRt9Kl0S8SIxBAgqLgilB47B7gTx/1MZohlXiE+WzzvPhFV+Y0U
         cAj0QHWngYCEsjorQTSrQ1UgSpPIjzbO3WwABTiEXpxSBPPRTATQ0R+HBNlv6aOPpFIb
         30VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70xy1n2gDIvv+iETV/rv+1NlvCJQ2K0m5huNto1lIYw=;
        b=Q85mmSwE65fL8oX50oXStqRnXqwkAYi6nePDueYcEq8gCtCp/4wnw5FTceIKXgi83U
         M3qqKfiZMeTuBIkpcszwJkFc8PhGD/CbEqfCjukr3bW6MiGcu77xc+ksm3blMYeCiogK
         C7TM+plhZboo7wkVY+ZdlegAf4nqUPlbCxkX4kLJubANTR7TTZ4euZPMBkAMHLSq2z4D
         tdDRSXqAuO1j6nGq/MjTWF/zU7VZOSk/QgWTT7T6ATnsnXrgcWBSEd9WYbqv5iX+i39Q
         5LU8m/k7+kuLofwvtS+sINeIUvfytAiZ8dBQ5yvIWuzzajfun4tBrsTzaDBnj8nxEBPp
         r47A==
X-Gm-Message-State: AOAM532cQFqp/wOJvIr2agHDSJtXuyH9dbe+LukNYQhwaovmFExVD5kw
        jY2QmLDQShggx48NJ0s3D3r4V/zaXGbmBg==
X-Google-Smtp-Source: ABdhPJzebQIFqGWpm+t+Jx+NxEohJqWAUTqNBNXnp21/j2WneI94+nCBhB8he2GT4rKdR17vSvadjw==
X-Received: by 2002:a05:600c:2d86:b0:397:4743:5d25 with SMTP id i6-20020a05600c2d8600b0039747435d25mr349756wmg.11.1653153312121;
        Sat, 21 May 2022 10:15:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b0039736892653sm4964685wmj.27.2022.05.21.10.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 10:15:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] receive-pack: use bug() and BUG_if_bug()
Date:   Sat, 21 May 2022 19:14:41 +0200
Message-Id: <patch-4.5-c590f4273c0-20220521T170939Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.960.g7a4e2fc85c9
In-Reply-To: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend code added in a6a84319686 (receive-pack.c: shorten the
execute_commands loop over all commands, 2015-01-07) and amended to
hard die in b6a4788586d (receive-pack.c: die instead of error in case
of possible future bug, 2015-01-07) to the new bug() function instead.

Let's also rename the warn_if_*() function that code is in to
BUG_if_*(), its name became outdated in b6a4788586d.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ad20b41e3c8..d1b3e5c419e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1810,21 +1810,17 @@ static int should_process_cmd(struct command *cmd)
 	return !cmd->error_string && !cmd->skip_update;
 }
 
-static void warn_if_skipped_connectivity_check(struct command *commands,
+static void BUG_if_skipped_connectivity_check(struct command *commands,
 					       struct shallow_info *si)
 {
 	struct command *cmd;
-	int checked_connectivity = 1;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {
-			error("BUG: connectivity check has not been run on ref %s",
-			      cmd->ref_name);
-			checked_connectivity = 0;
-		}
+		if (!should_process_cmd(cmd) && si->shallow_ref[cmd->index])
+			bug("connectivity check has not been run on ref %s",
+			    cmd->ref_name);
 	}
-	if (!checked_connectivity)
-		BUG("connectivity check skipped???");
+	BUG_if_bug();
 }
 
 static void execute_commands_non_atomic(struct command *commands,
@@ -2005,7 +2001,7 @@ static void execute_commands(struct command *commands,
 		execute_commands_non_atomic(commands, si);
 
 	if (shallow_update)
-		warn_if_skipped_connectivity_check(commands, si);
+		BUG_if_skipped_connectivity_check(commands, si);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.36.1.960.g7a4e2fc85c9

