From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/6] pack-objects: no delta possible with only one object in
 the list
Date: Tue, 16 Oct 2007 21:55:47 -0400
Message-ID: <1192586150-13743-4-git-send-email-nico@cam.org>
References: <1192586150-13743-1-git-send-email-nico@cam.org>
 <1192586150-13743-2-git-send-email-nico@cam.org>
 <1192586150-13743-3-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:56:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihy9R-0003Wi-LZ
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935757AbXJQB4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936190AbXJQB4A
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:56:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8510 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936200AbXJQBz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:55:56 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ10063X9D2E630@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 21:55:53 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1212.gdb015
In-reply-to: <1192586150-13743-3-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61311>

... so don't even try in that case, and save another useless line of
progress display.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index df69abd..d729cb7 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1714,7 +1714,7 @@ static void prepare_pack(int window, int depth)
 		delta_list[n++] = entry;
 	}
 
-	if (nr_deltas) {
+	if (nr_deltas && n > 1) {
 		unsigned nr_done = 0;
 		if (progress)
 			start_progress(&progress_state, "Deltifying objects",
-- 
1.5.3.4.1212.gdb015
