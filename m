Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40452C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 12:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00429611AB
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 12:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhDPMEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbhDPMEI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 08:04:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F5AC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 05:03:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o20so5666605edc.7
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1Z77BvzR9R+WXqOJyZfl82NRFJgA3BrpQlha+wkuZo=;
        b=vIZmOgP+8vmQZ3h4NLloFXVjs8KqjpGBTjqu4l842FVLLp8ACJKMteXvl45U4KgBgB
         ZFa/8Qr7KtObq+SMcdkRTKZAq6HKniXfr29cr7ZiAluB+z+y3kScfazllIvhkU+zEXcD
         d+EpjVR82EQ3kndddnC/4aRGX1Qlgnd7jurPJ4uys55TV5HFHT9Hvgj7Jd0gCYlqYCR2
         Ub+FuoTiKIIeyccPIolkxuiGAPCUuAZ+Tl6zDk/hVdP5rGzaF3cOJYBlMMGnO5GTs9qn
         keKeP3cTKVeUe54OUsJl8C3IFfPYeh9u2+VXpPLCfWFzdGR/5FCGj0xkZ9gls+Hy5BuL
         ONng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1Z77BvzR9R+WXqOJyZfl82NRFJgA3BrpQlha+wkuZo=;
        b=h0ZkOM2LkaAHH0dG1HUNGDyxzOUe47ArEz9936CA7BAeHQUmaCZZLMOQ1ER1OecSG2
         B2EObwJ1c3uhthsVJvlQl7HzXOsdAIrOLR6pgMBIyTtHYpAmKCwDVEcBd6JmimDqqpPK
         qYlCf8TxHYbe3It11BaKRvHZqReDDVfvyYFdKBJwwezWRG6CL73+s+lsRFrAQSuLz4nI
         DqxcDT3OMz7Q/6DORUy6xcR7Fyz9f77/FAr4kiFszAI8vWy2TxP42G+bQGJhpeIS5rgS
         YuyPq88o/n/k+USozyD60ROQ6lDuYnVwiRdIcDztFCjrY0YXB2Gy6jlc0w97qM64U4Is
         dw7Q==
X-Gm-Message-State: AOAM531+69YRQS4sRtMnhyj453RjQDzl+U4KSr4AnkFWwQFAYDeWRAPL
        PoNpldaMjEBvssx9hZa4woGoAHMtrTmNDUrGyrDYmxFcJgZ14Q==
X-Google-Smtp-Source: ABdhPJx02lxKGkyfil7RM+h3NV70wlhOG4fK4d1bBoTt0mdMUCcytwhJV7eKjfoY+22KnECU3ae0joD9QrbFASxHmoI=
X-Received: by 2002:a05:6402:1255:: with SMTP id l21mr8753718edw.362.1618574622144;
 Fri, 16 Apr 2021 05:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
 <pull.913.v9.git.1618245568.gitgitgadget@gmail.com> <8129ef6c476b4f35be59eae71367de5b83888068.1618245568.git.gitgitgadget@gmail.com>
 <xmqqwnt7b5fg.fsf@gitster.g>
In-Reply-To: <xmqqwnt7b5fg.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Apr 2021 14:03:30 +0200
Message-ID: <CAP8UFD2gUbWP2LWXDt1nmph1qMyhEBfLErw3=5OTBx-KeBQBVQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] [GSOC] docs: correct descript of trailer.<token>.command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late answer.

On Mon, Apr 12, 2021 at 10:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  trailer.<token>.command::
> > +     This option can be used to specify a shell command that will be called:
> > +     once to automatically add a trailer with the specified <token>, and then
> > +     each time a '--trailer <token>=<value>' argument to modify the <value> of
> > +     the trailer that this option would produce.
> >  +
> > -When this option is specified, the behavior is as if a special
> > +When the specified command is first called to add a trailer
> > +with the specified <token>, the behavior is as if a special
> > +'--trailer <token>=<value>' argument was added at the beginning
> > +of the "git interpret-trailers" command, where <value>
> > +is taken to be the standard output of the command with any
> > +leading and trailing whitespace trimmed off.
>
> So, with
>
>         [trailer "foo"] command = "echo $ARG"
>
> in your .git/config
>
>     $ git interpret-trailers </dev/null
>
> gives 'foo:'.

Yeah:

------
$ git -c trailer.foo.command='echo $ARG' interpret-trailers </dev/null

foo:
------

