Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF3220229
	for <e@80x24.org>; Mon, 24 Oct 2016 10:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757272AbcJXKmw (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 06:42:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34156 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755006AbcJXKmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 06:42:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id 128so16286713pfz.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ossgBmxrytxSZVoNTE6FgRTJArCWZl6+wnLsbVHdak=;
        b=BUwI5F00UwfMf7t1BMdV3Vj+FKOF0QsWm+rNFhPXdzbfaUJUVaZEuEEOyjSmbqJAAk
         5VBuNGDli6TeUak90psX/UD9A9lnNgzN/aTjQTSmPhnpIOF5lmTk+vQDDx935h9UDeYx
         PyGJ5MoL9mk91U9XNGyGPgG11zUycdfVwSK8bSt0oSQ6cTj6rY+e/gBovM4lF3BnNX7l
         bv5gmwLwKSWb1OSeWAQw77X4r7SfeyCujRXVCcTC3LA2FQOZuCVaMNEgHmWWA8Sx8vEP
         OR2sL7Wi1dzK1WgeaRjQ++EqmCoeV7O3u3NryXJf6yi8MLf9BMoK/vxaAczDp1+Oc2fx
         x94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ossgBmxrytxSZVoNTE6FgRTJArCWZl6+wnLsbVHdak=;
        b=WFQH2L+mPZcZ9+LXs5hdYC1H4ZytS2BN1DRQfKytcIHVXzJctC4Apvt7eW+PpeKBpO
         y2YvvZFy0ykvdu4DYBb/Ff7nD6KQxZE2pdNG5+XNHEp44vegs4vhAG3lNROFMWe9w2yQ
         ploU6EfADxW0Td02TxzrjqN6je56jOQiBABG5OuGv8CqjTImq7t+gW28PVkwTHYY7Pj9
         0EW4V4XqECf/9QNxyunFhc2jRqKWcX2zXh4DlmNDLsBzgBfaA6XkziLoW/8dRX71i+Zq
         H3nUQKlXhWXinKZKcKbePaOwGIU1YqDFDHUOBrU+xFuGlkPCmTrtlp37A+jpIb9osGw/
         7wSg==
X-Gm-Message-State: ABUngveq9D8zGFAUzR8F9DIOn37ku3Mk3RAR6ZSXipYt+7aaMMFW2zpb2Z+r2RstJtvdjQ==
X-Received: by 10.99.141.193 with SMTP id z184mr7606581pgd.23.1477305768388;
        Mon, 24 Oct 2016 03:42:48 -0700 (PDT)
Received: from ash ([115.73.162.90])
        by smtp.gmail.com with ESMTPSA id r77sm24302877pfa.85.2016.10.24.03.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Oct 2016 03:42:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Oct 2016 17:42:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/4] commit: don't be fooled by ita entries when creating initial commit
Date:   Mon, 24 Oct 2016 17:42:22 +0700
Message-Id: <20161024104222.31128-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161024104222.31128-1-pclouds@gmail.com>
References: <20160928114348.1470-1-pclouds@gmail.com>
 <20161024104222.31128-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ita entries are dropped at tree generation phase. If the entire index
consists of just ita entries, the result would be a a commit with no
entries, which should be caught unless --allow-empty is specified. The
test "!!active_nr" is not sufficient to catch this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/commit.c      | 11 ++++++++---
 t/t2203-add-intent.sh | 10 ++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fe8694d..42732ba 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -894,9 +894,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (amend)
 			parent = "HEAD^1";
 
-		if (get_sha1(parent, sha1))
-			commitable = !!active_nr;
-		else {
+		if (get_sha1(parent, sha1)) {
+			int i, ita_nr = 0;
+
+			for (i = 0; i < active_nr; i++)
+				if (ce_intent_to_add(active_cache[i]))
+					ita_nr++;
+			commitable = active_nr - ita_nr > 0;
+		} else {
 			/*
 			 * Unless the user did explicitly request a submodule
 			 * ignore mode by passing a command line option we do
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 8652a96..84a9028 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -129,6 +129,16 @@ test_expect_success 'cache-tree does skip dir that becomes empty' '
 	)
 '
 
+test_expect_success 'commit: ita entries ignored in empty intial commit check' '
+	git init empty-intial-commit &&
+	(
+		cd empty-intial-commit &&
+		: >one &&
+		git add -N one &&
+		test_must_fail git commit -m nothing-new-here
+	)
+'
+
 test_expect_success 'commit: ita entries ignored in empty commit check' '
 	git init empty-subsequent-commit &&
 	(
-- 
2.8.2.524.g6ff3d78

