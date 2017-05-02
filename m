Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258AC1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbdEBQCb (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:65122 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbdEBQCa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:30 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLNeQ-1d68U90sLK-000gTR; Tue, 02
 May 2017 18:02:23 +0200
Date:   Tue, 2 May 2017 18:02:22 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 16/25] mktree: plug memory leaks reported by Coverity
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <7b4d9dbb201ee3311e5e686d69ff158cc829f0c2.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WXgOCyGsHWaDaNdiHbCCKRvpFEjTTYUOpOoy8273JfBFCNrrc84
 mXKHIeT/1VwOPNA2iaMNv9iZ7Y+fMJCDiLls73DVzw/M6Dx4ftUlhNxjRnbyO5PeqoVaF0I
 G/OblwTxjWnC/dxSXsl6XYKepAo6HEF5orgsoE7zfWDHNvsnSXYJLj9ombnZaSsAzgWUqMr
 R/tME3EUAIgOP+ZXaV1RQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xgCvy8hCeuQ=:3uSJctvEnpbLrx2c9lN3/y
 oFRvPt9pX90UONjGu1GBAXiGLot7zO16Cb3mMPNauWwC0J8tsw9WKo7E1EalQPZ6fvXwbVT/o
 XtyMd8kKF5TQ3x0EqG+jI1Ajw+z8ufCdMOltIyZYQJnthhJZsyovQKWwWaVl6CafedFNLF4k6
 8CnloQS9fhT5v1K6alcswaUJUigz4ovXi5MfgIAfGEfCyyQJSsA9l3w+2YpyRUc5z8pk2PEy+
 ET5a2cYhn8mfDoDDCWdlSeVjDMrIP27URhojfXhC69DZU8ZbLmAfAorjLJs/UdZVUyE7Inenu
 U32XDixlPffJJXjAwYzSXz9Bm/ohIxk6k+S3gDAZn81E9sX5aiPIwS9tduwtM8Psn8IE1YWuT
 Nni0UdrJPYUWzV1z9zAJ/G7aWDiScM7zFs4KNNUfm5yuCW5GcUNRsBcEVAdalEvaAfrPSk9HU
 hRpCbKbpzzBcG0ZReqE3LmvCtlZ7Bi44Q5ZafqdiSvvAQcOJa3aL2EqJ+E1FG6Cs6XBP5D3WL
 Ca2VIb+W/6hXD18/0EJ4mPlPf5dw7d4FFV8gIuTNE35Pmz71fTr0r0tLG03hPj8wpY30I0Cpx
 IK5L9FqJZXKnI6PvcnlRNtmIs/Mw3TTHb4igvRfq4LNO39qBvLrJbzMNPFWHU+S+nPHA6L4+O
 ZY5iGdfFRELdsUXif+YQ8YoUexMw4ChlfiP87o7pVpo0n8GbMtwtoMPlhcZ0llEVLtiLjcx3C
 wGISIsM+SQib1oqZEuD3AYMdGKIoauiQzbQyXJ2oFeSLwseA6NriT9VF2SPoO+qItFXLaMtnr
 3zzGhzo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/mktree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index de9b40fc63b..da0fd8cd706 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -72,7 +72,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	unsigned mode;
 	enum object_type mode_type; /* object type derived from mode */
 	enum object_type obj_type; /* object type derived from sha */
-	char *path;
+	char *path, *to_free = NULL;
 	unsigned char sha1[20];
 
 	ptr = buf;
@@ -102,7 +102,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 		struct strbuf p_uq = STRBUF_INIT;
 		if (unquote_c_style(&p_uq, path, NULL))
 			die("invalid quoting");
-		path = strbuf_detach(&p_uq, NULL);
+		path = to_free = strbuf_detach(&p_uq, NULL);
 	}
 
 	/*
@@ -136,6 +136,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	}
 
 	append_to_tree(mode, sha1, path);
+	free(to_free);
 }
 
 int cmd_mktree(int ac, const char **av, const char *prefix)
-- 
2.12.2.windows.2.800.gede8f145e06


