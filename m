From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] log-tree: let format-patch not indent notes
Date: Thu, 25 Sep 2014 10:24:53 -0700
Message-ID: <xmqqeguzboka.fsf@gitster.dls.corp.google.com>
References: <1411661409-24562-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Sep 25 19:25:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXCmr-0005Fi-6J
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 19:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbaIYRY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2014 13:24:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52132 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbaIYRY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2014 13:24:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7DA483C7CE;
	Thu, 25 Sep 2014 13:24:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DwJcGTSkpMKn
	dGDPDiwgtgAGwC8=; b=EV3lFQt5IGXj2Rat+acW1267+ZHWg77yg5T7WG69nwhB
	mu0izkATZcx5YnPrW5dzj1h3NXF2iepmYxLXedSQ/Y5zOh8k7ijvSEZDzGhDF0SD
	B6zFskx9WLETNZUyK9Lze1QHdP4IbIFhQ81IWQgSaTEItbCBgi5pJfpJ8OwHv+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HPMUEn
	alJv1yHfygUKnMvdwXUXzuWh1VCI+CFFSgGlcgLRGyvSdC1sIDBpm2lMGEbC9ukY
	IU6GHZcRfBiJzDcBYWKeJskWhzpdIfksg1enSbA/rLV9V/YengBS7brsvidR74ZK
	ozmi9E2gaOjPXiarGFmqOOj/UNelszYZHzk0U=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 737523C7CC;
	Thu, 25 Sep 2014 13:24:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EEE723C7CB;
	Thu, 25 Sep 2014 13:24:54 -0400 (EDT)
In-Reply-To: <1411661409-24562-1-git-send-email-u.kleine-koenig@pengutronix.de>
	("Uwe =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu, 25 Sep 2014
 18:10:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DDA128F0-44D8-11E4-A41E-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257483>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

> Commit logs as shown by git-log are usually indented by four spaces s=
o
> here it makes sense to do the same for commit notes.
>
> However when using format-patch to create a patch for submission via
> e-mail the commit log isn't indented and also the "Notes:" header isn=
't
> really useful. So consequently don't indent and skip the header in th=
is
> case. This also removes the empty line between the end-of-commit mark=
er
> and the start of the notes.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> This commit changes the output of format-patch (applied on this commi=
t) from:
>
> 	...
> 	case.
>
> 	Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de=
>
> 	---
>
> 	Notes:
> 	    This commit changes the output of format-patch (applied on this =
commit) from:
>
> to
>
> 	...
> 	case.
>
> 	Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de=
>
> 	---
> 	This commit changes the output of format-patch (applied on this comm=
it) from:
>
> which I consider to be more useful.

I suspect that is fairly subjective, as the current one is in that
form because those who wrote this feature first, reviewed, applied
would have considered it more useful, isn't it?

Because I never send out a format-patch output without looking it
over in an editor, I know I can easily remove it if I find the
"Notes:" out of place in the output, but if the "Notes:" thing
weren't there in the first place I may scratch my head trying to
figure out where to update it if the information there were stale,
so for that reason I'd find it more useful to have Notes: to remind
me where that information comes from.

But that is just my personal preference and I am willing to be
persuaded either way with a better argument than "to me it looks
nicer".

As to indenting, because the material after three-dashes is meant to
be fed to "git apply" or "patch", I'd prefer to keep it to avoid
having to worry about a payload that may look like part of a patch.
This preference is a bit stronger than the presence/absence of
"Notes:".

Thanks.

>  log-tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index bcee7c596696..c1d73d8fecdf 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -585,7 +585,8 @@ void show_log(struct rev_info *opt)
>  		int raw;
>  		struct strbuf notebuf =3D STRBUF_INIT;
> =20
> -		raw =3D (opt->commit_format =3D=3D CMIT_FMT_USERFORMAT);
> +		raw =3D (opt->commit_format =3D=3D CMIT_FMT_USERFORMAT) ||
> +			(opt->commit_format =3D=3D CMIT_FMT_EMAIL);
>  		format_display_notes(commit->object.sha1, &notebuf,
>  				     get_log_output_encoding(), raw);
>  		ctx.notes_message =3D notebuf.len
