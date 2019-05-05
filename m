Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD871F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfEEQYy (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:24:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42068 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfEEQYy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:24:54 -0400
Received: by mail-io1-f67.google.com with SMTP id c24so9105790iom.9
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QwX7VAYhuUVcR2HyKAVEOQPOp/lIvhZUrmzk2hFAoTg=;
        b=eWBqA/UeCiGaFAcaRStpDjC9qPrddsijQrZlxabEWba99T8zx/nU0PMGGnVP6477kZ
         hEjUzRrzXwVo5+bSEErgpM3dxfX/KWgjdxBRNXzOCMkQUk9wyNPqpa3ZrXSUs38r5rho
         3ntmz0zzIaDhG3s9GqmDWKm0gviAFvIZKniAhbnwNVvsYlyesIkOKYMWWO5eotZ8c+JR
         fwVs4JVLv+m8yBMHvfGnoQjoBOKK9+jvUUKySB57j9ELl+Xprch8vonewqjiGPV+eqR7
         u5x+CgxH1bgfScyJCsz1CjVHQbTd4ymA9yq+TUZ1Qe82vbevWq3GMC/w7ju4vw6q4VJB
         J84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QwX7VAYhuUVcR2HyKAVEOQPOp/lIvhZUrmzk2hFAoTg=;
        b=hhSpN0aL8fDWCREYLWI1qNV8+COnnCXgbF4H1LZuufPtTbNtqW9sPUS4t7964fKTlv
         ngPDFzoz6p8xDCR2ufZs8kSPSp0IAMgdXVrR7ha5ImgZtuWyXqesfvU5ma8wwyNmyxf7
         2n/8mpydwWYf2iLyuxbtvNRcyvWGQL5bNKN9dF8ZYnqp3Xon7GwnJ3CUgU15pxBAilOv
         q/M/RMaZgFX1aOEvdoG/IZYFI3cAMuZInPbK61g762LwM5VkCxmnOJcQeLn0gzpbekwc
         G25i0US+oTvHUPRWHL8rlcWJtJRkgq94/V6fIQkUT+4qhGWjJYeERTls10fxfVSpDzo9
         xZLA==
X-Gm-Message-State: APjAAAUEzoYNvz+kLdQSytRb+MIpqJZ1hT0HntFa0ABo1h8erPYQvKwq
        CUuisQPlQzvnOeWJ0fJLjYRLtDvP
X-Google-Smtp-Source: APXvYqx0g3nwMKzTVICeTdlyzM4LF0/gbP/1gbcrcz6pCWw7vXB5ZJdD3PDhwZr2r1RZT1rpmsz3dg==
X-Received: by 2002:a05:6602:21d7:: with SMTP id c23mr2997677ioc.66.1557073493226;
        Sun, 05 May 2019 09:24:53 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id v187sm9107503ita.0.2019.05.05.09.24.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:24:52 -0700 (PDT)
Date:   Sun, 5 May 2019 12:24:49 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 7/7] format-patch: read branch-specific To: and Cc: headers
Message-ID: <7e625b688883c0528348f77d181bc28195d8ab92.1557072929.git.liu.denton@gmail.com>
References: <cover.1557072929.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1557072929.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user wishes to keep track of whom to Cc: on individual patchsets,
they must manually keep track of each recipient and fill it in with the
`--cc` option on git-format-patch each time. However, on the Git mailing
list, Cc:'s are typically never dropped. As a result, it would be nice
to have a method to keep track of recipients on a per-branch basis.

Currently, git-format-patch gets its To: headers from the `--to` options
and the `format.to` config variable. The Cc: header is derived
similarly.

In addition to the above, read To: and Cc: headers from
`branch.<name>.to` and `branch.<name>.cc` so that users can have
branch-specific configuration options.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/branch.txt    |   6 ++
 Documentation/git-format-patch.txt |  10 +--
 builtin/log.c                      |  63 +++++++++++++++--
 t/t4014-format-patch.sh            | 108 +++++++++++++++++++++++------
 4 files changed, 159 insertions(+), 28 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 2bff738982..22b9bf3d0d 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -104,3 +104,9 @@ branch.<name>.description::
 branch.<name>.coverSubject::
 	When format-patch generates a cover letter, use the specified
 	subject for the cover letter instead of the generic template.
