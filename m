Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B8AC7EE23
	for <git@archiver.kernel.org>; Sun, 28 May 2023 10:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjE1KAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 May 2023 06:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1KAF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2023 06:00:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313A3B9
        for <git@vger.kernel.org>; Sun, 28 May 2023 03:00:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-309382efe13so1377349f8f.2
        for <git@vger.kernel.org>; Sun, 28 May 2023 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685268001; x=1687860001;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BuH6Hmtl39jdHzinfr2GUp+6i8L+Kk7QBwOIV9LTeI=;
        b=iKRfbVKZwJJMj6ZJhHLfXBlDsDXlYi+yNPqhKu+IcDaUFmwbAyW3JBkQky/vYSaWpo
         jSRGgGvGrWnQifN0EVPRGqcEfouRJ6dXcUp2fLKgHF/fUcCRCih1v7R7iBcyuR0DYtO1
         jTP3PEUDWpHEeOnofylo4yqJWilqHKRVfw31Ohd4wwk+DNvVhbjq63hgvThaHoQhMDFK
         yU0lIg4ZkGI9PZsWHx2mU8qSVBftnrSdca7Iijf3ne0ZYuxX/D2Dmf8sVva1/9FFee1L
         +XakvDWwOSAZ6mLebBqULg3ERWVuuK/mfQOisGjBqv3uJq6E2TUn/Ro3mhwttGNLOk5X
         NmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685268001; x=1687860001;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BuH6Hmtl39jdHzinfr2GUp+6i8L+Kk7QBwOIV9LTeI=;
        b=Xk5xRdArO0iRl+b0X9/l2H9wdv4wHvtHlVUpptv3il3Kin7Jr6sEI7XHr/sAACPY/B
         fQsbx91bKSlIkHDraWShlPgmrC33vHJ/74QK0ZIE48KzoyFWS9zaRJ4QF40iYc3vvvsc
         UoL73zO/xZr0M2LWH61RUYhh3Wm+8sezrF9KYt+F1l8bBrT5pPsbfglQmxj/OmH4hzG6
         tc+qEhNHr4MAuSlFh38GDpxwuMrplNuEIZ5XVc8L2R0PgUXxrdVB90H9FsHyP0jBPqDz
         MVcc4f8ZaGTpuVWZgDmgkQaLD2id5hH7GarR7490Iautcu+0tCEodW+gwxmRPlLqZqh2
         NBcg==
X-Gm-Message-State: AC+VfDxZg3XIdB80W1NJq5qtl59RcbcIz5t+8nwjVCobc7WCXvc+qqGY
        Gcv8GiLicBuhY2Ne5J/YKG7goeyRUHA=
X-Google-Smtp-Source: ACHHUZ7lsgkevS0+EdDrOR6sRzkb14uT7/qDxwXIUgqGZCoaHXOB3xgkOgaYgkAdI+rgiNg3pN/xaQ==
X-Received: by 2002:a5d:650c:0:b0:309:46f5:cea7 with SMTP id x12-20020a5d650c000000b0030946f5cea7mr5815026wru.17.1685268001077;
        Sun, 28 May 2023 03:00:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12-20020adfe80c000000b002fe13ec49fasm10272167wrm.98.2023.05.28.03.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 03:00:00 -0700 (PDT)
Message-Id: <pull.1257.v3.git.1685267999.gitgitgadget@gmail.com>
In-Reply-To: <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>
References: <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 May 2023 09:59:56 +0000
Subject: [PATCH v3 0/3] apply: support case-only renames in case-insensitive filesystems
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As suggested almost a year ago in thread
CAPMMpojwV+f=z9sgc_GaUOTFBCUVdbrGW8WjatWWmC3WTcsoXw@mail.gmail.com,
proposing a fix to git-apply for case-only renames on case-insensitive
filesystems.

Changes in V3:

 * Rebased onto recent main
 * Renumbered now-duplicate-number test t4141 to t4142
 * Removed "RFC" prefix to officially submit; I don't see a better
   direction, and haven't received any corresponding feedback

As mentioned in V2, I'm not super-happy with the duplication of filename
tracking tables, but I do think this bug needs to be fixed, and I don't see
any other way to do so. The fundamental rule this change implements is that
filesystem filename duplication checks should respect the core.ignorecase
option, but index filename duplication checks should not.

Junio C Hamano (1):
  t4142: test "git apply" with core.ignorecase

