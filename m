Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A0C208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 17:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754004AbdHURoG (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 13:44:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33027 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbdHURoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 13:44:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id 30so6610296wrk.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28HvLHHYvydBouWe4vs9AW0vRtjIfISK0b/N332bJjg=;
        b=Aw8Z0AEM0qh09+zmBKy1NZaVW7h9GFQgg7EB7zir7NrmDfpkLplwoFU9oqjxiSeOap
         LCyeLTkOlGnnb1EcqZnYCXXuYm9PW67t1WYRgcxSOLa1sIdAfXmnurFOpKEo7WfRotVV
         66y1oFKQmfO0eDQ67JRRMneiDXhk8LQPz8I1XgfbIQmq6HW0Wtft3KYk8L1fASsOOpiE
         LKHy7d+4CXJvWtgdB2vRpWTaf6zslQLN0G7egEzbqJ6Wpom8Ofjvz6SJ7BxP70Kyb9sJ
         GHcL2fGi3JVFPtF1tM1KIXJ8g3mxKByCtFroNLV6xsCUyWUkbvSBrnZOQSjbROqkuZYe
         kD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28HvLHHYvydBouWe4vs9AW0vRtjIfISK0b/N332bJjg=;
        b=FGn2yu7Ww6zcLmRuLZny+XSAHihl6qVTv3XRMuJ9XOznJSC6qGfqjrfTl4hIFgST55
         W6Nulu6Ef8sBOHyY+NnrgXqTeQW8vJ//erDIiodqzPUqh95RNXYLtJknMK1AMvwJsW8f
         +gP9auCs6IrGroMWHPmwJfq8T3+Lp+nULqh2wQdmQv7YfM85OBwrrXyAu32T5aimq210
         HlrJS0Ltr5KtiGIhvfSGLEMwAbuXfcraMUaBUm985XRPMtXRnc3mk9PUTg6KdNbuowLH
         8BTG9wyj/4UsByP6AfyoJHUPP3HavoElz5GlNStD9Mmj8KPmeY01Lpo/2RSOxWbyvlv1
         S6iA==
X-Gm-Message-State: AHYfb5issFoWzCryrJRNhndp/LLSoMCmm00eQ1TWwJY05UB2yd8QT7Nf
        mtDB2P8JpxeVospD
X-Received: by 10.223.176.72 with SMTP id g8mr13044883wra.117.1503337442922;
        Mon, 21 Aug 2017 10:44:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id y8sm5942458wmg.12.2017.08.21.10.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 10:44:02 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/4] convert: always initialize attr_action in convert_attrs
Date:   Mon, 21 Aug 2017 19:43:45 +0200
Message-Id: <f23f7f3d6cb75743cfd5b120a87e8765b281ce0a.1503323391.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1503323390.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

convert_attrs contains an "if-else". In the "if", we set attr_action
twice, and the first assignment has no effect. In the "else", we do not
set it at all. Since git_check_attr always returns the same value, we'll
always end up in the "if", so there is no problem right now. But
convert_attrs is obviously trying not to rely on such an
implementation-detail of another component.

Make the initialization of attr_action after the if-else. Remove the
earlier assignments.

Suggested-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v2: adapted per input from Torsten

 convert.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 1012462e3..1f8116381 100644
--- a/convert.c
+++ b/convert.c
@@ -1040,7 +1040,6 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		ca->crlf_action = git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action == CRLF_UNDEFINED)
 			ca->crlf_action = git_path_check_crlf(ccheck + 0);
-		ca->attr_action = ca->crlf_action;
 		ca->ident = git_path_check_ident(ccheck + 1);
 		ca->drv = git_path_check_convert(ccheck + 2);
 		if (ca->crlf_action != CRLF_BINARY) {
@@ -1054,12 +1053,14 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
 		}
-		ca->attr_action = ca->crlf_action;
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
 		ca->ident = 0;
 	}
+
+	/* Save attr and make a decision for action */
+	ca->attr_action = ca->crlf_action;
 	if (ca->crlf_action == CRLF_TEXT)
 		ca->crlf_action = text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_INPUT;
 	if (ca->crlf_action == CRLF_UNDEFINED && auto_crlf == AUTO_CRLF_FALSE)
-- 
2.14.1.151.gdfeca7a7e

