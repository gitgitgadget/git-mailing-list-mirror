From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/13] pretty: add %C(auto) for auto-coloring
Date: Tue, 16 Apr 2013 14:33:31 -0700
Message-ID: <7vd2tujh3o.fsf@alter.siamese.dyndns.org>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 23:33:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USDVS-0002wk-Fy
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 23:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965384Ab3DPVdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 17:33:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965262Ab3DPVde convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 17:33:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77C7316209;
	Tue, 16 Apr 2013 21:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ci+TwPVgSpp0
	dPrro9k7764y9vw=; b=F38v2Y90ho61nnxNyKcAA3Ak6VXes5Zq70fFfnNdOX4Y
	MUxhGJRFiv3AP8FvZcFqcatQX5jSue2jVKIWQeGIETKtq4ic5rMcRKy46oNt786s
	/h3Ol3bLDEdQfrxtdRrSb7NXi4B88B+fww88X0RXBl9bEnrz8W3rw24/Sbvb8EI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cdtFKi
	vZHbJ+rOm23p2dWBYeVb0Bs3pwj/YlYOK1gwvMfXGQii+p0+lFNIEeKZKHca7l8R
	uyFkjdYEBqus8kHWj250MKpqoUBfkqCmzUrDbiHpPnXo5aS9zNL/FnHkzg4nE3nH
	pwcYSZ2rOOya00BGMoGfVNC4y7CQ71NxVBm90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EDB616208;
	Tue, 16 Apr 2013 21:33:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA43916204; Tue, 16 Apr
 2013 21:33:32 +0000 (UTC)
In-Reply-To: <1366100702-31745-11-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 16 Apr
 2013 18:24:59 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 499585A6-A6DD-11E2-A3B9-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221477>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is not simply convenient over %C(auto,xxx). Some placeholders
> (actually only one, %d) do multi coloring and we can't emit a multipl=
e
> colors with %C(auto,xxx).
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/pretty-formats.txt |  3 ++-
>  pretty.c                         | 17 +++++++++++++++--
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-=
formats.txt
> index 6bde67e..bad627a 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -156,7 +156,8 @@ The placeholders are:
>    adding `auto,` at the beginning will emit color only when colors a=
re
>    enabled for log output (by `color.diff`, `color.ui`, or `--color`,=
 and
>    respecting the `auto` settings of the former if we are going to a
> -  terminal)
> +  terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto colori=
ng
> +  on the next placeholders until the color is switched again.
>  - '%m': left, right or boundary mark
>  - '%n': newline
>  - '%%': a raw '%'

Good addition.

In the previous round, it used to be "%C(auto)" was remembered in
this field to color the _next_ one, and the momorized value was
toggled off.  As the field no longer toggles automatically once it
is used, perhaps it should simply be called "auto_color" without
"next", though?

I can locally tweak that before queuing if you think it is better.

> diff --git a/pretty.c b/pretty.c
> index e0413e3..f385176 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -778,6 +778,7 @@ struct format_commit_context {
>  	char *message;
>  	char *commit_encoding;
>  	size_t width, indent1, indent2;
> +	int auto_color_next;
> =20
>  	/* These offsets are relative to the start of the commit message. *=
/
>  	struct chunk author;
> @@ -1005,7 +1006,15 @@ static size_t format_commit_one(struct strbuf =
*sb, /* in UTF-8 */
>  	/* these are independent of the commit */
>  	switch (placeholder[0]) {
>  	case 'C':
> -		return parse_color(sb, placeholder, c);
> +		if (!prefixcmp(placeholder + 1, "(auto)")) {
> +			c->auto_color_next =3D 1;
> +			return 7;
> +		} else {
> +			int ret =3D parse_color(sb, placeholder, c);
> +			if (ret)
> +				c->auto_color_next =3D 0;
> +			return ret;
> +		}

This is to handle a corrupt input, e.g. "%C(auto)%Cbleu%H" where
(perhaps deprecated) "%Cblue" is misspelled, and parse_color()
returns 0 without consuming any byte.

Does it make sense not to turn auto off in such a case?  Otherwise
the above would become

	if (!prefixcmp(placeholder + 1, "(auto)")) {
        	c->auto_color_next =3D 1;
                return 7; /* consumed 7 bytes, "C(auto)" */
	}
        c->auto_color_next =3D 0;
        return parse_color(sb, placeholder, c);

which may be simpler.  When we see %C, previous %C(auto) is
cancelled.

>  	case 'n':		/* newline */
>  		strbuf_addch(sb, '\n');
>  		return 1;
> @@ -1051,13 +1060,17 @@ static size_t format_commit_one(struct strbuf=
 *sb, /* in UTF-8 */
> =20
>  	switch (placeholder[0]) {
>  	case 'H':		/* commit hash */
> +		strbuf_addstr(sb, diff_get_color(c->auto_color_next, DIFF_COMMIT))=
;
>  		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
> +		strbuf_addstr(sb, diff_get_color(c->auto_color_next, DIFF_RESET));
>  		return 1;
