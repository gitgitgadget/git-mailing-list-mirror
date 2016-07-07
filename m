Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1F42070F
	for <e@80x24.org>; Thu,  7 Jul 2016 14:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbcGGOfo (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:35:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:51585 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbcGGOfn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:35:43 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MNZ9u-1bE1n93Lek-0079qS; Thu, 07 Jul 2016 16:35:29
 +0200
Date:	Thu, 7 Jul 2016 16:35:27 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 03/16] Avoid translating bug messages
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <b5c530404c8bb71e513e9e79a09d8ef7d259b580.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:czZLLmzLBr2TPZkwBz0lAuSkYDw9EnBmdjsMZeN84Nsjcf01RkW
 8IbiGNiO7xuNElN2anQMR2Gpn+xgBM896tkkmKRaP+CbPUOwEiqvDKqM3QoP4Zu7LOBU3yB
 tdLpieyeDI0WYmoV1s2iINY8yTvQxobZ7sOk6NEQTtBWS0M5DMGh6fDWesBvOVCga/BQf/S
 tQAeNKgQ7l9H6ETcpixVA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:F+gJYz1/ke0=:/5kXzmb5X6b2OT2TmJpQb0
 ItDEevX8GO6caNGW4uXkLCYuUbbBnXdPZFZtIcZkg2BmoZkHh6yDyHpcKK5YJO6wexYB5ydPU
 pNrEko/jJKRCer4Qd60kZnmw3bI3MMH8ubFhYwno7CYGR0YhUQhVpoj/y7uyxTW8XfbNQ8IOX
 sSjiNMSIz6B6B6q5NGPsxr+SW8N2dV2HOwE4g5nOb8bH+Q27nE/994qvFXYhDJ6kIny4eM88h
 6NpowLBiBfrEM4hUoy0rHFtyQadT67mHhlt7/o2U3b0GSXkFkrH9qW2pLkO2j+kxcNzP4NBE6
 v1yV/Hfse5H6f7N2+o74xZfW+IDpKJu7BZDEfZ9kzyx8L5lbu8kk4qZdAe56jLJZJ+YUrhS89
 49WaIreXJ3rqQ0jDgUEH9FXlI+TfZCi4pXjoVOzqN4Bl3Pjof5K+zZ2Dzbf+xy2Ffxya+E4vM
 XEwDcBY7KpIJTgFw4aMIa6ZzExhXMasp0tlA7mS9oFBmvlq8AMDuLD7essqMuceIz3Lm6+S5B
 5eOc9tkd/e0GSNPKQ4/oT9H8RDjpJwEz+tX3m5/edxKmJeclisiZwQyHOcVOtuEe5eB2l8OOh
 qI7Wmk8r4nTjFkP7oTYBl25iOAdCakqdLeyXUMjGTiaHD6PaR5CQf9lmwGg+mqnJMBy3dI0We
 CFYxJWqh3VuaMXwo84vYs2vllhYnR99TMAZs4MpDXisXZEgLRaN+MaoKEz/SHx5XsxuqEG5nm
 NCcds+IwICYw8wlpEWd/VG9omOW2w0GjFXRhffI8YGZjm7JD99lOkEo1qTV/kQX4tvfGoQl8d
 vg7G8r0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

While working on the patch series that avoids die()ing in recursive
merges, the issue came up that bug reports (i.e. die("BUG: ...")
constructs) should never be translated, as the target audience is the
Git developer community, not necessarily the current user, and hence
a translated message would make it *harder* to address the problem.

So let's stop translating the obvious ones. As it is really, really
outside the purview of this patch series to see whether there are more
die() statements that report bugs and are currently translated, that
task is left for another day and patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 05b9789..ea0df22 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -983,7 +983,7 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			if (!oid_eq(&a->oid, &b->oid))
 				result.clean = 0;
 		} else
-			die(_("BUG: unsupported object type in the tree"));
+			die("BUG: unsupported object type in the tree");
 	}
 
 	return result;
@@ -1827,7 +1827,7 @@ static int process_entry(struct merge_options *o,
 		 */
 		remove_file(o, 1, path, !a_mode);
 	} else
-		die(_("BUG: fatal merge failure, shouldn't happen."));
+		die("BUG: fatal merge failure, shouldn't happen.");
 
 	return clean_merge;
 }
@@ -1885,7 +1885,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die(_("BUG: unprocessed path??? %s"),
+				die("BUG: unprocessed path??? %s",
 				    entries->items[i].string);
 		}
 
-- 
2.9.0.278.g1caae67


