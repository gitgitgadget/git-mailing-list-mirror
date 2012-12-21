From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 2/7] tests: paint known breakages in yellow
Date: Thu, 20 Dec 2012 19:12:33 -0800
Message-ID: <1356059558-23479-3-git-send-email-gitster@pobox.com>
References: <1356059558-23479-1-git-send-email-gitster@pobox.com>
Cc: Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 04:13:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlt2t-0000D7-GL
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 04:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab2LUDMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 22:12:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060Ab2LUDMp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 22:12:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB893A811;
	Thu, 20 Dec 2012 22:12:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; s=sasl; bh=IXOExlpNQOlXhJUzX9/RjMvyVf8=; b=AqGrIPDi
	J7OvpMoL0k3PkZfBVsg7TJajssuCna5CIHRkbN9luIKnC8oJ8Z+/zKpM6DGcDgO/
	kVD+YUtG6f2TzlPrxySqAAe2jgSj4SBtzNV9ndc5Qd9F33txEN4UffSjkAABOXqQ
	pBSAQQJZNAYMSGFhVP/1x1yd4uOQuf1inL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; q=dns; s=sasl; b=d0fmU5ULQ0niCkCHDi23Ts6C0OQBz4+nGs
	nkNpN64Wcm1yga2jLrUqW8dPUaH+iJdJIvUaUSIXcxlWhAtVKmfk4y//o7dRhfqs
	sSyH+PzAXu+GtWCabcJufPKVWKb49aB0P51Z1LjOxOCJDFOGgtA+MxqhydqnIqO1
	MWORlFRro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA20DA810;
	Thu, 20 Dec 2012 22:12:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BDBFA80F; Thu, 20 Dec 2012
 22:12:44 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.225.g8d36ab4
In-Reply-To: <1356059558-23479-1-git-send-email-gitster@pobox.com>
In-Reply-To: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
References: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
X-Pobox-Relay-ID: 49B8563E-4B1C-11E2-B8FA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211945>

From: Adam Spiers <git@adamspiers.org>

Yellow seems a more appropriate color than bold green when
considering the universal traffic lights coloring scheme, where
green conveys the impression that everything's OK, and amber that
something's not quite right.

Likewise, change the color of the summarized total number of known
breakages from bold red to the same yellow to be less alarmist and
more consistent with the above.

An earlier version of this patch used bold yellow but because these
are all long-known failures, reminding them to developers in bold
over and over does not help encouraging them to take a look at them
very much.  This iteration paints them in plain yellow instead to
make them less distracting.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 03b86b8..72aafd0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -183,6 +183,8 @@ then
 			tput bold; tput setaf 1;; # bold red
 		skip)
 			tput bold; tput setaf 2;; # bold green
+		warn)
+			tput setaf 3;; # brown/yellow
 		pass)
 			tput setaf 2;;            # green
 		info)
@@ -281,7 +283,7 @@ test_known_broken_ok_ () {
 
 test_known_broken_failure_ () {
 	test_broken=$(($test_broken+1))
-	say_color skip "not ok $test_count - $@ # TODO known breakage"
+	say_color warn "not ok $test_count - $@ # TODO known breakage"
 }
 
 test_debug () {
@@ -375,7 +377,7 @@ test_done () {
 	fi
 	if test "$test_broken" != 0
 	then
-		say_color error "# still have $test_broken known breakage(s)"
+		say_color warn "# still have $test_broken known breakage(s)"
 		msg="remaining $(($test_count-$test_broken)) test(s)"
 	else
 		msg="$test_count test(s)"
-- 
1.8.1.rc2.225.g8d36ab4
