Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CFD81F404
	for <e@80x24.org>; Sun, 11 Feb 2018 16:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbeBKQkm (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 11:40:42 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39140 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBKQkk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 11:40:40 -0500
Received: by mail-wr0-f196.google.com with SMTP id g4so3027786wrb.6
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 08:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nqjA5i1D2zm2fJd3wLtgehb23Y2NQS2eXeWhlPOdcDY=;
        b=NNsQLaXc6wfkTo3CldyIr5khYEvA/z9Jq91cM8/A6ZiLY+rLqdLNzTjI8XrFhIDJmR
         E9wy0TAQVdGPcllhXTvtqU1PeZj4Wg3YTU4q1tNhl/UwUwRt38/wIJI6M8QrH1Xuo25y
         DBiB/nUqZgB9v1o1qcrFHJvZuYGnb3JfKFyBq4Po329DRdVhQC/amEe5zhLNFFyMUp7j
         JFIWRmH8bfjQhd+LiFi/9ayGkQdZ3fO3vA8BRFJOZPg5wqkqMMn96fBQfZbnWs7iQxse
         kQaCTDUB8sNyWLtEqCdDKiIzFL2bhPQLg3HTH5hul7PMObo2JBFs6E1dQCAruTnlJUiL
         fNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqjA5i1D2zm2fJd3wLtgehb23Y2NQS2eXeWhlPOdcDY=;
        b=NyfNdNjFj3VPi9jfVxXMNQI6BH8NARkpvk1FXLCeApXhcRZxiOvD5u2C9UwyXQpnVf
         hXY5aPu8SdszhoyrP6Svp+fFC6Rz4qfJsR8LjOph+pAkzP23sCpsswzYo5ThBHVRlZKq
         r1v+ygAJYjVdILwZV5FYyBaCqzzCLhF2S1Y3MvvTYld84MdBaSbSzTr3XiAhIo/2rwPT
         axXvamI3iCMH7M7c0rAjxAREreEL/wtaQQwyCQud2L8utIeIu9GCjfxYUZ+oIPGb/o1z
         e2KViBo2w15GTX2VLp/EBlesTIt5Prc7SxYpOEMptmCP7MpuJV16F0lOzQkaX2tGEaKQ
         vLQA==
X-Gm-Message-State: APf1xPBj+ltoh3mAyI6YtBWWcHoqIcaZ2AIpc+opNvoG+G9rmCZNQuh+
        Nm3vDcO+tjasO76vv8y3jc+y2SjA
X-Google-Smtp-Source: AH8x224NmZquWCrdEbzEt8UIl8Dirf/ipl7cpP3MtORt2n9CkiRJbFoJYy+Mp0wUXNPZRfecE9iDFw==
X-Received: by 10.223.184.124 with SMTP id u57mr1605809wrf.100.1518367239039;
        Sun, 11 Feb 2018 08:40:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id z73sm10012551wrb.50.2018.02.11.08.40.37
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Feb 2018 08:40:38 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] config: respect `pager.config` in list/get-mode only
Date:   Sun, 11 Feb 2018 17:40:24 +0100
Message-Id: <ad9a12af60cdc6ff747337c4116fe41860f82701.1518365675.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a
In-Reply-To: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
References: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to de121ffe5 (tag: respect `pager.tag` in list-mode only,
2017-08-02), use the DELAY_PAGER_CONFIG-mechanism to only respect
`pager.config` when we are listing or "get"ing config.

Some getters give at most one line of output, but it is much easier to
document and understand that we page all of --get[-*] and --list, than
to divide the (current and future) getters into "pages" and "doesn't".

This fixes the failing test added in the previous commit. Also adapt the
test for whether `git config foo.bar bar` respects `pager.config`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-config.txt | 5 +++++
 t/t7006-pager.sh             | 6 +++---
 builtin/config.c             | 8 ++++++++
 git.c                        | 2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 14da5fc157..ccc8f0bcff 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -233,6 +233,11 @@ See also <<FILES>>.
 	using `--file`, `--global`, etc) and `on` when searching all
 	config files.
 
+CONFIGURATION
+-------------
+`pager.config` is only respected when listing configuration, i.e., when
+`--list`, `--get` or any of `--get-*` is used.
+
 [[FILES]]
 FILES
 -----
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 5a7b757c94..869a0359a8 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -245,13 +245,13 @@ test_expect_success TTY 'git branch --set-upstream-to ignores pager.branch' '
 	! test -e paginated.out
 '
 
-test_expect_success TTY 'git config respects pager.config when setting' '
+test_expect_success TTY 'git config ignores pager.config when setting' '
 	rm -f paginated.out &&
 	test_terminal git -c pager.config config foo.bar bar &&
-	test -e paginated.out
+	! test -e paginated.out
 '
 
-test_expect_failure TTY 'git config --edit ignores pager.config' '
+test_expect_success TTY 'git config --edit ignores pager.config' '
 	rm -f paginated.out editor.used &&
 	write_script editor <<-\EOF &&
 		touch editor.used
diff --git a/builtin/config.c b/builtin/config.c
index ab5f95476e..9a57a0caff 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -48,6 +48,11 @@ static int show_origin;
 #define ACTION_GET_COLORBOOL (1<<14)
 #define ACTION_GET_URLMATCH (1<<15)
 
+/* convenience macro for "ACTION_LIST | ACTION_GET_*" */
+#define ACTION_LIST_OR_GET (ACTION_LIST | ACTION_GET | ACTION_GET_ALL | \
+			    ACTION_GET_REGEXP | ACTION_GET_COLOR | \
+			    ACTION_GET_COLORBOOL | ACTION_GET_URLMATCH)
+
 #define TYPE_BOOL (1<<0)
 #define TYPE_INT (1<<1)
 #define TYPE_BOOL_OR_INT (1<<2)
@@ -594,6 +599,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (actions & ACTION_LIST_OR_GET)
+		setup_auto_pager("config", 0);
+
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (config_with_options(show_all_config, NULL,
diff --git a/git.c b/git.c
index c870b9719c..e5c9b8729d 100644
--- a/git.c
+++ b/git.c
@@ -389,7 +389,7 @@ static struct cmd_struct commands[] = {
 	{ "column", cmd_column, RUN_SETUP_GENTLY },
 	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-	{ "config", cmd_config, RUN_SETUP_GENTLY },
+	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
 	{ "credential", cmd_credential, RUN_SETUP_GENTLY },
 	{ "describe", cmd_describe, RUN_SETUP },
-- 
2.16.1.72.g5be1f00a9a

