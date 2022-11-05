Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA135C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 08:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiKEIdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 04:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKEIdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 04:33:09 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFE06451
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667637165; bh=UFP3l3bIHW4bCUk9VugPIHmSFPqI6uklV88EkNZSkQ4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lxomYeaCU+7F9KSzo8fQDyk6ypw3SFeo6ygDqfu0irL+ahw2aeqqRDV5L3lr1Ab/y
         Vo7NciJ/HcOn5+xsUNW77/4ENAgLIDtoHuYqGlbU8PY8FuGPkahDjg9zRb+95wVYOd
         Idz2glSFOJ3dNn6lVRPoI0T23SzYq3OwXhhiw7SDSxaZJTB2ZQoqggIxQCXTGf7CZg
         Yod8HDv6OP9Z4svaOV9CwNRcALLh4d3P5rUKAIpEpcHwzZcdBMBn/Q3yXfBB7feCZG
         NLV6SDFMwJMdSUhuUkM+VDJwdQLXUAeaoWRADg3MzRzwd62dIWuqCw6WjuwJ1WI/AL
         Jv6sWfNtAZ9Gg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.144.51]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9Za2-1ouVrd2BKW-005xxf; Sat, 05
 Nov 2022 09:32:45 +0100
Message-ID: <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
Date:   Sat, 5 Nov 2022 09:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 09/13] parse-options API: don't restrict OPT_SUBCOMMAND()
 to one *_fn type
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KPZEeraRxfzigeLUl7bGEHNYfNE6c7F1DhKAQQ5p0jPuI7I2yiz
 a2NtZ4dOBDshmZO5ehFmeNig1vz5U5FnkZ/4uWfPPl1azyq2YmLWQFW5XIO1nQcQTBGzsqG
 ZcxBksjmhrzu5BGiSLlTQEAynuderZHGW8Mn7Ic0z67fANxrCCszbuMCP/lxAVKYNYRYlhx
 XhOEKltkHiv0JDCoEyEag==
UI-OutboundReport: notjunk:1;M01:P0:UbJUbGlSx88=;pg+wwJTEhzgGsY/18NHPs+4ERvw
 KJQp5NR+bD1jsb9X4Jjz86xfPCyiJJv/1Px6WajpUlMzsXwxxEsgqiqe25ZB1jWOy4g+xWpXt
 48SNwbbC50jQtTqYP5pFWfLaoe+II59K6pKijDZ/BeADdGwCiZZ9RQPTaauTE7BWXg+VgDVpH
 raaiexL9JiB88BQnyh/NEbN9ormSVCWhFeuLx8ruR5rXH/ASg52porScHs5sfwXPckQxHd5Uf
 bIvRjmJ7EUsC6CtI5h6G7712RtR7YhyGNKSfdd35FUogZxUBmeVY/NxPtgDAFL3eC4+u2UT06
 NjQlnBm/Nmq92YBh2qOl6HZM6m6v2MAp6r/tuBbXAk2/BMIGNJIm4ot6RNUIebI53/dXYT3aW
 Wy7UyNY6kLxPl8RaNbROme6SYC9TjxPv52Hi0fdjDX460UXnuxzH+ZyJLTreX08adgvJHq/qV
 1hw06zPkCkVutoxFrg9Pkzh6DdnYVNrzclYferOhyR4AotFrmFihi7ew6vYAzHEub8y2HFQHS
 MrpOVkKKIXjq+QwKTRSLKzQQEdsAgYQO8aBWqL3WlNdE9e7SOZA5Cb778myxBX5yhjgx7wzI0
 SCJPpBvLglR0Cs3riZmAGz+eHkCcHw3MLeuWsE5N0mbosvbdvwXNjzySOik0y1Rjhe71i7j4B
 k/zhRjqvAEe2yi8wEHnUcZBlDMycYKMXFgCiYTVEtpY/CTYg6EuAqUWLa8XqH7jr9nAVFYUBj
 1Tgvzw36dUJMMqR4My4/B9vkLztb2iiwYSMKcMewqhGB71F/Fct36C4kDdwuBFmoH+G6A4pB7
 OLY1mIV2wLw2oHJrrXsmdQu27HIO9M8luLv3qg9OapQlICMsFaamJz9hFflOekYYrNv0iDjIy
 /GMpFpq6uI/aNk/6hUPt948gGmYB+kpyrpmSLx8Q+2csZUWW3gUFc8tbwOLYL9xJn+Pe5WUeR
 Lppjlw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.11.22 um 14:22 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> When the OPT_SUBCOMMAND() API was implemented in [1] it did so by
