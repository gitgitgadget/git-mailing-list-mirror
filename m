Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF04202C9
	for <e@80x24.org>; Wed,  1 Mar 2017 00:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdCAAil (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 19:38:41 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32799 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbdCAAij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 19:38:39 -0500
Received: by mail-pg0-f66.google.com with SMTP id x17so3593873pgi.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 16:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=SbU35OOTcoXv7+VXt4B86lfNrpdaP/tSnFL6pzQLBrg=;
        b=HhNfeOERc++uyVcMJDAQOoDXiNuAvPvBHTFHgA1CasL0q8ea5R0GHX8xlmgtboNISU
         flV/TuFqgSx1AzyUC9aOAt1kWzm3vVMKC3ExMv8pGiCMivDH/EJIXM4xgOfVUQiCk5uT
         TcE0u0+bXgTb5Za4a6mBJUiMlm4G7YaJGscRZY9JDXzuOyaYjub4U3gOkk61awqI5liQ
         uMt1Dth4xXCsZH9oyXq8qfw6GwwuRzapSbycZ0PhhQgFjyg7eP9a1BDVfeiSzjuE8+FU
         baV4qjwFY4uXQIshKSzTixCJX/LGHs/oS/c9b8SH3KHXGNVls3muypzRlMWfX9xGgbm+
         gXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=SbU35OOTcoXv7+VXt4B86lfNrpdaP/tSnFL6pzQLBrg=;
        b=d3lETif6qmof/oct5792Z8ErfiuXcV6PKVDNOtZoM2GkPiGTWG756V1HyoVrEYB/zl
         0MUONl760tDtBXi1G90Z7cEpDS0Atag+OvoYAwiRuYcEwKYM26GYXVl8C2RKTfQv0ojb
         WRqbTIC1BQhowIOB6Pq4nbWvEKQOf6en6o7V1iHk8jhcKmF5RxRj37KLLC1WDSy8T4oV
         cP0wVayE/dK3Z9LINNyBPWKD20AYQ+yJ14tzGj1mUcxXV5OrzP0ezhHXYh+TZxpd5mfw
         CZjRwMmETZ/gwTCNNGXvTQTzMTj5qbZOACE9WLR/Oa1wkMonOzEIYVvb5GOYLss67P9/
         09vw==
X-Gm-Message-State: AMke39k+PAhSSlaWn6aPg+LA7e0QjVm9JARtP97RhuAO9YW8LyDBVOocOyLprxnYDh53fQ==
X-Received: by 10.99.0.23 with SMTP id 23mr5586612pga.139.1488328227646;
        Tue, 28 Feb 2017 16:30:27 -0800 (PST)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id x2sm6326858pfb.49.2017.02.28.16.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Feb 2017 16:30:27 -0800 (PST)
Date:   Tue, 28 Feb 2017 16:30:26 -0800 (PST)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] Put sha1dc on a diet
Message-ID: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Feb 2017 16:12:32 -0800
Subject: [PATCH] Put sha1dc on a diet

