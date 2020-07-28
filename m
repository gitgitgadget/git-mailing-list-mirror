Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35089C433FC
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123E32075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zM2aTEsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgG1XfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40862 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730243AbgG1XfO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F1D3B61022;
        Tue, 28 Jul 2020 23:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979312;
        bh=h47f+xSwvobYJ9HC1l12pEZyED1+cZGEjZ51kLW6H/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zM2aTEshrfafvzV2sqKnkiPVemHKzRBJyGVhZqVK5zFDO5sRqX8bCdHKl6Xj3Nqxw
         FP2tE+UiYaIV7JzrcTHKXpx9loAmIFiIBNLC7OHlwEiI3TZ2kvbCBqsPdKRZ5uCHb2
         EFK+xT92xBrF9zSwIg5Wm9t2+FIQvbBxlpradHlrm5qtDselAL1DkHwV50eMa2AXl5
         m2RkTAwbAeRc7as4oQgh4BBxsVB+KZS/YAdLyp6p4/JLVKrSbh+FkHSq4rTXXuJAQj
         cMgY33wYd7DkD4wsWnrWOCMBV4p+07FeKSilARDrx5e43cYmPdFBCFri+TGtdSsh3c
         CFgbwKTqirkwoprQIVuw5Mf5YjMERqu0NQfog0ycqmyRatPFZUG8lW9SY6pSqWeduY
         fGTZJSlKXvDBtAYlGqr7ATsY0Rr3RbhgZMU+wqzjM7PTY7G2HjnLqpWgKaS5+aP7zg
         Boe//RUFTR0V1BWmcsOMmPPCYlAWY/0BzI/SkYpw5+KqLCLHrcN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 38/39] docs: add documentation for extensions.objectFormat
Date:   Tue, 28 Jul 2020 23:34:45 +0000
Message-Id: <20200728233446.3066485-39-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the extensions.objectFormat config setting.  Warn users not to
modify it themselves.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config.txt            | 2 ++
 Documentation/config/extensions.txt | 8 ++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/config/extensions.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ef0768b91a..3042d80978 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -348,6 +348,8 @@ include::config/diff.txt[]
 
 include::config/difftool.txt[]
 
+include::config/extensions.txt[]
+
 include::config/fastimport.txt[]
 
 include::config/feature.txt[]
diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
new file mode 100644
index 0000000000..4e23d73cdc
--- /dev/null
+++ b/Documentation/config/extensions.txt
@@ -0,0 +1,8 @@
+extensions.objectFormat::
+	Specify the hash algorithm to use.  The acceptable values are `sha1` and
+	`sha256`.  If not specified, `sha1` is assumed.  It is an error to specify
+	this key unless `core.repositoryFormatVersion` is 1.
++
+Note that this setting should only be set by linkgit:git-init[1] or
+linkgit:git-clone[1].  Trying to change it after initialization will not
+work and will produce hard-to-diagnose issues.
