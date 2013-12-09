From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: move the trailing space out of translatable strings
Date: Mon, 09 Dec 2013 11:46:47 -0800
Message-ID: <xmqqeh5lzu1k.fsf@gitster.dls.corp.google.com>
References: <1386468704-18339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 20:47:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq6nC-0001KV-Dk
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 20:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab3LITqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Dec 2013 14:46:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755917Ab3LITqx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Dec 2013 14:46:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2FAA599E2;
	Mon,  9 Dec 2013 14:46:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mnu9BHVQYlfs
	N0870Z8575aliBs=; b=q+sNXscPyJ2W2CVNr5Lzcpb23FbyBx2UhnQBzIyK7HVK
	5P6ar4ZS0rNOHSlEQknpg0wFOxPAS38SliYC2t/ZP1vvBNoU0V/BkiMnYU7htXwA
	ucHsqALcXd+NTruhmUdTQr30Q8i/9/mASOZ0i8Ufrk9EQy+JyLjxN8K/9QBPjUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rvfIJM
	ZeR42ZdVX8JNQgzOgp6+lQWtOpZ4iTrqqbi5JtAT5ycWWpwJzRGGcMs30ThPRspq
	yWVfC0p5mofF/NlP6p10dWZ4zOMhCR/svmTk2ftYYs+pMEtCryVPzB7+lzZZ9zPH
	FFer+eFpmrf4vyParuXn5hnpFAT3ggZDE/VQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0564599E1;
	Mon,  9 Dec 2013 14:46:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4FD7599E0;
	Mon,  9 Dec 2013 14:46:48 -0500 (EST)
In-Reply-To: <1386468704-18339-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 8 Dec
 2013 09:11:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A48D05C8-610A-11E3-AD5A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239083>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> I've got this with Vietnamese translation
>
>     $ git status
>     HEAD =C4=91=C6=B0=E1=BB=A3c t=C3=A1ch r=E1=BB=9Di t=E1=BB=ABorigi=
n/master
>
> One does not need to understand Vietnamese to see that a space is
> missing before "origin/master"...

Not really.  Only if one guesses (or knows) that Vietnamese is among
the languages that use SP to separate words.  There are languages
that do not use inter-word spaces.

Because those languages are in the minority, it would be easier to
unconditionally add SP after translatable string regardless of the
l10n target languages, but I am afraid that it is going in a wrong
direction in the longer term.

>  		clean_print_color(CLEAN_COLOR_PROMPT);
> -		printf(_("Input ignore patterns>> "));
> +		printf("%s ", _("Input ignore patterns>>"));
>  		clean_print_color(CLEAN_COLOR_RESET);

As this space after the prompt may be different from inter-word
space after all, this one may probably be on the borderline.

> @@ -754,7 +754,8 @@ static int ask_each_cmd(void)
>  		/* Ctrl-D should stop removing files */
>  		if (!eof) {
>  			qname =3D quote_path_relative(item->string, NULL, &buf);
> -			printf(_("remove %s? "), qname);
> +			printf(_("remove %s?"), qname);
> +			putchar(' ');

As is this change.

But it is an example that can be used to illustrate my earlier
point.  The l10n target language may want to have _no_ space between
words, i.e. to turn the above into:

	printf("%s=E3=82=92=E5=89=8A=E9=99=A4=E3=81=97=E3=81=BE=E3=81=99=E3=81=
=8B?", qname);
        putchar(' ');

i.e. no space between the object of the verb ("the path being
removed") and the verb ("to remove"), while still wanting to have SP
between the prompt and its answer like everybody else.  And having
SP after "remove" in the gettext key _is_ a good thing, as l10n
people can choose not to have any SP between the verb and its
object.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 874e0fd..d48ccee 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -551,12 +551,12 @@ static void update_remote_refs(const struct ref=
 *refs,
> =20
>  	if (check_connectivity) {
>  		if (transport->progress)
> -			fprintf(stderr, _("Checking connectivity... "));
> +			fprintf(stderr, _("Checking connectivity..."));
>  		if (check_everything_connected_with_transport(iterate_ref_map,
>  							      0, &rm, transport))
>  			die(_("remote did not send all necessary objects"));
>  		if (transport->progress)
> -			fprintf(stderr, _("done.\n"));
> +			fprintf(stderr, " %s", _("done.\n"));

But I think that this changes enforces the inter-word SP policy that
could go against convention by specific l10n target languages.
