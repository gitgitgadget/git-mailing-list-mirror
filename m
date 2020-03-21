Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9BCC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90A520777
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/vYy+Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgCUSA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:27 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:33301 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgCUSAX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:23 -0400
Received: by mail-ed1-f52.google.com with SMTP id z65so11175280ede.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M+bkCOiGrLNAdoq4wyvFYkIGgvPCiozC9xG3Hu1yz3I=;
        b=B/vYy+KelW5iLejYPdKy5inbUsNLwfGDTckof4gEKpmSM1Adw9JCodYqufi/9pEqhY
         0BaNqZ7dE3C3Xxckl3/llgPtb26laIK2l+FVhxpxaec/N/pdX3lIEGyEup2eLvIDF7Z/
         aIEUPc8p6u0bV2SPYskbMZFuNV7siVWVYbo89qoKL8xZxw9Glp5SOGJtEROch1enzbgm
         ED9374CF+4yY/uJeDl6O9Y6ugcLFFRd0zNmcXCFWDSBqRYFLN1OYg1ZVIrmmu4Y5DxqG
         RyvVQ/PvYKR8DPRcYKlihKUlnyxKWrlY80lbAvp+zLiLWYdl1S7SaeJAP4gRSwH0Dyge
         On/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M+bkCOiGrLNAdoq4wyvFYkIGgvPCiozC9xG3Hu1yz3I=;
        b=tY4fK6GsPmpXCKZIfukTYQ6cx5WKvNKeeAxjFATnXp2uKp3xx7k9sbnFmIIxOEmWdB
         +1PTa5ymI5K/CnjedIinKypmUH312hj42XPJw0xhJ0IOux6mDV4JQHRmMNXk3DrD2ZA4
         +LiBELJRQzqqRkVXlWye7/a8SXcRDEVGl6KZRHxnlWV45G/RCv/myJI0EkllVQx6ovMS
         b1mAoapFGgA8NkTYz79lRo7A4Q1qQxkWc/z/RIeegpFXDNKNHNFN/wpaZwKLOyZ+7z2o
         E55+ULOBfHGOCIeNaW8Tc/MhpNWAk1HxgIXLheM+MSBlb1exr6/AanGnt2gJtXuqE5R/
         920A==
X-Gm-Message-State: ANhLgQ1Kq64baL7+MOORhKa9mgpqoPBXOKzSsmniNddYbPFs4eK6O20h
        Urlm8KN/N3uPmtg5b+h1Yv9aHqP/
X-Google-Smtp-Source: ADFU+vu5SjpRUL7ponKQu0HmfdUR6JZfTFKnmQnd8fw1M2hcjG0uXNzUj318Tb5yrKQ8j6Zie6J6Cg==
X-Received: by 2002:a17:906:3b0e:: with SMTP id g14mr2777886ejf.289.1584813621533;
        Sat, 21 Mar 2020 11:00:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm661681edp.58.2020.03.21.11.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:21 -0700 (PDT)
Message-Id: <02a8e01f35b7864dbeccd76e2969397b1a84d29a.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 18:00:06 +0000
Subject: [PATCH v2 15/18] unpack-trees: make sparse path messages sound like
 warnings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The messages for problems with sparse paths are phrased as errors that
cause the operation to abort, even though we are not making the
operation abort.  Reword the messages to make sense in their new
context.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 8 ++++----
 unpack-trees.c                     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 0d93d3983e0..11eb567f3fb 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -288,7 +288,7 @@ test_expect_success 'not-up-to-date does not block rest of sparsification' '
 
 	git -C repo sparse-checkout set deep/deeper1 2>err &&
 
-	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_i18ngrep "The following paths are not up to date" err &&
 	test_cmp expect repo/.git/info/sparse-checkout &&
 	check_files repo/deep a deeper1 deeper2 &&
 	check_files repo/deep/deeper1 a deepest &&
@@ -328,13 +328,13 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	echo dirty >dirty/folder1/a &&
 
 	git -C dirty sparse-checkout init 2>err &&
-	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
+	test_i18ngrep "warning.*The following paths are not up to date" err &&
 
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
-	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
+	test_i18ngrep "warning.*The following paths are not up to date" err &&
 
 	git -C dirty sparse-checkout disable &&
-	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
+	test_i18ngrep "warning.*The following paths are not up to date" err &&
 
 	git -C dirty reset --hard &&
 	git -C dirty sparse-checkout init &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 9ee04992ac6..7c24933016b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -50,10 +50,10 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	"",
 
 	/* WARNING_SPARSE_NOT_UPTODATE_FILE */
-	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+	"Path '%s' not uptodate; will not remove from working tree.",
 
 	/* WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN */
-	"Working tree file '%s' would be overwritten by sparse checkout update.",
+	"Path '%s' already present; will not overwrite with sparse update.",
 };
 
 #define ERRORMSG(o,type) \
@@ -172,9 +172,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		_("Cannot update submodule:\n%s");
 
 	msgs[WARNING_SPARSE_NOT_UPTODATE_FILE] =
-		_("Cannot update sparse checkout: the following entries are not up to date:\n%s");
+		_("The following paths are not up to date and were left despite sparse patterns:\n%s");
 	msgs[WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN] =
-		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
+		_("The following paths were already present and thus not updated despite sparse patterns:\n%s");
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
-- 
gitgitgadget

