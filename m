Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD32C4320A
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A4C60FC3
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhHDWRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhHDWRa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:17:30 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEF4C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 15:17:16 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so2986779qkd.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=x6Rc8rAkTdr6i9HVOr2eUAr2VxmB2yvLekh9vFXMHxY=;
        b=mDgT7g4zEyRaZCPddaAwwVCcDGUUt5az1L7vWKeCnR4/I2ZMJRtVF3RYcHOcHv0ZH8
         rp7C4Lgss5rCQSrT2Nb8bm4eU4JUZlx9IVwZhpUO2vbYFx3gwe99iVcBkjk5zpsqE1Go
         rAK4aq0SCp+ZZ1l5r9qhCZv8mYVXSq83o7sjBA0F2n79QeXnx3fSwk+ABTkXYM+a9nuQ
         Aj2EjqWrGV2mGQSm3HQ1t82NiwmpmtQszTnjeUuLB2awhdWYbHS4YmNWtcx9Th6rIZTB
         OnwzAiRnloEg4lDQQBKgDSy14kOoFlCU5jKPr/XLiBflBJRisc0ZUX3uwCwuYsmHnwxN
         vvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=x6Rc8rAkTdr6i9HVOr2eUAr2VxmB2yvLekh9vFXMHxY=;
        b=GWI+afdFiw6jURORMSgzMBdMLpReM4BaRMUEnE6zmhlzW4RE0abrPa1SsFVCYRQ4qF
         /S6XhstXUghf9hassyxTsopxnpriMrxFGUHQwoqBzqvU1N2KzaJibTrv3PhAqwJb/qnv
         yHqskVDF8CvcfAQKBvmRpbpUH2BJKINO0XoCWstEQ1LRygRjh/MjfjkQm2sCiuvS/rhW
         T+Ca0Aj1sJPL5HGbJMMxCiUiFMsfu5SmP+1WE7qflvouA6Gg6iauK9/2Z2X7X8B4YEyc
         bSzkm+r7XdGvn3d567iCmtBVqOcX59x07b0z7lAxID2u59RVAEMZu3iW3n3s3EYXqigW
         D+cg==
X-Gm-Message-State: AOAM530TzskEGTJamY6TsD5IuwMzlr2F37Mvmx+SIrnYfkRLs9fpp1Tc
        bLhRrLNa8kBIqg5DWrApt+uYV+aDko/4e+cmxxzgRwERhUAvnGm1qJpdPAwsUPkU5hurJjWHPlz
        EPchm0Bd0LD6J9mlltJs+JnOa+ni7Twx4n1QHZyvoQmnfp055T42+h9uq4LNNz7A=
X-Google-Smtp-Source: ABdhPJwG7atowTO3r+mt983HKbw4jXe145wKquGEde5eTGtmpsrd3ErWIxiU0Zla7CjsAnNENTtweGhIHYxLsQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:9758:1083:3c28:c541])
 (user=steadmon job=sendgmr) by 2002:a05:6214:d4b:: with SMTP id
 11mr1757524qvr.44.1628115435699; Wed, 04 Aug 2021 15:17:15 -0700 (PDT)
Date:   Wed,  4 Aug 2021 15:17:09 -0700
In-Reply-To: <cover.1628115064.git.steadmon@google.com>
Message-Id: <d138b2615c1af288627b9a2f8f7dd3d2fed184d7.1628115065.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1628115064.git.steadmon@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2 2/2] connect, protocol: log negotiated protocol version
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is useful for performance monitoring and debugging purposes to know
the wire protocol used for remote operations. This may differ from the
version set in local configuration due to differences in version and/or
configuration between the server and the client. Therefore, log the
negotiated wire protocol version via trace2, for both clients and
servers.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 connect.c                             |  3 +++
 protocol.c                            |  3 +++
 t/t5705-session-id-in-capabilities.sh | 12 ++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/connect.c b/connect.c
index 70b13389ba..5f0e113625 100644
--- a/connect.c
+++ b/connect.c
@@ -150,6 +150,9 @@ enum protocol_version discover_version(struct packet_reader *reader)
 		break;
 	}
 
+	trace2_data_string("transfer", NULL, "negotiated-version",
+			   format_protocol_version(version));
+
 	switch (version) {
 	case protocol_v2:
 		process_capabilities_v2(reader);
diff --git a/protocol.c b/protocol.c
index 7ec7ce896e..f52dc2d7a2 100644
--- a/protocol.c
+++ b/protocol.c
@@ -87,6 +87,9 @@ enum protocol_version determine_protocol_version_server(void)
 		string_list_clear(&list, 0);
 	}
 
+	trace2_data_string("transfer", NULL, "negotiated-version",
+			   format_protocol_version(version));
+
 	return version;
 }
 
diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
index f1d189d5bc..88871c59b5 100755
--- a/t/t5705-session-id-in-capabilities.sh
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -40,6 +40,7 @@ do
 		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)" &&
 		test -z "$(grep \"key\":\"client-sid\" tr2-server-events)"
 	'
+
 done
 
 test_expect_success 'enable SID advertisement' '
@@ -73,6 +74,17 @@ do
 		grep \"key\":\"server-sid\" tr2-client-events &&
 		grep \"key\":\"client-sid\" tr2-server-events
 	'
+
+	test_expect_success "client & server log negotiated version (v${PROTO})" '
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
+		cp -r "$LOCAL_PRISTINE" local &&
+		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
+		git -c protocol.version=$PROTO -C local fetch \
+			--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
+			origin &&
+		test "$(grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-client-events)" &&
+		test "$(grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-server-events)"
+	'
 done
 
 test_done
-- 
2.32.0.554.ge1b32706d8-goog

