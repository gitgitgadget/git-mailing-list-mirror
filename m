Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA62C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAB761245
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 15:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhFNPyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:54:22 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:42558 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhFNPyV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 11:54:21 -0400
Received: by mail-wm1-f51.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso261996wms.1
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kD8MGl98wy0ecB3dkV9gUTfjbJCNTzAsPNCuCXnsEwY=;
        b=HG4wpmkzBiT/IyqOe3Qyi+PjqwGjGD2K1nFXVLXNdEyBliVUqj87a+Z1BiAgR4hJDW
         a9h/UmGZHjxW/Exti/lPEeukcx9kMDo5v35KAGgl75+AFNItUhQynxUQxKt9UrIu//Q+
         c/Ta1ntZBnOxnuNHo/W8I8YEm2Vfs6Ju2I60xHf19bhW9sAZywLxEO3aTDmGmh8eJ50U
         TADERPxG6JSzeWNQs3MjofTp1Ojcvb7pjqc8GFl4/c8q6S3CTk/ZxGeqjqnWky9PeY/D
         w3iRyjSp5UVQHUAmgRtsMnPkzn4hrtOBakgyZVskea+kHc46XnF6GRTKT6bYPAiBJuvz
         oC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kD8MGl98wy0ecB3dkV9gUTfjbJCNTzAsPNCuCXnsEwY=;
        b=W9itF9bIDNPwHWM1vL2ibOKvocshzdrjrGUN9DTGiOGbH43sOd2TtXcY2y40afoSU9
         6MJ+UBH+zYs22xsrHdo4XOMRdo0rXIiFAv85Rv5tgx7AA1UMnhacCApp6TrYDsVFc7ao
         Ltj3AkTVb6bd1lWAjT/BIngGZhy7qOLgil2dF1fBsirGr57mhqny6Jx4q5qXhKfhvX/5
         C7Seva/0pR5soifbX6wyA5TACgc+iSI/i5gmPLkWnk3Lt7wohjjGMApQ4LBsiK5kE4QS
         iznTMZ/mgxcnlRPZKbwz+5GfNSbFf39WcgfaENmD9zTP5PBk0MdSA1x9OSglqq7Gck7K
         Zxaw==
X-Gm-Message-State: AOAM533F7Idf6GzlTJ92GxHJA7mz3dXAmdT5FSUGQGirWDXwJnW9kWi1
        jSEeWZiU8wSUEbSHZVH0VDfGiu3Wfz8=
X-Google-Smtp-Source: ABdhPJybXi0wGa/p0w5pHobXocYYecToUVZuudIrYA6S2ujKfOvi6RbLagX3WOhsiy25Ywl5jHuXrg==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr17440574wmh.115.1623685878274;
        Mon, 14 Jun 2021 08:51:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v132sm21281724wmb.14.2021.06.14.08.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:51:17 -0700 (PDT)
Message-Id: <pull.1033.v2.git.git.1623685877.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 15:51:13 +0000
Subject: [PATCH v2 0/3] Fix uninitialised reads found with MSAN
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2 replaces an #if'd memset with some brace initialisation (patch 3/3) as
per review comments.

I've also removed an irrelevant "technically" from commit message 2/3, and
fixed a typo in commit message 3/3.

Andrzej Hunt (3):
  bulk-checkin: make buffer reuse more obvious and safer
  split-index: use oideq instead of memcmp to compare object_id's
  builtin/checkout--worker: zero-initialise struct to avoid MSAN
    complaints

 builtin/checkout--worker.c | 2 +-
 bulk-checkin.c             | 3 +--
 split-index.c              | 3 ++-
 3 files changed, 4 insertions(+), 4 deletions(-)


base-commit: 62a8d224e6203d9d3d2d1d63a01cf5647ec312c9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1033%2Fahunt%2Fmsan-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1033/ahunt/msan-v2
Pull-Request: https://github.com/git/git/pull/1033

