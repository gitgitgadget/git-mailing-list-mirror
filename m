Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AE8F2018E
	for <e@80x24.org>; Sat, 13 Aug 2016 15:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbcHMPjI (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 11:39:08 -0400
Received: from mout.web.de ([217.72.192.78]:50375 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbcHMPjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 11:39:07 -0400
Received: from [192.168.178.36] ([79.213.114.86]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MfqEy-1btXgU2kRY-00NBSp; Sat, 13 Aug 2016 17:38:58
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] receive-pack: use FLEX_ALLOC_MEM in queue_command()
Message-ID: <57AF3F10.3050508@web.de>
Date:	Sat, 13 Aug 2016 17:38:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:W/k/CKY25CVTje+faWkIvVrXC2dyubVoD8bA6qAYWLQBFVJ5+L7
 irF66wGUZzNOzdYQn9M/VHPHjeKOx3s70Qk8KxfoWyshWuh1TOxlGqjewL1khrGTlqFZT9u
 cPt/Z4nWA1Aml85SB+ANKt+drI0NCzk00FBA3aejpxiSgQqWfIRqNUAfRhl6omhyyZrfKRU
 OdiWpIyYDMbAGanM/ZULQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YJIV9OvASI0=:MAaCX3tx9oz3d48Apqx8Wx
 7+dDEeyEbGpxrBzbrOSms7kYWETHZJh2GRoUqYZWvM4wTHpkxXjLHwgr+V9MFJsAYLyyZiHlu
 yTV9ja4bF4eTBR6Jzp6Hu6wc/CD50bHXPicX5SdznkMuCV7mV3n1fkacF9mU4I0b/tPeBMrEx
 6zT62aPelG80OQl6UPmRvSvE3ot3wHusmCv/u0WxrvFlrvSkiDHmpnI9bHZjt9MlzU+93YMYC
 pujZhCNzEKjQ42UnvOo98udnj6/OZiYgtzeAuxcuqeJKZByk0KE07E+qyxw2lVS/b47bQ80Y9
 +n5zlGN07ODuGy4BHBRgwJUqvAjvFWbCJAGzr3HDmpWAvuhKvYMHZRMvvrE5OuG5BSVSUEOlS
 YzHRPrAitgutJAOyhouUrPwzs9zER3iNdqQshwmimCV2gIxEh44Khy8T+JECne3FpGLrUF2d6
 A+STctM4lcQ2CUEynNqrzCRDyvceco1AKaz6g/J+RnmNZ6Dj0TgWZpX4K+vw0QxMH3E18orJd
 0IxiLWc/j3FxQJmP/CTYeK3HvfNMHJvEq/V63dGmNfhxNR8iuvS76rMd/++p+Yw27jGnrNc00
 P8ZpsG4lVSJ+l8LuLwt4bGAlTxeaPcjs43ypjnYX9jIf5NyK4fWmnVkE3je2Rh9X/KrVtsReo
 Y1cGBEXIBl9koPww0NeamUV4LSF10qSnhfvKt1gnAcFKzlM754OJPj+AOSRQECBX2t3DkL8Pr
 pvKwZSN05fPfUEu67gtcKZkdIeUIyHVjj7YjrlJZfwUL+D5bo3apBB+/bEsQZNHWQtXGc+ubD
 cQpYP3I
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Use the macro FLEX_ALLOC_MEM instead of open-coding it.  This shortens
and simplifies the code a bit.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/receive-pack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 92e1213..011db00 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1478,11 +1478,9 @@ static struct command **queue_command(struct command **tail,
 
 	refname = line + 82;
 	reflen = linelen - 82;
-	cmd = xcalloc(1, st_add3(sizeof(struct command), reflen, 1));
+	FLEX_ALLOC_MEM(cmd, ref_name, refname, reflen);
 	hashcpy(cmd->old_sha1, old_sha1);
 	hashcpy(cmd->new_sha1, new_sha1);
-	memcpy(cmd->ref_name, refname, reflen);
-	cmd->ref_name[reflen] = '\0';
 	*tail = cmd;
 	return &cmd->next;
 }
-- 
2.9.3

