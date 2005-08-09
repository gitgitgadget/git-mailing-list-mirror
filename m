From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Warning fix for gcc 4
Date: Tue, 09 Aug 2005 16:54:40 -0400
Message-ID: <1123620880.24295.17.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 09 22:55:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2b7X-0006aF-4z
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 22:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVHIUyo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 16:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVHIUyo
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 16:54:44 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:149 "EHLO fencepost.gnu.org")
	by vger.kernel.org with ESMTP id S964959AbVHIUyn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 16:54:43 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E2b5R-0002rS-Om
	for git@vger.kernel.org; Tue, 09 Aug 2005 16:52:37 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E2b7R-00023n-E3
	for git@vger.kernel.org; Tue, 09 Aug 2005 16:54:41 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j79KseA9007920
	for git@vger.kernel.org; Tue, 9 Aug 2005 16:54:40 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

This patch fixes the only warning reported by gcc 4.0.1 on Fedora Core 4
for x86_64:

sha1_file.c:1391: warning: pointer targets in assignment differ in
signedness

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1388,7 +1388,7 @@ int write_sha1_from_fd(const unsigned ch
 		ssize_t size;
 		if (*bufposn) {
 			stream.avail_in = *bufposn;
-			stream.next_in = buffer;
+			stream.next_in = (unsigned char *) buffer;
 			do {
 				stream.next_out = discard;
 				stream.avail_out = sizeof(discard);


-- 
Regards,
Pavel Roskin
