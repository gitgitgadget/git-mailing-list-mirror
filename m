Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753B41F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756763AbcH2IGs (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:06:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:49582 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756656AbcH2IGp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:06:45 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lw2Sj-1b3TQK3LiP-017lIE; Mon, 29 Aug 2016 10:06:41
 +0200
Date:   Mon, 29 Aug 2016 10:06:41 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 21/22] sequencer: left-trim the lines read from the script
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <8c30113a920e075e5ecd68ba31b4007de3e2dbc2.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MzD/YWAz0m0vgP7qtNG6/f4wZDkJNyZAwf7JB8apCSAbxqwdcUO
 r2kf6NsIDsgZ8c3dY0rvzkMh0S/IrN7Hv6YaM7zblLfUHlIrbWaH4hBLw60Mkfve7F7h/EU
 NzBOcA7M/nfc6PfHIY3zjk0yf386y+itJF8cBBVHqL++isyQYINn9QHJTpF39/awdGNLGfS
 o57+hYaRxK391/f8qa9/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TwoJ7l8XfNg=:w4R4CelRuQQPCvhu/Fqir6
 1S4qf7tWdbbdvaZynBE1IRe5ZjVV5bTmvG5n4fuGurEYZ59eTu89NL3FnB/IjB3rVSjQtgrMx
 lQd++lK5RcEbLXIs2MLRJ+Y8sVP4WUua2ZoL6WMkOfqJ7UX1n8HE8kACW4oTszmNrwvae9/ZC
 NhB68ByJQdj3XV+3UboFQpMTNfpMJmTk0cJpvUj7rh7+mqdWx0Lp9Nm4oNdU9RO3meHmE4klF
 HzXUD2uRAMuhZ9jZ8KWb/A/nTfKcoIqbgIEiwK0Zwirecdo03kT6GJk86evEonJYw+3W5hax7
 CjwG8pFweOXZfOo7vA5ASeYGYIKlBfzxtY1eiQoeT8qZB8bnDu3jwWrj8zBkRx0ie6bviVfNz
 PuV44HgNVcqrNl/BykQFH63dif/Ww5N2tORDdhbQ4eV6geiVWF5mIWX3zDwtj9A/aza3vx0fs
 tZQ88KxO7FIbGvMmnsXb1ddeHzF8SlS2Ys6sWMFNQs3svNg/0hPI6YoPW9O1IGf5U4AdmrofR
 Fz06DzNJVAAzNn6OUNX0BnLLK+x3S2lZqGpDJrkwX4Ha/a5BP8xvEjrdWnWHtT3JjNEAX2sea
 bmDVhblSHrqtgPou7bVuozlneEtGYJy3ngKIFb2LkN8yywudOcBJ2ZDbqLOww/+bjEziFeHFx
 mOr7WA7W5AZl1TAYeVc9iHNDYr4T1YM3x5dZOEpkKLqj5bUN+7Nrb9xtnWafFh2I/e1gA4Mvg
 IxZSQX24CJZP+R/N6zu2FgTqLLtpLEcT/jd51dMtWaZWOUfvt3Sz2vCxt38c/BoaXt8gxb8gQ
 0RehgjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interactive rebase's scripts may be indented; We need to handle this
case, too, now that we prepare the sequencer to process interactive
rebases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 0614b90..5efed2e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -864,6 +864,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	char *end_of_object_name;
 	int i, saved, status, padding;
 
+	/* left-trim */
+	bol += strspn(bol, " \t");
+
 	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
 		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
 			item->command = i;
-- 
2.10.0.rc1.114.g2bd6b38


