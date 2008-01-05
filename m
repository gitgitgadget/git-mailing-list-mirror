From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t/t7600: avoid GNUism in grep
Date: Fri, 04 Jan 2008 22:50:09 -0800
Message-ID: <7v63y8g40u.fsf@gitster.siamese.dyndns.org>
References: <1199506008-12225-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 07:50:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB2rp-00088O-7j
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 07:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbYAEGuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 01:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbYAEGuU
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 01:50:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbYAEGuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 01:50:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B5426B4A;
	Sat,  5 Jan 2008 01:50:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C7AA16B45;
	Sat,  5 Jan 2008 01:50:11 -0500 (EST)
In-Reply-To: <1199506008-12225-1-git-send-email-vmiklos@frugalware.org>
	(Miklos Vajna's message of "Sat, 5 Jan 2008 05:06:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69644>

Using \+ to mean "one or more" in grep without -E is a GNU
extension outside POSIX.  Avoid it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I do not think these clean-ups are particularly necessary
   right now, but as we noticed it why not...

 t/t7600-merge.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 6424c6e..21862ac 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -371,7 +371,7 @@ test_expect_success 'override config option -n' '
 	git merge --summary c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
 	verify_parents $c1 $c2 &&
-	if ! grep -e "^ file | \+2 +-$" diffstat.txt
+	if ! grep -e "^ file |  *2 +-$" diffstat.txt
 	then
 		echo "[OOPS] diffstat was not generated"
 	fi
@@ -386,7 +386,7 @@ test_expect_success 'override config option --summary' '
 	git merge -n c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
 	verify_parents $c1 $c2 &&
-	if grep -e "^ file | \+2 +-$" diffstat.txt
+	if grep -e "^ file |  +2 +-$" diffstat.txt
 	then
 		echo "[OOPS] diffstat was generated"
 		false
-- 
1.5.4.rc2.17.g257f
