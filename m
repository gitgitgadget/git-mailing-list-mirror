Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77644C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242627AbiFJCHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiFJCHG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:07:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155DC10A621
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:07:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n28so33424467edb.9
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ET7RZODVyr/aQ6UCzm+pVa9tEAQRU7jthG7A7fRc8JE=;
        b=W8ITEBp2kJAfyHnkvzJ16rlVLj2og2JwXfMpI5OKmnkPM3y9cJanmtdgWzlw233aRE
         reA1CgfSAv2+bsojtwDm3sIpxu57KUkIy3T01I2ZWiX2DG4UScEDScRTHzSGxdTH0Hkr
         Ckwx6Z2wyJTyUD9qRW+sPX1FP83IVG2qyH5D9bNSi+eRVtZY8V4mTPtYEzrZwhHXq98U
         pkAYn1U+5VAd3GQ7dLliJq9p1yLbYDzJDX/tCtSvlDf19iuoRQmZBk2xB37x+Zawfk0H
         /FMLlrVoVtOQTw49f8JMUihBjLCWBX7PP/brX4l7mRMRyOUcbaBI+ZgRdhuLEn8DNjK4
         D2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ET7RZODVyr/aQ6UCzm+pVa9tEAQRU7jthG7A7fRc8JE=;
        b=dfT7FGLjrIeB4J5ovKjgwZ0YQj8DxebmpWkhze4kM3z3aGqwxV/1sQhjf+U0FLdwL3
         b+XSMf8DHQJ6Zo8rKmgcMDmENbpwR+cc9qjr1tP56LBX3W4V5vmyZA5Ltm3u77DzC6bn
         O84xM85eUKXQLzD5YLPBSJeQTy+vLDgAOdvOqpG73eQIzgBoHruaG2/E5a7z9HBIgFh0
         zTgTITyyqDZF079Lxq1/fGLOab1PwcuIgpj5u9KDGSaOLyd4OMmQv7zjQ3W0fxU9pQNX
         Q+jWk0yChR9zX1JS6BnC+goOeIky6wEc7cBDA/8DxhTHf3YRPt5zhQ0usSYZpPqErJ4C
         trOw==
X-Gm-Message-State: AOAM5314INmPYckOn7oYeklKaNdx23/XQ9/fUDQ2cik0XdRpa2vULvQl
        zHWiGeU1DEU9q9FDTWFNwmg=
X-Google-Smtp-Source: ABdhPJz5DTCeaNbMW7zTfBwYoyETHG8MNPxGsy/T7Mhd6+lpX9bZ7HTCKSqFrfzl1H8Dy+8XvLhsng==
X-Received: by 2002:a05:6402:40c6:b0:42f:9ff8:62f8 with SMTP id z6-20020a05640240c600b0042f9ff862f8mr37946697edb.95.1654826823536;
        Thu, 09 Jun 2022 19:07:03 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906071800b006feed200464sm11536438ejb.131.2022.06.09.19.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:07:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nzU3C-0037qV-3b;
        Fri, 10 Jun 2022 04:07:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v13 1/7] unpack-objects: low memory footprint for
 get_data() in dry_run mode
Date:   Fri, 10 Jun 2022 04:05:39 +0200
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
 <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
 <patch-v13-1.7-12873fc9915-20220604T095113Z-avarab@gmail.com>
 <xmqqpmjl7i7y.fsf@gitster.g>
 <CAO0brD2s-i2Bp7r2n+TRLs2LckzM-i1-293rr=sgmC2TbLozow@mail.gmail.com>
 <xmqqa6allmjl.fsf@gitster.g>
 <CAO0brD3tU+v_5dS9En_fTpEyYVmgEMVb7iVGsPk6iuYNGdpYBg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAO0brD3tU+v_5dS9En_fTpEyYVmgEMVb7iVGsPk6iuYNGdpYBg@mail.gmail.com>
Message-ID: <220610.86mtels249.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 10 2022, Han Xin wrote:

> On Fri, Jun 10, 2022 at 2:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Han Xin <chiyutianyi@gmail.com> writes:
>>
>> >> I am not sure if this is not loosening the error checking in the
>> >> dry-run case, though.  In the original code, we set the avail_out
>> >> to the total expected size so
>> >>
>> >>  (1) if the caller gives too small a size, git_inflate() would stop
>> >>      at stream.total_out with ret that is not STREAM_END nor OK,
>> >>      bypassing the "break", and we catch the error.
>> >>
>> >>  (2) if the caller gives too large a size, git_inflate() would stop
>> >>      at the true size of inflated zstream, with STREAM_END and would
>> >>      not hit this "break", and we catch the error.
>> >>
>> >> With the new code, since we keep refreshing avail_out (see below),
>> >> git_inflate() does not even learn how many bytes we are _expecting_
>> >> to see.  Is the error checking in the loop, with the updated code,
>> >> catch the mismatch between expected and actual size (plausibly
>> >> caused by a corrupted zstream) the same way as we do in the
>> >> non dry-run code path?
>> >>
>> >
>> > Unlike the original implementation, if we get a corrupted zstream, we
>> > won't break at Z_BUFFER_ERROR, maybe until we've read all the
>> > input. I think it can still catch the mismatch between expected and
>> > actual size when "fill(1)" gets an EOF, if it's not too late.
>>
>> That is only one half of the two possible failure cases, i.e. input
>> is shorter than the expected size.  If the caller specified size is
>> smaller than what the stream inflates to, I do not see the new code
>> to be limiting the .avail_out near the end of the iteration, which
>> would be necessary to catch such an error, even if we are not
>> interested in using the inflated contents, no?
>>
>
> Yes, you are right.
>
> Instead of always using a fixed "bufsize" even if there is not enough
> expected output remaining, we can get a more accurate one by comparing
> "total_out" to "size", so we can catch problems early by getting
> Z_BUFFER_ERROR.
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 64abba8dba..5d59144883 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -139,7 +139,8 @@ static void *get_data(unsigned long size)
>                 if (dry_run) {
>                         /* reuse the buffer in dry_run mode */
>                         stream.next_out = buf;
> -                       stream.avail_out = bufsize;
> +                       stream.avail_out = bufsize > size - stream.total_out ?
> +                               size - stream.total_out : bufsize;
>                 }
>         }
>         git_inflate_end(&stream);
>
> Thanks
> -Han Xin

Han, do you want to pick this up again for a v14? It looks like you're
very on top of it already, and I re-sent your patches because I saw that
your
https://lore.kernel.org/git/cover.1653015534.git.chiyutianyi@gmail.com/
wasn't picked up in the interim & you hadn't been active on-list
otherwise.

But it looks like there's some interest now, and that you have more time
to test & follow-up on this topic than I do at the moment, so if you
wanted to do the work of properly rebasing ot in tho recent fsync
changes that would be great. Thanks.
