Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A58E1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeJFEzH (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:55:07 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:51072 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeJFEzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:55:06 -0400
Received: by mail-it1-f201.google.com with SMTP id h20-v6so3808122ita.0
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JG6Pc/YEzc5ZruoLsRmU1zApjgdFK9xQoJEhPbtHOLg=;
        b=Ny0LY3pUBn+LZvpZ0k6uB8uhn6YLd3B61E2noacmJcyIcqLzV/W4NxZChvXsLvX2oB
         NZuKz5J0kieY8AFN90xqxCEs06rxW3O9Vua1djA/dh+w7BYB4xm0G147YADdQQ6bjE2S
         KpSDGADwN9l2WJtVDGyFSBZi7qvR8ALqOHCm65V5LaxzncOAUjSnpEOs97OiwvLVN7xZ
         kzGf+8Kg/x3+HowabOK8JefrFHpSb1YJwnyrXJX3CHvWg2uCWr2rNhvA+5N4n7PfbhUM
         ieKvObq88bgbRppj7CO9laQ+G3zLRU/9KsTcId5wI4NxA17yFY9jdUj1iGJ0OUwtePkc
         iLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JG6Pc/YEzc5ZruoLsRmU1zApjgdFK9xQoJEhPbtHOLg=;
        b=DpOlJpiLmjyY1t+EzwWkTvnMU6PRoXwHyRwQaYIC+JJrSKtWRPE8ifx6qJPCnv4TLy
         Uaguyjn00zg7kA1RWbIfWe4ZJSRZUP19DwgMLDaK/LjeqJW9MgKYVjkZXV+QlQSF8Stf
         /0F2MAnyQihqtsL7Mj40jiFslqkqpkcn9pHdabeBz/4w8Kb708BwJDwEkhon+veZTpox
         gaNCzVdSTqvhRfM5w2QYZfunqfoQH/Cd6Bm3Hd6zA4+w7CWF0EHtmneHPXUxjYse1m31
         PJtRg8GgtfJG30PcHrhA80xkqGDEwDrak3fYu01QwP8fnpaFQHIJxXL/rt3boOG2ZNB8
         9MXg==
X-Gm-Message-State: ABuFfogBos/c9MXaRoAy2YkryD000zZuwAw6NSyKu0YTXmNCjRRdQdiP
        l3a1VE0+ZPFaZiG/chJ2GDVztFu72iHF3p+2yNUFRABl1RtXZDhhSY3pqA80zmbgYWp2jJdjPa+
        re2fP50MAtqzA4VWR4OKCGKNT7ArmCWEX93/VSe3rIPJ0a/pMrbJQM0dBsXg=
X-Google-Smtp-Source: ACcGV63LqNZ/d1QAwdW7fz/T6pyVeBd/0BhuOqUHg6EiTnM5gHgxVik8CWr+uy42THUtBEVFBQyD87rqmPip
X-Received: by 2002:a05:660c:310:: with SMTP id u16mr7519138itj.1.1538776467265;
 Fri, 05 Oct 2018 14:54:27 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:54:06 -0700
In-Reply-To: <cover.1538775186.git.matvore@google.com>
Message-Id: <a426aaa6c52aad3f28b4e20bb8dc81aaf898e18c.1538775186.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538775186.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v5 6/7] t9109: don't swallow Git errors upstream of pipes
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git ... | foo' will mask any errors or crashes in git, so split up such
pipes in this file.

One testcase uses several separate pipe sequences in a row which are
awkward to split up. Wrap the split-up pipe in a function so the
awkwardness is not repeated. Also change that testcase's surrounding
quotes from double to single to avoid premature string interpolation.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 t/t9101-git-svn-props.sh | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 8a5c8dc1a..c26c4b092 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -174,7 +174,8 @@ test_expect_success 'test create-ignore' "
 	cmp ./deeply/.gitignore create-ignore.expect &&
 	cmp ./deeply/nested/.gitignore create-ignore.expect &&
 	cmp ./deeply/nested/directory/.gitignore create-ignore.expect &&
-	git ls-files -s | grep gitignore | cmp - create-ignore-index.expect
+	git ls-files -s >ls_files_result &&
+	grep gitignore ls_files_result | cmp - create-ignore-index.expect
 	"
 
 cat >prop.expect <<\EOF
@@ -189,17 +190,21 @@ EOF
 # This test can be improved: since all the svn:ignore contain the same
 # pattern, it can pass even though the propget did not execute on the
 # right directory.
-test_expect_success 'test propget' "
-	git svn propget svn:ignore . | cmp - prop.expect &&
+test_expect_success 'test propget' '
+	test_propget () {
+		git svn propget $1 $2 >actual &&
+		cmp $3 actual
+	} &&
+	test_propget svn:ignore . prop.expect &&
 	cd deeply &&
-	git svn propget svn:ignore . | cmp - ../prop.expect &&
-	git svn propget svn:entry:committed-rev nested/directory/.keep \
-	  | cmp - ../prop2.expect &&
-	git svn propget svn:ignore .. | cmp - ../prop.expect &&
-	git svn propget svn:ignore nested/ | cmp - ../prop.expect &&
-	git svn propget svn:ignore ./nested | cmp - ../prop.expect &&
-	git svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
-	"
+	test_propget svn:ignore . ../prop.expect &&
+	test_propget svn:entry:committed-rev nested/directory/.keep \
+		../prop2.expect &&
+	test_propget svn:ignore .. ../prop.expect &&
+	test_propget svn:ignore nested/ ../prop.expect &&
+	test_propget svn:ignore ./nested ../prop.expect &&
+	test_propget svn:ignore .././deeply/nested ../prop.expect
+	'
 
 cat >prop.expect <<\EOF
 Properties on '.':
@@ -218,8 +223,11 @@ Properties on 'nested/directory/.keep':
 EOF
 
 test_expect_success 'test proplist' "
-	git svn proplist . | cmp - prop.expect &&
-	git svn proplist nested/directory/.keep | cmp - prop2.expect
+	git svn proplist . >actual &&
+	cmp prop.expect actual &&
+
+	git svn proplist nested/directory/.keep >actual &&
+	cmp prop2.expect actual
 	"
 
 test_done
-- 
2.19.0.605.g01d371f741-goog

