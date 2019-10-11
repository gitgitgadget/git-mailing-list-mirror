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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC491F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 08:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJKIgr (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 04:36:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50454 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfJKIgr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 04:36:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so9521102wmg.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cXMO3PinVYgqSLEFFm2db7pEvb/AG+LxHFEx2G8Ffg=;
        b=cS8UdQL872yIneVQc2pKwnu3Q8tLi8Gn8BMSvMNDzC7ApUpKwH7w5ZvHpLLwgBQDpA
         7pmg4ZItRcpq8MSuEcevldJoszVostw11b1ryax8svyfDuOAF1QY3HzcE9j+6sY2kc4b
         U1kDaG3tUp1nVie63+i6Ffty08GHtJCd/jh95JWzeGKa7Kx50Bix3vPX0q5w9jzBzdDC
         DvF4eG7lTR9BIY7hCrh3ZQsvw1JC2+ekTDEgymBLWRfa6OhsOIYTG5N2CsaLgvS6hKsH
         S1wQsWaPmMwrrtOZeNgKsznFF9+joWBo6ixL5ER2C8gZwlRy6gBVVKo+YqK8LTlOZZyo
         DBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cXMO3PinVYgqSLEFFm2db7pEvb/AG+LxHFEx2G8Ffg=;
        b=UVBDZCMOt2UurOCeJ3tDa+9IUWdd2XxNLujSB7tFpMVGJXY0V6OW4X4AbEuzzWZHzL
         eg5g6QbWfa+OhzOIi2OP9AeeztA5X797bHsJFdB1G9di26xCGUH9o4869YtO6+93Eld0
         XKJsHlLh/BnALqDvlDgo4awE1QJmnIR9edfa7gZU4URhQdtGItLMJDKyf/7ocN6Lhj40
         IAJeSUH48OvP1iID/uvh+8D9kBqtpKwwXGtSfxXVWXQsQrBG+moQ8Pt9zA9SKznTVhbO
         d38QWN4485XWZacVKpHudp38dJkLqm/YCa7dHqilV+dfLPUKoQEF6ano00FrYPka5QkR
         wIVw==
X-Gm-Message-State: APjAAAXMgmJdHXmkauuujBFnhbcJW3s40g/2jUA3689rK3uT4kVinW6l
        h5QT8G54boSdEU5uGoM=
X-Google-Smtp-Source: APXvYqxD3dHbl8Q873I7KbpoNmw9af+f6UfMAmbxqY7g+dUnw/ZwVFkg0iw6rVwXWxoK2gZRdBj3hw==
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr2298110wml.169.1570783004653;
        Fri, 11 Oct 2019 01:36:44 -0700 (PDT)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id q10sm15990337wrd.39.2019.10.11.01.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 01:36:44 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Alexander Kuleshov <kuleshovmail@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/2] format-patch: configure a command to generate the output directory name
Date:   Fri, 11 Oct 2019 10:36:42 +0200
Message-Id: <bdca9086256c6723f13712b1e80b0f1e29dafe9b.1570782773.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.13.g28bc381d7c
In-Reply-To: <b172eba0b748c3f0f638786a5cfba905aca385cc.1570782773.git.bert.wesarg@googlemail.com>
References: <30278644805925935d05ae877c4b14843e37e40c.1570469582.git.bert.wesarg@googlemail.com>
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
Changes in v2:
 * rephrase motivation

Changes in v3:
 * remove RFC

Changes in v4:
 * based on dl/format-patch-doc-test-cleanup and adopt it

Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
Cc: Denton Liu <liu.denton@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/format.txt    |  5 +++++
 Documentation/git-format-patch.txt |  6 +++++-
 builtin/log.c                      | 24 +++++++++++++++++++++++-
 t/t4014-format-patch.sh            | 26 ++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 2 deletions(-)

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
index 8d08632858..3eb507c02f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -774,6 +774,7 @@ static const char *signature = git_version_string;
 static const char *signature_file;
 static int config_cover_letter;
 static const char *config_output_directory;
+static const char *config_output_directory_cmd;
 
 enum {
 	COVER_UNSET,
@@ -856,6 +857,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.outputdirectory"))
 		return git_config_string(&config_output_directory, var, value);
+	if (!strcmp(var, "format.outputdirectorycmd"))
+		return git_config_string(&config_output_directory_cmd, var, value);
 	if (!strcmp(var, "format.useautobase")) {
 		base_auto = git_config_bool(var, value);
 		return 0;
@@ -1756,8 +1759,27 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
index 9facc3a79e..14c8f5e854 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1646,6 +1646,32 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 	test_path_is_dir patchset
 '
 
+test_expect_success 'format-patch format.outputDirectoryCmd option' '
+	test_config format.outputDirectoryCmd "echo patches" &&
+	rm -fr patches &&
+	git format-patch master..side &&
+	count=$(git rev-list --count master..side) &&
+	ls patches >list &&
+	test_line_count = $count list
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
2.23.0.13.g28bc381d7c

