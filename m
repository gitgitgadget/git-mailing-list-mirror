From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Sun, 10 Apr 2016 12:01:30 -0700
Message-ID: <xmqq37qtthit.fsf@gitster.mtv.corp.google.com>
References: <570965B9.9040207@jupiterrise.com>
	<20160409210429.GB18989@sigill.intra.peff.net>
	<57098259.1060608@jupiterrise.com>
	<20160409223738.GA1738@sigill.intra.peff.net>
	<xmqqmvp2ti20.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Tom G. Christensen" <tgc@jupiterrise.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 10 21:02:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apKca-0004RQ-DS
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 21:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759706AbcDJTBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 15:01:35 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759397AbcDJTBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 15:01:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4564F52E62;
	Sun, 10 Apr 2016 15:01:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YKYKr/o5+De1pA8Ir/BoQcgOMoI=; b=b8rb3h
	9Lb0xkwDGik3C7F+U55gN/yOem9gWh+HofZEbTyTa2rCkjHj4R/oP/Q2IXppiNuJ
	n25g8jssLSD6/8hJKxrS1zqEfBUUsC1umkVYG97yDq/UPRazTjEKiPk662bsJliw
	QZIMPWYYeY/EB0iPKIRyXSThl2MGoyOndbR0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XVbjCAsN1TMlhSEcizeXXIK9f/m7sSnJ
	FlG2VYEVNUbvJniMN5ShES3N0B0Kg9xJtPITTJ7/HNTjtE1sGnAOUGFyxcV/BkUO
	rhrBNo1/m+58VlBDEZ0zBkylPSowiDz0IyXumr7oD/yKUILUjMTNY2rI8OF7FmQJ
	3Jsa/KeU/e0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E61A52E60;
	Sun, 10 Apr 2016 15:01:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9523452E5D;
	Sun, 10 Apr 2016 15:01:31 -0400 (EDT)
In-Reply-To: <xmqqmvp2ti20.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 09 Apr 2016 17:37:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A34241E4-FF4E-11E5-A071-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291186>

Junio C Hamano <gitster@pobox.com> writes:

> I looked at
>
>     $ git grep -c '#! */bin/sh' t | grep -v ':1$'
>
> and did a few just for fun.  Doing it fully may be a good
> microproject for next year ;-)
>
>  t/t1020-subdirectory.sh       |  6 +++---
>  t/t2050-git-dir-relative.sh   | 11 ++++++-----
>  t/t3404-rebase-interactive.sh |  7 +++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
> index 8e22b03..6dedb1c 100755
> --- a/t/t1020-subdirectory.sh
> +++ b/t/t1020-subdirectory.sh
> @@ -142,9 +142,9 @@ test_expect_success 'GIT_PREFIX for built-ins' '
>  	# Use GIT_EXTERNAL_DIFF to test that the "diff" built-in
>  	# receives the GIT_PREFIX variable.
>  	printf "dir/" >expect &&
> -	printf "#!/bin/sh\n" >diff &&
> -	printf "printf \"\$GIT_PREFIX\"" >>diff &&
> -	chmod +x diff &&
> +	write_script diff <<-\EOF &&
> +	printf "%s" "$GIT_PREFIX"
> +	EOF
>  	(
>  		cd dir &&
>  		printf "change" >two &&

Regarding this one, I notice that "expect" and "actual" (produced
later in this script by executing "diff" script) are eventually
compared by test_cmp, which runs "diff" to show the actual
differences.  If we are doing this modernization to use write_script
more, we probably should make "expect" and "actual" text files that
end with a complete line.

I.e.

-- >8 --
Subject: t1020: do not overuse printf and use write_script

The test prepares a sample file "dir/two" with a single incomplete
line in it with "printf", and also prepares a small helper script
"diff" to create a file with a single incomplete line in it, again
with "printf".  The output from the latter is compared with an
expected output, again prepared with "printf" hance lacking the
final LF.  There is no reason for this test to be using files with
an incomplete line at the end, and these look more like a mistake
of not using

	printf "%s\n" "string to be written"

and using

	printf "string to be written"

Depending on what would be in $GIT_PREFIX, using the latter form
could be a bug waiting to happen.  Correct them.

Also, the test uses hardcoded #!/bin/sh to create a small helper
script.  For a small task like what the generated script does, it
does not matter too much in that what appears as /bin/sh would not
be _so_ broken, but while we are at it, use write_script instead,
which happens to make the result easier to read by reducing need
of one level of quoting.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1020-subdirectory.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 8e22b03..df3183e 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -141,13 +141,13 @@ test_expect_success 'GIT_PREFIX for !alias' '
 test_expect_success 'GIT_PREFIX for built-ins' '
 	# Use GIT_EXTERNAL_DIFF to test that the "diff" built-in
 	# receives the GIT_PREFIX variable.
-	printf "dir/" >expect &&
-	printf "#!/bin/sh\n" >diff &&
-	printf "printf \"\$GIT_PREFIX\"" >>diff &&
-	chmod +x diff &&
+	echo "dir/" >expect &&
+	write_script diff <<-\EOF &&
+	printf "%s\n" "$GIT_PREFIX"
+	EOF
 	(
 		cd dir &&
-		printf "change" >two &&
+		echo "change" >two &&
 		GIT_EXTERNAL_DIFF=./diff git diff >../actual
 		git checkout -- two
 	) &&
