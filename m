From: Clemens Buchacher <clemens.buchacher@intel.com>
Subject: [PATCH] rebase: return non-zero error code if format-patch fails
Date: Thu, 2 Jul 2015 11:11:33 +0200
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany - Tel: +49 89 99 8853-0, www.intel.de - Managing Directors: Prof. Dr. Hermann Eul, Christin Eisenschmid - Chairperson of the Supervisory Board: Tiffany Doon Silva - Registered Office: Munich - Commercial Register: Amtsgericht Mnchen HRB 186928
Message-ID: <20150702091133.GA13353@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.kw.w@gmail.com>,
	Jorge Nunes <jorge.nunes@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 11:12:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAaXM-0004wb-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 11:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbbGBJL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 05:11:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:9973 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753588AbbGBJLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 05:11:37 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 02 Jul 2015 02:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,391,1432623600"; 
   d="scan'208";a="754660438"
Received: from musxeris015.imu.intel.com (HELO localhost) ([10.216.40.13])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jul 2015 02:11:34 -0700
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273222>

Since e481af06 (rebase: Handle cases where format-patch fails) we
notice if format-patch fails and return immediately from
git-rebase--am. We save the return value with ret=$?, but then we
return $?, which is usually zero in this case.

Fix this by returning $ret instead.

Cc: Andrew Wong <andrew.kw.w@gmail.com>
Signed-off-by: Clemens Buchacher <clemens.buchacher@intel.com>
Reviewed-by: Jorge Nunes <jorge.nunes@intel.com>
---
 git-rebase--am.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index f923732..9ae898b 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -78,7 +78,7 @@ else
 
 		As a result, git cannot rebase them.
 		EOF
-		return $?
+		return $ret
 	fi
 
 	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
-- 
1.9.4
