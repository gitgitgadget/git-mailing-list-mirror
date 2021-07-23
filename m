Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FE5C4320A
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4965E60EC0
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhGWIpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGWIpl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:45:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F62C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:26:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h10so916718edv.8
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TWZ323EaUwMypdtwpqzNpvViB0W7h/KuNsZHF/pxS7E=;
        b=WboI/vhOLtQhb0gKdWNNQsEPQFESDtasIkcwvoJwo139daISnPyBkZO1cstcGXM+R6
         AbBObNaWTCHDk6p7Xo4xIM/RT8J5YSx/SRTuXtxUzODkNz0tH4plhFEzfkEllxvrPD6s
         yqQWz9s0+UkphjgaAXWxNfBNtMjziuwLNmHm2yFb9T+zsEAofFeeJ68tl7QNeOqmAreH
         UITeXpWlvaO6twuTdEQvV4REzKd77fnXdhEyw8GnnHTlsDqehnzLdL5wpN33LJoFuoTP
         5p77tikRgFZSMj3UamLIaIEgsue4HIkpWkM+L6K5uxKMeif60AA7Znesuv5X4tFOLgNd
         k1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TWZ323EaUwMypdtwpqzNpvViB0W7h/KuNsZHF/pxS7E=;
        b=NGRCkmxpP2kOg/YNOWzy3bKyPc22o82Bd0lFpYjH7JKSNFS2vYIR2DW8ehzyI+1BYH
         6oP81odvelpP7wPMxzKBDxJixvd+Rzf9kCpb3EPk09W+3QWQrPglHTUqd1XTRG7mRr3n
         YRePqY4bu7pXJV8jGWlZMhHO4ttFSb2MG2lSPbUyhasXXtDWqm7chkReWW51Cf/ZiUXq
         BfQOj5ikQ71VuocKG8/7Bhb/tU+BZXi7eHgznaUsN1SL/qRLzmj0iLIJP0DgC+ieY8GM
         qInDap6gvzEhH10ykMw7w7dWfnmUqGTJnWFpz38QaeFf1m3s1pfFMZvTx5F95Dw3V3Wy
         slNg==
X-Gm-Message-State: AOAM533HDhsN9bBN715FmgGDZ018aR+k95k3SGCt5AJQWEEtgT7xMod9
        RVXGyZzODzqkkG0bzL8BsRs=
X-Google-Smtp-Source: ABdhPJzdz3g6HZR64uvJuwXomKFZVqMJkbtIx0pHBJzbaynKit/C7n3GP0T/PWxpY3OqWIidg0Sf/Q==
X-Received: by 2002:aa7:c4c7:: with SMTP id p7mr4385102edr.290.1627032373233;
        Fri, 23 Jul 2021 02:26:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u9sm10099203eje.31.2021.07.23.02.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:26:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/9] hook: include hooks from the config
Date:   Fri, 23 Jul 2021 11:22:07 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-7-emilyshaffer@google.com>
 <87im1ay67y.fsf@evledraar.gmail.com> <YPn2dfjzFLovIYIX@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPn2dfjzFLovIYIX@google.com>
Message-ID: <875yx1tm7p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Emily Shaffer wrote:

> On Fri, Jul 16, 2021 at 11:01:24AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Thu, Jul 15 2021, Emily Shaffer wrote:
>>=20
>> > +static struct hook * find_hook_by_command(struct list_head *head, con=
st char *command)
>>=20
>> nit: "*find[...]" not "* find[...]", also let's wrap the long line.
> ACK
>>=20
>> > +{
>> > +	struct list_head *pos =3D NULL, *tmp =3D NULL;
>> > +	struct hook *found =3D NULL;
>> > +
>> > +	list_for_each_safe(pos, tmp, head) {
>> > +		struct hook *it =3D list_entry(pos, struct hook, list);
>> > +		if (!strcmp(it->command, command)) {
>> > +		    list_del(pos);
>> > +		    found =3D it;
>> > +		    break;
>>=20
>> Indented with spaces.
>
> I don't know how I even did this. *facepalm*
>
>>=20
>> Also is there some subtlety in the list macro here or can we just
>> "s/break/return it/" and skip the break/return pattern?
>
> I guess it's probably fine, but we'd need the final return anyway
> ("otherwise returns NULL"). IMO one return is more readable than two
> returns, so I'd rather leave this.

Sure makes sense. I'd tend to go for two returns, but let's not split
hairs on personal style.

>>=20
>> > +static struct hook * append_or_move_hook(struct list_head *head, cons=
t char *command)
>>=20
>> Same whitespace nits.
> ACK
>>=20
>> > +	if (!to_add) {
>> > +		/* adding a new hook, not moving an old one */
>> > +		to_add =3D xmalloc(sizeof(*to_add));
>> > +		to_add->command =3D command;
>> > +		to_add->feed_pipe_cb_data =3D NULL;
>> > +		/* This gets overwritten in hook_list() for hookdir hooks. */
>> > +		to_add->from_hookdir =3D 0;
>>=20
>> I commented on init verbosity elsewhere, i.e. we could do some things
>> via macros, but in this case just having an "init" helper make sense,
>> but we have at least two places copying the same init of all fields,
>> should just be hook_init_hook() or whatever it'll be called. Maybe with
>> a second "from hookdir" param?
>
> Hm, where is the second place where we init everything? I think with
> this commit we remove anywhere we're putting together a 'struct hook' man=
ually
> except during this helper? Hooks from hookdir are initted by
> 'append_or_move_hook()'ing them to the end of the list and modifying the
> from_hookdir field, and builtin/hook.c just calls hook_list() (and some
> list.h helpers to find an entry).

Looking again I think I just misread this then, thanks.

>> > +	/* to enable oneliners, let config-specified hooks run in shell */
>> > +	cp->use_shell =3D !run_me->from_hookdir;
>>=20
>> I've lost track at this point, but doesn't that mean we're going to use
>> a shell when we run our own do-not-need-a-shell hooks ourselves?
>>=20
>> Isn't isatty() more appropriate here, or actually even interactively why
>> is the shell needed (maybe this is answered elswhere...).
>
> use_shell means "conditionally guess whether I need to wrap this thing
> in `sh -c`" - it doesn't have anything to do with TTY or not. So we need
> this for something like `hook.post-commit.command =3D echo "made a
> commit"`. In this case the entire argv[0] will be the oneliner, which
> you will need use_shell set for. If we *do* just do something simple,
> like `hook.post-commit.command =3D /bin/mail`, even though
> use_shell is marked, the child_process runner will notice that there's
> no reason to wrap in 'sh -c' and so will just run the /bin/mail
> executable directly.

Ah, I missed that. Makes sense.
