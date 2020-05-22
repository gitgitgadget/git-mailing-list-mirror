Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9A3C433E2
	for <git@archiver.kernel.org>; Fri, 22 May 2020 13:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D18420723
	for <git@archiver.kernel.org>; Fri, 22 May 2020 13:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ox7ouEtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgEVNZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 09:25:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:48095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgEVNZK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 09:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590153907;
        bh=+QLKldwOPLGgZjRuV+IPQ+SM178p+7nUKWor0RcibkE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ox7ouEtfJputrIX65UIQD+fhciNG0/CUt1kwWSg4BWh01U7P9wNmP4l3WOZ+Gyw2X
         Gw/1IdqBVT9h3qoXbNLQYnvQG3cwyxCFYRrQXYKU0AmtaLXtp40FjYQz7Y7i8uKEBB
         OdZotIUXSmTysKn3g/OtniuavtoJXXXl5aysL3+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([213.196.213.226]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1j8HZ13BQy-00hAEl; Fri, 22
 May 2020 15:25:07 +0200
Date:   Fri, 22 May 2020 15:25:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 03/12] bisect--helper: introduce new `write_in_file()`
 function
In-Reply-To: <20200423070704.39872-4-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005221516540.56@tvgsbejvaqbjf.bet>
References: <20200423070704.39872-1-mirucam@gmail.com> <20200423070704.39872-4-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:guqYq5wE9/iQrR8AcRkjGPQ7d0pBgsiYREN8lrLCHFQlOgJfslW
 CWZl+BZfkmEi1KcYzfU2rCC5Ai47Rx9kOtSAb2lcqpV3ut+mUT+S4IlmvFCPK1hsW/yGIYw
 IvMQ8sItRnG3Pn9PPRjsQW7gPvuw+0u87NLsizkjWwIxKOLFNYEsXi7UBFtO83GhgbM7gkR
 II7GiUaGj1iIm+hYc58VQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rS8KZQB7FQY=:P9HY9d7ce9RDyNDLG/ctb6
 92QNs8A9+JsI5TF4WTgp2QeG4sR7LuvFaSbDSb2g6wf/nrJyvwmWmTpiY0imjbBQMykIepGv0
 Dn4uelVHqX7wdPzM3+J5E+sh8AtkTRWPyKBIOroigHBGKrJz4W8ZKo1uHn2pCv0H7qHKCozuQ
 VwPvsnQejJUYG3mqtk6OKziwNxSnNUorK4IHROhtbMQUg2Zi4rP/n//6/FkHA8LIazjC+oK+J
 skfN2Fn8oSrbtM9AKTkLq2qQy+O3bJNxSO0cuGXwdo0S6lAPxdJ68WMM5fxzLR3hwZMHwdyLm
 9ftB0TfrCRoUDfR9d+MobrZG93Mu/fq4dL8PP+7qHSRDe2KHVVVf6VcaMY7irYCtIq7hYB4vm
 kTElR/8SitOjE4VKl0MsPemNGLXWdo1B9JMtdQhe48QWASTA0ak10mo21TnvJxtBd7BB5TvVK
 IpO1P2Fxs4lSME226pW8PPF4nB0Sfg7SiDwKWQ4eUvh2n6FNED1F81tN8I5neV2H/viC8ra1y
 8pFBPwB7U49Knvu1yx4b8eSgpYXMVNFiekPqFsP+xQlIXYqb0p404FjZFyIyE5E/UDZRzAfN2
 iBOZ0G74WXWXQds017X6HvdKnxcWFVZbhwKJzw2rrt6sqP51a3QRTAWnleStkguMGnCHW4Wc6
 ZWbKbhXRYoIlizO3P9qugKnp5KKzzJwmgDKmZh2Rv0L7aLAfpj8EDGI6vyX4YldzQONLHAiGh
 uW2y5WMkHoHBUPqiTG+qgXir771EHl9XeA4sNZWxgffD7wgOXzrn2Bzyogjj9+OwSsb8ZaPaS
 jI4E4FR0BQ9YI1IF08E2gnfSqUsQHpY5RGyfzgXpW70U1nok8yhddD4xAIazjETZuIQgyiI8A
 AekjsMtwUI5v1GjZsTdJ6zW8EGGK7pkiopglDynbI4Zh91LQ7GfsWxtI95vcHj5j/BbC0Rjty
 3i+P8TAurWcst2TFu8jqfyZy79zY5aRc0xWrW38V6Kc/X2a8sg6KQj6Hivsz++HieqMndGD/4
 vBVXZ511lW1Ge7Egj/TTDCfP4pp0vjTvRX1m1I84OVFS85iExKnpQBvmMhj6XxSC4tbYwt3fa
 pq3wa/YET2zh3NjByiFlvmK7vPfeE1ChgW9bu2drYB/uv5Ux/8H1kbt585ES0HIbqSNv+WXPl
 A7DCxOcsjhRUdsiEer1/Garnsa3l8QFCCmoFGoIZRvTvxs6ZKz6PbeR1w36Tgz72UAwRkEy+K
 1qg37xdipfQ+0Ic8S
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Thu, 23 Apr 2020, Miriam Rubio wrote:

