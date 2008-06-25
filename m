From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack.indexversion config option now defaults to 2
Date: Wed, 25 Jun 2008 00:25:53 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806250025130.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:26:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBMao-0007Oh-4F
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 06:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbYFYEZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 00:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbYFYEZy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:25:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50184 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbYFYEZx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 00:25:53 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3000EAP4B59OG0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Jun 2008 00:25:53 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86218>


As announced for 1.6.0.

Git older than version 1.5.2 (or any other git version with this option
set to 1) may revert to version 1 of the pack index by manually deleting
all .idx files and recreating them using 'git index-pack'.  Communication
over the git native protocol is unaffected since the pack index is never
transferred.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Documentation/config.txt |    6 +++---
 pack-write.c             |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c7fbc63..f72dd47 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -937,9 +937,9 @@ pack.indexVersion::
 	legacy pack index used by Git versions prior to 1.5.2, and 2 for
 	the new pack index with capabilities for packs larger than 4 GB
 	as well as proper protection against the repacking of corrupted
-	packs.  Version 2 is selected and this config option ignored
-	whenever the corresponding pack is larger than 2 GB.  Otherwise
-	the default is 1.
+	packs.  Version 2 is the default.  Note that version 2 is enforced
+	and this config option ignored whenever the corresponding pack is
+	larger than 2 GB.
 
 pack.packSizeLimit::
 	The default maximum size of a pack.  This setting only affects
diff --git a/pack-write.c b/pack-write.c
index f52cabe..a8f0269 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -2,7 +2,7 @@
 #include "pack.h"
 #include "csum-file.h"
 
-uint32_t pack_idx_default_version = 1;
+uint32_t pack_idx_default_version = 2;
 uint32_t pack_idx_off32_limit = 0x7fffffff;
 
 static int sha1_compare(const void *_a, const void *_b)
-- 
1.5.6.56.g29b0d
