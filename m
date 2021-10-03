Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9479C433F5
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 12:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A844B61B31
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 12:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhJCMbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 08:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhJCMbn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 08:31:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D491AC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 05:29:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id rj12-20020a17090b3e8c00b0019f88e44d85so3628601pjb.4
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6FYBdq6zC89oXjnPnKchxhMnsagoeSJO63WkxkYaOM=;
        b=ZMcv7YnKBj/woeT792+zpeE2e3fWEkD7dqmouStABfth24QUL5xAC9sZd062QAcxgG
         4QNmT/bVFf5yzSakCj1lPwQUUhaZWOCBtPZ7SCU2yruBPrr1W93PpUiWU5nx3vaQO5bW
         AXJDM2Guf6s6NAWokk/X4upSTqsV7854Ux0VPFSQs02yFggzmKEV8iDVolqxOQeIy5Fq
         qGsjmI1IorbFOmkO+WP49dtFGTs6vSEKPurlGK+0Gb9mWPYgoOOGp0CVKttfu4Rq8A0o
         t6Qqv5lM6Z+HmPjtMzHH+UDemJGC58CNd0ajAb8IZ4qe9KteQncjkT9O4I21aR56cQxB
         6CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6FYBdq6zC89oXjnPnKchxhMnsagoeSJO63WkxkYaOM=;
        b=AQ5suulqcmO0dZ5XLRtF8NynkvkSaRRPgzDbaJAKgKC+iLMUDa8hMzAxzjJZsn9Lsq
         pt2Qa57RvWrfuoIExfvAWTod/W9VBmNyqwmAvUxXrYKbQy3GkKdjo6HRdW+gYw6X3YGm
         dsYt6WevdSFn7LxmpTPwYI1hq0Ac775nTBA7rOJX8pKewzthRHtyzpaLYWY1mrtDCyBf
         XGtUDPSoFexpvmvi9rHXo9RirRof8r/kLB4GB0wSctK82cnWLJsNC7ELr7Pn1AP+1Wy0
         9wTVWsoCxZtFBpkUesFlIhUV5DYmbCiE5SMrP1c/FRFx0qRZknSfbTu+q2xQeYVMeDBY
         IvDg==
X-Gm-Message-State: AOAM532uBJSJkzZoOkzBbwg7Lc/XozAUC77slYfEN6rhWaKKTc5dxE34
        wC2X0aOfxAITYEgrXTxjMsqLhcxVdW2Qbw==
X-Google-Smtp-Source: ABdhPJyPYcvbwI8i2wcoiOR48zcF/bayNHg/4S6a1jS9ep85MQFCwW0DRNzqKJFlG1K85qLl+EWC9Q==
X-Received: by 2002:a17:902:ab17:b0:13e:b2e0:58b with SMTP id ik23-20020a170902ab1700b0013eb2e0058bmr3226683plb.9.1633264195213;
        Sun, 03 Oct 2021 05:29:55 -0700 (PDT)
Received: from ubuntu.mate (subs09b-223-255-225-231.three.co.id. [223.255.225.231])
        by smtp.gmail.com with ESMTPSA id k17sm8476394pfu.82.2021.10.03.05.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 05:29:55 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Ryan Anderson <ryan@michonline.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/3] request-pull: introduce display_message() function
Date:   Sun,  3 Oct 2021 19:29:41 +0700
Message-Id: <20211003122943.338199-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003122943.338199-1-bagasdotme@gmail.com>
References: <20211003122943.338199-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move displaying PR message logic into display_message. While at it, use
local variable $format and $dashline to shorten argument typing to git
show.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 git-request-pull.sh | 57 ++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 2d0e44656c..88a7a9cf0d 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -136,37 +136,50 @@ fi
 
 url=$(git ls-remote --get-url "$url")
 
-git show -s --format='The following changes since commit %H:
+display_message() {
+	local format
+	local dash_line
+
+	dash_line="----------------------------------------------------------------"
+	format='The following changes since commit %H:
 
   %s (%ci)
 
 are available in the Git repository at:
-' $merge_base &&
-echo "  $url $pretty_remote" &&
-git show -s --format='
-for you to fetch changes up to %H:
+'
+
+	git show -s --format="$format" $merge_base &&
+	echo "  $url $pretty_remote" &&
+	format='for you to fetch changes up to %H:
 
   %s (%ci)
+'
+	git show -s --format="
+$format
+$dash_line" $headrev &&
 
-----------------------------------------------------------------' $headrev &&
+	if test $(git cat-file -t "$head") = tag
+	then
+		git cat-file tag "$head" |
+		sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p
+		echo
+		echo "$dash_line"
+	fi &&
 
-if test $(git cat-file -t "$head") = tag
-then
-	git cat-file tag "$head" |
-	sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p
-	echo
-	echo "----------------------------------------------------------------"
-fi &&
+	if test -n "$branch_name"
+	then
+		echo "(from the branch description for $branch_name local branch)"
+		echo
+		git config "branch.$branch_name.description"
+		echo "$dash_line"
+	fi &&
 
-if test -n "$branch_name"
-then
-	echo "(from the branch description for $branch_name local branch)"
-	echo
-	git config "branch.$branch_name.description"
-	echo "----------------------------------------------------------------"
-fi &&
+	git shortlog ^$baserev $headrev &&
+	git diff -M --stat --summary $patch $merge_base..$headrev
+}
 
-git shortlog ^$baserev $headrev &&
-git diff -M --stat --summary $patch $merge_base..$headrev || status=1
+message=$(display_message) || status=1
+
+echo "$message"
 
 exit $status
-- 
An old man doll... just what I always wanted! - Clara

