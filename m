Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59781F424
	for <e@80x24.org>; Fri, 20 Apr 2018 11:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754619AbeDTLSb (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 07:18:31 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:43594 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754549AbeDTLSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 07:18:30 -0400
Received: by mail-wr0-f178.google.com with SMTP id v15-v6so3907841wrm.10
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 04:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9xxuCUggngkFypqukcYUmh/21bnSSOsx8K6k74kylgo=;
        b=Ay7YsJewqIshd5qv3qKawunO/Iafh5d3mHxjvghVMytAE/q3R1qFuElwD6C+ymeUCC
         sYkGJCBCfS7GjdvauXvMrWJUPTbrquNrhTRgTI2ZUcHCYL7fkQ4EBumMyfvaxp387aUZ
         lN3RWNUXIW6okkMyJLIH+YQMq1f2HmS6EQOtyReFUVb95lU6cg0p5uebhAyfv383FbGV
         Xh29bCC64mjXLqNvQmSOmWeYA0GU7r2I+XYzD183SXdBR9yX5gjRwp6+uK7ZjrWn7Fsx
         0E2pK/5SP15b8FBd2MacwEhQ5A2hc9xWx9Z94romv6rjiyVdQoyOxZFU25al5jz1KfnZ
         EKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9xxuCUggngkFypqukcYUmh/21bnSSOsx8K6k74kylgo=;
        b=XRn2BxncPB81/B+3Aozrc5lTEPJO2dJhB9W1EM/vaT8hKAyeZEMFcOMifWG/rGg0jp
         Sh1Ogp9MrfnBvgE6BttjxitFDyHJjmPUiSiw2HCQGJdfyXv45jldeHUeHAQXxccCF8Zi
         g0gV/LOkbwP1E+lqT4XIzspgbUP13KFCvGjFc0CBhuLH5Vu2gGIDjK3PDfgIhIrbJsI0
         h6X46ExSG2Iv3qjXH8qjNxpE6RULrISquUmjDtwT1fSRuwPabFcOpweyTYH353GQykca
         qs+McJwux5q5zab8G2/AYUdblst3P5drL7mgdK0QQJyZKduduPaDXztTT9LOy+BTg4hN
         u28w==
X-Gm-Message-State: ALQs6tAMhl8EvI3WM+QqsqHR4TZeK6bJNuR6rdKG34U1CbJ8XGO7AiQR
        uLlF9OBgRPom4Yit7G+RVes=
X-Google-Smtp-Source: AIpwx49iv9HXgtYU1PUuWcCVTqfYtSsvVfvUhWSGkkT6iWco80UhNGCUL2AqsV6EFPkd0S/S/syvHw==
X-Received: by 2002:adf:ea90:: with SMTP id s16-v6mr3774708wrm.17.1524223109485;
        Fri, 20 Apr 2018 04:18:29 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id d7-v6sm5201947wrj.26.2018.04.20.04.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 04:18:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>
Subject: Re: [PATCH 1/3] gettext: avoid initialization if the locale dir is not present
References: <cover.1524211375.git.johannes.schindelin@gmx.de>
        <6be8678b7d6b4d9116ea4666a0b28ff4dd938690.1524211375.git.johannes.schindelin@gmx.de>
        <87o9iedwqn.fsf@evledraar.gmail.com>
        <CAN0heSpda1ZnFXgoCEgxGdBk-JYUSPAV0A=mQYMtOq7w8x+5=w@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAN0heSpda1ZnFXgoCEgxGdBk-JYUSPAV0A=mQYMtOq7w8x+5=w@mail.gmail.com>
Date:   Fri, 20 Apr 2018 13:18:27 +0200
Message-ID: <87lgdidt30.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 20 2018, Martin Ågren wrote:

> On 20 April 2018 at 11:59, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>>
>> On Fri, Apr 20 2018, Johannes Schindelin wrote:
>>
>>> The runtime of a simple `git.exe version` call on Windows is currently
>>> dominated by the gettext setup, adding a whopping ~150ms to the ~210ms
>>> total.
>>>
>>> Given that this cost is added to each and every git.exe invocation goes
>>> through common-main's invocation of git_setup_gettext(), and given that
>>> scripts have to call git.exe dozens, if not hundreds, of times, this is
>>> a substantial performance penalty.
>>>
>>> This is particularly pointless when considering that Git for Windows
>>> ships without localization (to keep the installer's size to a bearable
>>> ~34MB): all that time setting up gettext is for naught.
>>>
>>> So let's be smart about it and skip setting up gettext if the locale
>>> directory is not even present.
>
>> If you don't ship git for windows with gettext or a podir, then compile
>> with NO_GETTEXT, then we won't even compile this function you're
>> patching here. See line 30 and beyond of gettext.h.
>>
>> Are you instead compiling git for windows with gettext support with an
>> optional add-on package for i18n, so then this podir conditional would
>> pass?
>>
>> In any case, if this is actually the desired behavior I think it's worth
>> clearly explaining the interaction with NO_GETTEXT in the commit
>> message, and if you *actually* don't want NO_GETTEXT I think it's useful
>> to guard this with something like MAYBE_GETTEXT on top, so this code
>> doesn't unintentionally hide installation errors on other
>> platforms. I.e. something like:
>>
>>         int have_podir = is_directory(podir);
>>         if (!have_podir)
>> #ifdef MAYBE_GETTEXT
>>                 return;
>> #else
>>                 BUG("Broken installation, can't find '%s'!", podir);
>> #endif
>
> Is it fair to say that such a broken installation would function more or
> less well before and after Dscho's patch, and that your approach would
> render such an installation quite useless?

Yes my thown out there for the purposes of discussion suggestion may
break things for Dscho, or not. I'm just saying that we should document
*what* the use-case is.

Because it's not just important to massage the code so it works now, but
to document what the use-case is, so someone down the line who things
"oh why are we doing that" has a clear answer.

> Do we have some other similar
> cases where we go BUG("I could not find a resource. I could manage
> fairly well without it, but you seemed to want it when you installed
> me.")? I wonder what other well-respected software do if they can't find
> their translations.

E.g. my recent 1aca69c019 ("perl Git::LoadCPAN: emit better errors under
NO_PERL_CPAN_FALLBACKS", 2018-03-03) does similar things, we *could*
carry on in certain cases instead of dying there (or not, depending on
the codepath).

But in general, I don't think there's any reasonable use-cases for git
needing to repair from a broken or semi-broken installation that aren't
so specific that they can be explicitly declared, e.g. in this
hypothetical MAYBE_GETTEXT case.

Otherwise if it's not conditional, e.g. my git on Debian that won't ever
need this is going to just subtly regress because the FS is broken or
whatever, and I don't think we should have such code in git running
unconditionally.

> I suppose the logic could be the other way round, i.e., with a flag
> REALLY_REQUIRE_GETTEXT_AT_RUNTIME. But I also wonder if a user who does
> not notice that the installation is broken without us screaming BUG in
> their face, really minds the "brokenness" that much.

Without the BUG(...) that user is going to spend time fiddling with his
i18n settings before finally realizing that his package is broken, much
better to just emit an error so it's obvious that things are broken,
rather than taking the fallback path.
