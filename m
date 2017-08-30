Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21E4208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752347AbdH3Ruy (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:54 -0400
Received: from mout.web.de ([212.227.17.12]:56326 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751727AbdH3RuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:07 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LecNe-1d9s2K0jrq-00qOWV for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:06 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 04/34] check-ref-format: release strbuf after use in check_ref_format_branch()
Date:   Wed, 30 Aug 2017 19:49:35 +0200
Message-Id: <20170830175005.20756-5-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:Rf2kGX8D2Z0+efEpR+l6p34oGxucEAm9j7b5+cSw8TjMtSnU3zC
 MOHF+Bn1bTF+oKMmaftknG/v2nqspqYvd1G8VCvg1dHEF7xcjvA2uPEdqsuo+mEhXAxa0GR
 LkYZBR+4LoNLYRxq850FEaXhWsAJwtZY1oYRiMdE3wuKvTsOxkKrMMeaOXQO3eBl3JqxhNX
 TkM5XHuat2nnFmgax4cwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OPv+9AwXa1o=:76R+0C04/+TpsEXbaX1IDf
 c9VECLwGhOkBZmzlo0uv6V4J5Jl6AXPAbuAf9o9knTJMqX+BsUoSWxhIhcLQgYL9xLQDxK843
 AJx1wCTRX0WTHyMnMNfDxewhpAGPcdzxnlH8mA7rOs6xBoFxdkHafo/rdkUPpU2ujV5VZIAxp
 Kzojcr61xx7Z3vUc5a/L/wpyGYSVFS07kjavxJw/QQcis4xhuIGaDOJ5StTyaaxv+/PdUK/of
 s+mVYXbEiV9wD6RZZq2WdYOSO5z7PNImGvfFtB8GxJ6mbLaZOXv75jZV0QUhgZ76vfx/65B3F
 S213c5iqXeLO9naTRdj5UO4m7Tq6mJIm1PVTiiks0m3GBSZk4kIxnQpB5OucuVVKVcVfEP6Ot
 1cQzW8zrZPTRT0OdqS+8BX/KoJoceFB+l4e61uTzNT0g0SMaMa7ne0MujMFZxzU0ydCxkt9al
 93ySXRS62/qlaU4rlZV+hj8by4ImkJDuK6+KBPzPjxRBQsJS8eNnPGXpyyRji+tbTH2uI+vxp
 WzFrX4BqzFsFcwJQ1Z3Lm6Bf9E4IBvdchUN2gBBZTBD56h0tZlP+gDuzy7qd3SLCzEtOQry6B
 4OjX/YRwYz9K1ivdbF6C4P76E6AE6PW25KolRbqOuJF8TO2+wzTj6zAk4xrMWAWwBT3pkeVgI
 FalLyUdz64NeuhclYMCWh5vfB/rUA0dANH8O0rapHl9WMbrzUlN9eSwe3uxyGJGDCoFordrEt
 pg6jbMMhL8PI/5VaGjgLVruJ4L9Rh9r0XQo6BzsPog1LsPQtPDRsP9S8WN1d2jJStF5s0tCGP
 BCZOD6Eu5CEx73govRlg8xrrvl4Jw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/check-ref-format.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index eac499450f..6c40ff110b 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -39,12 +39,13 @@ static char *collapse_slashes(const char *refname)
 static int check_ref_format_branch(const char *arg)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int nongit;
 
 	setup_git_directory_gently(&nongit);
 	if (strbuf_check_branch_ref(&sb, arg))
 		die("'%s' is not a valid branch name", arg);
 	printf("%s\n", sb.buf + 11);
+	strbuf_release(&sb);
 	return 0;
 }
 
-- 
2.14.1

