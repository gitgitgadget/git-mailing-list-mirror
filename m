From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] t3419: drop unnecessary NOT_EXPENSIVE pseudo-prerequisite
Date: Mon,  9 Jun 2014 16:22:54 -0700
Message-ID: <1402356175-7249-7-git-send-email-gitster@pobox.com>
References: <1402356175-7249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 01:23:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8uj-0004Rp-R5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934420AbaFIXXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:23:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59921 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414AbaFIXXe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:23:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCEE41D418;
	Mon,  9 Jun 2014 19:23:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zm7D
	fGIV+2zVhVi5coYh5E8Dtoc=; b=Qhv8MQeEvpx3XZL1RF+QIl9IYjG9v0YefRtF
	Qgyp1SsvTE5nsBu5kCeiolaobWLMXis/5O7efBrmog33j0NHH+T2w4uqxDrgvMeE
	Uo3leZe01mB7bAzr3yfyaqlnmA6JAJ76laYiwXktGL5Fp+54KOl7cGFhR2e2+6dx
	3/3+ZCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=rm35QA
	E/+2q9UUM/187ION96tF09dHit5rZHMnylj8GYeWplIDjdu8N4P9OU5TeiBvDs0w
	rywRQVBPeaLqYLZJqQN+pqsv/AHSv6uxXbE/vXfCd/TH0UjZiI/xaH9labHCB5dt
	Wy2QVfqIZfHrb5bYP4X5j48w8oN1XKJD1mD/8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B4AF51D417;
	Mon,  9 Jun 2014 19:23:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF29D1D414;
	Mon,  9 Jun 2014 19:23:29 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-483-g1a584c4
In-Reply-To: <1402356175-7249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 10CC5A70-F02D-11E3-BC31-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251139>

This was only necessary because do_tests helper the script defines
took its parameters in a wrong order.  Just pass an empty string (or
not passing the optional EXPENSIVE prerequisite) when running the
test with a light-weight set of parameters and have the shell do the
right thing when parsing test_expect_success helper.

Also update coding style while we are at it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3419-rebase-patch-id.sh | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 08e30b3..9292b49 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -4,11 +4,9 @@ test_description='git rebase - test patch id computation'
 
 . ./test-lib.sh
 
-test_set_prereq NOT_EXPENSIVE
 test -n "$GIT_PATCHID_TIMING_TESTS" && test_set_prereq EXPENSIVE
 
-count()
-{
+count () {
 	i=0
 	while test $i -lt $1
 	do
@@ -17,8 +15,7 @@ count()
 	done
 }
 
-scramble()
-{
+scramble () {
 	i=0
 	while read x
 	do
@@ -27,12 +24,11 @@ scramble()
 			echo "$x"
 		fi
 		i=$((($i+1) % 10))
-	done < "$1" > "$1.new"
+	done <"$1" >"$1.new"
 	mv -f "$1.new" "$1"
 }
 
-run()
-{
+run () {
 	echo \$ "$@"
 	/usr/bin/time "$@" >/dev/null
 }
@@ -42,10 +38,8 @@ test_expect_success 'setup' '
 	git tag root
 '
 
-do_tests()
-{
-	pr=$1
-	nlines=$2
+do_tests () {
+	nlines=$1 pr=${2-}
 
 	test_expect_success $pr "setup: $nlines lines" "
 		rm -f .gitattributes &&
@@ -102,7 +96,7 @@ do_tests()
 	"
 }
 
-do_tests NOT_EXPENSIVE 500
-do_tests EXPENSIVE 50000
+do_tests 500
+do_tests 50000 EXPENSIVE
 
 test_done
-- 
2.0.0-435-g307a092
