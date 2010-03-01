From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] t0050: mark non-working test as such
Date: Mon, 01 Mar 2010 00:26:06 -0800
Message-ID: <7veik45ty9.fsf@alter.siamese.dyndns.org>
References: <hll45t$50o$1@ger.gmane.org>
 <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
 <hll65c$87a$1@ger.gmane.org>
 <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
 <20100219060249.GD22645@coredump.intra.peff.net>
 <20100219082445.GB13691@coredump.intra.peff.net>
 <7vhbp0ls26.fsf@alter.siamese.dyndns.org>
 <7v8wachgek.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Mar 01 09:26:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm0xO-0007jA-O0
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 09:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770Ab0CAI0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 03:26:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab0CAI0V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 03:26:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC6149D2FA;
	Mon,  1 Mar 2010 03:26:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=+L2aSrJFC9H9trxMk5QUQzS5gqI=; b=gigvjAt1bF2ZPOckAhv2bfY
	tREjolpdgdkk0HzA07u13nztylvlbIqpYZHIwuNwKZd43GF3+d4ciqoRF3d9l26E
	fyzGwryIYidGembD/lm74HOOO5KkenZ09qvHFUjQ9DnhrqT5jbYbE7P6RM5ICRD7
	N5Y+Ig3tCTFCjGJx/sHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Jcc3HJTrlsr9bto3tNB244kq4GaZP4hE1MIdn4DInWvR9eTM3
	iTbrSlPRqCwFzqIYx2wo2jl1XPX0sO1Mg+b0JX3Y7Cs4gMPx67fWQwJAc2mzkL2t
	rr0fReSrFKCo34Wo+nVt7NfxPARKsj8AduAa11hBqzpQkelD7B9ZUVIuGY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 841499D2F9;
	Mon,  1 Mar 2010 03:26:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7469C9D2F8; Mon,  1 Mar
 2010 03:26:08 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 19AEA0C6-250C-11DF-8B53-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141303>

The test is to prepare an empty file "camelcase" in the index, remove
and replace it with another file "CamelCase" with "1" as its contents
in the working tree, and add it to the index, in a repository configured
to be case insensitive.

However, the test actually checked ls-files knows about a pathname that
matches "camelcase" case insensitively.  It didn't check if the added
contents actually was the updated one.

Mark the test as non-working.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This comes from 8a19aaa (t0050: Add test for case insensitive add,
   2008-05-11); back then the code did add both camelcase and CamelCase,
   and somewhere after that we once fixed it, but 1e5f764 (builtin-add.c:
   optimize -A option and "git add .", 2008-07-22) broke it in a different
   way (namely, it stopped adding the updated contents); I am not going to
   have time to debug it further anytime soon (hint hint)...

 t/t0050-filesystem.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 89282cc..41df6bc 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -108,13 +108,17 @@ $test_case 'merge (case change)' '
 
 '
 
-$test_case 'add (with different case)' '
+
+
+test_expect_failure 'add (with different case)' '
 
 	git reset --hard initial &&
 	rm camelcase &&
 	echo 1 >CamelCase &&
 	git add CamelCase &&
-	test $(git ls-files | grep -i camelcase | wc -l) = 1
+	camel=$(git ls-files | grep -i camelcase) &&
+	test $(echo "$camel" | wc -l) = 1 &&
+	test "z$(git cat-file blob :$camel)" = z1
 
 '
 
-- 
1.7.0.1.241.g6604f
