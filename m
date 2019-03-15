Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9595C20248
	for <e@80x24.org>; Fri, 15 Mar 2019 15:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfCOPvx (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 11:51:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40713 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfCOPvx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 11:51:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id r23so8011217edm.7
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/ScG5mE8RuQQXn2hvhaf7X+HLstUDLP2L8JQsA8MyME=;
        b=TRRcOeh+VVp35bgMGka641ahWJ91Rre2uX2tmRW8VzEyGI67NeQwne7D9op9zjQpgE
         eHCHv9u37ROrsk7Z17BFO/EXUzSpWg3ew8NDV7Xm9y2gW0VH66yLUpNUflpYfnDHSTqJ
         vNpDGECcuKplmhL5l3SYgbTpLz4IUFN11wdSySJwNILmhdSZr9pa8fOnqwaHe9Kro93r
         S53wXlW09vDnNBUktGzFy21spUHZULt0SBSA2yO3fR0ElVHizBKTsSiOyCSIRuRiwcmL
         3TIb25wCady2QdWnaZ02A04lnMyNTn3m6Q/gnTVGpouHN2lNTtD37ibyxKpzDew202yE
         L0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/ScG5mE8RuQQXn2hvhaf7X+HLstUDLP2L8JQsA8MyME=;
        b=s+BdVEZjlHF7Tu8D16lT4OehaIb70G5lqK5qmGqGQFzwU/8rzncC52Onn7yNJi+oQ8
         AU6CY4cgXekzETaigqStE9ZR1LCwb3dDCsTnHvCZ+c8rMWbvFx+26+Qj7G1cx32dRXVQ
         A6tbbHqDftexrCLMjzQx58kc/KZ1T882ZZP/rAZqTPWGhbAB3har/9P3DWtO1hqF0e5b
         tjIM74qhr08aPJLc9NZpU7oHIONjJkvt0TOCA0UiodUzsYQlWdti2NzTNclMz7nzUSco
         b651KyHnd8jjrQQtyTWMHMVyVnT0w8Tqgph883ZUQQs7uZcwFuMxM1uAIWUp2xQX3w6c
         t9qw==
X-Gm-Message-State: APjAAAUhExMj5E8aZt3THOuqAbCMAN8p+51v55Cj49fVmHfQyiN3/y44
        RqurY/EarkJDC1/kdoCOgM3OwuD1iF4=
X-Google-Smtp-Source: APXvYqz2RTrO3Ckug1xrnQJ3oksOZoiyVqirTQ+Y4pdXrDOcxllSNbPYTq/lK+rMVEl1QIo2xb2E8g==
X-Received: by 2002:a17:906:5e0d:: with SMTP id n13mr2648467eju.139.1552665111543;
        Fri, 15 Mar 2019 08:51:51 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id x18sm732229edd.4.2019.03.15.08.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 08:51:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 5/7] reflog: exit early if there's no work to do
References: <20190313235439.30439-1-avarab@gmail.com> <20190314123439.4347-6-avarab@gmail.com> <CACsJy8C-zyh6Vea1hqciDHhKk+UvS5qFb1F2SfU15yWniy53Hw@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8C-zyh6Vea1hqciDHhKk+UvS5qFb1F2SfU15yWniy53Hw@mail.gmail.com>
Date:   Fri, 15 Mar 2019 16:51:50 +0100
Message-ID: <871s38b0fd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 15 2019, Duy Nguyen wrote:

> On Thu, Mar 14, 2019 at 7:35 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> When gc.reflogExpire and gc.reflogExpireUnreachable are set to "never"
>> and --stale-fix isn't in effect (covered by the first part of the "if"
>> statement being modified here) we can exit early without pointlessly
>> looping over all the reflogs.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/reflog.c  | 7 +++++++
>>  t/t1410-reflog.sh | 4 +++-
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/reflog.c b/builtin/reflog.c
>> index 4d3430900d..d95c77ca0e 100644
>> --- a/builtin/reflog.c
>> +++ b/builtin/reflog.c
>> @@ -606,6 +606,13 @@ static int cmd_reflog_expire(int argc, const char *=
*argv, const char *prefix)
>>                 mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
>>                 if (flags & EXPIRE_REFLOGS_VERBOSE)
>>                         putchar('\n');
>> +       } else if (!cb.cmd.expire_total && !cb.cmd.expire_unreachable) {
>> +               /*
>> +                * If we're not expiring anything and not dropping
>> +                * stale entries, there's no point in even opening the
>> +                * reflogs, since we're guaranteed to do nothing.
>> +                */
>
> I'm checking should_expire_reflog_ent(). With both of these being
> zero, we skip most of the "return 1;" except the last one
> cb->cmd.recno, added in 552cecc214 (Teach "git reflog" a subcommand to
> delete single entries, 2007-10-17). Will this shortcut affect that use
> case (I haven't spent time understanding that commit yet, gotta run
> soon)?

There was a bug related to this. Fixed in v3.

>
>> +               return 0;
>>         }
