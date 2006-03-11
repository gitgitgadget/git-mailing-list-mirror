From: "Art Haas" <ahaas@airmail.net>
Subject: [PATCH] Trivial warning fix for imap-send.c
Date: Sat, 11 Mar 2006 13:29:54 -0600
Message-ID: <20060311192954.GQ16135@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 11 20:29:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FI9lx-0002Tp-62
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 20:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWCKT2q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 14:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWCKT2q
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 14:28:46 -0500
Received: from 8f.7b.d1c4.cidr.airmail.net ([209.196.123.143]:6671 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S1751112AbWCKT2p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Mar 2006 14:28:45 -0500
Received: from cpe-24-28-121-130.houston.res.rr.com ([24.28.121.130] helo=pcdebian)
	by covert.iadfw.net with esmtp (Exim 4.24)
	id 1FI9q7-0002iK-6J
	for git@vger.kernel.org; Sat, 11 Mar 2006 13:33:23 -0600
Received: (qmail 4308 invoked by uid 1000); 11 Mar 2006 19:29:54 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17504>

Hi.

After my 'git' repo this morning and building I noticed a GCC warning
about a missing sentinel in this file. A scan of the libc docs says
that execl() needs to end with a terminating NULL, as the miniscule
change below does, and recompliation with GCC removed the warning.

Art Haas

Signed-off-by: Art Haas <ahaas@airmail.net>

diff --git a/imap-send.c b/imap-send.c
index fddaac0..203284d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -945,7 +945,7 @@ imap_open_store( imap_server_conf_t *srv
 				_exit( 127 );
 			close( a[0] );
 			close( a[1] );
-			execl( "/bin/sh", "sh", "-c", srvc->tunnel, 0 );
+			execl( "/bin/sh", "sh", "-c", srvc->tunnel, NULL );
 			_exit( 127 );
 		}
 
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
