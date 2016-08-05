Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7752018E
	for <e@80x24.org>; Fri,  5 Aug 2016 20:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2996723AbcHEUh1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 16:37:27 -0400
Received: from mout.web.de ([212.227.17.12]:52204 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761921AbcHEUhU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 16:37:20 -0400
Received: from [192.168.178.36] ([79.213.113.59]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MKrPw-1bVlrk2KNk-0005zI; Fri, 05 Aug 2016 22:37:12
 +0200
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use strbuf_addstr() instead of strbuf_addf() with "%s"
Message-ID: <57A4F8F7.5020109@web.de>
Date:	Fri, 5 Aug 2016 22:37:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:4q+pelaL6939gm3rRbl07tNGNnL7/Vh0YsZCGLZ53YIGe/dlxot
 tpFttoEUsbn2nSp6TTUTwEO7d24JShwAu0gNgQhQKOc3BwpvEuOJq/7Uaq0bo9Ylhlx5WX2
 HOX9td/UB3u9OOB/nHQKx0lZYkAdTDdXR2TH8ojvp60G1cyftkjs/YjqaoOL8EvH+iTYxM2
 sQjc+I68CfvvKbDGCuYsg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:3WiYy79q48c=:k3M0V1HcDgaWpIfZG+SwaA
 lfrY4ylHiNv2RwDNmEgSFrUAtoR9W+ifcTml24PMZA62I8N8SGROzLvob3gHDDYoF6SxUXOwk
 gtee50X6MydXcJRTTJuHLSMpPM2K/RlTGwD0GeTv38UmwhHjRrb0lTjNZF5uzuf7cnvZA3HgN
 YfKEmdrqeCA0U+Wb9TkeR6fnXerOlAgifc3FU1zgE/g4Nct8AnZGXQMOG3uZ+id1W1ezwNwl3
 aXfbHqlxWLFAEOMZ48VVd5pA4gp1kgq9yMxlHv5MnauqKZxl4ewawhBKY91asR2+2tXXAZQ/U
 12ZdYbolqix/w2HVASs3yXnKSjw0kgL1gOPmdW6GzblcVUjbSbIoP1N5eT6NzAQffovYF7svk
 ESwEM+WWEloHt7jS71vrwFVg6rpDPWUkFW1814JB/AF0bHUr/qOooBExDhhEXQOn5ZBIiCnMP
 8EJEfd13LbnllhWQHl8gok3wxFPrL3ljxZdUBZUYIcQwSMp2yoUXrzps441tZzRqs/vZsJ0rA
 fV4rD/467owx00Rh8Nh8uc8kdLwZD7RX8MNagi3gSRV1XTBgvLnLqrc0cuvSq3uBOwFIMdgvZ
 G8nfLT4rxe4K1iB+iCaUl+ipFasuWzd/upm48+jROOAtLb8QqFi6lFgPTdtNfp6ZU4GDzz/QW
 LBy2/6QT2lmbbKU3r9mprUO60YXqYKRd2ObL/q8++zZTIgV6FDGqAYyp5VwY39s4MTh0s5ClR
 I4bRptJyQ+oNtbl84wuHE9/qCWmXA1d4ARwRYEOrS8Pq45oLG6hZLfw7ThnG8X72wrVXyC8/g
 o710eSW
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Call strbuf_addstr() for adding a simple string to a strbuf instead of
using the heavier strbuf_addf().  This is shorter and documents the
intent more clearly.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/fmt-merge-msg.c | 2 +-
 http.c                  | 2 +-
 sequencer.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e5658c3..ac84e99 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -272,7 +272,7 @@ static int cmp_string_list_util_as_integral(const void *a_, const void *b_)
 static void add_people_count(struct strbuf *out, struct string_list *people)
 {
 	if (people->nr == 1)
-		strbuf_addf(out, "%s", people->items[0].string);
+		strbuf_addstr(out, people->items[0].string);
 	else if (people->nr == 2)
 		strbuf_addf(out, "%s (%d) and %s (%d)",
 			    people->items[0].string,
diff --git a/http.c b/http.c
index e81dd13..cd40b01 100644
--- a/http.c
+++ b/http.c
@@ -1225,7 +1225,7 @@ void append_remote_object_url(struct strbuf *buf, const char *url,
 
 	strbuf_addf(buf, "objects/%.*s/", 2, hex);
 	if (!only_two_digit_prefix)
-		strbuf_addf(buf, "%s", hex+2);
+		strbuf_addstr(buf, hex + 2);
 }
 
 char *get_remote_object_url(const char *url, const char *hex,
diff --git a/sequencer.c b/sequencer.c
index cdfac82..7b1eb14 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -112,7 +112,7 @@ static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
 
-	strbuf_addf(&seq_dir, "%s", git_path(SEQ_DIR));
+	strbuf_addstr(&seq_dir, git_path(SEQ_DIR));
 	remove_dir_recursively(&seq_dir, 0);
 	strbuf_release(&seq_dir);
 }
-- 
2.9.2

