Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592ECC432BE
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 16:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A01C60231
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 16:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhHVQOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 12:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhHVQON (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 12:14:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C734C061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 09:13:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so17092263pjr.1
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFWigk4ekPdkhyCTjeIgg3tD+5/9C5hvPqAKad2bwG8=;
        b=Nf6AzU5ziSMPi0MyR44ne+tEp9iSXKoHXTlbVNwsePsrpOqmmlbXLm/Gv+3UvOE3UI
         g3ywqKureXr+LIyZKpGnr0lp+UOuHRF1QDb8mPg8rV8awVLWzYgmDg5qdpJO0QGSSHNQ
         oNLMVfubhLs0m3kCA2f0T/6Tvgg47lOCP6nTH1Wif8L5gyE66VEryoj0VUdROGnmChm/
         IVeajb/e/TWlLIiHlhFK+Zd/AVFxqDjy4cV+rbzGAX1kriJArrS6tqGsuQdI5cay6cdN
         A2C68saJJhSDjuEF9D4HKBUoZPlr7OCzeENkkm9VTEJNjBXMnnCmhEZF7JYbQYFfY1Om
         ZEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFWigk4ekPdkhyCTjeIgg3tD+5/9C5hvPqAKad2bwG8=;
        b=G2VOxrdTZc1+s50O+Pe2laXgDmKx9acSnLT4il0/hBTYUl2GfoA2yUAeIjfpl9Hm0f
         GGGbnAvEMPtMAe7zc24To2XTnAJ2Skg5EFc4mNSY4CyvLgsIlvQjIgBDQzTyCB+hXA1u
         FIxiuqzMItZAU17A6CgubYgOjyosneaKhkSVWbQoqsKU3kFpl6iiKh4Imn/RoixfOdAU
         r02LzP69gKspP6iaubvgU4kMBtbRSC+NVkNJjjgKJGu8KapzowC/iJaaHKEo8DGWjHAq
         JdggyncaBBVVomFsxb7+74NmzsnWGtGbqUxqKm5bTnMJKxmBBTkmjFkK9H1Ii+zhuaKV
         9QJg==
X-Gm-Message-State: AOAM531d/OFLz20FSrpdu7jryqyAXuaEt5mLMSNko+bS9kvAmYXN4a26
        s+ein4S9ui08RuDvNgTMgFaCi9xNAeAUndCP
X-Google-Smtp-Source: ABdhPJyKSNEL/LPnVVy0h2VFAA2N/KPon9Gr0/W4gywB/X+uh5d4hKPvqPNW0C3DPMt9FgvmT8jpKA==
X-Received: by 2002:a17:902:e74d:b0:12d:a944:527c with SMTP id p13-20020a170902e74d00b0012da944527cmr25161608plf.85.1629648810441;
        Sun, 22 Aug 2021 09:13:30 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n31sm12957480pfv.22.2021.08.22.09.13.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Aug 2021 09:13:30 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 1/1] ci: new github-action for git-l10n code review
Date:   Mon, 23 Aug 2021 00:13:25 +0800
Message-Id: <20210822161325.22038-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20210822161325.22038-1-worldhello.net@gmail.com>
References: <20210822161325.22038-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Git l10n uses github pull request for code review. A helper program
"git-po-helper" can be used to check typos in ".po" files, validate
syntax, and check commit message. It would be convenient to integrate
this helper program to CI and add comments in pull request.

The new github-action workflow is added in ".github/workflows/l10n.yml",
which is disabled by default. To turn it on for the git-l10n related
repositories, such as "git-l10n/git-po", we can add a new branch named
"ci-config" and create a simple shell script at "ci/config/allow-l10n"
in this branch.

The new l10n workflow listens to two types of github events: push and
pull_request.

For a push event, it will scan commits one by one. If a commit does not
look like a l10n commit (no file in "po/" has been changed), it will
immediately fail without checking for further commits. While for a
pull_request event, all new introduced commits will be scanned.

