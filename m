Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1830320450
	for <e@80x24.org>; Thu,  2 Nov 2017 10:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755440AbdKBKpc (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 06:45:32 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:50012 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbdKBKpc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 06:45:32 -0400
Received: by mail-pf0-f171.google.com with SMTP id i5so4289934pfe.6
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qLh7DEmfDb4hwYPwPITldq8MdluxG3vXVvIko9doxaE=;
        b=GdXdrY3HlhG8RkI7ThFRea77cAptSHX3LWSdSBTd5EXK304ZFo6FU7igVQxBR3Boi8
         duTM3Yf6C5Lqr29XupBxyEupczXKhgvgliWjx39IjVgxu8FW9fwyOEcyDg7rf+lZ7OLk
         YVFbq3EQ8/QZZrBeIyapySyF+SUm3DNk2swGDx2JvF4MqUtbpWUfQMIsoOm92Cm06OlM
         tOZ6QuF3okHC3/FXPFBI2M3LAvTDuQJxixfVj1MSzjoK3I2etAhb6+UMoQ3rUxoTPxJk
         rrC3l1x+FyjZ/Nq3XO6/yaH0Ox9OVsR+Fb68xL/nFyuaKJEv4oWnL8aoX7u47J/zZYW+
         TULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qLh7DEmfDb4hwYPwPITldq8MdluxG3vXVvIko9doxaE=;
        b=TzqdCGClR1gbnJP0mrFGFo4BQmIAI2NTwuXDt4QxCuARGawFj1pJRnpFqnoNoFTOyq
         s7R+trY0gPS5QILFVXDMp93FyrKtreqk936/xbWCK4xDSf7OZEgYBry+q1Hk7P6KeQmj
         p8rRjj3ynYq3bT5VNBZ8T9rF/i2bpa7A3nEwzxZeLbpcblB4SNnQib2M9O+wjDdqSrYo
         RcZEHAheSspOl0jrLpCJGtck4WzMonWTC7jSeiz9Tcquxmhr/eDO4mwlN8HRx9huCbv4
         GsXBwkGaCxN/55gs5l4Lightgtn4vjtwRkFJmINdxyDqjuOnKDRLdTvyvCD5B1YEnUWI
         Vpcw==
X-Gm-Message-State: AMCzsaXjNRW1r9F3txDMXXIJSLNCASjI7kuddOWyX0bZpsPUDwVbHeXg
        cMdCsPM+IRevYmEVtZr9BEdS8SDUQwoBR8ftx5s=
X-Google-Smtp-Source: ABhQp+SsbYackvC4gDlsxxjF8pr3eJ2M5azABIDwdrTp6HDw1FHhCCcWl0ctjLEVamPXFykPrPGQB5uKaWlI7fry4uM=
X-Received: by 10.98.202.74 with SMTP id n71mr3308993pfg.202.1509619531497;
 Thu, 02 Nov 2017 03:45:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.177.141 with HTTP; Thu, 2 Nov 2017 03:45:30 -0700 (PDT)
In-Reply-To: <xmqq7ev9s7bp.fsf@gitster.mtv.corp.google.com>
References: <20171101090326.8091-1-martin.agren@gmail.com> <xmqq7ev9s7bp.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 2 Nov 2017 11:45:30 +0100
Message-ID: <CAN0heSpgUBy4a6iok4MoDqJ__hZtrXvfApcxjHuS0vOBKSuShg@mail.gmail.com>
Subject: Re: [PATCH] reduce_heads: fix memory leaks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 November 2017 at 04:11, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
>> index 6dbd167d3..b1b7590c4 100644
>> --- a/builtin/merge-base.c
>> +++ b/builtin/merge-base.c
>> @@ -59,6 +59,8 @@ static int handle_independent(int count, const char **=
args)
>>               commit_list_insert(get_commit_reference(args[i]), &revs);
>>
>>       result =3D reduce_heads(revs);
>> +     free_commit_list(revs);
>> +
>>       if (!result)
>>               return 1;
>
> The post-context of this hunk continues like so:
>
>         while (result) {
>                 printf("%s\n", oid_to_hex(&result->item->object.oid));
>                 result =3D result->next;
>         }
>         return 0;
> }
>
> and we end up leaking "result".  This function is directly called from
> cmd_merge_base() and its value is returned to main(), so leaking it
> is not that a grave offence, but that excuse applies equally well to
> revs.

Good catch. I even have a patch to address the leak of `result`, except
I seem to have sorted it into another pile. For this series I just
grepped for "reduce_heads" and didn't stop to think about using UNLEAK,
nor about the leaking of `result`.

> I can see you are shooting for minimum change in this patch, but if
> we were writing this code in a codebase where reduce_heads_replace()
> is already available, I would imagine that we wouldn't use two separate
> variables, perhaps?

The way my other patch addresses the leaking of `result` is that it
rewrites the loop to avoid losing the original value of `result`, so
that it can be UNLEAK-ed at the very end. (That makes it obvious where
the leak happens, compared to adding an UNLEAK a few lines up.) If I do
`reduce_heads_replace(&revs)`, I'll need to touch the loop anyway, and
then I could probably just as well UNLEAK a little while at it.

I'll get to this within the next couple of days, then I'll see what it
looks like.

Thanks for your feedback.
