Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76214C433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 14:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiCGOzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbiCGOzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 09:55:16 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918BC3D1C3
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 06:54:21 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bi12so19406941ejb.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 06:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8qBPEky2NV8CgT6NWm39vg8Tv2RwrlPJU0WREAttzaw=;
        b=eaKZdnJPC+1Qp+1A9khLPtaliI/76wvrQh4AVGKiGCwM3si4okI5Gf+Z2/HwSLc7BC
         2ReHs3PNh/DAjSj7o/8jyPIERhGFhsZXrZN0ZBdKZOgC3fDYrMIS1XVs+IglfrpVGW5H
         4M9TD915AmJ3ONIeWjwyA5mg0AilUxid6jFArL3+aaRzYoWwc8javJpU/fDuNzcoUM7Z
         g0Xsn0N4EnM/sdgM/I13uhgA+3rVMK+f7oU0TSbBgkgW4qGHlOFHl31q98yL3F6CnFx0
         jlU5bI6ClSND0VvLh2cm9UhiTeut7tQxcqUyZsLHSnApKYP1aT4XjSFpFrh13ADNao9x
         Yl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8qBPEky2NV8CgT6NWm39vg8Tv2RwrlPJU0WREAttzaw=;
        b=AA9pTzjkRvMZ5lSAvNI7+oI/aPEJFj3FuU0tCLedDwdK2yw5kU7+ZMXVSrjZ26VDAK
         O7xuV0h2eLSAxuAj1HG4eXIm3Zsc8GbMrXOwW0pO4//nNebWQLsy+57ayNTjdDkvaYui
         /wIj5a3H82BOEA8tWUh/iUkUh7T3E0tB1PiamUE187fjjeh/HlNnCY/+Qxd/zwkv+KA2
         GwG51UZA83weQdq/stxD8NzdjJSs+RtEzNZt+C5Q7EvFnMCI1UNeU56lg5485PU+jzqV
         FaLZBWCb04ArdvEEed+/F6gBQeC3G/+jj+YVZ8iI03eDe7I8RTtmEYZ2JDYDoPYgfg51
         ZLYg==
X-Gm-Message-State: AOAM532zE4JY2OcCYcYcNj6sTcfSSu+8sXxNV5fICbIye2AfyDq8XIAc
        JEGJUrsB3cRdq30fYNqdYPY=
X-Google-Smtp-Source: ABdhPJxOLfA/iY6WWsYFXg6EGUeOBZVKIJX8Jq9elTjvXIf+nOz/IGz7KMLxAjPCdv1JDF2XEpKlwA==
X-Received: by 2002:a17:907:3f9b:b0:6da:6f2b:4b1c with SMTP id hr27-20020a1709073f9b00b006da6f2b4b1cmr9279773ejc.765.1646664859873;
        Mon, 07 Mar 2022 06:54:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm6277960edu.51.2022.03.07.06.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:54:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nREkc-001Y7I-F6;
        Mon, 07 Mar 2022 15:54:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>, carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] terminal: restore settings on SIGTSTP
Date:   Mon, 07 Mar 2022 15:45:51 +0100
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-5-phillip.wood123@gmail.com>
 <220305.86bkyk4hwc.gmgdl@evledraar.gmail.com>
 <8aa11144-c9ce-46aa-2edd-15e8fa1298dc@gmail.com>
 <220307.86ilsq0xxr.gmgdl@evledraar.gmail.com>
 <a02dea22-7403-7302-cf20-9aff75a10d14@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <a02dea22-7403-7302-cf20-9aff75a10d14@gmail.com>
Message-ID: <220307.86o82hzucl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Phillip Wood wrote:

