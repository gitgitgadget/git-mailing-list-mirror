From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: warn if feature cannot be overridden.
Date: Tue, 3 Oct 2006 20:07:43 +0200
Message-ID: <20061003180743.GO2871@admingilde.org>
References: <20060929221641.GC2871@admingilde.org> <7v8xk2jofc.fsf@assigned-by-dhcp.cox.net> <20060930181408.GD2871@admingilde.org> <7vfye9dtv7.fsf@assigned-by-dhcp.cox.net> <20061001215748.GG2871@admingilde.org> <eftkdk$2ii$3@sea.gmane.org> <7vbqotpadg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 20:08:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUogH-0000zt-Ty
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 20:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWJCSHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 14:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWJCSHq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 14:07:46 -0400
Received: from agent.admingilde.org ([213.95.21.5]:28101 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S964843AbWJCSHp
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 14:07:45 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GUogB-0004b4-S9; Tue, 03 Oct 2006 20:07:43 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqotpadg.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28286>

If the administrator configures pathinfo to be overrideable by the
local repository a warning is shown.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 10e803a..0ff6f7c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -116,6 +116,10 @@ sub gitweb_check_feature {
 		$feature{$name}{'override'},
 		@{$feature{$name}{'default'}});
 	if (!$override) { return @defaults; }
+	if (!defined $sub) {
+		warn "feature $name is not overrideable";
+		return @defaults;
+	}
 	return $sub->(@defaults);
 }
 
-- 
1.4.2.3

-- 
Martin Waitz
