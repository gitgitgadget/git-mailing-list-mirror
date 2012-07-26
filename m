From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/2] test-lib: provide UTF8 behaviour as a prerequisite
Date: Thu, 26 Jul 2012 16:28:34 -0700
Message-ID: <7vy5m63xwd.fsf_-_@alter.siamese.dyndns.org>
References: <7vboj25dk7.fsf@alter.siamese.dyndns.org>
 <7v7gtq5da3.fsf@alter.siamese.dyndns.org>
 <7v394e5cv5.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"Michael J Gruber" <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 01:28:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuXU3-0001HQ-Tu
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 01:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab2GZX2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 19:28:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753063Ab2GZX2h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 19:28:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63EAD8EFA;
	Thu, 26 Jul 2012 19:28:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3HLVCMIZrUJ2FuOoX7/iobwSM90=; b=hE02QS
	J4j9nAXTPJ0d55I9pTMTc/EVIM9wSkwch02mzETtqT8BHHQTAM7tA6PhXqX6326I
	p0jxhi2zkXvxOQaLFV9FfMM8H9gC4m4wfigMzSsinVS4GzqWI0Ew/o4bvha9jjtL
	ki67p3jiaqxuILkmNqNAuKZmv3LPDfHn2pR5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x7l7+xrFGa7Ey6aeg9Yj11ztG0+xCS2Z
	N81YxZAjMXtH8mNgxxaQDwppev+k2D3M1WvSUXIR3YFKj3L2CDDAlug3ZQIMvFmD
	tTU3pA9pqvBKzx9dhXFiuZlzev+M9p16fay5UzChcIrhbujk7CBTT6Uj5CCNWesL
	Hj46gYBtlE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5166E8EF9;
	Thu, 26 Jul 2012 19:28:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EFA58EF7; Thu, 26 Jul 2012
 19:28:35 -0400 (EDT)
In-Reply-To: <7v394e5cv5.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jul 2012 16:19:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EF8A836-D779-11E1-9D1A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202320>

And Michael's [4/5] would become like this (again, [3/5] does not
need any change).

-- >8 --

From: Michael J Gruber <git@drmicha.warpmail.net>
Date: Thu, 26 Jul 2012 15:39:56 +0200

UTF8 behaviour of the filesystem (conversion from nfd to nfc)  plays a
role in several tests and is tested in several tests. Therefore, move
the test from t0050 into the test lib and use the prerequisite in t0050.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/README              |  5 +++++
 t/t0050-filesystem.sh | 24 +++++++-----------------
 t/test-lib.sh         | 13 +++++++++++++
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/t/README b/t/README
index 5725607..e4128e5 100644
--- a/t/README
+++ b/t/README
@@ -629,6 +629,11 @@ use these, and "test_set_prereq" for how to define your own.
 
    Test is run on a case insensitive file system.
 
+ - UTF8_NFD_TO_NFC
+
+   Test is run on a filesystem which converts decomposed utf-8 (nfd)
+   to precomposed utf-8 (nfc).
+
 Tips for Writing Tests
 ----------------------
 
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index b46ae72..78816d9 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -7,22 +7,6 @@ test_description='Various filesystem issues'
 auml=$(printf '\303\244')
 aumlcdiar=$(printf '\141\314\210')
 
-unibad=
-test_expect_success 'see what we expect' '
-
-	test_unicode=test_expect_success &&
-	mkdir junk &&
-	>junk/"$auml" &&
-	case "$(cd junk && echo *)" in
-	"$aumlcdiar")
-		test_unicode=test_expect_failure &&
-		unibad=t
-		;;
-	*)	;;
-	esac &&
-	rm -fr junk
-'
-
 if test_have_prereq CASE_INSENSITIVE_FS
 then
 	say "will test on a case insensitive filesystem"
@@ -31,8 +15,14 @@ else
 	test_case=test_expect_success
 fi
 
-test "$unibad" &&
+if test_have_prereq UTF8_NFD_TO_NFC
+then
 	say "will test on a unicode corrupting filesystem"
+	test_unicode=test_expect_failure
+else
+	test_unicode=test_expect_success
+fi
+
 test_have_prereq SYMLINKS ||
 	say "will test on a filesystem lacking symbolic links"
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 52cb32a..95c966e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -670,6 +670,19 @@ test_lazy_prereq CASE_INSENSITIVE_FS '
 	test "$(cat CamelCase)" != good
 '
 
+test_lazy_prereq UTF8_NFD_TO_NFC '
+	# check whether FS converts nfd unicode to nfc
+	auml=$(printf "\303\244")
+	aumlcdiar=$(printf "\141\314\210")
+	>"$auml" &&
+	case "$(echo *)" in
+	"$aumlcdiar")
+		true ;;
+	*)
+		false ;;
+	esac
+'
+
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY
-- 
1.7.12.rc0.44.gc69a8ad
