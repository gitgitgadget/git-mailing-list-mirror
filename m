Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38805C43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 06:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiFSGub (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiFSGua (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 02:50:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1917B1C2
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso6266952wms.2
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+P/m3oxsMpVAuB+gHTWtW9nOS6uF8FgiHwNPXKCHmx0=;
        b=OjWKJN+yH9CxJLXF8A/AE+y00OyPAjR+l37Ds5qIzdQ4JeHFUPCZqIcG8Y/0HLCkKg
         6qojh66tTqjfGwtEPknR5V0BR74Ue7De/CZ8FoBowuHYMRK26o2t8+a72eDb9IJhT/0a
         tTChWpVt5PHNle6fI1bGDDVhwa38pWr8DxkoodCjUG5+oSXs2D4FpegwCNkZCDmBcZ0b
         c0GzUgJ9asDTfOFfb6oPSPtY/PMc3iBRWAp2pq7nKrWhaye8RJrXtIbntfuiz67uzdat
         IgvZXZrVh8N5B76dX1yimULeHltw+HOetxDu34t1DCbQE10LXyL9PNe+YiIw+/pML4VK
         iOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+P/m3oxsMpVAuB+gHTWtW9nOS6uF8FgiHwNPXKCHmx0=;
        b=Nr0GKgF0t1eqpkc1btANUjyHFoEyajNiUzQnO2Cj4EbQkH/3UxG+jrmg0MfQnxkZC4
         9WRb0SGbjwdw4wG9fm/H3B2SBP76pU6fB+3MB2WsIkbKiW8kifQ7SczzYRx7zt6JM5A/
         227yZizGMHd16r7CS+ZTNzLKGFj/kI/GIyCSkP+Y7h80mCp1krwt+qN8BTnegkbaXTgx
         AxA8pZrw8gyONa7wp97QN5lUE408htxkJhWCOaVTY0YeS6pCC5LZN3plsdoL6cswojZf
         BdfiVSKM/ndF/1ZeETJWhXjo4mJ+bgPG97R4KkM8PIuN/OEqdoZ3GvNAqaISIlW1mrtd
         eiQw==
X-Gm-Message-State: AOAM5337kgqx65PIIzXCGg1CjAFR3iATMvE378azwTJ8Kgwq4zhInNnb
        KFP2WBYCwWRNNcnoCJOjvjLJzpj0D+YUlA==
X-Google-Smtp-Source: ABdhPJy+V7HFLjFEVZtyGXE7WOZmkCC4oNDC2CfIAmLtjlD5mzBANP0BmdVuJvXf6gEydVW1IzlS/A==
X-Received: by 2002:a05:600c:2c46:b0:39c:55a0:9533 with SMTP id r6-20020a05600c2c4600b0039c55a09533mr28484377wmg.104.1655621427122;
        Sat, 18 Jun 2022 23:50:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p33-20020a05600c1da100b0039ef836d841sm4077273wms.42.2022.06.18.23.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 23:50:25 -0700 (PDT)
Message-Id: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Jun 2022 06:50:18 +0000
Subject: [PATCH v2 0/6] Fix merge restore state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MAINTAINER NOTE: Rebased on latest main/master. (In particular, needs
vd/sparse-stash; otherwise, the changes made here regress a
ensure-full-index testcase in t1092). Also, this fixes issues that predate
the v2.37 cycle, so this series can wait until v2.38 opens up.

Other note: If this rounds needs updates, ZheNing Hu may be the one to
respond and make any necessary updates, as per [1].

----------------------------------------------------------------------------

This is a simple series to fix restore_state() in builtin/merge.c, fixing
the issue reported by ZheNing Hu over here:
https://lore.kernel.org/git/CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com/

Changes since v1:

 * Rebased
 * Included Junio's patch providing more testcases from
   https://lore.kernel.org/git/xmqqbkvtnyae.fsf@gitster.g/
 * Added three new patches to fix issues highlighted by Junio's testcases,
   in particular to (a) fix stashing with racy-dirty files present, (b) fix
   restoring staged state in restore_state(), and (c) ensure we can restore
   pre-merge state. All three were long-standing issues that we just hadn't
   noticed yet and thus are useful fixes on their own. However, my fix from
   v1 (which still remains as the final patch) does make it easier to notice
   these issues, and in particular that combined with Junio's new testcases
   unearthed those problems.

[1]
https://lore.kernel.org/git/CAOLTT8RpGGioOyaMw5tkeWXmHpOaBW9UH8JghUvBRQ50ZcDdYQ@mail.gmail.com/

Elijah Newren (5):
  merge: remove unused variable
  merge: fix save_state() to work when there are racy-dirty files
  merge: make restore_state() restore staged state too
  merge: ensure we can actually restore pre-merge state
  merge: do not exit restore_state() prematurely

Junio C Hamano (1):
  t6424: make sure a failed merge preserves local changes

 builtin/merge.c                          | 32 ++++++++++++++----------
 t/t6424-merge-unrelated-index-changes.sh | 32 ++++++++++++++++++++++--
 t/t7607-merge-state.sh                   | 25 ++++++++++++++++++
 3 files changed, 74 insertions(+), 15 deletions(-)
 create mode 100755 t/t7607-merge-state.sh


base-commit: 8ddf593a250e07d388059f7e3f471078e1d2ed5c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1231%2Fnewren%2Ffix-merge-restore-state-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1231/newren/fix-merge-restore-state-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1231

Range-diff vs v1:

 -:  ----------- > 1:  6147e72c309 t6424: make sure a failed merge preserves local changes
 1:  042d624b815 = 2:  230d84f09c8 merge: remove unused variable
 -:  ----------- > 3:  89e5e633241 merge: fix save_state() to work when there are racy-dirty files
 -:  ----------- > 4:  4a8b7c9e06d merge: make restore_state() restore staged state too
 -:  ----------- > 5:  a03075167c1 merge: ensure we can actually restore pre-merge state
 2:  88bdca72a78 ! 6:  0783b48c121 merge: make restore_state() do as its name says
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    merge: make restore_state() do as its name says
     +    merge: do not exit restore_state() prematurely
      
          Previously, if the user:
      
     @@ Commit message
       ## builtin/merge.c ##
      @@ builtin/merge.c: static void restore_state(const struct object_id *head,
       {
     - 	const char *args[] = { "stash", "apply", NULL, NULL };
     + 	const char *args[] = { "stash", "apply", "--index", NULL, NULL };
       
      -	if (is_null_oid(stash))
      -		return;
     @@ builtin/merge.c: static void restore_state(const struct object_id *head,
      +	if (is_null_oid(stash))
      +		goto refresh_cache;
      +
     - 	args[2] = oid_to_hex(stash);
     + 	args[3] = oid_to_hex(stash);
       
       	/*
      @@ builtin/merge.c: static void restore_state(const struct object_id *head,

-- 
gitgitgadget
