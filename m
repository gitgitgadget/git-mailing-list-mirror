Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DBBC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiLTAfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiLTAfv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:35:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E06390
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:35:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bx10so10355372wrb.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaxB4TDvFY6IjQ/AEvYrgoOXa634CrYt+bm29Bdac4g=;
        b=oTNyG15/iwxteht8fa+kXtgdcZ99UiRZa+bce4Rw82a6f9I3Z5lRkBJ1Yf8PZaKaHh
         C8XGu35ymdayH8wlgukZSm2njd9pIFTpxJJqFghXaaB69fWJW8xW1GvbDBKoLIue2QEq
         sGqAirrR+slMZFEbnaZTO7Wk9ND2evunZOKB558k6IYufaxWstMfaqk2yHeUQiv5tRZx
         vt24sq6MLBlNZpCaxKlGoVcTlUBgucZbRmjgX+yBt6o26OXzyvAweuklsbLqV8GfBpc/
         K24ktn6DxATfl2c5lhOoYtlUCKTjj/5MBxHQtjMmMK69OUnuDUZW6UF5k//2HJm8DrTd
         dNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaxB4TDvFY6IjQ/AEvYrgoOXa634CrYt+bm29Bdac4g=;
        b=098murXoh8I3KwfKYLNxS+1ZOw1cQYGm/dh6ymzupfmI9mq/i+o79yoQ06Zk7b6TO9
         oPnUk633nFpmWw1yj+6HKEHd8HuVXaAALu5iN1dD04IGwQjPoeAOiiu0/xQRkuwS5HKQ
         F3THPHQut8OWbwAKNkE8/Dr3PFX0BHBWJehxdjzCI5x8MRS6IxK4qNOjAmTFhVGb3ex1
         mmoyHCJw+QA7G2+Unozl8cEeFGuenC0r6arg0f3I/LpkpKxwa0byFUbZExVTtWc0WQwe
         a/wzdOtPfXOnLI8ydhTD890kZQIlA/duRfIWiQd0EUtKnLI6jvgqdEFTvIpvHD1rNxsF
         BQyw==
X-Gm-Message-State: ANoB5plPgmgm3h+ibZstlxgq+E+KVk1BGb6GFJMPPokZ2CtzBAXdjYEP
        2AYYa8bBDxZ6E/AatHSz19s+wqCuBYk=
X-Google-Smtp-Source: AA0mqf5u3w2YNvOalcmIcw4asuMU05dPjLwRXo/zNxEpsZaQI8ZLvWfoS7pEK8C8FGXZJdOpl1oHqg==
X-Received: by 2002:adf:fb48:0:b0:236:57de:1462 with SMTP id c8-20020adffb48000000b0023657de1462mr26050366wrs.29.1671496549225;
        Mon, 19 Dec 2022 16:35:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b00228cbac7a25sm11191528wrm.64.2022.12.19.16.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:35:48 -0800 (PST)
Message-Id: <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com>
In-Reply-To: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
From:   "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 00:35:44 +0000
Subject: [PATCH v2 0/3] Make check-whitespace failures more helpful
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Chris. Webster" <chris@webstech.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the errors to the job summary along with suggested commands to fix the
problem. The commits and filenames are links.

This is for issue #1395. Sample job output
[https://github.com/webstech/check-whitespace/actions/runs/3707382446]:

❌ A whitespace issue was found in one or more of the commits.

Run these commands to correct the problem:

1. git rebase --whitespace=fix aaa04a9
2. git push --force

Errors:

1. --- 5cd37f6 Remove annotations
   trailing.txt:4: trailing whitespace.
   +
   trailing.txt:2: new blank line at EOF.


Chris. Webster (3):
  ci (check-whitespace): suggest fixes for errors
  ci (check-whitespace): add links to job output
  ci (check-whitespace): move to actions/checkout@v3

 .github/workflows/check-whitespace.yml | 57 +++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 11 deletions(-)


base-commit: 57e2c6ebbe7108b35ba30184dcbcb6c34c929ad8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1444%2Fwebstech%2Fwhitespace-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1444/webstech/whitespace-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1444

Range-diff vs v1:

 1:  67f60e4e5cb ! 1:  a2b5f3e87d6 Make `check-whitespace` failures more helpful
     @@ Metadata
      Author: Chris. Webster <chris@webstech.net>
      
       ## Commit message ##
     -    Make `check-whitespace` failures more helpful
     +    ci (check-whitespace): suggest fixes for errors
      
     -    Add the errors to the job summary along with suggested
     -    commands to fix the problem.
     +    Make the errors more visible by adding them to the job summary and
     +    display the git commands that will usually fix the problem.
      
          Signed-off-by: Chris. Webster <chris@webstech.net>
      
       ## .github/workflows/check-whitespace.yml ##
      @@ .github/workflows/check-whitespace.yml: jobs:
     -   check-whitespace:
     -     runs-on: ubuntu-latest
     -     steps:
     --    - uses: actions/checkout@v2
     -+    - uses: actions/checkout@v3
     -       with:
     -         fetch-depth: 0
     - 
           - name: git log --check
             id: check_out
             run: |
 2:  cdc2b1aae81 ! 2:  342167ef5bd Improve check-whitespace output
     @@ Metadata
      Author: Chris. Webster <chris@webstech.net>
      
       ## Commit message ##
     -    Improve check-whitespace output
     +    ci (check-whitespace): add links to job output
      
          A message in the step log will refer to the Summary output.
      
     -    The job summary output now has links to the commits and files.
     +    The job summary output is using markdown to improve readability.  The
     +    git commands and commits with errors are now in ordered lists.
     +    Commits and files in error are links to the user's repository.
      
          Signed-off-by: Chris. Webster <chris@webstech.net>
      
 -:  ----------- > 3:  aa8cd940940 ci (check-whitespace): move to actions/checkout@v3

-- 
gitgitgadget
