Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5C7C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358778AbhLFQO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389075AbhLFQNp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:13:45 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1611EC0D940A
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 07:56:08 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a9so23351528wrr.8
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 07:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2WvfLHDRn5PtUSv8R0fF8N/KMYsMG9QkL9V0gTjzwPo=;
        b=q5apoVE8X7L/Ig4RnqblGgD8dbcDUVetJPw+ntEd081/ftMCc9t+BBC1aPjTPX7uKz
         u6Nxj1nxq7y/xbuGNPYjqjVTV9AKmtxNBWFglu6PRo/sca+RYqLz2ytdxg0wQpvx9Zhf
         +Shbtk+qMzsEIs9CPh1NFMvhKILK2SJZmZiueOXwfK4XA9dSJz+QudVur6dkGLq9pERV
         HCd9WCcLbuOIwKVfIpOJnju53h+ZzLxLxbPxY0NfluqqjT2xmeyY7az2V36hAjo4HFuh
         23+qDqrSN8X17RrTjONTkuZqTFKgFSHa64DyP9X/hjrvoOfx0pE0KEWmvSrchUpBqN6s
         /WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2WvfLHDRn5PtUSv8R0fF8N/KMYsMG9QkL9V0gTjzwPo=;
        b=FVm/4cnYvikoq8rXiutV2pCtB45/f5GMVPTGbtOjmI+zYhVE9IOKaOAzAzX2JvnCqB
         a9NPL10a8bCOCQ1qPCsvd767gMZmtWJEu7OQsZdfw0hhM6wD5+YvI+iO0u5mj2hDxs0V
         JzwBYXFx/xGY6n5RtG/OMIF49cALe6mSxtfGhEiqMFCl26tlcUPZfzxHk+NrXzhZQ4Hn
         UMKS7rEP+gcXfONalF2f61valldECjBzGGIhcjHKldQb0WqWhQdj3RXFjq5KUSNz/efk
         uTdwceFdEYJhReDZzuU5TH3xSVJlifucwI7bXHmsRRXT2rIw1fQP3v/oLxpxT6jI3eEK
         2rHQ==
X-Gm-Message-State: AOAM530EEZ9xp6ZyaeDYJ+DSu12FFO7Pz3Y3sWwL6QEd/5R/Tr9mGa0a
        8hE5IU6FjX+ziqru808YwB8dwF7UMHA=
X-Google-Smtp-Source: ABdhPJzkxMzG6bZXaTUfHbsZocaJaoJuhXdMvn9b1LGB2w6BlapJ1qucWz7f3fP5hhaHK/TfO9vYyA==
X-Received: by 2002:a5d:52c2:: with SMTP id r2mr44863137wrv.548.1638806166611;
        Mon, 06 Dec 2021 07:56:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm13720364wmq.20.2021.12.06.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:56:06 -0800 (PST)
Message-Id: <2a1524a7e9ac267a550d5b88c02f853fe36fe08c.1638806161.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
References: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
        <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 15:55:59 +0000
Subject: [PATCH v6 5/7] diff: replace --staged with --cached in t1092 tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Replace uses of the synonym --staged in t1092 tests with --cached (which
is the real and preferred option). This will allow consistency in the new
tests to be added with the upcoming change to enable the sparse index for
diff.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 77e302a0ef3..203a594fa45 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -371,7 +371,7 @@ test_expect_success 'checkout and reset --hard' '
 	test_all_match git reset --hard update-folder2
 '
 
-test_expect_success 'diff --staged' '
+test_expect_success 'diff --cached' '
 	init_repos &&
 
 	write_script edit-contents <<-\EOF &&
@@ -380,10 +380,10 @@ test_expect_success 'diff --staged' '
 	run_on_all ../edit-contents &&
 
 	test_all_match git diff &&
-	test_all_match git diff --staged &&
+	test_all_match git diff --cached &&
 	test_all_match git add README.md &&
 	test_all_match git diff &&
-	test_all_match git diff --staged
+	test_all_match git diff --cached
 '
 
 # NEEDSWORK: sparse-checkout behaves differently from full-checkout when
@@ -400,8 +400,8 @@ test_expect_success 'diff with renames and conflicts' '
 		test_all_match git checkout rename-base &&
 		test_all_match git checkout $branch -- . &&
 		test_all_match git status --porcelain=v2 &&
-		test_all_match git diff --staged --no-renames &&
-		test_all_match git diff --staged --find-renames || return 1
+		test_all_match git diff --cached --no-renames &&
+		test_all_match git diff --cached --find-renames || return 1
 	done
 '
 
@@ -420,8 +420,8 @@ test_expect_success 'diff with directory/file conflicts' '
 		test_all_match git checkout $branch &&
 		test_all_match git checkout rename-base -- . &&
 		test_all_match git status --porcelain=v2 &&
-		test_all_match git diff --staged --no-renames &&
-		test_all_match git diff --staged --find-renames || return 1
+		test_all_match git diff --cached --no-renames &&
+		test_all_match git diff --cached --find-renames || return 1
 	done
 '
 
-- 
gitgitgadget

