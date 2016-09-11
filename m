Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2DFC207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755936AbcIKKzv (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:55:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:60372 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755778AbcIKKzu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:55:50 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MTO3f-1bZSJp1YON-00SNR7; Sun, 11 Sep 2016 12:55:46
 +0200
Date:   Sun, 11 Sep 2016 12:55:45 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 20/25] sequencer: left-trim lines read from the script
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <09e05e7ac23164625f2076ff06d2b034101878da.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:y2SLysaeAYafWscRJFwqzVlm8n9M7SJaxj7x5c46TeiFSJMGB+b
 xyRuodAAfdXJQqHJAd38ku23WBDtk4HtRFYT68IaNZX+MxfDiUgAHoCYalWrGgT4wwgmRVY
 BH5/mP0erPwTgAMff1k/4C3PhxczL3Va54TshD7ffVYT4wFZQ6s4MvYd/+9TbNs0Lt86gnf
 TRDWBiYFsuQ0gadzdPvLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2D42oUVdXkc=:ptBxGcK2s2V1GdkOHfP3qS
 OBw5GPO+Ch9QbkqBfN2GQJtO8Igk68Ku2p1RjGTHEsDY4WFea5EtnexRYKJ3kpOP1K5/rBMO5
 MZT7taXnr6SO0sXpVbqH0jKWoP8qr/93xW4hFSuxL91I0AXCIHGMWneofNiWq8pwMmWO4kF45
 bbpuGLPYvZjJBNVSovb5uFlzL/hmZZPB2iE2EUvBN7F+c9XQaPcSOB+s4hB10/3FUXDAcQvfb
 ZaG8PH22AicZU5xxDAHOgJfixgrXbOXSbsbhYyBtCoTlXt8IFkG9hS1x4fIbEdDN60xt4mzFG
 G27SmRSPe7cQ4bYa4qAbeK8028uS6cOhUeCG1uEDyIIUR7QDZvsYV+ibU3BBfBJV2dqEidcbd
 ybAUIuHLLUI9IjsVaFryM5G8eWWelLIicL9JipbyYNslKfPuMmsQm7EVJHIYqvQyDdgMDDGY0
 uU2UkTntgLyhPVdPFukd9R2pnwGBv93rX0Z39118+raqN04ynmzUF2yns+HUpjMucY5fo0ztK
 9Cc0UEWIvseegbbzkgQsJR9p86i5+cMP4tnzUB/DhuCxQ+Z72fjxZZIEhLqJ7bkr4gCnYzWdP
 twAzZRplc7TvoB/SOGwgeH8vb+5KfE52tyOuysH/YBbu3l6tB6dtklplX1bidEzxZJ3wkzPfd
 mqoUwzPIOnOZdx9frBsmEVWKwGEpW57vYdonWwNy9k+ftsl72eC/w73+WaYXHP/W+vye8q+Wu
 I1+BZ1CPHlfJbo8J8PufDsKGol8NRBNya1GrH3v4PDD9y8CMm96/H9Dpp7v7oigEYWBvgk707
 WSS0fMo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interactive rebase's scripts may be indented; we need to handle this
case, too, now that we prepare the sequencer to process interactive
rebases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 7953a05..5e5d113 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -875,6 +875,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	char *end_of_object_name;
 	int i, saved, status, padding;
 
+	/* left-trim */
+	bol += strspn(bol, " \t");
+
 	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
 		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
 			item->command = i;
-- 
2.10.0.windows.1.10.g803177d


