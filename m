Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951951F859
	for <e@80x24.org>; Fri, 19 Aug 2016 23:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755626AbcHSXuC (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 19:50:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:11273 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755545AbcHSXuC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 19:50:02 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP; 19 Aug 2016 16:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,547,1464678000"; 
   d="scan'208";a="1044487088"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2016 16:50:02 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] format-patch: show 0/1 and 1/1 for singleton patch with cover letter
Date:   Fri, 19 Aug 2016 16:49:59 -0700
Message-Id: <20160819234959.26308-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Change the default behavior of git-format-patch to generate numbered
sequence of 0/1 and 1/1 when generating both a cover-letter and a single
patch. This standardizes the cover letter to have 0/N which helps
distinguish the cover letter from the patch itself. Since the behavior
is easily changed via configuration as well as the use of -n and -N this
should be acceptable default behavior.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 92dc34dcb0cc..8e6100fb0c5b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1676,7 +1676,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		/* nothing to do */
 		return 0;
 	total = nr;
-	if (!keep_subject && auto_number && total > 1)
+	if (!keep_subject && auto_number && (total > 1 || cover_letter))
 		numbered = 1;
 	if (numbered)
 		rev.total = total + start_number - 1;
-- 
2.10.0.rc0.259.g83512d9

