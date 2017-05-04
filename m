Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68189207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbdEDN7J (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:59:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:61110 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753465AbdEDN5i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:57:38 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MB2G8-1dG9AE27s4-009vyj; Thu, 04
 May 2017 15:57:30 +0200
Date:   Thu, 4 May 2017 15:57:28 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 16/25] mktree: plug memory leaks reported by Coverity
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <b67d22e657400733c9bb5c78b8adff7b75a82280.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oU+Esx6+BrDgsfiR6J4G+IAQjyoF72IjFQm7Hdy7ErGWNVaUI2B
 waaTAoiJL7d68rbqNekmZS/KINSTqKdHud7sbOCPf5V2aL3Kai3hcHRETeNkLyi1eY5O3ey
 Qc7HrY5N/PJg9+egxHpqRLUoXQEEYDkj5eMOw/aa+SvXsp+qbPbYecz5ooSaaebVru7T6Kx
 7hULxWKlZWDULslAfp6Lg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yne8lUWR27M=:SljFQsSlZ/jbiUtCHkUYqp
 02rGpL9NhlLIzOghNE5AeWdVWO8CM9JQCQTD+C0nFyFJXfSBpJpLAgQ8T8aoQufKlRiUk+upb
 S1iBNnf6x7LxM9/k/oWjHTf1RPvRNAhKya8nFoH7PqyAds5flQjrdNrL4uK1B28UI+7rBM1U4
 VUczabwQdF/PFQX+L64EeLvkZbOBT4EsGLXAfTiiwb+phdZ2vaRm6Ey9dxNLxusF8rO2TmKH/
 USj3b80rtJM1W1XpAROBw996h0iYMMPiXXOGuL/5lvfgF8VmH/dC9hJQfIIFn0g0IX+R+AstW
 a2IFQHCQSikhY5ZocSObkBMeZ/AsvxLkCDNnTCFbIMuOS0VREeO7SWAmgE6NVsTNSFpdrZ+H1
 eaG2WVjFQyDwbOYZJV/3GpnJ9QosFtSL0pQUXhLrq0m1Y+WmL4tPtcbipsphBHxNLsy0maOEK
 mL4fXw1PTl6lAeKsAiC/kMRIqcSpi8qHJhUNDJe48N25rFbk6hPFFVLtrO/Rx0cM5SpyBGfYN
 eBuXXcZNBsJ+FzOxApyicAlvdORJ3rqmZehueHqhyoBn/v4gJoInpKHsQjy/CPatS/wHsYcDw
 coCZC3M969VKL6GVkWohH26esCbh5iSuR2/bKQdYAVOOcJPiZvhhsANV+2vxKFovN1xm06LCg
 VirKE7fCgSl+XZpkTh5LPBi7HGUgJW+E440mxx2AxqKXiE9OsRZOb36uway5knRj61hCnU2xS
 N+fEj0+iCUgJD99bXhOdTX9MFtmoMXYiVN7dRcvUu29Yt65lFk6rcHMTq7qaHL7GZ1EU/v7w4
 P4e5Vwa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/mktree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index de9b40fc63b..da0fd8cd706 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -72,7 +72,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	unsigned mode;
 	enum object_type mode_type; /* object type derived from mode */
 	enum object_type obj_type; /* object type derived from sha */
-	char *path;
+	char *path, *to_free = NULL;
 	unsigned char sha1[20];
 
 	ptr = buf;
@@ -102,7 +102,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 		struct strbuf p_uq = STRBUF_INIT;
 		if (unquote_c_style(&p_uq, path, NULL))
 			die("invalid quoting");
-		path = strbuf_detach(&p_uq, NULL);
+		path = to_free = strbuf_detach(&p_uq, NULL);
 	}
 
 	/*
@@ -136,6 +136,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	}
 
 	append_to_tree(mode, sha1, path);
+	free(to_free);
 }
 
 int cmd_mktree(int ac, const char **av, const char *prefix)
-- 
2.12.2.windows.2.800.gede8f145e06


