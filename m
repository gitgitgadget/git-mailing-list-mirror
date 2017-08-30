Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03C0820285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbdH3R6e (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:58:34 -0400
Received: from mout.web.de ([217.72.192.78]:50050 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbdH3R61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:58:27 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lw0ht-1dSDq03hxV-017mgv for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:58:25 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 04/34] check-ref-format: release strbuf after use in check_ref_format_branch()
Date:   Wed, 30 Aug 2017 19:58:07 +0200
Message-Id: <20170830175825.20905-3-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175825.20905-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175825.20905-1-l.s.r@web.de>
X-Provags-ID: V03:K0:3jIPJG4KbLBPexmdmBIHIV476cH0jHQ/qBN+pCM15Y+HDbT9Nnj
 dZgefYUA3ZYeINk4J6/bKWd6K1QP3apBBHyJvU1KEjjd67w+DKvx4jSEnW+oh0UV+ghctw9
 Az4lpnPBw5TO4H2AWxZwoZyKtvi1NLq5QbpS/VMhnX14GDQFO/Qj8Dhx+MSyzAo/u9iJXUi
 FgMZlkcgLC0ngYRBIEeMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kvk7IFQeWCM=:NOlcHhTKfyoYU7NnrNT7T+
 0L8/5uOcrxty/LuNx69QIgFmPXZd4BTj/BFO5vC4XR+mmRzlbDoAZUmlx7yKK8SaiYi/j6RDG
 3fpJdXZXY/aIcXS0rqvx72BEfG1YDDNMJ1/rwHQZCx5SPiL8W0OFIrbTn2AzsrjM3y9Yh7wbx
 xapjmenyoxrIdW/JHZpPgy7Pm59PBZPZBdnINoRVE2Cf2kN8X2c9FjjlHL7yA1cA9bV855F2V
 45P/XM7jIwAD0MXyLFFLTvVEtohXtptWVT1YacJ1Lgou20U+1oTxtsob3/Q4UCoGbYreO1un7
 0W/PDCQDH+pgb4QViwGKCUl87dhq256qggtHAoELpya17rB/JVFDGVZ16YGio3Y4B4QQHT4bU
 D3am7nz9Z6SK7QZ7n50ldw3JochyJN/FyqcLx+Fc0dDyks8cOkoUXazyHJifizjcpd8hDWN6p
 llP531ijBY4gO7GLe1Mj1Gunn+eTSo8cwt73q3FsF+TrOmw8iW/25ixAVz59j+xDDRrAE9I0q
 /BYc2m9SMVX72YUjshJGX9wBE0NIjbDVHYqGNNvhPiShfBoSQ2JGLBttt0cv7GpVJoIJsC5Xa
 YNpo2Mf4nRuFSQGrMARK3yqltdhCeqRWUKq/h1TbY7QGW588J1RRud7mudHNZ5xKo3dXefku2
 CbKxjiHj98LmM5Yuphw7K8nvNkbTLguVMhHjrCn/84c79JqLswNWF2uaZQL+5w6Av9OMwJ8sp
 zvbSHHZpresmPr9L5MMcIb3rlMBEydVILzdPfMN9Hn660QgOkKY1Jnjs8Xpfevckg9k05CMkT
 XRUY+DODn56cUhyGP21fVTmM1crvg==
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

