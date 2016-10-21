Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ACB420987
	for <e@80x24.org>; Fri, 21 Oct 2016 12:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755456AbcJUMYz (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:24:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:59001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755451AbcJUMYx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:24:53 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LikE1-1cW4DC0jzJ-00d0yY; Fri, 21 Oct 2016 14:24:47
 +0200
Date:   Fri, 21 Oct 2016 14:24:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 09/27] sequencer: strip CR from the todo script
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <090369749f8bc0a45c94198cd20fa0da5d0afddf.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KZThcQkKsYhO+JPrmdtMlUtBsvsxlaXcffxkObJ5TOlQO2S4yHj
 um9ESCnt5B42rH6KmcUam0VquM8dvoBxScMVzU1BfxAasmipUPXD6zo3DGrZ+BDMMW5kqdN
 jMDNkUaaOBfbs4/ruk/ZxvbKnoGCXo+/mEli5xWo7BwYU0BOzMH8Kh02nWOYi1QdMWVmm7p
 0CULznlBb8cGQB9olM4SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pBA3wFwU6nk=:mK20egUQPioZG3M0+/LRvs
 PESSveO2jCrC5EJXAIoJTETBAPGRWO//w/WjsiUtl3dD3WCngH9mhCHeUHGyxv7Ynzg+Rc3BD
 fD3ppRfBrvjYqz5n+jfMoessEQScj1AEBilpGIINHtzx3HnbW01TO1mCGr3XGz1dPmczXiyoK
 zdBkNfytR/nKh+tzDcdwhLdp5+zbcdMF9wv+39Oto0iWINBXnBmcDA0LcQjrKeF6H3AJdaPtA
 eLc8W1AYgj3yw/Lx1NwHYLVdLWwP4J772fjnaJwSnk9k/pC6b4aLCootGHy2hwQtZU7nb1+Aa
 1nRo1n3yYeva8zZ+3b8HQK0Y3CoXh1o/xtSOIQxXfF9owiW4ObLNSwUb+7BCFRhSOWzNcZn84
 xJjfvqCz5WZj6ktakWAJMf8Vxwlu9GyDL/y7Qsx36jt9iUpDk5weZd/tH+NmkYIRp3mxXMjZZ
 5bR8Ywa6IMgcr3IGqBAYp0FnsOIqJrf9w6y1YfCpsoVpVg3W6iHae6Tj7jDrVC60TDK2fIBrY
 VhKhWRbFbf5huUP0ylIZuTRO573XmIPcJY03twAgERB08pCMK23G84ixPNwErMR3Ev2dd7RC9
 d5Cod/pYTK535mX2xsMqk5akVg6iygwi0RwgLDZ3PSX8iNh9AGpmAweHdGn3Av1YxL5ErGhSN
 LrRLP3ZHGYguREpOO9MHPf+EtUZtHU0ePWYSdCOlOr8QyufYmMlkzOKXC5xmuD5BLcUYEUz+x
 ei0YLlKzheAvEDAa8ANNmHG+jyoFMaPU5ElV18UNHaIicH0xdVyR4XzZzvezivkCn9JPBnKrL
 pi2/9lD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not unheard of that editors on Windows write CR/LF even if the
file originally had only LF. This is particularly awkward for exec lines
of a rebase -i todo sheet. Take for example the insn "exec echo": The
shell script parser splits at the LF and leaves the CR attached to
"echo", which leads to the unknown command "echo\r".

Work around that by stripping CR when reading the todo commands, as we
already do for LF.

This happens to fix t9903.14 and .15 in MSYS1 environments (with the
rebase--helper patches based on this patch series): the todo script
constructed in such a setup contains CR/LF thanks to MSYS1 runtime's
cleverness.

Based on a report and a patch by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 145de78..04fcfd8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -776,6 +776,9 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 
 		next_p = *eol ? eol + 1 /* skip LF */ : eol;
 
+		if (p != eol && eol[-1] == '\r')
+			eol--; /* strip Carriage Return */
+
 		item = append_new_todo(todo_list);
 		item->offset_in_buf = p - todo_list->buf.buf;
 		if (parse_insn_line(item, p, eol)) {
-- 
2.10.1.583.g721a9e0


