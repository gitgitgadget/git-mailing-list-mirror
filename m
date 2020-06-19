Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275CCC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029A021527
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lTYUe+ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404873AbgFSR44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39572 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393718AbgFSR4g (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9177E60A68;
        Fri, 19 Jun 2020 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589387;
        bh=Cok++fiK9k9qHlhEU7BdUjv5FBYoGOPqOeNammZJSgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lTYUe+otxBa8YS/d3+kMsYBzt47hkdXucAJOKfGh8z9vvNo4NXiSWEnjQ/BonbL2j
         b+L06KFiR8kp46uoQ2/tYFg+yiyAa6et62HsXeDDzibBjYlkFT6oXX0xE5cVXWC5ba
         7HDkrVjezaVKCCP3TaRPBVXorOFmu7zWKD51h0J4so5vE7Xzz/a012VhQtWro30pld
         oh740ImlvyGI/eyN3e/Cg6cgUST40ngAZg1F8mDN6i9zenO+gto+Cm2KUMi7Mi2F+G
         Sw+rBY0YwTLrQLhCSBIE48UCDYeHQZKzkCKJmEp2HJHZeRBL2PoqWrGKgse8lVgbF3
         Bzd/TQBkM07YB7xdErbfgUH4BATj9cXEVBywFjOxSAr1hLnrKD7HEzsF8wkKLuvhww
         PMhggf0vLJ7hjNY5ANGeWADetdBBHGQaigZZC8u2B+yfCopluWhOZ5pMWovHRwBYz5
         6ngCfF3IJwdinsU3wxQyqGIqk9VA+Lap43xeWLCQCWD+AIpppc0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 28/44] Documentation/technical: document object-format for protocol v2
Date:   Fri, 19 Jun 2020 17:55:45 +0000
Message-Id: <20200619175601.569856-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the object-format extension for protocol v2.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/technical/protocol-v2.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 3996d70891..b288df7ed7 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -455,3 +455,12 @@ included in a request.  This is done by sending each option as a
 a request.
 
 The provided options must not contain a NUL or LF character.
+
+ object-format
+~~~~~~~~~~~~~~~
+
+The server can advertise the `object-format` capability with a value `X` (in the
+form `object-format=X`) to notify the client that the server is able to deal
+with objects using hash algorithm X.  If not specified, the server is assumed to
+only handle SHA-1.  If the client would like to use a hash algorithm other than
+SHA-1, it should specify its object-format string.
