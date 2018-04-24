Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100621F42D
	for <e@80x24.org>; Tue, 24 Apr 2018 22:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeDXWTJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 18:19:09 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:35268 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDXWTI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 18:19:08 -0400
Received: by mail-yb0-f181.google.com with SMTP id i69-v6so5173007ybg.2
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+z4yAPF89mEhFuhI36fgVcoA1GJqfxu98ILBfcWgW5o=;
        b=snlpVPWQGtAwpXs5BjhFuKR6NrthRGfB5hYKkZdCXmSqUQzhuLLtLTFxsETVKOz2Sk
         9FqSHypYJZ5W7DIsDeinMftLidBBui61dnLTMAYn5XgEx4syDqD4xeYdCQZA3kjRduJB
         Y9BSYCZ0RkBdK2VnpWv0DVPKA2OkTciHqydauhFkjrdW8mo9eJeX840ctZNV45T0Pc2U
         DZdx1b0zx5oyIm/SnxZJxGcsAQEUiD6yqYkSKHP7sk8u0iTkuSHTof2f0LD21SwtUirC
         3yhxC2Yt0+wVLUkx4BnvvMP9JrVWCaz5ldaJk7NBvURevPUmXiuIZURO5MqBGuowptqc
         ee7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+z4yAPF89mEhFuhI36fgVcoA1GJqfxu98ILBfcWgW5o=;
        b=YmqIpWQc/KJV7CRgnFLNSu4WioJeOfwLH+MiTNq/3cqvNIxCNVS9nZiV4vfpDvrwHN
         FGrm1yd4ExY3oHQEtCThLtg6xpO8VwBWC7GA0zp2/8WYgljvCE7Vx64absLVHICa4riZ
         xVsyGe96q8kwGtkSyZNAeK5akngVm6l6pxzwZcEydNvM+oVgXNdKiew6Qq0hPb168rCW
         +9vSX1DU8uq0hXLuoMTqhFnVKSu2g1l0/67T8PLuvbWTV/zp7JhZTD/WOk8qPyoexB7r
         Q95RVCLMsJ+egLN4aNglCJ8HSzjzCunxjKkGZTYLBTnsi5DT+3LFet3axxgdTxx7o2kk
         B6UQ==
X-Gm-Message-State: ALQs6tBw5o7CxiYQmyUnW3hqW00/hyj7tp+aRZGY/rM4qM+JcVnz6Khq
        Z3eiKfIeeG4CVG0CTO4357D1AY8WEnfMX0fNEOqK/g==
X-Google-Smtp-Source: AIpwx48XxrrrVLHJYxfdGXKX1/ooINk40VZ1DwikJPfCTzKNTkhVFhg4i68nbyC6EqRQ6QTx3h+p+8hPMm5SG4Lv7N8=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr14495223ybn.167.1524608347835;
 Tue, 24 Apr 2018 15:19:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 24 Apr 2018 15:19:07
 -0700 (PDT)
In-Reply-To: <20180424150036.8e7ca862525bedb91673ae46@google.com>
References: <20180424210330.87861-1-sbeller@google.com> <20180424210330.87861-7-sbeller@google.com>
 <20180424150036.8e7ca862525bedb91673ae46@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Apr 2018 15:19:07 -0700
Message-ID: <CAGZ79kYPd4KF7H8CiaztouF513gw=nwRuqwGDDKjvBk362e9uw@mail.gmail.com>
Subject: Re: [PATCH 6/7] diff.c: decouple white space treatment from move
 detection algorithm
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, Apr 24, 2018 at 3:00 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue, 24 Apr 2018 14:03:29 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> As we change the default, we'll adjust the tests.
>
> This statement is probably better written as:
>
>   In some existing tests, options like --ignore-space-at-eol were used
>   to control the color of the output. They have been updated to use
>   options like --color-moved-ignore-space-at-eol instead.

I'll adjust that statement; thanks for helping me out with good commit
messages (even the "As we change the defaults, .." was proposed by
you in a previous round)

>
>> +     unsigned flags = diffopt->color_moved_ws_handling
>> +                      & XDF_WHITESPACE_FLAGS;
>
> No need for "& XDF_WHITESPACE_FLAGS".

This is in anticipation of the next commit, when
color_moved_ws_handling takes more flags.
I can move that over to the last commit.

>
>> +     unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
>
> Same here.

Maybe I'll just state in the commit message why we keep the masking
here.

>
>> @@ -214,6 +214,7 @@ struct diff_options {
>>       } color_moved;
>>       #define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
>>       #define COLOR_MOVED_MIN_ALNUM_COUNT 20
>> +     int color_moved_ws_handling;
>>  };
>
> Should the "int" be "unsigned"?

yes.

> I noticed that the flag-like xdl_opts is
> signed, but I think it's better for flags to be unsigned.

I can change those, too.

> Also, document
> what this stores.

ok, will document.

> (And also, I would limit the bits.)

Not sure I follow. you want to make it e.g.

  unsigned color_moved_ws_handling : 6;

?

Oh, that would actually work, as XDF_WHITESPACE_FLAGS
are in second to fifth bits.

But then we need to document why the XDF_WHITESPACE
need to be at these low positions.

>> +     q_to_tab <<-\EOF >text.txt &&
>> +             Qa long line to exceed per-line minimum
>> +             Qanother long line to exceed per-line minimum
>> +             new file

>
> I know I suggested "per-line minimum", but I don't think there is one -
> I think we only have a per-block minimum. Maybe delete "per-line" in
> each of the lines.

yeah, I guess this heuristic could also make for another setting, though
as of now I did not desire any other heuristic than you originally came up
with. Will reword the text. Thanks!

Thanks,
Stefan
