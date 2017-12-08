Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BBE520C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbdLHP7u (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:59:50 -0500
Received: from siwi.pair.com ([209.68.5.199]:55838 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754031AbdLHP7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:59:10 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5FB96844F1;
        Fri,  8 Dec 2017 10:59:10 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DA7A3844DE;
        Fri,  8 Dec 2017 10:59:09 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 06/16] fetch-pack: add --no-filter
Date:   Fri,  8 Dec 2017 15:58:41 +0000
Message-Id: <20171208155851.855-7-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171208155851.855-1-git@jeffhostetler.com>
References: <20171208155851.855-1-git@jeffhostetler.com>
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

