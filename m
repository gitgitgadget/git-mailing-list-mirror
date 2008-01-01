From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] Let transport.c use git without a dash
Date: Tue,  1 Jan 2008 20:39:35 +0100
Message-ID: <1199216375-22161-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 01 20:40:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9my5-0007bZ-HY
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 20:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbYAATjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 14:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbYAATjj
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 14:39:39 -0500
Received: from smtp-1.orange.nl ([193.252.22.241]:63643 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629AbYAATji (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 14:39:38 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6009.orange.nl (SMTP Server) with ESMTP id CB7E3700008D
	for <git@vger.kernel.org>; Tue,  1 Jan 2008 20:39:36 +0100 (CET)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6009.orange.nl (SMTP Server) with ESMTP id 3E6087000081;
	Tue,  1 Jan 2008 20:39:36 +0100 (CET)
X-ME-UUID: 20080101193936255.3E6087000081@mwinf6009.orange.nl
X-Mailer: git-send-email 1.5.4.rc2.3.gbe5a8-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69442>

This fixes transport.c by using "git upload-pack" and "git receive pack".
Using the old dashed form, git fetch would fail on a remote installation where
the git binaries are installed in a separate dir
---

I think this might have been on the list before, but then it was never applied
to master. git fetch fails when you have used make gitexecdir=/somewhereelse
on the remote side, as it can't find git-upload-pack.


 transport.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 4e151a9..ad4c7e0 100644
--- a/transport.c
+++ b/transport.c
@@ -721,10 +721,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->disconnect = disconnect_git;
 
 		data->thin = 1;
-		data->uploadpack = "git-upload-pack";
+		data->uploadpack = "git upload-pack";
 		if (remote && remote->uploadpack)
 			data->uploadpack = remote->uploadpack;
-		data->receivepack = "git-receive-pack";
+		data->receivepack = "git receive-pack";
 		if (remote && remote->receivepack)
 			data->receivepack = remote->receivepack;
 	}
-- 
1.5.4.rc2.3.gbe5a8-dirty
