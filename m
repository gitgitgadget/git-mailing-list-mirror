From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Wed, 02 Jan 2013 16:08:42 -0800
Message-ID: <7vpq1nyvp1.fsf@alter.siamese.dyndns.org>
References: <201301012240.10722.tboegi@web.de>
 <20130102094635.GD9328@sigill.intra.peff.net>
 <7vtxqzyw0g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 03 01:09:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqYMq-0004Rt-Iw
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 01:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab3ACAIq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 19:08:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39281 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838Ab3ACAIo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2013 19:08:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FC9AA025;
	Wed,  2 Jan 2013 19:08:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sgNkswDZg72h
	7Sq0clmc/tHGh3U=; b=RTsiC2uikXLXDD1m+hyf0ChNIZxPGth1LFUKw3gfnR8x
	LDmjKy3DOvL17VpCux/q098qdxR11UaVHfNFBQZaydFPfhMNfe9GO6njJ6v+11oT
	1Nf7gHJ9M9W7pzPCoQVFDHM0MmSl0MLd5UXFbCJArWlyxgsPhRm+0WHYhauuaP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N06Cxc
	xqPY8YClRY8oE6XfHClznnWOnGvaF0VI7fZ5cGDD1h4daX+H9tipJWuYcsmM3ORN
	xHL+fKWv/6sYpuSkZ14W99lBPxYkXRJAjJnmd7kO3x0Q8RFnyffCfDVjIeQ4xWT2
	/numcxD7H4JMyCPJToPiiFFgV5qYjaGBlC4To=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42036A023;
	Wed,  2 Jan 2013 19:08:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70A27A022; Wed,  2 Jan 2013
 19:08:43 -0500 (EST)
In-Reply-To: <7vtxqzyw0g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 02 Jan 2013 16:01:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC45695E-5539-11E2-BCC7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212561>

Junio C Hamano <gitster@pobox.com> writes:

> I would actually not add this to TEST_LINT by default, especially
> when "duplicates" and "executable" that are much simpler and less
> likely to hit false positives are not on by default.
>
> At least, a change to add this to TEST_LINT by default must wait to
> be merged to any integration branch until all the fix-up topics that
> this test triggers in the current codebase graduate to the branch.
>
>>> +test-lint-shell-syntax:
>>> +	$(PERL_PATH) check-non-portable-shell.pl $(T)
>>
>> This is wrong if $(PERL_PATH) contains spaces, no?
>
> You are correct; "harness" thing in the same Makefile gets this
> wrong, too.  I think the right invocation is:
>
> 	@'$(PERL_PATH_SQ)' check-non-portable.shell.pl $(T)
>
> although I do not offhand know if that symbol is already exported by
> the top-level Makefile.

I'll tentatively queue this instead.  The log message has also been
cleaned up a bit.

-- >8 --
=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>
Date: Thu, 3 Jan 2013 00:20:19 +0100
Subject: [PATCH] test: Add check-non-portable-shell.pl

Add the perl script "check-non-portable-shell.pl" to detect
non-portable shell syntax.

"echo -n" is an example of a shell command working on Linux, but not
on Mac OS X.

These shell commands are checked and reported as error:

 - "echo -n" (printf should be used)
 - "sed -i" (GNUism; use a temp file instead)
 - "declare" (bashism, often used with arrays)
 - "which" (unreliable exit status and output; use type instead)
 - "test a =3D=3D b" (bashism for "test a =3D b")

"make test-lint-shell-syntax" can be used to run only the check.

Helped-By: Jeff King <peff@peff.net>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/Makefile                    |  8 ++++++--
 t/check-non-portable-shell.pl | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100755 t/check-non-portable-shell.pl

diff --git a/t/Makefile b/t/Makefile
index 3025418..a43becb 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -16,6 +16,7 @@ DEFAULT_TEST_TARGET ?=3D test
=20
 # Shell quote;
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
+PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
=20
 T =3D $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 TSVN =3D $(sort $(wildcard t91[0-9][0-9]-*.sh))
@@ -43,7 +44,7 @@ clean-except-prove-cache:
 clean: clean-except-prove-cache
 	$(RM) .prove
=20
-test-lint: test-lint-duplicates test-lint-executable
+test-lint: test-lint-duplicates test-lint-executable test-lint-shell-s=
yntax
=20
 test-lint-duplicates:
 	@dups=3D`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` &&=
 \
@@ -55,6 +56,9 @@ test-lint-executable:
 		test -z "$$bad" || { \
 		echo >&2 "non-executable tests:" $$bad; exit 1; }
=20
+test-lint-shell-syntax:
+	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T)
+
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
 	$(MAKE) clean
@@ -87,7 +91,7 @@ test-results:
 	mkdir -p test-results
=20
 test-results/git-smoke.tar.gz: test-results
-	$(PERL_PATH) ./harness \
+	'$(PERL_PATH_SQ)' ./harness \
 		--archive=3D"test-results/git-smoke.tar.gz" \
 		$(T)
=20
diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
=2Epl
new file mode 100755
index 0000000..8b5a71d
--- /dev/null
+++ b/t/check-non-portable-shell.pl
@@ -0,0 +1,27 @@
+#!/usr/bin/perl
+
+# Test t0000..t9999.sh for non portable shell scripts
+# This script can be called with one or more filenames as parameters
+
+use strict;
+use warnings;
+
+my $exit_code=3D0;
+
+sub err {
+	my $msg =3D shift;
+	print "$ARGV:$.: error: $msg: $_\n";
+	$exit_code =3D 1;
+}
+
+while (<>) {
+	chomp;
+	/^\s*sed\s+-i/ and err 'sed -i is not portable';
+	/^\s*echo\s+-n/ and err 'echo -n is not portable (please use printf)'=
;
+	/^\s*declare\s+/ and err 'arrays/declare not portable';
+	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)=
';
+	/test\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b" is not portable (pl=
ease use =3D)';
+	# this resets our $. for each file
+	close ARGV if eof;
+}
+exit $exit_code;
--=20
1.8.1.203.gc241474
