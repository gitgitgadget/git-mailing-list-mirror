From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/5] symbolit-ref: fix resolve_ref conversion.
Date: Thu, 21 Sep 2006 00:06:02 -0700
Message-ID: <7v4pv1bsx1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
	<Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
	<7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609180934360.4388@g5.osdl.org>
	<7v64fhd7ns.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 09:06:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQIdO-0004BE-C5
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 09:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWIUHGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 03:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWIUHGG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 03:06:06 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:11990 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750761AbWIUHGD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 03:06:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921070603.RCLK18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 03:06:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qv5o1V00q1kojtg0000000
	Thu, 21 Sep 2006 03:05:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27459>

An earlier conversion accidentally hardcoded "HEAD" to be passed to
resolve_ref(), thereby causing git-symbolic-ref command to always
report where the HEAD points at, ignoring the command line parameter.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-symbolic-ref.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index 6f18db8..13163ba 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -7,7 +7,7 @@ static const char git_symbolic_ref_usage
 static void check_symref(const char *HEAD)
 {
 	unsigned char sha1[20];
-	const char *refs_heads_master = resolve_ref("HEAD", sha1, 0);
+	const char *refs_heads_master = resolve_ref(HEAD, sha1, 0);
 
 	if (!refs_heads_master)
 		die("No such ref: %s", HEAD);
-- 
1.4.2.1.g4dc7