> Let's refactor code adding a new `write_in_file()` function
> that opens a file for writing a message and closes it.

Don't we have that already?
https://github.com/git/git/blob/v2.27.0-rc1/wrapper.c#L625-L638

If that function does not meet the bill, it would make more sense to
extend it (or refactor it, providing a new global function that does meet
the bill).

> This helper will be used in later steps and makes the code
> simpler and easier to understand.

Makes a lot of sense to me!

> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 0fbd924aac..d3b2b33df0 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -74,6 +74,28 @@ static int one_of(const char *term, ...)
>  	return res;
>  }
>
> +static int write_in_file(const char *path, const char *mode, const char=
 *format,...)

I wonder whether there is _ever_ a case where we want to set `mode` to
anything else than `"w"`? Ah...

> +{
> +	FILE *fp =3D NULL;
> +	va_list args;
> +	int res =3D 0;
> +
> +	if (!strcmp(mode, "a") && !strcmp(mode, "w"))
> +		return error(_("wrong writing mode '%s'"), mode);

... rather than doing this, I would prefer a pair of functions (that can
call the same helper function doing the actual work): `write_to_file()`
and `append_to_file()`.

Apart from that, the patch looks good to me,
Dscho

> +	fp =3D fopen(path, mode);
> +	if (!fp)
> +		return error_errno(_("cannot open file '%s' in mode '%s'"), path, mod=
e);
> +	va_start(args, format);
> +	res =3D vfprintf(fp, format, args);
> +	va_end(args);
> +	if (!res) {
> +		fclose(fp);
> +		return error_errno(_("could not write to file '%s'"), path);
> +	}
> +
> +	return fclose(fp);
> +}
> +
>  static int check_term_format(const char *term, const char *orig_term)
>  {
>  	int res;
> @@ -104,7 +126,6 @@ static int check_term_format(const char *term, const=
 char *orig_term)
>
>  static int write_terms(const char *bad, const char *good)
>  {
> -	FILE *fp =3D NULL;
>  	int res;
>
>  	if (!strcmp(bad, good))
> @@ -113,12 +134,8 @@ static int write_terms(const char *bad, const char =
*good)
>  	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
>  		return -1;
>
> -	fp =3D fopen(git_path_bisect_terms(), "w");
> -	if (!fp)
> -		return error_errno(_("could not open the file BISECT_TERMS"));
> +	res =3D write_in_file(git_path_bisect_terms(), "w", "%s\n%s\n", bad, g=
ood);
>
> -	res =3D fprintf(fp, "%s\n%s\n", bad, good);
> -	res |=3D fclose(fp);
>  	return (res < 0) ? -1 : 0;
>  }
>
> --
> 2.25.0
>
>
