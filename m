Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EB2C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AA520838
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlPUYXAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgJ2VdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgJ2VdD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:33:03 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E1C0613D2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:33:01 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z9so2566626qvo.20
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 14:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=B2VBxg7Va4v7/Oqd7E2X7HjmghjR5vMiOw/hZdmldgA=;
        b=JlPUYXAiYuamia5+Sp1ph3q2KWD6KE7BNwvHxQPGoaWwYdBHVJAMrAHEEpVqAFUya/
         Y/5UDGlFGfcqKyFrAAy/OVYcs3VqT9LJ4m1kTU91yaMXBCGzAKNDZkt4OMCPzPVkOt7I
         MvOwZa/3uGJp6xtyrjfFwPGWisdXRiyJX+5kWe/PTUWC2oJ4SbZdQ+6uhk9UmATn1Z2F
         kZU4BErUXFxfzCWKGVuD8aH8V+3STBO0TFACplrPEidh0Z5PqlAi+r/DoiScYcaF4ysh
         HFMMUt7UloXxP1H83fVezQjrqzSHDw9iErQasPuXJZtZmkU170v2y1Lbz+TwHdObC5bP
         oIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=B2VBxg7Va4v7/Oqd7E2X7HjmghjR5vMiOw/hZdmldgA=;
        b=WZ9Ld7yIjz7qDIZfGKGBG2GUzJM6YmiFDwnlPjHs0kBZtM9hI2rrR65i1eoHBIqQFP
         icHo4kuF5MfDOR/IfsJqiRXICiv+9eMWnONshv4DDTAFdYs4CUV+kxPuhb/cyHjY9VgF
         CZ6Yr0B5Xs3nxGbN+nFFrdp+CmniO4I9bE+6/KTMU8IPNCqwdraF33N6sWSjLPdaEw8M
         64p6+Y+O0gOM+ffZ+elMvkAXrtx78iZ9fCZE52vK7wR8RmJkbJkkxlL+a8wX/RwtHQSz
         V3IW9ulyxHdKNTm1yYFTCBP8Zvl+cpvq/DhPd7kZvrti6AyJY36HtqmMks6VZrfyIgxS
         NAQQ==
X-Gm-Message-State: AOAM532xwHbHb5wew+/fNNcbgzhxV8zeanrc11z7TZO7Kzd2/aW+yCG9
        haAvJ0Un+5pHCZDSpyb6Ngzfnw6P34l0cSquB8TsrpBKl1y/l+6/SpGxNqS2nNTn1e79wq/VXnH
        KfnVJYDFJRQDpleiJFKiX3gLS81ahHhxAhi4hkKBfvPlQhFcXavQkF8mI42Cza44=
X-Google-Smtp-Source: ABdhPJzhZBFctdDg/dy7kRMJuK5PzjUbseCPyyPP76BxSgn+noO6c4dQKb8jXT/cHUiAGCS7btbZ+Dtm7COA0A==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a05:6214:d42:: with SMTP id
 2mr6576671qvr.29.1604007180822; Thu, 29 Oct 2020 14:33:00 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:32:40 -0700
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <3bc412fc390afd0af1d6700609f899064b6d2844.1604006121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 10/10] receive-pack: log received client trace2 SID
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When receive-pack receives a trace2-sid capability from the client, log
the received session ID via a trace2 data event.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/receive-pack.c                |  7 +++++++
 t/t5705-trace2-sid-in-capabilities.sh | 20 ++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1ff83c874b..34199e4933 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2040,6 +2040,7 @@ static struct command *read_head_info(struct packet_reader *reader,
 		if (linelen < reader->pktlen) {
 			const char *feature_list = reader->line + linelen + 1;
 			const char *hash = NULL;
+			const char *client_trace2_sid;
 			int len = 0;
 			if (parse_feature_request(feature_list, "report-status"))
 				report_status = 1;
@@ -2062,6 +2063,12 @@ static struct command *read_head_info(struct packet_reader *reader,
 			}
 			if (xstrncmpz(the_hash_algo->name, hash, len))
 				die("error: unsupported object format '%s'", hash);
+			client_trace2_sid = parse_feature_value(feature_list, "trace2-sid", &len, NULL);
+			if (client_trace2_sid) {
+				char *client_sid = xstrndup(client_trace2_sid, len);
+				trace2_data_string("trace2", NULL, "client-sid", client_sid);
+				free(client_sid);
+			}
 		}
 
 		if (!strcmp(reader->line, "push-cert")) {
diff --git a/t/t5705-trace2-sid-in-capabilities.sh b/t/t5705-trace2-sid-in-capabilities.sh
index 3fad9462d3..15f78cb7d2 100755
--- a/t/t5705-trace2-sid-in-capabilities.sh
+++ b/t/t5705-trace2-sid-in-capabilities.sh
@@ -28,13 +28,17 @@ do
 	'
 
 	test_expect_success "trace2 session IDs not advertised by default (push v${PROTO})" '
-		test_when_finished "rm -rf local tr2-client-events" &&
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
+		test_when_finished "git -C local push --delete origin new-branch" &&
 		cp -r "$LOCAL_PRISTINE" local &&
 		git -C local pull --no-rebase origin &&
 		GIT_TRACE2_EVENT_NESTING=5 \
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
-		git -c protocol.version=$PROTO -C local push origin &&
-		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)"
+		git -c protocol.version=$PROTO -C local push \
+			--receive-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-receive-pack" \
+			origin HEAD:new-branch &&
+		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)" &&
+		test -z "$(grep \"key\":\"client-sid\" tr2-server-events)"
 	'
 done
 
@@ -58,13 +62,17 @@ do
 	'
 
 	test_expect_success "trace2 session IDs advertised (push v${PROTO})" '
-		test_when_finished "rm -rf local tr2-client-events" &&
+		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
+		test_when_finished "git -C local push --delete origin new-branch" &&
 		cp -r "$LOCAL_PRISTINE" local &&
 		git -C local pull --no-rebase origin &&
 		GIT_TRACE2_EVENT_NESTING=5 \
 		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
-		git -c protocol.version=$PROTO -C local push origin &&
-		grep \"key\":\"server-sid\" tr2-client-events
+		git -c protocol.version=$PROTO -C local push \
+			--receive-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-receive-pack" \
+			origin HEAD:new-branch &&
+		grep \"key\":\"server-sid\" tr2-client-events &&
+		grep \"key\":\"client-sid\" tr2-server-events
 	'
 done
 
-- 
2.29.1.341.ge80a0c044ae-goog

