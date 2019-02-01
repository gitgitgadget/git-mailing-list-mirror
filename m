Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904601F453
	for <e@80x24.org>; Fri,  1 Feb 2019 16:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfBAQWg (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 11:22:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35849 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbfBAQWg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 11:22:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so3447178pfc.3
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jk4bKCwkogKKQ34axZb1eDG5+hZ7gRU3tZhU8knyD2w=;
        b=Sn5oNKPsayVzYjYy27aaxtyKC2KyZyvmkLc0tO6hUX6J28c2fkVGaI2xUqCzJApcCq
         2bwky9a6XSXAekN8yBWi5hSc8YZSasS0OjzZYtFKhjXpYl7YmaQvFvK7dvxlVBU1DXzq
         LvGfT5M1tjasK6FnKJ9j8ulaCh8NHpuel4WfNFxpIgnCia4i9xsW8hCu5JOemuoSP7Mb
         fBr5oS5MUcqk9Te4DziUZX98T50A4gHM3IvLQTLFSDA5KgDxBmsI1PcLC+wyNEzVKjqL
         6tCpmz+4i9ibBSW6xaIr/0ptqMp630S4xA8PYgsD4/mjQwtvTAdf5VKzi7ZVt6btf875
         Zpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jk4bKCwkogKKQ34axZb1eDG5+hZ7gRU3tZhU8knyD2w=;
        b=KOHD9tJZV7ZTLpcUH2CS51HIxAl30fZo6pvIvs8qw+5IjGHo0WrgKFDx/QQ7CSHOZD
         0nfJRZXiBRKTSzS1vn1jVdwggN4dyhZnAZ9PhRMhjxq9IhE8ZtyCPmqbN0oTUZg64NuP
         fqYN4qypi5DXj2A6RCmMzPqFDgwE7dizNC1fu5XG588/LMcprlJmtIUJNyTFO7/g14k2
         NNaCeOC5vbpvcfIlm7o+3EhhJXSmXk8+KcZsiRqtwcKlWo0WXSNmYDjwJcXupXatyHzG
         tP5l97rf3Nr0TnHltxe9WQyvRmkuGuIRbY1STRjK7qL6BXqSP25+H5ZRQkL19PoGGpKA
         H+rg==
X-Gm-Message-State: AHQUAuZz1RninzM4KJPoJZUUHdZSBJ8x8PdrQoo5kvFmIJIjVkNvaU0R
        19ltZhVTyYY1vEkksIOyX7U=
X-Google-Smtp-Source: AHgI3IZkAyyOWg4/qSaVSWcrHV7oEMccIRg5PN9FHFkkc27P6ZTHl9uPy2u6r716UAFMu3jPSdlpng==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr2826500pgd.49.1549038155640;
        Fri, 01 Feb 2019 08:22:35 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:1:ce70:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id x2sm11872694pfx.78.2019.02.01.08.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 08:22:34 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v9 3/6] pack-redundant: delete redundant code
Date:   Sat,  2 Feb 2019 00:21:49 +0800
Message-Id: <20190201162152.31136-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190130114736.30357-1-worldhello.net@gmail.com>
References: <20190130114736.30357-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

The objects in alt-odb are removed from `all_objects` twice in `load_all_objects`
and `scan_alt_odb_packs`, remove it from the later function.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/pack-redundant.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index f7dab0ec60..4a06f057dd 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -545,7 +545,6 @@ static void scan_alt_odb_packs(void)
 							alt->all_objects);
 			local = local->next;
 		}
-		llist_sorted_difference_inplace(all_objects, alt->all_objects);
 		alt = alt->next;
 	}
 }
-- 
2.20.1.103.ged0fc2ca7b

