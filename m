Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A806CE7A81
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjIYLvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjIYLvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:51:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F16EE
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405621baba7so32317995e9.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695642663; x=1696247463; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCSovQb9UsfxscadtXn6GfEXchznfsWUBvyWMh+Tx70=;
        b=Fk7TAOHRqvdqGiYdb1AWIFvQultx5AC85ADYxAAMnZVBPgz+9pp0uqOuOIIUJvxo0+
         aWzaWtyd6REZsspNvmyvSssb+HEZx+XkHAQIAAURJmVS6tHr7VnaNFjYWNimmBMFF9lN
         hBNn0wbNNy3d6DXADIGMCYyUvPghq2SOvnL8gwYhMwNGIsIJFQDCCAArE/Swsd3i/JlX
         lwsp2vQpSXUhQpGeZQhXrZG2ZFz0OhPgFVNZZugUyww5Af6X1JkJAf9vToQk3JoGgRL0
         ZSHyOtcK/XkIZlXhO4wv/MyPY3Jr7iPxaa6pWNH1AE6w1MeOfnx0VBxQyn8K9A4AV2KN
         SzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642663; x=1696247463;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCSovQb9UsfxscadtXn6GfEXchznfsWUBvyWMh+Tx70=;
        b=bGkaubTQ6+S0oyDJSob/YkzGI/gIANrL/z3IxnZ0XX3w7CHsZ/JtQNdoLb/lOzjVvR
         4CZ+qbb49AW4IvYkFYlMVzUzEHAXp29RL2L4cyfkKhGQrgh2tMEpoSmsDaJNzdtq75g1
         WlQiD0FvSDc/yE1cIkKcXxSm3jf//FzHKy7xWudXje1my26pp4dPMJCNb/0jziSIAbHC
         tRPGTNjbLjc7zxpRutHLRdm426piJFUF19KMwuctIjUiDH6TQvVoE/P8+9ib2sa2PHbU
         BGLIROsilxkIWzLv7se2AEAY8VHNxMz+HQ0lqAgVo7qDbHd7bQM48b5UTcTrBpIyM55j
         cQfQ==
X-Gm-Message-State: AOJu0YwwMj8BOoXgy4AgOVT9fnRkJEgizxL88NXdEjQawZnW50ZtshBU
        RiFfo6IU05yT6T0I5bwGFEsUq2/MxZs=
X-Google-Smtp-Source: AGHT+IEMfzTs6UJJGyDrlrTYKbObWCPzuJIMCPwowRsDeSamkt4T84Gk/LGSvMlEel/+42Ye5qIUJg==
X-Received: by 2002:a05:600c:280b:b0:404:732b:674f with SMTP id m11-20020a05600c280b00b00404732b674fmr5324656wmb.34.1695642663281;
        Mon, 25 Sep 2023 04:51:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bca4f000000b003fe4548188bsm14674373wml.48.2023.09.25.04.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:51:03 -0700 (PDT)
