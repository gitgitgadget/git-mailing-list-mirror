Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF3AC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C1660F35
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhHDWR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhHDWR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:17:27 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F17C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 15:17:14 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w10-20020a0cfc4a0000b0290335dd22451dso2514305qvp.5
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=wypiMyjNXd2CJ7qJ2XeSgNHnMJdDPFbrpAp3EJQZp9w=;
        b=f5zeEP8KyU5WLYs0QFYTmtprwaINQAPyjIZVwNSAEfxotVCaIgkUjtUUDvfV+eMSlQ
         d7G109DC98It+LeqXmFSQXPllyNLA63v2tLXhOIvFYMJ9/5kfRzeAjO/QPuJwEFKlS3D
         J/Qnq6ySomdhMg5yIGQIaRTBo6Ts/qxB1cEAMWoosxhPYiq6QQBoaC9acFfU1JyszJWE
         7CmxzKVDdVPl8/ztyOcNHXLTz1bCC+mJEQsIJS0UzNcEGY4OhaY8oHONF9n0t2k8MK+1
         nLiKVp+i7VqEKtIkkYbIu9sQHjdB28hYMUMcYaGZDQuhFlNCNR7fVd1qz0FTuZoxUDeG
         qquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=wypiMyjNXd2CJ7qJ2XeSgNHnMJdDPFbrpAp3EJQZp9w=;
        b=KiC7LxH13OriiUuRI2rxXLl/GrNs+XTudmUQ3ONQKGPy5vtQk6QAXsC4MIcKK2qgZI
         jYi1vKCT1DTT2LKol+gzpNf7EbiFLbCQkZgHDc3vcHcsT1u/S/Poq1r9T0a6mCG57h0p
         avD3JkIwYSJ+jRrfLRnrJGK4T7l8DFPfcLXcu/TfAyTIXlQUHtaBzpx4UzCk87hVWn9m
         tBu8CVZlVMiGC+pPWA8OLTYvumFFK4IIapaykFYmHFA8BJwUKRxrPcE9vzTYo2iIgH20
         qb6FLu5CjUOVvjyVyar2msglEO/8M8G+otzHkPfXN9XdUTKMuQbIhSuJOnfO/IBh4Hxu
         vY6A==
X-Gm-Message-State: AOAM533j5jGFPO6nl05mX3t1BQ/INb0c8GuBXMNq8pyVO8oDPjR+6aQk
        6vG3RH77s5qLqH/UJS3sm9vQHa7mwzliRZ0mw/HEUdNWvDTZVhHxmYSJu5HVokPGH6RDjUyO+LB
        uOdUwkTlZ2mHmyPmdbB4jtNWXpNfJmWUNLYxjf+PGnoPdn7ofJIFuDnUywfguaBk=
X-Google-Smtp-Source: ABdhPJwLfcLIoHRv5EhUHcIlkGdx+XplodDa9to2HqvNxpttk99QmkAWkZki1RNqePb+LKDTWbHWNIAGQr6T3w==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:9758:1083:3c28:c541])
 (user=steadmon job=sendgmr) by 2002:a05:6214:e88:: with SMTP id
 hf8mr1751017qvb.40.1628115433378; Wed, 04 Aug 2021 15:17:13 -0700 (PDT)
Date:   Wed,  4 Aug 2021 15:17:08 -0700
In-Reply-To: <cover.1628115064.git.steadmon@google.com>
Message-Id: <63f98062788a7c5d44fafecfde78077bdce2af73.1628115065.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1628115064.git.steadmon@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2 1/2] protocol: add protocol version formatting function
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function to get human-readable names for the various wire protocol
versions.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 protocol.c | 14 ++++++++++++++
 protocol.h |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/protocol.c b/protocol.c
index 052d7edbb9..7ec7ce896e 100644
--- a/protocol.c
+++ b/protocol.c
@@ -14,6 +14,20 @@ static enum protocol_version parse_protocol_version(const char *value)
 		return protocol_unknown_version;
 }
 
+const char *format_protocol_version(enum protocol_version version)
+{
+	switch (version) {
+		case protocol_v0:
+			return "0";
+		case protocol_v1:
+			return "1";
+		case protocol_v2:
+			return "2";
+		default:
+			return "UNKNOWN_VERSION";
+	}
+}
+
 enum protocol_version get_protocol_version_config(void)
 {
 	const char *value;
diff --git a/protocol.h b/protocol.h
index cef1a4a01c..22e7a70912 100644
--- a/protocol.h
+++ b/protocol.h
@@ -8,6 +8,12 @@ enum protocol_version {
 	protocol_v2 = 2,
 };
 
+/*
+ * Return a string representation for a given protocol version. Mainly used to
+ * handle protocol_unknown_version nicely.
+ */
+const char *format_protocol_version(enum protocol_version);
+
 /*
  * Used by a client to determine which protocol version to request be used when
  * communicating with a server, reflecting the configured value of the
-- 
2.32.0.554.ge1b32706d8-goog

