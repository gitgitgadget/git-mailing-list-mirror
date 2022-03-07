Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB46AC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbiCGMvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242626AbiCGMun (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A24FC51
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:43 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n15so8977497wra.6
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5se80LEa3tDQZzinpGCSpffAeIEgYnbhyqhZn3uUT4=;
        b=jxBF8r380MCGGPdVw0eMa5OeeaXjYPnC85EO9ugycsRMWzAwZXT9+RB+e3tFQ9GzGO
         fsdbiyZe+9VuaMAe3NMZ49Y0TwlpvvQMoEPytzefIPAsfvUtzjpsuWykpoLDQACvYy6q
         +DuVwOWwBrFTetCWxxH1xexDPY3jNQW1eNpCfhS2ui3Zhe1VJKMeG9QKCQp36QPh5BP7
         Kc1n6FNfgn4Zg6+wx2PztYe64jXOskH2kjql3iLcAglCSINh49Iicfdkz8ITrvvvSIdg
         B4Nga5vTNjF5HQ2Z7Hh5Ev6bKuiPRTwFfKu0JhqfKINk3AFABo8lfPufgknhTuA9jI1P
         gNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5se80LEa3tDQZzinpGCSpffAeIEgYnbhyqhZn3uUT4=;
        b=Sc0uG+cz+2DghKbmRUx/ud6ILbuTjagSBv70rWKWroY2mrQyqznMJjYwRMn6Tcyd+6
         A9SIQJrCPqfnY3jGVaUf226miSmJCegYQOgBpNi6FdzCtsebPO26912RlFY0+uK0rlgF
         /L89LRMEyc9+jEnDhQ8mS0tpRngw6OGdIUPoyEJnkSiBFc/VpEr3Yz5UzCtGMtHw52WA
         NfnSfW3Jy6FOdsVg5Yn1G8F6E15lADDOzOPfxTlgPJkRbCfnSgEs3qXH21uCCxXJ1Fv+
         WH+fdI30bvVI5mLthbyI1Uny0MZPBz9pktVpuB9fm6UvuxSxu++4jBlRyDAI0NWdpPcJ
         WOig==
X-Gm-Message-State: AOAM5316/zmx44eY/zOId/++e2tXQW4AALxm9/CIDETDezOsba9F6woR
        WfXKREk5emVedgrnQ4VcteAg1uL3YfaIvw==
X-Google-Smtp-Source: ABdhPJyHghOuht0muq4+THOBg8qkaLW2izvMYnjKbT+k3AsazD31gE/5aBd8OGiE5iipJzPEnkz7Aw==
X-Received: by 2002:adf:e552:0:b0:1ef:58cc:fd3c with SMTP id z18-20020adfe552000000b001ef58ccfd3cmr8195384wrm.264.1646657381966;
        Mon, 07 Mar 2022 04:49:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/15] rev-list simplify tests: don't ignore "git" exit code
Date:   Mon,  7 Mar 2022 13:49:06 +0100
Message-Id: <patch-v2-15.15-16889ed154f-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a fragile test pattern introduced in 65347030590 (Topo-sort
before --simplify-merges, 2008-08-03) to check the exit code of both
"git name-rev" and "git log".

This test as a whole would fail under SANITIZE=leak, but we'd pass
several "failing" tests due to hiding these exit codes before we'd
spot git dying with abort(). Now we'll instead spot all of the
failures.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6012-rev-list-simplify.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index 63fcccec32e..de1e87f1621 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -12,7 +12,9 @@ note () {
 }
 
 unnote () {
-	git name-rev --tags --annotate-stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
+	test_when_finished "rm -f tmp" &&
+	git name-rev --tags --annotate-stdin >tmp &&
+	sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g" <tmp
 }
 
 #
@@ -111,8 +113,8 @@ check_outcome () {
 	shift &&
 	param="$*" &&
 	test_expect_$outcome "log $param" '
-		git log --pretty="$FMT" --parents $param |
-		unnote >actual &&
+		git log --pretty="$FMT" --parents $param >out &&
+		unnote >actual <out &&
 		sed -e "s/^.*	\([^ ]*\) .*/\1/" >check <actual &&
 		test_cmp expect check
 	'
@@ -151,8 +153,8 @@ check_result 'L K I H G B' --exclude-first-parent-only --first-parent L ^F
 check_result 'E C B A' --full-history E -- lost
 test_expect_success 'full history simplification without parent' '
 	printf "%s\n" E C B A >expect &&
-	git log --pretty="$FMT" --full-history E -- lost |
-	unnote >actual &&
+	git log --pretty="$FMT" --full-history E -- lost >out &&
+	unnote >actual <out &&
 	sed -e "s/^.*	\([^ ]*\) .*/\1/" >check <actual &&
 	test_cmp expect check
 '
-- 
2.35.1.1242.gfeba0eae32b

