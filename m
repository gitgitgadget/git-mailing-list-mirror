Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3E21F404
	for <e@80x24.org>; Wed, 20 Dec 2017 22:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756151AbdLTWYV (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 17:24:21 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:45139 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755711AbdLTWYU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 17:24:20 -0500
Received: by mail-it0-f67.google.com with SMTP id z6so8485631iti.4
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 14:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSrEWawZJ1KRlrW9GSiiRMhuM1tlHpByk4nd3bc01Ns=;
        b=psg3NjhNN+/FqYHoEDihv8hdbp98hw1z9p7OCGdTV1T4IG0cyE6Cq7Wi38wpLjxpe4
         rSR0u2aJxq1Y8OGYWugKg+CzC/qt5+wJNREehGBBNMm1d0YuZkXTU4lGkgqiuTK7VcKV
         ZBgigrGDNwplyFi0zbPIgSVQaxi+qYBBEJ8OrBXxPXp8+K001ERjAV35QPYFsq7SEkD8
         QZs6KzxuYYTl14sd/VUJm51Q6heQt0k1NTwsfnGu74TEyO3IeERwqLIfwu89OONR8fY4
         waKZxm3btmA8mJjs+bnjlpvnaRkcTYla3zcAAscRcUiRxrDaFVtemWiYkLCNNiEzNo+j
         u0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSrEWawZJ1KRlrW9GSiiRMhuM1tlHpByk4nd3bc01Ns=;
        b=s8KZ7g8nw3RJ+n+9RekbwJa5TCvX+JNF/oiRLSdfxDj4DeiWbcnF+WoiLnlLC48T64
         wHLc5tx/EtpwiNuoO+YWXdPwS4VuVHJH1/T1HixM3upe8+hi/VLPOMuyebN8NwX6hxKa
         Lwfe1YsWpWSYWJfbBAGM0rNC088buUKYc+/C7zUk42C4halUE+Qh77NTO0Hm6bPuhDHV
         /L/+bSSiZMHh9WOKxsju0DDE8qWCJG4dyHOfMzyX4DYGfkl7Rv1hdod17ESro5tr4AXd
         ssKmJoD1w5y1L12Xgg4Mkh2yZfTzIxlnSKveLTx4PsttMWFHM/4AvgsGk116FMz44tjk
         41Rg==
X-Gm-Message-State: AKGB3mJVGpPgCKdlwlNTjssGPVJGhRoC7HSf2MDOYZIw12BvWtpeyaa+
        nAAlifPxKh4W14AExBydztu1Dw==
X-Google-Smtp-Source: ACJfBosIxWuqx33Rq/BI1g1atW1d+dy1neQo/c1rDvRnElCnwDPHdFG0UO2yFZ+k1a213/WmOPHbJg==
X-Received: by 10.36.48.82 with SMTP id q79mr11022673itq.75.1513808659663;
        Wed, 20 Dec 2017 14:24:19 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i63sm3148577itb.35.2017.12.20.14.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Dec 2017 14:24:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH] t/helper/test-lazy-name-hash: fix compilation
Date:   Wed, 20 Dec 2017 14:24:16 -0800
Message-Id: <20171220222416.130872-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <39238da4-c2b8-050d-51e3-675f5515776e@jeffhostetler.com>
References: <39238da4-c2b8-050d-51e3-675f5515776e@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was compiling origin/master today with the DEVELOPER compiler flags
today and was greeted by

t/helper/test-lazy-init-name-hash.c: In function ‘cmd_main’:
t/helper/test-lazy-init-name-hash.c:172:5: error: ‘nr_threads_used’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     printf("avg [size %8d] [single %f] %c [multi %f %d]\n",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         nr,
         ~~~
         (double)avg_single/1000000000,
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         (avg_single < avg_multi ? '<' : '>'),
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         (double)avg_multi/1000000000,
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         nr_threads_used);
         ~~~~~~~~~~~~~~~~
t/helper/test-lazy-init-name-hash.c:115:6: note: ‘nr_threads_used’ was declared here
  int nr_threads_used;
      ^~~~~~~~~~~~~~~

Fix this issue by assigning 0 to 'nr_threads_used'.

Acked-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Slightly reworded the commit message. I'd really like this patch to be included
such that I can compile git with the DEVELOPER_CFLAGS flags.

 t/helper/test-lazy-init-name-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 6368a89345..297fb01d61 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -112,7 +112,7 @@ static void analyze_run(void)
 {
 	uint64_t t1s, t1m, t2s, t2m;
 	int cache_nr_limit;
-	int nr_threads_used;
+	int nr_threads_used = 0;
 	int i;
 	int nr;
 
-- 
2.15.1.620.gb9897f4670-goog

