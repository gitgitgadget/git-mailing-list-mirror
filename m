Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E849C5519F
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 03:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10A020721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 03:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKWDZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 22:25:08 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39912 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKWDZH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 22:25:07 -0500
Received: by mail-qk1-f195.google.com with SMTP id q22so15781458qkq.6
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 19:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMbT6Yi/tTYjhh+yuwVnrIDSMuMmbfgqvRN1Eh0Ydf4=;
        b=rkgEK4RXR5USFSUQLyyKvYkR0AG7ja8gZQqGY0qiSxxSDQh2mzGUVwPVGc2be6qM1J
         fNNsGs/jKu16BTQMcIdvFBz36eNjnVZwydT3gm2Tu03C6YMp/DNGRgfvm8/BdcP3p35B
         7/yn/loWispWt4IOwgd5lPH9TWC11ZYR68dvQ5eC+9xbpcygHmQmpHC13VpKRxJvGTpG
         m+cNMGy+G+pQRwdwd6SXlmhgW0a+NbdIpMjgkLHl/CVJqK3p4N+5CRp3ISBF9dSPhPBu
         ls9fLBu0hu5C946MHajNfu1wnaUt4t5/7Fbi4fKDXyKsrSlBL17X+u6yhIv/Z8KD1WEr
         B+Yw==
X-Gm-Message-State: AOAM530Frex15/LuJquQW7Mz4dJ3SrrjWLhXsQ7Syqn4ShlWHJN4cIdx
        UoiINwNBFsP6/skpqoobCBMsU/lPVpeKD4mO
X-Google-Smtp-Source: ABdhPJwiuTbshwMInZfMkWV6UlfyBe9XHmirXoRarEXsYmAZ37piMzz52l+5+rvGsPMAIdaDA1amrQ==
X-Received: by 2002:a37:aa0e:: with SMTP id t14mr28478738qke.138.1606101906693;
        Sun, 22 Nov 2020 19:25:06 -0800 (PST)
Received: from crimescene.lan (pool-100-16-98-84.bltmmd.fios.verizon.net. [100.16.98.84])
        by smtp.gmail.com with ESMTPSA id c6sm8906341qkg.54.2020.11.22.19.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 19:25:06 -0800 (PST)
From:   nate@roosteregg.cc
To:     git@vger.kernel.org
Cc:     Nate Avers <nate@roosteregg.cc>
Subject: [PATCH 0/2] Fix a segfault in git log --notes
Date:   Sun, 22 Nov 2020 22:23:40 -0500
Message-Id: <20201123032342.24566-1-nate@roosteregg.cc>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nate Avers <nate@roosteregg.cc>

Hi,

I came across a segfault in git log --notes (also affects diff-tree)
when notes.displayRef is configured with no value (not an empty value).
It appears to stem from a missing return statement in
notes.c:notes_display_config(). Very small fix. (Not sure how much sense
it makes to include the test.)

Thanks,
Nate

Nate Avers (2):
  notes.c: fix a segfault in notes_display_config()
  t3301: test proper exit response to no-value notes.displayRef.

 notes.c          | 2 +-
 t/t3301-notes.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.27.0

