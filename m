Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6558C83F19
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjH1Vs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjH1VsG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:48:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DE3F9
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:48:03 -0700 (PDT)
Received: (qmail 572 invoked by uid 109); 28 Aug 2023 21:48:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:48:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4553 invoked by uid 111); 28 Aug 2023 21:48:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:48:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:48:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 13/22] add-interactive: mark unused callback parameters
Message-ID: <20230828214802.GM3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interactive commands are dispatched from a table of abstract
pointers, but not every command uses every parameter it receives. Mark
the unused ones to silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 add-interactive.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index add9a1ad43..852e8e6b2f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1021,9 +1021,9 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 	return res;
 }
 
-static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
-		    struct prefix_item_list *unused_files,
-		    struct list_and_choose_options *unused_opts)
+static int run_help(struct add_i_state *s, const struct pathspec *ps UNUSED,
+		    struct prefix_item_list *files UNUSED,
+		    struct list_and_choose_options *opts UNUSED)
 {
 	color_fprintf_ln(stdout, s->help_color, "status        - %s",
 			 _("show paths with changes"));
@@ -1074,7 +1074,7 @@ struct print_command_item_data {
 	const char *color, *reset;
 };
 
-static void print_command_item(int i, int selected,
+static void print_command_item(int i, int selected UNUSED,
 			       struct string_list_item *item,
 			       void *print_command_item_data)
 {
-- 
2.42.0.505.g4c6fb48dec

