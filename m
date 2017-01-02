Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F23BE205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756373AbdABP2c (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:32 -0500
Received: from mout.gmx.net ([212.227.15.19]:50251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756363AbdABP2a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:30 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSMKx-1bv6d118Q7-00TYkB; Mon, 02
 Jan 2017 16:28:24 +0100
Date:   Mon, 2 Jan 2017 16:28:23 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 25/38] sequencer (rebase -i): run the post-rewrite hook,
 if needed
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <60bfbf24fe89bad4bb8295baa216f98932d4ee8f.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HB0pcWxQwDbV5cZInPn7s7/IGR5nLa5uEq8oKor0igyrjyO+tVa
 21L4miQf/n9msbr4E0GfCx0ZBDUcv8wKgRDYUkVsjEPX4WAbnzCENHvZk6FRdklJOSFXqGC
 YC6gHqLwSZpjYMRW+o9YoQq86iePV4oz73vd7Rxq0CekQo36sRtarqnwSpzr9JPuM0i6Mqj
 rsHcRVGRZy+Fhu0MCZkyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Eb6QSTR4jbk=:KRvvJjPYNgqjzYqJeVbzei
 RJ9v2ys/85r7zHIIEje6LFflpyDTBmwkq2XBJSkykUCzGctdHiavSV1o/7AZeeF2mLBm42+3O
 6gCnVy3cyCLSbyHmQ5FTtMfHN2U54/gO+sTWdBqN0pCdXOFJ8J0dsM3GyoCpwNRhHYTj3ARqK
 +kT+n0Uy3/2A5LPKFtVP4b9FPrxljoP8VeaU6LAZIelDIyod+VthlBiBXl/gZ+KWOIGZoTFek
 aEwnmIB/+mLBkUVfTqaQETB59m8ENBTJTEamGgx3eI06C5dUjN8rLFyVEmOCMxLxFF8q8xt0g
 T8RmQXxz18vyIedE50zBCHtW5e3ho1+F2irDoutZA4iFq0eqQi17y3YQ+BfVsXgRKRE5gXVxU
 T6A3ZIq3faAikKuyacAKmk4/6nbt7lcCEY/gMQpQSL5MXFtwoebrogtlaKBe5MLSKf5Fly5wc
 lhMldR4p8+W/8eQ0ia4aJ5vEqB1BPh3Up3re+xpWfB5arAGkF3hc5wfJOm/Yo5/L4ROmYk9nF
 6q++9MFOp0La93iuT5EDBio1HZYFmwcyABhS5z/GRZGx4uXrxrQlMxXIdL4c0X2DADpVIN5Sb
 lLmRCFdOsWN/jymEDBfTYiqa5jsGmQzRDMXBlKQeEpyOGYKDnTZfed1zDv9Yo2Q4tYqBmv8rz
 ej0DV0oKo7OFFPQ+XuL8kaSGW+vPLOKzFowcknOuU76EkFu/xwfefJfg7TZobogmrEzI61DbP
 OtszjACGl9dtnVUSt3bae4of3T1b/dfSI6f6u/YL/IOwvL7KWlSVVvaT6DlU3N031679Frdhq
 3+XyL3X
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index d7273fd1b3..43ced8db31 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1957,6 +1957,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process child = CHILD_PROCESS_INIT;
+			const char *post_rewrite_hook =
+				find_hook("post-rewrite");
 
 			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			child.git_cmd = 1;
@@ -1965,6 +1967,18 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			argv_array_push(&child.args, "--for-rewrite=rebase");
 			/* we don't care if this copying failed */
 			run_command(&child);
+
+			if (post_rewrite_hook) {
+				struct child_process hook = CHILD_PROCESS_INIT;
+
+				hook.in = open(rebase_path_rewritten_list(),
+					O_RDONLY);
+				hook.stdout_to_stderr = 1;
+				argv_array_push(&hook.args, post_rewrite_hook);
+				argv_array_push(&hook.args, "rebase");
+				/* we don't care if this hook failed */
+				run_command(&hook);
+			}
 		}
 
 		strbuf_release(&buf);
-- 
2.11.0.rc3.windows.1