+
+branch.<name>.to::
+branch.<name>.cc::
+	Additional recipients to include in a patch to be submitted
+	by mail.  See the --to and --cc options in
+	linkgit:git-format-patch[1].
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index af7883acbe..1c972f683a 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -199,7 +199,7 @@ will want to ensure that threading is disabled for `git send-email`.
 	Add a `To:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times. The
 	emails given will be used along with any emails given by
-	`format.to` configurations.
+	`format.to` and `branch.<name>.to` configurations.
 	The negated form `--no-to` discards all `To:` headers added so
 	far (from config or command line).
 
@@ -207,7 +207,7 @@ will want to ensure that threading is disabled for `git send-email`.
 	Add a `Cc:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times. The
 	emails given will be used along with any emails given by
-	`format.cc` configurations.
+	`format.cc` and `branch.<name>.cc` configurations.
 	The negated form `--no-cc` discards all `Cc:` headers added so
 	far (from config or command line).
 
@@ -335,7 +335,7 @@ CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message,
 defaults for the subject prefix and file suffix, number patches when
-outputting more than one patch, add "To" or "Cc:" headers, configure
+outputting more than one patch, add "To:" or "Cc:" headers, configure
 attachments, and sign off patches with configuration variables.
 
 ------------
@@ -352,11 +352,13 @@ attachments, and sign off patches with configuration variables.
 ------------
 
 In addition, for a specific branch, you can specify a custom cover
-letter subject.
+letter subject, and add additional "To:" or "Cc:" headers.
 
 ------------
 [branch "branch-name"]
 	coverSubject = "subject for branch-name only"
+	to = <email>
+	cc = <email>
 ------------
 
 DISCUSSION
diff --git a/builtin/log.c b/builtin/log.c
index 685e319078..6825d95c5f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -738,6 +738,8 @@ static char *default_attach = NULL;
 static struct string_list extra_hdr = STRING_LIST_INIT_NODUP;
 static struct string_list extra_to = STRING_LIST_INIT_NODUP;
 static struct string_list extra_cc = STRING_LIST_INIT_NODUP;
+int to_cleared;
+int cc_cleared;
 
 static void add_header(const char *value)
 {
@@ -1030,6 +1032,55 @@ static void show_diffstat(struct rev_info *rev,
 	fprintf(rev->diffopt.file, "\n");
 }
 
+static void add_branch_headers(struct rev_info *rev, const char *branch_name)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const struct string_list *values;
+
+	if (!branch_name)
+		branch_name = find_branch_name(rev);
+
+	if (!branch_name || !*branch_name)
+		return;
+
+	/*
+	 * HACK: We only use branch-specific recipients iff the list has not
+	 * been cleared by an earlier --no-{to,cc} option on the command-line.
+	 *
+	 * When we get format.{to,cc} options, they can be cleared by
+	 * --no-{to,cc} options since the `git_config` call comes before the
+	 *  `parse_options` call.
+	 *
+	 *  However, in the case of branch.<name>.{to,cc}, this function needs
+	 *  to be called after `setup_revisions`, which must be called after
+	 *  `parse_options`. However, in order for the --no-{to,cc} logic to
+	 *  clear the extra_{to,cc} string_list, this function should actually
+	 *  be called _before_ `parse_options`. As a result, we have a circular
+	 *  dependency.
+	 *
+	 *  The {to,cc}_cleared flag lets us workaround this by just no
+	 *  including branch-specific recipients iff --no-{to,cc} has been
+	 *  specified on the command-line.
+	 */
+
+	if (!to_cleared) {
+		strbuf_addf(&buf, "branch.%s.to", branch_name);
+		values = git_config_get_value_multi(buf.buf);
+		if (values)
+			string_list_append_all(&extra_to, values);
+	}
+
+	if (!cc_cleared) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "branch.%s.cc", branch_name);
+		values = git_config_get_value_multi(buf.buf);
+		if (values)
+			string_list_append_all(&extra_cc, values);
+	}
+
+	strbuf_release(&buf);
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
@@ -1289,18 +1340,20 @@ static int header_callback(const struct option *opt, const char *arg, int unset)
 
 static int to_callback(const struct option *opt, const char *arg, int unset)
 {
-	if (unset)
+	if (unset) {
+		to_cleared = 1;
 		string_list_clear(&extra_to, 0);
-	else
+	} else
 		string_list_append(&extra_to, arg);
 	return 0;
 }
 
 static int cc_callback(const struct option *opt, const char *arg, int unset)
 {
-	if (unset)
+	if (unset) {
+		cc_cleared = 1;
 		string_list_clear(&extra_cc, 0);
-	else
+	} else
 		string_list_append(&extra_cc, arg);
 	return 0;
 }
