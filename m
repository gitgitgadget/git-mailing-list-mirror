Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4B3E1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 09:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfG2JUv (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 05:20:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40612 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfG2JUv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 05:20:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so58651338eds.7
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3eJojPSDU8wZOrjeJqg94Mo1AVcKtLO4SAnNWTxSaEA=;
        b=uQLJpEuNBzjsbCIvREVG3P6u2dGL9hjJURci4G1rCLD1ERHDW82PazNB8Rv4ONSin4
         6UO7NE184xsTh9jwKCgkXBkRM12IC2KK+n0JN93aDUp9c60KHQg7uPZnjtWu0Hi9zSGv
         wtpLVc3JcthOZE5gXJXfLCXIgD+kEZnCCUHdinmvo0NfzkqCdz7iR7UD6r1CIOSUCe6A
         O7CttUKYex4PWc/7f1/R/iRuqlk+ArHe2VLUEpf6JMlI9uGR1Ql3SMC0endKVAcx1weT
         m6LMF6LOhy+Qh1Z5QSOraKNKXcPTHZ/vs8xS6+AnqPKvfOz02oS6l1iEVHAOcqGbpsrd
         Z7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3eJojPSDU8wZOrjeJqg94Mo1AVcKtLO4SAnNWTxSaEA=;
        b=oEWoHB4vEnfztefGDc/MMXuZPAh5pU1tdk4UDpvcmG1px6HnxTKTNxAIz3o2nuYP5q
         +5t/7DNVCte6f+eC2Z7nB+qkAc1gBXB6PbZh8z22JlX9I/wyHdFkTsuTsELlkgtvjkIU
         10zVp3f62irK6CUpEODMHDNl8z1Jtuf60n/88ELgdnMwkU22f5aVctCCOMKQvtR+TtxJ
         e36X4ef2FkeodzYN8eRQTQ9qamqtxLlmy/xPcm+Ld1+Zi4uPuFKIeCI4T9HnJQtJYrvA
         UuFLFBVuQYKWdAyx4FxoJjEJ/Un5TvIqr19ozxj51mdxMflCkq1Q2PTiFTYAzc0ao0ul
         +I4g==
X-Gm-Message-State: APjAAAUWO1ZtlVlT+Z18bs/Y6TkeVRMnaUVB5v9A+EcqcillerVKsxsN
        buxygKqMMK5eZ4UJonBtOEE=
X-Google-Smtp-Source: APXvYqx4A8mWPHVstr2pP1+C5rcGRYVhtFO6M3KRjsUowldbub32VjaYP41tV6mVn3lR8478XsIh9w==
X-Received: by 2002:a50:ad0c:: with SMTP id y12mr93280956edc.25.1564392049642;
        Mon, 29 Jul 2019 02:20:49 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id b15sm11516647ejp.7.2019.07.29.02.20.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 02:20:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/8] grep: PCRE JIT fixes + ab/no-kwset fix
References: <20190724151415.3698-1-avarab@gmail.com> <20190726150818.6373-1-avarab@gmail.com> <xmqqpnlwmthc.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqpnlwmthc.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 29 Jul 2019 11:20:48 +0200
Message-ID: <87y30h5h8v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 26 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> 1-3 here are a re-roll on "next". I figured that was easier for
>> everyone with the state of the in-flight patches, it certainly was for
>> me. Sorry Junio if this creates a mess for you.
>
> As long as I can just apply all of them on top of no-kwset and keep
> it a single topic, it wouldn't be too much of a hassle.
>
>> 4-8 are a "fix" for the UTF-8 matching error noted in Carlo's "grep:
>> skip UTF8 checks explicitally" in
>> https://public-inbox.org/git/20190721183115.14985-1-carenas@gmail.com/
>>
>> As noted the bug isn't fully fixed until 8/8, and that patch relies on
>> unreleased PCRE v2 code. I'm hoping that with 7/8 we're in a good
>> enough state to limp forward as noted in the rationale of those
>> commits.
>
> Yikes.  Perhaps we should kick the no-kwset thing out of 'next' and
> start from scratch?  It does not sound that the world is ready yet.

I have some fix-for-the-fix and was going to submit a v3 of this series,
but I think the more responsible thing to do at this point, especially
with various patches from Carlo that need to be integrated in one way or
another, is to back it out until the outstanding issues are addressed.

If it's not too much trouble, would you mind reverting just the two
patches at the tip of ab/no-kwset in "next"? I.e.

    b65abcafc7 ("grep: use PCRE v2 for optimized fixed-string search", 2019=
-07-01)
    48de2a768c ("grep: remove the kwset optimization", 2019-07-01)

I believe the rest are all settled & haven't had any issues raised with
them, and those tests & preparatory fixes would be very useful to have
in "master" for any re-roll without needing to be distracted by those
changes.

> But that is just a knee-jerk reaction before reading the actual
> patches.  Let's see how they look ;-)
>
> Thanks.
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
>>   grep: remove overly paranoid BUG(...) code
>>   grep: stop "using" a custom JIT stack with PCRE v2
>>   grep: stop using a custom JIT stack with PCRE v1
>>   grep: consistently use "p->fixed" in compile_regexp()
>>   grep: create a "is_fixed" member in "grep_pat"
>>   grep: stess test PCRE v2 on invalid UTF-8 data
>>   grep: do not enter PCRE2_UTF mode on fixed matching
>>   grep: optimistically use PCRE2_MATCH_INVALID_UTF
>>
>>  Makefile                        |  1 +
>>  grep.c                          | 68 +++++++++++----------------------
>>  grep.h                          | 13 ++-----
>>  t/helper/test-pcre2-config.c    | 12 ++++++
>>  t/helper/test-tool.c            |  1 +
>>  t/helper/test-tool.h            |  1 +
>>  t/t7812-grep-icase-non-ascii.sh | 39 +++++++++++++++++++
>>  7 files changed, 80 insertions(+), 55 deletions(-)
>>  create mode 100644 t/helper/test-pcre2-config.c
