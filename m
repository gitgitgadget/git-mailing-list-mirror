Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5562AC35242
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2816E20725
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irwmLSrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBQExK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:53:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34679 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgBQExJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 23:53:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id n10so16037515wrm.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 20:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=sqyhDozF+ZHB4FFg//PkDVfKz5L5Y6eZaDnE4U0UUOg=;
        b=irwmLSrABiSxhd6gt6z9uynqGzEf/H4coFWBWERWfBmDhE1SDOXeuczY+z9Lmars+5
         QrBmJ/s1H1kbJXjZcNBuQstCF2bOqOqvQHmRRIUUg0cUSPbKwGRYLEvXDUYzhycM5yti
         m8EOitfV6HSkqWlKUooLFeqierZrg5RsedKUuLds2TwC9AZ2fG703JL0ztKxBzr+uTxP
         tRPTmlFVAviS2rHelXN6uaOKgtYxoMdo8ogVDwecl09WZy9jorsgUTTzy6H9qHtHrmEJ
         d4BvTBWtJWRHUCMWSJEnwnz3wxW0x9j2KXADNSuk517oSDnXZu8pIDVRthLcVezDpjIO
         AwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sqyhDozF+ZHB4FFg//PkDVfKz5L5Y6eZaDnE4U0UUOg=;
        b=O2mX+s8I8UjxVqROFgCmd2Ah3CSG2/2qNGk+/cR1U5EHD6jVkRJXhyDmhZQCyPsycM
         pFaFoxDWbmLkA+JYb1/Ut8Mw5ThMUpZEyyW5Sp8zUrZKMHrUDwFYJ4PNGdkFDLVImYV5
         wKmbcksGDjhRomUCl9oMOo9gsgoESUFsKYN5POEdFD6Oij8G6x2Bi3FpWtz6um02hyuq
         0pDvAgAXa6PjcoIkrINajlZCsZ1IxXBcH2Hf1QniSiv2xgIyj2mrb2H1LexntSgS9GiM
         b/+WRViVidx3sDV+iOjVdqie25YYC+xQcn3tnx77aLwVCOwWBnpulgUvnmOO6unLFnLa
         FNUQ==
X-Gm-Message-State: APjAAAUYY7tglSFDtqx68L1lFDLvYRTGRoZC+IaSzDPL06BOVLf4Ez01
        9ZB6/BHFW1zjAhcJCmqCVde288kE
X-Google-Smtp-Source: APXvYqwniaNpyvjkTbSaiB995etjRjgeSUhW4oBpIYbj5Rop0+4zXfjsY/wcc+h/hgRHyzK85KeOVA==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr19630705wrp.1.1581915187299;
        Sun, 16 Feb 2020 20:53:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d204sm19351383wmd.30.2020.02.16.20.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 20:53:06 -0800 (PST)
Message-Id: <pull.555.git.1581915186.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 04:53:00 +0000
Subject: [PATCH 0/6] unpack-trees: fix '--recurse-submodules' when switching from no submodules
 to nested submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, using git checkout --recurse-submodules (or the submodule.recurse 
config) to switch from a commit with no submodules to a commit with
initialized nested submodules fails because a child git process tries to cd 
to a yet non-existing nested submodule directory. reset and read-tree are
also affected in the same way since they also use the unpack-trees
machinery.

The 5th commit in this series fixes this bug. The first four are clean-up
patches in tests and in unpack-trees that mostly remove outdated
comments/dead code. The 6th commit adds a test for the reverse transition
(nested submodules -> no submodules) as it was not being tested.

The commit message of the 5th commit is quite long, as I tried to describe
clearly what is the cause of the bug.

Philippe Blain (6):
  t7112: remove mention of KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED
  t/lib-submodule-update: remove outdated test description
  t/lib-submodule-update: move a test to the right section
  unpack-trees: remove outdated description for verify_clean_submodule
  unpack-trees: check for missing submodule directory in merged_entry
  t/lib-submodule-update: add test removing nested submodules

 t/lib-submodule-update.sh  | 68 +++++++++++++++++++++++++++-----------
 t/t7112-reset-submodule.sh |  1 -
 unpack-trees.c             |  7 ++--
 3 files changed, 51 insertions(+), 25 deletions(-)


base-commit: d8437c57fa0752716dde2d3747e7c22bf7ce2e41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-555%2Fphil-blain%2Fcheckout-recurse-nested-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-555/phil-blain/checkout-recurse-nested-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/555
-- 
gitgitgadget
