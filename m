Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712BC1F462
	for <e@80x24.org>; Wed, 22 May 2019 02:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfEVCoo (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 22:44:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40242 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfEVCoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 22:44:44 -0400
Received: by mail-io1-f68.google.com with SMTP id s20so627299ioj.7
        for <git@vger.kernel.org>; Tue, 21 May 2019 19:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jw2TQLTbDWiejHY6tIlatO7sk9t0v5Gc48VX9pmJouw=;
        b=Ho1dBe26G1/dUjfyqtt5ZhlTwv9t8QToRgJmlGWlNg+XPbrmyAeINHpw6Cruddl4cI
         Y7pVxB8LgWVJlekUdv1NUqBMK6tXY3f72ys5cqjsyvCsJyH3uwl8b3oSOYw7jss4VObF
         MPea/Rgn2mA7NHJsYLUIKX2nUtTaeMmpW2MvS1sNjlS9WqJ10gvKVqS9EyvIIPNiWl+1
         Jn2XCos7uBZTTm8ukXkiy0/ZfRuaSNfrxCaGXe5/nfDFW//1RaeQw8w0jyQBX0u+PON0
         mZqCT6N5cg8kjPyvUHjAQ5HHznkavQLTCNLHA/7CdnX0myKtYy/r1pIhEhwa8hwmOlxs
         6iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jw2TQLTbDWiejHY6tIlatO7sk9t0v5Gc48VX9pmJouw=;
        b=tXWW+W9T/wLfj64gwYJcCXEUTHj1+MWvhG8c2Jto3QjGHi7M8UWKY4e3eJvdGTzqZo
         V7dRHYcl/g57EuGVzDkR4wdNm9Rsb5xhjGipLiHSPEG0RHk7vOMfGxG2mA/jlbFO0yFB
         cz2BeYcyT8I4+60+x8BN5D1IDY/lZuPCq/5OABUJ70UuNznkf9XbFKI6HpN/PhsIqMs6
         jke0eZDHrmh9EXxd9qACnXBSMaS36EY8TaEHDJfuWhMNfW0c2rQCz+vIl5mBgHelLXJm
         ySbZn1VMio3N7J8LvcsqkJ50/RsY0n5JRLSSmS8NrpJtlqRE4AnsX9YfxfHBiSkxIK8d
         wyMg==
X-Gm-Message-State: APjAAAWq6wl7aPn8TUug4mbfb3YfIY/sF4DKr7sQDse50keuauykUv1n
        Vdr0AeGw7mdKqbHAS2Cv7+hk4QFF
X-Google-Smtp-Source: APXvYqw5hwNqY3bJ80mUIsNRBSDDpohqiCHsAv9CE6qAa+1NRJNiRX82rJMp6YblYqxgGSXDIAd2Jg==
X-Received: by 2002:a05:6602:2049:: with SMTP id z9mr22182027iod.46.1558493082982;
        Tue, 21 May 2019 19:44:42 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id k203sm2198496itk.41.2019.05.21.19.44.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 19:44:42 -0700 (PDT)
Date:   Tue, 21 May 2019 22:44:41 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/8] format-patch: read branch-specific output directory
Message-ID: <b23c3c16f752242a25245cdbfb97b26598d47dc0.1558492582.git.liu.denton@gmail.com>
References: <cover.1558052674.git.liu.denton@gmail.com>
 <cover.1558492582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558492582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user wishes to have a per-branch output directory for patches, they
must manually specify this on the command-line with `-o` for each
invocation of format-patch. However, this can be cumbersome for a user
to keep track of.

Read `format.<branch-name>.outputDirectory` to give a branch-specific
output directory that would override `format.outputDirectory`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt    |  5 ++++-
 Documentation/git-format-patch.txt |  3 ++-
 builtin/log.c                      | 26 ++++++++++++++++++++++++--
 t/t4014-format-patch.sh            | 18 +++++++++++++++---
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 95e255347a..df67a83183 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -87,8 +87,11 @@ format.coverLetter::
 	generate a cover-letter only when there's more than one patch.
 
 format.outputDirectory::
+format.<branch-name>.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
-	current working directory.
+	current working directory. If patches are being generated for
+	<branch-name>, the latter option takes priority if it exists,
+	otherwise we will fallback to the former.
 
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 707b4bdc6b..346f1229d8 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -359,12 +359,13 @@ with configuration variables.
 ------------
 
 In addition, for a specific branch, you can add additional "To:" or
-"Cc:" headers.
+"Cc:" headers and change the patch output directory.
 
 ------------
 [format "branch-name"]
 	to = <email>
 	cc = <email>
+	outputDirectory = <directory>
 ------------
 
 DISCUSSION
diff --git a/builtin/log.c b/builtin/log.c
index 97980881ec..a1fe8b994a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1023,6 +1023,24 @@ static void show_diffstat(struct rev_info *rev,
 	fprintf(rev->diffopt.file, "\n");
 }
 
+static const char *get_branch_output_dir(struct rev_info *rev, const char *branch_name)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *output_directory;
+
+	if (!branch_name)
+		branch_name = find_branch_name(rev);
+
+	if (!branch_name || !*branch_name)
+		return NULL;
+
+	strbuf_addf(&buf, "format.%s.outputdirectory", branch_name);
+	git_config_get_string_const(buf.buf, &output_directory);
+	strbuf_release(&buf);
+
+	return output_directory;
+}
+
 static void add_branch_headers(struct rev_info *rev, const char *branch_name)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -1804,8 +1822,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (!output_directory && !use_stdout)
-		output_directory = config_output_directory;
+	if (!use_stdout) {
+		if (!output_directory)
+			output_directory = get_branch_output_dir(&rev, branch_name);
+		if (!output_directory)
+			output_directory = config_output_directory;
+	}
 
 	if (!use_stdout)
 		output_directory = set_outdir(prefix, output_directory);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 23c467e95b..147934922c 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1667,12 +1667,24 @@ test_expect_success 'format-patch format.outputDirectory option' '
 	test_line_count = $(ls patches | wc -l) list
 '
 
-test_expect_success 'format-patch -o overrides format.outputDirectory' '
+test_expect_success 'format-patch format.side.outputDirectory option overrides format.outputDirectory' '
 	test_config format.outputDirectory patches &&
-	rm -fr patches patchset &&
+	test_config format.side.outputDirectory sidepatches &&
+	rm -fr patches sidepatches &&
+	git format-patch master..side &&
+	git rev-list master..side >list &&
+	test_path_is_missing patches &&
+	test_line_count = $(ls sidepatches | wc -l) list
+'
+
+test_expect_success 'format-patch -o overrides format.outputDirectory and format.side.outputDirectory' '
+	test_config format.outputDirectory patches &&
+	test_config format.side.outputDirectory sidepatches &&
+	rm -fr patches sidepatches patchset &&
 	git format-patch master..side -o patchset &&
 	test_path_is_missing patches &&
-	test_path_is_dir patchset
+	test_path_is_missing sidepatches &&
+	test_line_count = $(ls patchset | wc -l) list
 '
 
 test_expect_success 'format-patch --base' '
-- 
2.22.0.rc1.169.g49223abbf8

