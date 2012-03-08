From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Thu, 08 Mar 2012 13:31:29 -0800
Message-ID: <7vr4x2bwzy.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <4F57D18B.5090506@lsrfire.ath.cx> <7vzkbskr71.fsf@alter.siamese.dyndns.org>
 <4F58F06A.1070108@lsrfire.ath.cx> <7v1up2ew9u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Mar 08 22:31:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5kvx-00039X-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 22:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784Ab2CHVbc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 16:31:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab2CHVbb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 16:31:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43EC678DD;
	Thu,  8 Mar 2012 16:31:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8JSq2Joe5ewd
	f8n55VPM0jNamZE=; b=WU7x8Vhx96bh3+gZtjKHUubKw3rFGOPKWSsoG2X7Jtsl
	gt61LzNqk3E7wWtGEcGuITLO66mSuHctbbHPCvjZ4wnJkTDiSR6MYImi3E6TpR5Z
	OIjId0YIkgFeieKiMJqloOtS4dS7ChEgYtdKAdy5EkO5/JFM0jf/HaoiOhz+45g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FYuhtN
	fo94FrgaJAVEGhgqvK5cEX8nEHIqA848Gu3NZduJ/3wCZtiJM9+VJmAumyN24iaT
	1TeUIhxSw0RKJ40euFd5XbmApaYBbqLomzwS79+NIHBR/m0e7WPhXsLOOB1NuFmI
	Jikaffc7Gq1NJOlrDbYvNyY+5bYFtEDwD+pSg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3894378DC;
	Thu,  8 Mar 2012 16:31:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3A7078DA; Thu,  8 Mar 2012
 16:31:30 -0500 (EST)
In-Reply-To: <7v1up2ew9u.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 08 Mar 2012 11:18:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11F740B8-6966-11E1-A9A2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192653>

Junio C Hamano <gitster@pobox.com> writes:

>> Three of the five callers introduced in that commit cast the result =
to
>> int and the remaining two don't care, so it actually does seem to
>> matter for most of them, strictly speaking.  When I see a nit, I can=
't
>> resist the urge to pick it, apparently.
>
> Unfortunately, replacing intptr_t with int or casting the above
> again as int will result in
>
> builtin/fmt-merge-msg.c: In function 'record_person':
> builtin/fmt-merge-msg.c:213: error: cast to pointer from integer of d=
ifferent size
>
> So...

-- >8 --
Subject: [PATCH] fmt-merge-msg.c: make util_as_int() return "int"

As its name says, the return value from util_as_int() should be
usable where an int is called for without casting.

Spotted-by: Ren=C3=A9 Scharfe
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fmt-merge-msg.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 40b90b1..8ddefb3 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -182,7 +182,7 @@ static void add_branch_desc(struct strbuf *out, con=
st char *name)
 	strbuf_release(&desc);
 }
=20
-#define util_as_int(elem) ((intptr_t)((elem)->util))
+#define util_as_int(elem) ((int)((elem)->util))
=20
 static void record_person(int which, struct string_list *people,
 			  struct commit *commit)
@@ -210,7 +210,7 @@ static void record_person(int which, struct string_=
list *people,
 		elem =3D string_list_insert(people, name_buf);
 		elem->util =3D (void *)0;
 	}
-	elem->util =3D (void*)(util_as_int(elem) + 1);
+	elem->util =3D (void*)((intptr_t)(util_as_int(elem) + 1));
 }
=20
 static int cmp_string_list_util_as_int(const void *a_, const void *b_)
@@ -226,13 +226,13 @@ static void add_people_count(struct strbuf *out, =
struct string_list *people)
 	else if (people->nr =3D=3D 2)
 		strbuf_addf(out, "%s (%d) and %s (%d)",
 			    people->items[0].string,
-			    (int)util_as_int(&people->items[0]),
+			    util_as_int(&people->items[0]),
 			    people->items[1].string,
-			    (int)util_as_int(&people->items[1]));
+			    util_as_int(&people->items[1]));
 	else if (people->nr)
 		strbuf_addf(out, "%s (%d) and others",
 			    people->items[0].string,
-			    (int)util_as_int(&people->items[0]));
+			    util_as_int(&people->items[0]));
 }
=20
 static int committer_is_me(const char *name)
--=20
1.7.10.rc0.28.g709d0
