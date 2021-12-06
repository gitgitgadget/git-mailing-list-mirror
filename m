Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75C3C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 22:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353208AbhLFWIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 17:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhLFWIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 17:08:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA8C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 14:05:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i5so25389321wrb.2
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 14:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jlVz1ZQtXcyNV32nPb+JVM+krpqcCrSNLzaYUS+3oLo=;
        b=A6OK1n+Tl/0maJnOykiTkHyDwC/kHG+oKesXviTt+lK/zV/yvwqwXUiDWifeL9GrvX
         aMbhOkeDAB0etiyvHJW/Qw+DbViW4K33Hj4Rhck/l1lUZyPmVjyWJpKUSPcLdSuNUii9
         4yq8QSG+VL9+a6Rhwtpbe6g5cr4ZvUJSOaXAqYlCtv0Wxkad2h44PFcuPUUoRVCce2UE
         8WWNfo7Fd+HUbZkqvFG7LGeTS4dwvizdJWlaNkLKX9cFQ2AJdVnopJr5O7gCrgiVqXJV
         ytyUSMAWSE6DWO3TZNLVK82AwgXImfB6FtQjEXUav8cBmN9b1G2yv42ltN9NAkP8Ycqr
         cLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jlVz1ZQtXcyNV32nPb+JVM+krpqcCrSNLzaYUS+3oLo=;
        b=J6ZG3TYsJn+/9w98xe/AVXRA/CZ1I3ZTPL9oyMKBAcqQe44vnT9F8YGWbVIfasLzPW
         BQfkDIyKCnJM0El5cp1GioqsyfMltC5CriBBLZ1FmbsaX/2EijlqPlGehl8/Mflf2Fod
         5QjbNYUUuYe1k6F1cWBCk+4uQBQ4ccXN32xalQd6jTdaGlmfsvkdaSkraWVdjmA3Zaff
         uvyaoEh+uQeTiag/qQSAZypKZOOHnyYFSG1fTv3NIop2aAgc0FQVtzvUAs1a5CX/CAFq
         nn1i4anFZhCYz66YOoYcuQFSdq/Bn3wrFx05R5LAvoF+SzAUSetBjBgrRRT9T0G2CEbc
         ah4w==
X-Gm-Message-State: AOAM532yd/RjKfUr+qOb7lOjZn9DpZk494i/XshL+sdQP40KsW8HJcVQ
        CLe5agvJK2jVm76fqY5g9z8trggTM2k=
X-Google-Smtp-Source: ABdhPJw8TtluMtWKS9kHHnQehGTVOZCxCRUJ6sdlizBwmCRz82Ob4jKKfdQuWOUa9jTx3T4k87SpKQ==
X-Received: by 2002:adf:c406:: with SMTP id v6mr46308879wrf.570.1638828306860;
        Mon, 06 Dec 2021 14:05:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm12921841wrt.66.2021.12.06.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:05:06 -0800 (PST)
Message-Id: <pull.1091.v3.git.1638828305.gitgitgadget@gmail.com>
In-Reply-To: <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com>
References: <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 22:05:03 +0000
Subject: [PATCH v3 0/2] ns/tmp-objdir: add support for temporary writable databases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V3 (hopefully final):

 * Fix the commit description for patch [2/2] to reflect the fact that
   disabling ref updates no longer depends on the_repository.
 * Add a link to Jeff King's test case in patch [2/2]. The test relies on
   remerge-diff, so it can't be directly included here.
 * Adjust line spacing in update_relative_gitdir (gitster)
 * Switch struct object_directory to use full-width integers rather than
   flags (gitster)
 * Fix typo s/protentially/potentially (neerajsi)

V2 changes: I lost a couple changes in the shuffle while splitting these
changes out

 * Make the will-destroy boolean a single bit field of type unsigned int so
   that it doesn't change twice in this small patch series.
 * Remove a the_repository reference in the disable ref updates code. Now
   the repository is taken from the ref_store.

New interface into the tmp-objdir API to help in-core use of the quarantine
feature.

This patch series was formerly part of the ns/batched-fsync topic [1]. It's
now split out into its own gitgitgadget PR and discussion thread since it is
the base for en/remerge-diff as well.