> > +If some '--trailer <token>=<value>' arguments are also passed
> > +on the command line, the command is called again once for each
> > +of these arguments with the same <token>. And the <value> part
> > +of these arguments, if any, will be used to replace the first
> > +occurrence of substring `$ARG` in the command. This way the
> > +command can produce a <value> computed from the <value> passed
> > +in the '--trailer <token>=<value>' argument.
> >  +
> > +For consistency, the first occurrence of substring `$ARG` is
> > +also replaced, this time with the empty string, in the command
> > +when the command is first called to add a trailer with the
> > +specified <token>.
>
> And then
>
>     $ git interpret-trailers --trailer=foo:F </dev/null
>
> would give you
>
>     foo:
>     foo: F

Yeah:

------
git -c trailer.foo.command='echo $ARG' interpret-trailers
--trailer=foo:F </dev/null

foo:
foo: F
------

> The above is quite an easy to read explanation of the behaviour.
>
> I somehow wonder if this "run with empty even without anything on
> the command line" a misfeature, and I'd prefer to iron it out before
> we add .cmd, because we may not want to inherit it to the new .cmd,
> just like we avoided '$ARG' that does not properly quote and
> replaces only once from getting inherited by .cmd mechanism.

I don't think it's a misfeature. I think it can be very useful in some
cases like with:

$ git config trailer.sign.command 'echo "$(git config user.name)
<$(git config user.email)>"'

My opinion is that we should have added a `trailer.<token>.runMode`
config option along with `trailer.<token>.command`. This was not
discussed unfortunately when ".command" was implemented, but it seems
to be a good idea now.

> The reason why I suspect this may be a misfeature is because I do
> not see any way to avoid 'foo' trailer once trailer.foo.command is
> set.

It can be avoided when the --trim-empty CLI option can be used. A hook
to remove empty trailers (which might call `git interpret-trailers
--trim-empty` itself) could also be used when --trim-empty cannot be
used directly.

> Which means I cannot use this mechanism to emulate "commit -s",
> which would hopefully be something like
>
>         [trailer "signoff"]
>                 command = "git var GIT_COMMITTER_IDENT | sed -e 's/>.*/>/"
>                 ifexists = addIfDifferentNeighbor
>
> And trailer.signoff.ifmissing=donothing would not help in this case,
> either, I am afraid, as that would not just suppress the automatic
> empty one, which is fairly useless, but also suppresses the one that
> is made in response to the option from the command line.

I agree that the current mechanism cannot easily emulate "commit -s".

> Christian?  What's your thought on this?
>
> I can understand that it sometimes may be useful to unconditionally
> be able to add a trailer without doing anything from the command
> line, but it feels fairly useless that an empty one is automatically
> added, that the only way to hide that empty one from the end result
> is to use ifexists=replace, and that there is no apparent way to remove
> the empty one.
>
> The --trim-empty option is a bit too crude a band-aid to use, as the
> existing log message may have an unrelated trailer for which it is
> perfectly valid not to have any value.

I agree that --trim-empty is not usable sometimes. Another idea would
be to add 'trailer.<token>.trimEmpty' to be able to do things like:

------
git -c trailer.foo.trimEmpty=true -c trailer.foo.command='echo $ARG'
interpret-trailers --trailer=foo:F </dev/null

foo: F
------

It could also be used along with `git commit --trailer=foo:F`.

> The fix we'd do when introducing .cmd should also get rid of this
> initial "run with an empty even when not asked"?

I don't think it's a good idea to make ".cmd" behave in a different
way as ".command" regarding this. Yes, there could be a short term
gain because people could use ".cmd" when they don't want the initial
"run with an empty value", but, as some people might still want this
initial run, long term it looks like a burden that might:

  - make it more difficult to understand how ".cmd" and ".command" both work
  - make it more difficult to migrate from ".command" to ".cmd"
  - prevent us from deprecating ".command" in favor of ".cmd"

> Or if the execution without any input from the command line were
> truly useful sometimes, a configuration variable that disables this
> behaviour, i.e.
>
>         [trailer "signoff"]
>                 command = "git who"
>                 ifexists = addIfDifferentNeighbor
>                 implicitExecution = false
>
> so that
>
>         git commit --trailer=signoff:Couder --trailer=signoff:gitster@
>
> would give us two sign-offs without the empty one, perhaps?

Yeah, that's basically the same idea that we previously discussed with
'tailer.<token>.runMode' (or 'trailer.<token>.alwaysRunCmd') in:

https://lore.kernel.org/git/CAP8UFD0OMJfkuX_JoDros7h0B20D8sm0ZbtkVpL3dCYRV_M=OA@mail.gmail.com/

> In any case, the documentation update in this step looks reasonably
> well written.

Thanks!
