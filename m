From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 1/2] Fix a warning about conversion to float
Date: Tue,  6 Mar 2012 09:54:36 +0100
Message-ID: <1331024077-5736-1-git-send-email-user@vincent-VirtualBox>
Mime-Version: 1.0
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 09:55:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4qB1-0007mT-AT
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 09:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758843Ab2CFIy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 03:54:59 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61843 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758649Ab2CFIy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 03:54:58 -0500
Received: by eaaq12 with SMTP id q12so1730761eaa.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 00:54:56 -0800 (PST)
Received-SPF: pass (google.com: domain of  designates 10.14.99.10 as permitted sender) client-ip=10.14.99.10;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of  designates 10.14.99.10 as permitted sender) smtp.mail=
Received: from mr.google.com ([10.14.99.10])
        by 10.14.99.10 with SMTP id w10mr3501837eef.51.1331024096919 (num_hops = 1);
        Tue, 06 Mar 2012 00:54:56 -0800 (PST)
Received: by 10.14.99.10 with SMTP id w10mr2634326eef.51.1331024096796;
        Tue, 06 Mar 2012 00:54:56 -0800 (PST)
Received: from localhost.localdomain (wlan-145-94-169-074.wlan.tudelft.nl. [145.94.169.74])
        by mx.google.com with ESMTPS id y11sm10939264eem.3.2012.03.06.00.54.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 00:54:56 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
X-Gm-Message-State: ALoCoQlaNtGAjUb7sq9b08gcbSqRXG6eCxxjerTFp8bCZkoMMovlsw15Ds0yF9I/Eudiq2h5++Mi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192318>

From: Vincent van Ravesteijn <vfr@lyx.org>

Below in the same function, val is correctly casted to a float. Do this also
for the initialization of x.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 bisect.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6e186e2..4aeb402 100644
--- a/bisect.c
+++ b/bisect.c
@@ -536,7 +536,7 @@ static int get_prn(int count) {
  */
 static int sqrti(int val)
 {
-	float d, x = val;
+	float d, x = (float)val;
 
 	if (val == 0)
 		return 0;
@@ -550,6 +550,7 @@ static int sqrti(int val)
 	return (int)x;
 }
 
+
 static struct commit_list *skip_away(struct commit_list *list, int count)
 {
 	struct commit_list *cur, *previous;
-- 
1.7.5.4
