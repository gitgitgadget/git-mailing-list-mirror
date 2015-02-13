From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] SQUASH??? t9001: turn --no$option workarounds to --no-$option
Date: Fri, 13 Feb 2015 12:19:29 -0800
Message-ID: <1423858769-1565-3-git-send-email-gitster@pobox.com>
References: <xmqq8ug2pvw7.fsf@gitster.dls.corp.google.com>
 <1423858769-1565-1-git-send-email-gitster@pobox.com>
Cc: Brandon Casey <drafnel@gmail.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 21:19:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMMiI-0003NC-Vx
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 21:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbbBMUTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 15:19:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753254AbbBMUTf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 15:19:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 357EE248C8;
	Fri, 13 Feb 2015 15:19:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bFc5
	gB1ICgf/0OmclVzfSixeu/w=; b=K6h8CUi822pkur3G82bdO2Hhe6d3AHNV14oA
	YtuJazn7AOll5aGPDjNeX1v7BKvE84JtcEIFQuReTBghMBFpzAWjdVEQLOHQmzR9
	Z0ID8fvGeci6UDQtdb7KoQKGZl9ygelmg46S4hJVdFd2bp+mENuGh3ZNL9T3WBWv
	yfQaPDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	aZuddTbRRWd6CHpuaYdalTaHJDm+qsOJewQnCPXZ7Ax9jKHpgNP5/8foK5qsR/Yo
	h6X08PQr4OpZtEw3CLeR2kAhOgciNfdlV53w3rvGI/jE9mGiSl46nWy9GvNN+Y2n
	JZOjq0UtI0guGtGvjpQ59rI258P3ZW7cnPtwN6NevXU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A8D3248C6;
	Fri, 13 Feb 2015 15:19:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2772248C0;
	Fri, 13 Feb 2015 15:19:34 -0500 (EST)
X-Mailer: git-send-email 2.3.0-191-geb1a277
In-Reply-To: <1423858769-1565-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A040D484-B3BD-11E4-A1D0-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263830>

These were done to work around older versions of Getopt::Long that
did not take negation of a boolean "--option" as "--no-option" (but
they happily took "--nooption").

I am inclined to squash this into the previous one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9001-send-email.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index af6a3e8..0513055 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -392,7 +392,7 @@ test_expect_success $PREREQ 'allow long lines with --no-validate' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
-		--novalidate \
+		--no-validate \
 		$patches longline.patch \
 		2>errors
 '
@@ -426,7 +426,7 @@ test_expect_success $PREREQ 'In-Reply-To without --chain-reply-to' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--nochain-reply-to \
+		--no-chain-reply-to \
 		--in-reply-to="$(cat expect)" \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches $patches $patches \
@@ -1067,7 +1067,7 @@ test_expect_success $PREREQ 'in-reply-to but no threading' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--in-reply-to="<in-reply-id@example.com>" \
-		--nothread \
+		--no-thread \
 		$patches |
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
@@ -1077,7 +1077,7 @@ test_expect_success $PREREQ 'no in-reply-to and no threading' '
 		--dry-run \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--nothread \
+		--no-thread \
 		$patches $patches >stdout &&
 	! grep "In-Reply-To: " stdout
 '
@@ -1088,7 +1088,7 @@ test_expect_success $PREREQ 'threading but no chain-reply-to' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--thread \
-		--nochain-reply-to \
+		--no-chain-reply-to \
 		$patches $patches >stdout &&
 	grep "In-Reply-To: " stdout
 '
-- 
2.3.0-191-geb1a277
