Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 28318 invoked by uid 107); 28 Feb 2010 13:29:33 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 28 Feb 2010 08:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab0B1N3J (ORCPT <rfc822;peff@peff.net>);
	Sun, 28 Feb 2010 08:29:09 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:52262 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab0B1N3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 08:29:08 -0500
Received: from [79.210.50.103] (helo=stokes.schwinge.homeip.net)
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <thomas@dirichlet.schwinge.homeip.net>)
	id 1NljCk-0005Qu-Bl
	for git@vger.kernel.org; Sun, 28 Feb 2010 14:29:06 +0100
Received: (qmail 969 invoked from network); 28 Feb 2010 13:28:38 -0000
Received: from dslb-084-057-207-194.pools.arcor-ip.net (84.57.207.194)
  by stokes.schwinge.homeip.net with QMQP; 28 Feb 2010 13:28:38 -0000
Received: (nullmailer pid 28014 invoked by uid 1000);
	Sun, 28 Feb 2010 13:28:38 -0000
From:	Thomas Schwinge <thomas@schwinge.name>
To:	u.kleine-koenig@pengutronix.de
Cc:	Thomas Schwinge <thomas@schwinge.name>, git@vger.kernel.org
Subject: [PATCH] README: Sketch out what tg rename OLD NEW would do.
Date:	Sun, 28 Feb 2010 14:28:38 +0100
Message-Id: <1267363718-27990-1-git-send-email-thomas@schwinge.name>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <20100228101320.GA13987@pengutronix.de>
References: <20100228101320.GA13987@pengutronix.de>
To:	u.kleine-koenig@pengutronix.de
X-Df-Sender: thomas@schwinge.name
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

... as proposed by me and acknowledged by David Bremner and Uwe Kleine-König on
2010-01-27 in #topgit (freenode).

Signed-off-by: Thomas Schwinge <thomas@schwinge.name>

---
 README |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/README b/README
index 495c70b..a0c1bfa 100644
--- a/README
+++ b/README
@@ -486,7 +486,23 @@ tg push
 	repository.  By default the remote gets all dependencies
 	(both tgish and non-tgish) and bases pushed to.
 
-TODO: tg rename
+tg rename
+~~~~~~~~~
+	There is no such command yet, but here's a receipe what ``tg rename OLD
+	NEW'' would do:
+
+	  - Have a clean state before beginning.
+	  - Assert NEW doesn't already exist.
+	  - git branch -m OLD NEW
+	  - git update-ref refs/top-bases/NEW refs/top-bases/OLD ''
+	  - for BRANCH in (all branches that depend on OLD,
+			   i.e. reference OLD in .topdeps); do
+	      git checkout BRANCH
+	      sed -i 's%^OLD$%NEW$' .topdeps
+	      git commit -m 'OLD -> NEW' .topdeps
+	    done
+	  - tg summary
+	  - tg update as appropriate
 
 
 IMPLEMENTATION
-- 
tg: (341a371..) t/tg_rename (depends on: master)
