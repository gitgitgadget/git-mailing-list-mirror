Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43C01F404
	for <e@80x24.org>; Fri,  2 Feb 2018 22:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeBBWgl (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 17:36:41 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:47025 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeBBWgj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 17:36:39 -0500
Received: by mail-pf0-f195.google.com with SMTP id w69so4550729pfd.13
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 14:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=NvuToHcT4h1AZ9Dk62vydznTtS1PAc0gw3L65atLRxo=;
        b=FztN6jaZvvVrEeClpPjq2AzFZMwqLa9h385RKH9EdeHEc4HhQyynsllthQlbbNwbKG
         O13r/OO+w1K3lUoTxlk6s3euRocQOCRY7nqs6IBSYzhOfL8PQXQtJSEGjkF9dQsHrrpH
         6XD/AS3OWHsJcX0VZoxfboKak717TBuzVJp9WUY/EomWNNok+R8PKkqJ0AhumeffEasz
         s8Z4tgFCF06XfaK8m7YkglJlX8oy1nwCrUF/am2U5bpv5c9gvJwG0mhHAQ92k6aV9vH/
         e7kB1q0OSnAvO+VpDBfEIvvH/Aw5gy259/Z6piKghuLROx2fLeL02E/KCaQthb6gPMlJ
         FnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NvuToHcT4h1AZ9Dk62vydznTtS1PAc0gw3L65atLRxo=;
        b=YkZXeXW7ZTn62FHu+JlvfGIPFMn9XBv2I6IL5uegVvT2QaTezwQ1lKPyhJ7AjPCP9V
         jUqtSQTurELoOLm56p4QuEIh0Cw3+EjGvsHeudoMNDIrSIkBMImWmpabYyVd7ym1V2If
         /ON1a5+TMmsgIvcYXAU/XnxiomuhqPNQ4e9KxJjBmQD7BniqOFTD3TPfyQ9dfAL1+q/J
         0v8LdWHZJenFdvEauTHuqHZjj5f4N1SFgU9qum3c6UDXC12a5qPTXAsRG0q5+ZCLGOOt
         ZY45zoBy8QakQdvvFcDcsykSICxaRvoqUxUkLjSr5VH88Rpz4MVeGLzo/dqsDvrcHGb5
         F2+Q==
X-Gm-Message-State: AKwxytctAUkHXzyvsrMy1Uek1zAVK4XKbJet399dgmieqIBG621udQ8o
        R5qdNhatxB9Y7DEzV5tDql34mAnPYVw=
X-Google-Smtp-Source: AH8x225YNCOLQjcYxgImJZb2R8thlwr+tiVw3shN1djhZr6dKHHbsEDJKMMHXTQuGL2g8iZ/i8HqRg==
X-Received: by 10.98.237.6 with SMTP id u6mr41846770pfh.190.1517610998980;
        Fri, 02 Feb 2018 14:36:38 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id b81sm5878168pfm.25.2018.02.02.14.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2018 14:36:38 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com
Subject: [PATCH 1/2] packfile: remove GIT_DEBUG_LOOKUP log statements
Date:   Fri,  2 Feb 2018 14:36:30 -0800
Message-Id: <e1c6a9769b553f978bde8a524dbf323ea0c1b54b.1517609773.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1517609773.git.jonathantanmy@google.com>
References: <cover.1517609773.git.jonathantanmy@google.com>
In-Reply-To: <cover.1517609773.git.jonathantanmy@google.com>
References: <cover.1517609773.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 628522ec1439 ("sha1-lookup: more memory efficient search in
sorted list of SHA-1", 2008-04-09), a different algorithm for searching
a sorted list was introduced, together with a set of log statements
guarded by GIT_DEBUG_LOOKUP that are invoked both when using that
algorithm and when using the existing binary search. Those log
statements was meant for experiments and debugging, but with the removal
of the aforementioned different algorithm in commit f1068efefe6d
("sha1_file: drop experimental GIT_USE_LOOKUP search", 2017-08-09),
those log statements are probably no longer necessary.

Remove those statements.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 packfile.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/packfile.c b/packfile.c
index 4a5fe7ab1..58bdced3b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1713,10 +1713,6 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
 	unsigned hi, lo, stride;
-	static int debug_lookup = -1;
-
-	if (debug_lookup < 0)
-		debug_lookup = !!getenv("GIT_DEBUG_LOOKUP");
 
 	if (!index) {
 		if (open_pack_index(p))
@@ -1738,17 +1734,10 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 		index += 4;
 	}
 
-	if (debug_lookup)
-		printf("%02x%02x%02x... lo %u hi %u nr %"PRIu32"\n",
-		       sha1[0], sha1[1], sha1[2], lo, hi, p->num_objects);
-
 	while (lo < hi) {
 		unsigned mi = lo + (hi - lo) / 2;
 		int cmp = hashcmp(index + mi * stride, sha1);
 
-		if (debug_lookup)
-			printf("lo %u hi %u rg %u mi %u\n",
-			       lo, hi, hi - lo, mi);
 		if (!cmp)
 			return nth_packed_object_offset(p, mi);
 		if (cmp > 0)
-- 
2.16.0.rc1.238.g530d649a79-goog

