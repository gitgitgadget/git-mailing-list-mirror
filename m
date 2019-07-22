Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B881F461
	for <e@80x24.org>; Mon, 22 Jul 2019 19:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfGVTm2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 15:42:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46876 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGVTm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 15:42:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id d4so41665257edr.13
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6qSbaCOVnG+YLjCr/wP/ZZ//S1mCu2gD4I/xscexLh4=;
        b=DkrpvaJ+d+6fHDZzkAGhK1umMT1jKxN+/HQtQ5s7Iou1W0X2n/pYnevwrvC58N1uBu
         tIKc3tdGvpVznTYJ8bnTJgstZdgqbA9RgRLi/eH3+0DtDM2BREEOiPc/sdMTznvfrVqh
         CEOZ//2xFe4Q7wCSwE8ecGDUy4BTxA1SIRFkxmC0dnXY5fs4Ts5J7KtyvNKxwCENxMkx
         5W5PZxljdLlEhHcQdC3b8zCBSNPCyA6xrfMjwwaD639nELFLY4gV/5Ogi500vn69VhOr
         FQ5mKwCglzn6O4zPHy4qJLALFEUl+0AlFPyQKjW6LJMqsmLcmzNUoOVGPSXsrC1yB54o
         TreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6qSbaCOVnG+YLjCr/wP/ZZ//S1mCu2gD4I/xscexLh4=;
        b=uUGOQoiUQejatusV3rKNgpLCKZrY7rqGm4PCGigNpEFm/lWlyPgHJ3/bGSXVz7Z6cy
         W6RXLxfVh4QMV/kRyE2+SYFVjFNBRpdbyaZSIhfbJf5bnyuLb5Vxmp6jy0gpQYlxtghM
         +ENpu7F3aMZrvCqzNmvFc1qG4KBYNMy0EhveJa6gQb9P/kQ9mEt1nOCQoYQuwVpyCd4f
         swJuxmBwJ/z9DreRcGb9T3G/JwfMZgEs9+7jue7BbUmHm4U6RR2ipJ1RsWtaHOYNwerM
         80zSL1bSPFn1vu0hKaMVXeuD7Og/QcIMDM2D3wXchYJfuTn66DY6/RK+sCdqF10CKrRJ
         XLGg==
X-Gm-Message-State: APjAAAVRwXlJ8BxZ+fo0gTtzJdcMvBlQueia6xGop/1hXkjuwOdhJVre
        hox17YeAByB80DzNb4Uq8Fs=
X-Google-Smtp-Source: APXvYqwMdCPU77yTQVZnvr6ti/R4CfXqX781NOae1SL8OJmzOg8lIbInVBptT+jyCOe9N9PHRyvgcA==
X-Received: by 2002:a50:b0e3:: with SMTP id j90mr62187665edd.26.1563824545846;
        Mon, 22 Jul 2019 12:42:25 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id pv18sm8107446ejb.14.2019.07.22.12.42.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:42:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
Date:   Mon, 22 Jul 2019 21:42:24 +0200
Message-ID: <87muh57t5r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 22 2019, Johannes Schindelin wrote:

> Hi Carlo,
>
> On Sun, 21 Jul 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
>> Usually PCRE is compiled with JIT support, and therefore the code
>> path used includes calling pcre2_jit_match (for PCRE2), that ignores
>> invalid UTF-8 in the corpus.
>>
>> Make that option explicit so it can be also used when JIT is not
>> enabled and pcre2_match is called instead, preventing `git grep`
>> to abort when hitting the first binary blob in a fixed match
>> after ed0479ce3d ("Merge branch 'ab/no-kwset' into next", 2019-07-15)
>
> Good idea.
>
> The flag has been in PCRE1 since at least March 5, 2007, when the
> pcre.h.in file was first recorded in their Subversion repository:
> https://vcs.pcre.org/pcre/code/trunk/pcre.h.in?view=3Dlog
>
> It also was part of PCRE2 from the first revision (rev 4, in fact, where
> pcre2.h.in was added):
> https://vcs.pcre.org/pcre2/code/trunk/src/pcre2.h.in?view=3Dlog

Thanks for digging, that portability indeed sounds just fine.

> So I am fine with this patch.

I'm not, not because I dislike the approach. I haven't made up my mind
yet.

I stopped paying attention to this error-with-not-JIT discussion when I
heard that some other series going into next for Windows fixed that
issue[1]

But now we have it again in some form? My ab/no-kwset has a lot of tests
for encodings & locales combined with grep, don't some of those trigger
this? If so we should make any such failure a test & part of this patch.

Right now we don't have the info of whether we're really using the JIT
or not, but that would be easy to add to grep's --debug mode for use in
a test prereq.

As noted in [2] I'd be inclined to go the other way, if we indeed have
some cases where PCRE skips its own checks does not dying actually give
us anything useful? I'd think not, so just ignoring the issue seems like
the wrong thing to do.

Surely we're not producing useful grep results at that point, so just
not dying and mysteriously returning either nothing or garbage isn't
going to help much...

1. https://public-inbox.org/git/xmqq4l3wxk8j.fsf@gitster-ct.c.googlers.com/
2. https://public-inbox.org/git/87pnms7kv0.fsf@evledraar.gmail.com/

> Thanks,
> Dscho
>
>> ---
>>  grep.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/grep.c b/grep.c
>> index fc0ed73ef3..146093f590 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -409,7 +409,7 @@ static void compile_pcre1_regexp(struct grep_pat *p,=
 const struct grep_opt *opt)
>>  static int pcre1match(struct grep_pat *p, const char *line, const char =
*eol,
>>  		regmatch_t *match, int eflags)
>>  {
>> -	int ovector[30], ret, flags =3D 0;
>> +	int ovector[30], ret, flags =3D PCRE_NO_UTF8_CHECK;
>>
>>  	if (eflags & REG_NOTBOL)
>>  		flags |=3D PCRE_NOTBOL;
>> @@ -554,7 +554,7 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>>  static int pcre2match(struct grep_pat *p, const char *line, const char =
*eol,
>>  		regmatch_t *match, int eflags)
>>  {
>> -	int ret, flags =3D 0;
>> +	int ret, flags =3D PCRE2_NO_UTF_CHECK;
>>  	PCRE2_SIZE *ovector;
>>  	PCRE2_UCHAR errbuf[256];
>>
>> --
>> 2.22.0
>>
>>