The most recent feedback was in [2]. I removed printing from prune_subdir
and simplified the strbuf handling in prune_tmp_file.

References: [1]
https://lore.kernel.org/git/pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/CABPp-BH6m4q_EoX77bqLcpCN1HRfJ_XayeCV2O0sRybX53rPrw@mail.gmail.com/

Neeraj Singh (2):
  tmp-objdir: new API for creating temporary writable databases
  tmp-objdir: disable ref updates when replacing the primary odb

 builtin/prune.c        | 20 ++++++++++++---
 builtin/receive-pack.c |  2 +-
 environment.c          |  9 +++++++
 object-file.c          | 50 ++++++++++++++++++++++++++++++++++++--
 object-store.h         | 26 ++++++++++++++++++++
 object.c               |  2 +-
 refs.c                 |  2 +-
 repository.c           |  2 ++
 repository.h           |  1 +
 tmp-objdir.c           | 55 +++++++++++++++++++++++++++++++++++++++---
 tmp-objdir.h           | 29 +++++++++++++++++++---
 11 files changed, 183 insertions(+), 15 deletions(-)


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1091%2Fneerajsi-msft%2Fns%2Ftmp-objdir-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1091/neerajsi-msft/ns/tmp-objdir-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1091

Range-diff vs v2:

 1:  36c00613d9a ! 1:  cccb3888070 tmp-objdir: new API for creating temporary writable databases
     @@ environment.c: static void update_relative_gitdir(const char *name,
       {
       	char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
      +	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
     ++
       	trace_printf_key(&trace_setup_key,
       			 "setup: move $GIT_DIR to '%s'",
       			 path);
     -+
       	set_git_dir_1(path);
      +	if (tmp_objdir)
      +		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
     @@ object-store.h: struct object_directory {
      +	/*
      +	 * This object store is ephemeral, so there is no need to fsync.
      +	 */
     -+	unsigned int will_destroy : 1;
     ++	int will_destroy;
      +
       	/*
       	 * Path to the alternative object store. If this is a relative path,
     @@ tmp-objdir.h: int tmp_objdir_destroy(struct tmp_objdir *);
       void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
       
      +/*
     -+ * Replaces the main object store in the current process with the temporary
     ++ * Replaces the writable object store in the current process with the temporary
      + * object directory and makes the former main object store an alternate.
      + * If will_destroy is nonzero, the object directory may not be migrated.
      + */
     @@ tmp-objdir.h: int tmp_objdir_destroy(struct tmp_objdir *);
      +struct tmp_objdir *tmp_objdir_unapply_primary_odb(void);
      +
      +/*
     -+ * Reapplies the former primary temporary object database, after protentially
     ++ * Reapplies the former primary temporary object database, after potentially
      + * changing its relative path.
      + */
      +void tmp_objdir_reapply_primary_odb(struct tmp_objdir *, const char *old_cwd,
 2:  f667cbcc47d ! 2:  4e44121c2d7 tmp-objdir: disable ref updates when replacing the primary odb
     @@ Commit message
          the disable_ref_updates flag on the odb, which is queried by
          the ref_transaction_prepare function.
      
     -    Note: This change adds an assumption that the state of
     -    the_repository is relevant for any ref transaction that might
     -    be initiated. Unwinding this assumption should be straightforward
     -    by saving the relevant repository to query in the transaction or
     -    the ref_store.
     -
     -    Peff's test case was invoking ref updates via the cachetextconv
     +    Peff's test case [1] was invoking ref updates via the cachetextconv
          setting. That particular code silently does nothing when a ref
          update is forbidden. See the call to notes_cache_put in
          fill_textconv where errors are ignored.
      
     +    [1] https://lore.kernel.org/git/YVOn3hDsb5pnxR53@coredump.intra.peff.net/
     +
          Reported-by: Jeff King <peff@peff.net>
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
     @@ object-store.h: struct object_directory {
      +	 * facility. Disable ref updates since the objects in the store
      +	 * might be discarded on rollback.
      +	 */
     -+	unsigned int disable_ref_updates : 1;
     ++	int disable_ref_updates;
      +
       	/*
       	 * This object store is ephemeral, so there is no need to fsync.

-- 
gitgitgadget
