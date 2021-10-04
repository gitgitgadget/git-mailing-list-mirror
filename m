Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C405C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2D26115B
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhJDBOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhJDBOA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:14:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCA1C061786
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:12:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e12so7375139wra.4
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSJZyY8aVgNm185JUDFOszyU662k30q9xI+uXP7vo2I=;
        b=T2St2Qu7kTYhrJ6uRAFxUOCO88SVlr6fU5EA+1eN8iQSzraSD2rKojdIj6MZghVCpV
         0RjqWZpqmjOJKQcEQfuIvW4nRBsM6r6z9TrZx8D98SHigWR1KVUxWGPHuhB69iBOt8yM
         rymtcLTkjmYTIq0V7rAr9cwns1KOItqNQgim/Kq5LCckF4TtL49Lpm2juyyV4OT6qoHo
         5VqUhchBXtCWlLxv6TVcqs058ixNwzbmDvEkrH+ivV7HCl8pNh0IBD6zEdoIsE3stJC6
         ZFiM/6hHWPy/+R6RZIs1wX8++JpUWkIf5nuf+hWW9/f4MWvGRO1sG82ZyOt2ALJ4AwlK
         gMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSJZyY8aVgNm185JUDFOszyU662k30q9xI+uXP7vo2I=;
        b=uiJLFmwGxfzOb+KV8BYWz86LwunOwjYGmSQrDbhio017FDITcC20YyPn1GiZyqofda
         nLPwrUN9yjSK33hqQNYSUmOMaUV3NjK1Ua0DzOhmjh2KGVS/nmL2C8f2EogZP//hW/w6
         d3nUZgLEfefzAnrjfDe1Hxi+5PBxlgAxZKkXfutBEw9t6SBRUmkrP8aEG1hzpMTaTS7E
         zDYGgsOJeUb7Ipz63orXGQcof5FaFS15yGna5zp5Jq673OC3NxBmXhpVM4OPXRZLzk4l
         rG79qAF4PuSFvyazlwgGm2tvwPeU4xVFahEoUV+4z+XITV26lMQkbzBIk8r0JlO9dbYp
         o0LQ==
X-Gm-Message-State: AOAM530Sp1BoSZttJ6WyeqmNtfQD/mhVrA7LNG4Enkyxpmz1G+awekcV
        3XKs+TOaJxK4nyStogWEnSzthjznQc0Vbw==
X-Google-Smtp-Source: ABdhPJyEulCDbuNhYcoLM0kO9r3MtFEc7npBCAbh30AOxJCwjczbi4aO9xvBIxrFMXJ8JxoEtki9yw==
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr6166839wri.243.1633309929319;
        Sun, 03 Oct 2021 18:12:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3sm12384317wmc.25.2021.10.03.18.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:12:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 08/10] unpack-trees: avoid nuking untracked dir in way of locally deleted file
Date:   Mon,  4 Oct 2021 03:11:57 +0200
Message-Id: <RFC-patch-v4-08.10-10a7cbf049e-20211004T004902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2500-untracked-overwriting.sh | 2 +-
 unpack-trees.c                   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 5ec66058cfc..5c0bf4d21fc 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -218,7 +218,7 @@ test_expect_success 'git am --abort and untracked dir vs. unmerged file' '
 	)
 '
 
-test_expect_failure 'git am --skip and untracked dir vs deleted file' '
+test_expect_success 'git am --skip and untracked dir vs deleted file' '
 	test_setup_sequencing am_skip_and_untracked &&
 	(
 		cd sequencing_am_skip_and_untracked &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 8408a8fcfff..703e7953d62 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2405,7 +2405,10 @@ static int deleted_entry(const struct cache_entry *ce,
 		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
 			return -1;
 		return 0;
+	} else if (verify_absent_if_directory(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o)) {
+		return -1;
 	}
+
 	if (!(old->ce_flags & CE_CONFLICTED) && verify_uptodate(old, o))
 		return -1;
 	add_entry(o, ce, CE_REMOVE, 0);
-- 
2.33.0.1404.g83021034c5d

