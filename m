Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8611F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 08:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfJEIn6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 04:43:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41759 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfJEIn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 04:43:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id f20so8067303edv.8
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXiBsLkSAa4794S4uOb8vhmYLt9KgU4HKBrKRqMhvd0=;
        b=gGNfcEzuTtdyeEiPlRfdcfAoPg27DeC9ewZSyZtMsfIJFXRLtM95S7Zm6JFOMkitmh
         FxvHzR1iLxr4IXFzmF8p4wF3ICGAXl8nFnoiKnUl2IGntehHEPdOOuymcwX0zD5uJjff
         Aj1Mmd++q7lCRBCx7dexLFgeD0PElwPyBCCcq1xV2dcN6iY7Sb1g28/s4EmSnu4JfObQ
         1glSXJ8OcbVlAvFG6ME3+7L5lWdi7KD8s3ntffKA3cif50tG5d4lW7nkkjgMjVqwk0wr
         y94EPPqM72VdToUIPB/okBJlFu4Tt995tnXST02DeFKmylv3nW+WAHA5eeZpRIsmqhlI
         wNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXiBsLkSAa4794S4uOb8vhmYLt9KgU4HKBrKRqMhvd0=;
        b=M4XO9IDjIkScAuj/Myl7d64HNx6fg/VP1qAe5kfCHBm26V6kAM4ZXkHV3ox4/MYBMC
         qZ2KsLFh5lOAwWs1mPGhlfagkmMyowkQpNP7CPgSE8w8BqtH/xHro+9AIhuQj6hSmOyj
         piZDtS41vqSEW/fxkMqG/JLKOut/vIXTJ97ujITrAUjqu6vK4kTV6aXaH8ZUOzKEoZti
         Q6FyUvvVy7qWIX9nVl6hIepqdOFG4/apG2hczzGQdlbx65unPXqbFj/vwyXmrKMBKGe1
         21SHdHkoNomUJd37FmrH8hqyfvp4LOZr3r3JgY+uTqTY/jSTKhRYD+rKI0u/Uf2q1Ey+
         o7mA==
X-Gm-Message-State: APjAAAVZGKDLJzfFLYZAJ9lEwB4r6QNRZjn9sBVxAH0FgPoVmLdZB/c6
        51VhLOIy4RedicHuEZw=
X-Google-Smtp-Source: APXvYqwcqTg7XGzIF237Z2fKrc83T4+BmFHTQpCpL5sX9T1qAxphp8dvuKUmbLKizwDZagS9CQpTpg==
X-Received: by 2002:a17:906:d0d2:: with SMTP id bq18mr15714771ejb.233.1570265035172;
        Sat, 05 Oct 2019 01:43:55 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id h58sm1721761edb.43.2019.10.05.01.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Oct 2019 01:43:54 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Alexander Kuleshov <kuleshovmail@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] [RFC] format-patch: configure a command to generate the output directory name
Date:   Sat,  5 Oct 2019 10:43:52 +0200
Message-Id: <8cb452eddda2643b257ea23f67acd384f1dbb846.1570264824.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.11.g242cf7f110
In-Reply-To: <2b8b000d76a20349f1f9e09260eff91429beebfb.1570264824.git.bert.wesarg@googlemail.com>
References: <431f8a4e372feccf240b9c66c91248a6f53eab47.1570051490.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'format.outputDirectory' configuration is only able to store constant
directory names. Though some may use

   $ git format-patch -o $(createdir) …

to name the directory dynamically. Provide a new configuration to be able
to store such a command too.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

--- 

ChangeLog:

v2:
 * rephrase motivation

Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
Cc: Denton Liu <liu.denton@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/format.txt    |  5 +++++
 Documentation/git-format-patch.txt |  6 +++++-
 builtin/log.c                      | 24 +++++++++++++++++++++++-
 t/t4014-format-patch.sh            | 25 +++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 40cad9278f..420188a1c6 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -83,6 +83,11 @@ format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
 	current working directory. All directory components will be created.
 
