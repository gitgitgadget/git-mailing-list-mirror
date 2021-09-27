Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DAAC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 10:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3877060555
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 10:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhI0Kzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 06:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbhI0Kzr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 06:55:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D917C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 03:54:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id dm26so33354289edb.12
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Z6zVOAUQhkUcy00BoV+EUlhGglYpbflx45R5JYvrqQA=;
        b=gRqlKCemG6QEuoN8PkWv4cst8//S6ichewpv+oIFUPx+V8qUdiJIwLdxfyFiOUBw/L
         qFL51QROoKtDqDH1jPY4To5eHdHeP84TJr3mmS4CtGj5G0rmfRcr6sfVg1mzk1apN46p
         CoS5jiCjBge+0EiVZO7X5VDDfvl6cpi+GRetrbPKxhY2NKIcV8KPfI+IQl11W3LLTeLn
         8dyMvato63rfL+zMG/E2fJFw0CySOSTkA+KH+D0BM0eBkjsoiEdrgfLVOgNRJ4qHIDpH
         f84dtbmcRJVLsaeqyY11oHk0Dx+X83jy3ctXaRUsYBMMg/sYvo73DEbT+//oUi1MsEM8
         RFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Z6zVOAUQhkUcy00BoV+EUlhGglYpbflx45R5JYvrqQA=;
        b=TP183GO+wG8qIRWruL8N+8w96QXJ6ynU8qbGNkmwaq9/liEoo/sxKT/UK+b9AH+DLy
         GLZeYGaz6HTbWiZ0faWaMgLqUKPKqUZwKheZPpPiInAfAAN+VAFgbSznt+kM/uay5Fnn
         +B0sXerlDxY087glY0yTxH1tdId4z+qpkJCEAjPGHk+7pi2niEExEOf/7pGv1sR8tb1t
         nP4TMFdsPSpEJYwoZnrv/oz79+l3+ybAEaZT7Rc/z/zyebrWi5dTWckx2CGveE1y6Z/g
         JkDztZ6nENHnBlV18ume/xrvqdIYAo90tvQV93BO4wZk5mr6hFvfyNlrSMMK9uZELcr/
         9YUw==
X-Gm-Message-State: AOAM530RKi+a5SJ5KSEhXyqV0GTnaLXe2WkosqTPMMMh3rP3hk+7rS7V
        puZlBdVdZTs2U/07UxXHjqY=
X-Google-Smtp-Source: ABdhPJxwGC1izPDtRU8qjifhEuMu5ajZMHhHrL0Tm5Oka6lHlDvlsR7ERqCpClyQL8OeztmFA2OWOw==
X-Received: by 2002:a05:6402:2061:: with SMTP id bd1mr22582495edb.186.1632740048040;
        Mon, 27 Sep 2021 03:54:08 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o23sm1336565edr.89.2021.09.27.03.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 03:54:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 3/6] shortlog: use designated initializer for "struct
 shortlog"
Date:   Mon, 27 Sep 2021 12:52:33 +0200
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
 <patch-3.6-c9db107fcb1-20210927T004920Z-avarab@gmail.com>
 <94842a94-d168-2b61-4a44-0059ecbe1b36@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <94842a94-d168-2b61-4a44-0059ecbe1b36@gmail.com>
Message-ID: <87lf3i1e7k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Phillip Wood wrote:

> Hi =C3=86var
>
> On 27/09/2021 01:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change code added in 64093fc06a (blame,shortlog: don't make local
>> option variables static, 2016-06-13) to use a designated initializer
>> via a typical *_INIT macro pattern.
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   builtin/shortlog.c | 2 +-
>>   shortlog.h         | 4 ++++
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
>> index 3e7ab1ca821..fa1f76cc51e 100644
>> --- a/builtin/shortlog.c
>> +++ b/builtin/shortlog.c
>> @@ -342,7 +342,7 @@ void shortlog_init(struct shortlog *log)
>>     int cmd_shortlog(int argc, const char **argv, const char
>> *prefix)
>>   {
>> -	struct shortlog log =3D { STRING_LIST_INIT_NODUP };
>> +	struct shortlog log =3D SHORTLOG_INIT;
>>   	struct rev_info rev;
>>   	int nongit =3D !startup_info->have_repository;
>>   diff --git a/shortlog.h b/shortlog.h
>> index 3f7e9aabcae..47892d6d604 100644
>> --- a/shortlog.h
>> +++ b/shortlog.h
>> @@ -28,6 +28,10 @@ struct shortlog {
>>   	FILE *file;
>>   };
>>   +#define SHORTLOG_INIT { \
>> +	.list =3D STRING_LIST_INIT_NODUP, \
>> +}
>> +
>>   void shortlog_init(struct shortlog *log);
>
> looking at this wouldn't it be better follow the pattern in the first
> patch in this series and replace shortlog_init() with a designated=20
> initializer?

I've ejected this patch from a WIP re-roll, I don't know what I was
thinking when I included it.

It's "correct", but one of those cases where we can't easily get rid of
the not-a-macro init() function, so having a *_INIT macro that doesn't
actually do the initialization for both users is just confusing.

Worse, that "nodup" is actually a like, the shortlog_init() function
sets it to "dup", that issue pre-dated by change here, but I shouldn't
have carried it forward.

Sorry!
