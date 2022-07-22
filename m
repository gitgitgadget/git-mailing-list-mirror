Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC65CC43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 05:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiGVFQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiGVFPx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 01:15:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D2248D9
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so1864842wmo.0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8hOFrkxXUiIasWHVohoJoM+SqtUciFu2UG5GIzqdmgU=;
        b=QhzcS0EjpJu52JI1LqiLWmes3yNAIJ9s2iuAM4kxVDO7ttNkt8AH8N/LKS5VaNpVDm
         Eanwjtiytt4HYsBB9X9psWCWidH0fZJJIxpPFJe1SKtQBM5Cb6maTvvZItyl6xJZZml0
         XmGpoTnA1i0YekzypbKkqjCh3XvJZFdzjtUWaQslEPLw15vhNhoGhRRegMXn8UgB45ZY
         X6Y4P8w4it5+uTLpYURYon4o9p8LxBPEtxD9dgvWhSziFkBQqqiRV+oi2jgo0ED9b2Jn
         i6z2SUmkTc7jCGk7wImaIKJbIXYG/FUahuT641kEzVwl7yVH9VaUOto8Oj40J3riqm0f
         XZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8hOFrkxXUiIasWHVohoJoM+SqtUciFu2UG5GIzqdmgU=;
        b=ggnf6jNQJndD/tfcuXGEuJm1GPiqB5SuUYzYyBRtBN86ci96mfFApOAr51LhWZi0oS
         tIaEYw1UVGj8MnnQxxP8ZGIJZtVrSevHtG8c7cvuTYFwWMHbCug+HG5qqx8OMJ4LAH8/
         WSAynaQcBAnkCwaDeZiNWQUEJEKbc512tX/PkMpjUkpQUvmpjRsNeYX+ZFNyfc64pd68
         H6iMNMwfgBHQBpMq5PhdY+VVdSZXiVsVMkwTzLTSlH7jwi57WBLRE2wRBlgyFOyaeHDx
         NVvEYssZ2mkxdzMEvbq5B6M+8rxqdDndiYh5fu75RSO/39w2C1+IR+jPlT3LSAbSCQzU
         55RA==
X-Gm-Message-State: AJIora/PegO0nf/yVGRpiVcHxP6X7Fmr8onghiKUqzRg7jjyw3XHBgoN
        6SOhy/6dxbhRwvoSklz6Vo6IQhe7Iu0=
X-Google-Smtp-Source: AGRyM1t4DY5UxpKej/IHKsa524/XZ64Gzo8YyFSBzvauXi9Jiz6xyE00ZspK01+L12Cle8muQz1tfA==
X-Received: by 2002:a05:600c:4f08:b0:3a1:99ed:4f1f with SMTP id l8-20020a05600c4f0800b003a199ed4f1fmr10750143wmq.199.1658466950434;
        Thu, 21 Jul 2022 22:15:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6-20020a5d6446000000b0021db2dcd0aasm4258504wrw.108.2022.07.21.22.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 22:15:49 -0700 (PDT)
Message-Id: <ad5354c219cc266972d4ea37a7e0acf9a981ffec.1658466942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jul 2022 05:15:41 +0000
Subject: [PATCH v4 6/7] merge: ensure we can actually restore pre-merge state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Merge strategies can:
  * succeed with a clean merge
  * succeed with a conflicted merge
  * fail to handle the given type of merge

If one is thinking in terms of automatic mergeability, they would use
the word "fail" instead of "succeed" for the second bullet, but I am
focusing here on ability of the merge strategy to handle the given
inputs, not on whether the given inputs are mergeable.  The third
category is about the merge strategy failing to know how to handle the
given data; examples include:

  * Passing more than 2 branches to 'recursive' or 'ort'
  * Passing 2 or fewer branches to 'octopus'
  * Trying to do more complicated merges with 'resolve' (I believe
    directory/file conflicts will cause it to bail.)
  * Octopus running into a merge conflict for any branch OTHER than
    the final one (see the "exit 2" codepath of commit 98efc8f3d8
    ("octopus: allow manual resolve on the last round.", 2006-01-13))

That final one is particularly interesting, because it shows that the
merge strategy can muck with the index and working tree, and THEN bail
and say "sorry, this strategy cannot handle this type of merge; use
something else".

Further, we do not currently expect the individual strategies to clean
up after themselves, but instead expect builtin/merge.c to do so.  For
it to be able to, it needs to save the state before trying the merge
strategy so it can have something to restore to.  Therefore, remove the
shortcut bypassing the save_state() call.

There is another bug on the restore_state() side of things, so no
testcase will be added until the next commit when we have addressed that
issue as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f807bf335bd..11bb4bab0a1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1686,12 +1686,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * tree in the index -- this means that the index must be in
 	 * sync with the head commit.  The strategies are responsible
 	 * to ensure this.
+	 *
+	 * Stash away the local changes so that we can try more than one
+	 * and/or recover from merge strategies bailing while leaving the
+	 * index and working tree polluted.
 	 */
-	if (use_strategies_nr == 1 ||
-	    /*
-	     * Stash away the local changes so that we can try more than one.
-	     */
-	    save_state(&stash))
+	if (save_state(&stash))
 		oidclr(&stash);
 
 	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
-- 
gitgitgadget

