Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAA5C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 22:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKEWiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 18:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKEWiH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 18:38:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F27C120AB
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 15:38:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ud5so21628400ejc.4
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 15:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VY+Iut+5VjgSYwGl3AkSSkehGEnv2iwvzXKwBskTI2M=;
        b=YEuQne+CX5IxBe6vWPJdiIlL/eQeeNh7+2/jic38Fn+n+aibQJXcHHwsluKRmaRjg4
         4iD4v+NUN+kUsKniqagfUtdQ3u14bRQSzMDrzvJItSnkg2ZlNI+sDhmiUoD/hSG5awvH
         INx2IUoz03ZgCZcHVF1ydQqCAqEWO8tk3MpkasgYOcH3YbpjgC9NwIl4KPqppRDF+q0r
         Lag1kkra9Ki4NyzX+IaBQOYeJlDbE7W4G4Eu7E8ffnV+AFpM4BccZ9gnGBjTxUOniN8I
         GS1IAmSLeRqroppSJltqqbov4eKygxm5VQXdBsukauC/L/pq+JsR8vpHWZF2YC+MLgW6
         UT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VY+Iut+5VjgSYwGl3AkSSkehGEnv2iwvzXKwBskTI2M=;
        b=nGd9ru+LeNhO8PpredLf2njqW+Vmr3zuovO2YAKh7ewLuAm/0JDWHoULK2ttQb/z+z
         jzrB+8SVZoqH+04LCso+9ghkei0nbxUjBG2oMDsXsIQKievqsvXJBZNxCza4mLGUfgaA
         IsQ2t5dEve0st4LXCAxgmg6lRmdi/4dxvibYR+ruDeLRaIaf/sMGb6IvBCu8Y40Ia4YN
         g7AykS1Z76sXHc/NmQslh4C/PcRgWed1Xt1S7khliNFCwDsCRlpAUhgvP34QnAmvUDMb
         jeZR8u8ly/lGNfqj05v2X8fEEeknPuTxelYqR9gsfIkxRx9V0ZI1cVA/1RF5XW1CSaFW
         Epbw==
X-Gm-Message-State: ACrzQf0uBUoJFwKEcxjsAFYoqtaon1x83gaDYl3jmzVrik44Rx8fub5u
        8SndDIzN2N7jXYp36MgJDVs=
X-Google-Smtp-Source: AMsMyM4e2CUNO6ygwLfRqxETSo72yYR9XMNc/v2g4n9Z4goQj0xIrKxRdVMML4MnksHwD/KQKEJNbg==
X-Received: by 2002:a17:906:c155:b0:7ad:a2e9:a479 with SMTP id dp21-20020a170906c15500b007ada2e9a479mr40558385ejc.568.1667687885015;
        Sat, 05 Nov 2022 15:38:05 -0700 (PDT)
Received: from gmgdl (31-151-3-230.dynamic.upc.nl. [31.151.3.230])
        by smtp.gmail.com with ESMTPSA id v19-20020aa7dbd3000000b00463c5c32c6esm1717886edt.89.2022.11.05.15.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 15:38:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1orRnf-000SSX-33;
        Sat, 05 Nov 2022 23:38:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy?= =?utf-8?B?4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/13] parse-options API: don't restrict
 OPT_SUBCOMMAND() to one *_fn type
Date:   Sat, 05 Nov 2022 23:33:32 +0100
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
 <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
 <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
 <25776063-a672-fc65-bed3-1bc8536ab8b3@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <25776063-a672-fc65-bed3-1bc8536ab8b3@web.de>
Message-ID: <221105.86o7tlvxh0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 05 2022, Ren=C3=A9 Scharfe wrote:

> Am 05.11.22 um 14:52 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> I think that's an "unportable" extension covered in "J.5 Common
>> extensions", specifically "J.5.7 Function pointer casts":
>>
>> 	A pointer to an object or to void may be cast to a pointer to a
>> 	function, allowing data to be invoked as a function
>>
>> Thus, since the standard already establishes that valid "void *" and
>> "intptr_t" pointers can be cast'd back & forth, the J.5.7 bridges the
>> gap between the two saying a function pointer can be converted to
>> either.
>>
>> Now, I may be missing something here, but I was under the impression
>> that "intptr_t" wasn't special in any way here, and that any casting of
>> a function pointer to either it or a "void *" was what was made portable
>> by "J.5.7".
>
> Do you mean "possible" or "workable" instead of "portable" here?  As you
> write above, J.5.7 is an extension, not (fully) portable.

I think my just-sent in the side-thread should clarify this.

