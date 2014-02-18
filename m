From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RESEND] attr: allow pattern escape using backslashes
Date: Tue, 18 Feb 2014 11:38:34 -0800
Message-ID: <xmqqy518dxdx.fsf@gitster.dls.corp.google.com>
References: <1392429904-11559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 20:38:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFqVD-0002XB-H7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 20:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbaBRTim convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 14:38:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbaBRTil convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 14:38:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 038716D13E;
	Tue, 18 Feb 2014 14:38:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QwrAbTMwZ4cl
	BFqhLPshk/s1Moc=; b=Y8IbwJvHMO7mVBX1r8Ts/i4UyX8dee6djxB+fhwvBlPv
	eRDUaHiIgr3kAXgYGqPKBPZYYgYyMysdHK5KjkeiusHvd3opx0c9sckY8iaCcF0I
	QDTYaiCpOTu+y6lCOvYLFTdWJqViLkcjzjPfFxSqPVDroVGY0Aid/xOrSddCZCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=E4t9n4
	E9zqHCdjW2g8Xo0qGlkOYGTwUkrkXN00QBxXDsPZNeBn1m+28QlM0qWn5IH7/81O
	KCeXijNJBg73JsBqRc/v9i+ivgbLF8OOjpyykFGW/lvVzCOjTVCrumGtiyqD8EbH
	qzoa/fmeuNQpwf2tXv3L4+QIylMouvSGUMS0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D67A6D139;
	Tue, 18 Feb 2014 14:38:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DB896D137;
	Tue, 18 Feb 2014 14:38:37 -0500 (EST)
In-Reply-To: <1392429904-11559-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 15
 Feb 2014 09:05:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42C55118-98D4-11E3-A746-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242343>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Patterns in .gitattributes are separated by whitespaces, which makes
> it impossible to specify exact spaces in the pattern. '?' can be used
> as a workaround, but it matches other characters too. This patch make=
s
> a space following a backslash part of the pattern, not a pattern
> separator.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Last discussion is [1] although the thread went off topic, so no
>  actual discussion.

The only people who could get hurt with this patch are those who do
have a path that ends with a backslash (e.g. 'hello\') and have been
matching it with a pattern that literally match with it, but even
then they should have been quoting it at the end of the pattern
(e.g. as 'hello\\'), so the new parsing rule would not be confused,
I would think.

So, I like it.  Thanks.

> =20
>  [1] http://thread.gmane.org/gmane.comp.version-control.git/212631
>
>  Documentation/gitattributes.txt | 6 +++---
>  attr.c                          | 8 +++++++-
>  t/t0003-attributes.sh           | 5 +++++
>  3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattri=
butes.txt
> index 643c1ba..5d4d386 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -20,9 +20,9 @@ Each line in `gitattributes` file is of form:
> =20
>  	pattern	attr1 attr2 ...
> =20
> -That is, a pattern followed by an attributes list,
> -separated by whitespaces.  When the pattern matches the
> -path in question, the attributes listed on the line are given to
> +That is, a pattern followed by an attributes list, separated by
> +whitespaces that are not quoted by a backslash. When the pattern mat=
ches
> +the path in question, the attributes listed on the line are given to
>  the path.
> =20
>  Each attribute can be in one of these states for a given path:
> diff --git a/attr.c b/attr.c
> index 8d13d70..699716d 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -209,7 +209,13 @@ static struct match_attr *parse_attr_line(const =
char *line, const char *src,
>  	if (!*cp || *cp =3D=3D '#')
>  		return NULL;
>  	name =3D cp;
> -	namelen =3D strcspn(name, blank);
> +	namelen =3D 0;
> +	while (name[namelen] !=3D '\0' && !strchr(blank, name[namelen])) {
> +		if (name[namelen] =3D=3D '\\' && name[namelen + 1] !=3D '\0')
> +			namelen +=3D 2;
> +		else
> +			namelen++;
> +	}
>  	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
>  	    starts_with(name, ATTRIBUTE_MACRO_PREFIX)) {
>  		if (!macro_ok) {
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index b9d7947..2f16805 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -23,6 +23,7 @@ test_expect_success 'setup' '
>  		echo "offon -test test"
>  		echo "no notest"
>  		echo "A/e/F test=3DA/e/F"
> +		echo "A\\ b test=3Dspace"
>  	) >.gitattributes &&
>  	(
>  		echo "g test=3Da/g" &&
> @@ -195,6 +196,10 @@ test_expect_success 'root subdir attribute test'=
 '
>  	attr_check subdir/a/i unspecified
>  '
> =20
> +test_expect_success 'quoting in pattern' '
> +	attr_check "A b" space
> +'
> +
>  test_expect_success 'negative patterns' '
>  	echo "!f test=3Dbar" >.gitattributes &&
>  	git check-attr test -- '"'"'!f'"'"' 2>errors &&
