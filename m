From: Robert de Bath <rdebath@tvisiontech.co.uk>
Subject: [PATCH] Expand on impact of threads on memory consumption.
Date: Fri, 24 Oct 2014 08:43:27 +0100
Message-ID: <1414136607-24765-1-git-send-email-rdebath@tvisiontech.co.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	Robert de Bath <rdebath@tvisiontech.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 10:12:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhZzM-00026h-8K
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 10:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbaJXIMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 04:12:40 -0400
Received: from mail.tvisiontech.co.uk ([81.143.168.209]:32939 "EHLO
	mail.tvisiontech.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212AbaJXILx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 04:11:53 -0400
X-Greylist: delayed 1695 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Oct 2014 04:11:53 EDT
Received: from mail by mail.tvisiontech.co.uk with filter-scanned (Exim 4.72 #1 (Debian))
	id 1XhZX4-0003f9-SL; Fri, 24 Oct 2014 08:43:34 +0100
Received: from mayday (mail.debath.co.uk) [192.168.139.10]:37370 
	by mail.tvisiontech.co.uk with esmtp (Exim 4.72 #1 (Debian))
	id 1XhZX4-0003f5-ML; Fri, 24 Oct 2014 08:43:34 +0100
Received: from robert by mail.debath.co.uk with local (Exim 4.80)
	id 1XhZX4-0006S9-Dn
	addr local; Fri, 24 Oct 2014 08:43:34 +0100
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It took me a long time to notice the rider on the pack.threads
configuration option that it would multiple the memory consumption by
the number of CPUs in the machine. This patch puts the memory consumption
warning against the memory option that I was using to try to stop git-pack
running out of RAM.

Signed-off-by: Robert de Bath <rdebath@tvisiontech.co.uk>
---
 Documentation/config.txt |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c55c22a..6384038 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1828,7 +1828,10 @@ pack.depth::
 
 pack.windowMemory::
 	The window memory size limit used by linkgit:git-pack-objects[1]
-	when no limit is given on the command line.  The value can be
+	when no limit is given on the command line.  This limit may be
+	allocated individually by each thread doing delta compression
+	so the total memory allocated by linkgit:git-pack-objects[1] can
+	be this multiplied by the number of threads.  The value can be
 	suffixed with "k", "m", or "g".  Defaults to 0, meaning no
 	limit.
 
-- 
1.7.10.4