>> Anyway, like ssize_t and a few other things this is extended upon and
>> made standard by POSIX. I.e. we're basically talking about whether this
>> passes:
>>
>> 	assert(sizeof(void (*)(void)) =3D=3D sizeof(void*))
>>
>> And per POSIX
>> (https://pubs.opengroup.org/onlinepubs/9699919799/functions/dlsym.html):
>>
>> 	Note that conversion from a void * pointer to a function pointer
>> 	as in:
>>
>> 		fptr =3D (int (*)(int))dlsym(handle, "my_function");
>>
>> 	is not defined by the ISO C standard. This standard requires
>> 	this conversion to work correctly on conforming implementations.
>
> Conversion from object pointer to function pointer can still work if
> function pointers are wider.
>
>> So I think aside from other concerns this should be safe to use, as
>> real-world data backing that up we've had a intptr_t converted to a
>> function pointer since v2.35.0: 5cb28270a1f (pack-objects: lazily set up
>> "struct rev_info", don't leak, 2022-03-28).
>
> That may not have reached unusual architectures, yet.  Let's replace
> that cast with something boring before someone gets hurt.  Something
> like this?
>
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 573d0b20b7..9e6f1530c6 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4154,14 +4154,15 @@ struct po_filter_data {
>  	struct rev_info revs;
>  };
>
> -static struct list_objects_filter_options *po_filter_revs_init(void *val=
ue)
> +static int list_objects_filter_cb(const struct option *opt,
> +				  const char *arg, int unset)
>  {
> -	struct po_filter_data *data =3D value;
> +	struct po_filter_data *data =3D opt->value;
>
>  	repo_init_revisions(the_repository, &data->revs, NULL);
>  	data->have_revs =3D 1;
>
> -	return &data->revs.filter;
> +	return opt_parse_list_objects_filter(&data->revs.filter, arg, unset);
>  }
>
>  int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> @@ -4265,7 +4266,7 @@ int cmd_pack_objects(int argc, const char **argv, c=
onst char *prefix)
>  			      &write_bitmap_index,
>  			      N_("write a bitmap index if possible"),
>  			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
> -		OPT_PARSE_LIST_OBJECTS_FILTER_INIT(&pfd, po_filter_revs_init),
> +		OPT_PARSE_LIST_OBJECTS_FILTER_F(&pfd, list_objects_filter_cb),
>  		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
>  		  N_("handling for missing objects"), PARSE_OPT_NONEG,
>  		  option_parse_missing_action),
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 5339660238..2e560c2fdb 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -286,15 +286,9 @@ void parse_list_objects_filter(
>  		die("%s", errbuf.buf);
>  }
>
> -int opt_parse_list_objects_filter(const struct option *opt,
> +int opt_parse_list_objects_filter(struct list_objects_filter_options *fi=
lter_options,
>  				  const char *arg, int unset)
>  {
> -	struct list_objects_filter_options *filter_options =3D opt->value;
> -	opt_lof_init init =3D (opt_lof_init)opt->defval;
> -
> -	if (init)
> -		filter_options =3D init(opt->value);
> -
>  	if (unset || !arg)
>  		list_objects_filter_set_no_filter(filter_options);
>  	else
> @@ -302,6 +296,12 @@ int opt_parse_list_objects_filter(const struct optio=
n *opt,
>  	return 0;
>  }
>
> +int opt_parse_list_objects_filter_cb(const struct option *opt,
> +				     const char *arg, int unset)
> +{
> +	return opt_parse_list_objects_filter(opt->value, arg, unset);
> +}
> +
>  const char *list_objects_filter_spec(struct list_objects_filter_options =
*filter)
>  {
>  	if (!filter->filter_spec.len)
> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> index 7eeadab2dd..fc6b4da06d 100644
> --- a/list-objects-filter-options.h
> +++ b/list-objects-filter-options.h
> @@ -107,31 +107,26 @@ void parse_list_objects_filter(
>  	struct list_objects_filter_options *filter_options,
>  	const char *arg);
>
> +int opt_parse_list_objects_filter(struct list_objects_filter_options *fi=
lter_options,
> +				  const char *arg, int unset);
> +
>  /**
>   * The opt->value to opt_parse_list_objects_filter() is either a
>   * "struct list_objects_filter_option *" when using
>   * OPT_PARSE_LIST_OBJECTS_FILTER().
>   *
> - * Or, if using no "struct option" field is used by the callback,
> - * except the "defval" which is expected to be an "opt_lof_init"
> - * function, which is called with the "opt->value" and must return a
> - * pointer to the ""struct list_objects_filter_option *" to be used.
> - *
> - * The OPT_PARSE_LIST_OBJECTS_FILTER_INIT() can be used e.g. the
> - * "struct list_objects_filter_option" is embedded in a "struct
> - * rev_info", which the "defval" could be tasked with lazily
> - * initializing. See cmd_pack_objects() for an example.
> + * Or, OPT_PARSE_LIST_OBJECTS_FILTER_F() can be used to specify a
> + * custom callback function that may expect a different type.
>   */
> -int opt_parse_list_objects_filter(const struct option *opt,
> -				  const char *arg, int unset);
> +int opt_parse_list_objects_filter_cb(const struct option *opt,
> +				     const char *arg, int unset);
>  typedef struct list_objects_filter_options *(*opt_lof_init)(void *);
> -#define OPT_PARSE_LIST_OBJECTS_FILTER_INIT(fo, init) \
> +#define OPT_PARSE_LIST_OBJECTS_FILTER_F(fo, fn) \
>  	{ OPTION_CALLBACK, 0, "filter", (fo), N_("args"), \
> -	  N_("object filtering"), 0, opt_parse_list_objects_filter, \
> -	  (intptr_t)(init) }
> +	  N_("object filtering"), 0, (fn) }
>
>  #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
> -	OPT_PARSE_LIST_OBJECTS_FILTER_INIT((fo), NULL)
> +	OPT_PARSE_LIST_OBJECTS_FILTER_F((fo), opt_parse_list_objects_filter_cb)
>
>  /*
>   * Translates abbreviated numbers in the filter's filter_spec into their

I think "just leave it, and see if anyone complains".

If you look over config.mak.uname you can see what we're likely to be
ported to (and some of that's probably dead). The list of potential
targets that:

 1) We know of ports to, or people would plausibly port git to
 2) Are updated so slow that they're on a release that's getting close
    to a year old.

Are small, and it's usually easy to look up their memory model etc. are
you concerned about any specific one?

I think if you're worried enough about it to push for the diff above:
Can we just hide it behind an "#ifdef", then if we find that nobody's
using it, we can consider it safe to use.

I don't think there's any great benefit to the extension in that
specific case, but there might be in the future (e.g. this topic would
be one small user), so since we already have an unintentional test
ballon, why not see if we can keep it safely?