Range-diff vs v1:

 1:  7659d4bf13c2 = 1:  7659d4bf13c2 bulk-checkin: make buffer reuse more obvious and safer
 2:  14b0d5dd7fce ! 2:  6943eb511bee split-index: use oideq instead of memcmp to compare object_id's
     @@ Commit message
          include that field when calling memcmp on a subset of the cache_entry.
          Depending on which hashing algorithm is being used, only part of
          object_id.hash is actually being used, therefore including it in a
     -    memcmp() is technically incorrect. Instead we choose to exclude the
     -    object_id when calling memcmp(), and call oideq() separately.
     +    memcmp() is incorrect. Instead we choose to exclude the object_id when
     +    calling memcmp(), and call oideq() separately.
      
          This issue was found when running t1700-split-index with MSAN, see MSAN
          output below (on my machine, offset 76 corresponds to 4 bytes after the
 3:  cd1e1f6985c7 ! 3:  4bdc0b77f6f2 builtin/checkout--worker: memset struct to avoid MSAN complaints
     @@ Metadata
      Author: Andrzej Hunt <ajrhunt@google.com>
      
       ## Commit message ##
     -    builtin/checkout--worker: memset struct to avoid MSAN complaints
     +    builtin/checkout--worker: zero-initialise struct to avoid MSAN complaints
      
          report_result() sends a struct to the parent process, but that struct
     -    contains unintialised padding bytes. Running this code under MSAN
     -    rightly triggers a warning - but we also don't care about this warning
     -    because we control the receiving code, and we therefore know that those
     -    padding bytes won't be read on the receiving end. Therefore we add a
     -    memset to convince MSAN that this memory is safe to read - but only
     -    when building with MSAN to avoid this cost in normal usage.
     +    would contain uninitialised padding bytes. Running this code under MSAN
     +    rightly triggers a warning - but we don't particularly care about this
     +    warning because we control the receiving code, and we therefore know
     +    that those padding bytes won't be read on the receiving end.
     +
     +    We could simply suppress this warning under MSAN with the approporiate
     +    ifdef'd attributes, but a less intrusive solution is to 0-initialise the
     +    struct, which guarantees that the padding will also be initialised.
      
          Interestingly, in the error-case branch, we only try to copy the first
          two members of pc_item_result, by copying only PC_ITEM_RESULT_BASE_SIZE
     @@ Commit message
          after the end of the second last member. We could avoid doing this by
          redefining PC_ITEM_RESULT_BASE_SIZE as
          'offsetof(second_last_member) + sizeof(second_last_member)', but there's
     -    no huge benefit to doing so (and our memset hack silences the MSAN
     -    warning in this scenario either way).
     +    no huge benefit to doing so (and this patch silences the MSAN warning in
     +    this scenario either way).
      
          MSAN output from t2080 (partially interleaved due to the
          parallel work :) ):
     @@ Commit message
          Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
      
       ## builtin/checkout--worker.c ##
     -@@ builtin/checkout--worker.c: static void report_result(struct parallel_checkout_item *pc_item)
     - 	struct pc_item_result res;
     +@@ builtin/checkout--worker.c: static void packet_to_pc_item(const char *buffer, int len,
     + 
     + static void report_result(struct parallel_checkout_item *pc_item)
     + {
     +-	struct pc_item_result res;
     ++	struct pc_item_result res = { 0 };
       	size_t size;
       
     -+#if defined(__has_feature)
     -+#  if __has_feature(memory_sanitizer)
     -+	// MSAN workaround: res contains padding bytes, which will remain
     -+	// permanently unintialised. Later, we read all of res in order to send
     -+	// it to the parent process - and MSAN (rightly) complains that we're
     -+	// reading those unintialised padding bytes. By memset'ing res we
     -+	// guarantee that there are no uninitialised bytes.
     -+	memset(&res, 0, sizeof(res));
     -+#endif
     -+#endif
     -+
       	res.id = pc_item->id;
     - 	res.status = pc_item->status;
     - 

-- 
gitgitgadget
