From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] t5300: improve SHA1 collision test
Date: Tue, 02 Sep 2008 10:22:22 -0400
Message-ID: <1220365342-21308-3-git-send-email-nico@cam.org>
References: <1220365342-21308-1-git-send-email-nico@cam.org>
 <1220365342-21308-2-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 16:24:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaWo2-0006md-7B
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 16:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbYIBOWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 10:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbYIBOWl
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 10:22:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46761 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbYIBOWk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 10:22:40 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6K00ILVNXAG9W9@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Sep 2008 10:22:23 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.276.g59b81
In-reply-to: <1220365342-21308-2-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94675>

Make sure the reason for the command failure is actually due to
the detection of SHA1 collision.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 t/t5300-pack-object.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 83abe5f..8a8b0f1 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -272,7 +272,8 @@ test_expect_success \
 
 test_expect_success \
     'make sure index-pack detects the SHA1 collision' \
-    'test_must_fail git-index-pack -o bad.idx test-3.pack'
+    'test_must_fail git-index-pack -o bad.idx test-3.pack 2>msg &&
+     grep "SHA1 COLLISION FOUND" msg'
 
 test_expect_success \
     'honor pack.packSizeLimit' \
-- 
1.6.0.1.276.g59b81
