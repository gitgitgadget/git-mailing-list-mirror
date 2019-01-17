Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4211F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAQNGx (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:06:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33568 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfAQNGx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:06:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so4746287plo.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eryAPEwHea4LEBscyEKUuGEIBu8IMFY2cb/zjCWn88=;
        b=EKpXRD+OCnAGjVaWQYJAuvO+Wp0m8WucMqVfNIk6EUXxrZ31L816VxoV0d/7WFsB5K
         TjyMIw8dq8EAJxgcoiXtwiX5C8f/AjsxB1llWTnll+ZBtrU4Cd+TAn0Cd1QKbohSfR6j
         hHSZgmj5TdPkZyITsNUFckFEsqd8fg5xJWoovDfE4X9CKzl+1WsZZmOu9JzZOr8nG2oW
         mcsTzpWT/9GzKtdzAur0cX5MBZ5eM7w+65D32QyQzcNMuuC5c0U95iNJjq9O/O8L+9F8
         Q37d2JZ3b1ljWSnZuLtUxSfSxZatgIuOMOwWatseIGWqKhN5bq6T7Qh89sfw60RGS0Ge
         fdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eryAPEwHea4LEBscyEKUuGEIBu8IMFY2cb/zjCWn88=;
        b=jCMZywI5GG9dzt6JSwEQAH0TTYKxblVxV/q2GsshpbAo9U9xwDfLzkxjqoBvadwXub
         RA6hPcOKjFdkkH5msCk7zh1YDlNECC5v+Ii2mzw/f5M6aNzNLTrt37Cv10dh8um1imzv
         w0hqrK1lVd2yyWQesmuRLGanKckUdBxps2vmlCpeu3BD6HrqjuY+1J79z1JyOU8V3Czo
         NG67OIm6Ye2witRgLUUys+D+mUb51rgF+Q1L/KaS1UoWaI8l1UGrmhfCQtGcNlmF7Kcg
         hbRVs9QpMmTJwzhqEjgDRcMUfb5iLtWzq3EBj5SrRl0imr49QFJRNMIzklYc0jtASmWQ
         2r0Q==
X-Gm-Message-State: AJcUukehGFVK+OZIF+fk8yNLTTqY83X9wL+5tfKavH+u58O9dMp5zNLI
        kovPqMn5oo3+cqcgYyoT1fiX47Sg
X-Google-Smtp-Source: ALg8bN46NLeEdV+s3upXNzRe8tunHDoz6OQYSENfEGpvWNV+FceyYWmjoDOgjFfwlu8qEyvYPR6MUg==
X-Received: by 2002:a17:902:30a3:: with SMTP id v32mr15057901plb.26.1547730412908;
        Thu, 17 Jan 2019 05:06:52 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id z9sm6948713pfd.99.2019.01.17.05.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:06:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:06:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/76] parse-options: disable option abbreviation with PARSE_OPT_KEEP_UNKNOWN
Date:   Thu, 17 Jan 2019 20:05:03 +0700
Message-Id: <20190117130615.18732-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse-options can unambiguously find an abbreviation only if it sees
all available options. This is usually the case when you use
parse_options(). But there are other callers like blame or shortlog
which uses parse_options_start() in combination with a custom option
parser, like rev-list. parse-options cannot see all options in this
case and will get abbrev detection wrong. Disable it.

t7800 needs update because --symlink no longer expands to --symlinks
and will be passed down to git-diff, which will not recognize it. I
still think this is the correct thing to do. But if --symlink has been
actually used in the wild, we would just add an option alias for it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c     | 3 ++-
 t/t7800-difftool.sh | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 678b263897..9710ec9d5e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -266,7 +266,8 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 		}
 		if (!rest) {
 			/* abbreviated? */
-			if (!strncmp(long_name, arg, arg_end - arg)) {
+			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
+			    !strncmp(long_name, arg, arg_end - arg)) {
 is_abbreviated:
 				if (abbrev_option) {
 					/*
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 22b9199d59..bb9a7f4ff9 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -546,7 +546,7 @@ do
 done >actual
 EOF
 
-test_expect_success SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
+test_expect_success SYMLINKS 'difftool --dir-diff --symlinks without unstaged changes' '
 	cat >expect <<-EOF &&
 	file
 	$PWD/file
@@ -555,7 +555,7 @@ test_expect_success SYMLINKS 'difftool --dir-diff --symlink without unstaged cha
 	sub/sub
 	$PWD/sub/sub
 	EOF
-	git difftool --dir-diff --symlink \
+	git difftool --dir-diff --symlinks \
 		--extcmd "./.git/CHECK_SYMLINKS" branch HEAD &&
 	test_cmp expect actual
 '
-- 
2.20.0.482.g66447595a7

