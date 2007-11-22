From: Alexey Dobriyan <adobriyan@sw.ru>
Subject: [PATCH] Tweak git-quiltimport to allow more flexible series format
Date: Thu, 22 Nov 2007 16:48:49 +0300
Message-ID: <20071122134849.GB6240@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: adobriyan@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 14:49:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvCQf-0007l3-K5
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 14:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbXKVNs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 08:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbXKVNs7
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 08:48:59 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:11401 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbXKVNs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 08:48:58 -0500
Received: from sw.ru ([192.168.0.16])
	by relay.sw.ru (8.13.4/8.13.4) with SMTP id lAMDmokL030394;
	Thu, 22 Nov 2007 16:48:53 +0300 (MSK)
Received: by sw.ru (nbSMTP-1.00) for uid 1000
	adobriyan@sw.ru; Thu, 22 Nov 2007 16:48:53 +0300 (MSK)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65824>

Make quiltimport also understand comments following patch name.

Signed-off-by: Alexey Dobriyan <adobriyan@sw.ru>
---

 git-quiltimport.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -63,7 +63,7 @@ tmp_info="$tmp_dir/info"
 commit=$(git rev-parse HEAD)
 
 mkdir $tmp_dir || exit 2
-for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
+for patch_name in $(sed -e 's/#.*//' < "$QUILT_PATCHES/series" ); do
 	if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
 		echo "$patch_name doesn't exist. Skipping."
 		continue
