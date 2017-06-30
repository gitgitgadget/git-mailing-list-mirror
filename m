Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB47D201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbdF3Ux3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:29 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35318 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbdF3Ux0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:26 -0400
Received: by mail-pf0-f174.google.com with SMTP id c73so72471351pfk.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gp2p0rh900T64j6jVmbegwUukokMIIk0hQXTUdGrT2k=;
        b=rN7OSmnsp6UHL3FuHAXdjmBKAeGSMvpFil4zGgYJaxN65yf8uaHLmahJ8WfkA2+XeB
         bee4DJ7xra6iEKJr1uH0KDD+7EgP8+fjGUuZGLshrYmdR7wmxTjuTdXOsjSw3dv3HwO4
         w8K+1Kf3C5ThmSjGTEGjSp7zS3Vr1KIFbITH8Cl8Y9neb8G+Ga5EWk+nos+OVFjm4TXr
         oQ0jGpnLVi0HkM5qeCMtjEKmZMyRlrwUNaCdMHR/ji00FuSZCCApvfssuA8AjjuR4zvQ
         YtCxSAfpoSyIfhFqxU9K8/O7UWXLCI18W+2B1xK0A9mM3mC+8vUanAn+W0b7Y63uFPaw
         oybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gp2p0rh900T64j6jVmbegwUukokMIIk0hQXTUdGrT2k=;
        b=Zp/2Dm3UdtjhqnuxN1WTpP7TM2vDuo67WiGsB5VojvubGp4fpL0Q4PnXwzXOvJnqei
         eU4SLPpCZSevf4oLuLvnjHvq2Yy7fWtcDInkCqVhl6CwOW/rXsPVDzaHsUMK7BnRqLlw
         HbXr7O181SfXC8/fWuqLMfvgTXn4S3pkfS/Rxr5d4yoI5yaL3XoepmdVGCp7SKlrOH4S
         IdmNjR0Gq2Rsm3CE/kRhWVoENU5E23fsYtXsjVlP6psDymJKfekYo5OZiy9IJp/yBIr1
         yM3DpPYKl6PL9MNVLT0pRJIF0S9157yDfLE9SfHx/T1QXzP6LUzQty47b1lPxSPVjMWJ
         KZZQ==
X-Gm-Message-State: AKS2vOwZcpNj2dl+Arltk/YMZaNll9q0uN2M17UXbqDZ+CY24IL/SqLw
        mv7NqbhGnXdgZWNLX8lz2Q==
X-Received: by 10.98.160.28 with SMTP id r28mr24557763pfe.86.1498856000848;
        Fri, 30 Jun 2017 13:53:20 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id l4sm17584679pgr.21.2017.06.30.13.53.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 05/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
Date:   Fri, 30 Jun 2017 13:52:50 -0700
Message-Id: <20170630205310.7380-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 4637368d59..75b996c4cf 100644
--- a/diff.c
+++ b/diff.c
@@ -561,13 +561,20 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
 };
 
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len)
 {
+	const char *context, *reset;
 	switch (s) {
+	case DIFF_SYMBOL_CONTEXT_MARKER:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, context, reset, line, len);
+		break;
 	case DIFF_SYMBOL_SEPARATOR:
 		fprintf(o->file, "%s%c",
 			diff_line_prefix(o),
@@ -662,7 +669,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->opt, context, reset, line, len);
+		emit_diff_symbol(ecbdata->opt,
+				 DIFF_SYMBOL_CONTEXT_MARKER, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
-- 
2.13.0.31.g9b732c453e

