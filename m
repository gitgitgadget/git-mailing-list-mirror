From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 1/6] add a test for git-send-email for non-threaded mails
Date: Wed, 10 Jun 2009 00:16:03 -0700
Message-ID: <7vy6s0tv7w.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<1244410857-920-4-git-send-email-markus.heidelberg@web.de>
	<7vhbyo1vr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:16:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEI2h-0007gb-Nm
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 09:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbZFJHQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 03:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbZFJHQD
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 03:16:03 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50910 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbZFJHQB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 03:16:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610071604.VVRQ20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jun 2009 03:16:04 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 27G31c00B4aMwMQ037G3g6; Wed, 10 Jun 2009 03:16:03 -0400
X-VR-Score: -62.00
X-Authority-Analysis: v=1.0 c=1 a=GecFyh6C1VEA:10 a=aS7S05H_7zsA:10
 a=ybZZDoGAAAAA:8 a=A1X0JdhQAAAA:8 a=MM1HVTrppejBgqJksD4A:9
 a=84p8rmw4WQokAvSTKOKPARGNoYwA:4 a=5N_Nib3jKbIA:10 a=XTUYKXyG0EEA:10
 a=5KVauyKsRKMA:10 a=qIVjreYYsbEA:10 a=Y6qChIQXU1wA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121254>

From: Markus Heidelberg <markus.heidelberg@web.de>
Date: Mon, 8 Jun 2009 09:13:16 +0200

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * To be applied on 'maint'.

 t/t9001-send-email.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ce26ea4..5bfa36e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -621,4 +621,14 @@ test_expect_success 'in-reply-to but no threading' '
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
 
+test_expect_failure 'no in-reply-to and no threading' '
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--nothread \
+		$patches $patches >stdout &&
+	! grep "In-Reply-To: " stdout
+'
+
 test_done
-- 
1.6.3.2.214.gf4f78e
