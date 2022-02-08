Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7464C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387578AbiBHWZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386334AbiBHUJu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 15:09:50 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648B6C0612C0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 12:09:49 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso1369750wmi.0
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=53UCkH8yeSwITRvUoTGg6vH7r7CEFF2W1pSrTYmMFPg=;
        b=c5loMF6DTYCKz9SMNwbKJfQS6tuo0XX/Eeyvxkt8VI7wze9k+Bejl2G72Iu0rqqNYq
         4wj+vSUg+ueviJkCM72VSOMiX5d89qDSzg1tWhBQZ62BoD/NgQm5FWXWtgkpvAWThQuW
         yZpLSbDOpMKT0pCXQy8eLzAfdggkcOvoBZUsxdRL6i6oBgHOgrooTQ7xva+s0QRDJ+WY
         c86NSrfsSWbKMsyAXmJ2kgIa+RRu0F/8SIt4x+rzd/b4b9pGA+yktidUOfG0lyqP5fXQ
         at5inKzWlKsmd02ofFXrUwwZxm5NdomxKQ8S1VU9PyIJqn9RkvObdJL1jFYGkJU4J9vf
         HiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=53UCkH8yeSwITRvUoTGg6vH7r7CEFF2W1pSrTYmMFPg=;
        b=tm5M+JzLgl1M381VacAHkQF7kP+yzX36wkm633Sr5dmPdFc/1tCONBIlxCPdjqhQvv
         Xrf1LZ/XkpmqjGQNXsPeiFmTvCuqRnS+9hr/wg9QQZH49/YMw+yREmHvwyYdRhXGQAmc
         aKaWY4/wcfeLpvexpj1wRYef0z7hfth6czibOY/au2HHRCNjSJ3NMxNTuPXLduigSFrn
         A7Mml5qH5RKtTzKFOGfqQVObgDO1CEAw0ELdDwzcBm5QYrDeV6tk1k4lgiEOj+7ydij4
         uI1PwsRZeaDH3IZ++PKBnxDpID3RC84mU7EU12TmLfN5ARuUeKdmwQCgsuaeaF1Q51O2
         E6hA==
X-Gm-Message-State: AOAM532jPnzVHaqiHrqm/TkgwKr29HmmTfNqM8UqAbaPNXv8br17z8Di
        +lg1BnmLBhscuuisQNuibnxXgNmSTVM=
X-Google-Smtp-Source: ABdhPJxK7X5qB5qAP2CCgFM59MHwFFqnYg9ZtXCjDsQUk1thEqUq7CdslPDN2s9eUZ7++k45jjQgrA==
X-Received: by 2002:a05:600c:686:: with SMTP id a6mr2322975wmn.161.1644350987617;
        Tue, 08 Feb 2022 12:09:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd25sm3072874wmb.6.2022.02.08.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:09:46 -0800 (PST)
Message-Id: <fc1bd0621085f331b804c83df7a03cb1d4872fcd.1644350985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1214.git.git.1644350985.gitgitgadget@gmail.com>
References: <pull.1214.git.git.1644350985.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 20:09:44 +0000
Subject: [PATCH 1/2] t3420: prepare for reftable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Check for autostash existence using rev-parse; remove the autostash
using test-tool.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t3420-rebase-autostash.sh | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 43fcb68f27e..e6466290e03 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -79,7 +79,7 @@ create_expected_failure_merge () {
 
 testrebase () {
 	type=$1
-	dotest=$2
+	test_type=$2
 
 	test_expect_success "rebase$type: dirty worktree, --no-autostash" '
 		test_config rebase.autostash true &&
@@ -133,9 +133,10 @@ testrebase () {
 		test_when_finished git branch -D rebased-feature-branch &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
-		test_path_is_file $dotest/autostash &&
+		git rev-parse $test_type/autostash &&
 		test_path_is_missing file3 &&
-		rm -rf $dotest &&
+		test-tool ref-store main delete-refs REF_SKIP_REFNAME_VERIFICATION msg $test_type/autostash &&
+		rm -rf .git/$test_type &&
 		git reset --hard &&
 		git checkout feature-branch
 	'
@@ -147,12 +148,12 @@ testrebase () {
 		test_when_finished git branch -D rebased-feature-branch &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
-		test_path_is_file $dotest/autostash &&
+		git rev-parse $test_type/autostash &&
 		test_path_is_missing file3 &&
 		echo "conflicting-plus-goodbye" >file2 &&
 		git add file2 &&
 		git rebase --continue &&
-		test_path_is_missing $dotest/autostash &&
+		test_must_fail git rev-parse $test_type/autostash &&
 		grep dirty file3 &&
 		git checkout feature-branch
 	'
@@ -164,10 +165,10 @@ testrebase () {
 		test_when_finished git branch -D rebased-feature-branch &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
-		test_path_is_file $dotest/autostash &&
+		git rev-parse $test_type/autostash &&
 		test_path_is_missing file3 &&
 		git rebase --skip &&
-		test_path_is_missing $dotest/autostash &&
+		test_must_fail git rev-parse $test_type/autostash &&
 		grep dirty file3 &&
 		git checkout feature-branch
 	'
@@ -179,10 +180,10 @@ testrebase () {
 		test_when_finished git branch -D rebased-feature-branch &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
-		test_path_is_file $dotest/autostash &&
+		git rev-parse $test_type/autostash &&
 		test_path_is_missing file3 &&
 		git rebase --abort &&
-		test_path_is_missing $dotest/autostash &&
+		test_must_fail git rev-parse $test_type/autostash &&
 		grep dirty file3 &&
 		git checkout feature-branch
 	'
@@ -195,11 +196,11 @@ testrebase () {
 		echo dirty >>file3 &&
 		git diff >expect &&
 		test_must_fail git rebase$type related-onto-branch &&
-		test_path_is_file $dotest/autostash &&
+		git rev-parse $test_type/autostash &&
 		test_path_is_missing file3 &&
 		git rebase --quit &&
 		test_when_finished git stash drop &&
-		test_path_is_missing $dotest/autostash &&
+		test_must_fail git rev-parse $test_type/autostash &&
 		! grep dirty file3 &&
 		git stash show -p >actual &&
 		test_cmp expect actual &&
@@ -214,7 +215,7 @@ testrebase () {
 		echo dirty >file4 &&
 		git add file4 &&
 		git rebase$type unrelated-onto-branch >actual 2>&1 &&
-		test_path_is_missing $dotest &&
+		test_must_fail git rev-parse $test_type/autostash &&
 		git reset --hard &&
 		grep unrelated file4 &&
 		! grep dirty file4 &&
@@ -257,9 +258,9 @@ test_expect_success "rebase: noop rebase" '
 	git checkout feature-branch
 '
 
-testrebase " --apply" .git/rebase-apply
-testrebase " --merge" .git/rebase-merge
-testrebase " --interactive" .git/rebase-merge
+testrebase " --apply" rebase-apply
+testrebase " --merge" rebase-merge
+testrebase " --interactive" rebase-merge
 
 test_expect_success 'abort rebase -i with --autostash' '
 	test_when_finished "git reset --hard" &&
-- 
gitgitgadget

