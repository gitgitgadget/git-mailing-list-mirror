Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D015B202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 14:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbdJCOgr (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 10:36:47 -0400
Received: from mout.web.de ([217.72.192.78]:49924 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbdJCOgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 10:36:46 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNjo-1dURGU1dbc-00md3s; Tue, 03
 Oct 2017 16:36:42 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] test-stringlist: avoid buffer underrun when sorting nothing
Message-ID: <16d3a84c-b695-a55d-0263-885d0d34ae95@web.de>
Date:   Tue, 3 Oct 2017 16:36:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:aYyUAPrZaI7uIR48MIZzXrsTQ9cIXYvgOWdqiIl9FzB7XHYY1bc
 amAV8xRiPhRF9ahXLl+LZxu5hLkaPTCAJ58k+Nrg//KAcPUwlr2RiLbW+wnIUkbGPjVDnlv
 8numvq2Rflc9KrKCP3PqdFnOm/Rfyx4pUQk+guIt3JCAxRwNfZG+ZAM+3OmR5/lUP2O2fKy
 8r7osUsChugFxXlmpi1Kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aFy8uoEuuEI=:VecguoYb05Gsh2O2ERzf0E
 PwboaoOQ6GxwJjEeKfRuyQLhHPs4V1CucqUL8FebIgOqINgwjAU1BadOpbpIaEcFAsJ9r1m5+
 rGS6UCa+9zpqSZnwwAVvw+MMKbQsLuCvcrQm3SmRRaI+ex55hwkE86CnKyiiHIwTwsz6h3Q8C
 kA8nbHc0w5BqKpZbMsfAnx0oWom632syz4uBWIN9fUD4k39naNLTNXIfkb4tarMxTnYuNS1mF
 tXS5Bp4duMP76/UMaeLYbKMJtdPDIz98B2U2OAj0DvEdhRR09PhcmZv3wkDoHk/x/TbwL8WQ2
 +BaH2DqMCpfunZVGqVQ6eMZfcReaGG23zkD0sAPiV7eopB2rYD3GWAZ1F+oYiGLMl62xck/i9
 QrmyJwFyhwkthkRlSNyNvY4woaDdq+WnMD1AZladSqfAeVWG9mXo8ftGXRM47Gk0vBJEycFdh
 uF9hmvxDQNkb/TRCJ8POKefIjUVOwuxCJFSBhqrSWUir4ZTiSY6Cdwz4RO7gPEgSqLZgUifvE
 1twRHuOaUqfpRjitrBdgSZSzjr3Mi5rYlpwQxLtqpz/SUCZFD2cUMvufvBaJGPBL3kvEnCiWm
 7POlJxn7wUv7oij676KT7uUhXqBd5pzcmcYPfgKMzDNJvTjTBh3O/j511Hp+hAhgFb6ou9Oem
 LaKHSZBjHO19Uvy+2BzjRWzVq9B7j0t+cNO1pWjHIbHhXGXmgzqYNQeweesV+TQ3KMP3AcwOB
 68d6PpzmBiRxONIOmgMEMxz+kcPKvMdB4hHOWOSY9NcDfQDyhf6Jmz8192wcw4fXsSa3Gbiev
 +poT9xTWpd2AMBx2B0BQmiW5M4x8iMk33PAkeXpQMQVOgym9fg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Check if the strbuf containing data to sort is empty before attempting
to trim a trailing newline character.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/helper/test-string-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index c502fa16d3..829ec3d7d2 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -108,7 +108,7 @@ int cmd_main(int argc, const char **argv)
 		 * Split by newline, but don't create a string_list item
 		 * for the empty string after the last separator.
 		 */
-		if (sb.buf[sb.len - 1] == '\n')
+		if (sb.len && sb.buf[sb.len - 1] == '\n')
 			strbuf_setlen(&sb, sb.len - 1);
 		string_list_split_in_place(&list, sb.buf, '\n', -1);
 
-- 
2.14.2
