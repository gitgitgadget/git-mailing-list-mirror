Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2D4F1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 13:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfAXNMe (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 08:12:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:47208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727798AbfAXNMe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 08:12:34 -0500
Received: (qmail 27487 invoked by uid 109); 24 Jan 2019 13:12:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 13:12:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28313 invoked by uid 111); 24 Jan 2019 13:12:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 08:12:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 08:12:32 -0500
Date:   Thu, 24 Jan 2019 08:12:32 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/8] config: drop unused parameter from maybe_remove_section()
Message-ID: <20190124131232.GF22398@sigill.intra.peff.net>
References: <20190124131104.GA24017@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124131104.GA24017@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need the contents buffer to drop a section; the parse
information in the config_store_data parameter is enough for our logic.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/config.c b/config.c
index ff521eb27a..24ad1a9854 100644
--- a/config.c
+++ b/config.c
@@ -2565,7 +2565,6 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
  * entry (which all are to be removed).
  */
 static void maybe_remove_section(struct config_store_data *store,
-				 const char *contents,
 				 size_t *begin_offset, size_t *end_offset,
 				 int *seen_ptr)
 {
@@ -2850,7 +2849,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 				replace_end = store.parsed[j].end;
 				copy_end = store.parsed[j].begin;
 				if (!value)
-					maybe_remove_section(&store, contents,
+					maybe_remove_section(&store,
 							     &copy_end,
 							     &replace_end, &i);
 				/*
-- 
2.20.1.842.g8986705066

