Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E96C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13FE218AC
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfLRT6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:58:41 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41123 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfLRT6e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:58:34 -0500
X-Originating-IP: 157.36.178.182
Received: from localhost.localdomain (unknown [157.36.178.182])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 23CF760002;
        Wed, 18 Dec 2019 19:58:30 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Vasili Novikov <vasilii.novikov@zivver.com>
Subject: [PATCH v2] git-gui: allow closing console window with Escape
Date:   Thu, 19 Dec 2019 01:28:09 +0530
Message-Id: <20191218195809.7658-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This gives users a quick shortcut to close the window. But since the
window can also show commands in progress, closing the window on Escape
can give the perception that the command has been cancelled even though
it hasn't been. So, only enable this binding when the command is done.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
Changes in v2:
- Only allow closing the window on Escape when the command is done.

 lib/console.tcl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/console.tcl b/lib/console.tcl
index 1f3248f..bb6b9c8 100644
--- a/lib/console.tcl
+++ b/lib/console.tcl
@@ -203,6 +203,8 @@ method done {ok} {
 			focus $w.ok
 		}
 	}
+
+	bind $w <Key-Escape> "destroy $w;break"
 }

 method _sb_set {sb orient first last} {
--
2.24.1

