Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E9E1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 13:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfAXNMB (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 08:12:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:47196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728066AbfAXNMA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 08:12:00 -0500
Received: (qmail 27445 invoked by uid 109); 24 Jan 2019 13:12:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 13:12:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28281 invoked by uid 111); 24 Jan 2019 13:12:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 08:12:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 08:11:59 -0500
Date:   Thu, 24 Jan 2019 08:11:59 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/8] column: drop unused "opts" parameter in item_length()
Message-ID: <20190124131158.GD22398@sigill.intra.peff.net>
References: <20190124131104.GA24017@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124131104.GA24017@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no column options which impact the length computation. In
theory there might be, but this is a file-local function, so it will be
trivial to re-add the parameter should it ever be useful.

Signed-off-by: Jeff King <peff@peff.net>
---
 column.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/column.c b/column.c
index 2165297608..7a17c14b82 100644
--- a/column.c
+++ b/column.c
@@ -21,7 +21,7 @@ struct column_data {
 };
 
 /* return length of 's' in letters, ANSI escapes stripped */
-static int item_length(unsigned int colopts, const char *s)
+static int item_length(const char *s)
 {
 	int len, i = 0;
 	struct strbuf str = STRBUF_INIT;
@@ -167,7 +167,7 @@ static void display_table(const struct string_list *list,
 
 	ALLOC_ARRAY(data.len, list->nr);
 	for (i = 0; i < list->nr; i++)
-		data.len[i] = item_length(colopts, list->items[i].string);
+		data.len[i] = item_length(list->items[i].string);
 
 	layout(&data, &initial_width);
 
-- 
2.20.1.842.g8986705066

