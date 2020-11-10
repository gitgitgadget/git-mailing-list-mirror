Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F38EC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 12:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073EA206B2
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 12:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMoEAo9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgKJMBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJMBn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 07:01:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DAAC0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 04:01:43 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i13so5181565pgm.9
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 04:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cRbVzxeImPowjA2VUqu2OAwLOk5vWk6/kmididk7cCY=;
        b=PMoEAo9BzA4hnDbCs5XwNiP06wfAJz8kRixWmC7EmLYFN3r5t0OHsojbkahg3Rt5ML
         9ubmpoqjK/ZDQYoP18SK4T4VSVmQ1MvrLR3kb0A0CoSezp0HUsBj8rte4OWn6m7XBYWS
         iNmw5KwUNUHSSDPecKCEyeVxYMnNpdWmLASUlSpSC7hWKjfxLVh6JT6x9fmyeXJl8q16
         LsLPHlF3CG9tN1odk7T1euDeOo38mkLkVuFLXUZn6SZlyAagGZcg6QZUjBwJzGazB42z
         VA2wrdzcr8A45zfiZ3mBpWFWPuwFgT0NDV+eiE8MdD+QBfHgp06m5E8cLVrxrqFFNFl7
         fHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cRbVzxeImPowjA2VUqu2OAwLOk5vWk6/kmididk7cCY=;
        b=uGZU03yfQp00NPnmFS/4Sj06y2FW+IsulGj+BT4U1Vx/Us/PjaXMZYcuNKXr3FN3gu
         /TcWHsLmDazJ2mMdPaJ5XRv2qVkDYUNM2Hqlzp6Ik9U1AWIORe7MCyUGeem/SvHB05cy
         dZkajFBo6diqMhOaQVD5VVnsXw0lDV86wbH9zqAyzgHeTFTE2+hfC62c3lLZ9hsYC36F
         7O0SNdWHM2EH0RYEHdGO195V68LdoYPR7ma3/XsYzMbnMTIOSRJ9xb+LsMPvJ2rMhkv4
         ura/Rg/yat8hNdmVy9pi/KdWKulvt/Jui3yLdMqOYlIYT7SKRcdvzfSuAYvAct1iDEFw
         fOIw==
X-Gm-Message-State: AOAM532rBicVH7dez6sCy9WKCapQBrz0kyV+4wGT6ugQkq4lbvi9yBC1
        E602A3xo0dDXwpZIRSLZCE5JouwfyihZOA==
X-Google-Smtp-Source: ABdhPJwBUAcG5enGQWUxX7lu4Bj0m7TY3rxv9KkWU8E8OI3/Qjy3e1XKEy2wXesEHfrXUuiIxjpNjg==
X-Received: by 2002:a62:7883:0:b029:18a:e054:edf1 with SMTP id t125-20020a6278830000b029018ae054edf1mr17829572pfc.70.1605009702749;
        Tue, 10 Nov 2020 04:01:42 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id i2sm3098731pjl.15.2020.11.10.04.01.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 04:01:42 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 1/2] t5411: refactor make_user_friendly_and_stable_output
Date:   Tue, 10 Nov 2020 20:01:34 +0800
Message-Id: <20201110120135.42025-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.29.0.dirty
In-Reply-To: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
References: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Common function `make_user_friendly_and_stable_output()` can take
additional arguments to format messages for special cases.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411/common-functions.sh                       | 10 ++++++++--
 t/t5411/test-0000-standard-git-push.sh            |  9 ++++-----
 t/t5411/test-0001-standard-git-push--porcelain.sh | 15 +++++++--------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
index 521a347710..b7cca2d8fb 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -42,7 +42,7 @@ create_commits_in () {
 make_user_friendly_and_stable_output () {
 	sed \
 		-e "s/  *\$//" \
-		-e "s/   */ /g" \
+		-e "s/  */ /g" \
 		-e "s/'/\"/g" \
 		-e "s/	/    /g" \
 		-e "s/$A/<COMMIT-A>/g" \
@@ -52,5 +52,11 @@ make_user_friendly_and_stable_output () {
 		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
 		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
 		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#" \
-		-e "/^error: / d"
+		-e "/^error: / d" | \
+	if test $# -eq 0
+	then
+		cat
+	else
+		sed ${1+"$@"}
+	fi
 }
diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
index 2b04b49367..b3af3f59b0 100644
--- a/t/t5411/test-0000-standard-git-push.sh
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -36,11 +36,10 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
 		main \
 		$B:refs/heads/next \
 		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out |
-		sed -n \
-			-e "/^To / { s/   */ /g; p; }" \
-			-e "/^ ! / { s/   */ /g; p; }" \
-			>actual &&
+	make_user_friendly_and_stable_output -n \
+		-e "/^To / { p; }" \
+		-e "/^ ! / { p; }" \
+		<out >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [rejected] main -> main (non-fast-forward)
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index 747307f8da..16ff2d5666 100644
--- a/t/t5411/test-0001-standard-git-push--porcelain.sh
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -37,16 +37,15 @@ test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
 		main \
 		$B:refs/heads/next \
 		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out |
-		sed -n \
-			-e "s/^# GETTEXT POISON #//" \
-			-e "/^To / { s/   */ /g; p; }" \
-			-e "/^! / { s/   */ /g; p; }" \
-			>actual &&
+	make_user_friendly_and_stable_output -n \
+		-e "s/^# GETTEXT POISON #//" \
+		-e "/^To / { p; }" \
+		-e "/^! / { p; }" \
+		<out >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	! refs/heads/main:refs/heads/main [rejected] (non-fast-forward)
-	! <COMMIT-B>:refs/heads/next [rejected] (atomic push failed)
+	!    refs/heads/main:refs/heads/main    [rejected] (non-fast-forward)
+	!    <COMMIT-B>:refs/heads/next    [rejected] (atomic push failed)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
-- 
2.29.0.dirty

