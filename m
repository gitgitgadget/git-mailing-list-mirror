Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56E7C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBC92071E
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG5aNemg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfL3Rma (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:42:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37971 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfL3Rm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 12:42:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id i16so33299628edr.5
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 09:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Rz/qqeEXUbEPcpGMItMZwDcShV6UQePPH7aA9fsDgcM=;
        b=TG5aNemgAd+ohlmBedws7oYL2pJzFovcKIFBUo3FGs8IDj7a4rHCqOEHsJwa82p+0g
         WGSjAD/iqi7OPlI7uuu9rOQPEYZPfKeLeWKNLl4kBv7EZEhN3WxTrwiNnDnkukQSbGPi
         gEwazXBBYC+spzdzbfpRCwxaz+ZRGI1JKCVY2aALvh1kjoPB0oPnfxVAOQpMyJATjdIc
         xKKSTfCkQlKoXP5kHQ3c4jQCfzBoa25NGkCjFPHgzSbVWFLUnPSTbUfiqGu89Mik4Lv4
         RbdAqA+8PQcKqxJngMqf+diIvczQoqJM43wf+R8sO/AGe8S8WSfZY4Xsp+fNxd6gM480
         6vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Rz/qqeEXUbEPcpGMItMZwDcShV6UQePPH7aA9fsDgcM=;
        b=oaXxb9rVmBkumwz48c/YxvoKvqNFvRCoUmEOxAY3qwue+V9R8c23NAB9+HVkwkQCIz
         5oQRenspAUyVbqQruDhrgLcLFes/0eUvk6x36ID1aOpNJcL+oVKbeQIEWKHv7d2eZqZD
         1yu5vnz3TAbn24A7GzsBH5tCfbIXSiGXTS8vx/91A9y1fHGdfLitOUt+PL+rbkBH3+Pp
         uT6PT0aBu29WLKbLZ/m1cy0FAEbGgIjhf1UzICQt20ClzqwsDUxSO+YvuMssMy19GYlZ
         JeGE8/pchZUfX+QuKMvK1lnnfb5greKOAVyUlszCmDCdQ0AFOWi2Ukbjxa/VUae1Pr+A
         rr3A==
X-Gm-Message-State: APjAAAVaunB5Rk2yQC278hHfOOpHOrE4Yt8MQyxfE2vBYc9bc6kVM6oC
        CJoPULdo6QI9KtT/A4U0dZnHY+l3
X-Google-Smtp-Source: APXvYqx6Ca/SUQrD0c5cvnFBcy9CcAlheymjrCsMbJKjgRnbydq8/8+qt1gLAMxjNf+gSiYbTzohEQ==
X-Received: by 2002:a17:906:4d89:: with SMTP id s9mr72565795eju.268.1577727748271;
        Mon, 30 Dec 2019 09:42:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id gl17sm5662467ejb.72.2019.12.30.09.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 09:42:27 -0800 (PST)
Message-Id: <pull.503.git.1577727747.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 17:42:24 +0000
Subject: [PATCH 0/3] t: rework tests for --pathspec-from-file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please refer to commit messages for rationale.

This branch is a follow-up for [1] where part of branch was merged into `master` via [2].

Previously in [3] there were some concerns on whether removing
copy&pasted tests is good. I still think that yes, it 's a good thing,
mostly because of high volume of potential 13*6=78 duplicate tests.

Still, I separated this change as last patch, so that the remaining
part of the branch can be taken without it.

[1] https://lore.kernel.org/git/pull.490.git.1576161385.gitgitgadget@gmail.com/
[2] https://public-inbox.org/git/pull.445.v4.git.1575381738.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/xmqqwoatcn5u.fsf@gitster-ct.c.googlers.com/

Alexandr Miloslavskiy (3):
  t: fix quotes tests for --pathspec-from-file
  t: directly test parse_pathspec_file()
  t: drop copy&pasted tests for --pathspec-from-file

 Makefile                            |  1 +
 t/helper/test-parse-pathspec-file.c | 34 +++++++++++
 t/helper/test-tool.c                |  1 +
 t/helper/test-tool.h                |  1 +
 t/t0067-parse_pathspec_file.sh      | 89 +++++++++++++++++++++++++++++
 t/t2026-checkout-pathspec-file.sh   | 70 +----------------------
 t/t2072-restore-pathspec-file.sh    | 70 +----------------------
 t/t3704-add-pathspec-file.sh        | 70 +----------------------
 t/t7107-reset-pathspec-file.sh      | 79 +++----------------------
 t/t7526-commit-pathspec-file.sh     | 70 +----------------------
 10 files changed, 142 insertions(+), 343 deletions(-)
 create mode 100644 t/helper/test-parse-pathspec-file.c
 create mode 100755 t/t0067-parse_pathspec_file.sh


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-503%2FSyntevoAlex%2F%230207(git)_2b_test_parse_directly-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-503/SyntevoAlex/#0207(git)_2b_test_parse_directly-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/503
-- 
gitgitgadget
