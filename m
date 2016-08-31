Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBBBE1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933734AbcHaIzQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:53259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933217AbcHaIzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:09 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lw2dd-1b2jyu3i1d-017nMU; Wed, 31 Aug 2016 10:55:05
 +0200
Date:   Wed, 31 Aug 2016 10:55:05 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/34] sequencer (rebase -i): the todo can be empty when
 continuing
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <1ed867cdbca0351265f2b0fcc8d10366a6b94411.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6ePoRGpLpsH+TmzVf48XOm6YLOzuLN8BjhWtVHHlGJ2Hpyh0At/
 F90SzdfoFhd3MBbmcE+RcRm9k7blUchie2EsWSsH9JA8fu8uli7FkkYogPg7MWTfCDILW5h
 KCgvMPhwmT0D1A9CeAJMCuJ44DHYuv8TGLlRpLMT17oYZJKx8sK9X5ImScWQFAAJgTBDI0M
 BF7alLzNHLReh5ckbPQNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wvH7JbiiUHU=:USW4VlOAAnY3hn2HTbNni6
 yj9ZnDZkbQ6FevCVmLLvl0dFBnLh3Zmm6E9CSiDt/NcMCukViYRven20lW1XWrJp94q5W7uC3
 cWPkrYD3FdSiwWeGB/W3IsfvsBrC21LbJDb/A+xCuQtshYVW23KBQuate1deb1gmXl8W/MlTY
 yuamk7A9Os4jQYNbO0Bx/HOVbYSWsGIYgO/KQie1+nUy/VpIfmRlBBQ7QmDYD9yj8yP3iQJwg
 E8/24SP3oG8a/NxbvB5cCYbLYqMYDd1vaxId/qHDzqG4uWBbaA5y6aXQUdXXeRedR5+E3WIO+
 P3J+dJBd8Qpb0gyghURK8vzmkcG88DKxhEl9lrhbv8lZHiOE2NdTFGjStJeXaRCnHozivcnnb
 Mcj41BbVIgbGcD115PiLQ02CEG1sPdj+WH7tIG68MAKuApVVn/iiprGt3Xl1CAOb6fcB5jOOF
 DAUA8LM+FYIxD/YoPnx6ZAXN4U//nztoFDRlabI4PTJ61KW9zeDAv1foTvTHQ2DseCOm6SEcK
 MWZSB6m5cwanNFu7MQNiONaF7q1Xy77to5tFZxoUwvromQ4K9PdF8fwQJR64SzVp6g2hINry4
 AskhS+D8ScIz8E1pv6FWlHXrxKnb8zzPwfN5YUZN/SUXz1Y8/p9s1+/v8qvZw4ekeHutlJMEg
 g/pNgpK7zjp6olJIY5OOS339RPj2Jg9oEaify8O3n0JUfYWFL2l0ptAbfsBG4+eXElQoumEmX
 FOrfLtMQekQV284P8dWfu4GBPaRfIgofItRQMyqK/TAMbRK57yq2Pb9Y//MqvA5OCRfddF5O0
 vrw7Xib
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the last command of an interactive rebase fails, the user needs to
resolve the problem and then continue the interactive rebase. Naturally,
the todo script is empty by then. So let's not complain about that!

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7f017a8..d4437f5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1249,8 +1249,6 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 			fixup_okay = 1;
 		p = *eol ? eol + 1 : eol;
 	}
-	if (!todo_list->nr)
-		return error(_("No commits parsed."));
 	return res;
 }
 
@@ -1273,6 +1271,9 @@ static int read_populate_todo(struct todo_list *todo_list,
 	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
 	if (res)
 		return error(_("Unusable instruction sheet: %s"), todo_file);
+	if (!todo_list->nr &&
+	    (!is_rebase_i(opts) || !file_exists(rebase_path_done())))
+		return error(_("No commits parsed."));
 	return 0;
 }
 
-- 
2.10.0.rc2.102.g5c102ec


