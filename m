Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3767C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 17:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiLNRmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 12:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiLNRmf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 12:42:35 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B628E2E
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 09:42:31 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A1D85C00A2;
        Wed, 14 Dec 2022 12:42:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 14 Dec 2022 12:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jpgrayson.net;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671039749; x=1671126149; bh=5mPUs6keIt
        KcfjnsXCMEaB4udROrkjzDkTxcWQQFTFI=; b=IKJehQmSdzbGRJl89PoCwLshfp
        /8MklzSpGwFIplhB/cjgDVwdB+IvUY/r+mWMOBUk4UAGaAQg6EdBRftW1y9nA7kB
        x4EGsWLdvBvP3Lq6uNTZxjl3axEu0BYUuCfd7j2Cxd/s4aZeO+r/7ksOUEVHFMaB
        EgXvjiUlrP0ai0feEtTuQu/Cqt3uKN0BGF2R8e34SPZZ/2juf3BOxKTJIRo1VPkk
        GWurwaV6s1Ctlldlk84mePTelYOd/mhk11Z7KFSFC6IXfx/FIlFqWcfsHLLnauVK
        AyxAZhUAPdAA7qegpwZBUmzelmEf8GfePEOERHiE4t0S9crstv6GFQcpAabw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1671039749; x=1671126149; bh=5mPUs6keItKcfjnsXCMEaB4udROrkjzDkTx
        cWQQFTFI=; b=WVuv5Qw2n7NCw9sFgCRwvuwzQ/13xm5jceMxzY2VJ8s62FJBsnS
        eKlLYcQI9sABFqH1vgrZu8pwbID3ka5mFJU39BvlvFT1gGeuxZZIOETKJO4vW2Qy
        VSmDkWU6YGZsICLJ1Yzish2xKSgPwrxxPg3OxWcU8wH1a7oOyLBbLhxbBSKhEnYk
        eyoXoCqogyso0XZm0BpNZMnqgqSlYzsB8RHT98LErU80DwYvXRYeG18P/Qak/pjY
        XUoTZtYicis1YO7By+Hv3yNfs4Zc354AhXkhiv3h324jjTmPITUmOLOEiazNG/qZ
        HEnlO/SzSoRMFHjbglVIiIWr2qZQd1j9yxg==
X-ME-Sender: <xms:BAuaY493auAeSDJukpr_m1DFQIUZSMgCpXF4d5PGvpIh9pPvyBSK4g>
    <xme:BAuaYwt-ibaZ_Tq7Pc9VWXqc51XfwyhWU8YLFPnLZgoqKM-hdENHZrJKEMOlpypIU
    84NlxQO8_Vfqf1PUIw>
X-ME-Received: <xmr:BAuaY-DkTPNSodR8qfAYbmDb7wprLf03v6E50nuyLr0k6ibePjt_alJpgRHizAkJ8uuECZNc7LJngxGFI59Ex1zY0xktemFpzSC5KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefrvghtvghrucfirhgrhihsohhnuceophgvthgvsehjphhgrhgr
    hihsohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeffjeevtdevjeeigefhvddtfeefue
    egtdekkedtleefudfgvdeitdduvdekgeelveenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehpvghtvgesjhhpghhrrgihshhonhdrnhgvth
X-ME-Proxy: <xmx:BAuaY4cfwjCe0r9_HumE-2xLAnB6JTmZDTTUEyH9EcFIlwNhFtiTIQ>
    <xmx:BAuaY9N6songSw5pACgfRAn4EuQ2piz5Scl5eex4ukrY_YRdv5JBZQ>
    <xmx:BAuaYyl6wrCohzbDJvQDSiuDQQu-wErgSXs621NYgVee5HWck1q0ZA>
    <xmx:BQuaY_W9vXsYsxMR8zfiQPaZGawEo9sWqUYqusyjH8NRBtrfK4RkYw>
Feedback-ID: iefe944c0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Dec 2022 12:42:28 -0500 (EST)
From:   Peter Grayson <pete@jpgrayson.net>
To:     git@vger.kernel.org
Cc:     Peter Grayson <pete@jpgrayson.net>
Subject: [PATCH] diff: fix regression with --stat and unmerged file
Date:   Wed, 14 Dec 2022 12:41:51 -0500
Message-Id: <20221214174150.404821-1-pete@jpgrayson.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A regression was introduced in

12fc4ad89e (diff.c: use utf8_strwidth() to count display width, 2022-09-14)

that causes missing newlines after "Unmerged" entries in `git diff --cached
--stat` output.

This problem affects v2.39.0-rc0 through v2.39.0.

This patch adds the missing newline along with a new test to cover this
behavior.

Signed-off-by: Peter Grayson <pete@jpgrayson.net>
---
 diff.c                   |  2 +-
 t/t4046-diff-unmerged.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 1054a4b732..85f035a9e8 100644
--- a/diff.c
+++ b/diff.c
@@ -2801,7 +2801,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		else if (file->is_unmerged) {
 			strbuf_addf(&out, " %s%s%*s | %*s",
 				    prefix, name, padding, "",
-				    number_width, "Unmerged");
+				    number_width, "Unmerged\n");
 			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
 					 out.buf, out.len, 0);
 			strbuf_reset(&out);
diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index 0ae0cd3a52..ffaf69335f 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -86,4 +86,14 @@ test_expect_success 'diff-files -3' '
 	test_cmp diff-files-3.expect diff-files-3.actual
 '
 
+test_expect_success 'diff --stat' '
+	for path in $paths
+	do
+		echo " $path | Unmerged" || return 1
+	done >diff-stat.expect &&
+	echo " 0 files changed" >>diff-stat.expect &&
+	git diff --cached --stat >diff-stat.actual &&
+	test_cmp diff-stat.expect diff-stat.actual
+'
+
 test_done
-- 
2.39.0

