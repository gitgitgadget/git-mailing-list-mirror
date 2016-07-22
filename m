Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765F720195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbcGVM0F (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:26:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:56683 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064AbcGVM0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:26:03 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MQ2zr-1bLsp61hUh-005Jl3; Fri, 22 Jul 2016 14:25:55
 +0200
Date:	Fri, 22 Jul 2016 14:25:53 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 14/16] merge-recursive: offer an option to retain the
 output in 'obuf'
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <57d6b5ec8dbf6d43e92eae562d3ba48d481aff67.1469187653.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ss4mF6f2H6abm6qyWqMbBqiLPQWgzzqSwxMsximDy0FZDw1rXP2
 ZlepJWp6DsfJJ3U2/5fg6k1oWVWklPHf/F2UAaHp/DwXAAc2HnTCgE3ItGf1A2QsrsCWAWh
 IZzM1/zEKend3yMqBLIQcEQDzirAYH8mLu4/A5ndysRfycv5ed7EmF28YjGAdFgWTRcCgay
 BiMPWi63Lfs4a5XprMr7g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Y4OYeyhNnB8=:jg2hKkcjrvXRZVuD3urb/R
 Yi+WKC4qfyuICbVJZ6XZoSGKOEDK3cT1a7lQxR9yJUROHzBMJ23QBpbsUSzvdFPozYemktgek
 pAea3O/qqa/W3DM5kyIX+n3plNSMqyMaRfLH7+Kuz434kM5s0dLyPxkabmIAMWIIY4U7osc4z
 RrmSPGGc7CWrHqVJkpA+javLH3YhbHuE7UMGi2LHkgQEJRbQNkjCJ0xypkt39gqjLwHUrPksK
 EKQ0BOvdDeFeDSB2MHutq4Tt6F7g9ZoWDGvPEXvq8cl3sPh42HotMwnRHmw/xBX3CppZ3MWyU
 UPHVRQhZQ5in8qsNR1gwcDMFHDSZO9zk77wb0NWIo4dD0sUriHRlIAfQ/FAAr2w6jlxXidSbL
 5WWr+77d6jWUTcRO0jDgdlZoZAyhgqkFX702oeLcW93MeirGCCpXcb0uSqR+RwZUJXXXuibvR
 9lR+kAiBjeEsD90AhC7r7lLi/tBX3uTHJgIQCe6yBja4Cyt4rvQnXOeHIj0yX4LaP3KBIz3iy
 5R2tFLZIDMBV9D/iBNRSCTrVJdc7Ypv7x2OjkYziR7FLuZjGp8hFP12HizWU05dhpnS1cWBqV
 LQS/wn31ECA2vFf6NjZqQE7sKmrDyyj4kHRVUfwmrNdwjfkz9k/GjPiYLW/NRg0cpp6/saukS
 krbhiFu4uJ0hqbizkYJ3CN8rggSftRTl3WFeRooyyBjdevNgxpHLNADB1XK5xFEsiEwgHLFB0
 XvXwtaFADeTJPMuw+n0F/drVXDGjps1oSN3ddvyuMJ5bz4pKgYALVgpVRtdGCJouHTmQCh9Tu
 0aVlsej
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Since 66a155b (Enable output buffering in merge-recursive., 2007-01-14),
we already accumulate the output in a buffer. The idea was to avoid
interfering with the progress output that goes to stderr, which is
unbuffered, when we write to stdout, which is buffered.

We extend that buffering to allow the caller to handle the output
(possibly suppressing it). This will help us when extending the
sequencer to do rebase -i's brunt work: it does not want the picks to
print anything by default but instead determine itself whether to print
the output or not.

Note that we also redirect the error messages into the output buffer
when the caller asked not to flush the output buffer, for two reasons:
1) to retain the correct output order, and 2) to allow the caller to
suppress *all* output.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 17 +++++++++++++----
 merge-recursive.h |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2bc41fe..1746c38 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -25,7 +25,7 @@
 
 static void flush_output(struct merge_options *o)
 {
-	if (o->obuf.len) {
+	if (o->buffer_output < 2 && o->obuf.len) {
 		fputs(o->obuf.buf, stdout);
 		strbuf_reset(&o->obuf);
 	}
@@ -36,10 +36,19 @@ static int err(struct merge_options *o, const char *err, ...)
 	va_list params;
 
 	va_start(params, err);
-	flush_output(o);
+	if (o->buffer_output < 2)
+		flush_output(o);
+	else {
+		strbuf_complete(&o->obuf, '\n');
+		strbuf_addstr(&o->obuf, "error: ");
+	}
 	strbuf_vaddf(&o->obuf, err, params);
-	error("%s", o->obuf.buf);
-	strbuf_reset(&o->obuf);
+	if (o->buffer_output > 1)
+		strbuf_addch(&o->obuf, '\n');
+	else {
+		error("%s", o->obuf.buf);
+		strbuf_reset(&o->obuf);
+	}
 	va_end(params);
 
 	return -1;
diff --git a/merge-recursive.h b/merge-recursive.h
index d415724..340704c 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -13,7 +13,7 @@ struct merge_options {
 		MERGE_RECURSIVE_THEIRS
 	} recursive_variant;
 	const char *subtree_shift;
-	unsigned buffer_output : 1;
+	unsigned buffer_output : 2; /* 1: output at end, 2: keep buffered */
 	unsigned renormalize : 1;
 	long xdl_opts;
 	int verbosity;
-- 
2.9.0.281.g286a8d9


