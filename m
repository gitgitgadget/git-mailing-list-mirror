Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AC9C3527E
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F662332A
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393565AbgLJWbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 17:31:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33781 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405126AbgLJWZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 17:25:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id t22so8588941ljk.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 14:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=A0s/M57IBE90xfI8PWYqlE7fs0bCLICPYSyS8x2+/HY=;
        b=lUnMSfuqFLWW8j1oF+gH9F6lIfMoLrM3Md0XAtuELl0Hlpo7bY8fS7F+QAIh3Blg5V
         O7Y6/akOrkF9j2BnOnAgmVmG+VEh+b9S46AbmfoYsC884cYH3EYeaj55CRizhppr5jSF
         lmfaY0n4czzpUxEOviipB6hOvWrnTkBR1oQV7xkhEzRmwI4O6QV6uJuKMq64zLLl3cdl
         G3OPkgpt1143vKvwscAXGkSk2mrO1JDgvj7noWd//s1Cy02vSISoJjLS6wHo5Onr/z7Q
         VrBHbGSJCgx6XuLVGvMnpae04s/Io0/lzgZjRlO2+2AAZhw1kXMWYUAfLtWQzGZQOTdd
         PDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=A0s/M57IBE90xfI8PWYqlE7fs0bCLICPYSyS8x2+/HY=;
        b=WkMHMwZdGbC0ufi9Kv7p4cE04D8cH28siCX7u8Mbfh2S4rKtkc6Dcb4C/iOTQPx0fl
         qvZVvzUp06AJEiDOOTmhRsvCGQmugC5hhIV4Bv3ACQL7S8qT4ASFzxHlVh7I5a5vYoDS
         wJUTih/aWDoFR9d1oMImWFcuKiB0PTiQFooAcnR+Ao9vDd4St01flzr7brotaxQtpJJp
         rI4u1gl3J0hVPEJI9LrjdL0IGBBOOEne+FopSgTeefwdY0lMv7Pk9KxjxMJdV0ZiEmhP
         JQ/oZ2tYtzkEYCRshGf6j/auYrF39VfTyzk7Hqw93SZOGum1G7h2tQuD8N4osfvvf0PK
         Oi6w==
X-Gm-Message-State: AOAM530jwaAVTQH3YK0O+RkFa/biN+b0o/dxoqfKCIcLplP2RUr/3KtJ
        Zgy9hDd5w8916gjGvIskxyZZvX8kg6F0Pw==
X-Google-Smtp-Source: ABdhPJz4bqXA7AsKNlhdtOJQT2OwOusbB9w3bKeeGLAKKAsSnMswYNy/IKcpsAu+b0wKjE4Hm1xdgg==
X-Received: by 2002:aa7:da01:: with SMTP id r1mr9127874eds.45.1607638665370;
        Thu, 10 Dec 2020 14:17:45 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id m2sm5985159edf.27.2020.12.10.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 14:17:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] refs: warn on non-pseudoref looking .git/<file> refs
References: <20201210125321.19456-1-avarab@gmail.com>
 <20201210125321.19456-2-avarab@gmail.com>
 <CAPig+cQpB3B+Ywc1aFd7QMrqVKy29VmNKJfzcFeSCYz=mwO0Hw@mail.gmail.com>
 <87sg8dwglk.fsf@evledraar.gmail.com>
 <CAPig+cSph9EcnGDUBjWsvR3yfbydK=mOMPmCEas=YC6bUJS=zA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <CAPig+cSph9EcnGDUBjWsvR3yfbydK=mOMPmCEas=YC6bUJS=zA@mail.gmail.com>
Date:   Thu, 10 Dec 2020 23:17:43 +0100
Message-ID: <87mtylwbjs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 10 2020, Eric Sunshine wrote:

> On Thu, Dec 10, 2020 at 3:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Thu, Dec 10 2020, Eric Sunshine wrote:
>> > On Thu, Dec 10, 2020 at 7:55 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > <avarab@gmail.com> wrote:
>> >> +       GIT_TEST_GETTEXT_POISON=3Dfalse grep "like a pseudoref" err &&
>> >
>> > What is the purpose of assigning GIT_TEST_GETTEXT_POISON here?
>>
>> Since 6cdccfce1e0 (i18n: make GETTEXT_POISON a runtime option,
>> 2018-11-08) we haven't needed to use the C_LOCALE_OUTPUT prerequisite
>> for any new code, since we can just turn the poisoning off.
>>
>> I think we should just slowly refactor things away from that
>> prerequisite and test_i18ngrep, which were only needed because it used
>> to be a compile-time switch, but I haven't gotter around to that
>> refactoring.
>>
>> In liue of that I think it makes more sense to always run the full test
>> if possible, no matter what the GIT_TEST_* mode is.
>
> I must be missing something. I've looked at 6cdccfce1e0 but I still
> don't see how or why `GIT_TEST_GETTEXT_POISON=3Dfalse` could affect the
> simple `grep` invocation being done by this test. I could understand
> if GIT_TEST_GETTEXT_POISON was applied to the invocation of a Git
> command, but that's not the case here.
>
> (I also notice that 6cdccfce1e0 only checks whether
> GIT_TEST_GETTEXT_POISON is empty or not -- and the changes in
> 6cdccfce1e0 set GIT_TEST_GETTEXT_POISON to an empty value rather than
> to "false", so I find myself doubly confused by this application of
> GIT_TEST_GETTEXT_POISON to `grep`.)

You're not missing something, but it seems I need to step away from the
computer for the day. I managed to write this & reply to your E-Mail
without noticing I'd put the GIT_TEST[...] env variable in front of the
wrong command. It should indeed be in front of the rev-parse above.
