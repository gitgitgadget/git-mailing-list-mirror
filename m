Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9193CC433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbiBTRy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:54:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiBTRyx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:54:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E814D9EA
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:31 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k1so23274615wrd.8
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=sLYNOEnMmtGba/Ow8Cj+woXbGSlqY4h1q2tBYfUoSR8=;
        b=BOLYMa+Xzglc18tgp27umykRBmOzAVJnPh5RSH6qlma7m1+plz1K34WZE6Rsty663Z
         3iCJQgyMl4N5oMY9o2rfWJ0WZfn9JD66PZSJICMYUrUmNNIVh8K25rr9MeA6yBj28x/R
         ho7KQ0tOn6YqJvUfRPEAPQ3Izhzd9/fq3AIXxYmkOoyJfpJ+E9RMlandlcilu/Kai/6D
         7EzjGk8lZFmUKu0UzIQlWIaDNVp90Yr6qjXXW1aYVbBCUQIGzJefhipQRqqwK7TyqSzw
         iPlpvByp6nOtVGQMc6t++141KfjraVlGKo18DEgADSKVLO9zzKJEse54VCc5iys8ehG4
         dKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=sLYNOEnMmtGba/Ow8Cj+woXbGSlqY4h1q2tBYfUoSR8=;
        b=hiPMyHLFSot/eK2sKpPWh0FzLTIBhJcSeNAPTk1OtdryfpGqTA6wMqcNwGSIbWlUUf
         d1qDrR2IYJZnE8QyYOj3x3Uygdg8ALNI1uPYYOrcPww/vyVBit6QmG9DqejpOvhdnJs1
         +9FC0p9qcCcY8Pwnpg+eOYxNM66r7YprUOUlpd9+TRQGQN1NGV1EuRXROk99cawZe2O5
         3/xb2UNMs70hcBeE2CSbyfcz/s0zB1OeE6foJ7gIunqL1e1pmpPSV3aIPloISy8Idcd9
         aAevYjse2QL7b+IPptm142qt2EHuo/tmjlV26doWI9sWkhrJOMGI0oyzSyvBOSRd/Ebm
         MlRw==
X-Gm-Message-State: AOAM533PSlFMfKTocYbxp6BVgQIlXsrbW2vgW4Z0x66rCALWSJak+jPs
        qmmnlZF9Zd/SLdvPxFjAmrndO2xOlXg=
X-Google-Smtp-Source: ABdhPJwFyFY/wEeLqY8KGweEfxbQgkjdo5/hJICh2EDIa8ci5/sTJngRXMnDDk+iry87/WkpNgSQYg==
X-Received: by 2002:a5d:54c8:0:b0:1e3:3944:637f with SMTP id x8-20020a5d54c8000000b001e33944637fmr12983898wrv.100.1645379669017;
        Sun, 20 Feb 2022 09:54:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm40407089wrc.98.2022.02.20.09.54.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:28 -0800 (PST)
Message-Id: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:16 +0000
Subject: [PATCH 00/11] Updates to worktree code and docs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "mailto:sunshine@sunshineco.com" 
        <[sunshine@sunshineco.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        "Elijah Newren [ ]" <newren@gmail.com>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is built on top of ds/sparse-checkout-requires-per-worktree-config and
includes some forward fixes for comments from that series.

 * Patch 1 combines two translatable messages into one. (Thanks, Jean-Noël)
 * Patches 2-4 extract methods from the already-busy add_worktree() method.
   (Thanks, Eric)
 * Patches 5-11 update git-worktree.txt to use 'worktree' over 'working
   tree'. This involves some rewrapping of the paragraphs, so the diffs are
   not obviously just a find and replace. I split the changes mostly by
   section of the file to keep the diffs from being too large.

Thanks, -Stolee

Derrick Stolee (11):
  worktree: combine two translatable messages
  worktree: extract copy_filtered_worktree_config()
  worktree: extract copy_sparse_checkout()
  worktree: extract checkout_worktree()
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'
  worktree: use 'worktree' over 'working tree'

 Documentation/git-worktree.txt | 271 ++++++++++++++++-----------------
 builtin/worktree.c             | 138 +++++++++--------
 2 files changed, 210 insertions(+), 199 deletions(-)


base-commit: 3ce113827287079dced9aaf9c5d1e1734ecaa265
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1154%2Fderrickstolee%2Fworktree-forward-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1154/derrickstolee/worktree-forward-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1154
-- 
gitgitgadget
