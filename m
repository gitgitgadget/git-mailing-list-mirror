Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E603C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 18:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376673AbhLBSnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376629AbhLBSnf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 13:43:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6FBC061758
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 10:40:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so3072578wme.0
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2TVRLSi+w77MBadJmLiDcs0AzkIYMxQckPgbd9BIQWs=;
        b=ebYRAAjDlTzziEyu3iigmBijg/4CApFZxOPbPupTbZOmD6Gc1pleTaAa/aDLGiI7Ox
         9ShTlNo2iSfGqaWQnsRHwyJESozkLIMCI0El/6KorubTKAyZJxtnd6lwDDuBYBxADy+S
         fJjEv3gyttY9kunClqLqCioise+piLdCspcFTMFNdTfghMR2/br1j85zffEm9MovzqW1
         +PntyzY2JX3v+mm2bg6dN/OUBZrKgjHgqJoOXlpBUrXnXQqdcdpGpzz/tCOxNkH1IdAJ
         WMwd9jSSWhtfyAhsUWR0++9Rbus0wsQ/ZAhSgyzfev4YYqPSdihYZfP8V1PgJ1VmYf6m
         dBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2TVRLSi+w77MBadJmLiDcs0AzkIYMxQckPgbd9BIQWs=;
        b=EXw7Q0Yv7czDTMWUMZF7JxRNBKB329sYSE4ce50yd2Z+03hkxyJ292WwsNuhsOLC7R
         aIok/7WVJd2Lq+h0Nnw7+0Hg0Ko8vbJgphafKtok5vOk0sxVuq3RetWhpvoaKsD2Tsgt
         HqEFNPNDKBNmcnmDoZ9a+8zYlhu8g95MvI60GDg4CSeLmORlkEyM5IgCHudOMNmMHLnx
         HOjMfaZwJh2mxtHn/Fw9+1nrKVutHYFponFM86RyOUDHUOMjgoGXmWGN9kU6c816eK0k
         S13mKr0ghUbon6DmpYRNBqco/SCa2GJRT3nnhXsE09rSA2FaqSRxlejBCx+X1IEENmWW
         HLhA==
X-Gm-Message-State: AOAM530wrCLqs5vOjsGsZ7YbFjhJ2dB0R5oOJs1u/ZiY4p/7Wn0KnDTb
        nt8iDSQeCQ9gzMlu8yvc11ihGUFXbAA=
X-Google-Smtp-Source: ABdhPJw29G85pzsIq4VA2l6yYABj4V9SYwaPrZBHIA4VUlb9SHBEjvZTKYgJhBCDHeGpiqn77HG64w==
X-Received: by 2002:a05:600c:354b:: with SMTP id i11mr8484231wmq.61.1638470409638;
        Thu, 02 Dec 2021 10:40:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm543887wrh.32.2021.12.02.10.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 10:40:09 -0800 (PST)
Message-Id: <d4f1d209468405a250c83ebc4fa9b50ad0bf9260.1638470403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
References: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 18:40:01 +0000
Subject: [PATCH v3 7/8] t1430: remove refs using test-tool
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

