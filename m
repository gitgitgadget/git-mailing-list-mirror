From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] Documentation for joining more than two histories
Date: Wed, 21 May 2008 18:16:44 -0700
Message-ID: <1211419009-9741-2-git-send-email-gitster@pobox.com>
References: <1211419009-9741-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 03:17:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyzRK-0002Gi-9G
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 03:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762338AbYEVBRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 21:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762403AbYEVBRA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 21:17:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761779AbYEVBQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 21:16:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 75F596847
	for <git@vger.kernel.org>; Wed, 21 May 2008 21:16:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 92BDE6846 for <git@vger.kernel.org>; Wed, 21 May 2008 21:16:56 -0400
 (EDT)
X-Mailer: git-send-email 1.5.5.1.499.g878b8
In-Reply-To: <1211419009-9741-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C59C008C-279C-11DD-8FBE-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82591>

From: Sverre Hvammen Johansen <hvammen@gmail.com>

Added some documentation for how git-merge currently
works when more than two histories are joined.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 Documentation/git-merge.txt |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index ef1f055..5924c1a 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -151,6 +151,42 @@ After seeing a conflict, you can do two things:
    should be, and run `git-commit` to commit the result.
 
 
+JOINING MORE THAN TWO HISTORIES
+-------------------------------
+
+More than one remote may be specified on the command line.  Those
+remotes are used for selecting the merge startegy and is also used in
+the merge commit message.  However, some of these remotes may not be
+independent.  Only remotes with independent heads (reduced parents)
+will be recorded in the merge commit object.
+
+The following shows master and two topic branches.  topicB is based
+on topicA, topicA is previously branched off from master:
+
+------------
+		    o---o---o  topicB
+		   /
+	  o---o---o  topicA
+	 /
+    o---o---o---o---o---o---o  master
+
+------------
+
+Merging topicA and topicB to the master branch will select the merge
+strategy based on all three branches (an Octopus).  master and topicB
+are the reduced parents and are therefore the only parents recorded in
+the merge commit object:
+
+------------
+
+		    o---o---o  topicB
+		   /         \
+	  o---o---o  topicA   o  master
+	 /                   /
+    o---o---o---o---o---o---o
+
+------------
+
 SEE ALSO
 --------
 linkgit:git-fmt-merge-msg[1], linkgit:git-pull[1],
-- 
1.5.5.1.499.g878b8
