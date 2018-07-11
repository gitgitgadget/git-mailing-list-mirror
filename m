Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD46B1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 08:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbeGKIlp (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 04:41:45 -0400
Received: from goliath.siemens.de ([192.35.17.28]:58754 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeGKIln (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 04:41:43 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w6B8cR7A025792
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 10:38:27 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6B8cQUC026123;
        Wed, 11 Jul 2018 10:38:27 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/2] gpg-interface: make parse_gpg_output static and remove from interface header
Date:   Wed, 11 Jul 2018 10:38:25 +0200
Message-Id: <b568214bffb7f2dcaf2495990c5a6b478863d157.1531298241.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <f9e371c8dd2a17ddb5fd5989a7fdad1c0d1bb6e7.1531298241.git.henning.schild@siemens.com>
References: <f9e371c8dd2a17ddb5fd5989a7fdad1c0d1bb6e7.1531298241.git.henning.schild@siemens.com>
In-Reply-To: <f9e371c8dd2a17ddb5fd5989a7fdad1c0d1bb6e7.1531298241.git.henning.schild@siemens.com>
References: <f9e371c8dd2a17ddb5fd5989a7fdad1c0d1bb6e7.1531298241.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn parse_gpg_output into a static function, the only outside user was
migrated in an earlier commit.

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