This removes the unnecessary parts of the sha1dc code, shrinking things from

	[torvalds@i7 git]$ size sha1dc/*.o
	   text	   data	    bss	    dec	    hex	filename
	 277559	    640	      0	 278199	  43eb7	sha1dc/sha1.o
	   4438	  11352	      0	  15790	   3dae	sha1dc/ubc_check.o

to

	[torvalds@i7 git]$ size sha1dc/*.o
	   text	   data	    bss	    dec	    hex	filename
	  13287	      0	      0	  13287	   33e7	sha1dc/sha1.o
	   4438	  11352	      0	  15790	   3dae	sha1dc/ubc_check.o

so the sha1.o text size shrinks from about 271kB to about 13kB.

The shrinking comes mainly from only generating the recompressio functions 
for the two rounds that are actually used (58 and 65), but also from 
removing a couple of other unused functions. The sha1dc library lost its 
"safe_hash" parameter to do that, since we check - and refuse to touch - 
the colliding cases manually.

The git binary itself is about 2MB of text on my system. For other helper 
binaries the size reduction is even more noticeable.  A quarter MB here 
and a quarter MB there, and suddenly you have a big binary ;)

This has been tested with the bad pdf image:

	[torvalds@i7 git]$ ./t/helper/test-sha1 < ~/Downloads/bad.pdf 
	fatal: The SHA1 computation detected evidence of a collision attack;
	refusing to process the contents.

although we obviously still don't have an actual git object to test with.

The normal git test-suite obviously also passes.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I notice that sha1dc is in the 'pu' branch now, so let's put my money 
where my mouth is, and send in the sha1dc diet patch.

 sha1dc/sha1.c | 356 +++-------------------------------------------------------
 sha1dc/sha1.h |  24 ----
 2 files changed, 18 insertions(+), 362 deletions(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 6569b403e..4910f0c35 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -9,6 +9,15 @@
 #include "sha1dc/sha1.h"
 #include "sha1dc/ubc_check.h"
 
+// function type for sha1_recompression_step_T (uint32_t ihvin[5], uint32_t ihvout[5], const uint32_t me2[80], const uint32_t state[5])
+// where 0 <= T < 80
+//       me2 is an expanded message (the expansion of an original message block XOR'ed with a disturbance vector's message block difference)
+//       state is the internal state (a,b,c,d,e) before step T of the SHA-1 compression function while processing the original message block
+// the function will return:
+//       ihvin: the reconstructed input chaining value
+//       ihvout: the reconstructed output chaining value
+typedef void(*sha1_recompression_type)(uint32_t*, uint32_t*, const uint32_t*, const uint32_t*);
+
 #define rotate_right(x,n) (((x)>>(n))|((x)<<(32-(n))))
 #define rotate_left(x,n)  (((x)<<(n))|((x)>>(32-(n))))
 
@@ -39,212 +48,14 @@
 
 
 
-void sha1_message_expansion(uint32_t W[80])
+static void sha1_message_expansion(uint32_t W[80])
 {
 	unsigned i;
 	for (i = 16; i < 80; ++i)
 		W[i] = rotate_left(W[i - 3] ^ W[i - 8] ^ W[i - 14] ^ W[i - 16], 1);
 }
 
-void sha1_compression(uint32_t ihv[5], const uint32_t m[16])
-{
-	uint32_t W[80];
-	uint32_t a, b, c, d, e;
-	unsigned i;
-
-	memcpy(W, m, 16 * 4);
-	for (i = 16; i < 80; ++i)
-		W[i] = rotate_left(W[i - 3] ^ W[i - 8] ^ W[i - 14] ^ W[i - 16], 1);
-
-	a = ihv[0];
-	b = ihv[1];
-	c = ihv[2];
-	d = ihv[3];
-	e = ihv[4];
-
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(a, b, c, d, e, W, 0);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(e, a, b, c, d, W, 1);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(d, e, a, b, c, W, 2);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(c, d, e, a, b, W, 3);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(b, c, d, e, a, W, 4);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(a, b, c, d, e, W, 5);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(e, a, b, c, d, W, 6);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(d, e, a, b, c, W, 7);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(c, d, e, a, b, W, 8);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(b, c, d, e, a, W, 9);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(a, b, c, d, e, W, 10);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(e, a, b, c, d, W, 11);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(d, e, a, b, c, W, 12);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(c, d, e, a, b, W, 13);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(b, c, d, e, a, W, 14);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(a, b, c, d, e, W, 15);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(e, a, b, c, d, W, 16);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(d, e, a, b, c, W, 17);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(c, d, e, a, b, W, 18);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(b, c, d, e, a, W, 19);
-
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(a, b, c, d, e, W, 20);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(e, a, b, c, d, W, 21);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(d, e, a, b, c, W, 22);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(c, d, e, a, b, W, 23);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(b, c, d, e, a, W, 24);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(a, b, c, d, e, W, 25);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(e, a, b, c, d, W, 26);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(d, e, a, b, c, W, 27);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(c, d, e, a, b, W, 28);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(b, c, d, e, a, W, 29);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(a, b, c, d, e, W, 30);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(e, a, b, c, d, W, 31);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(d, e, a, b, c, W, 32);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(c, d, e, a, b, W, 33);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(b, c, d, e, a, W, 34);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(a, b, c, d, e, W, 35);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(e, a, b, c, d, W, 36);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(d, e, a, b, c, W, 37);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(c, d, e, a, b, W, 38);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(b, c, d, e, a, W, 39);
-
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(a, b, c, d, e, W, 40);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(e, a, b, c, d, W, 41);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(d, e, a, b, c, W, 42);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(c, d, e, a, b, W, 43);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(b, c, d, e, a, W, 44);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(a, b, c, d, e, W, 45);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(e, a, b, c, d, W, 46);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(d, e, a, b, c, W, 47);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(c, d, e, a, b, W, 48);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(b, c, d, e, a, W, 49);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(a, b, c, d, e, W, 50);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(e, a, b, c, d, W, 51);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(d, e, a, b, c, W, 52);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(c, d, e, a, b, W, 53);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(b, c, d, e, a, W, 54);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(a, b, c, d, e, W, 55);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(e, a, b, c, d, W, 56);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(d, e, a, b, c, W, 57);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(c, d, e, a, b, W, 58);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(b, c, d, e, a, W, 59);
-
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(a, b, c, d, e, W, 60);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(e, a, b, c, d, W, 61);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(d, e, a, b, c, W, 62);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(c, d, e, a, b, W, 63);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(b, c, d, e, a, W, 64);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(a, b, c, d, e, W, 65);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(e, a, b, c, d, W, 66);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(d, e, a, b, c, W, 67);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(c, d, e, a, b, W, 68);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(b, c, d, e, a, W, 69);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(a, b, c, d, e, W, 70);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(e, a, b, c, d, W, 71);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(d, e, a, b, c, W, 72);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(c, d, e, a, b, W, 73);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(b, c, d, e, a, W, 74);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(a, b, c, d, e, W, 75);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(e, a, b, c, d, W, 76);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(d, e, a, b, c, W, 77);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(c, d, e, a, b, W, 78);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(b, c, d, e, a, W, 79);
-
-	ihv[0] += a; ihv[1] += b; ihv[2] += c; ihv[3] += d; ihv[4] += e;
-}
-
-
-
-void sha1_compression_W(uint32_t ihv[5], const uint32_t W[80])
-{
-	uint32_t a = ihv[0], b = ihv[1], c = ihv[2], d = ihv[3], e = ihv[4];
-
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(a, b, c, d, e, W, 0);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(e, a, b, c, d, W, 1);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(d, e, a, b, c, W, 2);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(c, d, e, a, b, W, 3);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(b, c, d, e, a, W, 4);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(a, b, c, d, e, W, 5);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(e, a, b, c, d, W, 6);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(d, e, a, b, c, W, 7);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(c, d, e, a, b, W, 8);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(b, c, d, e, a, W, 9);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(a, b, c, d, e, W, 10);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(e, a, b, c, d, W, 11);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(d, e, a, b, c, W, 12);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(c, d, e, a, b, W, 13);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(b, c, d, e, a, W, 14);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(a, b, c, d, e, W, 15);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(e, a, b, c, d, W, 16);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(d, e, a, b, c, W, 17);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(c, d, e, a, b, W, 18);
-	HASHCLASH_SHA1COMPRESS_ROUND1_STEP(b, c, d, e, a, W, 19);
-
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(a, b, c, d, e, W, 20);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(e, a, b, c, d, W, 21);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(d, e, a, b, c, W, 22);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(c, d, e, a, b, W, 23);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(b, c, d, e, a, W, 24);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(a, b, c, d, e, W, 25);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(e, a, b, c, d, W, 26);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(d, e, a, b, c, W, 27);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(c, d, e, a, b, W, 28);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(b, c, d, e, a, W, 29);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(a, b, c, d, e, W, 30);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(e, a, b, c, d, W, 31);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(d, e, a, b, c, W, 32);
- 	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(c, d, e, a, b, W, 33);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(b, c, d, e, a, W, 34);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(a, b, c, d, e, W, 35);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(e, a, b, c, d, W, 36);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(d, e, a, b, c, W, 37);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(c, d, e, a, b, W, 38);
-	HASHCLASH_SHA1COMPRESS_ROUND2_STEP(b, c, d, e, a, W, 39);
-
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(a, b, c, d, e, W, 40);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(e, a, b, c, d, W, 41);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(d, e, a, b, c, W, 42);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(c, d, e, a, b, W, 43);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(b, c, d, e, a, W, 44);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(a, b, c, d, e, W, 45);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(e, a, b, c, d, W, 46);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(d, e, a, b, c, W, 47);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(c, d, e, a, b, W, 48);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(b, c, d, e, a, W, 49);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(a, b, c, d, e, W, 50);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(e, a, b, c, d, W, 51);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(d, e, a, b, c, W, 52);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(c, d, e, a, b, W, 53);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(b, c, d, e, a, W, 54);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(a, b, c, d, e, W, 55);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(e, a, b, c, d, W, 56);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(d, e, a, b, c, W, 57);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(c, d, e, a, b, W, 58);
-	HASHCLASH_SHA1COMPRESS_ROUND3_STEP(b, c, d, e, a, W, 59);
-
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(a, b, c, d, e, W, 60);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(e, a, b, c, d, W, 61);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(d, e, a, b, c, W, 62);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(c, d, e, a, b, W, 63);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(b, c, d, e, a, W, 64);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(a, b, c, d, e, W, 65);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(e, a, b, c, d, W, 66);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(d, e, a, b, c, W, 67);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(c, d, e, a, b, W, 68);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(b, c, d, e, a, W, 69);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(a, b, c, d, e, W, 70);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(e, a, b, c, d, W, 71);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(d, e, a, b, c, W, 72);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(c, d, e, a, b, W, 73);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(b, c, d, e, a, W, 74);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(a, b, c, d, e, W, 75);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(e, a, b, c, d, W, 76);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(d, e, a, b, c, W, 77);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(c, d, e, a, b, W, 78);
-	HASHCLASH_SHA1COMPRESS_ROUND4_STEP(b, c, d, e, a, W, 79);
-
-	ihv[0] += a; ihv[1] += b; ihv[2] += c; ihv[3] += d; ihv[4] += e;
-}
-
-
-
-void sha1_compression_states(uint32_t ihv[5], const uint32_t W[80], uint32_t states[80][5])
+static void sha1_compression_states(uint32_t ihv[5], const uint32_t W[80], uint32_t states[80][5])
 {
 	uint32_t a = ihv[0], b = ihv[1], c = ihv[2], d = ihv[3], e = ihv[4];
 
@@ -664,7 +475,7 @@ void sha1_compression_states(uint32_t ihv[5], const uint32_t W[80], uint32_t sta
 
 
 #define SHA1_RECOMPRESS(t) \
-void sha1recompress_fast_ ## t (uint32_t ihvin[5], uint32_t ihvout[5], const uint32_t me2[80], const uint32_t state[5]) \
+static void sha1recompress_fast_ ## t (uint32_t ihvin[5], uint32_t ihvout[5], const uint32_t me2[80], const uint32_t state[5]) \
 { \
 	uint32_t a = state[0], b = state[1], c = state[2], d = state[3], e = state[4]; \
 	if (t > 79) HASHCLASH_SHA1COMPRESS_ROUND4_STEP_BW(b, c, d, e, a, me2, 79); \
@@ -832,111 +643,20 @@ void sha1recompress_fast_ ## t (uint32_t ihvin[5], uint32_t ihvout[5], const uin
 	ihvout[0] = ihvin[0] + a; ihvout[1] = ihvin[1] + b; ihvout[2] = ihvin[2] + c; ihvout[3] = ihvin[3] + d; ihvout[4] = ihvin[4] + e; \
 } 
 
-SHA1_RECOMPRESS(0)
-SHA1_RECOMPRESS(1)
-SHA1_RECOMPRESS(2)
-SHA1_RECOMPRESS(3)
-SHA1_RECOMPRESS(4)
-SHA1_RECOMPRESS(5)
-SHA1_RECOMPRESS(6)
-SHA1_RECOMPRESS(7)
-SHA1_RECOMPRESS(8)
-SHA1_RECOMPRESS(9)
-
-SHA1_RECOMPRESS(10)
-SHA1_RECOMPRESS(11)
-SHA1_RECOMPRESS(12)
-SHA1_RECOMPRESS(13)
-SHA1_RECOMPRESS(14)
-SHA1_RECOMPRESS(15)
-SHA1_RECOMPRESS(16)
-SHA1_RECOMPRESS(17)
-SHA1_RECOMPRESS(18)
-SHA1_RECOMPRESS(19)
-
-SHA1_RECOMPRESS(20)
-SHA1_RECOMPRESS(21)
-SHA1_RECOMPRESS(22)
-SHA1_RECOMPRESS(23)
-SHA1_RECOMPRESS(24)
-SHA1_RECOMPRESS(25)
-SHA1_RECOMPRESS(26)
-SHA1_RECOMPRESS(27)
-SHA1_RECOMPRESS(28)
-SHA1_RECOMPRESS(29)
-
-SHA1_RECOMPRESS(30)
-SHA1_RECOMPRESS(31)
-SHA1_RECOMPRESS(32)
-SHA1_RECOMPRESS(33)
-SHA1_RECOMPRESS(34)
-SHA1_RECOMPRESS(35)
-SHA1_RECOMPRESS(36)
-SHA1_RECOMPRESS(37)
-SHA1_RECOMPRESS(38)
-SHA1_RECOMPRESS(39)
-
-SHA1_RECOMPRESS(40)
-SHA1_RECOMPRESS(41)
-SHA1_RECOMPRESS(42)
-SHA1_RECOMPRESS(43)
-SHA1_RECOMPRESS(44)
-SHA1_RECOMPRESS(45)
-SHA1_RECOMPRESS(46)
-SHA1_RECOMPRESS(47)
-SHA1_RECOMPRESS(48)
-SHA1_RECOMPRESS(49)
-
-SHA1_RECOMPRESS(50)
-SHA1_RECOMPRESS(51)
-SHA1_RECOMPRESS(52)
-SHA1_RECOMPRESS(53)
-SHA1_RECOMPRESS(54)
-SHA1_RECOMPRESS(55)
-SHA1_RECOMPRESS(56)
-SHA1_RECOMPRESS(57)
 SHA1_RECOMPRESS(58)
-SHA1_RECOMPRESS(59)
-
-SHA1_RECOMPRESS(60)
-SHA1_RECOMPRESS(61)
-SHA1_RECOMPRESS(62)
-SHA1_RECOMPRESS(63)
-SHA1_RECOMPRESS(64)
 SHA1_RECOMPRESS(65)
-SHA1_RECOMPRESS(66)
-SHA1_RECOMPRESS(67)
-SHA1_RECOMPRESS(68)
-SHA1_RECOMPRESS(69)
-
-SHA1_RECOMPRESS(70)
-SHA1_RECOMPRESS(71)
-SHA1_RECOMPRESS(72)
-SHA1_RECOMPRESS(73)
-SHA1_RECOMPRESS(74)
-SHA1_RECOMPRESS(75)
-SHA1_RECOMPRESS(76)
-SHA1_RECOMPRESS(77)
-SHA1_RECOMPRESS(78)
-SHA1_RECOMPRESS(79)
-
-sha1_recompression_type sha1_recompression_step[80] =
+
+static sha1_recompression_type sha1_recompression_step[80] =
 {
-	sha1recompress_fast_0, sha1recompress_fast_1, sha1recompress_fast_2, sha1recompress_fast_3, sha1recompress_fast_4, sha1recompress_fast_5, sha1recompress_fast_6, sha1recompress_fast_7, sha1recompress_fast_8, sha1recompress_fast_9,
-	sha1recompress_fast_10, sha1recompress_fast_11, sha1recompress_fast_12, sha1recompress_fast_13, sha1recompress_fast_14, sha1recompress_fast_15, sha1recompress_fast_16, sha1recompress_fast_17, sha1recompress_fast_18, sha1recompress_fast_19,
-	sha1recompress_fast_20, sha1recompress_fast_21, sha1recompress_fast_22, sha1recompress_fast_23, sha1recompress_fast_24, sha1recompress_fast_25, sha1recompress_fast_26, sha1recompress_fast_27, sha1recompress_fast_28, sha1recompress_fast_29,
-	sha1recompress_fast_30, sha1recompress_fast_31, sha1recompress_fast_32, sha1recompress_fast_33, sha1recompress_fast_34, sha1recompress_fast_35, sha1recompress_fast_36, sha1recompress_fast_37, sha1recompress_fast_38, sha1recompress_fast_39,
-	sha1recompress_fast_40, sha1recompress_fast_41, sha1recompress_fast_42, sha1recompress_fast_43, sha1recompress_fast_44, sha1recompress_fast_45, sha1recompress_fast_46, sha1recompress_fast_47, sha1recompress_fast_48, sha1recompress_fast_49,
-	sha1recompress_fast_50, sha1recompress_fast_51, sha1recompress_fast_52, sha1recompress_fast_53, sha1recompress_fast_54, sha1recompress_fast_55, sha1recompress_fast_56, sha1recompress_fast_57, sha1recompress_fast_58, sha1recompress_fast_59,
-	sha1recompress_fast_60, sha1recompress_fast_61, sha1recompress_fast_62, sha1recompress_fast_63, sha1recompress_fast_64, sha1recompress_fast_65, sha1recompress_fast_66, sha1recompress_fast_67, sha1recompress_fast_68, sha1recompress_fast_69,
-	sha1recompress_fast_70, sha1recompress_fast_71, sha1recompress_fast_72, sha1recompress_fast_73, sha1recompress_fast_74, sha1recompress_fast_75, sha1recompress_fast_76, sha1recompress_fast_77, sha1recompress_fast_78, sha1recompress_fast_79,
+	[58] = sha1recompress_fast_58,
+	[65] = sha1recompress_fast_65,
 };
 
 
 
 
 
-void sha1_process(SHA1_CTX* ctx, const uint32_t block[16]) 
+static void sha1_process(SHA1_CTX* ctx, const uint32_t block[16])
 {
 	unsigned i, j;
 	uint32_t ubc_dv_mask[DVMASKSIZE];
@@ -973,12 +693,6 @@ void sha1_process(SHA1_CTX* ctx, const uint32_t block[16])
 					if (ctx->callback != NULL)
 						ctx->callback(ctx->total - 64, ctx->ihv1, ctx->ihv2, ctx->m1, ctx->m2);
 
-					if (ctx->safe_hash) 
-					{
-						sha1_compression_W(ctx->ihv, ctx->m1);
-						sha1_compression_W(ctx->ihv, ctx->m1);
-					}
-
 					break;
 				}
 			}
@@ -990,7 +704,7 @@ void sha1_process(SHA1_CTX* ctx, const uint32_t block[16])
 
 
 
-void swap_bytes(uint32_t val[16]) 
+static void swap_bytes(uint32_t val[16])
 {
 	unsigned i;
 	for (i = 0; i < 16; ++i) 
@@ -1011,7 +725,6 @@ void SHA1DCInit(SHA1_CTX* ctx)
 	ctx->ihv[3] = 0x10325476;
 	ctx->ihv[4] = 0xC3D2E1F0;
 	ctx->found_collision = 0;
-	ctx->safe_hash = 1;
 	ctx->ubc_check = 1;
 	ctx->detect_coll = 1;
 	ctx->reduced_round_coll = 0;
@@ -1019,39 +732,6 @@ void SHA1DCInit(SHA1_CTX* ctx)
 	ctx->callback = NULL;
 }
 
-void SHA1DCSetSafeHash(SHA1_CTX* ctx, int safehash)
-{
-	if (safehash)
-		ctx->safe_hash = 1;
-	else
-		ctx->safe_hash = 0;
-}
-
-
-void SHA1DCSetUseUBC(SHA1_CTX* ctx, int ubc_check)
-{
-	if (ubc_check)
-		ctx->ubc_check = 1;
-	else
-		ctx->ubc_check = 0;
-}
-
-void SHA1DCSetUseDetectColl(SHA1_CTX* ctx, int detect_coll)
-{
-	if (detect_coll)
-		ctx->detect_coll = 1;
-	else
-		ctx->detect_coll = 0;
-}
-
-void SHA1DCSetDetectReducedRoundCollision(SHA1_CTX* ctx, int reduced_round_coll)
-{
-	if (reduced_round_coll)
-		ctx->reduced_round_coll = 1;
-	else
-		ctx->reduced_round_coll = 0;
-}
-
 void SHA1DCSetCallback(SHA1_CTX* ctx, collision_block_callback callback)
 {
 	ctx->callback = callback;
diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
index 1bb0ace99..f126bf63b 100644
--- a/sha1dc/sha1.h
+++ b/sha1dc/sha1.h
@@ -5,29 +5,6 @@
 * https://opensource.org/licenses/MIT
 ***/
 
