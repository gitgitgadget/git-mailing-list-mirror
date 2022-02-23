Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FB1C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbiBWSc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243894AbiBWScK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C2A4BFDF
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d28so13320145wra.4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NOsus6dQJSUF86hnfVb84Zn0qDjSNhLGKvDkGIv1aAY=;
        b=H9H/tRmayqPZUOV2uuK35cb43VmCufXm9WnE2bQU0sfFgmar9FzlyVBDd2viW+G6bf
         3ee5B7hJtK/crY16Tya9L9f2Egvf3e5qKW6342aCmKjf+COXIxxstNIjth6ceqEg7IZY
         6Y/OlC5QAChCJMGvCDabNX/c4/ctWOFLaoAofnaco/N6O2TR6YYJHNtW9wUO+ayHK/18
         KRXM+9hGnyCsjFdR2JCStQYt7dRJNC+22Gc7w/V/zaSZsDzia06kOWK9En6P7zifySGb
         LH99U5CLmEmzdn4TYf0uPA9G4m0V4uxLR1F77ioAJjb2N+YvBvob59YpkkUsySC8X6CI
         /hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NOsus6dQJSUF86hnfVb84Zn0qDjSNhLGKvDkGIv1aAY=;
        b=120ZaPJOqdH4UX5nVWXHn5WbxAFAQU8nXShRM7dT0p4SKa1QdF+SDduTBKc7Rg/xgv
         Ru2xcb/l6ZS+SHvwK1mq+ipK3TazojuhrinkPyp+FGzk0Jz8We+z70Bn0nfGnIAqSisE
         MfrsD9GE7Kf/eL6uSfyOaiiHlEn1LZLaRlT34FjHHU7hk1SCHGsfD0rMtBc1lJTWBmJN
         0ckgxhbe4/bJQFfcbNBh8cMxIKs/040AOLLonJ+E0DNSQtENFk9ABOkBQxitVFtKU0CP
         nWNejjRhlOKWJgctb8FBguh6ip+YxV7nLkyTgu/ctMMyNTl64AQIhYuATcyEyZ3ehWQQ
         SF/g==
X-Gm-Message-State: AOAM532jYddUTlllcEWCvQmY/E4NwAMSsPkE0cy40BXFs7YFtE5HOoLT
        vd9C5TYSNaMsDiBk8eXHozesT8fxEFs=
X-Google-Smtp-Source: ABdhPJxpiumnnzMNPnudC6rZXdCX2P1nDIhqFwmhhPshYb+UmJBEpLqxXJPp+yMlo47m4bBkj62GoA==
X-Received: by 2002:a05:6000:2a5:b0:1e8:d9dc:f369 with SMTP id l5-20020a05600002a500b001e8d9dcf369mr639424wry.589.1645641086728;
        Wed, 23 Feb 2022 10:31:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9sm263700wrx.76.2022.02.23.10.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:26 -0800 (PST)
Message-Id: <a6779c713afc19bfaf0ffa10bf97346b9b4e96fb.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:59 +0000
Subject: [PATCH 21/25] serve: advertise 'features' when config exists
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'features' capability allows a server to recommend some Git features
at a high level. Previous changes implemented the capability so servers
understand it, but it was never advertised.

Now, allow it to be advertised, but only when the capability will
actually _do_ something. That is, advertise if and only if a config
value exists with the prefix "serve.". This avoids unnecessary round
trips for an empty result.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 serve.c              | 18 +++++++++++++++---
 t/t5701-git-serve.sh |  9 +++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/serve.c b/serve.c
index a1c853dda1f..7dcabb68147 100644
--- a/serve.c
+++ b/serve.c
@@ -18,12 +18,24 @@ static int always_advertise(struct repository *r,
 	return 1;
 }
 
-static int never_advertise(struct repository *r,
-			   struct strbuf *value)
+static int key_serve_prefix(const char *key, const char *value, void *data)
 {
+	int *signal = data;
+	if (!strncmp(key, "serve.", 6)) {
+		*signal = 1;
+		return 1;
+	}
 	return 0;
 }
 
+static int has_serve_config(struct repository *r,
+			    struct strbuf *value)
+{
+	int signal = 0;
+	repo_config(r, key_serve_prefix, &signal);
+	return signal;
+}
+
 static int agent_advertise(struct repository *r,
 			   struct strbuf *value)
 {
@@ -144,7 +156,7 @@ static struct protocol_capability capabilities[] = {
 	},
 	{
 		.name = "features",
-		.advertise = never_advertise,
+		.advertise = has_serve_config,
 		.command = cap_features,
 	},
 };
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 1896f671cb3..6ef721c3f97 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -30,6 +30,15 @@ test_expect_success 'test capability advertisement' '
 	test_cmp expect actual
 '
 
+test_expect_success 'test capability advertisement' '
+	test_when_finished git config --unset serve.bundleuri &&
+	git config serve.bundleuri "file://$(pwd)" &&
+	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
+		--advertise-capabilities >out &&
+	test-tool pkt-line unpack <out >actual &&
+	grep features actual
+'
+
 test_expect_success 'stateless-rpc flag does not list capabilities' '
 	# Empty request
 	test-tool pkt-line pack >in <<-EOF &&
-- 
gitgitgadget

