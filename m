Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D37C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 09:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7423061411
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 09:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244991AbhI2JQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbhI2JQq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 05:16:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA4C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 02:15:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj4so6031870edb.5
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=LNaKH5yb1K2Z1cLGLeiApQ13ZI7dn8CrIjtMLw0FKZA=;
        b=IpwkGMnbDVPhUHwJLwW2SEDtekhDeWL+1lwUvkG3qmWBazWfwfmHOSjAjfxHxm1VCT
         omNieu87OG0pDFkCgN6qjMljmBBeRiCgGRhQERk4J1SHQt//+xAV74HJIZYCx2EF27zE
         7qz1WFl64elU7sf+PmpPcL65nXw49T0xWIKNoTddItftXh5rKB3pQOzkc/m7TxxwvqlJ
         3qKVajhlBKHYoYMI+Sol7SIPiI3V1sG/LY67ywdSd7DXQfQolpLFzSUzTrtNWaisOyU8
         x1fgdSy6LJp4P/yvQc5z+IObzAy5zpNcovizz3p3pICnPI9bf71P26v0uT4nkL7f848a
         PiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LNaKH5yb1K2Z1cLGLeiApQ13ZI7dn8CrIjtMLw0FKZA=;
        b=ynbkt9cTuNHP8cCNIF6bMnj8SFsp3ewMbDIYz3R2dUtdRCltTr7eGB/nsazmtU29YS
         IcF6CgNhwdsHW37MsGLJfAI0gqak8mg3B+fvRpA0ff0PTjcO0r4eOPE1hAlhxYRjltHz
         ufibrMEpy2iSWlQmnFIceOGcZk56WsDK2qrBSxJDGoTpjU/eBC7duC3wc78tu2Vo71/y
         7VwE8gSiLqe5+n4EXV2Jj5TGaUsAVTjyPYiv2mHtlVCeprbg+I8RlPPJY3+ld+fF/lkv
         TFGsAGCEsOV8GwhvS+fuV7ln7+4Vjuw1PJurphokytqE5FF4Tb15iphtG3WwCc35YR70
         S9QQ==
X-Gm-Message-State: AOAM531V0a/oxHiCdJuyknq9aZ8/alTSCN+w44qTA4dBi2f7jnvadD+k
        SlxKC3AV/p6mjRv202dcrOnFQcc7GsO0UA==
X-Google-Smtp-Source: ABdhPJx91LYYkA5LBJaisD9EzFzOYg2usdOxYLVIMu9LwftLF3VS/RF59qoqRxlkyi8WIuYqoR99Yw==
X-Received: by 2002:a17:906:8288:: with SMTP id h8mr12884321ejx.87.1632906904363;
        Wed, 29 Sep 2021 02:15:04 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id pj17sm993573ejb.66.2021.09.29.02.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 02:15:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 02/10] parse-options.[ch]: consistently use "enum
 parse_opt_flags"
Date:   Wed, 29 Sep 2021 10:53:18 +0200
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
 <patch-02.10-289bb437eb5-20210928T130905Z-avarab@gmail.com>
 <xmqqilykgs2k.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqilykgs2k.fsf@gitster.g>
