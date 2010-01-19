From: David Ripton <dripton@ripton.net>
Subject: [PATCH] bisect: fix singular/plural grammar nit
Date: Tue, 19 Jan 2010 07:13:33 -0800
Message-ID: <20100119151333.GA9660@vidar.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 19 16:41:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXGCh-0002Gy-5o
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 16:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab0ASPlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 10:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948Ab0ASPlJ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 10:41:09 -0500
Received: from judo.dreamhost.com ([66.33.216.100]:44301 "EHLO
	judo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab0ASPlI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 10:41:08 -0500
X-Greylist: delayed 1614 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2010 10:41:08 EST
Received: from crusty.g.dreamhost.com (crusty.g.dreamhost.com [67.205.8.12])
	by judo.dreamhost.com (Postfix) with ESMTP id 60792452F99
	for <git@vger.kernel.org>; Tue, 19 Jan 2010 07:14:13 -0800 (PST)
Received: from vidar.dreamhost.com (vidar.dreamhost.com [208.113.223.211])
	by crusty.g.dreamhost.com (Postfix) with ESMTP id 8972911DD60;
	Tue, 19 Jan 2010 07:13:33 -0800 (PST)
Received: by vidar.dreamhost.com (Postfix, from userid 59956)
	id 8E17998517; Tue, 19 Jan 2010 07:13:33 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137466>

Remove the trailing 's' from "revisions" and "steps" when there is
only one.

Signed-off-by: David Ripton <dripton@ripton.net>
---
 bisect.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index f1a1f84..af280b4 100644
--- a/bisect.c
+++ b/bisect.c
@@ -956,7 +956,7 @@ int bisect_next_all(const char *prefix)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
-	int reaches = 0, all = 0, nr;
+	int reaches = 0, all = 0, nr, steps;
 	const unsigned char *bisect_rev;
 	char bisect_rev_hex[41];
 
@@ -998,8 +998,10 @@ int bisect_next_all(const char *prefix)
 	}
 
 	nr = all - reaches - 1;
-	printf("Bisecting: %d revisions left to test after this "
-	       "(roughly %d steps)\n", nr, estimate_bisect_steps(all));
+	steps = estimate_bisect_steps(all);
+	printf("Bisecting: %d revision%s left to test after this "
+	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
+               steps, (steps == 1 ? "" : "s"));
 
 	return bisect_checkout(bisect_rev_hex);
 }

-- 
David Ripton    dripton@ripton.net
