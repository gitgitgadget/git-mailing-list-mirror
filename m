Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 269A41F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 17:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfJ3Rmn (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 13:42:43 -0400
Received: from smtp2.axis.com ([195.60.68.18]:52009 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfJ3Rmn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 13:42:43 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2019 13:42:42 EDT
IronPort-SDR: rz/YwVhM2sH87gzpIftBiNSUYl8Nhj0tLqTohNPuB7zyrG1cCEgtViv2GtHcqd76JxJ2NTg1au
 lVHXGRyN97fU7U9CizZe1xRlJ2L7pVt9onx01BBe+U+6rrQNngve1RR5Az6sLszeCkqYEsuAO0
 MJU7hCWSLk2GlydDnTIXST1Zfd4BuOXkgI1toOOlNlccMFkpa8YHAD+gSsAma1AUuk8WU8BMzP
 ABjoAcP80YsAhwoKfiYa8096kD+5tv+kcnNWWrcIIw6Oka9QWeVSkYGmKfFu0MAwzFincZ2UWg
 NTM=
X-IronPort-AV: E=Sophos;i="5.68,248,1569276000"; 
   d="scan'208";a="1934084"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
From:   Mattias Hansson <mattias.hansson@axis.com>
To:     <git@vger.kernel.org>
CC:     Mattias Hansson <hansson.mattias@gmail.com>
Subject: [PATCH] ls-remote: Remove conflicting option "-h"
Date:   Wed, 30 Oct 2019 18:33:37 +0100
Message-ID: <20191030173337.6574-1-mattias.hansson@axis.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX01.axis.com (10.0.5.15) To XBOX04.axis.com (10.0.5.18)
X-TM-AS-GCONF: 00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mattias Hansson <hansson.mattias@gmail.com>

The "-h" option is documented to limit the result to heads, which is a
bit nonintuitive since "-h" is commonly used as the short option for
"--help". However, "-h" currently displays the usage information
which proves that there's a double reference to the option.

This patch will remove "-h" as a short option for "--heads". This
will maintain the current behaviour and correct the misleading
documentation.

Signed-off-by: Mattias Hansson <hansson.mattias@gmail.com>
---
 builtin/ls-remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 6ef519514b..85ce336fc3 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -63,7 +63,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			   N_("path of git-upload-pack on the remote host"),
 			   PARSE_OPT_HIDDEN },
 		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
-		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
+		OPT_BIT(0, "heads", &flags, N_("limit to heads"), REF_HEADS),
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
-- 
2.22.0

