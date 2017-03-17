Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FD620951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbdCQXw6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:52:58 -0400
Received: from mout.web.de ([212.227.17.11]:49352 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbdCQXw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:52:57 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lnj7L-1cHsNh2DQl-00hySs; Sat, 18
 Mar 2017 00:52:50 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] shortlog: don't set after_subject to an empty string
Message-ID: <209e03fd-07ae-8e06-3da6-52093495db43@web.de>
Date:   Sat, 18 Mar 2017 00:52:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:nHnEEsAh/zIvDzRp0OEsL55waMVXux5dlaAAws8fIOsu938uHg6
 GEMyZhAVMEImCY9MW5B2yze0JzbCQnhhSwPGz/NKCwHQE6yzwKlS53z9Yp83yPvARD3D8Mt
 g1gnoG4PxaUSrYh5/RRfjwiBdDAUYp/vJbuqwuDgnenUrr6MyLwoWrUd5baoCFuALe+ya2+
 tpUuJK+JE/ZeHXYSmDZNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QLTnPOkANOY=:f4kImCRX6CsQfv9rArxxoy
 SR0qjGmuOPxUcl3B0XQhL8efuS46CtwRMcIUt8j/BU0FwcwhXQc9K4FeZLeIaSXjebVhFO5VC
 tI95bAutNoZ7Yc5hcJrTEcic514oif0attmdjdKjHrjFexvpPcyRop8EF0KAJ0iL/nHX0lqik
 /f6iTlDSOyWgzM/9/D6BBjfdTeR6FTa1rlRejS6D7bPqnTeMG8T5TwpKc6KOPhSE3T53zvpdh
 ET80RH0X35iwHbRi8tka/OGhbMfiQpDIKm9nVKAAtW6Sws3Q9HVYi8ENAOKVr6u2awO4mA3Xf
 8MdmaN2mRwu2+hNOj8UBMaqpll3DIHKq8B4PW3k8al1x+e3F9Q6ZHONT9pNUSvrKUHViDk3Wm
 yxEkqDuQOaqkXcTHZAh31QrmpQ/KVf08Ad0U95o7RnGp9YHT5Z0lCFmPdjIfHu0eVno/IHjyK
 1LR7aWVq8UbqYe/BuG4k/VZuo7Z//n9QREmz3rl685K4ceggnHJiXpYsMRKqrt7EYnEV8vuPi
 dPEB3uTXnDglzhE0kBIDQDCYdkjyXHwE9dpW4ev7EEAEWCutqtyaZvFh6+WjE+5QTxsQYeQ0v
 T7ly5nTF/IgbPeEdGGBbDMF5HLDKW159BMGlfKl6R6yJEUDsWuwv4LLgaLI032ADmO0lPmApE
 5rUHy2/9XdGJP5slDcJRx/oLG9nRViOkIcWPamkIp3+pzI7oN2SmXwWjdh/2RKMK3ISWUc+bO
 6ZvuCld24yNacTLzKKK3FGEqRbZiVuO+pskb2qPn+ECXTv9iHmflm61qQ1HkUi4JTo6O25qC5
 IZlZfZY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The string after_subject is added to a strbuf by pp_title_line() if
it's not NULL.  Adding an empty string has the same effect as not
adding anything, but the latter is easier, so don't bother changing
the context member from NULL to "".

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/shortlog.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index f78bb4818d..7cff1839fc 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -149,7 +149,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
 	ctx.print_email_subject = 1;
-	ctx.after_subject = "";
 	ctx.date_mode.type = DATE_NORMAL;
 	ctx.output_encoding = get_log_output_encoding();
 
-- 
2.12.0

