Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88876208E9
	for <e@80x24.org>; Mon, 30 Jul 2018 09:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeG3LNa (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 07:13:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52160 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeG3LNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 07:13:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so12393156wma.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=YXFZDRXDnwd/3506WPTApskhO7wf4hJRtltyLosrui8=;
        b=sAR6nY8crUdhhL6RTCkoFjYDPr7ADqoitBC2lrq0Bo9SH5j8Ym6biEQxTvUxEmn1h8
         VvOHweq9ey/2n5TJiTlkWKU6H4LSq36PoWs/hjsigD+7FbgViEX6s/Re795mGS4oBAWX
         YZvQdh+p2i08PzUAbtnwzjCmNF/SnUORBDjiBw1pO/VEhOmGZHRhEoL6Q3J3jEgCwrc4
         K7jq+Em4grPo7fkRTYiKtGhiwLmAgoSrMutkxJPjajzn1ZJnCkAqe0lSJHze0OH0CNfg
         h+Ou6086iMoma/IVvIFNbR2JjgBh/cX4lKf1mxMzazrn+3cOR04wfa3GIiwYgP6NWbdO
         2a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=YXFZDRXDnwd/3506WPTApskhO7wf4hJRtltyLosrui8=;
        b=P8VL0XhwSJqFGNm3iyaUemTUcaU2d1QRT75RgWO+wdnpGWuxjIY3ftvIvJHIa8VF5D
         1jlUxCHUgXNrphYddSpsVq617tgKFYnqO+fdSRM77TXpxtkTr6k+4RGnwsInJpZvnsCY
         ZtBOTPY4Qgk5QdkifkQQM03yWfKCgrtZIziLrHQmV1xeov8vX0r7HjGr+e+CPfCJu2IQ
         MOpvbeRrEDPEiast8hgORNBEOR6aBCZ0+XSp2A1OFJYtUKJCOnSD7TKy8K8i2zbT0cOx
         XnDa3xudYqTaGp1CQ9UOZjJuX+clTWkqGqivV7cLKr7/HksODVBb3s4E93aS+kSiI5qJ
         DgUA==
X-Gm-Message-State: AOUpUlGGj+oSYV6LbXN3acCysotO7zxOWsICj0tf+2CGouN5ukh3qwWS
        72btzQuwXM40seXT6KHyCuY=
X-Google-Smtp-Source: AAOMgpf0yQh9XhUSITsl4D4K+ylDgGHiLw3qI2qRYVKVpCJ8cjh3d8EHhQ9WDC6Alk0VQpcKwtxK1w==
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr15489009wma.41.1532943559886;
        Mon, 30 Jul 2018 02:39:19 -0700 (PDT)
Received: from evledraar ([5.57.20.50])
        by smtp.gmail.com with ESMTPSA id m2-v6sm10286150wrw.76.2018.07.30.02.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 02:39:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael <aixtools@felt.demon.nl>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Dan Shumow <shumow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Is detecting endianness at compile-time unworkable?
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
        <20180729181006.GC945730@genre.crustytoothpaste.net>
        <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
        <20180729192753.GD945730@genre.crustytoothpaste.net>
        <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
        <20180729200623.GF945730@genre.crustytoothpaste.net>
        <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
Date:   Mon, 30 Jul 2018 11:39:18 +0200
Message-ID: <87wotdt649.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 29 2018, Michael wrote:

> On 29/07/2018 22:06, brian m. carlson wrote:
>> On Sun, Jul 29, 2018 at 09:48:43PM +0200, Michael wrote:
>>> On 29/07/2018 21:27, brian m. carlson wrote:
>>>> Well, that explains it.  I would recommend submitting a patch to
>>>> https://github.com/cr-marcstevens/sha1collisiondetection, and the we can
>>>> pull in the updated submodule with that fix.
>>> Not sure I am smart enough to do that. I'll have to download, build, and see
>>> what it says.
>> The issue is that somewhere in lib/sha1.c, you need to cause
>> SHA1DC_BIGENDIAN to be set.  That means you need to figure out what
>> compiler macro might indicate that.
> I remember - roughly - a few decades back - having an assignment to
> write code to determine endianness. PDP and VAC were different iirc,
> and many other micro-processors besides the 8088/8086/z85/68k/etc..
>
> If you are looking for a compiler macro as a way to determine this -
> maybe you have one for gcc, but not for xlc. I do not know it - currently :)

I'm not familiar with AIX, but from searching around I found this
porting manual from IBM:
http://www.redbooks.ibm.com/redbooks/pdfs/sg246034.pdf

There they suggest either defining your own macros, or testing the
memory layout at runtime (see section "2.2.2.3 Technique 3: Testing
memory layout" and surrounding sections).

Perhaps it's worth taking a step back here and thinking about whether
this whole thing is unworkable. It was hard enough to get this to work
on the combination of Linux, *BSD and Solaris, but I suspect we'll run
into increasingly obscure platforms where this is hard or impossible
(AIX, HP/UX etc.)

The reason we're in this hole is because we use this
sha1collisiondetection library to do SHA-1, and the reason we have
issues with it specifically (not OpenSSL et al) is because its only
method of detecting endianness is at compile time.

This didn't use to be the case, it was changed in this commit:
https://github.com/cr-marcstevens/sha1collisiondetection/commit/d597672

Dan Shumow: Since the commit message doesn't say why, can you elaborate
a bit on why this was done, i.e. is determining this at runtime harmful
for performance? If not, perhaps it would be best to bring this back, at
least as an option.

And, as an aside, the reason we can't easily make it better ourselves is
because the build process for git.git doesn't have a facility to run
code to detect this type of stuff (the configure script is always
optional). So we can't just run this test ourselves.

Junio: I've barked up that particular tree before in
https://public-inbox.org/git/87a7x3kmh5.fsf@evledraar.gmail.com/ and I
won't bore you all by repeating myself, except to say that this is yet
another case where I wish we had a hard dependency on some way of doing
checks via compiled code in our build system.
