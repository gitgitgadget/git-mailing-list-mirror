Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A197C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C062A22275
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/yHfgi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgKBWbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgKBWbd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F8AC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w4so15701302ybq.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=3aNFn6yfjfb+gMRjfQE9R+KZYkxhYDxU8woVj/hNAsM=;
        b=S/yHfgi/vQdfK1BC025t8LKtRAtH4LxzR86Nz7pFHtAcVSZfP61DV6cQMkczUIcXHC
         VpUiWsDizbspaNmDw3KPLLtvcmoVzrWF66BACh5fKqpXgYmeCOUrfCV50c3YNnSPFx1Z
         gEhxtP11jSGxqY51RexjLw77czKJTp6HdPaLD9jfPohUot6ePe3FcDZaGdRiB+VXf919
         +o/XMHUfGNgJKre0oJtGuozZnGrVqQmAa1WRKvbDHuMs7fj//TIdv3WZLlRDNYd+t46T
         pik/GHF6Z3lmwCSstjoxndD3dtLtX/3O4iKaboqnTIKZqc02oWaGGwgox2cjVxOfkPZF
         FHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=3aNFn6yfjfb+gMRjfQE9R+KZYkxhYDxU8woVj/hNAsM=;
        b=cNaLEnolZQ9yUbhpALIpUcuVO1qAjwzIPNGycOExIFCv973l22lwPBTUqpmkuAMQzA
         Pqgpd5vXyTQesd1cuUFoRgZpH8GDN36pVj38jVAxdXt4d4/zxUfxYqmoLRppez2UstOB
         6epESqBtQmi9Z0nX18Pua3KGwpP5NkY2j0miWYvvIGZltbX8RYJ1Ewco2oifTAmgGHzM
         TeOp3DkMfmuFXx5WXlpKp9au+uDdjnXE2+nJXEjVn/IKyQWJFeRW2QB1a9KS4DVaHOkC
         /H9YaEFjv8cqmEcgLzs+tSrW73w+5k8i4/+ScYzluuvL4RSWyACpq1Re1heOvYSMU3Cs
         21+A==
X-Gm-Message-State: AOAM533g0HXdM8XiTPJQmc6rHiGVEoYekex42xARPtlhhXiCNePpIkZp
        UgcVAatLuRZO/k770tJGA2o7DqLp1AeBGc5T2NMwjT58envNbKvoo4yCtaoo0YV/qWmskXbxeHM
        9FAuX48r2CwzEl/LulJz9tK43qeHDrsBWf2fBfZ2SekV7b99axPVZK+HkTxhsFGY=
X-Google-Smtp-Source: ABdhPJxpUBxw6kKq4+/MaK9yGgNb9RVKi5RCIRwr3exGLSIq9ArEntVy90RboCfQ8Zpn2WWRAhwPDVpcrXBk2A==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a25:aaa3:: with SMTP id
 t32mr21687401ybi.209.1604356290853; Mon, 02 Nov 2020 14:31:30 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:31:08 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com>
Message-Id: <c0b1ffc6d8ba6be9906a573e7c4d88b29c90d9b4.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 10/11] send-pack: advertise trace2 SID in capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trace2 is enabled, the server sent a trace2-sid capability, and
trace2.advertiseSID is true, advertise send-pack's own session ID back
to the server.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 send-pack.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index eb4a44270b..7478a3f7cc 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -424,6 +424,8 @@ int send_pack(struct send_pack_args *args,
 	int use_sideband = 0;
 	int quiet_supported = 0;
 	int agent_supported = 0;
+	int server_sent_trace2_sid = 0;
+	int advertise_trace2_sid = 0;
 	int use_atomic = 0;
 	int atomic_supported = 0;
 	int use_push_options = 0;
@@ -435,6 +437,8 @@ int send_pack(struct send_pack_args *args,
 	const char *push_cert_nonce = NULL;
 	struct packet_reader reader;
 
+	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
+
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status-v2"))
 		status_report = 2;
@@ -450,6 +454,8 @@ int send_pack(struct send_pack_args *args,
 		quiet_supported = 1;
 	if (server_supports("agent"))
 		agent_supported = 1;
+	if (server_supports("trace2-sid"))
+		server_sent_trace2_sid = 1;
 	if (server_supports("no-thin"))
 		args->use_thin_pack = 0;
 	if (server_supports("atomic"))
@@ -506,6 +512,8 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addf(&cap_buf, " object-format=%s", the_hash_algo->name);
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
+	if (advertise_trace2_sid && server_sent_trace2_sid && trace2_is_enabled())
+		strbuf_addf(&cap_buf, " trace2-sid=%s", trace2_session_id());
 
 	/*
 	 * NEEDSWORK: why does delete-refs have to be so specific to
-- 
2.29.1.341.ge80a0c044ae-goog

