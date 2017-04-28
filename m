Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB56207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 14:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036027AbdD1ODm (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:03:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:57752 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035154AbdD1ODl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:03:41 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWSwU-1daWXQ3JLm-00Xeh6; Fri, 28
 Apr 2017 16:03:30 +0200
Date:   Fri, 28 Apr 2017 16:03:30 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 16/25] mktree: plug memory leaks reported by Coverity
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <32f1cb4d925ff7a80b9a58983e0bcebf7ccff9cb.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:86RSI4/HgqZPHY9GkNymbT9mOJ2c+7wP1FvMWeBXrkZrmiK9yhm
 2GSfYiAddFlruD/8qkCo3NJXTRdVM1zOu1c6aYsWmOCsmR6gO3jdGLUIROTsB6+BeCJFf2q
 uEjtIv8wJBVvaH3bXNWaClsnCv3NDAMkJVtu1OjCD6JZiJjVsxmPL/dGCBn83Fa6Jy3VUBI
 U/sghkHCiju6y4mjMZrMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xt5klPAkzco=:Z9TKlzvZqoDU7/3oLodgw1
 gnL/GihA3mybPGnbz7TA2zFgmRLsSKZuNVq5AKYbne8X5bnm68yTwtvFR+/ejGJ0xPG9FsZnd
 MEIuw7EQ0aPCpKj4GiSWzJVKv/AczRy3vKNhQrwKQTeWhbq6gyOKdXnr7rzLmTt5e9gtpbm56
 MQx7vFETXhPMh3GeRYc70+zbYy4Ibo54DkRR3ASYoezY4KhzB+X5Xg0ftbv8m452tK0frQLt2
 QTbJcYm5aRjxlqVSiNhNPcZeJUk9amv9mGC8o3aiRIHCsr85s8UBZGAR5Fj2mtuenvnLW0aTl
 GS0pDmmKWxCFy9gpX8FnPphtJhlscZe8qINRpUAmf3NoYmTNqKdxcF1Pdp+UdFZYu8PKhRGZO
 Td6uovCZBRYANd7MmreabT0sCJucb4Qtj0iXFPawZXt+77oJaGTWKpz1Dq4ZYoaDW/RePy3rI
 9BGiG4QHAmApfvL2uZJ7E1rpNAipKXUpXnCzxwE5u6Rm3qge80dgE5QXXw9CHun8LifWFnvgW
 8ewiuXqRZj7wK+xZWD2OAgUMLFcCGLro54vQMDTzvJqmOJ9w4laZmS7RcuHzI1Fo3+8aEP0rg
 gMixukZ1JxUuEq+k6bZUexdxseC8OPtlcIaOr2CuzWXSQkbvEPgPQMGe+ZY3pMbAJBIWjQQ/c
 sOjvApEWs3EcWW0UR5o6gQClY7SV5lowMdalrap7omNFHSNuGQumZ6ZqE1Ax91KUaCClYRlgO
 GIWyWb+sJLSmBZL5+WYu1zU3qTTq6S+HH+z0b/Zz9Kiqx3tyrTDpxFwbLUuX3u21fTJuk/zYI
 h8xxtMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/mktree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index de9b40fc63b..f0354bc9718 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -72,7 +72,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	unsigned mode;
 	enum object_type mode_type; /* object type derived from mode */
 	enum object_type obj_type; /* object type derived from sha */
-	char *path;
+	char *path, *p = NULL;
 	unsigned char sha1[20];
 
 	ptr = buf;
@@ -102,7 +102,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 		struct strbuf p_uq = STRBUF_INIT;
 		if (unquote_c_style(&p_uq, path, NULL))
 			die("invalid quoting");
-		path = strbuf_detach(&p_uq, NULL);
+		path = p = strbuf_detach(&p_uq, NULL);
 	}
 
 	/*
@@ -136,6 +136,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	}
 
 	append_to_tree(mode, sha1, path);
+	free(p);
 }
 
 int cmd_mktree(int ac, const char **av, const char *prefix)
-- 
2.12.2.windows.2.800.gede8f145e06


