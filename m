Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060681F453
	for <e@80x24.org>; Mon, 29 Oct 2018 16:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJ3Bso (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 21:48:44 -0400
Received: from mout.web.de ([217.72.192.78]:47527 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbeJ3Bso (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 21:48:44 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCIqT-1gPfKH29jd-009C1d; Mon, 29
 Oct 2018 17:59:16 +0100
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCIqT-1gPfKH29jd-009C1d; Mon, 29
 Oct 2018 17:59:16 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] remote-curl.c: xcurl_off_t is not portable (on 32 bit platfoms)
Date:   Mon, 29 Oct 2018 17:59:14 +0100
Message-Id: <20181029165914.2677-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
In-Reply-To: <20181025161310.29249-1-tboegi@web.de>
References: <20181025161310.29249-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tQDBpySfq1DEa1Va+Kj75fko3imEYlAlHp8AoTCpvO7mcd7Z3L2
 ffBxh6yOxu/BO/cXKANK66bdhrec55IGzr7TUXABSoJ2oXesmVKW2xgk7HIrc9pGk+cLhQ+
 ast/YxuKhiH6CDMkS3PHAJoipVri/fOV1yL2rrKKT/rbdn+/hlnGDGAEHaSRupW0FzkQHsm
 dhYxvi6fxEU6wCKVJmuvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1Vjp/LJdw84=:Q4R5QSUhekCDZtR6yZd6Vh
 Rw5pj/6kdu7PBDzehO5xMRK9ZOpZ7XsMHkr2JNsZOOJ36XCzYRHmNqL2EJ5JmeW/tMqeUBmul
 9aNvdvaLn3yw4GE08K9exkmjlowptsxj0eka6bEVCKZQxssHyJHoJURvRB3aWvRV0/+XsXGYM
 jRNz3QOd/Y9WKcy/8JZ/Ua7MfmkQ2sWwtoGvtuCC9wIpn+hID1gdhrS6aDyh+yK+dhKWo+q6G
 hav+8pi+Yf4BMXOiT8iMW68d/dNAuZhYBKVlZYgl68wohOLdHU+gYI3ZntlBMQDOFTa9l54FU
 Gg+/9bfB0GcK8M1zBBpxcJJDTDQoJFI2oWgMic2LrwcE/kIVb8R1obw2mvTOogBZqT44paQD0
 DL7+cbX9zl44mNo88SGNyf7wqa4Jg4jAQQV906DGeRm6g3EMv3MgA8HozRu3r7977aGc9ON3d
 aECFG/4nZdWtBfUCTV7iJdxRhbzyo4KaZaP8D801dPu5J6rSdHl93zkussfc3Truet32CW58z
 JUXjy16aEZ0hPebp/EDFCwQtVwnY+u8Zk2cyDiXWnUF9WR/fxzd9G/mapfEq2gPCbldcErg/K
 L9W0Xlxd8oj/VcK5xlKKtVcYyetn6sO9SNdPAVmHkOchhgWIQ8uWjou46jKtJC/B3zZMwsMah
 97nbMUioO4DgA/xRfmIukyjkrc/j8behlJHm/ODnXNjW8rzuhjDYFstBWiWQu5TBicxVEWitE
 KCcfqHS24Ib3t1eHpUi2G51HhxHj6fW9AoxUvpS7DmppmMMtp9GuCqnH3MqNgN4iYGMNRkh+9
 tBSHtS2a8RAmwqVasTirIXxn/xP7SKyqNxhABp87OClGH0qQzQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When  setting
DEVELOPER = 1
DEVOPTS = extra-all

"gcc (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516" errors out with
"comparison is always false due to limited range of data type"
"[-Werror=type-limits]"

It turns out that the function xcurl_off_t() has 2 flavours:
- It gives a warning 32 bit systems, like Linux
- It takes the signed ssize_t as a paramter, but the only caller is using
  a size_t (which is typically unsigned these days)

The original motivation of this function is to make sure that sizes > 2GiB
are handled correctly. The curl documentation says:
"For any given platform/compiler curl_off_t must be typedef'ed to a 64-bit
 wide signed integral data type"
On a 32 bit system "size_t" can be promoted into a 64 bit signed value
without loss of data, and therefore we may see the
"comparison is always false" warning.
On a 64 bit system it may happen, at least in theory, that size_t is > 2^63,
and then the promotion from an unsigned "size_t" into a signed "curl_off_t"
may be a problem.

One solution to suppress a possible compiler warning could be to remove
the function xcurl_off_t().

However, to be on the very safe side, we keep it and improve it:
- The len parameter is changed from ssize_t to size_t
- A temporally variable "size" is used, promoted int uintmax_t and the comopared
  with "maximum_signed_value_of_type(curl_off_t)".
  Thanks to Junio C Hamano for this hint.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 remote-curl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 762a55a75f..1220dffcdc 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -617,10 +617,11 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	return err;
 }
 
-static curl_off_t xcurl_off_t(ssize_t len) {
-	if (len > maximum_signed_value_of_type(curl_off_t))
+static curl_off_t xcurl_off_t(size_t len) {
+	uintmax_t size = len;
+	if (size > maximum_signed_value_of_type(curl_off_t))
 		die("cannot handle pushes this big");
-	return (curl_off_t) len;
+	return (curl_off_t)size;
 }
 
 static int post_rpc(struct rpc_state *rpc)
-- 
2.19.0.271.gfe8321ec05

