Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F151F453
	for <e@80x24.org>; Mon, 11 Feb 2019 17:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfBKRXm (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 12:23:42 -0500
Received: from avasout05.plus.net ([84.93.230.250]:43398 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfBKRXm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 12:23:42 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id tFIygik3L3a8gtFIzgoCMo; Mon, 11 Feb 2019 17:23:41 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=U7m889ju c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=bB_5KGr-wt1901Q5KS8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] prune-packed: check for too many arguments
Message-ID: <feaa30fe-acc7-9748-eaa9-1afbcf7fa5b2@ramsayjones.plus.com>
Date:   Mon, 11 Feb 2019 17:23:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGEm9uR93VcG+Rzk63ayuoEj4/lt45MNzncm1yntzuoqrnqKWsL1fqMcLXV/kho0YmZXd8LV8jFSdEBV5mby80pxlpaja/IZ5naVXmHg+U/XXDzgqggP
 2edmryIhBewAtucr8jFWmVLguZ3QOj9QgLNRam4gIBmlxchoX/CwzDQStcYxat+Flxkj5wqEMtF5Zw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

Another 'old find' (from feb 2017), but this time I don't seem to have
sent this one to the list before. It is possible that I didn't think
it was up to scratch ... dunno. ;-)

ATB,
Ramsay Jones

 builtin/prune-packed.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index a9e7b552b9..48c5e78e33 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -63,6 +63,11 @@ int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, prune_packed_options,
 			     prune_packed_usage, 0);
 
+	if (argc > 0)
+		usage_msg_opt(_("too many arguments"),
+			      prune_packed_usage,
+			      prune_packed_options);
+
 	prune_packed_objects(opts);
 	return 0;
 }
-- 
2.20.0
