From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2010, #03; Wed, 10)
Date: Thu, 11 Mar 2010 21:52:53 -0800
Message-ID: <7vhbomt7be.fsf@alter.siamese.dyndns.org>
References: <7v7hpj4k7w.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1003112041m7c8b4012j187d9a0c2537acbb@mail.gmail.com>
 <7vtysmt7wo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Larry D'Anna" <larry@elder-gods.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 06:53:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npxo8-00016E-Nf
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 06:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab0CLFxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 00:53:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab0CLFxD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 00:53:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8ACEA13A5;
	Fri, 12 Mar 2010 00:53:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rap54ocl9OJ51lYOdPjqCa2LkgM=; b=n9z8Gf
	AAwZh5wEoD5ldWk4139yc5nBhwBKJJsVw3O4cq1GADaIx7sgMlhoha4IBlvGqIFD
	gI6afnsjmm4NTD94khErmgujDKPbXw6jPQRgSTAT5tS2jWQ9+5LikYN6cvzJw08e
	nIIiVRhSx4SbUVwsIRvVFvEDoOMXJgh+t0J+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p6C0iuAjq39NHL17ET/icq3y5tvI4zxh
	+dTqRK6CkqvRvoxOQwnyzWMrQ2yjvGLvvJo/60cZkBzLgeitkq9rKfe/sgxlx0eE
	oyf22pV7slfsAXtSS8ZSZ2kBbyUOeg40+gSat/wDnoJmdLWQ+EUroojCtFbOBmtB
	qeX/OoMwI4U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84633A13A3;
	Fri, 12 Mar 2010 00:52:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 992BDA139D; Fri, 12 Mar
 2010 00:52:54 -0500 (EST)
In-Reply-To: <7vtysmt7wo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 11 Mar 2010 21\:40\:07 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8393A59E-2D9B-11DF-9454-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142018>

Junio C Hamano <gitster@pobox.com> writes:

> Subject: t9400: Use test_cmp when appropriate

And this is an obvious follow-up.

-- >8 --
Subject: t5516: Use test_cmp when appropriate

Consistently using test_cmp would make debugging test scripts far easier,
as output from them run under "-v" option becomes readable.

Besides, some platforms' "diff" implementations lack "-q" option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5516-fetch-push.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 11adb0b..2de98e6 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -672,7 +672,7 @@ test_expect_success 'push --porcelain' '
 		test "z$r" = "z$the_commit" &&
 		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
 	) &&
-	diff -q .git/foo .git/bar
+	test_cmp .git/foo .git/bar
 '
 
 test_expect_success 'push --porcelain bad url' '
@@ -692,7 +692,7 @@ test_expect_success 'push --porcelain rejected' '
 	echo >>.git/foo "!	refs/heads/master:refs/heads/master	[remote rejected] (branch is currently checked out)" &&
 
 	test_must_fail git push >.git/bar --porcelain  testrepo refs/heads/master:refs/heads/master &&
-	diff -q .git/foo .git/bar
+	test_cmp .git/foo .git/bar
 '
 
 test_expect_success 'push --porcelain --dry-run rejected' '
@@ -707,7 +707,7 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 	echo >>.git/foo "Done" &&
 
 	test_must_fail git push >.git/bar --porcelain  --dry-run testrepo refs/heads/master^:refs/heads/master &&
-	diff -q .git/foo .git/bar
+	test_cmp .git/foo .git/bar
 '
 
 test_done
