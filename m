Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EB3C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBE9207D3
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0gI0XgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgESKyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 06:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgESKyP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 06:54:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB70C05BD0A
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i14so14257764qka.10
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YBnhe/GsDhR26I4VumrbqZP6HIDql2w1szyn7XtSRyc=;
        b=Q0gI0XgYGz+wfBexko8lTJyBd9XselxmlDqo1yuyq8ASC5LQlM1ZkwOUAeBpAsNUXa
         NPOp9NR1Cb2cmrVpvBlPwiwzkvPLQdgI/9OWl7MBBhXlw966XnSZpbcaBHcOHyagnc5M
         +nkSwwHJAZZGYf+2AbUwAmOZCstZ1OPGQQv6pxurr+NBMk45QT2nf6OP0uMEmL6KCV50
         dwmSNrcaHqQW0pY9SJrR5sJRQ8pbc+gVp7wYUpu1dkjO+MQyB1izCVndyA+HgKILYKLK
         ELjfZ3sDxBn7a/sq4yxGXHawPhyKEmWu2+dw9qeJbADdNliMKjCRHiWSG3hNm5rOqouG
         EyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBnhe/GsDhR26I4VumrbqZP6HIDql2w1szyn7XtSRyc=;
        b=rh+4jvT5rTvr7XG08RgkXgf/mrig4c6Mlg//iOQMPAuOBabkQb3WTxkSDU4llmWWFW
         qkir8N1BRSklR/scAK+ab+3lqkrvedlYZJoAfSLx6WPNFIbU9BtP5QnIEVwFFB37SYsp
         j1tXY27T7lTRZpSJQdzdC9/1on+VPIc5zJruzCs6mARBXhxqnC29Bks6kIgVEMLB+cyV
         ELZ9vJVEKR/7DrHXuWzlBOtctWVjkE4s3wi3AbmTPOMD868fT5CcnciKIGQQKHyyUXf8
         keewsh4Ngb+8pirQFx3Dfbi9y1gLSC2RgrOLcVExpL9Aq1nnVd9uUvTLSE3SvHxChMKV
         vsIw==
X-Gm-Message-State: AOAM533opGPMwN/wmbboNB53aeEjFfyU6y+znrku8rFwPRzXf5UEz1Id
        FcoL1v2DVDjMEpsX/GnHNIQ+A51z
X-Google-Smtp-Source: ABdhPJzDcyp0aMXnl90LB9Opni0NyY9wNnVD+gRNoZUhbblBf9v3DIPnOT3AsUKxAPpUxHALyabwoA==
X-Received: by 2002:a37:6e42:: with SMTP id j63mr20014528qkc.495.1589885654142;
        Tue, 19 May 2020 03:54:14 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c63sm10177775qkf.131.2020.05.19.03.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:54:13 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/7] transport: extract common fetch_pack() call
Date:   Tue, 19 May 2020 06:53:56 -0400
Message-Id: <c118baa5a2e14e16b1f565e485fedcc7806dc505.1589885479.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589885479.git.liu.denton@gmail.com>
References: <cover.1589816718.git.liu.denton@gmail.com> <cover.1589885479.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the switch statement, the difference between the `protocol_v2` and
`protocol_v{1,0}` arms is a preparatory call to die_if_server_options() in
the latter. The fetch_pack() call is identical in both arms. However,
since this fetch_pack() call has so many parameters, it is not
immediately obvious that the call is identical in both cases.

Extract the common fetch_pack() call out of the switch statement so that
code duplication is reduced and the logic is more clear for future
readers. While we're at it, rewrite the switch statement as an if-else
tower for increased clarity.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 transport.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/transport.c b/transport.c
index 15f5ba4e8f..431a93caef 100644
--- a/transport.c
+++ b/transport.c
@@ -369,24 +369,15 @@ static int fetch_refs_via_pack(struct transport *transport,
 		refs_tmp = handshake(transport, 0, NULL, must_list_refs);
 	}
 
-	switch (data->version) {
-	case protocol_v2:
-		refs = fetch_pack(&args, data->fd,
-				  refs_tmp ? refs_tmp : transport->remote_refs,
-				  to_fetch, nr_heads, &data->shallow,
-				  &transport->pack_lockfile, data->version);
-		break;
-	case protocol_v1:
-	case protocol_v0:
-		die_if_server_options(transport);
-		refs = fetch_pack(&args, data->fd,
-				  refs_tmp ? refs_tmp : transport->remote_refs,
-				  to_fetch, nr_heads, &data->shallow,
-				  &transport->pack_lockfile, data->version);
-		break;
-	case protocol_unknown_version:
+	if (data->version == protocol_unknown_version)
 		BUG("unknown protocol version");
-	}
+	else if (data->version <= protocol_v1)
+		die_if_server_options(transport);
+
+	refs = fetch_pack(&args, data->fd,
+			  refs_tmp ? refs_tmp : transport->remote_refs,
+			  to_fetch, nr_heads, &data->shallow,
+			  &transport->pack_lockfile, data->version);
 
 	close(data->fd[0]);
 	close(data->fd[1]);
-- 
2.26.2.706.g87896c9627

