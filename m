Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6C4C77B78
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 01:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjDWBHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 21:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjDWBHr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 21:07:47 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154332710
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 18:07:44 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7606d44dbb5so315914639f.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 18:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682212063; x=1684804063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N89M7piNPstDGZ96bQkkLdmhmbCVnC/uU+LyYdnXQI0=;
        b=MRGha72B1ECXpNdyeL7W+HDkiuiTx9pZdFNl7jhu2AdpmaoJGZKb9SdYuaWVNd7fDS
         b5BOAN/qkuH6Apf32JBS0F97u7myshhZ0tkWLtMbFhCZJRC0OZ3pCyOiYqrPflxQl6ji
         5PJdJ/DBAlONf05tKww3wldixSSJHJps1lleT5PksFCaquQuY8DbQUM40tr+XauW7m6Y
         O0Qa9ELrgWF+etLp6B7Q9wMb9igm01VIQwpHKUBPtPzt/nmUiGlE488E3EHJpy+yQxOX
         HHGYU0QgsN6VFjJZPYWUHw+YdWI4qgM9kRgYsScFuG3L8gYb+Vu3lWihIIXloXkL0PTK
         uDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682212063; x=1684804063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N89M7piNPstDGZ96bQkkLdmhmbCVnC/uU+LyYdnXQI0=;
        b=eKr86sWrutLOvZSTpcRxubgTL+BQ46UMOPsYjYbXhXFR1krRoNmJGvz3/wLsUQ3ile
         NNb6+41W3NeiYEra1baa1KsujIbqnrIJE/3cCjYZse/gE/9QTFH+nhJRYJzByNUnNPT0
         bHS5z7ArFzXkGABNN9OQTVSBspeV5yjclaXKTugQS9p3WIEpgCSEJFO8gh7GCDNZCthR
         39xUwWO+fIMzK06n3mEQGsci2bY+FoMKDoUmVnky5eQzOIrLGp7Rzc+fEaKpXQSx4g2O
         FCrXLF37g1ykcT4F2KjlyHU/keXEGjOcotQShhugsvXv0B88nebc/TJsLUVU2x/rxrck
         S9sQ==
X-Gm-Message-State: AAQBX9du7JDAB96bTBKgAbQDpSruxknOH4V9uz0j6Zm3ffwQtoTFOOc2
        QuHoWlGF8QNT27BpqT2MsFFAkl5s1lXsHQ==
X-Google-Smtp-Source: AKy350a/HkM4t08UczCy2FrV3h1J4MPH+bSJ1fxPJHM8UAJBhzH5khVXpFMLjRt6/QDIALFypKfy1A==
X-Received: by 2002:a6b:6809:0:b0:746:1b8:8687 with SMTP id d9-20020a6b6809000000b0074601b88687mr2444547ioc.14.1682212062976;
        Sat, 22 Apr 2023 18:07:42 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id z1-20020a92d6c1000000b0032e28db67dcsm669819ilp.84.2023.04.22.18.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 18:07:42 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v8 0/2] diff-files: integrate with sparse index
Date:   Sat, 22 Apr 2023 21:07:19 -0400
Message-Id: <20230423010721.1402736-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230322161820.3609-1-cheskaqiqi@gmail.com>
References: <20230322161820.3609-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v7:

* Refactor the ensure_expanded and ensure_not_expanded functions by 
introducing a helper function, ensure_index_state.

* Delete the test 'diff-files pathspec expands index when necessary'.

* Delete 'the pathspec_needs_expanded_index' function.

* Add double quotes to "deep/*"

* Change "**a" to "*a"

* Updata commit message.


Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  4 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 81 +++++++++++++++++++++++-
 3 files changed, 85 insertions(+), 2 deletions(-)

Range-diff:
1:  e2dcf9921e ! 1:  d7f921c1a6 t1092: add tests for `git diff-files`
    @@ Commit message
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## t/t1092-sparse-checkout-compatibility.sh ##
    -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep sparse directory within submodules' '
    - 	test_cmp actual expect
    +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded: write-tree' '
    + 	ensure_not_expanded write-tree
      '
      
     +test_expect_success 'diff-files with pathspec inside sparse definition' '
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'grep sparse direc
     +	test_all_match git diff-files deep/a && 
     +
     +	# test wildcard
    -+	test_all_match git diff-files deep/*
    ++	test_all_match git diff-files "deep/*"
     +'
     +
     +test_expect_success 'diff-files with pathspec outside sparse definition' '
2:  fb8edaf583 < -:  ---------- diff-files: integrate with sparse index
-:  ---------- > 2:  b44384ac94 diff-files: integrate with sparse index
-- 
2.39.0