@@ -1767,6 +1820,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	add_branch_headers(&rev, branch_name);
+
 	for (i = 0; i < extra_hdr.nr; i++) {
 		strbuf_addstr(&buf, extra_hdr.items[i].string);
 		strbuf_addch(&buf, '\n');
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 1cf4dfbce2..6578e6b433 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -234,6 +234,65 @@ test_expect_failure 'configuration To: header (rfc2047)' '
 	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
 '
 
+test_expect_success 'branch-specific configuration To: header (ascii)' '
+
+	test_unconfig format.to &&
+	git config branch.side.to "R E Cipient <rcipient@example.com>" &&
+	git format-patch --stdout master..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs10
+'
+
+test_expect_failure 'branch-specific configuration To: header (rfc822)' '
+
+	git config branch.side.to "R. E. Cipient <rcipient@example.com>" &&
+	git format-patch --stdout master..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs10
+'
+
+test_expect_failure 'branch-specific configuration To: header (rfc2047)' '
+
+	git config branch.side.to "R Ä Cipient <rcipient@example.com>" &&
+	git format-patch --stdout master..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs10
+'
+
+test_expect_success 'all recipients included from all sources' '
+
+	git config format.to "Format To1 <formatto1@example.com>" &&
+	git config --add format.to "Format To2 <formatto2@example.com>" &&
+	git config format.cc "Format Cc1 <formatcc1@example.com>" &&
+	git config --add format.cc "Format Cc2 <formatcc2@example.com>" &&
+	git config branch.side.to "Branch To1 <branchto1@example.com>" &&
+	git config --add branch.side.to "Branch To2 <branchto2@example.com>" &&
+	git config branch.side.cc "Branch Cc1 <branchcc1@example.com>" &&
+	git config --add branch.side.cc "Branch Cc2 <branchcc2@example.com>" &&
+	cat <<-\EOF >expect &&
+	To: Format To1 <formatto1@example.com>,
+	    Format To2 <formatto2@example.com>,
+	    Command-line To1 <commandlineto1@example.com>,
+	    Command-line To2 <commandlineto2@example.com>,
+	    Branch To1 <branchto1@example.com>,
+	    Branch To2 <branchto2@example.com>
+	Cc: Format Cc1 <formatcc1@example.com>,
+	    Format Cc2 <formatcc2@example.com>,
+	    Command-line Cc1 <commandlinecc1@example.com>,
+	    Command-line Cc2 <commandlinecc2@example.com>,
+	    Branch Cc1 <branchcc1@example.com>,
+	    Branch Cc2 <branchcc2@example.com>
+
+	EOF
+	git format-patch --stdout \
+		--to="Command-line To1 <commandlineto1@example.com>" \
+		--to="Command-line To2 <commandlineto2@example.com>" \
+		--cc="Command-line Cc1 <commandlinecc1@example.com>" \
+		--cc="Command-line Cc2 <commandlinecc2@example.com>" \
+		master..side | sed -ne "/^To:/,/^$/p;/^$/q" >patch10 &&
+	test_cmp expect patch10
+'
+
 # check_patch <patch>: Verify that <patch> looks like a half-sane
 # patch email to avoid a false positive with !grep
 check_patch () {
@@ -286,42 +345,51 @@ test_expect_success '--no-to overrides config.to' '
 
 	git config --replace-all format.to \
 		"R E Cipient <rcipient@example.com>" &&
-	git format-patch --no-to --stdout master..side >patch10 &&
-	sed -e "/^\$/q" patch10 >hdrs10 &&
-	check_patch hdrs10 &&
-	! grep "^To: R E Cipient <rcipient@example.com>\$" hdrs10
+	git config --replace-all branch.side.to \
+		"B R Anch <branch@example.com>" &&
+	git format-patch --no-to --stdout master..side >patch11 &&
+	sed -e "/^\$/q" patch11 >hdrs11 &&
+	check_patch hdrs11 &&
+	! grep "R E Cipient <rcipient@example.com>" hdrs11 &&
+	! grep "B R Anch <branch@example.com>" hdrs11
 '
 
 test_expect_success '--no-to and --to replaces config.to' '
 
 	git config --replace-all format.to \
 		"Someone <someone@out.there>" &&
+	git config --replace-all branch.side.to \
+		"B R Anch2 <branch2@example.com>" &&
 	git format-patch --no-to --to="Someone Else <else@out.there>" \
-		--stdout master..side >patch11 &&
-	sed -e "/^\$/q" patch11 >hdrs11 &&
-	check_patch hdrs11 &&
-	! grep "^To: Someone <someone@out.there>\$" hdrs11 &&
-	grep "^To: Someone Else <else@out.there>\$" hdrs11
+		--stdout master..side >patch12 &&
+	sed -e "/^\$/q" patch12 >hdrs12 &&
+	check_patch hdrs12 &&
+	! grep "Someone <someone@out.there>" hdrs12 &&
+	! grep "B R Anch2 <branch2@example.com>" hdrs12 &&
+	grep "^To: Someone Else <else@out.there>\$" hdrs12
 '
 
 test_expect_success '--no-cc overrides config.cc' '
 
 	git config --replace-all format.cc \
 		"C E Cipient <rcipient@example.com>" &&
-	git format-patch --no-cc --stdout master..side >patch12 &&
-	sed -e "/^\$/q" patch12 >hdrs12 &&
-	check_patch hdrs12 &&
-	! grep "^Cc: C E Cipient <rcipient@example.com>\$" hdrs12
+	git config --replace-all branch.side.cc \
+		"B R Anch3 <branch3@example.com>" &&
+	git format-patch --no-cc --stdout master..side >patch13 &&
+	sed -e "/^\$/q" patch13 >hdrs13 &&
+	check_patch hdrs13 &&
+	! grep "C E Cipient <rcipient@example.com>" hdrs13 &&
+	! grep "B R Anch3 <branch3@example.com>" hdrs13
 '
 
 test_expect_success '--no-add-header overrides config.headers' '
 
 	git config --replace-all format.headers \
 		"Header1: B E Cipient <rcipient@example.com>" &&
-	git format-patch --no-add-header --stdout master..side >patch13 &&
-	sed -e "/^\$/q" patch13 >hdrs13 &&
-	check_patch hdrs13 &&
-	! grep "^Header1: B E Cipient <rcipient@example.com>\$" hdrs13
+	git format-patch --no-add-header --stdout master..side >patch14 &&
+	sed -e "/^\$/q" patch14 >hdrs14 &&
+	check_patch hdrs14 &&
+	! grep "^Header1: B E Cipient <rcipient@example.com>\$" hdrs14
 '
 
 test_expect_success 'multiple files' '
@@ -957,7 +1025,7 @@ test_expect_success 'format-patch wraps extremely long subject (ascii)' '
 	git add file &&
 	git commit -m "$M512" &&
 	git format-patch --stdout -1 >patch &&
-	sed -n "/^Subject/p; /^ /p; /^$/q" <patch >subject &&
+	sed -n "/^Subject/p; /^ /p; /^Header1:/q" <patch >subject &&
 	test_cmp expect subject
 '
 
@@ -996,7 +1064,7 @@ test_expect_success 'format-patch wraps extremely long subject (rfc2047)' '
 	git add file &&
 	git commit -m "$M512" &&
 	git format-patch --stdout -1 >patch &&
-	sed -n "/^Subject/p; /^ /p; /^$/q" <patch >subject &&
+	sed -n "/^Subject/p; /^ /p; /^Header1:/q" <patch >subject &&
 	test_cmp expect subject
 '
 
@@ -1005,7 +1073,7 @@ check_author() {
 	git add file &&
 	GIT_AUTHOR_NAME=$1 git commit -m author-check &&
 	git format-patch --stdout -1 >patch &&
-	sed -n "/^From: /p; /^ /p; /^$/q" <patch >actual &&
+	sed -n "/^From: /p; /^ /p; /^Date:/q" <patch >actual &&
 	test_cmp expect actual
 }
 
-- 
2.21.0.1049.geb646f7864

