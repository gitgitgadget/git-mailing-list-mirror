Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78A8EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjF0OmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0OmD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:42:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3208A35AC
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so1916048e87.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876889; x=1690468889;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdTuqlsYN96z5Q+SCaRUCk9MnIkkeIkfW12kJhnD1hM=;
        b=fqMT5ByNqaqFLJKi3GDfdlk2HnVyVgJI81mk2OYBjXcu1bhA8A/9s8MUIodVk0citH
         hySeGSHfrkoNDww24810A/6E6Dsb17hWb7OHkSsEB0q7pqLNYvtnu6UVme/gPR0iwx9Z
         k9LnPYo+tZ2LZ+p5qL/6CxxTILCPZ++luGdRu0DWbYBSBi3fssV2BUAQQmzaFnhv5KxQ
         ZqThti57DJ6AvEkVGDX+HxlXZ5lITymMujA78pE8iPUWD/SVxkTh7tfqWTXVjeUWRG3M
         qsQHdoJPTqKzrzRn1m2xuOScSWSc9WC7dfkIRs23baftv2oQS9HO5SHfDOlLfDKzE6Qh
         0B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876889; x=1690468889;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdTuqlsYN96z5Q+SCaRUCk9MnIkkeIkfW12kJhnD1hM=;
        b=IunilMbSnieYkYrc44XJA5tHYF2fY65nEr8n7A9FHfvlXXBy3wsjcstyyJvfXJ32A3
         dGcS+Ic9rZnf8izZMmcM4+TF8+im7o5V+9tSHwLZGYvlp79KfXjQQb87B2tMY5HWJCEN
         cw8Ng6J84rkxlnRlOSW88lhjdfa9JX+1OtjRq4PzqRlTIBrWPtVKJjon+SC9FABJnv8k
         2lCkf61goZO74/dsP3+c5ubdBTEULTvbjnd2L1OyfLLBjqd3ph3kBWJ8b7UXnXnonLav
         fdsd3TrLFUeZD7/9EW158Cbs/Eb2le2YEteFwE32eTVfIjXU1+Yxl5EdjKIZLU0NKJuc
         YuyQ==
X-Gm-Message-State: AC+VfDyMDumiyoen0JS5vZkvbHkTJOz5tPtwUVAQNaTbnE+V7nZHorU4
        MNtgisMSeP4iv0AMEAyZf0WoJNadnCo=
X-Google-Smtp-Source: ACHHUZ4QHypHVPVCQkXZfdiiLFLXZpR4a785v3O/MtB/Ib0nXX1Z3jducZirwMQBVqnuXR8xS6x5Lw==
X-Received: by 2002:a19:ca4a:0:b0:4f8:7897:55d9 with SMTP id h10-20020a19ca4a000000b004f8789755d9mr13135846lfj.53.1687876888321;
        Tue, 27 Jun 2023 07:41:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15-20020adfe7cf000000b0030fae360f14sm10637756wrn.68.2023.06.27.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:41:27 -0700 (PDT)
Message-Id: <863fa3ee311482c990f396a7d5298a12c159e0ef.1687876885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 14:41:17 +0000
Subject: [PATCH 2/9] gitk: use term "current branch" in gui
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Jens Lidestrom <jens@lidestrom.se>,
        Jens Lidestrom <jens@lidestrom.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jens Lidestrom <jens@lidestrom.se>

This is the term that is used in the official documentation. Instead of
"HEAD branch" which in not standard.

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a533ff9002e..574a80fbcc2 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2693,7 +2693,7 @@ proc makewindow {} {
         {mc "Write commit to file" command writecommit}
         {mc "Create new branch" command mkbranch}
         {mc "Cherry-pick this commit" command cherrypick}
-        {mc "Reset HEAD branch to here" command resethead}
+        {mc "Reset current branch to here" command resethead}
         {mc "Mark this commit" command markhere}
         {mc "Return to mark" command gotomark}
         {mc "Find descendant of this and mark" command find_common_desc}
-- 
gitgitgadget

