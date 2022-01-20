Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08859C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346016AbiATPMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiATPMS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:18 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A185BC061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso22685962wmj.0
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/FhCO9ZDaP1GLFY6hQaNYX0W530ZaCayGOVNn3urtkg=;
        b=LVseS31cEVGbZ605zxpEwP7QmgtUQuuje2/FKsbxdDLsuN9RyDQv6/I6bJwn8ziqMq
         jaB6LV4WAWqz4SLxV7vl8S/fo0d3yPn9uXL692WN4cshEXBYjlrp4pOZXk+MRESnwdnS
         DeCvT6+AW36jJzr+stdYmeSk7MqGSteWm1S7DYTp/4tAc1M0PqaDnroMdkrBa3OZ7DKq
         gx1wiaI5gYnbOwf0vFuHiBfU88KuqVhrSQYaE0moR/xpZ7YlmrCCyyilXhuAjte8iDy5
         WRyBpVDepoWwyrNyNqykP5KI3HYdvLab81Yxnfb9yFnkWKR7+t7v2ZB9i/Ak9l4YnVHA
         KHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/FhCO9ZDaP1GLFY6hQaNYX0W530ZaCayGOVNn3urtkg=;
        b=yur867IN93Jo1m03ZncEn2Xm+z6HjGqA6fR5/X+EGAO69pxw88LEOHl6AK7RqECcM3
         gtxLxwmmnHC53CA+U5xhVkAvKcgCCLJOFN3Ci59cJyNHOJL3SAe01G83gSbucYtE1NH9
         bv2mB8KQfogT9HfoSwr1FAwyUBjPFDY+hbFS3e5y2UYbavF0eU3NOQFOID31z9hzWXYJ
         NC1r7XuJc8sL5+G/HAhBhL6WVIy/AiagkPkQq/06vlWOltMK1rgXMkRZID+O2JIC6IFw
         FX2p1Wa0VoUT2oXGkUeltdOCL1iZR1QQ0D4jewn0MEshnd2VqXCs+4vYC1/uIO2OtDRf
         UlAg==
X-Gm-Message-State: AOAM533NDyGpH3VXsIehrWCLPPdt42ImebiTcdqox9NPjGyxga8J+4aT
        uIiiwIRqI8G0vmHONZ9zNgZgmPmAD3I=
X-Google-Smtp-Source: ABdhPJx1d7863K/Cd9bLMAQIrkZa3l+IQx/d9Skonj4PFxqbZxRkYgYn7zJNadgfesp4q7g4yf0v5A==
X-Received: by 2002:a5d:6d49:: with SMTP id k9mr34677343wri.530.1642691535883;
        Thu, 20 Jan 2022 07:12:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm3832013wri.89.2022.01.20.07.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:15 -0800 (PST)
Message-Id: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:11:59 +0000
Subject: [PATCH v6 00/15] Reftable coverity fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series was targeted to 'master'.

This addresses some complaints from Coverity that Peff reported.

v6:

 * drop 0-length memcpy paranoia patch.

Han-Wen Nienhuys (15):
  reftable: fix OOB stack write in print functions
  reftable: fix resource leak in block.c error path
  reftable: fix resource leak blocksource.c
  reftable: check reftable_stack_auto_compact() return value
  reftable: ignore remove() return value in stack_test.c
  reftable: fix resource warning
  reftable: all xxx_free() functions accept NULL arguments
  reftable: order unittests by complexity
  reftable: drop stray printf in readwrite_test
  reftable: handle null refnames in reftable_ref_record_equal
  reftable: make reftable-record.h function signatures const correct
  reftable: implement record equality generically
  reftable: remove outdated file reftable.c
  reftable: make reftable_record a tagged union
  reftable: add print functions to the record types

 reftable/block.c           |  28 ++-
 reftable/block_test.c      |  22 +--
 reftable/blocksource.c     |   6 +-
 reftable/generic.c         |  41 +++--
 reftable/iter.c            |   4 +-
 reftable/merged.c          |  33 ++--
 reftable/pq.c              |   3 +-
 reftable/pq_test.c         |  27 ++-
 reftable/reader.c          | 112 ++++++------
 reftable/readwrite_test.c  |  67 ++++++-
 reftable/record.c          | 366 ++++++++++++++++++++++++-------------
 reftable/record.h          |  49 ++---
 reftable/record_test.c     | 197 ++++++++++----------
 reftable/reftable-record.h |  14 +-
 reftable/reftable.c        | 115 ------------
 reftable/stack.c           |  10 +-
 reftable/stack_test.c      |   3 +-
 reftable/writer.c          |  43 +++--
 t/helper/test-reftable.c   |   9 +-
 19 files changed, 620 insertions(+), 529 deletions(-)
 delete mode 100644 reftable/reftable.c


base-commit: 50b2d72e110cad39ecaf2322bfdf1b60cd13dd96
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1152%2Fhanwen%2Freftable-coverity-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1152/hanwen/reftable-coverity-v6
Pull-Request: https://github.com/git/git/pull/1152

