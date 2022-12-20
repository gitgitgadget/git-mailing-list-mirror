Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594C7C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiLTAf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiLTAfx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:35:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3D610D3
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:35:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h16so10257716wrz.12
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zl6Iga4ua4RWF2Ch3AHdkeYMAPYH/eqhuovDHXPKyLY=;
        b=Pp+Q3al9Wmm0FJtWfCZ82sBV7Ma5SCQJElRUlHork8Tvo+8fnH3NJiJmx2UFjWPMbE
         t3C4C1qkqi9m4dfwu/O6SuG9R0f9DTq42J3VtZ3F8ZJAIzsKbmfF+KArmEY0/9FJkn3t
         RmsJ56JJsIFcJeKRkcbImU9JFI7lAnyQoTn9TtP3E/kZ8VVTW+bGQ/oaz6r+gOVFv7S9
         TzKqq5OJjURe7rdQDCS0HJReRfcQafwlO0exmUkqqLq9weNBxamMBRANCp4oeU2dDPqF
         Jmf9oyu34mbABZVe/eZohb5EzZiPeFik2E8RTLgmMSQ4VuOw0sW+Dl5AyYxGX2cWg1pV
         JplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zl6Iga4ua4RWF2Ch3AHdkeYMAPYH/eqhuovDHXPKyLY=;
        b=3gjci+stbO70rQ9wh4AAhpYR/FfDgcbrRZTPI05nL8FSDy0Td3cEUd9Fo2XbQ54MNd
         B4KqWJMZsrTdqujF3avTHGyyVc18MkJxbE4bsf9O83AbXF2+ei3BlByKqTK6XmjyMxE0
         fWggGNcE0fF/XXwdpnC9ZS1b4g5YnCQ2/gam1++PW7oHvudjDSnogEOXqnIPYXQrmNFg
         H5GgEw1aWKv2FTvDOm18gE58zVHTH67Lc1n9Mcml81U6GeSnvmUZ+Rqz7b2vM1GMTDFw
         S489d0wPyQUgO9etzyLc2xrJ1JrzH3odb02jRA2lXuiasgUTbiFV9icPrVUislpq3Mg4
         lzSA==
X-Gm-Message-State: AFqh2kpuc0b+F5BxVlONP+2CW7ZFdnsp2HS1beWSR7w7/KGXe62BJeuT
        FjA2dMiKULNQCBAJrg2qzAUAGoSlfoA=
X-Google-Smtp-Source: AMrXdXuNn8E1sIvIpPTrQMUfgCjhouHKu5ITQ/DLk+w5CdKxiu6rqX8cY7x1i+wxx+e3LTLscvNSZQ==
X-Received: by 2002:a5d:50d2:0:b0:241:d126:ea0e with SMTP id f18-20020a5d50d2000000b00241d126ea0emr127206wrt.65.1671496550770;
        Mon, 19 Dec 2022 16:35:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d4c85000000b0023659925b2asm11082814wrs.51.2022.12.19.16.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:35:50 -0800 (PST)
Message-Id: <342167ef5bd7f98a7248feea86f4f77b268988bb.1671496548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com>
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
        <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com>
From:   "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 00:35:46 +0000
Subject: [PATCH v2 2/3] ci (check-whitespace): add links to job output
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

A message in the step log will refer to the Summary output.

The job summary output is using markdown to improve readability.  The
git commands and commits with errors are now in ordered lists.
Commits and files in error are links to the user's repository.

Signed-off-by: Chris. Webster <chris@webstech.net>
---
 .github/workflows/check-whitespace.yml | 34 +++++++++++++++++++-------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index a0871489b24..552894f736a 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -20,46 +20,62 @@ jobs:
     - name: git log --check
       id: check_out
       run: |
+        baseSha=${{github.event.pull_request.base.sha}}
         problems=()
         commit=
         commitText=
-        lastcommit=
+        commitTextmd=
+        goodparent=
         while read dash sha etc
         do
           case "${dash}" in
           "---")
             if test -z "${commit}"
             then
-              lastcommit=${sha}
+              goodparent=${sha}
             fi
             commit="${sha}"
             commitText="${sha} ${etc}"
+            commitTextmd="[${sha}](https://github.com/${{ github.repository }}/commit/${sha}) ${etc}"
             ;;
           "")
             ;;
           *)
             if test -n "${commit}"
             then
-              problems+=("" "--- ${commitText}")
+              problems+=("1) --- ${commitTextmd}")
               echo ""
               echo "--- ${commitText}"
               commit=
             fi
-            problems+=("${dash} ${sha} ${etc}")
-            echo "${problems[-1]}"
+            case "${dash}" in
+            *:[1-9]*:) # contains file and line number information
+              dashend=${dash#*:}
+              problems+=("[${dash}](https://github.com/${{ github.repository }}/blob/${{github.event.pull_request.head.ref}}/${dash%%:*}#L${dashend%:}) ${sha} ${etc}")
+              ;;
+            *)
+              problems+=("\`${dash} ${sha} ${etc}\`")
+              ;;
+            esac
+            echo "${dash} ${sha} ${etc}"
             ;;
           esac
-        done <<< $(git log --check --pretty=format:"---% h% s" ${{github.event.pull_request.base.sha}}..)
+        done <<< $(git log --check --pretty=format:"---% h% s" ${baseSha}..)
 
         if test ${#problems[*]} -gt 0
         then
           if test -z "${commit}"
           then
-            lastcommit=${{github.event.pull_request.base.sha}}
+            goodparent=${baseSha: 0:7}
           fi
-          echo "A whitespace issue was found in one or more of the commits." >$GITHUB_STEP_SUMMARY
+          echo "🛑 Please review the Summary output for further information."
+          echo "### :x: A whitespace issue was found in one or more of the commits." >$GITHUB_STEP_SUMMARY
           echo "" >>$GITHUB_STEP_SUMMARY
-          echo "Run \`git rebase --whitespace=fix ${lastcommit}\` and \`git push --force\` to correct the problem." >>$GITHUB_STEP_SUMMARY
+          echo "Run these commands to correct the problem:" >>$GITHUB_STEP_SUMMARY
+          echo "1. \`git rebase --whitespace=fix ${goodparent}\`" >>$GITHUB_STEP_SUMMARY
+          echo "1. \`git push --force\`" >>$GITHUB_STEP_SUMMARY
+          echo " " >>$GITHUB_STEP_SUMMARY
+          echo "Errors:" >>$GITHUB_STEP_SUMMARY
           for i in "${problems[@]}"
           do
             echo "${i}" >>$GITHUB_STEP_SUMMARY
-- 
gitgitgadget

