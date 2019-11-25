Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA251C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 20:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40FF2075C
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 20:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfKYUpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:45:08 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:19787 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfKYUpI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 15:45:08 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2019 15:45:07 EST
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id ED3CC9FA21
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 20:37:43 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47MJkb5Csqz3QdR;
        Mon, 25 Nov 2019 20:37:43 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id 922AC14E92; Mon, 25 Nov 2019 20:37:43 +0000 (UTC)
From:   Ed Maste <emaste@freefall.freebsd.org>
To:     git@vger.kernel.org
Cc:     Ed Maste <emaste@freebsd.org>
Subject: [PATCH] ci: add Cirrus-CI config for FreeBSD CI
Date:   Mon, 25 Nov 2019 20:37:40 +0000
Message-Id: <20191125203740.72249-1-emaste@freefall.freebsd.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ed Maste <emaste@freebsd.org>

Cirrus-CI is relatively unique among hosted CI providers in supporting
FreeBSD (in addition to Linux, Windows, and macOS).  Add a Cirrus-CI
config to facilitate building and testing on FreeBSD.

Signed-off-by: Ed Maste <emaste@freebsd.org>
---
6 i18n tests are currently failing and need investigation.
Example result: https://cirrus-ci.com/task/5394512637067264
Test log: https://api.cirrus-ci.com/v1/task/5394512637067264/logs/test.log

 .cirrus.yml | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 .cirrus.yml

diff --git a/.cirrus.yml b/.cirrus.yml
new file mode 100644
index 0000000000..47d871ded5
--- /dev/null
+++ b/.cirrus.yml
@@ -0,0 +1,12 @@
+env:
+  CIRRUS_CLONE_DEPTH: 1
+
+freebsd_12_task:
+  freebsd_instance:
+    image: freebsd-12-1-release-amd64
+  install_script:
+    pkg install -y gettext gmake perl5
+  build_script:
+    - gmake
+  test_script:
+    - gmake test
-- 
2.24.0

