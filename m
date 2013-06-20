From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] send-email: add test for duplicate utf8 name
Date: Thu, 20 Jun 2013 12:20:34 -0700
Message-ID: <7vppvgtwql.fsf@alter.siamese.dyndns.org>
References: <1371731166-24015-1-git-send-email-mst@redhat.com>
	<1371731166-24015-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"\=\?UTF-8\?q\?SZEDER\=20G\=C3\=A1bor\?\=" <szeder@ira.uka.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 21:20:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpkPS-0002sV-K9
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 21:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758529Ab3FTTUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jun 2013 15:20:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758252Ab3FTTUh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 15:20:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABA7629B3B;
	Thu, 20 Jun 2013 19:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=pDX4kCjbIhQNApnDWzyDfgvSH
	V8=; b=klaYz89aGyD8Mn3aGBQJapat5a1+kFSTtlWDAtuZiailvH/P81qYmmboD
	LZpJA6tLZhOZRG4irb3SBqmWYdzkKNr4j7b04wShpbaWA9wGDZ5N1gY10pkc7xoB
	fbeTtIdAyO1Vt0jKkmApaUFOLW0JQqvurL3XEJb+9jQTmh14iY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Lvcjk6WQc9DAs3sNTHL
	P0/jRHT2OvDsEEB/N7YwmhWCsjh7vRjWajcv0DIAbfxQhy4MgqdhFVYkECG/WT/2
	jsCv861X848OxQ6oiIxm9bpnFG1VS/pkszbwdhRe3ZTxATabbicXNVoxLKDQ+p2s
	iEp5/5qxAWh8j4IrWzoIRqwc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BE1E29B39;
	Thu, 20 Jun 2013 19:20:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A81D329B2B;
	Thu, 20 Jun 2013 19:20:35 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BC4901A-D9DE-11E2-B557-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228523>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Verify that author name is not duplicated if it matches
> sender, even if it is in utf8.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Hmph.  There seems to be something wrong in the original message I
received from you (look at Cc: line I have above, which was copied
by my MUA from the message I am responding to).

Visiting

  http://article.gmane.org/gmane.comp.version-control.git/228485/raw

shows this gem:

  Cc: =3D?us-ascii?B?PT9VVEYtOD9xP1NaRURFUj0yMEc9QzM9QTFib3I/PQ=3D=3D?=3D=
=20
     <szeder@ira.uka.de>

Somebody is wrapping what "=3D?UTF-8?q?..." which you had already
wrapped into "=3D?us-ascii?B..."???

In any case, I think Thomas's "first expect failure and then flip
it, if you add test and fix as separate patches" is a good idea, and
the change between the previous one and this seems to be only the
last part of this test, so I'll tweak what I already have from the
previous on 'pu' locally and push the result out.  Please double
check the result.

Thanks.

>  t/t9001-send-email.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 9f46f22..020acc4 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -956,6 +956,20 @@ test_expect_success $PREREQ 'utf8 author is corr=
ectly passed on' '
>  	grep "^From: F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd_?=3Dmail@exam=
ple.com>" msgtxt1
>  '
> =20
> +test_expect_success $PREREQ 'utf8 sender is not duplicated' '
> +	clean_fake_sendmail &&
> +	test_commit weird_sender &&
> +	test_when_finished "git reset --hard HEAD^" &&
> +	git commit --amend --author "F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <o=
dd_?=3Dmail@example.com>" &&
> +	git format-patch --stdout -1 >funny_name.patch &&
> +	git send-email --from=3D"F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd_?=
=3Dmail@example.com>" \
> +	  --to=3Dnobody@example.com \
> +	  --smtp-server=3D"$(pwd)/fake.sendmail" \
> +	  funny_name.patch &&
> +	grep "^From:" msgtxt1 > msgfrom &&
> +	test_line_count =3D 1 msgfrom
> +'
> +
>  test_expect_success $PREREQ 'sendemail.composeencoding works' '
>  	clean_fake_sendmail &&
>  	git config sendemail.composeencoding iso-8859-1 &&
