Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6351B1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 03:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbeGLDLK (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 23:11:10 -0400
Received: from pug.qqx.org ([50.116.43.67]:58286 "EHLO pug.qqx.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeGLDLK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 23:11:10 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
        id 116521E95A; Wed, 11 Jul 2018 23:03:46 -0400 (EDT)
From:   Aaron Schrab <aaron@schrab.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Daniel Harding <dharding@living180.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Fix --rebase-merges with custom commentChar
Date:   Wed, 11 Jul 2018 23:02:49 -0400
Message-Id: <20180712030249.22071-1-aaron@schrab.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <e8973797-fc5f-2ca5-1881-5ee66fc8279b@living180.net>
References: <e8973797-fc5f-2ca5-1881-5ee66fc8279b@living180.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for taking so long to get back to this. Hopefully the following 
will be acceptable to everyone.

8< -----

Subject: [PATCH v2] sequencer: use configured comment character

Use the configured comment character when generating comments about
branches in a todo list.  Failure to honor this configuration causes a
failure to parse the resulting todo list.

Note that the comment_line_char has already been resolved by this point,
even if the user has configured the comment character to be selected
automatically.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 4034c0461b..caf91af29d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3991,7 +3991,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		entry = oidmap_get(&state.commit2label, &commit->object.oid);
 
 		if (entry)
-			fprintf(out, "\n# Branch %s\n", entry->string);
+			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
 		else
 			fprintf(out, "\n");
 
-- 
2.18.0.419.gfe4b301394

