Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8AB1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 12:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeGCMil (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 08:38:41 -0400
Received: from thoth.sbs.de ([192.35.17.2]:39897 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752990AbeGCMij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 08:38:39 -0400
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w63CcN9u014627
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 14:38:23 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id w63CcME5008580;
        Tue, 3 Jul 2018 14:38:23 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/8] gpg-interface: make parse_gpg_output static and remove from interface header
Date:   Tue,  3 Jul 2018 14:38:14 +0200
Message-Id: <192cf9fc4e7a601d2639ec2d82c777d4c7b26e99.1530616446.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit turns parse_gpg_output into an internal function, the only
outside user was migrated in an earlier commit.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 gpg-interface.c | 2 +-
 gpg-interface.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 0647bd634..09ddfbc26 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -35,7 +35,7 @@ static struct {
 	{ 'R', "\n[GNUPG:] REVKEYSIG "},
 };
 
-void parse_gpg_output(struct signature_check *sigc)
+static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
 	int i;
diff --git a/gpg-interface.h b/gpg-interface.h
index a5e6517ae..5ecff4aa0 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -33,8 +33,6 @@ void signature_check_clear(struct signature_check *sigc);
  */
 size_t parse_signature(const char *buf, size_t size);
 
-void parse_gpg_output(struct signature_check *);
-
 /*
  * Create a detached signature for the contents of "buffer" and append
  * it after "signature"; "buffer" and "signature" can be the same
-- 
2.16.4

