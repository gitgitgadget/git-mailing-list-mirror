Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3497F201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 00:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbdGAA3J (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 20:29:09 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34254 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbdGAA2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 20:28:50 -0400
Received: by mail-pg0-f50.google.com with SMTP id t186so70726647pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 17:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LV9mcEBrqMpqM+gZHZbJ57mDZSLRCRZKfNQ0khXuvrs=;
        b=uH/8iMKMyEvZnZeolIFCyqdGwn7QDHVYJ7pu5Voe/cMDYFAq5wcSs+YcHp6FivkbKg
         l6zC8Qc/aFYh2CSAOkyGMGtQ/3bQz3e06Z9qhENE87j74ZzaAuChqVYZ+GyA99Bm3W/g
         lgYJJ1ciR+Cas3vmr0QR8bXEoSmhlmEe18itujugnhHTNVPyL4o75lxiHmGwkARt0gPt
         y6CR4ejE7CqKkj/1/hAHPrjTL7pYsUO6P058CyVvOpSxNkzjPX3vnQT1lHDU7T9AFTB1
         tDPKQQbPizUtAmJaUHwqi2UXZxIhVtgIMjnymaH6ZCsQLV4zD1l3Q/rt7M2L+IUT9J7k
         Al3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LV9mcEBrqMpqM+gZHZbJ57mDZSLRCRZKfNQ0khXuvrs=;
        b=ulTboND+CFW8MnSrDA/Aq5HoWl2J1+1fEAoWAnCYxGRB7YwxbEhHyFLOJQGoNPTrnC
         oNcvDOrRKtqN9fQ9iApqY2kZxupuqKNXSq8voQr+CRcvsqruBI6O3p0rngAk4K7t+Jhu
         eG/1vYgAv7wCzAnsIz/XK5aRIvyY5DygvBIoHxAB7/HYX5owZdY1oN7FIYdG5qiqj74F
         eAcj9JEs76A4vVyqNAXtaDrWpo4mnPAxU/V6IB3vViy89J4SOVJnPWxfN2IND12jiMVP
         y/pES/bGhv/13/j/rQ1n/WOCGwuQ35Wi45VOdzux/KlF1S/5LBf43qJdaFiGCnwViPGg
         eIXw==
X-Gm-Message-State: AKS2vOyzWJuDe12rp++YQc+vNi1qDegWOU0fG/SZPtv8sbcmO2MoXGlu
        TAeK6/Eq+kpemtXt+g2jQA==
X-Received: by 10.84.236.1 with SMTP id q1mr27765964plk.187.1498868930077;
        Fri, 30 Jun 2017 17:28:50 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc8b:7c8c:8e14:f9b5])
        by smtp.gmail.com with ESMTPSA id p76sm18220667pfa.53.2017.06.30.17.28.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 17:28:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/10] remote.c: drop hashmap_cmp_fn cast
Date:   Fri, 30 Jun 2017 17:28:35 -0700
Message-Id: <20170701002838.22785-8-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170701002838.22785-1-sbeller@google.com>
References: <20170701002838.22785-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 remote.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 60d0043921..3efa358558 100644
--- a/remote.c
+++ b/remote.c
@@ -134,10 +134,14 @@ struct remotes_hash_key {
 };
 
 static int remotes_hash_cmp(const void *unused_cmp_data,
-			    const struct remote *a,
-			    const struct remote *b,
-			    const struct remotes_hash_key *key)
+			    const void *entry,
+			    const void *entry_or_key,
+			    const void *keydata)
 {
+	const struct remote *a = entry;
+	const struct remote *b = entry_or_key;
+	const struct remotes_hash_key *key = keydata;
+
 	if (key)
 		return strncmp(a->name, key->str, key->len) || a->name[key->len];
 	else
@@ -147,7 +151,7 @@ static int remotes_hash_cmp(const void *unused_cmp_data,
 static inline void init_remotes_hash(void)
 {
 	if (!remotes_hash.cmpfn)
-		hashmap_init(&remotes_hash, (hashmap_cmp_fn)remotes_hash_cmp, NULL, 0);
+		hashmap_init(&remotes_hash, remotes_hash_cmp, NULL, 0);
 }
 
 static struct remote *make_remote(const char *name, int len)
-- 
2.13.0.31.g9b732c453e