Message-ID: <87mtnvvj3c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 28 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Use the "enum parse_opt_flags" instead of an "int flags" as arguments
>> to the various functions in parse-options.c. This will help to catch
>> cases where we're not handling cases in switch statements, and
>
> I am not sure about most part this change, and the claim the second
> sentence makes is certainly dubious.  Let's look at the first hunk:
>
>> diff --git a/parse-options.c b/parse-options.c
>> index 55c5821b08d..9dce8b7f8a8 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -481,7 +481,8 @@ static void parse_options_check(const struct option =
*opts)
>
>  static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
>  				  int argc, const char **argv, const char *prefix,
> -				  const struct option *options, int flags)
> +				  const struct option *options,
> +				  enum parse_opt_flags flags)
>  {
>  	ctx->argc =3D argc;
>  	ctx->argv =3D argv;
>  	if (!(flags & PARSE_OPT_ONE_SHOT)) {
>  		ctx->argc--;
>  		ctx->argv++;
>  	}
>  	ctx->total =3D ctx->argc;
>  	ctx->out   =3D argv;
>  	ctx->prefix =3D prefix;
>  	ctx->cpidx =3D ((flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
>  	ctx->flags =3D flags;
>  	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
>  	    (flags & PARSE_OPT_STOP_AT_NON_OPTION) &&
>  	    !(flags & PARSE_OPT_ONE_SHOT))
>  		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
>  	if ((flags & PARSE_OPT_ONE_SHOT) &&
>  	    (flags & PARSE_OPT_KEEP_ARGV0))
>  		BUG("Can't keep argv0 if you don't have it");
>  	parse_options_check(options);
>  }
>=20=20
> The "flags" parameter does not take a value that is an "enum" in the
> usual "enumeration" sense at all.  Even though parse_opt_flags
> defines 7 distinct "enum" values, each enumerated value is a small
> unsigned integer with only single bit set, the caller can throw a
> value that is not among these 7 by OR'ing them together.  We would
> not sensibly do
>
> 	switch (flags) {
> 	case PARSE_OPT_KEEP_UNKNOWN:
> 		...
>
> In general, I am not all that enthusiastic for such a(n) (ab)use of
> "enum" for bit patterns, much less than "enumerate all possible
> values to make sure compilers would help us catch missing logic".

I agree that it's not as nice as enums where the fields are mutually
exclusive, since those can be checked via "case" arms, and this is
"unchecked" bitfields.

So e.g. the bug I fixed in 01/10 would not be found by a compiler I have
access to (and I don't think one currently exists).

But I think this is perfectly good use of enums, we use this
enums-as-bitfields pattern in various other places,
e.g. builtin/rebase.c's "flags", the "commit_graph_write_flags",
"expire_reflog_flags" & "todo_item_flags", just to name a few from some
quick grepping.

One advantage is that integrates nicely with some wider C
tooling. E.g. before this series, starting "git stash show" under gdb
and inspecting flags:

    (gdb) p flags
    $1 =3D 9

And after:

    (gdb) p flags
    $1 =3D (PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN)

So the type information and bitfield-ness are retained.

Although you might argue that it leads you into a trap, as adding:

    flags |=3D PARSE_OPT_LASTARG_DEFAULT;

Will result in:

    (gdb) p flags
    $2 =3D (PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_NO=
_INTERNAL_HELP)

I.e. it decodes the enum based on the int value & its known labels, and
it just so happens that PARSE_OPT_LASTARG_DEFAULT has the same value as
PARSE_OPT_NO_INTERNAL_HELP in an unrelated enum.

> The "parse_opt_result" enum is the "right" kind of enumeration that
> I can stand behind fully.  The hunk related to that enum in this
> patch is quite reasonable and takes advantage of the fact that the
> enum is meant to be the enumeration of all possible values.
>
> Compared to it, parse_opt_flags and parse_opt_option_flags, not
> really.
>
> If we wanted to really clean up the latter two, perhaps we should
> define the bit (which *can* be made to a proper "here are the all
> possible values" enumeration), like this:
>
>     enum parse_opt_flags_bit {
> 	PARSE_OPT_KEEP_DASHDASH_BIT =3D 0,
>         PARSE_OPT_STOP_AT_NON_OPTION_BIT,
> 	PARSE_OPT_KEEP_ARGV0_BIT,
> 	...
> 	PARSE_OPT_SHELL_EVAL_BIT,
>     };
>
> and then update the users to use (1U << PARSE_OPT_$FLAG$_BIT), or
> drop the pretense that it is a good idea to use enum for bit pattern
> and use the CPP macro, i.e.
>
>     #define PARSE_OPT_KEEP_DASHDASH (1U<<0)
>     #define PARSE_OPT_STOP_AT_NON_OPTION (1U<<1)
>     ...
>     #define PARSE_OPT_SHELL_EVAL (1U<<6)
>
> to make it clear that we do not mean these are "enumeration of
> possible values".

I'm not sure what the former suggestion here buys us, but the latter
will drop the type information as noted above, i.e. you'll get a:

    (gdb) p flags
    $1 =3D 9