Message-ID: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
In-Reply-To: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:50:56 +0000
Subject: [PATCH v2 0/6] Add a GitHub workflow to submit builds to Coverity Scan
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coverity [https://scan.coverity.com/] is a powerful static analysis tool
that helps prevent vulnerabilities. It is free to use by open source
projects, and Git benefits from this, as well as Git for Windows. As is the
case with many powerful tools, using Coverity comes with its own set of
challenges, one of which being that submitting a build is quite laborious.

The help with this, the Git for Windows project created an Azure Pipeline to
automate submitting builds to Coverity Scan
[https://dev.azure.com/git-for-windows/git/_build/index?definitionId=35]
which is ported to a GitHub workflow in this here patch series, keeping an
eye specifically on allowing both the Git and the Git for Windows project to
use this workflow.

Since Coverity build submissions require authentication, this workflow is
skipped by default. To enable it, the repository variable
[https://docs.github.com/en/actions/learn-github-actions/variables]
ENABLE_COVERITY_SCAN_FOR_BRANCHES needs to be added. Its value needs to be a
JSON string array containing the branch names, e.g. ["master", "next"].
Further, two repository secrets
[https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions]
need to be set: COVERITY_SCAN_EMAIL and COVERITY_SCAN_TOKEN.

An example run in the Git for Windows project can be admired here
[https://github.com/git-for-windows/git/actions/runs/6298399881].

Note: While inspired by vapier/coverity-scan-action
[https://github.com/vapier/coverity-scan-action], I found too many
limitations in that Action to be used here. However, I would be willing to
fork that Action into the git organization on GitHub, improve the code to
accommodate Git's needs, and maintain that Action, if there is enough
support for taking that route instead of simply hard-coding the steps in
Git's .github/workflows/coverity.yml.

This patch series is based on v2.42.0, but would apply literally everywhere
because it adds a new file and modifies no existing one.

Changes since v1:

 * After verifying that cURL's --fail option does what we need in Coverity's
   context, I switched to using that in every curl invocation.
 * Adjusted quoting (the ${{ ... }} constructs do not require double quotes
   because they are interpolated before the script is run).
 * Touched up a few commit messages, based on the feedback I received.
 * Addressed an actionlint [https://rhysd.github.io/actionlint/] warning.

Johannes Schindelin (6):
  ci: add a GitHub workflow to submit Coverity scans
  coverity: cache the Coverity Build Tool
  coverity: allow overriding the Coverity project
  coverity: support building on Windows
  coverity: allow running on macOS
  coverity: detect and report when the token or project is incorrect

 .github/workflows/coverity.yml | 163 +++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 .github/workflows/coverity.yml


base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1588%2Fdscho%2Fcoverity-workflow-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1588/dscho/coverity-workflow-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1588

Range-diff vs v1:

 1:  8cb92968c5e ! 1:  46fb6b583d3 ci: add a GitHub workflow to submit Coverity scans
     @@ .github/workflows/coverity.yml (new)
      +      - name: download the Coverity Build Tool (${{ env.COVERITY_LANGUAGE }} / ${{ env.COVERITY_PLATFORM}})
      +        run: |
      +          curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
     -+            --no-progress-meter \
     ++            --fail --no-progress-meter \
      +            --output $RUNNER_TEMP/cov-analysis.tgz \
     -+            --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT"
     ++            --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
     ++            --form project="$COVERITY_PROJECT"
      +      - name: extract the Coverity Build Tool
      +        run: |
      +          mkdir $RUNNER_TEMP/cov-analysis &&
     @@ .github/workflows/coverity.yml (new)
      +      - name: submit the build to Coverity Scan
      +        run: |
      +          curl \
     -+            --form token="${{ secrets.COVERITY_SCAN_TOKEN }}" \
     -+            --form email="${{ secrets.COVERITY_SCAN_EMAIL }}" \
     ++            --fail \
     ++            --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
     ++            --form email='${{ secrets.COVERITY_SCAN_EMAIL }}' \
      +            --form file=@cov-int.tgz \
     -+            --form version="${{ github.sha }}" \
     ++            --form version='${{ github.sha }}' \
      +            "https://scan.coverity.com/builds?project=$COVERITY_PROJECT"
 2:  8420a76eba3 ! 2:  e26545b1ed9 coverity: cache the Coverity Build Tool
     @@ .github/workflows/coverity.yml: jobs:
      +        id: lookup
      +        run: |
      +          MD5=$(curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
     -+                   --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT&md5=1")
     ++                   --fail \
     ++                   --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
     ++                   --form project="$COVERITY_PROJECT" \
     ++                   --form md5=1) &&
      +          echo "hash=$MD5" >>$GITHUB_OUTPUT
      +
      +      # Try to cache the tool to avoid downloading 1GB+ on every run.
     @@ .github/workflows/coverity.yml: jobs:
      +        if: steps.cache.outputs.cache-hit != 'true'
               run: |
                 curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
     -             --no-progress-meter \
     -             --output $RUNNER_TEMP/cov-analysis.tgz \
     -             --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT"
     +             --fail --no-progress-meter \
     +@@ .github/workflows/coverity.yml: jobs:
     +             --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
     +             --form project="$COVERITY_PROJECT"
             - name: extract the Coverity Build Tool
      +        if: steps.cache.outputs.cache-hit != 'true'
               run: |
 3:  6c1c8286281 = 3:  ea85e351233 coverity: allow overriding the Coverity project
 4:  14cdefff082 ! 4:  84e1c3eede8 coverity: support building on Windows
     @@ Commit message
          value, say, `["windows-latest"]`, this GitHub workflow now runs on
          Windows, allowing to analyze Windows-specific issues.
      
     +    This allows, say, the Git for Windows fork to submit Windows builds to
     +    Coverity Scan instead of Linux builds.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## .github/workflows/coverity.yml ##
     @@ .github/workflows/coverity.yml: name: Coverity
             COVERITY_PROJECT: ${{ vars.COVERITY_PROJECT || 'git' }}
             COVERITY_LANGUAGE: cxx
      -      COVERITY_PLATFORM: linux64
     ++      COVERITY_PLATFORM: overridden-below
           steps:
             - uses: actions/checkout@v3
      +      - name: install minimal Git for Windows SDK
     @@ .github/workflows/coverity.yml: name: Coverity
      +          echo "COVERITY_PLATFORM=$COVERITY_PLATFORM" >>$GITHUB_ENV
      +          echo "COVERITY_TOOL_FILENAME=$COVERITY_TOOL_FILENAME" >>$GITHUB_ENV
                 MD5=$(curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
     -                    --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT&md5=1")
     -           echo "hash=$MD5" >>$GITHUB_OUTPUT
     +                    --fail \
     +                    --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
      @@ .github/workflows/coverity.yml: jobs:
               run: |
                 curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
     -             --no-progress-meter \
     +             --fail --no-progress-meter \
      -            --output $RUNNER_TEMP/cov-analysis.tgz \
      +            --output $RUNNER_TEMP/$COVERITY_TOOL_FILENAME \
     -             --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT"
     +             --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
     +             --form project="$COVERITY_PROJECT"
             - name: extract the Coverity Build Tool
               if: steps.cache.outputs.cache-hit != 'true'
               run: |
 5:  782cf2b4403 ! 5:  3d24b6f3b22 coverity: allow running on macOS
     @@ .github/workflows/coverity.yml: jobs:
                 echo "COVERITY_TOOL_FILENAME=$COVERITY_TOOL_FILENAME" >>$GITHUB_ENV
      +          echo "MAKEFLAGS=$MAKEFLAGS" >>$GITHUB_ENV
                 MD5=$(curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
     -                    --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT&md5=1")
     -           echo "hash=$MD5" >>$GITHUB_OUTPUT
     +                    --fail \
     +                    --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
      @@ .github/workflows/coverity.yml: jobs:
                   mkdir $RUNNER_TEMP/cov-analysis &&
                   tar -xzf $RUNNER_TEMP/$COVERITY_TOOL_FILENAME --strip 1 -C $RUNNER_TEMP/cov-analysis
 6:  458bc2ea91f ! 6:  b45cc4b8a25 coverity: detect and report when the token or project is incorrect
     @@ Commit message
          either an incorrect token, or even more likely due to an incorrect
          Coverity project name.
      
     -    Let's detect that scenario and provide a helpful error message instead
     -    of trying to go forward with an empty string instead of the correct MD5.
     +    Seeing an authorization failure that is caused by an incorrect project
     +    name was somewhat surprising to me when developing the Coverity
     +    workflow, as I found such a failure suggestive of an incorrect token
     +    instead.
     +
     +    So let's provide a helpful error message about that specifically when
     +    encountering authentication issues.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## .github/workflows/coverity.yml ##
      @@ .github/workflows/coverity.yml: jobs:
     -           echo "COVERITY_TOOL_FILENAME=$COVERITY_TOOL_FILENAME" >>$GITHUB_ENV
     -           echo "MAKEFLAGS=$MAKEFLAGS" >>$GITHUB_ENV
     -           MD5=$(curl https://scan.coverity.com/download/$COVERITY_LANGUAGE/$COVERITY_PLATFORM \
     -+                   -D "$RUNNER_TEMP"/headers.txt \
     -                    --data "token=${{ secrets.COVERITY_SCAN_TOKEN }}&project=$COVERITY_PROJECT&md5=1")
     -+          http_code="$(sed -n 1p <"$RUNNER_TEMP"/headers.txt)"
     -+          case "$http_code" in
     -+          *200*) ;; # okay
     -+          *401*) # access denied
     -+            echo "::error::incorrect token or project? ($http_code)" >&2
     +                    --fail \
     +                    --form token='${{ secrets.COVERITY_SCAN_TOKEN }}' \
     +                    --form project="$COVERITY_PROJECT" \
     +-                   --form md5=1) &&
     ++                   --form md5=1)
     ++          case $? in
     ++          0) ;; # okay
     ++          *22*) # 40x, i.e. access denied
     ++            echo "::error::incorrect token or project?" >&2
      +            exit 1
      +            ;;
      +          *) # other error
     -+            echo "::error::HTTP error $http_code" >&2
     ++            echo "::error::Failed to retrieve MD5" >&2
      +            exit 1
      +            ;;
      +          esac

-- 
gitgitgadget
