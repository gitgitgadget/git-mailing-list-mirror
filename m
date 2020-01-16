Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AFCC33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ED020728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppiKm9Zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgAPQJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:09:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56083 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgAPQJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 11:09:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so4324069wmj.5
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 08:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=GJlqEmTMcn+zRiHq0L/YJ9oz9HKtjaJRcXT9GzBPUcg=;
        b=ppiKm9ZgNoqKdILDvXoO8aK6cCtrb3yVYedHlS53klaOdkpQ8UL+Ik0cwwI7S3ocP9
         4vo3L54V3JRKMuLi/keMjjbWKQI3fLa6eZ3JYJXkXp1htb0i67F3i84a87D29Mq7Lgwu
         nLJZiuNsPI8Kt+1pUUQ+F8LDrCz6V+IDwGG4lYrkfq1k+QPInwWe+l7hkndwwIMmpmrz
         7KdGUHGdqZwyUqyr8OWf17Yhk8r0KqTGOtJXKmukqiGjxDp/giLa+rPhsnkZxMLCTSWT
         FYYlIaymZJ4GGHP1m4nrzVhoKcGa9REaob5tq4M/cstQInTuI4JxsCrFeHPqQul0/mOT
         ScWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GJlqEmTMcn+zRiHq0L/YJ9oz9HKtjaJRcXT9GzBPUcg=;
        b=R168QyPDpaRql4OHu0mkjj/BNMWPGo9mA2SUAHAQBV7KF+7fqzJsszQ71gn45EEM3k
         1eacrOpVsey52C92xLVrz8lxqjg2FvrAI0gyWhVBtOsAwXrAbn/+ihtNzciSSiK6kw0S
         mgAMCiYRjyvtCVLto9PnIgPJ+NBOdz2aeon0jTKnnz95kLIq5e0Noejph9X8BVY4ZSpJ
         Of9R/fI550fGKZ6an712MFDb8EgnVHky6WBPYJDvkcqBzU8kHlAWDCyrHgITMHyn8qFk
         UzPcL9s+sLHaq86La+tvRq5Z2j7mQMWcP4Bd0AgnRuKvjh4uz8lTbLuhB6AhsTbRlcVd
         sD1Q==
X-Gm-Message-State: APjAAAW0/FxTOvMU0P3mo5/VLZCV1BGQv0bv7zdV8Mxk63cS10GCjccS
        Ea7JcD1OfyId905IpKzJtfoeO4wv
X-Google-Smtp-Source: APXvYqwDJIR77bMFpetRrRC2X9ZAwXMI80R3jq/tcSCeSvJszYDwZyJdSOBxSgaLs6CzzJ+bKkFpVA==
X-Received: by 2002:a1c:1d16:: with SMTP id d22mr102924wmd.158.1579190966916;
        Thu, 16 Jan 2020 08:09:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm29141326wrq.31.2020.01.16.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:09:26 -0800 (PST)
Message-Id: <pull.530.git.1579190965.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 16:09:17 +0000
Subject: [PATCH 0/8] Support --pathspec-from-file in rm, stash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series continues the effort to support `--pathspec-from-file`
in various git commands. Series already in `master`: [1][2]

Cc'ing Paul-Sebastian Ungureanu because I touched his git stash code.

[1] https://public-inbox.org/git/pull.445.git.1572895605.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/pull.490.git.1576161385.gitgitgadget@gmail.com/

Alexandr Miloslavskiy (8):
  doc: rm: synchronize <pathspec> description
  rm: support the --pathspec-from-file option
  doc: stash: split options from description (1)
  doc: stash: split options from description (2)
  doc: stash: document more options
  doc: stash: synchronize <pathspec> description
  stash: eliminate crude option parsing
  stash push: support the --pathspec-from-file option

 Documentation/git-rm.txt       |  61 ++++++++++--------
 Documentation/git-stash.txt    | 111 +++++++++++++++++++++------------
 builtin/rm.c                   |  28 +++++++--
 builtin/stash.c                |  79 ++++++++++++-----------
 t/t3601-rm-pathspec-file.sh    |  79 +++++++++++++++++++++++
 t/t3903-stash.sh               |   5 ++
 t/t3909-stash-pathspec-file.sh | 100 +++++++++++++++++++++++++++++
 7 files changed, 353 insertions(+), 110 deletions(-)
 create mode 100755 t/t3601-rm-pathspec-file.sh
 create mode 100755 t/t3909-stash-pathspec-file.sh


base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-530%2FSyntevoAlex%2F%230207(git)_pathspec_from_file_3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-530/SyntevoAlex/#0207(git)_pathspec_from_file_3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/530
-- 
gitgitgadget
