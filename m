Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D7E1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 18:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfJHSrw (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 14:47:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45918 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHSrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 14:47:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so17758137qkb.12
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41QD51sbPms/wnXAZz8QeCa8oVjUDB1cpDbJPJjUarY=;
        b=OlH+PZZBbViHrz/wpVXb/k4XC5pvJfsL9fuCiqKkYBQScr1D0qqwkcrOFLKE6/jZ0Q
         9IR2Wk/xAeOSjIzKtjKrORMCZndEVzvvmcIuVBKky88GkhHrd+4f4jy7PwMeMqCKQGp4
         OB0xwE6SMRKGtme4yvJ8M/oWPEJhsawMWyty+y7i1QZZFAwZi00AuyZH5RedjyQcNBF7
         wDjp+1jmMJLOCTLkCtzPqe2MYBotCkTyxOP73dDEKFCQOtRHt7pRB+TCQL5bAyMmgowT
         ljd4lehSqKeuLl9AOb5TxVcl/Sa2Ey78Se6I+iBajqrEMRkPiLOUB8dxofTN3UmE2UIR
         6Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41QD51sbPms/wnXAZz8QeCa8oVjUDB1cpDbJPJjUarY=;
        b=PKt5NCqXf0MZlCr1l4T80Jpp/IFDPDUOcepOsu0kekyIaRPE8wY5kmqOXCIaBdQk8o
         FzMKRd2WJ7e6EL+fdvcNti8C9TLb6Sy7E7yRMSs3nglcvebGg+1O7LGO2gcWMV51dcmB
         TAk6xnfRdHmPIsjQcmzVi7qujUoYF72HmMg95Q94eVOIQLFm6Isp4Hs+uIcvG5PULZIL
         ZlVzIipzuVG2xEg0ScJN4nopfbDBrH9bgHHrwv87op65YstDEsJZZ+YdcGaATtt6GzCh
         CI1TLgVd5NageCC76BDSqmkmbXpmzSLY/xOQaNcm8FVhlFcUykV6baXNTdX3+QZiolJz
         t57g==
X-Gm-Message-State: APjAAAWAYC3AVR9DJlj8ayFyxqPMaMQzb/gi4ZW13EjDFPNm1z6qEyub
        i0r16WOY/96F5c+1B2SxOnyTYa3+
X-Google-Smtp-Source: APXvYqyOlcdm3A7/SNocjxsH+QK1fLib+49X4H/vIY3TWXzRS3haj8oeNhZgJUSyhqglcIi6uDKQKQ==
X-Received: by 2002:a37:6747:: with SMTP id b68mr30570583qkc.155.1570560470742;
        Tue, 08 Oct 2019 11:47:50 -0700 (PDT)
Received: from wall-e.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s16sm8185118qkg.40.2019.10.08.11.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 11:47:50 -0700 (PDT)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     git@vger.kernel.org
Cc:     kernel-usp@googlegroups.com, rcdailey.lists@gmail.com,
        me@ttaylorr.com, peff@peff.net, matheus.bernardino@usp.br,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.dcf@gmail.com>
Subject: [RFC WIP PATCH 3/3] tag: add full support for --edit and --no-edit
Date:   Tue,  8 Oct 2019 15:47:27 -0300
Message-Id: <20191008184727.14337-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
References: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git tag --edit and --no-edit flags are not currently fully supported.
This patch fixes the functionality that allows the editor to be opened
on demand.

Co-authored-by: Bárbara Fernandes <barbara.dcf@gmail.com>
Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Bárbara Fernandes <barbara.dcf@gmail.com>
---
 builtin/tag.c  | 16 +++++++++++++---
 t/t7004-tag.sh |  4 ++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 0322bdbdfb..7dff61d45a 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -230,6 +230,7 @@ static int build_tag_object(struct strbuf *buf, int sign, struct object_id *resu
 struct create_tag_options {
 	unsigned int message_given:1;
 	unsigned int use_editor:1;
+	unsigned int force_editor:1;
 	unsigned int sign;
 	enum {
 		CLEANUP_NONE,
@@ -307,13 +308,21 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 		    tag,
 		    git_committer_info(IDENT_STRICT));
 
-	if (!opt->message_given || opt->use_editor) {
+	if (opt->force_editor && !opt->message_given && is_null_oid(prev) &&
+	    !opt->use_editor) {
+		die(_("no tag message?"));
+	} else if ((!opt->force_editor && !opt->message_given && is_null_oid(prev))
+		  || (opt->force_editor && opt->use_editor)) {
+		/* Editor must be opened */
 		prepare_tag_template(buf, opt, prev, path, tag);
 		if (launch_editor(path, buf, NULL)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
 		}
+	} else if (!opt->message_given) {
+		/* Tag already exists and user doesn't want to change it */
+		strbuf_addstr(buf, get_tag_body(prev, NULL));
 	}
 
 	if (opt->cleanup_mode != CLEANUP_NONE)
@@ -436,7 +445,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	struct ref_format format = REF_FORMAT_INIT;
 	int icase = 0;
-	int edit_flag = 0;
+	int edit_flag = -1;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -592,7 +601,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("tag '%s' already exists"), tag);
 
 	opt.message_given = msg.given || msgfile;
-	opt.use_editor = edit_flag;
+	opt.force_editor = edit_flag >= 0;
+	opt.use_editor = opt.force_editor ? edit_flag : 0;
 
 	if (!cleanup_arg || !strcmp(cleanup_arg, "strip"))
 		opt.cleanup_mode = CLEANUP_ALL;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 80eb13d94e..bf43d2c750 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1313,7 +1313,7 @@ test_expect_success GPG,RFC1991 \
 	'reediting a signed tag body omits signature' '
 	echo "rfc1991" >gpghome/gpg.conf &&
 	echo "RFC1991 signed tag" >expect &&
-	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
+	GIT_EDITOR=./fakeeditor git tag -f --edit -s rfc1991-signed-tag $commit &&
 	test_cmp expect actual
 '
 
@@ -1356,7 +1356,7 @@ test_expect_success GPG,RFC1991 \
 test_expect_success GPG,RFC1991 \
 	'reediting a signed tag body omits signature' '
 	echo "RFC1991 signed tag" >expect &&
-	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
+	GIT_EDITOR=./fakeeditor git tag -f --edit -s rfc1991-signed-tag $commit &&
 	test_cmp expect actual
 '
 
-- 
2.23.0

