From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t6044 broken on pu
Date: Sun, 08 May 2016 11:20:14 -0700
Message-ID: <xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
	<878tzmrrfg.fsf@linux-m68k.org>
	<d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
	<xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
	<5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 08 20:20:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azTJY-0007Hj-E3
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 20:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbcEHSUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 14:20:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751053AbcEHSUS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2016 14:20:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FE9718FD2;
	Sun,  8 May 2016 14:20:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nFG/vFdh4lIb
	U0GrTHWdnAwjMf4=; b=Tsm67ZJ+YVc8JaEMMgeZ5RKq0s2sFvD+9Q2qbUw9wFa2
	KhKQcOg78hgW3jrKVfX1sb+Si0MWirkCglMvUHA/0rMFZBL7FXpN/6hW7lrvIwAE
	hjUJgmbZxj7E4OGjgGDoRTHJH+oPf1TluE28vltPFGAyd4gwJTK/D/aZzMI2EPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yc9jB+
	PDAPZZ+Y4yP8zVjnPThCdwXup0F1pYheHukCv7oyoRp/X6dmhE32bR7TrLciRfcv
	3Rhvtpor0Como6HhCSvYGO+AewB4dLplNfqyzel0uC+LEqAHZyPqsdY9G4yWlPP1
	0Cnt422aVPZPfZ6COcEqZFKpySbsiO5b7K9k0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 068E618FD1;
	Sun,  8 May 2016 14:20:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8690718FD0;
	Sun,  8 May 2016 14:20:16 -0400 (EDT)
In-Reply-To: <5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sun, 8 May 2016 08:54:06
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8393238E-1549-11E6-B99E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293971>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> May a  simple
>  printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n"
>
> be an option ?

If you were to do that, at least have the decency to make it more
readable by doing something like:

	printf "%s\n" 1 2 3 4 5 6 7 8 9 10

;-)

But as I said, as a response to "t6044 broken on pu" bug report,
s/seq/test_seq/ is the only sensible change.

Improving "test_seq, the alternative to seq" is a separate topic.

If you have aversion to $PERL, perhaps do them without using
anything what is not expected to be built-in in modern shells,
perhaps like this?

 t/test-lib-functions.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8d99eb3..4edddac 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -739,7 +739,12 @@ test_seq () {
 	2)	;;
 	*)	error "bug in the test script: not 1 or 2 parameters to test_seq" =
;;
 	esac
-	perl -le 'print for $ARGV[0]..$ARGV[1]' -- "$@"
+	test_seq_counter__=3D$1
+	while test "$test_seq_counter__" -le $2
+	do
+		echo "$test_seq_counter__"
+		test_seq_counter__=3D$((test_seq_counter__ + 1))
+	done
 }
=20
 # This function can be used to schedule some commands to be run
