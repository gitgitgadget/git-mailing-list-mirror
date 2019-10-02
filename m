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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4D01F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 21:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfJBV0W (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 17:26:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40169 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbfJBV0U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 17:26:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id v38so506625edm.7
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 14:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LPlPjWtsf12ikJ3fQw1ZDy/OpJJCzhhxiQZfmU7Y7I=;
        b=k76neYBIv4WC5y7pY/GF4x2XN0wYyMtpmR0OpwE97TGcCdyQtzk6nhvxI+hZGXeKPS
         pNsd8/d8DmIDgj/rLvbtSVzAGiVlpeoIc5WZ/CGhkBN229bI31sDDlcHUItAtUk8GkVD
         c5RovCMkEn+v4bE9EbHm3TleyvCfGxwY3vhGU2TuroF734/o39hgbHuGbTQs72TPCooX
         iUmli6+PgXmoC56oRZ/yYHHw+cojjJo26ncH6vNLVvKX8jJx4B/LcsWECuJxwL3IxaUr
         CcPyUlINRf9PP37PKHaMPTLSfrsaVg/DlI45IqS+t/ZHtRpkSkotTZUTZt+NMb4ZCTYU
         yifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LPlPjWtsf12ikJ3fQw1ZDy/OpJJCzhhxiQZfmU7Y7I=;
        b=j85fXjE7MNJDOCn+Va7BOSAepvpwRERWhKS6ErpePoeJcIo5dvb5817x13syKq4gWI
         ONl4yLJw1BnxMNWd3d2K7CagMNBvLH5YAu+Sj3IEINsd61yWXUUQyhOZ/mius09V8Cfb
         ZGlhtpaYnHY2CY8Ww0RAiS68vbTpYyrzV5HhgolO7xa6O2QXfzfHEgUujviZrd8tV464
         hcH7Qgj1JdeJoq+rT4RD5HTWjjscdBWBo0n1x6Ev9TrYhfQMBBC2Jo6XMc4XXvWRJp48
         IltVtodCYWEX8SlA3Zm83MLReUfPymkHdXlT6XiH6ZLBeD3stVYDa5YYsRH/l8h5kpjs
         oRXw==
X-Gm-Message-State: APjAAAXKPHDZB/Y/PnCsJvF4GBUs59ea3A8gnthpcv0pjDWmsW1Ac+4u
        FVMN9Y6m/NTFgk7EERI=
X-Google-Smtp-Source: APXvYqxHaxHo9iJRBr7BdSZWKrXWPkhqqXlwzlrDar7uRBT2GiCAqueJZRHqeXZnTc5z5uY7qLa6Zw==
X-Received: by 2002:a17:906:409b:: with SMTP id u27mr4983207ejj.295.1570051576883;
        Wed, 02 Oct 2019 14:26:16 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id o26sm63799edi.23.2019.10.02.14.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 14:26:16 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Alexander Kuleshov <kuleshovmail@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC PATCH 3/3] format-patch: use a command to generate the output directory name
Date:   Wed,  2 Oct 2019 23:26:13 +0200
Message-Id: <431f8a4e372feccf240b9c66c91248a6f53eab47.1570051490.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.11.g242cf7f110
In-Reply-To: <1aeacd8af4b83142f160c63be4746554e823cfc3.1570051490.git.bert.wesarg@googlemail.com>
References: <1aeacd8af4b83142f160c63be4746554e823cfc3.1570051490.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Having 'format.outputDirectory' is convenient, but being able to process
all produced patches via a wildcard command is even more so. I.e.,
using an argument like '<dir>/*'. Neither '-o' nor
'format.outputDirectory' can be parameterized to produce a new unique
directory. Thus provide the new 'format.outputDirectoryCmd' configuration
to specify a command which does the job and puts the name to standard
output.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/config/format.txt    |  5 +++++
 Documentation/git-format-patch.txt |  6 +++++-
 builtin/log.c                      | 24 +++++++++++++++++++++++-
 t/t4014-format-patch.sh            | 24 ++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index b6c96ece04..dcce2c67ef 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -82,6 +82,11 @@ format.outputDirectory::
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
index f418f490aa..0da904255b 100644
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
index 1ab9eb6b78..b102e86bea 100644
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
index 43d608aa94..bf2547ce87 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1664,6 +1664,30 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 	test_path_is_dir patchset
 '
 
+test_expect_success 'format-patch format.outputDirectoryCmd option' '
+	test_config format.outputDirectoryCmd "echo patches" &&
+	rm -fr patches &&
+	git format-patch master..side &&
+	test $(git rev-list master..side | wc -l) -eq $(ls patches | wc -l)
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
 	git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual1 &&
-- 
2.23.0.11.g242cf7f110

