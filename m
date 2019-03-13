Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDFE120248
	for <e@80x24.org>; Wed, 13 Mar 2019 18:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfCMS0j (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 14:26:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41815 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMS0h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 14:26:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so3098665wrs.8
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=2i2YbpiZkC4YQl2ZkXB7HkCKa246LtYK3tFaRmnA7Gw=;
        b=CqJ2b8Sl/lM3rdAo6kElAyICMMZYNcMvlAq0vsgXqI1LqVnbqxHHv9S69qOqR8/BXF
         O+3A5iVVi341J/5s3FzBMvcFnA56FVoBXABlGzuIojctMI7gX/qJjS+I0uQTSMvwCvW3
         fTy49J4Y+FW6aPSkgQ6iY7jy0Oai7ssJ/c2lLKpx6RzH2Kqcj/ySExKKhAPI77jl43hl
         8yBXHZIhohO0jvIeXKSjbYiLAqcOQLCaWO/7upVJ6r2e+HLuS7SFW6vuYK3noMn0UryE
         9YwOR7mfaTg1WRrARJdnDnaz2IZrR3V/a3uBukkChQPOC/9oAg32ZJu/KaupC6ZS9i4d
         PNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=2i2YbpiZkC4YQl2ZkXB7HkCKa246LtYK3tFaRmnA7Gw=;
        b=VKLYrgkSQas2Py8RaFCotGfvtSH0g/42BymoV9drKPYYQXvWb5dZkZdYpqztarD1sB
         mEib17JIlDiyUT6mkxP7vubdNPKZjxjYCSar6sSM5Kk6LHa7RIvmxkZ0JVagJPl/s0k8
         8lh1RSNplolUjjDLfsiFKykRsVA8tGdHrgc6hTS87ln7LZ9DaA9hXEryhPMX+NYoF1Js
         efbOjaKcvgeVH1wOcDoORpwDiKyDasKhyklV+PWKkdpDHwaJwXyy2i3qMUyL0/YcqF6K
         Pw57lOnY0F/U0VUyVI8vvvoOiRxU0mz6YIOLwAngHZ9onCVvk4XEjywyDV04svUK6z2+
         7eww==
X-Gm-Message-State: APjAAAUvqzhEZue/uNU9DXrFJv1qB+EJ5W+FBt0iNDNtt98lDdS8FW2I
        kfeyXdnVafbcrxgmm7JRr6dkvFJkQos4hg==
X-Google-Smtp-Source: APXvYqwGUc/20vUWD2CAQ4raH/FQ+8yQU1tKDcTWZPGs2JGykTkRiR2xdv2mLpvsqZiQwD8qfrKFHg==
X-Received: by 2002:adf:f54b:: with SMTP id j11mr4950189wrp.39.1552501595213;
        Wed, 13 Mar 2019 11:26:35 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id i62sm2753807wmg.17.2019.03.13.11.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:26:34 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/3] cherry-pick --continue: remember options
Date:   Wed, 13 Mar 2019 18:26:15 +0000
Message-Id: <20190313182615.7351-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313182615.7351-1-phillip.wood123@gmail.com>
References: <20190313182615.7351-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Remember --allow-empty, --allow-empty-message and
--keep-redundant-commits when cherry-pick stops for a conflict
resolution.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                     | 18 ++++++++++++++++++
 t/t3507-cherry-pick-conflict.sh |  4 ++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5e19b22f8f..1ad51aa498 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2307,6 +2307,15 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->no_commit = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.edit"))
 		opts->edit = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.allow-empty"))
+		opts->allow_empty =
+			git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.allow-empty-message"))
+		opts->allow_empty_message =
+			git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.keep-redundant-commits"))
+		opts->keep_redundant_commits =
+			git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.signoff"))
 		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.record-origin"))
@@ -2705,6 +2714,15 @@ static int save_opts(struct replay_opts *opts)
 	if (opts->edit)
 		res |= git_config_set_in_file_gently(opts_file,
 					"options.edit", "true");
+	if (opts->allow_empty)
+		res |= git_config_set_in_file_gently(opts_file,
+					"options.allow-empty", "true");
+	if (opts->allow_empty_message)
+		res |= git_config_set_in_file_gently(opts_file,
+				"options.allow-empty-message", "true");
+	if (opts->keep_redundant_commits)
+		res |= git_config_set_in_file_gently(opts_file,
+				"options.keep-redundant-commits", "true");
 	if (opts->signoff)
 		res |= git_config_set_in_file_gently(opts_file,
 					"options.signoff", "true");
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 79e994cffa..1ef8e9d534 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -410,7 +410,7 @@ test_expect_success 'cherry-pick preserves sparse-checkout' '
 	test_i18ngrep ! "Changes not staged for commit:" actual
 '
 
-test_expect_failure 'cherry-pick --continue remembers --keep-redundant-commits' '
+test_expect_success 'cherry-pick --continue remembers --keep-redundant-commits' '
 	test_when_finished "git cherry-pick --abort || :" &&
 	pristine_detach initial &&
 	test_must_fail git cherry-pick --keep-redundant-commits picked redundant &&
@@ -419,7 +419,7 @@ test_expect_failure 'cherry-pick --continue remembers --keep-redundant-commits'
 	git cherry-pick --continue
 '
 
-test_expect_failure 'cherry-pick --continue remembers --allow-empty and --allow-empty-message' '
+test_expect_success 'cherry-pick --continue remembers --allow-empty and --allow-empty-message' '
 	test_when_finished "git cherry-pick --abort || :" &&
 	pristine_detach initial &&
 	test_must_fail git cherry-pick --allow-empty --allow-empty-message \
-- 
2.21.0

