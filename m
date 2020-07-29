Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D5C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3ADA2067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NZJkF9WQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgG2XPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41044 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728114AbgG2XPF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:05 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BA4FB6101E;
        Wed, 29 Jul 2020 23:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064503;
        bh=h47f+xSwvobYJ9HC1l12pEZyED1+cZGEjZ51kLW6H/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NZJkF9WQCBhmsRebDiK8XVV7mswz435DO/R259WgVbNiwLjGfgYQjZVY5dJZMsq1l
         j6uo654oGmJBrzsSpcpWF2yOzRX3+iEBqif7RtBTbxT6M2LtFx15MjA9R2ZAl8T9T+
         bZjEtriJAmykrYD1LCj11mIC8GeMMsdoRK1zvR0hzbmnvvGxJMQmH+BTxePMuHS5l+
         HzkX9Ny11BU9ExoYpRckwegstmUW+H2T7gofGNkDtgmmHCEATdUWmRlLAXUtl4DWye
         WqgmRrP5X78rofaMDlboYketo+6vW2yDV8GBxNBV/ZlQuwiYezdl3RB260NoRcyg+U
         ptSTbDQwlFU5Yzny/UUc7tt2Z2CEQpzh9xHRBaFI7B+ZzM+10AavTY0mmNzT2dPtgA
         WHKD953/F8luoM9vflDjDzR9sAoeZJ2XCzMU3VUqYM+LHGnjCRQsAx4jjt7XKGDVHy
         /Pmlgsbh9EjiC9bDGUiY6SYGuRveoTyuPQ4QNbC6SvUIZ4OOln/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 38/39] docs: add documentation for extensions.objectFormat
Date:   Wed, 29 Jul 2020 23:14:27 +0000
Message-Id: <20200729231428.3658647-39-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
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
