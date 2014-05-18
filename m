From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] rebase --keep-empty -i: add test
Date: Sun, 18 May 2014 23:28:39 +0300
Message-ID: <1400444838-12685-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nhorman@tuxdriver.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 22:30:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm7j4-0006YN-Cq
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 22:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbaERU3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 16:29:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29177 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbaERU3w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 16:29:52 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4IKTklo005114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 May 2014 16:29:46 -0400
Received: from redhat.com (ovpn-116-32.ams2.redhat.com [10.36.116.32])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s4IKTiFu029989;
	Sun, 18 May 2014 16:29:44 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249509>

There's some special code in rebase -i to deal
with --keep-empty.
Add test for this combination.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t3404-rebase-interactive.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c0023a5..3b1b863 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -67,6 +67,14 @@ test_expect_success 'setup' '
 SHELL=
 export SHELL
 
+test_expect_success 'rebase --keep-empty' '
+	git checkout -b emptybranch master &&
+	git commit --allow-empty -m "empty" &&
+	git rebase --keep-empty -i HEAD~2 &&
+	git log --oneline >actual &&
+	test_line_count = 6 actual
+'
+
 test_expect_success 'rebase -i with the exec command' '
 	git checkout master &&
 	(
-- 
MST