+format.outputDirectoryCmd::
+	The command which is used to name a custom directory to store the
+	resulting files instead of the current working directory. All directory
+	components will be created.
+
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
 	format-patch by default.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 2035d4d5d5..4936b9f91d 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -67,7 +67,11 @@ can be set with the `format.outputDirectory` configuration option.
 The `-o` option takes precedence over `format.outputDirectory`.
 To store patches in the current working directory even when
 `format.outputDirectory` points elsewhere, use `-o .`. All directory
-components will be created.
+components will be created. The 'format.outputDirectoryCmd' configuration can
+be used to name a command to produce the directory name programmatically. The
+command should produce the name to its standard output. The
+`format.outputDirectory` configuration takes precedence over
+`format.outputDirectoryCmd`.
 
 By default, the subject of a single patch is "[PATCH] " followed by
 the concatenation of lines from the commit message up to the first blank
diff --git a/builtin/log.c b/builtin/log.c
index 294534aacb..e841306e61 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -775,6 +775,7 @@ static const char *signature = git_version_string;
 static const char *signature_file;
 static int config_cover_letter;
 static const char *config_output_directory;
+static const char *config_output_directory_cmd;
 
 enum {
 	COVER_UNSET,
@@ -857,6 +858,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.outputdirectory"))
 		return git_config_string(&config_output_directory, var, value);
+	if (!strcmp(var, "format.outputdirectorycmd"))
+		return git_config_string(&config_output_directory_cmd, var, value);
 	if (!strcmp(var, "format.useautobase")) {
 		base_auto = git_config_bool(var, value);
 		return 0;
@@ -1757,8 +1760,27 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		init_display_notes(&rev.notes_opt);
 
-	if (!output_directory && !use_stdout)
+	if (!output_directory && !use_stdout) {
+		// outputDirectoryCmd can be preceeded by outputDirectory
+		if (!config_output_directory && config_output_directory_cmd) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			const char *argv[1];
+			struct strbuf buf = STRBUF_INIT;
+			int rc;
+
+			argv[0] = config_output_directory_cmd;
+			cp.argv = argv;
+			cp.use_shell = 1;
+			rc = capture_command(&cp, &buf, PATH_MAX);
+			if (rc)
+				die(_("outputDirectoryCmd command failed: "
+				      "'%s'"), config_output_directory_cmd);
+			strbuf_setlen(&buf, strcspn(buf.buf, "\r\n"));
+			config_output_directory = strbuf_detach(&buf, NULL);
+		}
+
 		output_directory = config_output_directory;
+	}
 
 	if (!use_stdout)
 		output_directory = set_outdir(prefix, output_directory);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 2f2cd6fea6..f351d26543 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1642,6 +1642,31 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 	test_path_is_dir patchset
 '
 
+test_expect_success 'format-patch format.outputDirectoryCmd option' '
+	test_config format.outputDirectoryCmd "echo patches" &&
+	rm -fr patches &&
+	git format-patch master..side &&
+	git rev-list master..side >list &&
+	test_line_count = $(ls patches | wc -l) list
+'
+
+test_expect_success 'format-patch format.outputDirectory overrides format.outputDirectoryCmd' '
+	test_config format.outputDirectoryCmd "echo patches" &&
+	test_config format.outputDirectory patchset &&
+	rm -fr patches patchset &&
+	git format-patch master..side &&
+	test_path_is_missing patches &&
+	test_path_is_dir patchset
+'
+
+test_expect_success 'format-patch -o overrides format.outputDirectoryCmd' '
+	test_config format.outputDirectoryCmd "echo patches" &&
+	rm -fr patches patchset &&
+	git format-patch -o patchset master..side &&
+	test_path_is_missing patches &&
+	test_path_is_dir patchset
+'
+
 test_expect_success 'format-patch --base' '
 	git checkout patchid &&
 
-- 
2.23.0.11.g242cf7f110

