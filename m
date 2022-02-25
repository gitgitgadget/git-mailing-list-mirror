Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7828C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 19:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiBYTba (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 14:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiBYTb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 14:31:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D471DC9A8
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:30:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v21so5965806wrv.5
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Ct1sMu+lMVYmgYeWw10IRqfYhY/Mku8yg6ZIfnH6Te4=;
        b=X3ebdhNjXgBgsLzq8N5tt3B9hOJ+URvRsJ4xvr5twV36o/R9jmETWPjicnWb5Fkyz4
         fN3I9bWlwahYULrHNCg27Ussujwc46kZsqFFT9yZ/cBMFvBy7dLG6Eunj7riYAbu/kBA
         kmdXa32t2iZHtOsWTCcuLb7nnV/f8VPKx81VQmVzLkrnAo4lHHzX4xlBfqOQ+sO13izR
         ViuRZoH65biRJ31Juq0Gu1okVGP8ULaUk4Df6UANGjEky8PlC5kxizOw7j/C4fwJWmW2
         EzG4P3c6ovRqXhAzH9MDBCFW4zbwLK1dXtFIoO6fiOMg4hnL+nOqqLPiuDpyqEwOQSwi
         EzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Ct1sMu+lMVYmgYeWw10IRqfYhY/Mku8yg6ZIfnH6Te4=;
        b=6cy3i/7Kyuj0Z1QgpzhhSLKcBnN2LBFzEwBh+Wma2S53h+NgAcXHkg8lxaQoEghaA9
         s+9Cbt6c/9V/hGB0gR6YRPMkJlLFe1N9ix8ZWUXv+fAA/uleYcvT7lgD2+i1zfM+sf9/
         oEPMy9yk6IDoAMtg1/EsYsgKibd9IvAIuHyl/Q3lpS2iZtXpCIfi/9fQ8oeqJjC4O0GO
         wk0RRbjsoZ3SEYXBWtFcVnEDreVevj7TYzjK1G1xSnwISV2EtkrG7eh+tmORkyooUI+Y
         81sULqBNk+MJ+ebCnBXI5f7qG+3tthscNsfoafyvQHFfjPi9ufPBwu/Uu1HFJFxabC7O
         KJPg==
X-Gm-Message-State: AOAM533Trpo3STOC4/jfskmeN+hu4COYUrT3ob6SosHVi8GfFoQmwclN
        wWaTNo709IBi6ZwyfCoZ2UQML0aHzT0=
X-Google-Smtp-Source: ABdhPJyR3SfvOdeMVT+XNZk59TvxLqDkoCyRvQ/sHY7X+uwj0q/hw6oZt3jsGGXmiKteXGXuOLcf0g==
X-Received: by 2002:a5d:59ac:0:b0:1e4:9b6e:eac7 with SMTP id p12-20020a5d59ac000000b001e49b6eeac7mr7464127wrr.172.1645817454502;
        Fri, 25 Feb 2022 11:30:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b00380ead5bc65sm4280884wmq.29.2022.02.25.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:30:54 -0800 (PST)
Message-Id: <33299825fc47fb0e2bc54e1f125282e7825e1924.1645817452.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
References: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
        <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 19:30:50 +0000
Subject: [PATCH v3 1/3] stash: add tests to ensure reflog --rewrite --updatref
 behavior
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

There is missing test coverage to ensure that the resulting reflogs
after a git stash drop has had its old oid rewritten if applicable, and
if the refs/stash has been updated if applicable.

Add two tests that verify both of these happen.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t3903-stash.sh | 65 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b149e2af441..73785cf862f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -41,20 +41,29 @@ diff_cmp () {
 	rm -f "$1.compare" "$2.compare"
 }
 
-test_expect_success 'stash some dirty working directory' '
-	echo 1 >file &&
-	git add file &&
-	echo unrelated >other-file &&
-	git add other-file &&
+setup_stash() {
+	repo_dir=$1
+	if test -z $repo_dir; then
+		repo_dir="."
+	fi
+
+	echo 1 >$repo_dir/file &&
+	git -C $repo_dir add file &&
+	echo unrelated >$repo_dir/other-file &&
+	git -C $repo_dir add other-file &&
 	test_tick &&
-	git commit -m initial &&
-	echo 2 >file &&
+	git -C $repo_dir commit -m initial &&
+	echo 2 >$repo_dir/file &&
 	git add file &&
-	echo 3 >file &&
+	echo 3 >$repo_dir/file &&
 	test_tick &&
-	git stash &&
-	git diff-files --quiet &&
-	git diff-index --cached --quiet HEAD
+	git -C $repo_dir stash &&
+	git -C $repo_dir diff-files --quiet &&
+	git -C $repo_dir diff-index --cached --quiet HEAD
+}
+
+test_expect_success 'stash some dirty working directory' '
+	setup_stash
 '
 
 cat >expect <<EOF
@@ -185,6 +194,40 @@ test_expect_success 'drop middle stash by index' '
 	test 1 = $(git show HEAD:file)
 '
 
+test_expect_success 'drop stash reflog updates refs/stash' '
+	git reset --hard &&
+	git rev-parse refs/stash >expect &&
+	echo 9 >file &&
+	git stash &&
+	git stash drop stash@{0} &&
+	git rev-parse refs/stash >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success REFFILES 'drop stash reflog updates refs/stash with rewrite' '
+	git init repo &&
+	setup_stash repo &&
+	echo 9 >repo/file &&
+
+	old_oid="$(git -C repo rev-parse stash@{0})" &&
+	git -C repo stash &&
+	new_oid="$(git -C repo rev-parse stash@{0})" &&
+
+	cat >expect <<-EOF &&
+	$(test_oid zero) $old_oid
+	$old_oid $new_oid
+	EOF
+	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
+	test_cmp expect actual &&
+
+	git -C repo stash drop stash@{1} &&
+	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
+	cat >expect <<-EOF &&
+	$(test_oid zero) $new_oid
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'stash pop' '
 	git reset --hard &&
 	git stash pop &&
-- 
gitgitgadget

