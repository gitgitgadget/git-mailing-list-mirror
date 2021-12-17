Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20680C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 04:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhLQEZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 23:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhLQEZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 23:25:25 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126A5C06173E
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t18so1603283wrg.11
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IiZC3HCwJKDFZeln0GAPYcTzB5FueOEpwmHvt2DvUrE=;
        b=F9++opc/ktELK+5VUmWRzpK1uXW7KqgSDGH6DGC/NSlsURez7KKgs5noa+J2aV17GC
         OZXLmkNea9x4MVtMEHjM/XQe2o4jAGWqwJld++oZWE6Un0eLp+RbYIY+IjLO1W9I0R3M
         gK8/Gc7oClm7xz137WxwP694fTWw+ob0EXsffvI6kvKcuG9Mt+b2lzxA0iTZj7UzWLyF
         MCX6G5CMrJG7YGZ1qDFRcRpED7Ea2falnR5Pvn1GPUoN9R8F//kLK8v/TBuToBtxhFOi
         FEUVSi4MLSJnQofKZDMCC92wyP/aAB/Nq3/Q7x8krPoimBRTzD+7VSDFnDIMWAIbImTF
         pJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IiZC3HCwJKDFZeln0GAPYcTzB5FueOEpwmHvt2DvUrE=;
        b=bZ2hXzarvr8I3BiqsC005LgaWs/IEFFKnj8gW3y+olqpFJneuiJW6b8v/bFAYymBjs
         6/1m3ep5qQZA5pJnxSqoyRveYUpZKVv2snRgNZjXwfvYfUOPU+j+Rc2sYlCWjv07rL3E
         QZ70c2BNuB5SC+gDRwa1xIjohYVAdRxpHoJMevWh7OvviuY8qSlUgBEpEL0PMkubfkI6
         wFR3zMitVu+Wbbm8yTgQmnw0Jj4Nj2UNtWgZePsP8h8n9Wcvkxl256T1YntBe0MefYw/
         vWm1DoP+kBUayogE3quz+EMpfZfhyjvxTt69Yj8s0ysQR/KmSBBrR7YWCktvBl6GL6Ch
         HO6Q==
X-Gm-Message-State: AOAM530H+j1Czax2majYrZxlp8Uqlnvf+XLFn8+igYcHP6fcKfdZ0Sni
        xt6w9XbUCXgivI6YHY+K//qFEK60X+vu3w==
X-Google-Smtp-Source: ABdhPJw1HdZHm8QFsHdmUyoW5U8nqsqM43UzwPIJkom3PsU0hRDfSJuKwRm3W+vwXPjzC8zKaU/Lfw==
X-Received: by 2002:adf:e0d0:: with SMTP id m16mr863543wri.74.1639715123454;
        Thu, 16 Dec 2021 20:25:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o64sm6325634wme.28.2021.12.16.20.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:25:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 2/7] progress.c test helper: add missing braces
Date:   Fri, 17 Dec 2021 05:24:57 +0100
Message-Id: <patch-v7-2.7-81788101763-20211217T041945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we have braces on one arm of an if/else all of them should have it,
per the CodingGuidelines's "When there are multiple arms to a
conditional[...]" advice. This formatting change makes a subsequent
commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-progress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 9265e6ab7cf..50fd3be3dad 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -63,10 +63,11 @@ int cmd__progress(int argc, const char **argv)
 				die("invalid input: '%s'\n", line.buf);
 			progress_test_ns = test_ms * 1000 * 1000;
 			display_throughput(progress, byte_count);
-		} else if (!strcmp(line.buf, "update"))
+		} else if (!strcmp(line.buf, "update")) {
 			progress_test_force_update();
-		else
+		} else {
 			die("invalid input: '%s'\n", line.buf);
+		}
 	}
 	stop_progress(&progress);
 	strbuf_release(&line);
-- 
2.34.1.1119.g7a3fc8778ee

