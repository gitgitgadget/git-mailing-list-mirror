From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t3419-*.sh: Fix arithmetic expansion syntax error
Date: Tue, 21 Dec 2010 18:50:47 +0000
Message-ID: <4D10F707.1000206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, drizzd@aon.at
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 20:55:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV8JK-0006FK-4L
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 20:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab0LUTzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 14:55:45 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:59161 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752685Ab0LUTzp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Dec 2010 14:55:45 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PV8JD-0005kB-ig; Tue, 21 Dec 2010 19:55:44 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164049>


Some shells, for example dash versions older than 0.5.4, need to
spell a variable reference as '$N' rather than 'N' in an arithmetic
expansion. In order to avoid the syntax error, we change the
offending variable reference from 'i' to '$i' in function scramble.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Note that this test is unique in having an '#!/bin/bash' line (rather
than '#!/bin/sh'), which was (indirectly) responsible for me not
noticing this failure for a while. I don't see anything that would
require bash, so I suspect this is not intensional.

ATB,
Ramsay Jones

 t/t3419-rebase-patch-id.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 1aee483..6972b49 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -27,7 +27,7 @@ scramble()
 		then
 			echo "$x"
 		fi
-		i=$(((i+1) % 10))
+		i=$((($i+1) % 10))
 	done < "$1" > "$1.new"
 	mv -f "$1.new" "$1"
 }
-- 
1.7.3
