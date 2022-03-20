Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F78C433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 07:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244948AbiCTHR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 03:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbiCTHR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 03:17:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76499C3372
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a1so15511536wrh.10
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nYuTjR/X1Xpml9PawvWN/0/7fBoEGfXzppqrMGYC/yk=;
        b=WNXlHmjG2yyq5RfbMPYBZRFs6gT4PxbwBv7pF3q3oyrmAvizmizMkXOn168wQpobUF
         EEMQUmFd0bL5SFmg8/bmJ7yflNxAwX/oA+MLtqd9tEgu3zaaSnPB8nYN2IESakr66xnw
         yE2Mpi0tUCWa5WCn37YIC7Uy1Dbw+/9Ss9H4InfjfrwFYnH6fG3Ll5EnMjYjm7P4/mms
         +718CtnStqkR5oWWmKVbJFKKmUQiRa6AXj+okTwAy87FH+0lNUG49fyeNmLeRwg2csCO
         VHfFdgXQxkmKA4qp5RT1LE1CTw69QR6fSw9YyMMC3gDkpLbN5nBvhpAIfWO4qwQE2OfV
         pw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nYuTjR/X1Xpml9PawvWN/0/7fBoEGfXzppqrMGYC/yk=;
        b=oUWYTUyKGF9BFosBjVlHZPbu1pP6FoE7Cn8SQc6HgjrZq+P9zpO4e10LTMbluDrYt3
         Bs7eemcnU9VPqYPI8KtGIh1w2/zYlD255JexnjYfxWlrSh61eVHTKnYpRj9E8QC8XWCw
         kIttFx3XBvZV7WmR7uzFQIVQAlyjyL3qMgJsqeyE6I9giwR8uWKVYFAf624lGfaU5SR4
         ex1pVNcLhVRzOWGPbh26wvAlcE0TkgAg4sZiyt6EUcmJO/1tDX1O/sgnR2Kwt+Btj9k0
         n+TH3P6r3ljLRPQl3mebD0IkHfYVtSZCcwlh2ntfNMB19qf5I+AyEAu0+DTobV2hVpln
         nSbw==
X-Gm-Message-State: AOAM533q+IP+y9BMFJy5Y2jsNILfezGKgzgxW5JmZewdyBSPa3yPjT9X
        JtJAK4zFnDM9ZDqO5vfUVU4Ae17D1dY=
X-Google-Smtp-Source: ABdhPJw/qv/50LZag3RsG2JHBQAWImyt5QT4nPAtuh+Idi2+hGyL/9F/dLXguInE8TsZ3HJJxaezXw==
X-Received: by 2002:adf:c188:0:b0:1e6:8ecb:ea5a with SMTP id x8-20020adfc188000000b001e68ecbea5amr13568506wre.711.1647760562735;
        Sun, 20 Mar 2022 00:16:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020a0560001aca00b00203daf3759asm10960634wry.68.2022.03.20.00.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 00:16:01 -0700 (PDT)
Message-Id: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 07:15:53 +0000
Subject: [PATCH v2 0/7] core.fsyncmethod: add 'batch' mode for faster fsyncing of multiple objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2 changes:

 * Change doc to indicate that only some repo updates are batched
 * Null and zero out control variables in do_batch_fsync under
   unplug_bulk_checkin
 * Make batch mode default on Windows.
 * Update the description for the initial patch that cleans up the
   bulk-checkin infrastructure.
 * Rebase onto 'seen' at 0cac37f38f9.

--Original definition-- When core.fsync includes loose-object, we issue an
fsync after every written object. For a 'git-add' or similar command that
adds a lot of files to the repo, the costs of these fsyncs adds up. One
major factor in this cost is the time it takes for the physical storage
controller to flush its caches to durable media.

This series takes advantage of the writeout-only mode of git_fsync to issue
OS cache writebacks for all of the objects being added to the repository
followed by a single fsync to a dummy file, which should trigger a
filesystem log flush and storage controller cache flush. This mechanism is
known to be safe on common Windows filesystems and expected to be safe on
macOS. Some linux filesystems, such as XFS, will probably do the right thing
as well. See [1] for previous discussion on the predecessor of this patch
series.

This series is important on Windows, where loose-objects are included in the
fsync set by default in Git-For-Windows. In this series, I'm also setting
the default mode for Windows to turn on loose object fsyncing with batch
mode, so that we can get CI coverage of the actual git-for-windows
configuration upstream. We still don't actually issue fsyncs for the test
suite since GIT_TEST_FSYNC is set to 0, but we exercise all of the
surrounding batch mode code.

This work is based on 'seen' at . It's dependent on ns/core-fsyncmethod.

[1]
https://lore.kernel.org/git/2c1ddef6057157d85da74a7274e03eacf0374e45.1629856293.git.gitgitgadget@gmail.com/

