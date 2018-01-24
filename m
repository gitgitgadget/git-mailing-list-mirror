Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24AC61F404
	for <e@80x24.org>; Wed, 24 Jan 2018 23:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbeAXXHF (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 18:07:05 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:44628 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932884AbeAXXHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 18:07:04 -0500
Received: by mail-wr0-f173.google.com with SMTP id v31so353071wrc.11
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 15:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=IRnse4BQKhU2vO0369alRGDjHSppyg8SLGFCzl49d4I=;
        b=YhpmwsHcH4Xuj/FdyA3Vu42zjOpIPcPZL7WxM1p0ZWiw+3GvD6wjtMiyIS/JAtwa+t
         FqUuHlRD0C+wJCFZ1exJa0RB9KCYdlC7HA43sKQ49rcF6KK7Gkp6C8CuI/UCHLlc9aHZ
         GhsQm4AEl5y/BrGTZYWQIQtBd0SAtFRZMhV6o9/lcPivAnF1vC4541YJsm03vW80tQ1J
         ROjyK/QSvMFyZkDKo3AqlM1AB1EN+KpsXyqK26shOUTOH31ynOFpiDfkBVntajPDyujX
         C7OxkYpyobpwcl7Spp9TrMpScFdmrJrSD9X1o3ttGGHr/498gk4ZwxQo2YarKmr797t7
         JDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=IRnse4BQKhU2vO0369alRGDjHSppyg8SLGFCzl49d4I=;
        b=jWfnodsVAqmG2nEf9uYArc5sjh9rRAOUvsr1werXa+a9YUQ49hedXtf/KWInuicg5O
         sXBnt/tvCbqlV6GlbtVNMnc6KgUDvggyGo+00echG4xSv1sSp721hq+F1ppVpe3fkNRh
         AVQzYSmoCttxHkwJRHoFN0+OiupT6FvLgNrLwP3A0kpynNe/Yow9/XCNrOPlYebjzHqP
         cgwhXM3VSSeKAXHLDamOzeampVfI1/YLQdhnLcDpj4KPOwR4HrBGx87N6Xh/LW8MgY4v
         dCCt5FXDnOUM74py6HiAmU00yRv3GqBSwObG7Bett7mvqeHrmuypkNj4zs/QBe8Jjhyl
         4pRg==
X-Gm-Message-State: AKwxytdbCSAvHAkVfp78FBP6wtOv4JqUIE1pftiFHglqtpa5GY6ErElO
        GULhzV/qxMeFDixEdafpIhs=
X-Google-Smtp-Source: AH8x227LfggucEOoV3pbJcBv2oQmb0ATzm0oGrroSdEUoWQ+63TIUMimxsjO8ygIeQUUZMBqf7qmSw==
X-Received: by 10.223.184.102 with SMTP id u35mr6757506wrf.143.1516835222883;
        Wed, 24 Jan 2018 15:07:02 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 188sm1588915wmg.29.2018.01.24.15.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 15:07:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: Git packs friendly to block-level deduplication
References: <87bmhiykvw.fsf@evledraar.gmail.com> <CABPp-BE0u9x_TtEHmfS11ZV-50rSvCi_y7cmTVV7z=2zT3atvg@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CABPp-BE0u9x_TtEHmfS11ZV-50rSvCi_y7cmTVV7z=2zT3atvg@mail.gmail.com>
Date:   Thu, 25 Jan 2018 00:06:59 +0100
Message-ID: <878tcmyhyk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 24 2018, Elijah Newren jotted:

> On Wed, Jan 24, 2018 at 2:03 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> If you have a bunch of git repositories cloned of the same project on
>> the same filesystem, it would be nice of the packs that are produced
>> would be friendly to block-level deduplication.
>>
>> This would save space, and the blocks would be more likely to be in
>> cache when you access them, likely speeding up git operations even if
>> the packing itself is less efficient.
>>
>> Here's a hacky one-liner that clones git/git and peff/git (almost the
>> same content) and md5sums each 4k packed block, and sort | uniq -c's
>> them to see how many are the same:
>
> <snip>
>
>>
>> Has anyone here barked up this tree before? Suggestions? Tips on where
>> to start hacking the repack code to accomplish this would be most
>> welcome.
>
> Does this overlap with the desire to have resumable clones?  I'm
> curious what would happen if you did the same experiment with two
> separate clones of git/git, cloned one right after the other so that
> hopefully the upstream git/git didn't receive any updates between your
> two separate clones.  (In other words, how much do packfiles differ in
> practice for different packings of the same data?)

If you clone git/git from Github twice in a row you get the exact same
pack, and AFAICT this is true of git in general (but may change between
versions).

If you make a local commit to that, copy the dir, and repack -A -d you
get the exact same packs again.

If you then make just one local commit to one copy (even with
--allow-empty) and repack, you get entirely differnt packs, in my test
2.5% of the blocks remain the same.

Obviously you could pack *that* new content incrementally and keep the
existing pack, but that won't help you with de-duping the initially
cloned data, which is what matters.
