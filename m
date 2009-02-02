From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] git-add -i/-p: Change prompt separater from slash to
 comma
Date: Sun,  1 Feb 2009 19:42:37 -0800
Message-ID: <1233546159-30347-2-git-send-email-gitster@pobox.com>
References: <1233546159-30347-1-git-send-email-gitster@pobox.com>
Cc: William Pursell <bill.pursell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 04:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTpjL-0006QD-JN
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 04:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbZBBDmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 22:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbZBBDmt
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 22:42:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbZBBDmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 22:42:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7DA4C2A439;
	Sun,  1 Feb 2009 22:42:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C6E0A2A436; Sun, 
 1 Feb 2009 22:42:44 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.331.g8c4c8
In-Reply-To: <1233546159-30347-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8E3065BC-F0DB-11DD-ADBD-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108042>

From: William Pursell <bill.pursell@gmail.com>

Otherwise the find command '/' soon to be introduced will be hard to see.

Signed-off-by: William Pursell <bill.pursell@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-add--interactive.perl |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ca60356..ca50363 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -929,22 +929,22 @@ sub patch_update_file {
 		for ($i = 0; $i < $ix; $i++) {
 			if (!defined $hunk[$i]{USE}) {
 				$prev = 1;
-				$other .= '/k';
+				$other .= ',k';
 				last;
 			}
 		}
 		if ($ix) {
-			$other .= '/K';
+			$other .= ',K';
 		}
 		for ($i = $ix + 1; $i < $num; $i++) {
 			if (!defined $hunk[$i]{USE}) {
 				$next = 1;
-				$other .= '/j';
+				$other .= ',j';
 				last;
 			}
 		}
 		if ($ix < $num - 1) {
-			$other .= '/J';
+			$other .= ',J';
 		}
 		if ($num > 1) {
 			$other .= '/g';
@@ -958,13 +958,13 @@ sub patch_update_file {
 		last if (!$undecided);
 
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
-			$other .= '/s';
+			$other .= ',s';
 		}
-		$other .= '/e';
+		$other .= ',e';
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
+		print colored $prompt_color, "Stage this hunk [y,n,a,d$other,?]? ";
 		my $line = <STDIN>;
 		if ($line) {
 			if ($line =~ /^y/i) {
-- 
1.6.1.2.331.g8c4c8
