From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] tree_entry_interesting(): support negative pathspec
Date: Tue, 14 Sep 2010 09:18:20 -0700
Message-ID: <7vd3sg8fjn.fsf@alter.siamese.dyndns.org>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
 <1283961023-4491-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 18:18:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvYDQ-0003YR-FD
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 18:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892Ab0INQSd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 12:18:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0INQSc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 12:18:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E573D60A3;
	Tue, 14 Sep 2010 12:18:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WF2EZx1GSfOU
	fgs7heOCzglRbYs=; b=dBGxBfp1KlYmyYYpeP+T297++8meHcseE2bfMpeJKBHq
	q10DN3fr5T9GjsVgyu6Aaap7fxZwGU+aSf5LcUBn/7SNws4HSO6c8CArkErFx7oH
	Ct9oO5H1FPRycRXtozVYiY03pl6HLve21VZhLbInE392bbofqhhC8rFukH8GPos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S9kEew
	WLN6qYp+8KCXfaPP+/4LnOG1WEnJRXwA5oKJSgxtEVh8FstDGrPPF6Ljsy3tjuib
	4MXJMOV7EV7jhdgbW9ESAnlMUlUxToz+KoSqd/sEeWeKBuN16xs7YXiaRqW2VuUi
	la/XSK0poCUvMnsLwF8bfDHcsYASEXPUm81K4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 081C1D60A1;
	Tue, 14 Sep 2010 12:18:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3C77D609D; Tue, 14 Sep
 2010 12:18:21 -0400 (EDT)
In-Reply-To: <1283961023-4491-9-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\,  9 Sep
 2010 01\:50\:23 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B523574A-C01B-11DF-8D5A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156199>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  t/t9999-test.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++

If this is about the basic tree traversal logic, that belongs somewhere=
 in
2xxx series.  You seem to be testing only diff-tree and nothing else, s=
o I
suspect that you shouldn't even consume a new test number but just addi=
ng
a new test or two to 4013 should suffice.

> +test_expect_success 'diff' '
> +	cat >expected <<-\EOF &&

What's the point of the dash in "<<-\EOF" if you are not going to inden=
t
the here doc?

> +:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5b=
b6fa28c517a0bb32b8b506539d4d M	one/file
> +:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5b=
b6fa28c517a0bb32b8b506539d4d M	one/two/file
> +:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 d00491fd7e5b=
b6fa28c517a0bb32b8b506539d4d M	one/zoo
> +EOF

Outside t0xxx series please avoid making the test depend on absolute
object names like this.  Since you are using only two blobs, you could
run two hash-objects to learn the hash for "" and "1\n" and say

	cat >expected <<-EOF &&
	:100644 100644 $none $one M	one/file
        ...
	EOF

Better yet, think if you even need the raw output here?  Perhaps using
output formats like --name-only or --name-status is more appropriate an=
d
make the test more readable?

> diff --git a/tree-walk.c b/tree-walk.c
> index a2f4a00..fd19681 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -532,7 +532,7 @@ int tree_entry_interesting(const struct name_entr=
y *entry, const char *base, int
> =20
>  	pathlen =3D tree_entry_len(entry->path, entry->sha1);
> =20
> -	for (i =3D 0; i < ps->nr; i++) {
> +	for (i =3D ps->nr-1; i >=3D 0; i--) {

No explanation in the commit log message why.  Besides, spell binary "-=
"
operator with a SP each on both ends, please.

Also the code seems to use a new term subpathspec without defining nor
explaining.  Not good.
