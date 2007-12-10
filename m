From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/5] Remove a CURLOPT_HTTPHEADER (un)setting
Date: Mon, 10 Dec 2007 22:36:08 +0100
Message-ID: <1197322571-25023-2-git-send-email-mh@glandium.org>
References: <1197322571-25023-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 22:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1qIr-0003Jj-HY
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 22:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310AbXLJVgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 16:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753954AbXLJVgU
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 16:36:20 -0500
Received: from smtp19.orange.fr ([80.12.242.17]:48689 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753810AbXLJVgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 16:36:14 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1912.orange.fr (SMTP Server) with ESMTP id 916E71C000EC
	for <git@vger.kernel.org>; Mon, 10 Dec 2007 22:36:12 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf1912.orange.fr (SMTP Server) with ESMTP id 60DD71C000C3;
	Mon, 10 Dec 2007 22:36:12 +0100 (CET)
X-ME-UUID: 20071210213612396.60DD71C000C3@mwinf1912.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1qIN-0006Vw-Uq; Mon, 10 Dec 2007 22:36:12 +0100
X-Mailer: git-send-email 1.5.3.7.1159.gdd4a4-dirty
In-Reply-To: <1197322571-25023-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67760>

Setting CURLOPT_HTTPHEADER doesn't add HTTP headers, but replaces whatever
set of headers was configured before, so setting to NULL doesn't have any
magic meaning, and is pretty much useless when setting to another list
right after.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 2d0b46d..784b93e 100644
--- a/http.c
+++ b/http.c
@@ -364,7 +364,6 @@ struct active_request_slot *get_active_slot(void)
 	slot->finished = NULL;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
-- 
1.5.3.7.1159.gdd4a4
