Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D431F454
	for <e@80x24.org>; Thu, 25 Oct 2018 16:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeJZAqk (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:46:40 -0400
Received: from mout.web.de ([212.227.15.4]:40753 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbeJZAqj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:46:39 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmLac-1fgvP8116I-00a0QY; Thu, 25
 Oct 2018 18:13:12 +0200
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmLac-1fgvP8116I-00a0QY; Thu, 25
 Oct 2018 18:13:12 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 2/2] curl_off_t xcurl_off_t is not portable
Date:   Thu, 25 Oct 2018 18:13:10 +0200
Message-Id: <20181025161310.29249-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LmMeZk0wDR+9TEDwoWJBxVDYdMeI+tWQ9ST+Ysrh7uDgJfdqKjv
 znKh4hl6O1qAnJbAR35yiV3h4Yibqwyv+JTHLEObHETTWJQNWT5MrrgtEhOg5KajxQ8UhwJ
 +9KIfn4LoPaxvqErRDXC/MqDXIk+BrhG7T1an7NIvlviiirzx4qnWFxpmravrpKTuDo5pPj
 JngbnN8h8ELbC9lDFQ0lw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hMT/V811d9w=:98xy96wkGjNBEIE2nCPB/l
 StVHG7xgizZCNDOpAfIORfrUrNkYqC6Pzb8g4YDJrVHkHz/qKuDfAqlZcAqv8meUmx2VVce66
 Pr1IKAGnIY8cTNzCHsie11cLfJ4coPnld5QoRw+GnlTXk6wnRbBAQQpW06wVgfJESR+w158+u
 kXcaVGMlJnpbRtH/oml+YaTzyqvXjWOoaOjUdvIqsWhWJc6WzWatFhczBttN206OjY29SbtX6
 QudrDM7uHUlNmbj73/o0rSrFNUlC5kyDZPsRTOdFBE9U7hP3n5mMzFBSxu1bqTujqeRbwWzgH
 5bhqoZ9TFeCWewP75VeR8l9rwN/PLdgChRPuhwHSmGbX7gm/yehXBBg51ISeOy7V/eWww09wN
 8UN9LfNM2tvadyCc1TRFmdLLmfsdf6/CmKvLsMmlSplGgpCNKwmDB/9C2PbqzAR/7963rrL15
 rHHrpFnLzc8UZn3xFVCKWF1CKFXCUYph5UOt6oPJI1N2J4UNPsK/ZzfWcSsfcBk/uVw75Gjtb
 nwiU93PZOGUpjmcF8T/BhtIexIP+9ehdUYO5aFJ/z7bqFoxI9PXPWSmCgEASWNrGJLihjPN4q
 NXwXKOV5YILpa/Sk4aoBxQ26HXLJhoOaWoGxKKu7S5SQ9K9sPV5g6i/0fe0frGnXbw9RkKWeW
 NQLwd+fPab/I9bEhIDDf2p3jxpJRmF/2zWAemgBIg3J/8Incag4TwipNwVEdmRHfLPUWwFqqT
 UlWMX9ca3ObQahii2QA0GHmvYtW/Q7VHR2ZoEdpzoD1gxcN+sxrFEeFUUNNj9lQtArU4FT5bL
 2ILhCpPsQE9o9+SvmuUMaURuseYRtn3ZlxCO/0JI2lPK9Ti1Y4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Comparing signed and unsigned values is not always portable.
When  setting
DEVELOPER = 1
DEVOPTS = extra-all

"gcc (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516" errors out with
"comparison is always false due to limited range of data type"
"[-Werror=type-limits]"

Solution:
Use a valid cast & compare, similar to xsize_t()

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 remote-curl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 762a55a75f..c89fd6d1c3 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -618,9 +618,10 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 }
 
 static curl_off_t xcurl_off_t(ssize_t len) {
-	if (len > maximum_signed_value_of_type(curl_off_t))
+	curl_off_t size = (curl_off_t) len;
+	if (len != (ssize_t) size)
 		die("cannot handle pushes this big");
-	return (curl_off_t) len;
+	return size;
 }
 
 static int post_rpc(struct rpc_state *rpc)
-- 
2.11.0

