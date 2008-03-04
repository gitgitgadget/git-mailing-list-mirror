From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Test for packed tags in git-describe output
Date: Mon, 3 Mar 2008 20:09:35 -0500
Message-ID: <20080304010935.GB15791@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 02:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWLfZ-00032h-Fh
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 02:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbYCDBJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 20:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755436AbYCDBJi
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 20:09:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52171 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114AbYCDBJh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 20:09:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWLen-0001J4-WE; Mon, 03 Mar 2008 20:09:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 673F120FBAE; Mon,  3 Mar 2008 20:09:35 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76007>

In c374b91c ("git-describe: use tags found in packed-refs correctly")
Junio fixed an issue where git-describe did not parse a tag object it
obtained from a packed-refs file, as the peel information was read in
from packed-refs and not the tag object itself.

This new test case verifies the fix listed above is functioning, and
does not have a regression in the future.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t6120-describe.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index ba9ea60..cc24477 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -98,4 +98,7 @@ check_describe B --tags HEAD^^2^
 
 check_describe B-0-* --long HEAD^^2^
 
+test_expect_success 'pack tag refs' 'git pack-refs'
+check_describe A-* HEAD
+
 test_done
-- 
1.5.4.3.529.gb25fb

