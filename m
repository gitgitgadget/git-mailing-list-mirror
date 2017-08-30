Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4C9420285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbdH3SAl (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:00:41 -0400
Received: from mout.web.de ([217.72.192.78]:64989 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752561AbdH3SAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:00:39 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MS290-1dxSLk0CTq-00TF78 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:00:38 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 21/34] refs: release strbuf on error return in write_pseudoref()
Date:   Wed, 30 Aug 2017 20:00:24 +0200
Message-Id: <20170830180037.20950-2-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830180037.20950-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de>
X-Provags-ID: V03:K0:8bNp+3othJx1BrvDeLkK0HAKYbaphLvBbpstggjtT8ARtMuyQ1H
 WSlHDgHfRD5tiTKnf8+iRgalvRVmtfQ5B3bhACBLERvbu1ik43NQIKotnH9JrnO1VjbprpJ
 raQh7HIUzVBkDCl2RF/PFAW7Ac+EvAsGGT2G3WupjrXrHdS/zSxA0pUyVnRrrEUlR2l/rtz
 Nb5fvcPcIK1kLIbKk1u5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YL1g0LDNnew=:fy3SJJ/RaMEhrKQi+DG6sO
 H6MLDW85hzkbzpoRvxRZxXmrGTs1hZ7tAn/FNDzOuocS4hEUAqCZCHr+TRi1s2ppt4Dxy3LX2
 TEZP+IQXEKfgqFGVr8PuRovtA8MSmBUsnqR5BFinRF1F69fijbqDWCRVYWFw9hYYo0HdPg/il
 HtB9mioroib0a4EHhoBxYUpWDhEEHcRNKerO3kwf6W0DR2sryN3uHOCGcPo/VXwO5OtjMb8hY
 ZA1RtBJ64YVbZWB1tuVpPJFwSWgs/IDXcYiEJGP43z/mDd2dF/Q+DRa+Jx7FW5l5SjLGxkp9G
 yEHe9AzQwRQ+J81sarnAGNk9TvsihISFGF3hSK03Y5uigXwWpVfU+9YEWasfrcHu/pMTVXru9
 CI+AG0LMgnfaJu0hn0xL4nW9wZvkL8XA1aVjZjtU46RBUR7Xtj2k/n6LjbGIdIZm/4psnTQA/
 yUrvP2+eU2EdS/Lk5RUMfOmTC6GfrceNx7Fxk5nb0z5vJcDDue0yQ5bpOOw9zrWxMzFJ8L9AT
 zvcZ3GRvI5fxtjL9oHld8a/TKgSblA64v3Wv8cPDNhNhqe7kRSgupRJPWCl6qh/uXhrlzDFUS
 mUzs2p4m/bhRYPSlIDK2l555Io4QyIPpMMESEYf8Mt5mOjLSpdL+ECaNammoXzjJSXpp0BPQe
 E4JNdHP2yw1vvv3AMgBWGMcSUlN3cai4CeWxFMF8iPfzWyIy3hy4QugDGXJYLpmaX0lQAWddu
 0a9L/3yrYDuDpKgwIwJbRlAsA/jKOaEkKo+bwupaowjy2hTXDsnMwFQJGWQXxOgFaNVzAq3YD
 m+SWElL/gWQHeY+xWHkdqzUaIFilg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index b0106b8162..d8dc86b1f5 100644
--- a/refs.c
+++ b/refs.c
@@ -597,45 +597,45 @@ long get_files_ref_lock_timeout_ms(void)
 static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 			   const unsigned char *old_sha1, struct strbuf *err)
 {
 	const char *filename;
 	int fd;
 	static struct lock_file lock;
 	struct strbuf buf = STRBUF_INIT;
 	int ret = -1;
 
 	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
 
 	filename = git_path("%s", pseudoref);
 	fd = hold_lock_file_for_update_timeout(&lock, filename,
 					       LOCK_DIE_ON_ERROR,
 					       get_files_ref_lock_timeout_ms());
 	if (fd < 0) {
 		strbuf_addf(err, "could not open '%s' for writing: %s",
 			    filename, strerror(errno));
-		return -1;
+		goto done;
 	}
 
 	if (old_sha1) {
 		unsigned char actual_old_sha1[20];
 
 		if (read_ref(pseudoref, actual_old_sha1))
 			die("could not read ref '%s'", pseudoref);
 		if (hashcmp(actual_old_sha1, old_sha1)) {
 			strbuf_addf(err, "unexpected sha1 when writing '%s'", pseudoref);
 			rollback_lock_file(&lock);
 			goto done;
 		}
 	}
 
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len) {
 		strbuf_addf(err, "could not write to '%s'", filename);
 		rollback_lock_file(&lock);
 		goto done;
 	}
 
 	commit_lock_file(&lock);
 	ret = 0;
 done:
 	strbuf_release(&buf);
 	return ret;
 }
-- 
2.14.1