> On 07/03/2022 11:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Mar 07 2022, Phillip Wood wrote:
>>=20
>>> Hi =C3=86var
>>>
>>> On 05/03/2022 13:59, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> [...]
>>>>>    int save_term(unsigned flags)
>>>>>    {
>>>>> +	struct sigaction sa;
>>>>> +
>>>>>    	if (term_fd < 0)
>>>>>    		term_fd =3D (flags & SAVE_TERM_STDIN) ? 0
>>>>>    						    : open("/dev/tty", O_RDWR);
>>>>> @@ -44,6 +136,26 @@ int save_term(unsigned flags)
>>>>>    	if (tcgetattr(term_fd, &old_term) < 0)
>>>>>    		return -1;
>>>>>    	sigchain_push_common(restore_term_on_signal);
>>>>> +	/*
>>>>> +	 * If job control is disabled then the shell will have set the
>>>>> +	 * disposition of SIGTSTP to SIG_IGN.
>>>>> +	 */
>>>>> +	sigaction(SIGTSTP, NULL, &sa);
>>>>> +	if (sa.sa_handler =3D=3D SIG_IGN)
>>>>> +		return 0;
>>>>> +
>>>>> +	/* avoid calling gettext() from signal handler */
>>>>> +	background_resume_msg =3D xstrdup(_("error: cannot resume in the ba=
ckground"));
>>>>> +	restore_error_msg =3D xstrdup(_("error: cannot restore terminal set=
tings"));
>>>> You don't need to xstrdup() the return values of gettext() (here
>>>> _()),
>>>> you'll get a pointer to static storage that's safe to hold on to for t=
he
>>>> duration of the program.
>>>
>>> I had a look at the documentation and could not see anything about the
>>> lifetime of the returned string, all it says is "don't alter it"
>> I think this is overed in "11.2.7 Optimization of the *gettext
>> functions", a pedantic reading might suggest not, but what's meant with
>> the combination of that API documentation & the description of how MO
>> files work is that you're just getting pointers into the already-loaded
>> translation catalog, so it's safe to hold onto the pointer and re-use it
>> later.
>
> Strictly that section only shows it is safe if there are no other
> calls to gettext() before the returned string is used. I agree the=20
> implementation is likely to be just returning static strings but I
> can't find anywhere that says another implementation (e.g. on
> macos/*bsd) has to do that.

I agree. I'm 99.99% sure this is safe & portable use of the API, but I'm
having some trouble finding documentation for that...

>> In any case, if we're going to be paranoid about gettext() it would make
>> sense to propose that as some general change to how we use it, we rely
>> on this assumption holding in a lot of our use of the API:
>>      git grep '=3D _\('
>> Rather than sneak that partcular new assumption in here in this
>> already
>> tricky code...
>
> The ones I looked at are mostly not calling gettext() again before
> using the translated string (there is one exception in
> builtin/remote.c).

Doesn't validate_encoding() in convert.c, process_entry() in
merge-ort.c, setup_unpack_trees_porcelain() in unpack-trees.c cmd_mv()
in builtin/mv.c etc. qualify?

I.e. for a hypothetical gettext() that always returned the same pointer
and just overwrote it with the latest message those would all emit bad
output, wouldn't they?

> In restore_term() I'm checking if the messages are NULL to see if job
> control is enabled, I could use a flag but I'm inclined to just keep=20
> coping the strings.

Checking if they're NULL is orthagonal to whether we xstrdup()
them. I.e. you'd just skip the xstrdup() and replace the FREE_AND_NULL
with a "=3D NULL" assignment, no?

Anyway, *if* I'm right that it's not new general paranoia with how
gettext() is used I still think splitting up that part of the change
would make sense, just for future readers etc. who'd wonder why it is
that this already tricky signal handling etc. code needs that particular
bit of special behavior.

>>>> In this case I think it would make sense to skip "error: " from the
>>>> message itself.
>>>> Eventually we'll get to making usage.c have that prefix translated,
>>>> and
>>>> can have some utility function exposed there (I have WIP patches for
>>>> this already since a while ago).
>>>> To translators it'll look like the same thing, and avoid churn when
>>>> we
>>>> make the "error: " prefix translatable.
>>>
>>> Unless we add a function that returns a string rather than printing
>>> the message I don't see how it avoids churn in the future. Having the
>>> whole string with the "error: " prefix translated here does not add
>>> any extra burden to translators - it is still the same number of
>>> strings to translate.
>> Because translators translate "we failed" for most errors, not
>> "error:
>> we failed".
>> If and when we convert it from "error: we failed" to "we failed"
>> they'll
>> need to translate it again (although to be fair, the translation cache
>> will help).
>> And even then it'll be one of very few exceptions where the "error:
>> "
>> currently that *is* translated.
>>=20
>>>> Aside: If you do keep the xstrdup() (perhaps an xstrfmt() with the abo=
ve
>>>> advice...) doesn't it make sense to add the "\n" here, so you'll have
>>>> one write_in_full() above?
>>>
>>> I decided to keep the translated string simpler by omitting the
>>> newline, calling write_in_full() twice isn't a bit deal (I don't think
>>> the output can be split by a write from another thread or signal
>>> handler in between).
>> Makes sense.
>> FWIW I meant if you're going to xstrdup() or xstrfmt() it anyway you
>> could do:
>>      xstrfmt("error: %s\n", _("the error"))
>> And then do one call to write_in_full().
>> But I think just:
>>      msg =3D _("the error");
>> And then:
>> 	const char *const =3D pfx =3D "error: ";
>>          const size_t len =3D strlen(pfx);
>> 	write_in_full(2, pfx, len);
>>          write_in_full(2, msg, strlen(msg));
>> 	write_in_full(2, "\n", 1);
>> Makes more sense :)
>
> Agreed, I'll change that.
>
> Best Wishes
>
> Phillip

