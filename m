Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0446B201A7
	for <e@80x24.org>; Sat, 20 May 2017 23:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbdETXhu (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 19:37:50 -0400
Received: from avasout07.plus.net ([84.93.230.235]:33741 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbdETXht (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 19:37:49 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id Nndm1v0041keHif01ndnoY; Sun, 21 May 2017 00:37:48 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=hMgo07bgswL3bjpvHG8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] diff: mark some file local symbols as static
Message-ID: <578bfb5b-bdd1-a418-98f2-d26e1bff0be2@ramsayjones.plus.com>
Date:   Sun, 21 May 2017 00:37:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Stefan,

If you need to re-roll your 'sb/diff-color-move' branch, could you
please squash this into to the relevant patches. (Each hunk would
be squashed into a separate commit, thus:
  - commit 9b68d54c11, "diff: buffer all output if asked to"
  - commit 4b71ba47ab, "submodule.c: convert show_submodule_summary to use emit_line_fmt"
  - commit 703d25581d, "diff.c: convert show_stats to use emit_line_*"
).

Thanks!

ATB,
Ramsay Jones

 diff.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index ba23c5862..15f389676 100644
--- a/diff.c
+++ b/diff.c
@@ -810,10 +810,10 @@ static void append_buffered_patch_line(struct diff_options *o,
 	f->line = e->line ? xmemdupz(e->line, e->len) : NULL;
 }
 
-void emit_line(struct diff_options *o,
-	       const char *set, const char *reset,
-	       int add_line_prefix, int markup_ws,
-	       int sign, const char *line, int len)
+static void emit_line(struct diff_options *o,
+		      const char *set, const char *reset,
+		      int add_line_prefix, int markup_ws,
+		      int sign, const char *line, int len)
 {
 	struct buffered_patch_line e = {set, reset, line,
 		len, sign, add_line_prefix,
@@ -825,10 +825,10 @@ void emit_line(struct diff_options *o,
 		emit_buffered_patch_line(o, &e);
 }
 
-void emit_line_fmt(struct diff_options *o,
-		   const char *set, const char *reset,
-		   int add_line_prefix,
-		   const char *fmt, ...)
+static void emit_line_fmt(struct diff_options *o,
+			  const char *set, const char *reset,
+			  int add_line_prefix,
+			  const char *fmt, ...)
 {
 	struct strbuf sb = STRBUF_INIT;
 	va_list ap;
@@ -1862,8 +1862,8 @@ static void fill_print_name(struct diffstat_file *file)
 	file->print_name = pname;
 }
 
-void print_stat_summary_0(struct diff_options *options, int files,
-			  int insertions, int deletions)
+static void print_stat_summary_0(struct diff_options *options, int files,
+				 int insertions, int deletions)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-- 
2.13.0
