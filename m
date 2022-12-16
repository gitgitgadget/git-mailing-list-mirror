Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970EEC4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 08:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLPIcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 03:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPIcI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 03:32:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D163912D0B
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 00:32:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso3564681wme.5
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 00:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7LanUyz+eQ9lU/NN2Hm3RcXIwe46kyYd8EhNmvtYYk=;
        b=SsO+sQD018xSZid+G4poeHVQj1MsDeTZrZ+JIhkrgsgnzY6h26jAwlX0UVmEgne6Ah
         qkGtBg/dyzCyytZ7TwEX4y8ia1NQMOxQ8tV3Q16ZAz3c15JINsmgo4IgSRu5DUc9dc3L
         eBoNTgn2ld7ull+Jz/yM8tf2n9UKl5XcJpWTR3ZM48vOkqUqEBj4h9Ah8fNw6sxXRLuI
         QX6UkVaKtI+gYGuN+sknWpNFQYuWf4KkY2dTAmUXqlIXqFgY40/eEVIHQYcKe7j13/JO
         4LdQFfP2VtJVg1vH72h3IhdkNwj0G3RYtlBGeTIvQ2ZPFAKFSs7CJrSmRkZSzMP8VBu2
         v3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7LanUyz+eQ9lU/NN2Hm3RcXIwe46kyYd8EhNmvtYYk=;
        b=hfJFQuXLvlswODTwT7QSoJ0srxW2arpVwFZPFV82KWRwC9za1m7acJP2zOgEAbU96g
         9IxzZhNoYAWNii17ttJ/o3j4/YC5oNO2V5owXe5qBa+4lHitcsSI7ImigSSwwgCztm6V
         EvEGhQrV/C83z/zxxtVhARrqRLhpRhmv8kGHnGmXJfzDCSPrEfAm8MlT1xNklOYcaOyU
         EzeU47muyfd++3+cnyau9ikqpgmLxc+bCKwAIq3wSFDOy7IRAbQidhzYfSKZvAZY21Ua
         rEpxFWwq8N5awX6NAG2Sngti5TskEifDGq5eYD7bJ1GBnujUI4rxhWkWBi/L0xfQJRj2
         TNfA==
X-Gm-Message-State: ANoB5plH11wf8pdO4q5y4DNG7nG0vaaGQWtLM3Gecj7swuQp/SbBEMv/
        0GgCrMIqbYVBgxQvHgMIzUL8FjT2pLU=
X-Google-Smtp-Source: AA0mqf5ThyAhdrjPdvgB0z6Hc/4iXT7nh8R/87W2uG04ERGJONsGxLM+fG3p56450wRVc2NIQpKZiw==
X-Received: by 2002:a05:600c:4fd0:b0:3cf:d367:274d with SMTP id o16-20020a05600c4fd000b003cfd367274dmr24457438wmq.31.1671179524187;
        Fri, 16 Dec 2022 00:32:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i26-20020a1c541a000000b003c6c182bef9sm10710686wmb.36.2022.12.16.00.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 00:32:03 -0800 (PST)
Message-Id: <cdc2b1aae81f8c37b4e71cb3e0e382cf82de2272.1671179520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
From:   "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 08:32:00 +0000
Subject: [PATCH 2/2] Improve check-whitespace output
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

The job summary output now has links to the commits and files.

Signed-off-by: Chris. Webster <chris@webstech.net>
---
 .github/workflows/check-whitespace.yml | 34 +++++++++++++++++++-------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index 3a99073bc33..da557fd5914 100644
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
