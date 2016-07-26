Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A74203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756995AbcGZQGY (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:06:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:55999 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198AbcGZQGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:06:20 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LuP5z-1bHK2L13OJ-011mP5; Tue, 26 Jul 2016 18:06:06
 +0200
Date:	Tue, 26 Jul 2016 18:05:53 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 03/16] Avoid translating bug messages
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <765d70cf1697a76f4da0f22f3b243cfde1dae7aa.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OnU0QdagsWV47mVoJMv5s1+cHGoJcUlPunz//tNZ2tGmGO6WoZH
 KVg84Cyjr6MpEXZu6RxzX2BCIyafhujl0PCLKDPy39FvM8CfhuyYfS6rw5VjLl/IjukBN7W
 gCMuQ5xHE5tYDF2D39z2ZLpPWaNKN/5A+38cyw+5Ncu8FQI0wVK/FUdcql6dZnd9T9VvJXI
 wN2s7uIUKhkDMOW2ASSIQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:DcuFv4LrJIA=:VFOehEy+yL0hjbXRBQq197
 gMbcifIDbMj8d3n9f4031Jy+bZ7J1/0o9mEUPqOwbbURlpZIymZulqmkl88cMMaw/GjnCE+Ro
 8KjwrzHIi34fSohbFMR2jAdc83Em7mElHC3MF8t3OPlwhYP5lzRSmdqYOBlchx3k+7sf9o5E6
 S1J0oQYRdt5lPh8KAxqFbyfD0LNGncEJqDK0GM/f5f53W4SIS0Q7D6TOHo0jBB549WgKL+zym
 QdrZtY0hQTl7amYC56Kiqw9908w/RsohQbnNEsbR/2rmx5WaSISOYXMjUOVTBVg8ac1vAhkYR
 TmYklhqXtx0j8RlWqGUrk6cOW0lyD9Sg/lkA7A7/jMrfIHeUiDjvnHZKqiinQoghqdLu/R3m/
 UexON+7XWncVK4Uw2qfuiMYKEGTMa6/UtZ/zQfvLFv+IjMczkRxDxRZiqKeTXTwmalrB64+1Z
 fs9uu+X381FYlNWc1Gu7kybTZHjJhqrQXyBqmhuWDPN45V1KKgl+BveEAZ7bLkqLDV/NgUD+C
 BoQ6kzpx9+ppVWPDPk/GaTWv+ySyQMCudwbvIC+NKsVUW62wQHbk5rb8LpSypCWrzt2QaDAPf
 LeVnXk/jF2pBKbmcikv4tLU7KVyT66gGrggosXOS+uqtVe54BvWQ3b3dsBNAKVIyqb6Ms1L6K
 qANDXaR6lsjSuQ1o9xZTuSCqeeCdgjQcZ6UXkDilAwWpKUAp9KBIBsr5jovjv7dNH0wi72DAP
 +ptrswyv9Qp3+sQvejl/hvzgB/qrmqezcO90YwJ9JJh6JPg9c5Ck1ycnbc6//ug6hxNbFfU9b
 uamUe0p
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
index 4338b73..1b6db87 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -967,7 +967,7 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			if (!oid_eq(&a->oid, &b->oid))
 				result.clean = 0;
 		} else
-			die(_("BUG: unsupported object type in the tree"));
+			die("BUG: unsupported object type in the tree");
 	}
 
 	return result;
@@ -1811,7 +1811,7 @@ static int process_entry(struct merge_options *o,
 		 */
 		remove_file(o, 1, path, !a_mode);
 	} else
-		die(_("BUG: fatal merge failure, shouldn't happen."));
+		die("BUG: fatal merge failure, shouldn't happen.");
 
 	return clean_merge;
 }
@@ -1869,7 +1869,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die(_("BUG: unprocessed path??? %s"),
+				die("BUG: unprocessed path??? %s",
 				    entries->items[i].string);
 		}
 
-- 
2.9.0.281.g286a8d9


