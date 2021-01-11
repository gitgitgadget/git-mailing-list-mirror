Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E774CC433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D77022581
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbhAKIok (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbhAKIoj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 03:44:39 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C712C06179F
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 00:43:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r5so17833447eda.12
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 00:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=12klWsw+7nHrzrwtsD0NaZVD+aW+8LueC91oGPw+Liw=;
        b=dJHoReEkMwTTMuWwCVdd0yQhjBtMKpwyt1Sfqvn7TSvTaGgZZvdbHppytaSAily/j2
         ei2Fi+xz96JFwMOW9HvIyfY2icG9KJRmRNs6xmbuXTfW+CRc7BLER8+tXN5qgvUQIjKu
         zTDf38z2pJ8Ptf1J99w86heJ/HVzqwGAqBrrP0EYp96c7Jr8/nP/YsQ2Ts3dIUwhy8IT
         s4uTuWehveCJXDkMJFrWjxKmGCKtW+kKpx0JFLl6kczJw1vk9DRTqB8vT/kWhG3Yn38r
         GRMfcwhurZ7bhv6SDQeXUC4FRpOmKLEUIIl5CwWZZsFeQ+I1w4Ff2ysK6DxGUh8oM4LX
         RCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=12klWsw+7nHrzrwtsD0NaZVD+aW+8LueC91oGPw+Liw=;
        b=pa57c9m5/wacR9+NpYWxUjL89Xx4ntLOL2o8gMufCMdCszNDucEWaS+gGrTVikaNwm
         sA8rloQcKQNDRmWZiFQ820c0VHHrZNLFSCXDjDXzMnBTjd0NWRDNptuo+jP95F+UJ+aA
         QC+BXOFEHCFPp6tPFuTMYlb3A4AzvhDZM41lhi1j4PH6pVGL35SGTC0BrUppLWyQmV8j
         yrUfaGUrR55YwILS7v7skID0OnOEAu03GsnNAo9pvcVkh2f/IbGFWuCCriizPL2sdMy3
         tSvNKo22mBdwaj1qy6rTqf9BDBr6nc98cT6MIh1d+F3eGwt3DYGzt/M3RJ7+mJl1rXKR
         ZQ9Q==
X-Gm-Message-State: AOAM531WPz5RGd0w33NNQbAUprndP3BVcswlZBgAR9D+ruJ012Hn7F0q
        kq8WkUdqo84jMz1l6O3xvFQ=
X-Google-Smtp-Source: ABdhPJz07fi/9NaPhqb1/AUWUdaKQhMlZig+PQ/J3jMWmHIa+SDm7OCoeTWvynJeAW3v1xLFBaNPiA==
X-Received: by 2002:aa7:d154:: with SMTP id r20mr13936278edo.258.1610354637509;
        Mon, 11 Jan 2021 00:43:57 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id x16sm6719968ejo.104.2021.01.11.00.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 00:43:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should you use test_i18ngrep or GIT_TEST_GETTEXT_POISON=false?
References: <20201223013606.7972-1-avarab@gmail.com>
 <20210105194252.627-13-avarab@gmail.com>
 <20210110132155.GT8396@szeder.dev> <87y2h062jd.fsf@evledraar.gmail.com>
 <xmqqczyca6vq.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqqczyca6vq.fsf@gitster.c.googlers.com>
Date:   Mon, 11 Jan 2021 09:43:56 +0100
Message-ID: <87pn2b6eyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 10 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> You prodded me about this and Johannes also did off-list. So given that
>> this is already in "next" I think it's best to let usage in this mktag
>> series land as-is.
>
> For an issue like this "test_i18ngrep or not?" that would end up
> giving a useful hint to future developers, a follow-up commit with
> an explanation why test_i18ngrep is preferred (or not) would be a
> great way to go forward (if the "fix" is needed in the first place,
> that is).  It is easy to add a patch to fix things up while a series
> is cooking in 'next', without having to remember doing so after the
> series hits 'master'.
>
>>     git some-command >output &&=20
>>     test_i18ngrep "c locale string" output
>>
>> But since 6cdccfce1e0 (i18n: make GETTEXT_POISON a runtime option,
>> 2018-11-08) this hasn't been needed.
>
> I did not immediately see why that commit changes any equation, but
> I am inclined to say that your argument makes sort-of sense, if not
> 100%, to me.  POISON test is not about testing features that ought
> to work (that is what non-POISON tests are for).  The primary
> objective of POISON test is to ensure that we didn't over-localize;
> if all the output from some-command is expected to be fully
> localized, between the above and
>
> 	GIT_TEST_GETTEXT_POISON=3Dno git some-command >output &&
> 	grep "c locale string" output
>
> there wouldn't be much difference.
>
> But if the output contains strings, some of which are expected to be
> localized (e.g. human facing messages) and some are not (e.g.
> protocol dump), and the test output is inspected for both types of
> strings, it would not be an equivalent test.

*nod* we have a few tests like that, but most of it is "run git & do one
 grep".

> Having said that, it may be OK that a mixed-output-command is tested
> only in C locale without localization.  Our tests do *not* make sure
> that the strings that ought to be localized are indeed localized
> anyway, so as long as the inspection of the output string does not
> check for string that are *not* to be localized, we won't break the
> primary objective of having POISON tests.

What do you think about just removing it? I.e. make setting it a noop?

> In any case, if you want to push forward in that direction to use
> more GIT_TEST_* settings in the test to replace i18ncmp/grep, please
> make sure you propose something easier to read than "GETTEXT_POISON"
> for the environment variable name.  It is overly long and makes the
> tests unreadable by pushing the part of the command that are more
> important off of the right edge of the screen.

Yeah, that sucks a bit. The common case though is that the "git"
invocation itself isn't reindented by more than a "\t". E.g. in my patch
upthread:


-		test_must_fail git mktag <tag.sig 2>message &&
+		test_must_fail env GIT_TEST_GETTEXT_POISON=3Dfalse \
+			git mktag <tag.sig 2>message &&

I wondered if I could support:

    git --lang=3DC mktag [...]

But the order of argv parsing & gettext setup makes that a bit
inconvenient. The argv parsing itself emits i18n messages, it could be
done in the C code.

Also a pain to pass it over to the Perl + sh side without changing
semantics (simplest would be to setenv(LC_ALL, "C"), but then anything
downstream of us changes too.

Hrm, but I see I never added the "poison" support to the Perl side, just
the SH code.

Now I seem to recall that the last time I looked at this I punted on it
because I thought I'd just wait until the Shell built-ins needing i18n
disappeared, which makes any changes to it easier.

To me it makes sense just to use it. GETTEXT_POISON isn't *that* long of
a name, and any shortening-ing of it seems not worth it to e.g. break
shell history / needing to alter existing C settings etc. again.

It's a typical length for for the GIT_TEST_* variables, so if we think
their use makes tests too verbose it makes sense to re-visit that as a
more general topic.

But I also think it makes more sense to just get rid of it
entirely...
