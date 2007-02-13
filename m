From: "Julian Phillips" <jp3@quantumfyre.co.uk>
Subject: [PATCH] Use stdin reflist passing in parse-remote
Date: Tue, 13 Feb 2007 01:21:40 +0000
Message-ID: <1171329702101-git-send-email-julian@quantumfyre.co.uk>
References: <11713297014015-git-send-email-julian@quantumfyre.co.uk> <11713297013179-git-send-email-julian@quantumfyre.co.uk>
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 02:28:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGmTC-0006ZR-Rj
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 02:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965461AbXBMB2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 20:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965463AbXBMB20
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 20:28:26 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:37418 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965460AbXBMB2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 20:28:24 -0500
Received: (qmail 25801 invoked by uid 103); 13 Feb 2007 01:21:42 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <jp3@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2553. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.234728 secs); 13 Feb 2007 01:21:42 -0000
Received: from unknown (HELO beast) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 13 Feb 2007 01:21:42 +0000
Received: by beast (sSMTP sendmail emulation); Tue, 13 Feb 2007 01:21:42 +0000
X-Mailer: git-send-email 1.4.4.4
In-Reply-To: <11713297013179-git-send-email-julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39475>

Use the new stdin reflist passing mechanism for the call to
fetch--tool expand-refs-wildcard, allowing passing of more
than ~128K of reflist data.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 git-parse-remote.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 9b19a21..185eb54 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -81,7 +81,7 @@ get_remote_default_refs_for_push () {
 # is to help prevent randomly "globbed" ref from being chosen as
 # a merge candidate
 expand_refs_wildcard () {
-	git fetch--tool expand-refs-wildcard "$ls_remote_result" "$@"
+	echo "$ls_remote_result" | git fetch--tool expand-refs-wildcard "-" "$@"
 }
 
 # Subroutine to canonicalize remote:local notation.
-- 
1.4.4.4
