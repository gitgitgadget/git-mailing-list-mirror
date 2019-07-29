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
	by dcvr.yhbt.net (Postfix) with ESMTP id 644E61F462
	for <e@80x24.org>; Mon, 29 Jul 2019 09:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfG2JFg (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 05:05:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38278 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG2JFg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 05:05:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so23835171edo.5
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lZ04vOOOKW6zIVTz56lK0VuPIIYbe+hNMxA22baCCQM=;
        b=oDCKtyy+FQ9wVATyJXrieOv9iGU2DhJmL47vLfjNnjpngIx9A4/yjZE/r8Ztr0jXkN
         n03nVoRs6qZrY/JpsoC7Qxhf1j9xmzrObc90g+kxCgthyWBRHf+SOwoiRrEJ/NKsg3AJ
         N+wd3hGEsGPfc7OExumIZ+qCx7ilq+M5hjHkHh2VHlccqZLcX++7ELKpzqZOrXZQfJwi
         iLO7UpOlW2kuFUXjtbBX0Ow3AuZPJe4ZpWGgtnwt8qX2MJLNQQupiik1PjYpoyVLqqoq
         twUXm6tvfynyuKRZ8YW3oWcfLWj77gYP0pOpr3auGEMokm0O4mspyHpcEsM577lTzHNU
         O7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lZ04vOOOKW6zIVTz56lK0VuPIIYbe+hNMxA22baCCQM=;
        b=blcxFrkjT8NAff1CVEv2ef0wmnq/zcnA7JhKfVvu2HB7oU3Ey8cBGUHyh3WNzAFX6G
         bLnqP1QSZD7xhsoy3LxW+WPfrkPWzbXGYxFTipME6hyT5J/K268cOp9G2c1+h/Qp/lpL
         KLX9CWIX7eB6W64L/JkHOhSYdtqLt+KmhnAo8r7lScHTNZaxfgmp/PyFpV0DTmLqHz+3
         pDg9NWjTEE8i3z0kB3K/nggXW/wb+BVrcSmcOIyNAgSe9ZodxPzRlsylITx41SyO1nKy
         KZuAYsliahl2ClckU0IBWscNHZVyt5c+CcnmdGd2ZqavHJf6fjAZ9yRJ1RFf+DucYVGA
         VGRA==
X-Gm-Message-State: APjAAAWbk1KqVfQ8c42JBSSwJ09f1gCqUvrC3Tpn25kBKhi4k8/Ib7yY
        qtBLxcCTavQwOALZ+oaLm1Y=
X-Google-Smtp-Source: APXvYqwEISJYLACqaQusmWzzA2hrJaC+rDmbTeXOKDIDtceMZ4eta/FvuW0M+9zMcsOfO7rTNny8Qg==
X-Received: by 2002:a17:906:114d:: with SMTP id i13mr83725877eja.252.1564391134549;
        Mon, 29 Jul 2019 02:05:34 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id v12sm11443862ejj.52.2019.07.29.02.05.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 02:05:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/8] grep: consistently use "p->fixed" in compile_regexp()
References: <20190724151415.3698-1-avarab@gmail.com> <20190726150818.6373-5-avarab@gmail.com> <CAPUEspgay3RnLH3pdEWyktgn8XeuiKZ8PYPNB_38gyxffmh5Jw@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPUEspgay3RnLH3pdEWyktgn8XeuiKZ8PYPNB_38gyxffmh5Jw@mail.gmail.com>
Date:   Mon, 29 Jul 2019 11:05:33 +0200
Message-ID: <871ry96wiq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 29 2019, Carlo Arenas wrote:

> On Fri, Jul 26, 2019 at 8:09 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> It's less confusing to use that variable consistently that switch back
>> & forth between the two.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  grep.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/grep.c b/grep.c
>> index 9c2b259771..b94e998680 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -616,7 +616,7 @@ static void compile_regexp(struct grep_pat *p, struc=
t grep_opt *opt)
>>                 die(_("given pattern contains NULL byte (via -f <file>).=
 This is only supported with -P under PCRE v2"));
>>
>>         pat_is_fixed =3D is_fixed(p->pattern, p->patternlen);
>> -       if (opt->fixed || pat_is_fixed) {
>> +       if (p->fixed || pat_is_fixed) {
>
> at the end of this series we have:
>
>   if (p->fixed || p->is_fixed)
>
> which doesn't make sense; at least with opt->fixed it was clear that
> what was meant is that grep was passed -P

I assume you mean "was passed -F...".

> maybe is_fixed shouldn't exist and fixed when applied to the pattern
> means we had determined it was a fixed
> pattern and overridden the user selection of engine.

They're two flags because p->fixed is "--fixed-strings", and p->is_fixed
is "there's no metachars here". So the former case needs escaping, as
the code just below might do (the two aren't mutually exclusive).

I don't get how you think we can always fold them into one flag, but
maybe I'm missing something...

> that at least will give us a logical way to fix the pattern reported
> in [1] and that currently requires the user to know
> git's grep internals and know he can skip the "is_fixed" optimization
> by doing something like :
>
>   $ git grep 'foo[ ]bar'
>
> [1] https://public-inbox.org/git/20190728235427.41425-1-carenas@gmail.com/

As I noted in a reply there this seems like a way to fix a bug in "next"
with a config knob. Yes we should fix the bug, but we've had the kwset
code in git for years without needing this distinction, so after we work
out the bugs I don't see why we'd need this.

The reason we ignore the user's choice here is because you might
e.g. set grep.patternType=3Dextended in your config, and you'd still want
grepping for a fixed "foo" to be fast.
