Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1576DC33CB7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D09214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhfkyXH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgAaUQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55560 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgAaUQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so9337329wmj.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UAdG0lzNzfH3h6z/Xyok/D1JO6NRnig6jTHOWkD+ijY=;
        b=OhfkyXH/3cE4HOMrm31eyAuwF1XviWOce6aNKs596R1ztmOXM6NPW8jW7Ml4yeX+4/
         d13yQWf7zG9a19pc1PtDFmSmz58/6ZjiiliB8AFFL0J7gy2oIj8PoFGQID+/lYUdoMNe
         9szOs6bDYfcj6edmLUlBtBqLdBam5gFQq4xSUnDpzFfl0VnljZ2xrPbUw0fBTbVpzcGU
         yIi9lhdz06NwHsVZP2ksWz2por7UOOQqp+eqBNLoVrgKAxzVulV3JLFLWcc9N6BEKmsJ
         ucXXl0JzgvZrTSwscKSEZ0N/sYF6k9bAN1ih/eYpbo9Bo/Eu6enCT9N14H5JhvNy21At
         3JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UAdG0lzNzfH3h6z/Xyok/D1JO6NRnig6jTHOWkD+ijY=;
        b=BWpq+TzBEKY0c+caQboFScmufwhGfgy0ugMt08EZjQwAd1Rb6wTqdHMNerCdCBMkmV
         lXP1RTND7Llf7d6i7TvzJHwlATg8eMWBCN7exXuSTGAEWW+S+3UVqTNCtukN8qtx+Ajo
         m2VUiB4epVS6AeYWD8E9ZNvs0cHZf/e4fghtAmKc7GeQno1Hf9WGWOSUjxAYGdsdrBtb
         E4gFzKnq70hHueGfqqg0asdAKh9bMXBaEsYchCErHmUFrel3zxairG7zA6EntoNzq739
         GZ68/uzEySMwSy2nmHGJc0jmGU7T01MacXOHX+VIdJwMeKMV+ZRKSsxzld/qXWtuby55
         JFKQ==
X-Gm-Message-State: APjAAAVvxe5QUHX3qPJ/P2iTFxbANAvjZHe2cX2oPYHp+0xSOzT5vaw4
        DnvKzohigz4N0gX/9Bxirgh5igqD
X-Google-Smtp-Source: APXvYqzGfgvED4NGJfmbi7xh3/PvPg8py3xv67QIZ7RNsoQoQmzTT5KLDClAHzReycPV5MHlENnlUw==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr13103098wmi.45.1580501785803;
        Fri, 31 Jan 2020 12:16:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm12379382wrt.57.2020.01.31.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:25 -0800 (PST)
Message-Id: <54be8e89eb7ebad67ec18bfb871a13726f7c6769.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:13 +0000
Subject: [PATCH v4 13/15] sparse-checkout: escape all glob characters on write
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse-checkout patterns allow special globs according to
fnmatch(3). When writing cone-mode patterns for paths containing
these characters, they must be escaped.

Use is_glob_special() to check which characters must be escaped
this way, and add a path to the tests that contains all glob
characters at once. Note that ']' is not special, since the
initial bracket '[' is escaped.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          |  2 +-
 t/t1091-sparse-checkout-builtin.sh | 13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index facdb6bda7..7aeb384362 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -149,7 +149,7 @@ static char *escaped_pattern(char *pattern)
 	struct strbuf final = STRBUF_INIT;
 
 	while (*p) {
-		if (*p == '*' || *p == '\\')
+		if (is_glob_special(*p))
 			strbuf_addch(&final, '\\');
 
 		strbuf_addch(&final, *p);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 545e8d5ebe..37e9304ef3 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -381,20 +381,21 @@ test_expect_success 'pattern-checks: contained glob characters' '
 	done
 '
 
-test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
+test_expect_success BSLASHPSPEC 'pattern-checks: escaped characters' '
 	git clone repo escaped &&
 	TREEOID=$(git -C escaped rev-parse HEAD:folder1) &&
 	NEWTREE=$(git -C escaped mktree <<-EOF
 	$(git -C escaped ls-tree HEAD)
 	040000 tree $TREEOID	zbad\\dir
 	040000 tree $TREEOID	zdoes*exist
+	040000 tree $TREEOID	zglob[!a]?
 	EOF
 	) &&
 	COMMIT=$(git -C escaped commit-tree $NEWTREE -p HEAD) &&
 	git -C escaped reset --hard $COMMIT &&
-	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" zglob[!a]? &&
 	git -C escaped sparse-checkout init --cone &&
-	git -C escaped sparse-checkout set zbad\\dir/bogus "zdoes*not*exist" "zdoes*exist" &&
+	git -C escaped sparse-checkout set zbad\\dir/bogus "zdoes*not*exist" "zdoes*exist" "zglob[!a]?" &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
@@ -403,9 +404,10 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	/zbad\\dir/bogus/
 	/zdoes\*exist/
 	/zdoes\*not\*exist/
+	/zglob\[!a]\?/
 	EOF
 	test_cmp expect escaped/.git/info/sparse-checkout &&
-	check_read_tree_errors escaped "a zbad\\dir zdoes*exist" &&
+	check_read_tree_errors escaped "a zbad\\dir zdoes*exist zglob[!a]?" &&
 	git -C escaped ls-tree -d --name-only HEAD >list-expect &&
 	git -C escaped sparse-checkout set --stdin <list-expect &&
 	cat >expect <<-\EOF &&
@@ -416,9 +418,10 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	/folder2/
 	/zbad\\dir/
 	/zdoes\*exist/
+	/zglob\[!a]\?/
 	EOF
 	test_cmp expect escaped/.git/info/sparse-checkout &&
-	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" zglob[!a]? &&
 	git -C escaped sparse-checkout list >list-actual &&
 	test_cmp list-expect list-actual
 '
-- 
gitgitgadget

