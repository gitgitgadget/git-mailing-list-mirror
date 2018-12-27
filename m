Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C243C211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeL0QZx (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:25:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36154 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeL0QZw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:25:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so13003402lfg.3
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YFAFRg5e9ZHwBpKf9D2cHuV0LCnydBqKdfnG0tQI5FY=;
        b=OmdXkIeEBQbKRzdLhs08czs/K7ao0QNJR/p4b80d++oDVbg4qedoFxYqTZu/EbAUBz
         J6Q8Xx/ErmIw+fUJ47UYIlKVFmaPhRvT56My76r/UJVCazH3YO8pqGxT6p1b5e/ZUty5
         yhxT9zrY8kdQJ56T6/YKmAHyNpBdaK7H2mpFNKJUnNRCHhHG2CzYhTw2LmwOPNVDqSMM
         W9gZ8iB8+u5p1eRYZo/Y4b1sUEkNbeE1MCMIi5fQNEBXwiXQuhL3dH3eLK/sJdRpNLwQ
         CNhBR6hfJghymsgfqUHsi//xJhNAoQ/Ou02djLOMLB7J38uIYnyLVsKcRReH6qrnPnqf
         HvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFAFRg5e9ZHwBpKf9D2cHuV0LCnydBqKdfnG0tQI5FY=;
        b=YUczON3yndeeoEAZaKG1RLiAv6fvgMbzqZnKNWAOo0YxBwkxbZN7DIxtB/LKYNdgEq
         /pCPozGf8aAd5L7H8BnP1+uP2L9Y3Qcu0i7dxQpVQ8XaaZBa3h5rGurDE3tL1Oain2if
         Ze5DwqrU1HpWU66lsaTeOQQM1M1pRsrb8jgltun10LmhHrGAvj3iPx3VzTfHnh0Kd9PS
         lw3ZaZlkg6Yg113IB/X+Nn5HWRNWnkaZ7XNV6/vBNnDKDY3kwdvzkVVwe8FEF/1EBv72
         vQFmlLV9NHW0FOttou8yr4VaSpQMsXTb9oUT8CfZurRkuwdsXFFLRz5otpXnXpIiHPwi
         +CNg==
X-Gm-Message-State: AA+aEWahBNnahNmfV/e+BFsF8PljpClq3EknnqZjlXQfV8STgM6pRz6M
        dfVygIbhp3HIRAxaCzes3nkVmW7R
X-Google-Smtp-Source: AFSGD/WVk1M6jISDlc0Zrpbkp+98FrIcd8LC+MwfZXaRrUDVdVhpMJMl1j8LODALiFsq361HiGUjQQ==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr11888913lfk.151.1545927949945;
        Thu, 27 Dec 2018 08:25:49 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:49 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/75] parse-options: disable option abbreviation with PARSE_OPT_KEEP_UNKNOWN
Date:   Thu, 27 Dec 2018 17:25:25 +0100
Message-Id: <20181227162536.15895-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
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
index 4cbcefc262..81e66b9374 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -265,7 +265,8 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
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

