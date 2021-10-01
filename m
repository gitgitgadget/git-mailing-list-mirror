Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BEEC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 07:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797F461A6F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 07:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352486AbhJAHZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 03:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbhJAHZq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 03:25:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B43DC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 00:24:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x7so30316902edd.6
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RL8K6bXF0nekAgVAM/6lhUZB0ZT5W1nqKlIIN+3gfU0=;
        b=irlyrSEhCeukjwJQnCKaJuqkPIOFPqMw/GLa1A/I8Myr2FAbrdEzsdVEpOs9Sc51X/
         iWM7MicG8yxRpQVWDoo60lhqfslZ4oAn+vDBILTsuF3WJsLZ5uK+ZGMofTC/qLgMUdsL
         bx84CD5HXNyeO8cmKTSoH3Tci5ZBguIxdkPHh6Dg4PDdmws2bTwQQ3EbAb22srs0q+qH
         ecL13Gs+7CBFPxIf1tIO6Qu3H20ynKV8CTOkcw12sxRe6lHOZSDhX9i6YXYh3xQ3cW0p
         aISAsrGI1azV28XVIe+uex3cAumUm7FCe2pfl5lOysSsTsRsrVYcHYdwo3veygDF3pw2
         LZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RL8K6bXF0nekAgVAM/6lhUZB0ZT5W1nqKlIIN+3gfU0=;
        b=0eknuY5+A8UmOsUucKi+9Lz9hIVhdw5ziHSFqVL2rpGsU2KrejltY14urh2/4jPzQF
         U35O0CqXyYBPJ25+If64DyEUPZoVJ0GAnujDozV+TYUP8SJSzLUmpLI/ENLcXirfNBLr
         N3RN/anAVI+HXsNrHzJa46DxSjmSaJooeQN2c2E4xiUuZHO5kSwmg/2lq0elYGY5H8AP
         mtGiBN0l4JtvV2w1TN6Ll5Q6MqcxHf3WpVXU15W2h+sqTOtzJxOEx7jMKbK+i8MnJQIc
         Gznns94wFpUmZVsw8FItvYWChvn5KjpudHIYU+32f+rk9qmqb5nQwvhKs0T2JlkyN+9X
         N9GQ==
X-Gm-Message-State: AOAM532wbjzSeJUAJqGEiG851npBhNsRHhHZO1yZTSrb+VXvXBCpqM/8
        1J3g9kumNbIHjkckYWn+2OFZ0gRFPM8vRA==
X-Google-Smtp-Source: ABdhPJw/N4JcHXSrd4kQ4gNVhZpLt7C/XhVc+/Hfd0CGbgcXi4u8Is1x6JzBklOn3nrK3hNUK854Gw==
X-Received: by 2002:a17:906:69c3:: with SMTP id g3mr4578453ejs.265.1633073040518;
        Fri, 01 Oct 2021 00:24:00 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cb7sm2686015edb.49.2021.10.01.00.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 00:24:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 4/7] merge-ort: capture and print ll-merge warnings in
 our preferred fashion
Date:   Fri, 01 Oct 2021 09:23:30 +0200
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <ce95b82fc492d48fa6022df424f9a303a1c70ad4.1630376800.git.gitgitgadget@gmail.com>
 <87a6jut36p.fsf@evledraar.gmail.com>
 <CABPp-BFyh239+7FLuUuoRJJbcE8NxHZABPTXPmSQhvRSPCiGvQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BFyh239+7FLuUuoRJJbcE8NxHZABPTXPmSQhvRSPCiGvQ@mail.gmail.com>
Message-ID: <871r55tdgw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Elijah Newren wrote:

> On Thu, Sep 30, 2021 at 9:53 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Tue, Aug 31 2021, Elijah Newren via GitGitGadget wrote:
>>
>> > @@ -108,8 +108,14 @@ test_expect_success 'refuse to merge binary files=
' '
>> >       printf "\0\0" >binary-file &&
>> >       git add binary-file &&
>> >       git commit -m binary2 &&
>> > -     test_must_fail git merge F >merge.out 2>merge.err &&
>> > -     grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge=
.err
>> > +     if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
>> > +     then
>> > +             test_must_fail git merge F >merge.out &&
>> > +             grep "Cannot merge binary files: binary-file (HEAD vs. F=
)" merge.out
>> > +     else
>> > +             test_must_fail git merge F >merge.out 2>merge.err &&
>> > +             grep "Cannot merge binary files: binary-file (HEAD vs. F=
)" merge.err
>> > +     fi
>> >  '
>>
>> To save readers from eyeballing if a single character has changed here,
>> which I don't think it has, just do:
>>
>> if ...
>> then
>>         cmd >actual
>> else
>>         other cmd >actual
>
> Do you mean
>    other cmd >/dev/null 2>actual
> ?

Yes, sorry. I was going for lazy pseudocode. I meant maybe the "grep"
can be shared between the two.
