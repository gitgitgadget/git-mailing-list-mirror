From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 1/8] contrib/subtree: Use %B for split subject/body
Date: Mon, 18 Feb 2013 14:56:46 -0600
Message-ID: <1361221013-12756-2-git-send-email-greened@obbligato.org>
References: <1361221013-12756-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>,
	James Nylen <jnylen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:58:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Xn1-0005I5-AW
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab3BRU5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:57:53 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:45270 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754726Ab3BRU5w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:57:52 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U7XoT-0000E4-RE; Mon, 18 Feb 2013 14:59:50 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1361221013-12756-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: Techlive Zheng <techlivezheng@gmail.com> Use %B to format
    the commit message and body to avoid an extra newline if a commit only has
    a subject line. Signed-off-by: Techlive Zheng <techlivezheng@gmail.com> Signed-off-by:
    David A. Greene <greened@obbligato.org> --- contrib/subtree/t/t7900-subtree.sh
    | 11 +++++++++++ 1 file changed, 11 insertions(+) [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- ------------------------------------------- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216522>

From: Techlive Zheng <techlivezheng@gmail.com>

Use %B to format the commit message and body to avoid an extra newline
if a commit only has a subject line.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/t/t7900-subtree.sh |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 80d3399..8dd6a82 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -226,6 +226,17 @@ test_expect_success 'check hash of split' '
 	check_equal ''"$new_hash"'' "$subdir_hash"
 '
 
+test_expect_success 'check hash of split' '
+        spl1=$(git subtree split --prefix subdir) &&
+        undo &&
+        git subtree split --prefix subdir --branch splitbr1test &&
+        check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1"
+        git checkout splitbr1test &&
+        new_hash=$(git rev-parse HEAD~2) &&
+        git checkout mainline &&
+        check_equal ''"$new_hash"'' "$subdir_hash"
+'
+
 test_expect_success 'check split with --branch for an existing branch' '
         spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
         undo &&
-- 
1.7.10.4
