Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3EB1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbcGSSgw (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:36:52 -0400
Received: from mout.web.de ([212.227.15.4]:55576 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847AbcGSSgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:36:50 -0400
Received: from [192.168.178.36] ([79.237.58.95]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MEZPl-1bao942jIv-00Fj2d; Tue, 19 Jul 2016 20:36:35
 +0200
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use strbuf_addbuf() for appending a strbuf to another
Message-ID: <578E732D.2090803@web.de>
Date:	Tue, 19 Jul 2016 20:36:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:UpGi5rncrZLSRgfJeCVaK3+UNSmtUtGQ3YhX75IGoEkwf3L6wMI
 EoAwRuIamJ+idNutJf4CEBEHPKbergxe8RMvqpJ9O+8BuyxgJwAVTwwW+qqorchZiWvCJ00
 oylqFmp3sdCBtFsgAQU6JWl7XRbfIH40icVzBjm9U7Yx7IgrJRo5aGV2KHSykJ+1Q+Qt1AB
 dxDmKDggnqWf0xNDSotbA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:HMGrxQ7Uo1A=:dmS7rYWC4LnotX/j+ShezC
 QCAq4aP31YLushAooolTMA1uDh5M5Z0SOhR3T07dGML3bStszZf+DFnMX1XUmHAD/4NMq8zyV
 VpqC+4jNR77q6+JBYFbCKA5ZrxXjeqJMrzSr+XQ0Ql1HIi1L6NPyFvrgEn5igiYlXasAx31cO
 kNFVFHhQAJH8ija2YFzS1iVte3sckwALB+FKPII0QzmlGnWF/06YJzY3/8OLVWZ8KKeX5pBaj
 hFWRr5R2o5p692zTVL8QeiIBp5NsNmqai8Je55aYB/NRD+Lqqsf84AHgrg63JyMKgUOrxdQYQ
 tllfPXtj0LTFyO5Ck8l+KEjVa3ctX4g8Pkv9q2zXgqNKIJMPB4Yxh0kOi7XotX3LGxS23rXVe
 Eltc2S4G/HNCgtheNnQ06vLxojSPfG2dNAYwaAL7Txb9dq77Pq1Qjw7sHowG+ShVt44MPrw/m
 o26nIWTKmbvxkkqCYv95IqZkK9kRoFKoszxFsN2cFG+zpBz8KNe3PcLPOSdcjt6LMkS7y6IcG
 xmZq4zuDQ8RIAM4w52j0V2BU9Dj1RPCC4xy9xaYkmMFn5GlqWST2ddWp4bFLWMwU9NnP7Irpm
 I5tDqsVER4OGkIfNEV1zWTBfOptRtTPHSHGSudSGW4VUlo8/fz9bMcmPSiqu+QoZQXKDq3jyW
 zdHoOoS+tBWDNDmlJFPiqgjpyIIEBKd9aTz1N0w5BiLFTpROVlPwRtlI6FQmoQAguZyn66Lz5
 NfOOGXyKacPZ90i9fAY7PreRFc3cbUsH2k7gkxtiVOuqEx5vqrvEjKKJld+2vMQ1TkfE3cPNT
 mV7Uag8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Use strbuf_addbuf() where possible; it's shorter and more efficient.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 dir.c       | 2 +-
 path.c      | 2 +-
 wt-status.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 6172b34..0ea235f 100644
--- a/dir.c
+++ b/dir.c
@@ -2364,7 +2364,7 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 
 	varint_len = encode_varint(untracked->ident.len, varbuf);
 	strbuf_add(out, varbuf, varint_len);
-	strbuf_add(out, untracked->ident.buf, untracked->ident.len);
+	strbuf_addbuf(out, &untracked->ident);
 
 	strbuf_add(out, ouc, ouc_size(len));
 	free(ouc);
diff --git a/path.c b/path.c
index 259aeed..17551c4 100644
--- a/path.c
+++ b/path.c
@@ -483,7 +483,7 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 		strbuf_addstr(buf, git_dir);
 	}
 	strbuf_addch(buf, '/');
-	strbuf_addstr(&git_submodule_dir, buf->buf);
+	strbuf_addbuf(&git_submodule_dir, buf);
 
 	strbuf_vaddf(buf, fmt, args);
 
diff --git a/wt-status.c b/wt-status.c
index c19b52c..dbdb543 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1062,7 +1062,7 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 			strbuf_addf(split[1], "%s ", abbrev);
 			strbuf_reset(line);
 			for (i = 0; split[i]; i++)
-				strbuf_addf(line, "%s", split[i]->buf);
+				strbuf_addbuf(line, split[i]);
 		}
 	}
 	strbuf_list_free(split);
-- 
2.9.2

