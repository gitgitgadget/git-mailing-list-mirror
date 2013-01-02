From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2] t9810: Do not use sed -i
Date: Wed, 02 Jan 2013 15:06:28 -0800
Message-ID: <7vhamz18y3.fsf@alter.siamese.dyndns.org>
References: <201301020020.38535.tboegi@web.de>
 <20130102224446.GA12363@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 00:06:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqXOd-0003LK-HL
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 00:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab3ABXGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 18:06:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40375 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206Ab3ABXGb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2013 18:06:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31707ABAB;
	Wed,  2 Jan 2013 18:06:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YVjUbkzU7IL0
	TWlxMK04Q+/7NBE=; b=UjUAR1tqcJk/NzDTxzbCa//R0d1FxKwzdnAZh4g1Pfsa
	TzCCDwSaC/VFpXFB7+NQunk1pIDhMsZl0yS6Bovp6FXVhM5sbTlzOk/nEwSwddbH
	PKB6+3hBbdyA7STQEOR2k9pmMTdK+zv8cSW6srjBrLYUj63leSo5kWYkwecgZlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jJs9C5
	9Y79GqGsF4uN1F8JcQbbEzQRIfDJw3MUSEFvWhX4UEUsGnBE073/FKk+3twWf2ZT
	D5X332NI8gzUuGpQj1+rQTcWBKsHZ0w7ip1OmIciceqRPnLzQ+sSc/G8aZV/NTJx
	QymgjmNbpBqcZGg4rNZcWWRH+QjkuYqHfJCW4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22B15ABAA;
	Wed,  2 Jan 2013 18:06:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48755ABA9; Wed,  2 Jan 2013
 18:06:30 -0500 (EST)
In-Reply-To: <20130102224446.GA12363@padd.com> (Pete Wyckoff's message of
 "Wed, 2 Jan 2013 17:44:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B219308-5531-11E2-95B4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212552>

Pete Wyckoff <pw@padd.com> writes:

> tboegi@web.de wrote on Wed, 02 Jan 2013 00:20 +0100:
>> sed -i is not portable on all systems.
>> Use sed with different input and output files.
>> Utilize a tmp file whenever needed
>>=20
>> Added missing && at 2 places
>>=20
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> One more teensy fix is needed in this hunk, following Junio's
> comment about redirections going at the end:

I've already pushed out the previous one on 'pu' after fixing it up
like this.

Thanks.  Anything I missed?

Date: Tue, 1 Jan 2013 22:40:37 +0100
Subject: [PATCH] t9810: Do not use sed -i

sed -i is not portable on all systems.  Use sed with different input
and output files.  Utilize a tmp file whenever needed.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9810-git-p4-rcs.sh | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 0c2fc3e..34fbc90 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -26,10 +26,8 @@ test_expect_success 'init depot' '
 		line7
 		line8
 		EOF
-		cp filek fileko &&
-		sed -i "s/Revision/Revision: do not scrub me/" fileko
-		cp fileko file_text &&
-		sed -i "s/Id/Id: do not scrub me/" file_text
+		sed "s/Revision/Revision: do not scrub me/" <filek >fileko &&
+		sed "s/Id/Id: do not scrub me/" <fileko >file_text &&
 		p4 add -t text+k filek &&
 		p4 submit -d "filek" &&
 		p4 add -t text+ko fileko &&
@@ -88,7 +86,8 @@ test_expect_success 'edit far away from RCS lines' '
 	(
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
-		sed -i "s/^line7/line7 edit/" filek &&
+		sed "s/^line7/line7 edit/" <filek >filek.tmp &&
+		mv -f filek.tmp filek &&
 		git commit -m "filek line7 edit" filek &&
 		git p4 submit &&
 		scrub_k_check filek
@@ -105,7 +104,8 @@ test_expect_success 'edit near RCS lines' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.attemptRCSCleanup true &&
-		sed -i "s/^line4/line4 edit/" filek &&
+		sed "s/^line4/line4 edit/" <filek >filek.tmp &&
+		mv -f filek.tmp filek &&
 		git commit -m "filek line4 edit" filek &&
 		git p4 submit &&
 		scrub_k_check filek
@@ -122,7 +122,8 @@ test_expect_success 'edit keyword lines' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.attemptRCSCleanup true &&
-		sed -i "/Revision/d" filek &&
+		sed "/Revision/d" <filek >filek.tmp &&
+		mv -f filek.tmp filek &&
 		git commit -m "filek remove Revision line" filek &&
 		git p4 submit &&
 		scrub_k_check filek
@@ -139,7 +140,8 @@ test_expect_success 'scrub ko files differently' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.attemptRCSCleanup true &&
-		sed -i "s/^line4/line4 edit/" fileko &&
+		sed "s/^line4/line4 edit/" <fileko >fileko.tmp &&
+		mv -f fileko.tmp fileko &&
 		git commit -m "fileko line4 edit" fileko &&
 		git p4 submit &&
 		scrub_ko_check fileko &&
@@ -189,12 +191,14 @@ test_expect_success 'do not scrub plain text' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.attemptRCSCleanup true &&
-		sed -i "s/^line4/line4 edit/" file_text &&
+		sed "s/^line4/line4 edit/" <file_text >file_text.tmp &&
+		mv -f file_text.tmp file_text &&
 		git commit -m "file_text line4 edit" file_text &&
 		(
 			cd "$cli" &&
 			p4 open file_text &&
-			sed -i "s/^line5/line5 p4 edit/" file_text &&
+			sed "s/^line5/line5 p4 edit/" <file_text >file_text.tmp &&
+			mv -f file_text.tmp file_text &&
 			p4 submit -d "file5 p4 edit"
 		) &&
 		echo s | test_expect_code 1 git p4 submit &&
--=20
1.8.1.203.gc241474
