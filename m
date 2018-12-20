Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637761F405
	for <e@80x24.org>; Thu, 20 Dec 2018 13:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbeLTNsk (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 08:48:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53675 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733197AbeLTNsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 08:48:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so2109869wmb.3
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 05:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l7XFiBXwfle79kR3hbgBFGxdmJNIQjJhVnjO2Fxt8A0=;
        b=RSPSAb5OUGGV8c9J1/+IJbHu/meNWGxmDK2727JlR1DEtgBidadHM7lO11UKDWz7d0
         vQ/vExdkqy6IPeEDjtPerVFFUK3Ud3ICaOC3EUe/i7w380Ua+G7N3cLkHyOCEQx+BchO
         hTRv1q8OiK0ewj6Ms2n/AF9k4ZWP1uNJef+bsLyZezUCyjqKCfun0fA7JwqcXhG8o8iE
         Ke39GxKt2OBi/NzvfOyJJNVMI6TU3SzpWMHQ1PLdEErrUb93QUOhnL3S8HBcqC20BCk3
         9BihG1HRxhB3xMWOgY7kzzTROuV4KxCve1GQ/3nZn/wuCnzMWAdIP6MU2U5QU238aoPx
         y63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l7XFiBXwfle79kR3hbgBFGxdmJNIQjJhVnjO2Fxt8A0=;
        b=ENuBrmYKzENf8c8RKJaqTi3KPQzzPp2Tlmi4WMK/1MYfHDp9IiqGhSaTF59/UWnTeM
         slN3R+KZ9x2zc6K0e54pGRn189war+HZw5XZaH1rmbA5eR2+qGigkfQp7LWvEmFCOJCW
         6+BaPLZ5MnuqSO+TalI3Cmq530wkyKHNbrNYWwRIyU5eG6VgXlyuKTTjvG9cJzOou4IC
         PZfEWakSzeFsQKhhuxVoRbmkdxkrA90V7vsNiMLNBrI/N44T9nWF5AmyOabfD15nOwDb
         W5O0j2Bd5G+0vYxNAaJXAzdpMHwOpMvPkYdAKNN0HQFb5eaSrCRXfRLTtND4+1Rwwu3g
         JRuA==
X-Gm-Message-State: AA+aEWYv9Tauekgs/NIhcZEzHQE53vUFo68osPq8/TnDE9T5prEicPb4
        2X00mi88kkZzUowdzdb3tcAE2dSCZX0=
X-Google-Smtp-Source: AFSGD/Uv04aycQqXLK1+rzI48fgJpI9kdSuJ355NyquDKgsKpEo+CmoH2g5XZRm+GsHJXFkeFxbUjw==
X-Received: by 2002:a1c:1550:: with SMTP id 77mr12279572wmv.100.1545313715706;
        Thu, 20 Dec 2018 05:48:35 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id h184sm1520464wmf.0.2018.12.20.05.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 05:48:34 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/8] move worktree tests to t24*
Date:   Thu, 20 Dec 2018 13:48:13 +0000
Message-Id: <20181220134820.21810-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <20181220134820.21810-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181220134820.21810-1-t.gummerer@gmail.com>
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
 t/{t2025-worktree-add.sh => t2400-worktree-add.sh}       | 0
 t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh}   | 0
 t/{t2027-worktree-list.sh => t2402-worktree-list.sh}     | 0
 t/{t2028-worktree-move.sh => t2403-worktree-move.sh}     | 0
 t/{t2029-worktree-config.sh => t2404-worktree-config.sh} | 0
 5 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t2025-worktree-add.sh => t2400-worktree-add.sh} (100%)
 rename t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} (100%)
 rename t/{t2027-worktree-list.sh => t2402-worktree-list.sh} (100%)
 rename t/{t2028-worktree-move.sh => t2403-worktree-move.sh} (100%)
 rename t/{t2029-worktree-config.sh => t2404-worktree-config.sh} (100%)

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
diff --git a/t/t2028-worktree-move.sh b/t/t2403-worktree-move.sh
similarity index 100%
rename from t/t2028-worktree-move.sh
rename to t/t2403-worktree-move.sh
diff --git a/t/t2029-worktree-config.sh b/t/t2404-worktree-config.sh
similarity index 100%
rename from t/t2029-worktree-config.sh
rename to t/t2404-worktree-config.sh
-- 
2.20.1.415.g653613c723

