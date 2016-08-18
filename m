Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F141FD99
	for <e@80x24.org>; Thu, 18 Aug 2016 00:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbcHRAvs (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 20:51:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:16044 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbcHRAvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 20:51:36 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP; 17 Aug 2016 17:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,536,1464678000"; 
   d="scan'208";a="157475897"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2016 17:51:33 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v7 5/7] submodule: correct output of submodule log format
Date:	Wed, 17 Aug 2016 17:51:29 -0700
Message-Id: <20160818005131.31600-6-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.217.g609f9e8.dirty
In-Reply-To: <20160818005131.31600-1-jacob.e.keller@intel.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

The submodule log diff output incorrectly states that the submodule is
"not checked out" in cases where it wants to say the submodule is "not
initialized". Change the wording to reflect the actual check being
performed.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 submodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 1b5cdfb7e784..e1a51b7506ff 100644
--- a/submodule.c
+++ b/submodule.c
@@ -348,7 +348,7 @@ void show_submodule_summary(FILE *f, const char *path,
 	if (is_null_sha1(two))
 		message = "(submodule deleted)";
 	else if (add_submodule_odb(path))
-		message = "(not checked out)";
+		message = "(not initialized)";
 	else if (is_null_sha1(one))
 		message = "(new submodule)";
 	else if (!(left = lookup_commit_reference(one)) ||
-- 
2.10.0.rc0.217.g609f9e8.dirty

