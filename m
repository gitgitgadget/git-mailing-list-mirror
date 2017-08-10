Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96CF0208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 16:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbdHJQsG (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 12:48:06 -0400
Received: from mout.web.de ([212.227.15.4]:55516 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753023AbdHJQsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 12:48:04 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQ5zf-1dl5Y53OJn-005MDa; Thu, 10
 Aug 2017 18:47:58 +0200
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] merge: use skip_prefix()
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <7ebe2ff6-bc4b-3694-7978-a1f5f8628b8a@web.de>
Date:   Thu, 10 Aug 2017 18:47:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:1rSBZEyk6FB+zC4iFPlXGa71DVIaB5xkzPLlFUKz9anm7EH7Zut
 IaVcFXLu4HmWOetL/aOm1k8Ddmu02drxXsNoKwaVtzJcvAJU7jwKcTefdDz8mcAckxWQ7Vl
 db3CmXxb7oCEXv/H9o088nuRw+wTAJwJCF9/u0L/x7r1LimNmUfl/aTy6+2NSXX/WZEEfum
 XFDQbzLtZUhCXfnENxjPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OyUC54KhQIk=:c0kb9KFqXylMY4tBAvQgkU
 9kmh5ndLHVfp+mCsqNRXp3kOOR2v6u1+ZVgZq+d8TnBpyMZeA98jPt9W1NrbAojviWUMNglfQ
 RCbJlgEri8EfqgyCSquY1lmrgiqxu9agsOpvdqisMlKHBilcPxuznbSmDovXZN7YneYIq580h
 vobjc3CBgWmeEdgpBmErdMeH3n+5SAhSbowIELxiUPN4DHbLauB6Us839yFTQy7IBjUYzP/cn
 dhPexvbozI981qx4TFsNBFsuH6CyvmZGtBKXPcGEJUokk1zgOiMM0jgD7EBcFYN5Mnn9gtBVs
 4zjCz6Li3pbRT5cgEWfjG9aAZNEfGlTe28NB3lErOtKAa5n5H3sStOwn+1jQNONHvbWMRuiRO
 piHu/Ar1VxXZzg6bwhToYwxvTULPCPaayU1PsSW8cLS9CBskyVSYW7fg/r7TzpYY6tmjFn2rN
 MRek5t/6sjFUVruZ9nhXVEAO/s8qbBQRHPjHLBknx6ILWYySzv6vxXSdM9gnlObzbxtVz+QW2
 zIYceshgb1IM6rzAfSDfZdmIpSSwps4VOpRXfl3MxWqNHY5jWkV28X0gMejuTHf4rfRNP95W2
 rBrNWZQYIERORhccZ7b/oPIG5x6zLIXEqlOTJGo3j6QessLRqkRPehjwMbq7xLMRNUDCtvUPL
 K+hzYg4caz1rPgvWy6Ol8DTogbTLWLK8F8zAvRKD7R/AICG7vG2x6NdS/KN0fPsWB9U5iZHo7
 5SiBXXauwRpYsy+nWajmXvaFHbjlV0qCEl6igKHpd/BjeeLIor7tcuzOn10y/yRj9jMgM32bW
 AhKz9i8l8HLv2GhvHxDXYT/pJb/v8lbZPjGzoi6e5EoB/nMpRw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of a magic string length constant by using skip_prefix() instead
of starts_with().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 900bafdb45..4facb6fdd0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1117,8 +1117,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * current branch.
 	 */
 	branch = branch_to_free = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
-	if (branch && starts_with(branch, "refs/heads/"))
-		branch += 11;
+	if (branch)
+		skip_prefix(branch, "refs/heads/", &branch);
 	if (!branch || is_null_oid(&head_oid))
 		head_commit = NULL;
 	else
-- 
2.14.0
