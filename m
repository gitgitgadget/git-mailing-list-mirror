From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [Squash PATCH] fprintf(stderr, "Warning...") -> warning("...")
Date: Thu, 24 Dec 2009 12:41:19 +0200
Message-ID: <1261651279-29041-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 11:48:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNlEn-00053F-8g
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 11:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbZLXKlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 05:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbZLXKlX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 05:41:23 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:59000 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbZLXKlX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 05:41:23 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 84A22C8005
	for <git@vger.kernel.org>; Thu, 24 Dec 2009 12:41:21 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0244C81536; Thu, 24 Dec 2009 12:41:21 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 7972C158A87
	for <git@vger.kernel.org>; Thu, 24 Dec 2009 12:41:20 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135651>

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

This fixes the small nit about fprintf(stderr, "Warning: ") by using
warning() API. 

It can be appiled on top of "Support remote helpers implementing smart
transports" or squashed to it.

diff --git a/transport-helper.c b/transport-helper.c
index 55427df..8c8ca8e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -420,11 +420,10 @@ static int process_connect_service(struct transport *transport,
 	if (strcmp(name, exec)) {
 		r = set_helper_option(transport, "servpath", exec);
 		if (r > 0)
-			fprintf(stderr, "Warning: Setting remote service path "
-				"not supported by protocol.\n");
+			warning("Setting remote service path not supported "
+				"by protocol.\n");
 		else if (r < 0)
-			fprintf(stderr, "Warning: Invalid remote service "
-				"path.\n");
+			warning("Invalid remote service path.\n");
 	}
 
 	if (data->connect)
-- 
1.6.6.3.gaa2e1
