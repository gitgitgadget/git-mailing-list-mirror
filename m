From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/11] grep: break down an "if" stmt in preparation for next changes
Date: Tue, 09 Feb 2016 10:20:04 -0800
Message-ID: <xmqqd1s54ugb.fsf@gitster.mtv.corp.google.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
	<1454724190-14063-1-git-send-email-pclouds@gmail.com>
	<1454724190-14063-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 19:20:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTCtb-0007NT-NE
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 19:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252AbcBISUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2016 13:20:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757245AbcBISUI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2016 13:20:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC613412D6;
	Tue,  9 Feb 2016 13:20:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lLp1R9PXpqGs
	5CipRK1wT9+zLUQ=; b=U7DlxkIjSrVb2mc68njzsj7k8fwf8NVgRkPVghMfVvwt
	7TyeBEZnJwmnWRriymh6Ya8gpC4oDri7bn7AM1a2SRNtoUEuvGJlXnIhEkveSA27
	G8ktJQqahksPkD7Nrej3Cv3zTUAo919YkFW5jaMv3F/Rq72Kvq33waQEgHWANK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qFzD6e
	OhlL6zs+MFljKfDNO5WUPBHyg4uY7Y4ju0DThGVGcWEJcceTbWK/JLUJp9virCWP
	FTTy4/x124h0YOcf0FPUfIEUgqLnywLUTWFpZFTSUV9lFEtcbcjhKD8//5usZz6K
	jt2Vp7RBfmwc/l+jwp8zrFx0QpZWcJA4przwk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2965412D5;
	Tue,  9 Feb 2016 13:20:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 49403412D0;
	Tue,  9 Feb 2016 13:20:07 -0500 (EST)
In-Reply-To: <1454724190-14063-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 6 Feb
 2016 09:03:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BF4BC38A-CF59-11E5-BE20-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285846>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  grep.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 7b2b96a..e739d20 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -403,9 +403,11 @@ static void compile_regexp(struct grep_pat *p, s=
truct grep_opt *opt)
>  	p->word_regexp =3D opt->word_regexp;
>  	p->ignore_case =3D opt->ignore_case;
> =20
> -	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
> +	if (is_fixed(p->pattern, p->patternlen))
>  		p->fixed =3D 1;
> -	else
> +	else if (opt->fixed) {
> +		p->fixed =3D 1;
> +	} else
>  		p->fixed =3D 0;

The original used to check inexpensive one first and then more
expensive one.  The updated one gets it backwards.

Is that intended?


> =20
>  	if (p->fixed) {
