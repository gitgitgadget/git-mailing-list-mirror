Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF04DC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 13:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhLGNmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbhLGNl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 08:41:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93749C061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 05:38:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q3so29522749wru.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 05:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2TVRLSi+w77MBadJmLiDcs0AzkIYMxQckPgbd9BIQWs=;
        b=QqxswQu75HubnbcXF/bUQAgJgU5SbgOQgeqIqZ6HLu93RP66Ec+2zsJrEspF7KJ7lc
         etphHtDG9ftYnld06wUEmP5PbjxYLn0Td/LFJKhauUlAIARg86lf7q1JT6AhiwJu631h
         AU/+KueUXozRlJPBazVL84cpWYGU2CosF5fytYhJV1lMXxG+24A6mlVAt7vY+Rh1vu+W
         FZJMHS3ZcaEMM+IFMFvfCDNUSXlCd/i32ROIvSBz9Rldz2nwKoVY5NfMPZ9ZNV5qalbb
         4Kg1ITpZkUgT0aXvBstMkl4zJKsCjfW3NBTgxYzRribDb2wojyBlFzGxOqwxKWOlF9ZY
         nUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2TVRLSi+w77MBadJmLiDcs0AzkIYMxQckPgbd9BIQWs=;
        b=RbxjoNifW0VZxACY2BvwDOL/7DQzaQUQmjPZSPrIg5emi6/+DmsLh34jqcn2+Jjh6C
         DUO92+gN4rfTOkXz3KI6C86pgFf9GwomjbKevXhwNsBrxYwNZaLe19NFO8cEz0VuyX5P
         uDArlKqDSoO1xeu4F4329reh8qi4T8LV/Yxwrz4FcAFSVd1DazNyvbon2EkaOuIbH9mM
         KG9wXYCIvOtnvzJdxJtDdgkDckDyAadmsflTqwXI4wMt1g7RGMdR6PUoYLueBFWeM2nV
         mXo6tx0LyvClByX5zCHU3FwrYzbA98smE7R487UI0gGbn7GtOq6/n1HKd8wDdmAKcH5J
         GwXg==
X-Gm-Message-State: AOAM531h4l0XHVE8KIuo10sVmgtqEoMDdfG2IcmH6fgYW4EKlOLudUVu
        DL74fiZ6aQ9lnqrkUQu/kgKoiA5jcdA=
X-Google-Smtp-Source: ABdhPJyB9cfFfAjs49aSQej8TWWa77ER/EX+M1PAhtI7GXOdSQMV+rcu6Xo0TFPHf5jm4z3cmojMWA==
X-Received: by 2002:adf:e484:: with SMTP id i4mr52785151wrm.49.1638884307077;
        Tue, 07 Dec 2021 05:38:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12sm14444197wrn.73.2021.12.07.05.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:38:26 -0800 (PST)
Message-Id: <d85cfa3fee1d6f38f34916d2429d45701ad450b3.1638884300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
        <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 13:38:19 +0000
Subject: [PATCH v4 7/8] t1430: remove refs using test-tool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1430-bad-ref-name.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 326e5bd5e80..84e912777c5 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -154,7 +154,7 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	git branch shadow one &&
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
-	test_when_finished "rm -f .git/refs/tags/shadow" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
 	test_cmp expect actual &&
@@ -165,9 +165,9 @@ test_expect_success 'for-each-ref emits warnings for broken names' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
-	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
 	git for-each-ref >output 2>error &&
 	! grep -e "broken\.\.\.ref" output &&
 	! grep -e "badname" output &&
@@ -204,7 +204,7 @@ test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
 
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
 	test_must_be_empty output &&
@@ -216,7 +216,7 @@ test_expect_success 'branch -d can delete symref to broken name' '
 
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
 	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
@@ -225,7 +225,7 @@ test_expect_success 'branch -d can delete symref to broken name' '
 
 test_expect_success 'update-ref --no-deref -d can delete dangling symref to broken name' '
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
 	test_must_be_empty output &&
@@ -234,7 +234,7 @@ test_expect_success 'update-ref --no-deref -d can delete dangling symref to brok
 
 test_expect_success 'branch -d can delete dangling symref to broken name' '
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
 	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
@@ -246,7 +246,7 @@ test_expect_success 'update-ref -d can delete broken name through symref' '
 
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git update-ref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...ref &&
 	test_must_be_empty output &&
@@ -255,7 +255,7 @@ test_expect_success 'update-ref -d can delete broken name through symref' '
 
 test_expect_success 'update-ref --no-deref -d can delete symref with broken name' '
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
-	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
 	test_must_be_empty output &&
@@ -264,7 +264,7 @@ test_expect_success 'update-ref --no-deref -d can delete symref with broken name
 
 test_expect_success 'branch -d can delete symref with broken name' '
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
-	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
 	git branch -d broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
 	test_i18ngrep "Deleted branch broken...symref (was refs/heads/main)" output &&
@@ -273,7 +273,7 @@ test_expect_success 'branch -d can delete symref with broken name' '
 
 test_expect_success 'update-ref --no-deref -d can delete dangling symref with broken name' '
 	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
-	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
 	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
 	test_must_be_empty output &&
@@ -282,7 +282,7 @@ test_expect_success 'update-ref --no-deref -d can delete dangling symref with br
 
 test_expect_success 'branch -d can delete dangling symref with broken name' '
 	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
-	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
 	git branch -d broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
 	test_i18ngrep "Deleted branch broken...symref (was refs/heads/idonotexist)" output &&
-- 
gitgitgadget

