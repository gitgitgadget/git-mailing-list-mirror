Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8578C4167B
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 12:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiLQMqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 07:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQMp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 07:45:57 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B5CBC00
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 04:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671281152; bh=w3GmJKRXhY223/Eh51cw8PwEADWy5uJ4nl6llOgUsN4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=sGdNTIXMkHGwLv2Jzc1XynFk0RxNeuD9A1QSok0IkSpj90TYZFYmtI3dkp63V76JP
         eJR/Wd1uGA3mifFyGuF4jlDOVw/RnO9fJS3QwvWh3qODJoalqWjNFJgcgbdhw1MzrU
         HubjUL7myA5qlG8pLBt4byo+3DGRT009v95GpSaniKJhUquOcCVvUYBo2W7v7OoPD2
         dD706imlaw6DQNT/nFxR0Mf6ig/wsbDGhDM/c5E5zIaLWpbDUIubT1+6MmmXsMKREn
         o4ibg0B7IAbD45Kl/SdihS9QczwKdKLLEVgx6ildxTopDQ0D/MYVwALztPwqnwJPlP
         1op1ri/JbT6xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWsc-1pLz3o1ca0-00KGFN; Sat, 17
 Dec 2022 13:45:52 +0100
Message-ID: <5f5e86e9-8c15-7ba3-1a03-0ec9f505c960@web.de>
Date:   Sat, 17 Dec 2022 13:45:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 3/5] strvec API: add a "STRVEC_INIT_NODUP"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
 <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
 <RFC-patch-3.5-16c20baf5ec-20221215T090226Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-3.5-16c20baf5ec-20221215T090226Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZSbGNoxWRD/pt3ctz7JSnfUnPbLTTukJLvlW0pygTP1kRbQH5NN
 4YdNcZpi8fI002zEnR/kM6vp8x4Vi8cgvXboo1J5Oth4Yx18d/sifDSCMfOt5G7Yq+eq5ZU
 Ln+Pp5wbdjy8TiLifuwC1wrALQKoUtURghHwDNI25YcPNMtFYn9KeQ+szc4nU6d8Je8Vdjr
 eVjwBrTAUCYoab9BpshoQ==
UI-OutboundReport: notjunk:1;M01:P0:VGda5k25VGs=;gdpxZDCkPTeu0AhlY+lI8R6bPRe
 OYlO4wwaYPipQ02chMp0ipxn4ikumA0c7Pv5nWbPmYgsHh9b36g1uNfd2ujlgO4OsIDDtEL9J
 GEfvF38R1p36eHT70Nf0nsm+YDXrxQVyMGg5JSZPGWezJvdoX1FQNw+zzbpTxu5H9S4IYpwTi
 Z8Sz7q7WyhgQ194/0a/Avgi3lnRvgQQoE+ohpg6nY6zNCstvp41Z1ZMRe8WqRzwdkkKZfMpKk
 o58j/PoNPuY3ALYTkBKx1df+aEvPVO7bdPro5QKaY5cUj9cvlnsGdxVKrdJ0Z2BVTGHTQfsNg
 bmaDS0rUxbsbcC5R/4I1R74mes9uSk5nOIMlBCXETOn2oSSylQozUPAfF4QKEzFJzLOegptz+
 D0nWuxkidTMZvltuuZJnHrmgKqTv3fluVI7Hr8dveGxfjM26oDp+7J/CKIYWNuTJXCEEXF6qc
 MEqFsTHY5tJJx1wolSUrmAjPuoaHe4zZS5Y4oPqI/X77K/kcSxorfF2DTQ0e74W5U2zc3lwaf
 YjAdDjxJeXV9TfNTiVNosi668M4IyyT/IKYO+wHWUtJhf6PT1RErpe8h+E36UabfXNNGNUTZt
 4RL4nm2ENs//un/383SbSQH6XsBMVVeLQ2Vd6m5/CfeoyEA7Ax1pOhruAdctWCVZoHZEhP2dp
 nZO6+ahFWq73HjqowHqOHEzz/DYLhWTB1tpPFJbyCv+MAYgAvdZagu0xKIiuVwpuXa6A7rRxA
 0k7TncNabEIMhA1wLvomYvyOJ9t1S1hLDo4I/c8dJLjUk6fK9/bxJRAzfERiziGDt2hL0OnsV
 fXFgWpSFMTwYeJDNBmQ9w0oeP7oqo7WFFqUi+ulxo7NFQ2PtuuFxmpj+zzS7IBX24cJBAxBeq
 egLo4xpLXWJywAiZli9KwaiKJ9q+YjKfECnlDtbtwzis0y0e1c6c+H16hIEaWU00vP9jIWKu/
 DHE7sdTr/p8twhNzQ71rib6p/Cs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.12.22 um 10:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> We have various tricky cases where we'll leak a "struct strvec" even
> when we call strvec_clear(), these happen because we'll call
> setup_revisions(), parse_options() etc., which will munge our "v"
> member.
>
> There's various potential ways to deal with that, see the extensive
> on-list discussion at [1]. One way would be to pass a flag to ask the
> underlying API to free() these, as was done for setup_revisions() in
> [2].
>
> But we don't need that complexity for many common cases, which are
> pushing fixed strings to the "struct strvec". Let's instead add a flag
> analogous to the "strdup_strings" flag in the "struct string_list". A
> subsequent commit will make use of this API.
>
> Implementation notes: The BUG_unless_dup() is implemented as a macro
> so we'll report the correct line number on BUG(). The "nodup_strings"
> flag could have been named a "strdup_strings" for consistency with the
> "struct string_list" API, but to do so we'd have to be confident that
> we've spotted all callers that assume that they can memset() a "struct
> strvec" to zero.