Tao Klerks (2):
  reset: new failing test for reset of case-insensitive duplicate in
    index
  apply: support case-only renames in case-insensitive filesystems

 apply.c                |  81 +++++++++----
 apply.h                |   5 +-
 t/t4142-apply-icase.sh | 258 +++++++++++++++++++++++++++++++++++++++++
 t/t7104-reset-hard.sh  |  11 ++
 4 files changed, 334 insertions(+), 21 deletions(-)
 create mode 100755 t/t4142-apply-icase.sh


base-commit: 4a714b37029a4b63dbd22f7d7ed81f7a0d693680
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1257%2FTaoK%2Ftao-apply-case-insensitive-renames-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1257/TaoK/tao-apply-case-insensitive-renames-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1257

Range-diff vs v2:

 1:  efd3bd4cdda ! 1:  8ad60943c66 t4141: test "git apply" with core.ignorecase
     @@ Metadata
      Author: Junio C Hamano <gitster@pobox.com>
      
       ## Commit message ##
     -    t4141: test "git apply" with core.ignorecase
     +    t4142: test "git apply" with core.ignorecase
      
          Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
     - ## t/t4141-apply-icase.sh (new) ##
     + ## t/t4142-apply-icase.sh (new) ##
      @@
      +#!/bin/sh
      +
 2:  1226fbd3caf = 2:  ab1cdd95e03 reset: new failing test for reset of case-insensitive duplicate in index
 3:  04d83283716 ! 3:  52359738532 apply: support case-only renames in case-insensitive filesystems
     @@ Commit message
          account for case-insensitive filesystems yet.
      
          Because the index is inherently case-sensitive even on a
     -    case-insensitive filesystem, we actually need this mechanism to be
     +    case-insensitive filesystem, we actually need this mechanism to
          handle both requirements, lest we fail to account for conflicting
          files only in the index.
      
     @@ apply.c: void clear_apply_state(struct apply_state *state)
      +	 */
       }
       
     - static void mute_routine(const char *msg, va_list params)
     + static void mute_routine(const char *msg UNUSED, va_list params UNUSED)
      @@ apply.c: static int read_file_or_gitlink(const struct cache_entry *ce, struct strbuf *buf
       	return read_blob_object(buf, &ce->oid, ce->ce_mode);
       }
     @@ apply.h: struct apply_state {
       	/*
       	 * This is to save reporting routines before using
      
     - ## t/t4141-apply-icase.sh ##
     -@@ t/t4141-apply-icase.sh: test_expect_success setup '
     + ## t/t4142-apply-icase.sh ##
     +@@ t/t4142-apply-icase.sh: test_expect_success setup '
              git diff HEAD HEAD^ -- file1 >deletion-patch &&
              git diff --cached HEAD -- file1 file2 >rename-file1-to-file2-patch &&
              git diff --cached HEAD -- file1 File1 >rename-file1-to-File1-patch &&
     @@ t/t4141-apply-icase.sh: test_expect_success setup '
       '
       
       # Basic creation, deletion, modification and renaming.
     -@@ t/t4141-apply-icase.sh: test_expect_success 'creation and deletion' '
     +@@ t/t4142-apply-icase.sh: test_expect_success 'creation and deletion' '
              test_must_fail git rev-parse --verify :file1
       '
       
     @@ t/t4141-apply-icase.sh: test_expect_success 'creation and deletion' '
              # start at "initial" with file0 only
              git reset --hard initial &&
       
     -@@ t/t4141-apply-icase.sh: test_expect_success 'modificaiton' '
     +@@ t/t4142-apply-icase.sh: test_expect_success 'modificaiton' '
              test_cmp_rev :file0 "$file0blob"
       '
       
     @@ t/t4141-apply-icase.sh: test_expect_success 'modificaiton' '
              # start from file0 and file1
              git reset --hard current &&
       
     -@@ t/t4141-apply-icase.sh: test_expect_success 'rename file1 to file2' '
     +@@ t/t4142-apply-icase.sh: test_expect_success 'rename file1 to file2' '
              test_cmp_rev :file1 "$file1blob"
       '
       
     @@ t/t4141-apply-icase.sh: test_expect_success 'rename file1 to file2' '
              # start from file0 and file1
              git reset --hard current &&
       
     -@@ t/t4141-apply-icase.sh: test_expect_success 'rename file1 to file2' '
     +@@ t/t4142-apply-icase.sh: test_expect_success 'rename file1 to file2' '
              test_cmp_rev :file1 "$file1blob"
       '
       

-- 
gitgitgadget