Range-diff vs v5:

  1:  e7f1be7bbec =  1:  9218bd59b25 reftable: fix OOB stack write in print functions
  2:  9ab631a3b29 !  2:  315ce62e710 reftable: fix resource leak in block.c error path
     @@ reftable/reader.c: int reader_init_block_reader(struct reftable_reader *r, struc
      +	err = block_reader_init(br, &block, header_off, r->block_size,
      +				hash_size(r->hash_id));
      +done:
     -+	if (err)
     -+		reftable_block_done(&block);
     ++	reftable_block_done(&block);
      +
      +	return err;
       }
     @@ reftable/readwrite_test.c: static void test_log_write_read(void)
      +		},
      +	};
      +
     -+	for (i = 0; i < sizeof(message)-1; i++)
     ++	for (i = 0; i < sizeof(message) - 1; i++)
      +		message[i] = (uint8_t)(rand() % 64 + ' ');
      +
      +	reftable_writer_set_limits(w, 1, 1);
  3:  8301000e83b !  3:  7cf65e141cf reftable: fix resource leak blocksource.c
     @@ Metadata
       ## Commit message ##
          reftable: fix resource leak blocksource.c
      
     -    This would be triggered in the unlikely event of fstat() failing on an opened
     -    file.
     +    This would be triggered in the unlikely event of fstat() failing on an
     +    opened file.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
  4:  e6e53aabc39 =  4:  8740ba92981 reftable: check reftable_stack_auto_compact() return value
  5:  7551bcdd917 =  5:  08be6d90a48 reftable: ignore remove() return value in stack_test.c
  6:  700a4e247e7 !  6:  630f67bdb51 reftable: fix resource warning
     @@ Metadata
       ## Commit message ##
          reftable: fix resource warning
      
     -    This would trigger in the unlikely event that we are compacting, and the next
     -    available file handle is 0.
     +    This would trigger in the unlikely event that we are compacting, and
     +    the next available file handle is 0.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ reftable/stack.c: static int stack_compact_range(struct reftable_stack *st, int
       	have_lock = 1;
       	err = stack_uptodate(st);
      @@ reftable/stack.c: static int stack_compact_range(struct reftable_stack *st, int first, int last,
     - 
     - 		sublock_file_fd = open(subtab_lock.buf,
     - 				       O_EXCL | O_CREAT | O_WRONLY, 0644);
     --		if (sublock_file_fd > 0) {
     -+		if (sublock_file_fd >= 0) {
     - 			close(sublock_file_fd);
     - 		} else if (sublock_file_fd < 0) {
     - 			if (errno == EEXIST) {
     -@@ reftable/stack.c: static int stack_compact_range(struct reftable_stack *st, int first, int last,
       		goto done;
       	}
       	err = close(lock_file_fd);
  7:  30016fee4c8 =  7:  afee67fb60d reftable: all xxx_free() functions accept NULL arguments
  8:  f90846cc103 !  8:  6f4f24c17ad reftable: order unittests by complexity
     @@ Metadata
       ## Commit message ##
          reftable: order unittests by complexity
      
     -    This is a more practical ordering when working on refactorings of the reftable
     -    code.
     +    This is a more practical ordering when working on refactorings of the
     +    reftable code.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
  9:  425e12d3667 =  9:  0abaab1d7c4 reftable: drop stray printf in readwrite_test
 10:  67d858ec59e = 10:  004b7a736bf reftable: handle null refnames in reftable_ref_record_equal
 11:  1e50924894f = 11:  951efcebcd2 reftable: make reftable-record.h function signatures const correct
 12:  c81b17ad57e = 12:  6385e449ba7 reftable: implement record equality generically
 13:  4175089ec43 = 13:  69c4a554882 reftable: remove outdated file reftable.c
 14:  ede2e792ab6 ! 14:  54bcac325bd reftable: make reftable_record a tagged union
     @@ Metadata
       ## Commit message ##
          reftable: make reftable_record a tagged union
      
     -    This reduces the amount of glue code, because we don't need a void pointer or
     -    vtable within the structure.
     +    This reduces the amount of glue code, because we don't need a void
     +    pointer or vtable within the structure.
      
     -    The only snag is that reftable_index_record contain a strbuf, so it cannot be
     -    zero-initialized. To address this, use reftable_new_record() to return fresh
     -    instance, given a record type. Since reftable_new_record() doesn't cause heap
     -    allocation anymore, it should be balanced with reftable_record_release() rather
     -    than reftable_record_destroy().
     +    The only snag is that reftable_index_record contain a strbuf, so it
     +    cannot be zero-initialized. To address this, use reftable_new_record()
     +    to return fresh instance, given a record type. Since
     +    reftable_new_record() doesn't cause heap allocation anymore, it should
     +    be balanced with reftable_record_release() rather than
     +    reftable_record_destroy().
      
          Thanks to Peff for the suggestion.
      
 15:  6c06bd91662 = 15:  82f140cab5c reftable: add print functions to the record types
 16:  e16bf0c5212 <  -:  ----------- reftable: be more paranoid about 0-length memcpy calls

-- 
gitgitgadget
