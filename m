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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB93C55178
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8266D20838
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duBzQK5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgJ2VdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgJ2VdA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:33:00 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9CC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:59 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w1so2606260qvv.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=TaxtZIDKG0UaCUh6/70wcULTQ2q/dbfS96QH9RZ+jR0=;
        b=duBzQK5sicZJ+eY5fG34Eph4FL7h2Tg3njRgAyPXS3CfeSkfjV5fZWXhjXNnVeM2n5
         EODXMqnfguGR42vdNpNn3qc/CojnnZDLLlwc9pw6u8lLoXW58WwKJtkv7GakB8dnZZJF
         n/e1DybO6b6vuctwv/pSNpEhM1Htz+irITdT8UDEu2aEJ3SwpKh5TKjlvRhrlsl75nms
         SlayzgLsSPGIz5kTIfgEk7VJ7Rj2ZY7mlEjVOAlpbwhJok5m7cA3A4tNY4y83EN3aQ86
         9FdICcmf+ecGxiAhp2SJ94kp1yfxOzD2xdAWAXJkQLGhB3kIUr3VTxTrvKtL5P2hMzz+
         BTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=TaxtZIDKG0UaCUh6/70wcULTQ2q/dbfS96QH9RZ+jR0=;
        b=tbE6fka5nhDWT77hP7QGKgA3Vzwj0V2b+Qu2hhEwFKir1CfxLX2vgpu1aFIdmTbreo
         SyqunQnEC1rd9BPKQBN9PcS4wi4nLw9hT0XzZF0ASsrUImt8rN0WvjmM3p1S4iUv/FWP
         fwwYGpgugKEzi1UDc9HDiK/gA+zVogWw+QT14UiZj6vgN+o8k59HVOOZ878e8pJBpjMG
         kOefVJP3rDeS9PeqeEuEdqNfH/tvqXnaaa8Ud1a+v//6xlnktnEgv6pZFhSt5m8bT+7s
         Oju8a60GQpcqJEyrQTQKBVh3Kutrs/utrcWD9xmHN5tY+JO+Jl7WsHzdbfEvlJipjxdL
         ebcA==
X-Gm-Message-State: AOAM531mcAKRWaM62lTWcSbv3QrxZe/e/d4a1TdB6wK2XjYlAlFhpd/F
        tCQd1Qtu57cn52BO1HORSQ/vBaejhr7dy7peHCW0ekKuV897fQyljjQO2cFQIAQBl5zFXgdDGat
        pLfS9DcTGtY6eQ+KyKeGyrmrBbWH1hfXwMenPJJGR6YmWV3PMER5wWJ04w80X2WM=
X-Google-Smtp-Source: ABdhPJyslGSzZaJIS+HpC3+0EBwioA9DF4lw9trZoYWM97aRlrL/JIMCkoaSMiUJ0fahBrcDVD4T8UEQ/g+28A==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a0c:f64b:: with SMTP id
 s11mr6232946qvm.47.1604007179069; Thu, 29 Oct 2020 14:32:59 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:32:39 -0700
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <609958bd1a308c63cc1d5a526b6206745f390a45.1604006121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 09/10] send-pack: advertise trace2 SID in capabilities
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
 send-pack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index eb4a44270b..56c6740e65 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -16,6 +16,7 @@
 #include "gpg-interface.h"
 #include "cache.h"
 #include "shallow.h"
+#include "trace2/tr2_sid.h"
 
 int option_parse_push_signed(const struct option *opt,
 			     const char *arg, int unset)
@@ -424,6 +425,8 @@ int send_pack(struct send_pack_args *args,
 	int use_sideband = 0;
 	int quiet_supported = 0;
 	int agent_supported = 0;
+	int server_sent_trace2_sid = 0;
+	int advertise_trace2_sid = 0;
 	int use_atomic = 0;
 	int atomic_supported = 0;
 	int use_push_options = 0;
@@ -435,6 +438,8 @@ int send_pack(struct send_pack_args *args,
 	const char *push_cert_nonce = NULL;
 	struct packet_reader reader;
 
+	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
+
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status-v2"))
 		status_report = 2;
@@ -450,6 +455,8 @@ int send_pack(struct send_pack_args *args,
 		quiet_supported = 1;
 	if (server_supports("agent"))
 		agent_supported = 1;
+	if (server_supports("trace2-sid"))
+		server_sent_trace2_sid = 1;
 	if (server_supports("no-thin"))
 		args->use_thin_pack = 0;
 	if (server_supports("atomic"))
@@ -506,6 +513,8 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addf(&cap_buf, " object-format=%s", the_hash_algo->name);
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
+	if (advertise_trace2_sid && server_sent_trace2_sid && trace2_is_enabled())
+		strbuf_addf(&cap_buf, " trace2-sid=%s", tr2_sid_get());
 
 	/*
 	 * NEEDSWORK: why does delete-refs have to be so specific to
-- 
2.29.1.341.ge80a0c044ae-goog