> adding a new "subcommand_fn" member to "struct option", rather than
> allowing the user of the API to pick the type of the function.
>
> An advantage of mandating that "parse_opt_subcommand_fn" must be used
> is that we'll get type checking for the function we're passing in, a
> disadvantage is that we can't convert e.g. "builtin/bisect--helper.c"
> easily to it, as its callbacks need their own argument.
>
> Let's generalize this interface, while leaving in place a small hack
> to give the existing API users their type safety. We assign to
> "typecheck_subcommand_fn", but don't subsequently use it for
> anything. Instead we use the "defval" and "value" members.
>
> A subsequent commit will add a OPT_SUBCOMMAND() variant where the
> "callback" isn't our default "parse_options_pick_subcommand" (and that
> caller won't be able to use the type checking).
>
> 1. fa83cc834da (parse-options: add support for parsing subcommands,
>    2022-08-19)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  parse-options.c |  9 ++++++---
>  parse-options.h | 25 +++++++++++++++++++++----
>  2 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index a1ec932f0f9..1d9e46c9dc7 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -427,7 +427,8 @@ static enum parse_opt_result parse_subcommand(const =
char *arg,
>  	for (; options->type !=3D OPTION_END; options++)
>  		if (options->type =3D=3D OPTION_SUBCOMMAND &&
>  		    !strcmp(options->long_name, arg)) {
> -			*(parse_opt_subcommand_fn **)options->value =3D options->subcommand_=
fn;
> +			if (options->callback(options, arg, 0))
> +				BUG("OPT_SUBCOMMAND callback returning non-zero");
>  			return PARSE_OPT_SUBCOMMAND;
>  		}
>
> @@ -506,8 +507,10 @@ static void parse_options_check(const struct option=
 *opts)
>  			       "That case is not supported yet.");
>  			break;
>  		case OPTION_SUBCOMMAND:
> -			if (!opts->value || !opts->subcommand_fn)
> -				optbug(opts, "OPTION_SUBCOMMAND needs a value and a subcommand func=
tion");
> +			if (!opts->value || !opts->callback)
> +				optbug(opts, "OPTION_SUBCOMMAND needs a value and a callback functi=
on");
> +			if (opts->ll_callback)
> +				optbug(opts, "OPTION_SUBCOMMAND uses callback, not ll_callback");
>  			if (!subcommand_value)
>  				subcommand_value =3D opts->value;
>  			else if (subcommand_value !=3D opts->value)
> diff --git a/parse-options.h b/parse-options.h
> index b6ef86e0d15..61e3016c3fc 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -128,19 +128,24 @@ typedef int parse_opt_subcommand_fn(int argc, cons=
t char **argv,
>   *			 the option takes optional argument.
>   *
>   * `callback`::
> - *   pointer to the callback to use for OPTION_CALLBACK
> + *   pointer to the callback to use for OPTION_CALLBACK and OPTION_SUBC=
OMMAND.
>   *
>   * `defval`::
>   *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
>   *   OPTION_{BIT,SET_INT} store the {mask,integer} to put in the value =
when met.
> + *   OPTION_SUBCOMMAND stores the pointer the function selected for
> + *   the subcommand.
> + *
>   *   CALLBACKS can use it like they want.
>   *
>   * `ll_callback`::
>   *   pointer to the callback to use for OPTION_LOWLEVEL_CALLBACK
>   *
>   * `subcommand_fn`::
> - *   pointer to a function to use for OPTION_SUBCOMMAND.
> - *   It will be put in value when the subcommand is given on the comman=
d line.
> + *   pointer to the callback used with OPT_SUBCOMMAND() and
> + *   OPT_SUBCOMMAND_F(). Internally we store the same value in
> + *   `defval`. This is only here to give the OPT_SUBCOMMAND{,_F}()
> + *   common case type safety.
>   */
>  struct option {
>  	enum parse_opt_type type;
> @@ -217,12 +222,24 @@ struct option {
>  #define OPT_ALIAS(s, l, source_long_name) \
>  	{ OPTION_ALIAS, (s), (l), (source_long_name) }
>
> +static inline int parse_options_pick_subcommand_cb(const struct option =
*option,
> +						   const char *arg UNUSED,
> +						   int unset UNUSED)
> +{
> +	parse_opt_subcommand_fn *fn =3D (parse_opt_subcommand_fn *)option->def=
val;
> +	*(parse_opt_subcommand_fn **)option->value =3D fn;

->defval is of type intptr_t and ->value is a void pointer.  The result
of converting a void pointer value to an intptr_t and back is a void
pointer equal to the original pointer if I read 6.3.2.3 (Pointers,
paragraphs 5 and 6) and 7.18.1.4 (Integer types capable of holding
object pointers) in C99 correctly.

6.3.2.3 paragraph 8 says that casting between function pointers of
different type is OK and you can get your original function pointer
back and use it in a call if you convert it back to the right type.

Casting between a function pointer and an object pointer is undefined,
though.  They don't have to be of the same size, so a function pointer
doesn't have to fit into an intptr_t.  I wouldn't be surprised if CHERI
(https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/) was an actual
example of that.

Why is this trickery needed?  Above you write that callbacks in
builtin/bisect--helper.c can't use subcommand_fn because they need
their own argument.  Can we extend subcommand_fn or use a global
variable to pass that extra thing instead?  The latter may be ugly, but
at least it's valid C..

> +	return 0;
> +}
> +
>  #define OPT_SUBCOMMAND_F(l, v, fn, f) { \
>  	.type =3D OPTION_SUBCOMMAND, \
>  	.long_name =3D (l), \
>  	.value =3D (v), \
>  	.flags =3D (f), \
> -	.subcommand_fn =3D (fn) }
> +	.defval =3D (intptr_t)(fn), \
> +	.subcommand_fn =3D (fn), \
> +	.callback =3D parse_options_pick_subcommand_cb, \

Getting the address of an inline function feels weird, but the compiler
is free to emit to ignore that keyword and will provide an addressable
function object here.

> +}
>  #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
>
>  /*

