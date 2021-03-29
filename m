Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4051C433E1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE0161990
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhC2XYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC2XYt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 19:24:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8E2C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:24:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j3so15999988edp.11
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=w4oiJjN44zmOe49S7QkRNJxagLA+gXJLn0JhcwDzhto=;
        b=bVmgkPLnlJe1z+RF7CJfxRoDhDuV1qlel814j3jHZIDDtJtVT1w274mbJJKjjLEP9t
         WzcL63FvwrGwYn8e4KmkagOmlWrmEnwNk9fM3DXd5qgR1DBOA7zK4XMH54x5TvNWKhPf
         cuQshktg5NOcNcfjyGtvGtskTbC/84MwlkXaHQN1WD6P6eAxfTVochGrIO8ToPeM544u
         UkOuzlCD3SDJwcnJoP7H5SjGgtDzAofn0TN6DhkxPzP/L0/RtIKrKKgbDehdPhHDPRGO
         bDgrW8uW2nrddtnm1ODMiUBGOy9At8tbtq1QwfgpPfD9/Vt2P0XDeUTvpjj0V/K67eh4
         tXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=w4oiJjN44zmOe49S7QkRNJxagLA+gXJLn0JhcwDzhto=;
        b=tv21/tp8vkmGlcr9lcj03qhcOqf9pBhrtVel4Dznui3NJIdJf24ywOSh2TqyCMyUCy
         SNJfKf5rn3cAkKPTK33DGscEXywdcVNPcTd2rRi5zgq7foWShCHu8Njo7McsIFLen2xi
         YZzEpwj6EYPKs2oeTWKnrps7n6PSdPFJWgKGgjcY9Z4CZV8WfWvLfEu4aIRKU6jgseDV
         8QMEm5I0TPXaIKg12ldBipCFAkMlrI2a3AXvXNGZu0XpCP2nrgQ2dIMTygLQWtyfUcSz
         DDc2ij6F2acmDb+giFWWVYSzQfIpRhTN/gExbh0qfAhkchGdphDDU7F07yCwSqu7c7j7
         pFvA==
X-Gm-Message-State: AOAM531KfqfaF5uATs7zjfv9UHhMzBBXySoPSwMhwnFfwWofL2kj99Zk
        hcbpGSQtUglk9Lbj+CN/ojidKBJyMvXjyA==
X-Google-Smtp-Source: ABdhPJwnRdzVueGCihyegKy4FeRqx6IUSV9nVNGss6uAjlcsvvLik4LLShBZbfelDeLfZ3zVl/XO6w==
X-Received: by 2002:aa7:d917:: with SMTP id a23mr30932272edr.122.1617060288098;
        Mon, 29 Mar 2021 16:24:48 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cf4sm9819327edb.19.2021.03.29.16.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:24:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/5] Makefile: rename objects in-place, don't clobber
References: <20210307132001.7485-1-avarab@gmail.com>
 <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
 <patch-1.6-3330cdbccc0-20210329T161723Z-avarab@gmail.com>
 <xmqqy2e5kegv.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqy2e5kegv.fsf@gitster.g>
Date:   Tue, 30 Mar 2021 01:24:47 +0200
Message-ID: <87ft0dmtkw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 29 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Per the log of changes to the Makfile and Junio's recent comment about
>> [1] why that pattern got introduced it was for a different reason
>> entirely, i.e. ("[]" edits are mine, for brevity):
>>
>>     [T]hat age old convention [...] is spelled [as]:
>>
>>     	thing:
>>     		rm -f thing thing+
>>     		prepare contents for thing >thing+
>
> Did I say that?  I recall I specifically avoided the "redirection"
> because this is *NOT* shell-script only principle.  If a command is
> so broken that "cmd -o thing" that fails to work correctly leaves a
> broken output in thing, then the pattern should be applied and made
> to "cmd -o thing+ && mv thing+ thing".

[I see this was already noted downthread...]

> On the other hand, if "cmd" refrains from leaving a half-baked
> result in "-o thing" (and I believe $(CC) is well-behaved even on
> AIX), I do not think it is a good idea to use that pattern.  One
> version of AIX may refuse to overwrite a file in use because
> creat("thing") that is necessary for "-o thing" may fail while
> "thing" is in use), but another system may refuse to rename over a
> file in use (i.e. "-o thing+" into a brand new "thing+" may be OK
> but the final "mv thing+ thing" may fail).  So pretending that it is
> a cure for broken use case is cluttering Makefile for no real
> benefit and leading readers into confused thinking.

It does fix this issue entirely on AIX. So it's a cure for the broken
case.

I can assure you that not having to regularly log in to the GCC farm AIX
box and remember how to deal with IBM's ps/kill etc. just to do another
build/test is a real benefit :)

Whereas maybe there's another system we're not fixing with this patch,
but does it matter? I don't see how it would make things worse for that
OS, if it exists. But it sounds like it's just a hypothetical.

>>     		mv thing+ thing
>>
>>     It protects us from a failure mode where "prepare contents for
>>     thing" step is broken and leaves a "thing" that does not work, but
>>     confuses make that make does not need to rebuild it, if you wrote it
>>     as such:
>>
>>     	thing:
>>     		prepare contents for thing >thing
>>
>>     [It might leave behind a corrupt 'thing'.] In any case, it is not
>>     "we are trying to make thing available while it is being
>>     rewritten" at all.
>>
>> That makes perfect sense for shellscripts, but as this change shows
>> there's other good reasons to use this age old convention that weren't
>> considered at the time.
>
> So, no, the age old convention may have considered and does not
> apply to such a use case.

The reason I mentioned this was to specifically address the implied "why
would we need this?" part of your E-Mail that you're quoting.

I think that started out as us talking past one another, so let me try
to summarize.

I was basically saying "here's a well-known command idiom" that can be
used for XYZ.

I think you're basically saying "in git.git, I introduced this idiom to
deal with problem ABC".

ABC and XYZ aren't incompatible. I'm just saying this can and does solve
both problems[continued below].

>>  git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>> -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
>> -		$(filter %.o,$^) $(LIBS)
>> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@+ $(ALL_LDFLAGS) \
>> +		$(filter %.o,$^) $(LIBS) && \
>> +	mv $@+ $@
>
> Really, does anybody else use "$(CC) -o $@" in such a way in their
> Makefile?  Having to do this smells simply crazy (I am not saying
> you are crazy---the platform that forces you to write such a thing
> is crazy).

Yes, if you do say a Google search for "Cannot open or remove a file
containing a running program" you'll find that there's 15k results of
people basically (re)discovering this problem in porting their software
to AIX, and the solutions being some variant of "yes AIX sucks, just use
this 'cmd >x+ && mv x+ x' trick".

You can also invoke a "slibclean" program to reticulate AIX's splines,
but I thought this sucked less.
