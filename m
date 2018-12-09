Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E3AE20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 20:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLIUFA (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 15:05:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32972 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLIUFA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 15:05:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so5136617wmh.0
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 12:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Xcnx2Do8YNDeBCKWPepvSPQuWc69kAWOsiXjVWUFKo=;
        b=SqTZ2Mcv7tBgytNKb45Xoa2PfjVns2XakQIOQrSLCCkyFT/7GCKbEZdlp1+KHjvCad
         5fB/W8EBcL85oMNFX53lRXc3B6ImFWr3isYKECK3hUW0MPbX4Pm6nrAGMstbjfVx5k28
         aNNciwOhlxTITM3XAX4nQL9Pf5uAKgY8ySB/Wz/nYx4lB+JbsqOHbbaMLjtxdNUiqAHc
         PbFvcj1UA02RS2I2gzRlhv+g0l8c5TngmCoExyqxO8J+yZgujGExPFxNOaLTveT+k/Sh
         ryFXbNufO6u5ovSJN1vbsuy0ID68GzJHDcAij/WtMIgqbRBlJIBF+L+7UoNiaQupsk/o
         tuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Xcnx2Do8YNDeBCKWPepvSPQuWc69kAWOsiXjVWUFKo=;
        b=Lc4XKjYF4LZz+FinZtSINuExvDhRWHxEIQ2abm9lp3JjjdGQ0zJoPIRQ2bDoBi9OVK
         HEEJ32HLrx/inGUID4UZENlsGIuxurHn4rC5+7HgN0TnPhwxfXf5iIea5k29zPUWJt13
         7MYsRdXKf2ttbmjvcifDWR+5dvSx6szQ2kbIT9GucxTq3OcKJ8AkjHy2D7nsmgpckSt7
         EeITeSjHsMIKG4zZ4Ad21+4nKNpDkQgdQZ4cXCFxYGQG7UAy0fVxosnS/PognpNJ87CM
         ng5f+54uGlu4Y8ixJ+F+nMwi4wqLaM6r2MRmvrMxtrE4a1PcQkBr7HKDXEoJU5YDrVNd
         bESg==
X-Gm-Message-State: AA+aEWYX+5+jCDbLaFztBM7kR/FY/P+Fns6p/QPelgj1M606mcyvB2g/
        bQFBdHEsYmPV/nQ/TO5WhURJkva2
X-Google-Smtp-Source: AFSGD/UXVv1s9R57UeAeKUVdJmVRNneBjOhu5pTFjpJUbKgmc9LzgzGC4d4NxYDyR1npW71wf5iZpw==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190mr9054437wmg.13.1544385898232;
        Sun, 09 Dec 2018 12:04:58 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id l78sm13504757wma.0.2018.12.09.12.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 12:04:57 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/8] move worktree tests to t24*
Date:   Sun,  9 Dec 2018 20:04:42 +0000
Message-Id: <20181209200449.16342-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'git worktree' command used to be just another mode in 'git
checkout', namely 'git checkout --to'.  When the tests for the latter
were retrofitted for the former, the test name was adjusted, but the
test number was kept, even though the test is testing a different
command now.  t/README states: "Second digit tells the particular
command we are testing.", so 'git worktree' should have a separate
number just for itself.

Move the worktree tests to t24* to adhere to that guideline. We're
going to make use of the free'd up numbers in a subsequent commit.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/{t2025-worktree-add.sh => t2400-worktree-add.sh}     | 0
 t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} | 0
 t/{t2027-worktree-list.sh => t2402-worktree-list.sh}   | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t2025-worktree-add.sh => t2400-worktree-add.sh} (100%)
 rename t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} (100%)
 rename t/{t2027-worktree-list.sh => t2402-worktree-list.sh} (100%)

diff --git a/t/t2025-worktree-add.sh b/t/t2400-worktree-add.sh
similarity index 100%
rename from t/t2025-worktree-add.sh
rename to t/t2400-worktree-add.sh
diff --git a/t/t2026-worktree-prune.sh b/t/t2401-worktree-prune.sh
similarity index 100%
rename from t/t2026-worktree-prune.sh
rename to t/t2401-worktree-prune.sh
diff --git a/t/t2027-worktree-list.sh b/t/t2402-worktree-list.sh
similarity index 100%
rename from t/t2027-worktree-list.sh
rename to t/t2402-worktree-list.sh
-- 
2.20.0.405.gbc1bbc6f85

