Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0624FC433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 17:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386555AbiEBRNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 13:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386544AbiEBRNV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 13:13:21 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6088D5F55
        for <git@vger.kernel.org>; Mon,  2 May 2022 10:09:52 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z34-20020a056a001da200b0050e057fdd7eso338112pfw.12
        for <git@vger.kernel.org>; Mon, 02 May 2022 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b7Or1K2HTHUnCI3ox1uTSfm7WCDiVHJa+NiADeIjCnk=;
        b=qFXNIlsmpOmEmCEM85qdV7AXwqiB/UVsaYQT6Rf3t4Y3hzcNzK/yW1jDyV/c4EDY2X
         lhu0hj0ESmqeYZkErdo2zEdUYeSqAPF13nsjQi0KfbjAXMY0MQvJunrZ78otqGlGVpGz
         /aGUT4RNG04/4F1FpvQKK0nKQHWqWyBMCJrIoffwl9Ij4RNONcdv7WmlznjuiiMDiuQ4
         Tc/rhavuRLfilVaDHFwHJv1VN56aq2CU2Yxsw5epeQW0VDcAdl3FADkkC4WuxNR0WtsL
         FmBKV55kD8YhDQIS/KuDT0mpzJn6hZckmoejDT36gfSTap7JIVICDVWP1TDHWxn2RBK3
         PFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b7Or1K2HTHUnCI3ox1uTSfm7WCDiVHJa+NiADeIjCnk=;
        b=3Bbe30UR1/95U8PYAo4CmzwEH/iBd/i1+6MxJhWHaB33Kx8hL6xWIi0+TV3+M0gpUC
         n2SlRjo3JEFFpH1YqmmURGaq1aZ7Ch9OFo05xRfWPxVosUFq/hMbMRei/RWw+/7aB8FV
         mQvytqBAeEs+yOLhxNkPWEy7Jr/vPntDeA5ckP0MK6qYROLH2kVDMA4OLvaY/PkQapVg
         OLbxw1J6uncU/v4Pyb1daJvnHWc31OpwFp2MO8jX4JVl/m57dels6KH/Ha2halI2gR5Y
         aiURh4nWC42vkW/ePpXT2Le4oms9CbBrkV9hRzXdmMMUybNTgcaUZljLWmb0x5xmDAZG
         PWXA==
X-Gm-Message-State: AOAM531HTrsL89ekfYHlzPlcerI05Le6j2Tot9hqhkPfe3eSWnkDUwpq
        mEyGuSuSxNXkF6bJbF0wpLYsySO0amD3WW8HMJGwvb03C3fSi79TiJNvnmqA6o6iwWeqpYmmpio
        H+d7hICGL/bXHsc7bP2XQKHcWyM2znATI1YH+Yw5bFLeXpP/xwNWI8Nz0+l/umq47Xg==
X-Google-Smtp-Source: ABdhPJw8JU3ATo3DpKzQhCadXTpRrqpO4i5wESjvbiY0qcLZropsSJHPcxUMNR5hJGWw6U36Cb79YbbKmLdEJcI=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:890:b0:4f6:686e:a8a9 with SMTP
 id q16-20020a056a00089000b004f6686ea8a9mr12007737pfj.83.1651511391636; Mon,
 02 May 2022 10:09:51 -0700 (PDT)
Date:   Mon,  2 May 2022 17:08:57 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220502170904.2770649-2-calvinwan@google.com>
Mime-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com> <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.36.0.rc2.10170.gb555eefa6f
Subject: [PATCH v4 1/8] fetch-pack: refactor packet writing
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, calvinwan@google.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch will need to write capabilities for another command,
so refactor write_fetch_command_and_capabilities() to be used by both
fetch and future command.

---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 4e1e88eea0..e06125c90a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1246,13 +1246,13 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return haves_added;
 }
 
-static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-						 const struct string_list *server_options)
+static void write_command_and_capabilities(struct strbuf *req_buf,
+						 const struct string_list *server_options, const char* command)
 {
 	const char *hash_name;
 
-	if (server_supports_v2("fetch", 1))
-		packet_buf_write(req_buf, "command=fetch");
+	if (server_supports_v2(command, 1))
+		packet_buf_write(req_buf, "command=%s", command);
 	if (server_supports_v2("agent", 0))
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id", 0))
@@ -1288,7 +1288,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, args->server_options, "fetch");
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2072,7 +2072,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 		int received_ready = 0;
 
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, server_options, "fetch");
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.36.0.rc2.10170.gb555eefa6f

