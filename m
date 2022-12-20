Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA69C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLTAfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiLTAfw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:35:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D89D80
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:35:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg10so7635280wmb.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8bod0Rl9Tnm1gnlXbsPAOPh2lPs80zvyxTxHmg+bUg=;
        b=hb+H39OQAPm8vVAexBNW7tX1l0oQnFhx24+ZTVLEQHT8ZmnxK1xgbbd2PMaZDtgKIa
         tqBP8lfDapR9xf1hOD/if/IP0wPr4Kgr/LQkb9xHwlfMNku2o8O8aP/VjzBD3fHCLkka
         Xhdqs4oFSZbGLt+qY5AfEFSw9hdjzhi0wfK3OPq8pV5LXNjhw6o46Mi2A4M01rury0D5
         q4hNEoOb6lCChpXftUplXgxpJlmb9hj+fJuMlwLzQ631N+WIKNMmMNjxBJcmDSNDi1t5
         sQlPm10/SRmfp2xrGit8lU7k6kGz1ND6S4YtdqAqBiGnpfJqATEQs5Q1HfWKFkUSrb+L
         8PXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8bod0Rl9Tnm1gnlXbsPAOPh2lPs80zvyxTxHmg+bUg=;
        b=HYnvnHfNxCop+OvVYDDw3SS9fIy03UVqypNHCGehpbvsUUqpV0IvK+r+zfWE8bJZC1
         a5bZI9TeXbUDzcVmK6+QrdNEO021QFr/Avj2GXTi1OcnrssxmDkfQgbLRGrBNnRT6rAe
         F66YIwUb/HXvZmvEMTGAQ5dp/vEPiBbWlXqcT8PSYOkCyZm2W9/c9fA+Q53WdjZnoUeW
         V5yRwTCtjE2YNYgmRHwajaLCAGnMejKYpUvkgYUBk1XKXCmoEGmK90gpoD0WCGGK6Pgh
         uyu0UCwp4HykQo609YBpuH1Xf74qHzNv/9fDysyC+sJCuFfJpdhwXhrWMuYb3k5Ii/bc
         XpMw==
X-Gm-Message-State: ANoB5pmx3mQTRRuCIgWhu3qpFD6tH5QOGp2G0/3oeD+RFUZbMcJ/Nd2C
        hLkrQSAJLPa/0NKH3ZSPeas1mv+++Jw=
X-Google-Smtp-Source: AA0mqf5wdgmdzv9PZyZF6UTL9/be2iNcIaMSFW4wpkzpz03iWjFGFvzxfY1+tq/7KilkGzEgw0QUqA==
X-Received: by 2002:a05:600c:1c87:b0:3cf:ae53:9193 with SMTP id k7-20020a05600c1c8700b003cfae539193mr36037803wms.39.1671496549934;
        Mon, 19 Dec 2022 16:35:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003c7087f6c9asm20993124wmq.32.2022.12.19.16.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:35:49 -0800 (PST)
Message-Id: <a2b5f3e87d6ef62d8005cff5568ad3afc4af3771.1671496548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com>
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
        <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com>
From:   "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 00:35:45 +0000
Subject: [PATCH v2 1/3] ci (check-whitespace): suggest fixes for errors
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

Make the errors more visible by adding them to the job summary and
display the git commands that will usually fix the problem.

Signed-off-by: Chris. Webster <chris@webstech.net>
---
 .github/workflows/check-whitespace.yml | 37 +++++++++++++++++++-------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index ad3466ad16e..a0871489b24 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -20,31 +20,50 @@ jobs:
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

