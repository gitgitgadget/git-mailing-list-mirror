Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAD631F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 16:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfJUQBD (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 12:01:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50351 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbfJUQBD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 12:01:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id q13so3898269wmj.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPLHTVyChDtpVyWmE9ijTqTAEouKXRIYLoPxaCD/LLA=;
        b=GEGqHzr0UmS8OliSC1JMsnPpbRzlmPced854FRjGeNW5l112dAJjA7F5tYfIrccL8e
         DQOL0nLzlNiWVY3/l23KVJzR1jk3M+MTBKhoDym7YRSAFyM5VxLfRM6TPrdRBoqvKTWd
         m5fynf6gmKN4DlUF8HY/gpLCslkS/JtmcD6uxpaEu5tOr/yuReT1zzY593Tb3BnUJLkP
         N5l8u5wmlAVHXdmR/LOzF/B5E7Vt+rQ8sKcVoJwzEp3n03qODvuWYGB04eZRIzzCfoSy
         NBJv3VIBFKmzyXG78MSCSZIiIdPYJSRvjNf9lNKkRLLrFsFylrMFGPcX36+9kr9JFOOx
         KMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPLHTVyChDtpVyWmE9ijTqTAEouKXRIYLoPxaCD/LLA=;
        b=tZHJfdnFOAVNkgkqUSpGOEcjzWniJjmdkrVjsdwftvJZJLc5/nZTRdkCI8wzT0zBih
         oLfIo8d75ulmosBBqan0GC/2/kR12OaqIXu6du5rw85G1XIWc7Wx8QgVsXlK75eQF6vr
         pYVbR8KbnPuELBu6hNg8SALtFTCMsNQed3yDvRZ7SnJqTqRYdvH/3dY8dK1tG2FkIKt3
         qylss0AKIhEueLwlCdVpJ24cOPw1wrEVlU4A0ZFQCu8LW1e5YBYCJXaXH9rXYg+0/wjv
         hprI4Ujqm69NWa1iz+z92G6ecR9hQdLStPQy0hfVd2FjiA/V5E83ClPrrdj6QWoUxwAt
         +W4Q==
X-Gm-Message-State: APjAAAUcQdmiE0ygv3sUtxsTSoXsDl5xRweEuVNX4dZ0vr8BdflcYxVw
        E0+rnBBf7EtV0QIMd7SDee9R/xjv
X-Google-Smtp-Source: APXvYqxariIqRRJol9sBopzFjqRCmcqAA+r+mlSUqDH7hj1xsg6drICkf9a6+oEJzV/WoCqsVG6YnA==
X-Received: by 2002:a1c:44:: with SMTP id 65mr16319962wma.93.1571673661330;
        Mon, 21 Oct 2019 09:01:01 -0700 (PDT)
Received: from localhost.localdomain (x4db66cac.dyn.telefonica.de. [77.182.108.172])
        by smtp.gmail.com with ESMTPSA id u26sm16293196wrd.87.2019.10.21.09.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 09:01:00 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/5] path.c: mark 'logs/HEAD' in 'common_list' as file
Date:   Mon, 21 Oct 2019 18:00:41 +0200
Message-Id: <20191021160043.701-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.rc0.472.ga6f06c86b4
In-Reply-To: <20191021160043.701-1-szeder.dev@gmail.com>
References: <20191021160043.701-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'logs/HEAD', i.e. HEAD's reflog, is a file, but its entry in
'common_list' has the 'is_dir' bit set.

Unset that bit to make it consistent with what 'logs/HEAD' is supposed
to be.

This doesn't make a difference in behavior: check_common() is the only
function that looks at the 'is_dir' bit, and that function either
returns 0, or '!exclude', which for 'logs/HEAD' results in 0 as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 4ac9a101f5..3fac5f5726 100644
--- a/path.c
+++ b/path.c
@@ -113,7 +113,7 @@ static struct common_dir common_list[] = {
 	{ 0, 1, 0, "info" },
 	{ 0, 0, 1, "info/sparse-checkout" },
 	{ 1, 1, 0, "logs" },
-	{ 1, 1, 1, "logs/HEAD" },
+	{ 1, 0, 1, "logs/HEAD" },
 	{ 0, 1, 1, "logs/refs/bisect" },
 	{ 0, 1, 1, "logs/refs/rewritten" },
 	{ 0, 1, 1, "logs/refs/worktree" },
-- 
2.24.0.rc0.472.ga6f06c86b4

