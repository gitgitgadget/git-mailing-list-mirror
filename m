Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B19120357
	for <e@80x24.org>; Mon, 10 Jul 2017 21:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754875AbdGJV4l (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 17:56:41 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32827 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754864AbdGJV4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 17:56:37 -0400
Received: by mail-lf0-f66.google.com with SMTP id t72so12344317lff.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 14:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAqZ612AvTN8Ew0gScp45dnWNABlK3YHhIaRPlCmSvg=;
        b=dqNBX6/e2ZXKvbhn0/FzHb33Jkct+lz4U7nrFbXJS42aJHXKmnPXm+yaIdjt1rwBAx
         +2N4O61BEamHXHIU0JZqY7im/4bybYdlTG0X8rI7AVPm7NJMQx44GNPpv6QufHcJCSCc
         AZSdFmT8uirO0JJZgyay4yR4Fkj/UkkT9x0pck2/arqfbyonFRsngkxpDw/5L8iyr0Zo
         bmk/BtPfk6p0LWdyG8QP8KMNWCM8TTguP8L/X30lEF2rlojw0i1mCTaO+QXABQyuMKrN
         D6AsVT/Ez6nfwsqZG6iKp1JOw1sLSv+WbdlNBaKytOlSYe/0NcCLzxKxWQCK0GcHhb4g
         FugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAqZ612AvTN8Ew0gScp45dnWNABlK3YHhIaRPlCmSvg=;
        b=ockNQDYHlwDCObC1tPjUSL9lX/BW+KjJI29E3DnowVRRLCcO9cgdF7R5Zx3CgqNYVu
         wv/6+YHUjmqRfFNxZSV7GAczxR1iYPLKIyEfaPt2ypVIYN3CqUizy1EqfkYdlDVfyeOT
         vo9b8VVGGoO5hUhI8PnIwbSc+EzLEQOPFDvIX+S8OL/AFTvYr/BD3eGY1Gd9LX7yiBog
         EtesY2Ifb34Eanv4lcxvHpBMbob91q8aXf0IuMaY7OyA1ofyvl7pEkUPd1hnjCRDmSit
         ktVqBoSltgRBf9hzjX2U+asA1m+QwkDT/grWRq42lvhXrpmvET3L2DoaXSCH74QcU9w+
         JklA==
X-Gm-Message-State: AIVw112wYMJBCo54WRvISHDRhlaQuJVdXKBkj3VoCfOxXNKN8kRNFYIk
        R1HCwdOUvYWKLc35Zho=
X-Received: by 10.25.225.8 with SMTP id y8mr2030026lfg.34.1499723795894;
        Mon, 10 Jul 2017 14:56:35 -0700 (PDT)
Received: from localhost.localdomain (78-66-223-92-no2204.tbcn.telia.com. [78.66.223.92])
        by smtp.gmail.com with ESMTPSA id x13sm2617077ljd.64.2017.07.10.14.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 14:56:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH 7/7] tag: make git tag -l use pager by default
Date:   Mon, 10 Jul 2017 23:55:20 +0200
Message-Id: <e893a0b87b14143af6fc162d1acb21012523af69.1499723297.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.13.2.653.gfb5159d
In-Reply-To: <cover.1499723297.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch introduced `pager.tag.list`. Its default was to use
the value of `pager.tag` or, if that was also not set, to fall back to
"off".

Change that fallback value to "on". Let the default value for
`pager.tag` remain at "off". Update documentation and tests.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-tag.txt |  2 +-
 builtin/tag.c             |  2 +-
 t/t7006-pager.sh          | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 6ad5811a2..fbdfb3f59 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -103,7 +103,7 @@ as `--contains` is provided. See the documentation for each of those
 options for details.
 +
 When determining whether to use a pager, `pager.tag.list` is considered
-before `pager.tag`.
+before `pager.tag`. If neither is set, the default is to use a pager.
 See linkgit:git-config[1].
 
 --sort=<key>::
diff --git a/builtin/tag.c b/builtin/tag.c
index e96ef7d70..ec69fca61 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -447,7 +447,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
 	if (cmdmode == 'l')
-		setup_auto_pager("tag.list", 0);
+		setup_auto_pager("tag.list", 1);
 	setup_auto_pager("tag", 0);
 
 	if (keyid) {
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index ed34c6734..94df89a5f 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -134,22 +134,22 @@ test_expect_success TTY 'configuration can enable pager (from subdir)' '
 	}
 '
 
-test_expect_success TTY 'git tag -l defaults to not paging' '
+test_expect_success TTY 'git tag -l defaults to paging' '
 	rm -f paginated.out &&
 	test_terminal git tag -l &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 test_expect_success TTY 'git tag -l respects pager.tag' '
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag tag -l &&
-	test -e paginated.out
+	test_terminal git -c pager.tag=false tag -l &&
+	! test -e paginated.out
 '
 
 test_expect_success TTY 'git tag -l respects pager.tag.list' '
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag=false -c pager.tag.list tag -l &&
-	test -e paginated.out
+	test_terminal git -c pager.tag -c pager.tag.list=false tag -l &&
+	! test -e paginated.out
 '
 
 test_expect_success TTY 'git tag -l respects --no-pager' '
-- 
2.13.2.653.gfb5159d

