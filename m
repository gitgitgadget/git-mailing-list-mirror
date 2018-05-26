Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A621F42D
	for <e@80x24.org>; Sat, 26 May 2018 23:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032477AbeEZX52 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 19:57:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35415 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032434AbeEZX51 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 19:57:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id o78-v6so23399220wmg.0
        for <git@vger.kernel.org>; Sat, 26 May 2018 16:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z1pJZX+HN+vzjtve5CH0gat+yR9pAVrLoKQ3DuHwm5U=;
        b=DSGMPIAmh7U9IBNtf+2SX8lTrk3cga+0S12GSegwqVPSzMcdhNyVvyoNWBgX/qBQ+h
         ZldXOdVr3R+8i+xg87U+O1JgjqSdxfU/fyS8B7MknliaeUfV3PI/iMtRd+9zSJ66NwXt
         UPtVFpOJSrWl7snpYuAjSwap3LemKLuGRa9r//gBuMAU++M9geaGWGb8pjGmjarNrQNL
         POIk3f+j0VL1hY3G5dL3nIDbGVxrSKT92n8zo3vIURqr7cpBwbKSM4CDghTnprGQa91e
         02NJ7zTTewtgUnyhWibpDSqmPUJ1gEkYzA7aB2ErQrwLXD2FR3cuFWc+vN0qjzIxOuJX
         AESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z1pJZX+HN+vzjtve5CH0gat+yR9pAVrLoKQ3DuHwm5U=;
        b=cSuv/hZXYvhXs9+iu8Ajdav/q/pnO0GCeIqf2FoTbR869CL3E0/+5Km16Jv5fj7ei4
         Nn/7JDViU2Uh7QPhPnv+CQwiTViyrVuVDx9LjVV6IHNZle/IlLVPCTbAUhCv03ACc6Ih
         kIcfXHvyNDb4bKGtpdJ5iIImz34IRcHsPreEMFjT1MU4G9rMHdZ8hS9LCPIkaCXDoGo1
         m9Y6x/00cWQE84eIxbbprHjqBYkyaHV3RlQRek2EiNNMUJ1Vt2LJMwB6xPXVm4oWZS/R
         ojH72FKnn96O90OjuKYiOrRv9LU5+iTe0+id31lrnOoNoEjxxIjCsKK2ITYprOxRKfnz
         dDXg==
X-Gm-Message-State: ALKqPwecRf9AmzuKgPHegiZf0V/ulZgsMqRbRDKq9PReJ1s5yipPqPkr
        9s7hiAlBHZXVAb1DWYm/4AU=
X-Google-Smtp-Source: ADUXVKKN6tslBBch56wKETcAhlcvf7vyS41M+frfXSlKBCW2hh68lBvSGvwY5LrQRxXkw/9eWJWQcQ==
X-Received: by 2002:a1c:d106:: with SMTP id i6-v6mr678858wmg.1.1527379045602;
        Sat, 26 May 2018 16:57:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x130-v6sm14383921wme.24.2018.05.26.16.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 May 2018 16:57:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeremy Linton <lintonrjeremy@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] packfile: Correct zlib buffer handling
References: <20180525225601.22575-1-lintonrjeremy@gmail.com>
        <CACsJy8C4zNZAe6Vw-mz8r8HueYdQKs4ZhMOQYX0v7ypfHdmShg@mail.gmail.com>
Date:   Sun, 27 May 2018 08:57:24 +0900
In-Reply-To: <CACsJy8C4zNZAe6Vw-mz8r8HueYdQKs4ZhMOQYX0v7ypfHdmShg@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 26 May 2018 07:51:55 +0200")
Message-ID: <xmqq8t86m0m3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, May 26, 2018 at 12:56 AM, Jeremy Linton <lintonrjeremy@gmail.com> wrote:
>> @@ -1416,7 +1416,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
>>                 return NULL;
>>         memset(&stream, 0, sizeof(stream));
>>         stream.next_out = buffer;
>> -       stream.avail_out = size + 1;
>> +       stream.avail_out = size;
>
> You may want to include in your commit message a reference to
> 39eea7bdd9 (Fix incorrect error check while reading deflated pack data
> - 2009-10-21) which adds this plus one with a fascinating story
> behind.

A bit puzzled---are you saying that this recent patch breaks the old
fix and must be done in some other way?