"git-po-helper" will generate two kinds of suggestions, errors and
warnings. A l10n contributor should try to fix all the errors, and
should pay attention to the warnings. All the errors and warnings will
be reported in the last step of the l10n workflow as two message groups.
For a pull_request event, will create additional comments in pull
request to report the result.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 .github/workflows/l10n.yml | 143 +++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 .github/workflows/l10n.yml

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
new file mode 100644
index 0000000000..60f162c121
--- /dev/null
+++ b/.github/workflows/l10n.yml
@@ -0,0 +1,143 @@
+name: git-l10n
+
+on: [push, pull_request]
+
+jobs:
+  ci-config:
+    runs-on: ubuntu-latest
+    outputs:
+      enabled: ${{ steps.check-l10n.outputs.enabled }}
+    steps:
+      - name: try to clone ci-config branch
+        run: |
+          git -c protocol.version=2 clone \
+            --no-tags \
+            --single-branch \
+            -b ci-config \
+            --depth 1 \
+            --no-checkout \
+            --filter=blob:none \
+            https://github.com/${{ github.repository }} \
+            config-repo &&
+          cd config-repo &&
+          git checkout HEAD -- ci/config || : ignore
+      - id: check-l10n
+        name: check whether CI is enabled for l10n
+        run: |
+          enabled=no
+          if test -x config-repo/ci/config/allow-l10n &&
+             config-repo/ci/config/allow-l10n '${{ github.ref }}'
+          then
+            enabled=yes
+          fi
+          echo "::set-output name=enabled::$enabled"
+
+  git-po-helper:
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+      with:
+        fetch-depth: '0'
+    - uses: actions/setup-go@v2
+      with:
+        go-version: ">=1.16"
+    - name: Install git-po-helper
+      run: |
+        go install github.com/git-l10n/git-po-helper@main
+    - name: Install other dependencies
+      run: |
+        sudo apt-get update -q &&
+        sudo apt-get install -q -y gettext
+    - id: check-commits
+      name: Run git-po-helper
+      run: |
+        if test "${{ github.event_name }}" = "pull_request"
+        then
+          commit_from=${{ github.event.pull_request.base.sha }}
+          commit_to=${{ github.event.pull_request.head.sha }}
+        else
+          commit_from=${{ github.event.before }}
+          commit_to=${{ github.event.after }}
+          if ! echo $commit_from | grep -q "^00*$"
+          then
+            if ! git rev-parse "$commit_from^{commit}"
+            then
+              git fetch origin $commit_from
+            fi
+          fi
+        fi
+        exit_code=0
+        git-po-helper check-commits --github-action -- \
+          $commit_from..$commit_to >git-po-helper.out 2>&1 ||
+        exit_code=$?
+        echo "::set-output name=exit_code::$exit_code"
+        has_error_msg=
+        has_warning_msg=
+        if test $exit_code -ne 0
+        then
+          has_error_msg=yes
+          if test "${{ github.event_name }}" = "pull_request"
+          then
+            echo "ERROR_MSG<<EOF" >>$GITHUB_ENV
+            grep -v -e "^level=warning" -e WARNING git-po-helper.out |
+              perl -pe 's/\e\[[0-9;]*m//g' >>$GITHUB_ENV
+            echo "EOF" >>$GITHUB_ENV
+          fi
+        fi
+        if grep -q -e "^level=warning" -e WARNING git-po-helper.out
+        then
+          has_warning_msg=yes
+          if test "${{ github.event_name }}" = "pull_request"
+          then
+            echo "WARNING_MSG<<EOF" >>$GITHUB_ENV
+            grep -v -e "^level=error" -e ERROR git-po-helper.out |
+              perl -pe 's/\e\[[0-9;]*m//g' >>$GITHUB_ENV
+            echo "EOF" >>$GITHUB_ENV
+          fi
+        fi
+        echo "::set-output name=has_error_msg::$has_error_msg"
+        echo "::set-output name=has_warning_msg::$has_warning_msg"
+    - name: Report errors in comment for pull request
+      uses: mshick/add-pr-comment@v1
+      if: steps.check-commits.outputs.has_error_msg == 'yes' && github.event_name == 'pull_request'
+      continue-on-error: true
+      with:
+        repo-token: ${{ secrets.GITHUB_TOKEN }}
+        repo-token-user-login: 'github-actions[bot]'
+        message: |
+          Errors found by git-po-helper in workflow ${{ github.workflow }}:
+          ```
+          ${{ env.ERROR_MSG }}
+          ```
+    - name: Report warnings in comment for pull request
+      uses: mshick/add-pr-comment@v1
+      if: steps.check-commits.outputs.has_warning_msg == 'yes' && github.event_name == 'pull_request'
+      continue-on-error: true
+      with:
+        repo-token: ${{ secrets.GITHUB_TOKEN }}
+        repo-token-user-login: 'github-actions[bot]'
+        message: |
+          Warnings found by git-po-helper in workflow ${{ github.workflow }}:
+          ```
+          ${{ env.WARNING_MSG }}
+          ```
+    - name: Report and quit
+      run: |
+        if test "${{ steps.check-commits.outputs.has_error_msg }}" = "yes"
+        then
+          echo "::group::Errors found by git-po-helper"
+          grep -v -e "^level=warning" -e WARNING git-po-helper.out
+          echo "::endgroup::"
+        fi
+        if test "${{ steps.check-commits.outputs.has_warning_msg }}" = "yes"
+        then
+          echo "::group::Warnings found by git-po-helper"
+          grep -v -e "^level=error" -e ERROR git-po-helper.out
+          echo "::endgroup::"
+        fi
+        if test ${{ steps.check-commits.outputs.exit_code }} -ne 0
+        then
+          exit ${{ steps.check-commits.outputs.exit_code }}
+        fi
-- 
2.33.0

