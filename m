Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925A2C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 14:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352959AbiDSOKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244266AbiDSOKX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 10:10:23 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CD5393C1
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 07:07:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r83so3760981pgr.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kha3PTdMQTe2RxUA5+E62pyTmnNVP2uj8PguLbp8fH8=;
        b=pKmygGXBNimYCg+TYer3znAislG+s2wWq6mQPw08Y8hWFdQeuWFqlOWdnqgk1jYctW
         JDaS6esXWAIMji8xqREiQlwHJYGfSytsiWi/cILDNZwd8WuZjlf2KmW1BlgPtS9bQglz
         TrnvHb4v1Fn5qjzBUNI86Es5IKLGLsD7nZHruu/B7Ods//DoS8y4I7mZQrDwHZSBYW8c
         zvHLaEcO2PXn9A8CO6vwq1X8+Um/26NgNa6wqBuBzb2dzKiFnA/6LYdRuwiyvI1cJIPR
         5XJo5MwmbTvSnTbTXLB5dqbHkrCLoq3gKT5gL3gtoqjs1Tzp7bDEUULKDwjgLnkiFi6W
         xp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kha3PTdMQTe2RxUA5+E62pyTmnNVP2uj8PguLbp8fH8=;
        b=ZPG5EljJIvxbQSzoLWvUIX2wr2Y4yz80ovBebGSf4IErw2pIXxFzxVHxJ5lWPSxA8D
         7wdK6OeDz48F2tyDshLx+KRP5o4U1Edx2Idn8QQUvn3skDHfPMKxnyPyv3fna07XjH7N
         GRmIneGYt2QEJ7b6OnvnR0VklFc+DQ46XWfOxGg+lR1S6UPC32z4KQnIoXqpOKHhQKNS
         6u7UBCudb2xnacn7ujdGX3beN01JZzX1/n9Draz01viUPuw1SCahzUK7GwqR3PFJMxl3
         2lS4CaAO0efDU5NHgDtd4cP+Dt7NhlltUoWqhXZvkbzOF1HgjMSCFZ2N7uGB5iAW5QHC
         YZZQ==
X-Gm-Message-State: AOAM530NfGOSNIlfEhTj/DsVkUP6REiR5AbZaJceMJ0BVOwpVbBSqZGZ
        8Xg9AqnJfFtBJmurOhfVtBYsKC5/pQ1sbzvMCuk=
X-Google-Smtp-Source: ABdhPJz3zA0n3cx5naIeC/L5UarMUsdevYGd8fA2lQihqrPS4jmwr8R/N58LIx9MaPDT2zD2S5do+wQq/fmRhmx6pVM=
X-Received: by 2002:aa7:8d4f:0:b0:508:229b:e82b with SMTP id
 s15-20020aa78d4f000000b00508229be82bmr17717283pfe.48.1650377259451; Tue, 19
 Apr 2022 07:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <7f2e9c1b-1d01-00af-810f-c81dd38c12ad@gmail.com>
 <bff6bdc8-83ef-7fa4-3554-edc0b7af1dfe@gmail.com> <CA+CkUQ9iujvFoGOqYHab-V9QKtnCvK+Zs1J7mzJDwQzH2-AOsQ@mail.gmail.com>
In-Reply-To: <CA+CkUQ9iujvFoGOqYHab-V9QKtnCvK+Zs1J7mzJDwQzH2-AOsQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 19 Apr 2022 16:07:27 +0200
Message-ID: <CAP8UFD0EXeZW=e2d34m5JSXpaedCs-QPc-jkuOcjxuDFFUAf+A@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal] Unify ref filters in pretty.{c,h}
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2022 at 9:42 PM Hariom verma <hariom18599@gmail.com> wrote:
>
> On Mon, Apr 18, 2022 at 11:13 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> >
> > +Cc: Christian, Hariom
> >
>
> Thanks Kaartic.

Yeah, thanks Kaartic!

> I didn=E2=80=99t get the time to read all of it. Maybe Christian can add =
some
> more pointers.

Thanks Jaydeep for this proposal, and thanks Hariom for taking a look!

I had a small vacation from Thursday evening to this morning, and now
I think it's a bit late to comment on this just before the deadline.
So I think it should be submitted as is. I will try to give it a look
after the deadline.

Best,
Christian.
