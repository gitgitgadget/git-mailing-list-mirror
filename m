From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Define cd_to_toplevel shell function in git-sh-setup
Date: Fri, 12 Jan 2007 12:55:23 -0800
Message-ID: <7vmz4ormmc.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
	<200701121501.24642.andyparkins@gmail.com>
	<7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 21:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5TQu-0004Hx-HK
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 21:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbXALUz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 15:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbXALUzZ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 15:55:25 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:58507 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030422AbXALUzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 15:55:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112205524.YZAA9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 15:55:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ALuY1W00a1kojtg0000000; Fri, 12 Jan 2007 15:54:33 -0500
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 12 Jan 2007 12:26:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36706>


Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-sh-setup.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 57f7f77..6b1c142 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -36,6 +36,17 @@ is_bare_repository () {
 	esac
 }
 
+cd_to_toplevel () {
+	cdup=$(git-rev-parse --show-cdup)
+	if test ! -z "$cdup"
+	then
+		cd "$cdup" || {
+			echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
+			exit 1
+		}
+	fi
+}
+
 require_work_tree () {
 	test $(is_bare_repository) = false ||
 	die "fatal: $0 cannot be used without a working tree."
-- 
1.5.0.rc1.g397d
