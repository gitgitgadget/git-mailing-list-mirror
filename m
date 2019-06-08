Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB3A1F462
	for <e@80x24.org>; Sat,  8 Jun 2019 19:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfFHTW4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jun 2019 15:22:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33574 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfFHTW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jun 2019 15:22:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id k187so2390236pga.0
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FcIoSjB7Z5So3H6F7GyH7pT1HszXNZbRms58WyzJtLA=;
        b=e9ejsSEY+DrGOq6Lo//LWO1sOGANS/NHnL6LJyRGluTpFhlWlNbKXZ36T+Lrn5UvmO
         QitcbK+Ahsszc9jlIfiX5lc9Y3E9/ogoOgi4Lj0bwRlhg+2HJjwDm9hGT2eYgEpOMsIt
         nZL+XhNdPnDXNKDUQ4CQYX8Q6f2ubr2eBbEKg0yB3tRDBXr+JoSABZbXWFSursyvvrje
         CS7Kxqkkzfvn0EN1cul2W76Y97J5pvPRbiUARJo/1WKfLVvdPFQ0Dp49V2VyqHCAHXdl
         /GUaB3MXWnDs7yxjzEOorpXZ3lIuw7+CuYrD025BkfCDfUSM3x6BaddHTeHeQgp3Tife
         C+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FcIoSjB7Z5So3H6F7GyH7pT1HszXNZbRms58WyzJtLA=;
        b=U1Ur/S3GIyv3nIhcdfDkC5xlnKp0IpEKIuLTgc/Wj3JtDA7T1b/+iHj1dTf1yH2odd
         flKaDAmwiUEaEjFk/V2FsKuSnxczjGQduvW9eKVaJCY3VAS1TrbGftWLUSR8ymja1gbD
         qrYe34SDjobSiM3ZpVgnJXw38/0o7Sh1j6UlUxB9K2Ag9D5BPqaEO3U4A5QrChYy446M
         1JZVPU9YGAk7hc827VNIEe/UW/DQFP3U++yc0ducLjFSmGefkMH0ljypbditsMxr2PNs
         K44l5QneSyGXCBHEspIR1iFxuyVAPEFE5zUkWWDetLscW35gbj3Wdyg0mmxmwIaihkfX
         mYug==
X-Gm-Message-State: APjAAAX2RVrHdSs+8d6/7+yhH0tTkQ2CzwcKE0bhwcmYY4KeKwmnPILm
        ktToKzJAZrNNeydMHCsw0NLjdIzOTbo=
X-Google-Smtp-Source: APXvYqyKL945mGOKosHN95kwJNMkDPd6d2KvLP1MSpuYQTUnzPihuqD0apQavUaxrVGGRQgYaubkMg==
X-Received: by 2002:a62:61c2:: with SMTP id v185mr50319021pfb.0.1560021774849;
        Sat, 08 Jun 2019 12:22:54 -0700 (PDT)
Received: from ar135.iitr.local ([223.188.32.84])
        by smtp.gmail.com with ESMTPSA id o126sm6186290pfb.134.2019.06.08.12.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 12:22:53 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, t.gummerer@gmail.com,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCH 0/3] Teach cherry-pick/revert to skip commits
Date:   Sun,  9 Jun 2019 00:49:55 +0530
Message-Id: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git am or rebase advice user to use git am --skip or git rebase --skip
to skip the commit that has become empty or has risen conflicts. OTOH,
cherry-pick advice user to use git reset HEAD which on the user’s part
is annoying and sometimes confusing. This patch series will bring
consistency between advices of these commands with introduction of
`--skip` flag to cherry-pick and revert.

Rohit Ashiwal (3):
  sequencer: add advice for revert
  cherry-pick/revert: add --skip option
  cherry-pick/revert: update hints

 Documentation/git-cherry-pick.txt |  4 +-
 Documentation/git-revert.txt      |  4 +-
 Documentation/sequencer.txt       |  4 ++
 builtin/commit.c                  | 13 ++++---
 builtin/revert.c                  |  5 +++
 sequencer.c                       | 26 ++++++++++++-
 sequencer.h                       |  1 +
 t/t3510-cherry-pick-sequence.sh   | 63 +++++++++++++++++++++++++++++++
 8 files changed, 108 insertions(+), 12 deletions(-)

PR: https://github.com/r1walz/git/pull/1
Reviewed-by: Elijah Newren <newren@gmail.com>
Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>
-- 
2.21.0

