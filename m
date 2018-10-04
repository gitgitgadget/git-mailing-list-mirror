Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584211F453
	for <e@80x24.org>; Thu,  4 Oct 2018 15:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeJDWIa (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 18:08:30 -0400
Received: from mout.web.de ([212.227.15.3]:41491 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJDWIa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 18:08:30 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXHoz-1gBhwq3j3V-00WCOA; Thu, 04
 Oct 2018 17:14:41 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXHoz-1gBhwq3j3V-00WCOA; Thu, 04
 Oct 2018 17:14:41 +0200
Subject: [PATCH 5/5] oidset: uninline oidset_init()
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f3d21da8-ae3a-6483-1d61-f25ad238df1e@web.de>
Date:   Thu, 4 Oct 2018 17:14:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OtImo+VZXxNyrNGCJ+uw1xzPYV+GOwu6qwQvvBoc/4EzG3m0mwk
 D/CucHj/i0NCM15uJcs8ZUaBbI6f4dZjj6W/TGZiKb2pY7V969sevyENaz/ZN4ba/39SA3k
 tbHLFt/V2PCvYb6r1aqEpOnXl6vh05YNFkbsNyMAThB+jZyqjOJFIPlZRY2qCeKh/lQQfkG
 K6fhSIULSXHc32PGANNEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1eUQrpTBarI=:4G0AL8oTHGXHqInYaloLD9
 oI6PaggUi6+GxZm8xsmcZ3fAeyYN7bwdsWqbWE9XgVzM0eNnOC6eES/tMBiW/pTF7u5z7O3rI
 b6NWMLTBu15myaVQJPkOpPi9fSEnTFO1QuI8Elx12yf1+s3U/WMTbFyMpEC36PTnEyjwe35Oi
 FlaR/t3uXRQ98OeqW+ZvVgjuNgEY1/GFTMUUjoQMZ/jSXYQDxu4FIhKCa/CJKg8X9WgHBE92L
 DMX6Yo731WHqQT04R8a5rY4wgwT22U4JgIGPru8p8CqAFWSffTtJ+bq+VrBtmnErFGCVImuhl
 hwaa2WDVxWaaPZCCW75vEv1kLHg8FTBbEck3s6Xl+D/Ls+ScoeeSt6XIYXz7FXnQ1uNZCsR/H
 lrrZaAFyQw601dmf7lxdbUiF0oLHrmyltcOoRJRZJWr1HNbcV84+BDdKJLnCbtRV4zHxVzzuN
 LYdXJej4qM60wabcXCC+Cc2isdLNnyMhk6qkOc6UZjIXCJ6g/z0y8H0nGL3JpGSTnijNWVT/M
 br5lRcFhp7i2tC5CN9QYcWEWK4h09HkRJ250x9SAsKknTEZVUZv5YE+cochl+Q9dpdnYw/DBR
 akt7p0l2yMUMbvVpFz1pRMUGxkNxuRgTWcjR3LLcGJvK2jhMmLh0YwMDWZh5OoIvhdcNY4fgu
 oeEEbEyIALIMSUACedaOv6qHt/1StZVNQ85kRwEwKYcDwPLhLzh843AHFCWICVUWmXHnSbRos
 BLcDR+3A38UsbTRfSzb37ltve55aBPAEI1G/+XTP2eU4RQZtfED5DdPBzBTY8ItqFt0Eb3CqF
 nEvyy2vj+gH7lNYnzrsgfq+eoWCF33pK/SK/ASvLOaAQcStBzk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to inline oidset_init(), as it's typically only called
twice in the lifetime of an oidset (once at the beginning and at the end
by oidset_clear()) and kh_resize_* is quite big, so move its definition
to oidset.c.  Document it while we're at it.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 oidset.c |  7 +++++++
 oidset.h | 13 +++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/oidset.c b/oidset.c
index 9836d427ef..fe4eb921df 100644
--- a/oidset.c
+++ b/oidset.c
@@ -1,6 +1,13 @@
 #include "cache.h"
 #include "oidset.h"
 
+void oidset_init(struct oidset *set, size_t initial_size)
+{
+	memset(&set->set, 0, sizeof(set->set));
+	if (initial_size)
+		kh_resize_oid(&set->set, initial_size);
+}
+
 int oidset_contains(const struct oidset *set, const struct object_id *oid)
 {
 	khiter_t pos = kh_get_oid(&set->set, *oid);
diff --git a/oidset.h b/oidset.h
index 4b90540cd4..c9d0f6d3cc 100644
--- a/oidset.h
+++ b/oidset.h
@@ -38,12 +38,13 @@ struct oidset {
 #define OIDSET_INIT { { 0 } }
 
 
-static inline void oidset_init(struct oidset *set, size_t initial_size)
-{
-	memset(&set->set, 0, sizeof(set->set));
-	if (initial_size)
-		kh_resize_oid(&set->set, initial_size);
-}
+/**
+ * Initialize the oidset structure `set`.
+ *
+ * If `initial_size` is bigger than 0 then preallocate to allow inserting
+ * the specified number of elements without further allocations.
+ */
+void oidset_init(struct oidset *set, size_t initial_size);
 
 /**
  * Returns true iff `set` contains `oid`.
-- 
2.19.0
