From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] restore fetching with thin-pack capability
Date: Wed, 07 Nov 2007 17:20:22 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711071712270.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:32:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IptS9-0000EY-6s
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778AbXKGWca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757373AbXKGWca
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:32:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25330 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412AbXKGWc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:32:29 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR5003V8Q1Y2AT0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Nov 2007 17:20:28 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63879>

Broken since commit fa74052922cf39e5a39ad7178d1b13c2da9b4519.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 862652b..bb1742f 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -32,7 +32,7 @@ static const char fetch_pack_usage[] =
 #define MAX_IN_VAIN 256
 
 static struct commit_list *rev_list;
-static int non_common_revs, multi_ack, use_thin_pack, use_sideband;
+static int non_common_revs, multi_ack, use_sideband;
 
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -178,7 +178,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 				     (multi_ack ? " multi_ack" : ""),
 				     (use_sideband == 2 ? " side-band-64k" : ""),
 				     (use_sideband == 1 ? " side-band" : ""),
-				     (use_thin_pack ? " thin-pack" : ""),
+				     (args.use_thin_pack ? " thin-pack" : ""),
 				     (args.no_progress ? " no-progress" : ""),
 				     " ofs-delta");
 		else
