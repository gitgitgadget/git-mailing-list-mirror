Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B00C4742C
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5ED20838
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L11w2wNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgJ2Vcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgJ2Vcw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:32:52 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F64C0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:52 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l1so2601293qvr.5
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=slkhbjCg3Mgmo4W6YmHzUeRTBQJw9wSMrA+Jj2oqGiY=;
        b=L11w2wNEYCYAkp7dO4YLIZ8dZ6MOzw9yke4WZo+gcXKM3C4bA6ueG2TeqHyYgM1mo+
         CV28R/FDerB0cv5stQzDQBhG2Ztqa4YIN9VXbiQjUr9ZqJpVONSIh58cJ9Ubjs0RJct8
         zc0Oh/t/dg3ICz1EGboVh0CSLnZzqPWUmKWivZPiTQ5CNubfoDVkMWzJ6aD+VQiG2KNt
         r+axOiaF4eaDaWxhl6JHuLWhn21uBpB1Yl3LSECHaBgOnnLagheNWgi43WBDYyfT7wVA
         3mU1OjUL3Z6Djca3465rTd5Rv35gi4CXMkrWStdreLZzLgb+g44aAPulhpqsG/0EfWNK
         TK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=slkhbjCg3Mgmo4W6YmHzUeRTBQJw9wSMrA+Jj2oqGiY=;
        b=uGE69ynOZYBGsrF2GCmVzJOnV8+2MACjN/+wVHl3FwoN8uOS/DWRiQY7DvMbnBzliN
         wrgcsHkFINvHSDySA6y7G4H5gQQ8lLcNTBag3Bxy+lpLJiHxl0/tNAlrcVMQZ2hzHYgl
         nvbX03IhW+A25uTzXKLohmsmAnUe1Jo24DYu+qQsn3vBKsf10wZORLGBCv4vlUkDy2HC
         nYIkRUnfi9DOcmYDWSXXtvxEscLBX32AyefBLqwUY5z1EE53gjQwi5aprI7nv6ybmDUi
         EYezZwrtGfnootabikNZFWsgOEfU75OT7QiCoULlAbe3Bomq90G28FDv4hTHvNRlvz9z
         q33w==
X-Gm-Message-State: AOAM531pExmwFI1vFhcGpX85SIRiLTsYbNf4gBwFShNcrxaFE0VkIQye
        egmGePJV/nD89cDxlsGLCPVqxYgoYrnv7Mb5ClTcFU5TVCQ5WuZlcaTMREWcdBNvrDU5LbHbeYV
        zKZgXF0YPZWlIvy+avDpXrQcTG+6UYItiPe3HZ6euBh0rwe41YII9VsfktVyYuLA=
X-Google-Smtp-Source: ABdhPJw99/IzssIFhzlhMEcJ0tBupwsjJ4NJrZjLGE8JjILoZZlwuzcPm09Yk6fpRYDmgzN65ETGhzfdnnnm/Q==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a0c:ba85:: with SMTP id
 x5mr6465364qvf.7.1604007171263; Thu, 29 Oct 2020 14:32:51 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:32:35 -0700
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <ff80f70d33c394b251b7baeae13bc5aab34ba16f.1604006121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 05/10] serve: advertise trace2 SID in v2 capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trace2 is enabled and trace2.advertiseSID is true, advertise the
server's trace2 session ID for all protocol v2 connections via the new
trace2-sid capability.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 serve.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/serve.c b/serve.c
index f6341206c4..6ad73d69ab 100644
--- a/serve.c
+++ b/serve.c
@@ -7,6 +7,9 @@
 #include "ls-refs.h"
 #include "serve.h"
 #include "upload-pack.h"
+#include "trace2/tr2_sid.h"
+
+static int advertise_trace2_sid;
 
 static int always_advertise(struct repository *r,
 			    struct strbuf *value)
@@ -30,6 +33,15 @@ static int object_format_advertise(struct repository *r,
 	return 1;
 }
 
+static int trace2_advertise(struct repository *r, struct strbuf *value)
+{
+	if (!advertise_trace2_sid || !trace2_is_enabled())
+		return 0;
+	if (value)
+		strbuf_addstr(value, tr2_sid_get());
+	return 1;
+}
+
 struct protocol_capability {
 	/*
 	 * The name of the capability.  The server uses this name when
@@ -66,6 +78,7 @@ static struct protocol_capability capabilities[] = {
 	{ "fetch", upload_pack_advertise, upload_pack_v2 },
 	{ "server-option", always_advertise, NULL },
 	{ "object-format", object_format_advertise, NULL },
+	{ "trace2-sid", trace2_advertise, NULL },
 };
 
 static void advertise_capabilities(void)
@@ -261,6 +274,8 @@ static int process_request(void)
 /* Main serve loop for protocol version 2 */
 void serve(struct serve_options *options)
 {
+	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
+
 	if (options->advertise_capabilities || !options->stateless_rpc) {
 		/* serve by default supports v2 */
 		packet_write_fmt(1, "version 2\n");
-- 
2.29.1.341.ge80a0c044ae-goog

