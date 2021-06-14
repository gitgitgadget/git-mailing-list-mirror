Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF82BC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF0B61208
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhFNMpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 08:45:00 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38511 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhFNMpA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 08:45:00 -0400
Received: by mail-wm1-f48.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso12949023wmi.3
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Nfma+yiJ07laTTpuKcJKMskGPMmX82CjKW2AbCfzq0=;
        b=VYifQO6IuHP25iWgVRMxK9/FJG3g4hCY2Vu5F7Jxh8lHlKSn1jSvvdeDYacvbR4k70
         XsXnHS+nFTL8UElHWOtAnYQW4OC69JSoaD8A+1TvvkbkLelUHnwHDHk3TQ+WN3j4uLXZ
         kmbGBwfLAKsthQcxJmzTmeemRO4gnUSeQzmKG9uwGo1vd9Ro0j64AQeDp/YHMNmXzGCK
         YMiF8qJkyPTGc+hnHGgraA9l1bNwhuyXWjxw6HOkL2oIZI/Z7zPspnXBwU1tUQgIdstE
         gYwY4EJq1uAhNcVvu9ApsoTBo8R0gULIZkLUWoLj+1MBfqzhzsOHIrs21qrDvtyW2loB
         LCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Nfma+yiJ07laTTpuKcJKMskGPMmX82CjKW2AbCfzq0=;
        b=qSdBEW0A3JZPsKPGj/D3H/pEYFbLJL+KA+0v6ltoqort81sVw57sb/dglzUuhSlN12
         NMapkZNFIl4b8uGeN2I/PZ+1QF9w7X8q0g+70HGM9EvQhwS1RleuO6nbo1TFPTOka2TV
         BQ1N7xIgpKTAj46BPg3fEWCJRL1TXIwINf0PKRjsNgrA+v8o/tD+Y4junaTvqNJLg3Ko
         3A4yW4xj681R3p7FbRXGN4e308xjg4Z9YcKJoGDSIW6+licGcrkrLkokc3XWX3Q0W0MN
         zN0ciYDYtTXrYDb8vv+FWRKdQ8N/lV4LO1J6VfWlvgYo8c7VWdqCyrANHD3uMe3glti5
         wRow==
X-Gm-Message-State: AOAM531d4bHyT+d0CEBBEnE/Mq2BsfDaHiLtzAEqBZ6putvgHEm1HTv8
        Y8bjUqBQaLEYDzKFJyVk8fIU8rodbqE=
X-Google-Smtp-Source: ABdhPJyUOlCDx0g81bK7bReEpZCZtcDVFBKLW20s+zjt+kdjBJGxRoVbGZfTxZs5oK4WLWlr1d36dg==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr15796174wmj.20.1623674516563;
        Mon, 14 Jun 2021 05:41:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k82sm20585224wmf.11.2021.06.14.05.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 05:41:56 -0700 (PDT)
Message-Id: <a6f7aa40485f6bdd271ff8797159d8affbd024a2.1623674514.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.978.v2.git.1623674513.gitgitgadget@gmail.com>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
        <pull.978.v2.git.1623674513.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 12:41:53 +0000
Subject: [PATCH v2 2/2] subtree: fix assumption about the directory separator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@lukeshu.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, both forward and backslash are valid separators. In
22d550749361 (subtree: don't fuss with PATH, 2021-04-27), however, we
added code that assumes that it can only be the forward slash.

Let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/subtree/git-subtree.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 3935cea7dd13..7f767b5c38fe 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -10,6 +10,7 @@ if test -z "$GIT_EXEC_PATH" || ! test -f "$GIT_EXEC_PATH/git-sh-setup" || {
 	test ! "$GIT_EXEC_PATH" -ef "${PATH%%:*}" 2>/dev/null
 }
 then
+	basename=${0##*[/\\]}
 	echo >&2 'It looks like either your git installation or your'
 	echo >&2 'git-subtree installation is broken.'
 	echo >&2
@@ -17,10 +18,10 @@ then
 	echo >&2 " - If \`git --exec-path\` does not print the correct path to"
 	echo >&2 "   your git install directory, then set the GIT_EXEC_PATH"
 	echo >&2 "   environment variable to the correct directory."
-	echo >&2 " - Make sure that your \`${0##*/}\` file is either in your"
+	echo >&2 " - Make sure that your \`$basename\` file is either in your"
 	echo >&2 "   PATH or in your git exec path (\`$(git --exec-path)\`)."
-	echo >&2 " - You should run git-subtree as \`git ${0##*/git-}\`,"
-	echo >&2 "   not as \`${0##*/}\`." >&2
+	echo >&2 " - You should run git-subtree as \`git ${basename#git-}\`,"
+	echo >&2 "   not as \`$basename\`." >&2
 	exit 126
 fi
 
-- 
gitgitgadget
