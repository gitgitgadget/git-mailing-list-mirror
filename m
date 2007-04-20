From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack-objects: remove obsolete comments
Date: Thu, 19 Apr 2007 22:28:02 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704192225120.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 04:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeirE-0000PS-OD
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 04:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbXDTC2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 22:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbXDTC2G
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 22:28:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28366 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348AbXDTC2D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 22:28:03 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGR00KLEYUQ7TD0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 Apr 2007 22:28:03 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45058>

The sorted-by-sha ans sorted-by-type arrays are no more.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 19fae4c..c72e07a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -49,22 +49,15 @@ struct object_entry {
  * expanded).  nr_objects & nr_alloc controls this array.  They are stored
  * in the order we see -- typically rev-list --objects order that gives us
  * nice "minimum seek" order.
- *
- * sorted-by-sha ans sorted-by-type are arrays of pointers that point at
- * elements in the objects array.  The former is used to build the pack
- * index (lists object names in the ascending order to help offset lookup),
- * and the latter is used to group similar things together by try_delta()
- * heuristics.
  */
+static struct object_entry *objects;
+static uint32_t nr_objects, nr_alloc, nr_result;
 
 static int non_empty;
 static int no_reuse_delta;
 static int local;
 static int incremental;
 static int allow_ofs_delta;
-
-static struct object_entry *objects;
-static uint32_t nr_objects, nr_alloc, nr_result;
 static const char *pack_tmp_name, *idx_tmp_name;
 static char tmpname[PATH_MAX];
 static unsigned char pack_file_sha1[20];
@@ -76,8 +69,7 @@ static int num_preferred_base;
 
 /*
  * The object names in objects array are hashed with this hashtable,
- * to help looking up the entry by object name.  Binary search from
- * sorted_by_sha is also possible but this was easier to code and faster.
+ * to help looking up the entry by object name.
  * This hashtable is built after all the objects are seen.
  */
 static int *object_ix;
