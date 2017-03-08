Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955CA202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754102AbdCHRqV (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:46:21 -0500
Received: from siwi.pair.com ([209.68.5.199]:31131 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754111AbdCHRqM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 12:46:12 -0500
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 151E4845F5;
        Wed,  8 Mar 2017 12:38:31 -0500 (EST)
From:   Jeff Hostetler <jeffhost@microsoft.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH 01/10] pack-objects: eat CR in addition to LF after fgets.
Date:   Wed,  8 Mar 2017 17:37:56 +0000
Message-Id: <1488994685-37403-2-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <git@jeffhostetler.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/pack-objects.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f294dcf..7e052bb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2764,6 +2764,8 @@ static void get_object_list(int ac, const char **av)
 		int len = strlen(line);
 		if (len && line[len - 1] == '\n')
 			line[--len] = 0;
+		if (len && line[len - 1] == '\r')
+			line[--len] = 0;
 		if (!len)
 			break;
 		if (*line == '-') {
-- 
2.7.4