-// uses SHA-1 message expansion to expand the first 16 words of W[] to 80 words
-void sha1_message_expansion(uint32_t W[80]);
-
-// sha-1 compression function; first version takes a message block pre-parsed as 16 32-bit integers, second version takes an already expanded message)
-void sha1_compression(uint32_t ihv[5], const uint32_t m[16]);
-void sha1_compression_W(uint32_t ihv[5], const uint32_t W[80]);
-
-// same as sha1_compression_W, but additionally store intermediate states
-// only stores states ii (the state between step ii-1 and step ii) when DOSTORESTATEii is defined in ubc_check.h
-void sha1_compression_states(uint32_t ihv[5], const uint32_t W[80], uint32_t states[80][5]);
-
-// function type for sha1_recompression_step_T (uint32_t ihvin[5], uint32_t ihvout[5], const uint32_t me2[80], const uint32_t state[5])
-// where 0 <= T < 80
-//       me2 is an expanded message (the expansion of an original message block XOR'ed with a disturbance vector's message block difference)
-//       state is the internal state (a,b,c,d,e) before step T of the SHA-1 compression function while processing the original message block
-// the function will return:
-//       ihvin: the reconstructed input chaining value
-//       ihvout: the reconstructed output chaining value
-typedef void(*sha1_recompression_type)(uint32_t*, uint32_t*, const uint32_t*, const uint32_t*);
-
-// table of sha1_recompression_step_0, ... , sha1_recompression_step_79
-extern sha1_recompression_type sha1_recompression_step[80];
-
 // a callback function type that can be set to be called when a collision block has been found:
 // void collision_block_callback(uint64_t byteoffset, const uint32_t ihvin1[5], const uint32_t ihvin2[5], const uint32_t m1[80], const uint32_t m2[80])
 typedef void(*collision_block_callback)(uint64_t, const uint32_t*, const uint32_t*, const uint32_t*, const uint32_t*);
@@ -39,7 +16,6 @@ typedef struct {
 	unsigned char buffer[64];
 	int bigendian;
 	int found_collision;
-	int safe_hash;
 	int detect_coll;
 	int ubc_check;
 	int reduced_round_coll;
-- 
2.12.0.4.g94589516d

