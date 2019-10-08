Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7571F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 12:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfJHMdz (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 08:33:55 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43205 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfJHMdz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 08:33:55 -0400
Received: by mail-vs1-f67.google.com with SMTP id b1so11141386vsr.10
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 05:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63JMRja7mOIhdrVBZgXiq+i5ZEEuK3jiU1NofEMA54c=;
        b=kxbglVPJ4xilYWuHnGxruaBLMtByTBfPAjWDrRb3iNlyHOle3Rqrg+UvWnW1rcMshG
         uFAaSHvk30U6dBJBkn5SLbLY+kezABsLLhtCthbDLArQ2j7ES+leRL5HQKNVZWCQ9ReH
         Z0+Fs3JToGBrUVxNuACUksdMa1mDLOh6GxoHOtkO3Gq5n3Zkfd8YV6EG9Ycxyq6QxShp
         geZFGUT6PcGYAPvKktBj22T0UnGyyJJARVWjAUjFS2jb8pxnNv0zA3TwBW3uH91XPjjU
         9qGk3Xf0yuFN57hAOJAQpcQrHBxndQwm4/tStUfprad+nUJyNn1YsJYrv9M6hTbO5qMj
         1P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63JMRja7mOIhdrVBZgXiq+i5ZEEuK3jiU1NofEMA54c=;
        b=fE5d3R3kGKFj/AeHSS93L3vF8muMiGA3hd2VDJlsIBpUWC4GgsXd37+cBoT9aTd0Re
         39W6b85c2qXyIw7SL4za5kq2dkelpbmlW0VLsQRvu6vPqx4D9qwDcBW/+BLIOFzCKZDo
         ZxWKGILvAKujYN/gk8XPBbGHCJt3Pk9bfwy66CQXUJiK/JdTXnZp7YU2H+URmD0NVEtt
         +KTw0Y40OalJLbplbFKsTWtZjqqJWk5A0uHo5JNLCi8eTrXZMZg46sKje6cuxI12mWPK
         iYnYtT+Ona1TJuuHGSKYK4qKy9eMBJdIFfC92ZGtRYBs3foqpRot3vNSoG66kQW5teBA
         n8xg==
X-Gm-Message-State: APjAAAV2D72dzrkO7RnBX5Via4SFn2pELSnlxCX9/o9gBoHyzAZ+vswy
        WGpWhaR4KXsLQMr2VBaLlICWEk3b4WswhNft8Yo=
X-Google-Smtp-Source: APXvYqzf8jWtorBXm/1txcOa7eOLdADAurdzu56eFeI0UJ3/kB/1yBCtQfCGvZHOqMNmHiU7NB2aYB1m2vjNPfSX9wA=
X-Received: by 2002:a67:dc16:: with SMTP id x22mr17454598vsj.85.1570538034239;
 Tue, 08 Oct 2019 05:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
 <20191005211209.18237-8-sandals@crustytoothpaste.net> <4733b8a0-bfd9-a49a-01d2-1c9f2a48cdf8@gmail.com>
In-Reply-To: <4733b8a0-bfd9-a49a-01d2-1c9f2a48cdf8@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 8 Oct 2019 14:33:43 +0200
Message-ID: <CAKPyHN3NaBv5s9aefb8fTDeGto2tLyTa0DxTjbWO9pGRY22pPQ@mail.gmail.com>
Subject: Re: [PATCH 07/15] t4011: abstract away SHA-1-specific constants
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 8, 2019 at 2:21 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/5/2019 5:12 PM, brian m. carlson wrote:
> > Adjust the test so that it computes variables for object IDs instead of
> > using hard-coded hashes.
>
> [snip]
>
> > @@ -137,14 +141,17 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
> >  '
> >
> >  test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
> > -     cat >expect <<-\EOF &&
> > +     file=$(git rev-parse --short $(git hash-object file.bin)) &&
> > +     link=$(git rev-parse --short \
> > +             $(printf file.bin | git hash-object --stdin)) &&
>
> Why this change from $(git hash-object file.bin) to
> $(printf file.bin | git hash-object --stdin)?

thats two different things. The first hashes the content of file
"file.bin". The second hashes the literal string "file.bin". To avoid
this confusion, may I suggest to use 'printf "%s" "file.bin"', so that
it is clear, that the literal string is meant in this context?

Bert

>
> For that matter, why are you using the "printf|git hash-object"
> pattern throughout your change? Seems like an unnecessary hurdle
> to me.
>
> -Stolee
