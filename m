Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF8C433F8
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356E0206F4
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vWB01kqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgGMCtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40684 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728612AbgGMCtp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CEE2260A62;
        Mon, 13 Jul 2020 02:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608582;
        bh=Lh1WlwvkzZkI88VSlSbSJOOPCkrrbx+hx4fkO3L6Xhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vWB01kqt/mxzTwqc8Iw0WQAfuistAGM//BOFVzehgKj58bY7AxDvTINpzT4Mrw6fD
         FcQMbgeWnMtfaMf6TY5GKTUpah3jhusN39osnimfJW7OFXKSNpegahwfE743a+fMD1
         7aJ270vsKT+/kHmMdYmG3a+ByzZ8bvV1QFaNb/iKs7/nHFpsJo4l6giymzXjRakIwI
         XEyK100N2ZEn4o4BgJYaItGMTMn9JOg5/1/cj84OVU1j9MMBq8cKUhq5XqVD/mRJUp
         ErgA0IcE2I8nwDCWVPuicoPOsUlMAJxZ+f6hKiwOykGv1IwRXDYaGvtyST5Vs4yH6x
         TkmEeKix0x5Mj0aKWK1z7xLgd1DxG6imEH5/QsQgI78ECkXXacq7D3MbgimnVGblEh
         RSxHKCs2+6CuLm0h9ADye2wZKSUS5S+eDEMoRyW27QXnYjNZEb28u8RwOQGcldqf56
         rjFJCLS3AyUgO8/gkUyfSB+HS8xQEwRBxVxPeE5v0+SiLm+D2rZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 38/39] docs: add documentation for extensions.objectFormat
Date:   Mon, 13 Jul 2020 02:49:08 +0000
Message-Id: <20200713024909.3714837-39-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
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
 Documentation/config/extensions.txt | 9 +++++++++
 2 files changed, 11 insertions(+)
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
index 0000000000..8baf23298c
--- /dev/null
+++ b/Documentation/config/extensions.txt
@@ -0,0 +1,9 @@
+extensions.objectFormat::
+	Specify the hash algorithm to use.  The acceptable values are `sha1` and
+	`sha256`.  If not specified, `sha1` is assumed.  As with other keys under
+	the `extensions` hierarchy, this value is ignored and has no effect unless
+	`core.repositoryformatversion` is 1.
++
+Note that this setting should only be set by linkgit:git-init[1] or
+linkgit:git-clone[1].  Trying to change it after initialization will not
+work and will produce hard-to-diagnose issues.