If the two variants would get separate types then the compiler would
take care of these checks.  Conceptually they are different enough and
have different operations; they only share the same struct layout.

But I doubt a _nodup variant as its own type would pull its weight.
It would basically be a trivial wrapper around REALLOC_ARRAY..

>
> 1. https://lore.kernel.org/git/221214.86ilie48cv.gmgdl@evledraar.gmail.c=
om/
> 2. f92dbdbc6a8 (revisions API: don't leak memory on argv elements that
>    need free()-ing, 2022-08-02)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  strvec.c | 20 ++++++++++++++++++--
>  strvec.h | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/strvec.c b/strvec.c
> index 61a76ce6cb9..721f8e94a50 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -10,6 +10,16 @@ void strvec_init(struct strvec *array)
>  	memcpy(array, &blank, sizeof(*array));
>  }
>
> +void strvec_init_nodup(struct strvec *array)
> +{
> +	struct strvec blank =3D STRVEC_INIT_NODUP;
> +	memcpy(array, &blank, sizeof(*array));
> +}
> +
> +#define BUG_unless_dup(array, fn) \
> +	if ((array)->nodup_strings) \
> +		BUG("cannot %s() on a 'STRVEC_INIT_NODUP' strvec", (fn))
> +
>  static void strvec_push_nodup(struct strvec *array, const char *value)
>  {
>  	if (array->v =3D=3D empty_strvec)
> @@ -22,7 +32,9 @@ static void strvec_push_nodup(struct strvec *array, co=
nst char *value)
>
>  const char *strvec_push(struct strvec *array, const char *value)
>  {
> -	strvec_push_nodup(array, xstrdup(value));
> +	const char *to_push =3D array->nodup_strings ? value : xstrdup(value);
> +
> +	strvec_push_nodup(array, to_push);
>  	return array->v[array->nr - 1];
>  }
>
> @@ -31,6 +43,8 @@ const char *strvec_pushf(struct strvec *array, const c=
har *fmt, ...)
>  	va_list ap;
>  	struct strbuf v =3D STRBUF_INIT;
>
> +	BUG_unless_dup(array, "strvec_pushf");
> +
>  	va_start(ap, fmt);
>  	strbuf_vaddf(&v, fmt, ap);
>  	va_end(ap);
> @@ -67,6 +81,8 @@ void strvec_pop(struct strvec *array)
>
>  void strvec_split(struct strvec *array, const char *to_split)
>  {
> +	BUG_unless_dup(array, "strvec_pushf");
> +
>  	while (isspace(*to_split))
>  		to_split++;
>  	for (;;) {
> @@ -89,7 +105,7 @@ void strvec_clear(struct strvec *array)
>  {
>  	if (array->v !=3D empty_strvec) {
>  		int i;
> -		for (i =3D 0; i < array->nr; i++)
> +		for (i =3D 0; !array->nodup_strings && i < array->nr; i++)
>  			free((char *)array->v[i]);
>  		free(array->v);
>  	}
> diff --git a/strvec.h b/strvec.h
> index 9f55c8766ba..b122b87b369 100644
> --- a/strvec.h
> +++ b/strvec.h
> @@ -26,29 +26,51 @@ extern const char *empty_strvec[];
>   * member contains the actual array; the `nr` member contains the
>   * number of elements in the array, not including the terminating
>   * NULL.
> + *
> + * When using `STRVEC_INIT_NODUP` to initialize it the `nodup_strings'
> + * member is set, and individual members of the "struct strvec" will
> + * not be free()'d by strvec_clear(). This is for fixed string
> + * arguments to parse_options() and others that might munge the "v"
> + * itself.
>   */
>  struct strvec {
>  	const char **v;
>  	size_t nr;
>  	size_t alloc;
> +	unsigned int nodup_strings:1;
>  };
>
>  #define STRVEC_INIT { \
>  	.v =3D empty_strvec, \
>  }
>
> +#define STRVEC_INIT_NODUP { \
> +	.v =3D empty_strvec, \
> +	.nodup_strings =3D 1, \
> +}
> +
>  /**
>   * Initialize an array. This is no different than assigning from
>   * `STRVEC_INIT`.
>   */
>  void strvec_init(struct strvec *);
>
> +/**
> + * Initialize a "nodup" array. This is no different than assigning from
> + * `STRVEC_INIT_NODUP`.
> + */
> +void strvec_init_nodup(struct strvec *);
> +
>  /* Push a copy of a string onto the end of the array. */
>  const char *strvec_push(struct strvec *, const char *);
>
>  /**
>   * Format a string and push it onto the end of the array. This is a
>   * convenience wrapper combining `strbuf_addf` and `strvec_push`.
> + *
> + * This is incompatible with arrays initialized with
> + * `STRVEC_INIT_NODUP`, as pushing the formatted string requires the
> + * equivalent of an xstrfmt().
>   */
>  __attribute__((format (printf,2,3)))
>  const char *strvec_pushf(struct strvec *, const char *fmt, ...);
> @@ -70,7 +92,13 @@ void strvec_pushv(struct strvec *, const char **);
>   */
>  void strvec_pop(struct strvec *);
>
> -/* Splits by whitespace; does not handle quoted arguments! */
> +/**
> + * Splits by whitespace; does not handle quoted arguments!
> + *
> + * This is incompatible with arrays initialized with
> + * `STRVEC_INIT_NODUP`, as pushing the elements requires an xstrndup()
> + * call.
> + */
>  void strvec_split(struct strvec *, const char *);
>
>  /**
