Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D6C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 19:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjDATsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 15:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDATsm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 15:48:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C50172A8
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 12:48:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l12so25565209wrm.10
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680378518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDGjPU9rvzTz8WdofH7YA08Y2vEWf6w7TRWTokutU4E=;
        b=WyBiHjv/CEEdWcQBNd5TkVLzXb4U6Vaw050wlfLZxXXwUTgGITloYB5c4LjfJkkzjk
         KxKf1T31OtOHQzl81jdIMWQAm78WPb6DU7GrK4nRyFnrqxcNcxfQSJwTpWADLV9evvXU
         AT6qz1lb8kzPBlyj18Jwc5TyxUMeIwV9Q+IFY3vB3LK7glf5A3q1DK5wiQVdy88yGYQS
         N5LBs9F4Dn4jjKVO6SmzacOjVzO6aUGicivtEADqjF6Ig8yrEySsrpPPhVE4dz1BBz26
         HjtuVMZ2mBl1snDIwhs5UCBprpwLfr/wsPpRAy8a4I19UnHGjupkYN+WRzSFC9MfvbQS
         UHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680378518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDGjPU9rvzTz8WdofH7YA08Y2vEWf6w7TRWTokutU4E=;
        b=lqryn4eo4+ZudrWketBiWibzsHwM4UTqx/09QWqC5jQFD4R9pNyhRP3B16K/T9K8x4
         XMMzGBqc0k5JDrxV+8o/tw0sCPx/Hmty7e9JeLg5oPoqNPUIXllvK98MbS1d8iQb6yEo
         j8Y7SxzVORUhjpvDxK9Znx47ub3KCQlpJOjjO8OwJEjyJMT+nxLQDsg1eHjM/2S2N7ps
         IgMaIjGlpfrnGlV7WColUjAd6Afng4qz/zQMYL30atS8JuRXHDj+VefYaUIMxXef64Zd
         Xvalrt54MA1t/IZ2acm85vfDfS/0CvHiiN3SKCHxsyLznDePj8yP7kgZaWNJsGYH4Pdc
         av2w==
X-Gm-Message-State: AAQBX9eZldG53tTMT7dqgTPQnzU7/v4B8Jtl6AMh9AWKo3XzmqiVQWGR
        keYH+qu9fuDgSqlcNOowQV3of1Nn6DK+Sw==
X-Google-Smtp-Source: AKy350ZZ8iJh3C28KT3aTROQNLdNXkC5ODTWXL9U8cizRemLXY+01iiu7SZdmGLURr/Yd/ERuCK09w==
X-Received: by 2002:a5d:4533:0:b0:2cf:ed7c:29c with SMTP id j19-20020a5d4533000000b002cfed7c029cmr23213121wra.62.1680378518397;
        Sat, 01 Apr 2023 12:48:38 -0700 (PDT)
Received: from localhost.localdomain ([2a0c:5bc0:40:2e25:76c6:3bff:fe8a:46ba])
        by smtp.gmail.com with ESMTPSA id f16-20020adffcd0000000b002d5a8d8442asm5586170wrs.37.2023.04.01.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 12:48:38 -0700 (PDT)
From:   Edwin Fernando <edwinfernando734@gmail.com>
To:     git@vger.kernel.org
Cc:     Edwin Fernando <edwinfernando734@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: [GSOC][PATCH v2] t3701: don't lose "git" exit codes in test scripts
Date:   Sat,  1 Apr 2023 20:47:56 +0100
Message-Id: <20230401194756.5954-1-edwinfernando734@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230326173147.39626-1-edwinfernando734@gmail.com>
References: <20230326173147.39626-1-edwinfernando734@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exit codes were lost due to piping and command substitution:

- "git ... | <command>"
- "<command> $(git ... )"

Fix these issues using the intermediate step of writing output to file.
---
Changes in response to review:
- addressed code style issues: ">diff" not  "> diff_file"
- a more direct alternative to "test -z $(cat ...)"
- commit message similar to previous commits accomplishing same goals
- revert unnecessary change. keep "<var> = $(git ...)"

 t/t3701-add-interactive.sh | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 80446b311d..77aad9032a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -292,10 +292,10 @@ test_expect_success FILEMODE 'patch does not affect mode' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "n\\ny\\n" | git add -p &&
-	git show :file > show_file &&
-	grep content show_file &&
-	git diff file > diff_file &&
-	grep "new mode" diff_file
+	git show :file >show &&
+	grep content show &&
+	git diff file >diff &&
+	grep "new mode" diff
 '
 
 test_expect_success FILEMODE 'stage mode but not hunk' '
@@ -303,10 +303,10 @@ test_expect_success FILEMODE 'stage mode but not hunk' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "y\\nn\\n" | git add -p &&
-	git diff --cached file > diff_file &&
-	grep "new mode" diff_file &&
-	git diff file > diff_file &&
-	grep "+content" diff_file
+	git diff --cached file >diff &&
+	grep "new mode" diff &&
+	git diff file >diff &&
+	grep "+content" diff
 '
 
 
@@ -315,12 +315,11 @@ test_expect_success FILEMODE 'stage mode and hunk' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "y\\ny\\n" | git add -p &&
-	git diff --cached file > diff_file &&
-	grep "new mode" diff_file &&
-	git diff --cached file diff_file &&
-	grep "+content" diff_file &&
-	git diff file > diff_file &&
-	test -z $(cat diff_file)
+	git diff --cached file >diff &&
+	grep "new mode" diff &&
+	grep "+content" diff &&
+	git diff file >diff &&
+	test_must_be_empty diff
 '
 
 # end of tests disabled when filemode is not usable
@@ -977,8 +976,8 @@ test_expect_success 'handle submodules' '
 
 	force_color git -C for-submodules add -p dirty-head >output 2>&1 <y &&
 	git -C for-submodules ls-files --stage dirty-head >actual &&
-	git -C for-submodules/dirty-head rev-parse HEAD > rev &&
-	grep -f rev actual
+	rev="$(git -C for-submodules/dirty-head rev-parse HEAD)" &&
+	grep "$rev" actual
 '
 
 test_expect_success 'set up pathological context' '
-- 
2.40.0

