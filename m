Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC9320A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbdLERDO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:03:14 -0500
Received: from siwi.pair.com ([209.68.5.199]:22082 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753049AbdLERDM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:03:12 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DA04D844E6;
        Tue,  5 Dec 2017 12:03:11 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5F6D0844DE;
        Tue,  5 Dec 2017 12:03:11 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 03/14] fetch-pack: add --no-filter
Date:   Tue,  5 Dec 2017 17:02:43 +0000
Message-Id: <20171205170254.65293-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205170254.65293-1-git@jeffhostetler.com>
References: <20171205170254.65293-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Fixup fetch-pack to accept --no-filter to be consistent with
rev-list and pack-objects.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fetch-pack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 7957807..cbf5035 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -157,6 +157,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			parse_list_objects_filter(&args.filter_options, arg);
 			continue;
 		}
+		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
+			list_objects_filter_release(&args.filter_options);
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
-- 
2.9.3

