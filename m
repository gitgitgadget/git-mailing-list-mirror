From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] attr.c: rename global var attr_nr to git_attr_nr
Date: Tue, 09 Dec 2014 15:54:04 -0800
Message-ID: <xmqq1to8l6qr.fsf@gitster.dls.corp.google.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
	<1418133205-18213-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 00:54:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyUbe-0003oz-Bp
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 00:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbaLIXyK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 18:54:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751013AbaLIXyI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 18:54:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 993C825A29;
	Tue,  9 Dec 2014 18:54:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Gj/qzrpDQrgx
	lX6OXkdy1ngxiUQ=; b=a6bOtMW9I6ke/Vdq1N2jFVed3olDDqmGotWqaMMblELH
	hyJPbC0flZtT+E3sumOfAD4Kd6gKKBP+Q+5YKoL9zADjN00QzC3CkWBOsN8MWh1s
	J3rFveS/kJTgbQszjjsmHfw557RRqPvx0UvrKZlB4eTE2y/dscagoqexFVosDuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pYBNB2
	CU0D17GnWHjGQTa37FV4jrcAiO+O5Q9Oc6Avxz27DMujHSG95ICiSAlF1lbZoCuM
	RwP0fDNRQ4wk6MEYo146WSm8w/3Egdh7ODTqLzHdvE54nOykFAbNUZrEBVoneJwy
	huo4sLtB68IlEwg70JtND7vJErI9z4vHffCa8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F6F425A28;
	Tue,  9 Dec 2014 18:54:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BE9A25A27;
	Tue,  9 Dec 2014 18:54:05 -0500 (EST)
In-Reply-To: <1418133205-18213-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 9 Dec
 2014 20:53:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8EEEF46-7FFE-11E4-AAA4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261179>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This name "attr_nr" is used elsewhere as local variable, shadowing th=
e
> global one. Let's rename the global one into something else to avoid
> accidents due to shadow in future.

Even though I do not think I would reject a patch to add this entire
file if the variable were named git_attr_nr from day one (read: the
result of the patch is not wrong per-se), I am not sure if the
variable deserves "git_" prefix that makes it look as if it may need
to be protected from global namespace contamination, given that this
is a file-scope static.

It might make a lot more sense not to do this rename, but change the
first parameter of macroexpand_one() from attr_nr to something more
appropriate, like "struct git_attr *attr"?

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  attr.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index cd54697..583d36a 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -34,7 +34,7 @@ struct git_attr {
>  	int attr_nr;
>  	char name[FLEX_ARRAY];
>  };
> -static int attr_nr;
> +static int git_attr_nr;
> =20
>  static struct git_attr_check *check_all_attr;
>  static struct git_attr *(git_attr_hash[HASHSIZE]);
> @@ -94,10 +94,10 @@ static struct git_attr *git_attr_internal(const c=
har *name, int len)
>  	a->name[len] =3D 0;
>  	a->h =3D hval;
>  	a->next =3D git_attr_hash[pos];
> -	a->attr_nr =3D attr_nr++;
> +	a->attr_nr =3D git_attr_nr++;
>  	git_attr_hash[pos] =3D a;
> =20
> -	REALLOC_ARRAY(check_all_attr, attr_nr);
> +	REALLOC_ARRAY(check_all_attr, git_attr_nr);
>  	check_all_attr[a->attr_nr].attr =3D a;
>  	check_all_attr[a->attr_nr].value =3D ATTR__UNKNOWN;
>  	return a;
> @@ -730,10 +730,10 @@ static void collect_all_attrs(const char *path)
>  	}
> =20
>  	prepare_attr_stack(path, dirlen);
> -	for (i =3D 0; i < attr_nr; i++)
> +	for (i =3D 0; i < git_attr_nr; i++)
>  		check_all_attr[i].value =3D ATTR__UNKNOWN;
> =20
> -	rem =3D attr_nr;
> +	rem =3D git_attr_nr;
>  	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
>  		rem =3D fill(path, pathlen, basename_offset, stk, rem);
>  }
> @@ -762,7 +762,7 @@ int git_all_attrs(const char *path, int *num, str=
uct git_attr_check **check)
> =20
>  	/* Count the number of attributes that are set. */
>  	count =3D 0;
> -	for (i =3D 0; i < attr_nr; i++) {
> +	for (i =3D 0; i < git_attr_nr; i++) {
>  		const char *value =3D check_all_attr[i].value;
>  		if (value !=3D ATTR__UNSET && value !=3D ATTR__UNKNOWN)
>  			++count;
> @@ -770,7 +770,7 @@ int git_all_attrs(const char *path, int *num, str=
uct git_attr_check **check)
>  	*num =3D count;
>  	*check =3D xmalloc(sizeof(**check) * count);
>  	j =3D 0;
> -	for (i =3D 0; i < attr_nr; i++) {
> +	for (i =3D 0; i < git_attr_nr; i++) {
>  		const char *value =3D check_all_attr[i].value;
>  		if (value !=3D ATTR__UNSET && value !=3D ATTR__UNKNOWN) {
>  			(*check)[j].attr =3D check_all_attr[i].attr;
