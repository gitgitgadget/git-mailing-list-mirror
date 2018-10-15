Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4F81F453
	for <e@80x24.org>; Mon, 15 Oct 2018 02:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeJOKCR (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 06:02:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50698 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbeJOKCR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 06:02:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ABBDF61B74;
        Mon, 15 Oct 2018 02:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539569949;
        bh=pMSh5GhHdmwYQAF79JnH+4wpmDiVPDyl8zaacMmcuK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=b7iA2Z/sA7Ys81/a+LdTyq+c7VoZ+z8tm3/lCjtDV3+k8bYJaDRlMGcA855zcglTQ
         eG31Ubo/1buNCDjWq3joAiNngsbljxR3kXrPOkmItEmnU6m0FjYQEn98xkXL3v6byo
         DhmtrrNoMGw6WvmUrjd1XgAKk1b+Za8nrKgDNYAmNSn2ZDr6mpk0Sj6ZSECkXcKwwP
         toz68s+8rLuD347Hha2RrXrTZW/xUhd3rLiBaSjD0oVfc+0Li9CPNucAALzajt4842
         8K2MxtJbtxbV0+j2LqjQ9C9wXsr8+ikynyWoyzBFDFQwu3Vb7EAC8F2eEpmQYNvFD/
         tfHhvxOK3Ghbna2J/9DawKC/TC4f5uqMKKnEKMuZNX9PsE9Lgxvt/bj0NIWk3sVWYo
         Megfak9qmYKwOHUFJaVt1JB39DGrpC9QyTBHdQmrGakEQ49kygWRl82ryR7fjrfinb
         6ODxM/SoeBz1dzUADfD5cmZdx7piPxNETvPlSIeRDenLmex763h
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/13] sha1-file: rename algorithm to "sha1"
Date:   Mon, 15 Oct 2018 02:18:48 +0000
Message-Id: <20181015021900.1030041-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The transition plan anticipates us using a syntax such as "^{sha1}" for
disambiguation.  Since this is a syntax some people will be typing a
lot, it makes sense to provide a short, easy-to-type syntax.  Omitting
the dash doesn't create any ambiguity, but it does make it shorter and
easier to type, especially for touch typists.  In addition, the
transition plan already uses "sha1" in this context.

Rename the name of SHA-1 implementation to "sha1".

Note that this change creates no backwards compatibility concerns, since
we haven't yet used this field in any serialized data formats.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1-file.c b/sha1-file.c
index a4367b8f04..e29825f259 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -97,7 +97,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		NULL,
 	},
 	{
-		"sha-1",
+		"sha1",
 		/* "sha1", big-endian */
 		0x73686131,
 		GIT_SHA1_RAWSZ,
