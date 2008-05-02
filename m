From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/7] pack-objects: simplify the condition associated with
 --all-progress
Date: Fri, 02 May 2008 15:11:47 -0400
Message-ID: <1209755511-7840-4-git-send-email-nico@cam.org>
References: <1209755511-7840-1-git-send-email-nico@cam.org>
 <1209755511-7840-2-git-send-email-nico@cam.org>
 <1209755511-7840-3-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:14:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js0hZ-00058j-CK
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 21:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936543AbYEBTMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 15:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbYEBTME
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 15:12:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28091 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936116AbYEBTL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 15:11:58 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K090074V9BRMJ70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 May 2008 15:11:53 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.226.g6f6e8
In-reply-to: <1209755511-7840-3-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81026>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index afbf3dd..b4a63d2 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -452,11 +452,10 @@ static void write_pack_file(void)
 	struct sha1file *f;
 	off_t offset, offset_one, last_obj_offset = 0;
 	struct pack_header hdr;
-	int do_progress = progress >> pack_to_stdout;
 	uint32_t nr_remaining = nr_result;
 	time_t last_mtime = 0;
 
-	if (do_progress)
+	if (progress > pack_to_stdout)
 		progress_state = start_progress("Writing objects", nr_result);
 	written_list = xmalloc(nr_objects * sizeof(*written_list));
 
-- 
1.5.5.1.226.g6f6e8