Neeraj Singh (7):
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  core.fsyncmethod: batched disk flushes for loose-objects
  update-index: use the bulk-checkin infrastructure
  unpack-objects: use the bulk-checkin infrastructure
  core.fsync: use batch mode and sync loose objects by default on
    Windows
  core.fsyncmethod: tests for batch mode
  core.fsyncmethod: performance tests for add and stash

 Documentation/config/core.txt |  7 +++
 builtin/unpack-objects.c      |  3 ++
 builtin/update-index.c        |  6 +++
 bulk-checkin.c                | 92 +++++++++++++++++++++++++++++++----
 bulk-checkin.h                |  2 +
 cache.h                       | 12 ++++-
 compat/mingw.h                |  3 ++
 config.c                      |  4 +-
 git-compat-util.h             |  2 +
 object-file.c                 |  2 +
 t/lib-unique-files.sh         | 36 ++++++++++++++
 t/perf/p3700-add.sh           | 59 ++++++++++++++++++++++
 t/perf/p3900-stash.sh         | 62 +++++++++++++++++++++++
 t/perf/perf-lib.sh            |  4 +-
 t/t3700-add.sh                | 22 +++++++++
 t/t3903-stash.sh              | 17 +++++++
 t/t5300-pack-object.sh        | 32 +++++++-----
 17 files changed, 340 insertions(+), 25 deletions(-)
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh


base-commit: 0cac37f38f94bb93550eb164b5d574cd96e23785
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1134%2Fneerajsi-msft%2Fns%2Fbatched-fsync-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1134/neerajsi-msft/ns/batched-fsync-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1134

Range-diff vs v1:

 1:  a77d02df626 ! 1:  9c2abd12bbb bulk-checkin: rename 'state' variable and separate 'plugged' boolean
     @@ Metadata
       ## Commit message ##
          bulk-checkin: rename 'state' variable and separate 'plugged' boolean
      
     -    Preparation for adding bulk-fsync to the bulk-checkin.c infrastructure.
     +    This commit prepares for adding batch-fsync to the bulk-checkin
     +    infrastructure.
     +
     +    The bulk-checkin infrastructure is currently used to batch up addition
     +    of large blobs to a packfile. When a blob is larger than
     +    big_file_threshold, we unconditionally add it to a pack. If bulk
     +    checkins are 'plugged', we allow multiple large blobs to be added to a
     +    single pack until we reach the packfile size limit; otherwise, we simply
     +    make a new packfile for each large blob. The 'unplug' call tells us when
     +    the series of blob additions is done so that we can finish the packfiles
     +    and make their objects available to subsequent operations.
     +
     +    Stated another way, bulk-checkin allows callers to define a transaction
     +    that adds multiple objects to the object database, where the object
     +    database can optimize its internal operations within the transaction
     +    boundary.
     +
     +    Batched fsync will fit into bulk-checkin by taking advantage of the
     +    plug/unplug functionality to determine the appropriate time to fsync
     +    and make newly-added objects available in the primary object database.
      
          * Rename 'state' variable to 'bulk_checkin_state', since we will later
            be adding 'bulk_fsync_objdir'.  This also makes the variable easier to
 2:  d38f20b4430 ! 2:  3ed1dcd9b9b core.fsyncmethod: batched disk flushes for loose-objects
     @@ Documentation/config/core.txt: core.fsyncMethod::
         filesystem and storage hardware, data added to the repository may not be
         durable in the event of a system crash. This is the default mode on macOS.
      +* `batch` enables a mode that uses writeout-only flushes to stage multiple
     -+  updates in the disk writeback cache and then a single full fsync to trigger
     -+  the disk cache flush at the end of the operation. This mode is expected to
     ++  updates in the disk writeback cache and then does a single full fsync of
     ++  a dummy file to trigger the disk cache flush at the end of the operation.
     ++  Currently `batch` mode only applies to loose-object files. Other repository
     ++  data is made durable as if `fsync` was specified. This mode is expected to
      +  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
      +  and on Windows for repos stored on NTFS or ReFS filesystems.
       
     @@ bulk-checkin.c: clear_exit:
      +		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
      +		delete_tempfile(&temp);
      +		strbuf_release(&temp_path);
     ++		needs_batch_fsync = 0;
      +	}
      +
     -+	if (bulk_fsync_objdir)
     ++	if (bulk_fsync_objdir) {
      +		tmp_objdir_migrate(bulk_fsync_objdir);
     ++		bulk_fsync_objdir = NULL;
     ++	}
      +}
      +
       static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
 3:  b0480f0c814 = 3:  54797dbc520 update-index: use the bulk-checkin infrastructure
 4:  99e3a61b919 = 4:  6662e2dae0f unpack-objects: use the bulk-checkin infrastructure
 5:  4e56c58c8cb ! 5:  03bf591742a core.fsync: use batch mode and sync loose objects by default on Windows
     @@ Commit message
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     -    change fsyncmethod to batch as well
     -
       ## cache.h ##
      @@ cache.h: enum fsync_component {
       			      FSYNC_COMPONENT_INDEX | \
 6:  88e47047d79 = 6:  1937746df47 core.fsyncmethod: tests for batch mode
 7:  876741f1ef9 = 7:  624244078c7 core.fsyncmethod: performance tests for add and stash

-- 
gitgitgadget
