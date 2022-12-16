Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB3C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 08:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiLPIcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 03:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLPIcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 03:32:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DBC32B8A
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 00:32:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ja17so1321308wmb.3
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 00:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGDdH7SmR3iE6lKn6PXk0EjJYeBQox3V3ZMra0OXZwE=;
        b=G2DZXrlSNf8sHpkGIfMU863Zl2duu10mQvghlWoP3Xkx1JNEH3ReEsvjR9jYNrSL45
         J+C9Z/drosr7XxmhZdeCsKHrGv1yYFZPqPGXIhTf+ZD4/7GfeK+kMcLbKX9QSsUB+WlY
         tIpxW5zL6uWHnTiX4n+Ts8JNh6vSnA3BEsjsqwHp/tSTmRnnHiCCQh+UZFGMD6i7uAY8
         AodOWNYKq7O+8LuLTB26ERJGw5TuGE4vIlZu7a1TS/5972CgZbwAA8h0maPZGPJG803i
         h9U2qUKI+A/IXmrWzTHv/ZtwRhb9LV9xwFNOantmvyfHkhOEiabiD1mISzqfyXRIgyUZ
         FN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGDdH7SmR3iE6lKn6PXk0EjJYeBQox3V3ZMra0OXZwE=;
        b=XSuCgEicMAfc+28WKKcsHdIPMeSXR9S6tzUjzOhmNgAmwbzOiOfvuQjxFX0w2/olM4
         +6s7c6rG6JdLvK6Kc25ECcUwvbpsOFZp8xtTPlGreVjkNc6tT+GNCjcKokaQG7slT1rM
         Fc/a2+ywn6aDkraHu17XmGSv+OMNSas8bLlN7J0gPPYmRWfTKajMw2TX/zykYvwwFgr2
         Gort2Oba+5gBTj4JPPqW19HRtY6pM2Xb9C9zaMeUqLm0qYT6Bbu8Ybp8+dJyh6AwnG7H
         eceWzbDf7X2hVW4pdwilmgb/zvMxJ0h5RlWP0lVVfrlXRacS9C2XFaqK7A8YP8q9Q2Xc
         udKw==
X-Gm-Message-State: ANoB5pkscfeHnCQ79JB1TXdns819WQJ+glNilGBRNMMjnSSSOtGeFtyy
        q1Q4DHcRaPL5DVBRDeeOPqke8PILbSc=
X-Google-Smtp-Source: AA0mqf5OhVBuT0MKWObdLtcFXoXpjq512M9GiwYZbH0MT3Pgs4z0hROj8oNTZpLmXxHWvlEPLEAEng==
X-Received: by 2002:a7b:c4d2:0:b0:3d1:f270:a81e with SMTP id g18-20020a7bc4d2000000b003d1f270a81emr25405958wmk.17.1671179522829;
        Fri, 16 Dec 2022 00:32:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n125-20020a1ca483000000b003cfa622a18asm8796929wme.3.2022.12.16.00.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 00:32:02 -0800 (PST)
Message-Id: <67f60e4e5cbb470bbf3f556f962403af5dd5938c.1671179520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
From:   "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 08:31:59 +0000
Subject: [PATCH 1/2] Make `check-whitespace` failures more helpful
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Chris. Webster" <chris@webstech.net>,
        "Chris. Webster" <chris@webstech.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Chris. Webster" <chris@webstech.net>

Add the errors to the job summary along with suggested
commands to fix the problem.

Signed-off-by: Chris. Webster <chris@webstech.net>
---
 .github/workflows/check-whitespace.yml | 39 +++++++++++++++++++-------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index ad3466ad16e..3a99073bc33 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -13,38 +13,57 @@ jobs:
   check-whitespace:
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
       with:
         fetch-depth: 0
 
     - name: git log --check
       id: check_out
       run: |
-        log=
+        problems=()
         commit=
-        while read dash etc
+        commitText=
+        lastcommit=
+        while read dash sha etc
         do
           case "${dash}" in
           "---")
-            commit="${etc}"
+            if test -z "${commit}"
+            then
+              lastcommit=${sha}
+            fi
+            commit="${sha}"
+            commitText="${sha} ${etc}"
             ;;
           "")
             ;;
           *)
             if test -n "${commit}"
             then
-              log="${log}\n${commit}"
+              problems+=("" "--- ${commitText}")
               echo ""
-              echo "--- ${commit}"
+              echo "--- ${commitText}"
+              commit=
             fi
-            commit=
-            log="${log}\n${dash} ${etc}"
-            echo "${dash} ${etc}"
+            problems+=("${dash} ${sha} ${etc}")
+            echo "${problems[-1]}"
             ;;
           esac
         done <<< $(git log --check --pretty=format:"---% h% s" ${{github.event.pull_request.base.sha}}..)
 
-        if test -n "${log}"
+        if test ${#problems[*]} -gt 0
         then
+          if test -z "${commit}"
+          then
+            lastcommit=${{github.event.pull_request.base.sha}}
+          fi
+          echo "A whitespace issue was found in one or more of the commits." >$GITHUB_STEP_SUMMARY
+          echo "" >>$GITHUB_STEP_SUMMARY
+          echo "Run \`git rebase --whitespace=fix ${lastcommit}\` and \`git push --force\` to correct the problem." >>$GITHUB_STEP_SUMMARY
+          for i in "${problems[@]}"
+          do
+            echo "${i}" >>$GITHUB_STEP_SUMMARY
+          done
+
           exit 2
         fi
-- 
gitgitgadget

