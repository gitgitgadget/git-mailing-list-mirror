Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85201F453
	for <e@80x24.org>; Wed, 30 Jan 2019 15:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfA3PEJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 10:04:09 -0500
Received: from m12-13.163.com ([220.181.12.13]:51909 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfA3PEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 10:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k0TG0
        Nc5198l+2f74M9cBAoBwPuZnO46EFSKnSjS4PQ=; b=T9HAb08oLB+3ofNN0BWyq
        oiuDK2x6smr5Hd/Zr/C4Fo6qCfUxACfW6YEjgZ9ueEYfr0AtPVbnr49I9coCC8Mn
        ympYxkh4H+Nc8tYyVbzu5wGgFUwbEHCGrfN4bDYhCVqs8dAyU9jEBz0JzDn0rBV3
        ird3WM2Y1W1S+8WJCWltrg=
Received: from localhost.localdomain (unknown [125.120.62.229])
        by smtp9 (Coremail) with SMTP id DcCowAC3yGzMvFFcXMzRDQ--.3790S3;
        Wed, 30 Jan 2019 23:03:41 +0800 (CST)
From:   16657101987@163.com
To:     worldhello.net@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunchao9@huawei.com,
        szeder.dev@gmail.com, zhiyou.jx@alibaba-inc.com
Subject: [PATCH v8 1/1] pack-redundant: delete redundant code
Date:   Wed, 30 Jan 2019 23:03:34 +0800
Message-Id: <20190130150334.20598-1-16657101987@163.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130114736.30357-5-worldhello.net@gmail.com>
References: <20190130114736.30357-5-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAC3yGzMvFFcXMzRDQ--.3790S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4DCrW8Cr48tr1xKF18uFg_yoWxKrg_GF
        W8t3WFqw4DuF47Z3W5Cay7ZF1Ygw1xXrs0gas3Kw15A3WrAFn0yrykK39xZF15Ka9rtr43
        Aw1fK3sFvr47CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5IzutUUUUU==
X-Originating-IP: [125.120.62.229]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiQw1Mglc7GVvtoQAAsi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

The objects in alt-odb are removed from `all_objects` twice in `load_all_objects`
and `scan_alt_odb_packs`, remove it from the later function.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 builtin/pack-redundant.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 0316a400ad..29ff5e99cb 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -492,7 +492,6 @@ static void scan_alt_odb_packs(void)
 							alt->remaining_objects);
 			local = local->next;
 		}
-		llist_sorted_difference_inplace(all_objects, alt->remaining_objects);
 		alt = alt->next;
 	}
 }
-- 
2.20.1


