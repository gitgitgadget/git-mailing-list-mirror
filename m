Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5D11F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbcHALpY (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:45:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:50833 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334AbcHALpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:45:09 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LlpJU-1av7wo4BhA-00ZML1; Mon, 01 Aug 2016 13:44:51
 +0200
Date:	Mon, 1 Aug 2016 13:44:50 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 14/16] merge-recursive: offer an option to retain the
 output in 'obuf'
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <2983ef4f7596c110b771f1da82dc84e426de19fd.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nfFuGGrSg74XOg/Pw5XBcp0NRfVKa59xtZkV3aA5RUoP4eWhf94
 aSpxU4+tpmpXm7VrxGZ6lcT/ismEtTTHIQ9M1bm0W7hQsEeyOlzqjC4P2bZpdEGtydemCWB
 RHAgpp+Q+EcpaN8vZobimwEMH0Qr16uaV2TTQOcMqvrkhev/4RWP7Ew+lunVdbIUMBLy5Y6
 hgEoAVkt0iSquLs24E6cQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:8xhfOv1k3f0=:0FDEmeQFWu29CG7aEuHfXK
 7/heADHUYYi/OuukUCHJO6qcJqSKEvc+BC4nkjQw+lrOXAIe6bVB7scOTYKiyolNl7LaSmgid
 aRbElb27B9Cqo6mmyHRBxgm8TnxtEqDFmTxQ7NgB9JQTKu8P0Nf7G/b4paDUdzpdUPjVsxSqJ
 3VC8CfrajNHebs0OCMwky8MuTHmwqgekH88MY1cvcL+r9T39gzyzI0JHoLT7SyyC2fllmuTCz
 tNdbnD+1SKJ7RL2E/FGKrK5OYuez/ckQz7mEeFi8oCLFWWIJaV4m8yI774t+SFlzzoD6Du+RA
 coDGSB1+N67rxxoKSvrENQIeWBB5b18wARP4PylVhZEz7BYLY65Qiv1JdLhMhzsUm4ciKh9OM
 MuwA+VkoZ1SSuRWneR2R9bNzgN19yp6OvU3y89CebECZJHgFmUFsQ+uns/dtnBM6k82CE5+LV
 dv9k5+QxXL4R9ML6O7t1OFaNHoXyhy3afOjVJbcsm3e33gfXk5KIEVREb+Mas+gauwTEtfohl
 brmNJrZkm1mLk8OywI0U6yoWxWYmTX2oDxW0vdSx3aY2yVgJPL09ye5qvTMahB8jRWhEFna7k
 G6rU3oZxqyg6cSpjMwKgNx04vMyI6pDALuYfilbc0kG7T/vKnx8v3jENREjBtF4Vi7U3bMZDW
 Rni0qPl+J/WhyiHYhtUZYyFzCupzDXptpbxeQLmFFpJaxyQ9UuaIj1rILnno1zE3X17bAHSEp
 8/0iShXdpoWCP5kdNUlLn02x5kYLO8jn/zPkrD61J+SSlS/Yehmv8p+mMd1fo4pxTdaiffgTS
 Xl8sk1a
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
index 99c9635..ec50932 100644
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
@@ -35,12 +35,21 @@ static int err(struct merge_options *o, const char *err, ...)
 {
 	va_list params;
 
-	flush_output(o);
+	if (o->buffer_output < 2)
+		flush_output(o);
+	else {
+		strbuf_complete(&o->obuf, '\n');
+		strbuf_addstr(&o->obuf, "error: ");
+	}
 	va_start(params, err);
 	strbuf_vaddf(&o->obuf, err, params);
 	va_end(params);
-	error("%s", o->obuf.buf);
-	strbuf_reset(&o->obuf);
+	if (o->buffer_output > 1)
+		strbuf_addch(&o->obuf, '\n');
+	else {
+		error("%s", o->obuf.buf);
+		strbuf_reset(&o->obuf);
+	}
 
 	return -1;
 }
diff --git a/merge-recursive.h b/merge-recursive.h
index d415724..735343b 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -13,7 +13,7 @@ struct merge_options {
 		MERGE_RECURSIVE_THEIRS
 	} recursive_variant;
 	const char *subtree_shift;
-	unsigned buffer_output : 1;
+	unsigned buffer_output; /* 1: output at end, 2: keep buffered */
 	unsigned renormalize : 1;
 	long xdl_opts;
 	int verbosity;
-- 
2.9.0.281.g286a8d9


