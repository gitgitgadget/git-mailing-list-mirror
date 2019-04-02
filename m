Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9933B20248
	for <e@80x24.org>; Tue,  2 Apr 2019 10:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfDBKgM (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 06:36:12 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:50455 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDBKgM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 06:36:12 -0400
Received: by mail-it1-f171.google.com with SMTP id q14so4270774itk.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 03:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9wc1xh7M4tGZkaG6DnBoBBvaGPLVvpDByScheRa0e4=;
        b=W2xsPmExMmqjKi0rBwpicfLu9YexAiKfptVakJlwvnOe5giJA8xBoedH0uJ4drJo9p
         Rx3b4LfxsNt9vnkg6Bv1vqr7D8ia75wPa5dxRo/6seAdjeOxdYcjpUWQ0ChjglCX3v75
         /lQm7BhDhnscSsjS+dyARZuemAaq/JZJ9Ax1mkfJ2cO9g9xMVzAIo7sP7HxCKrrCON9q
         zk0aKdBVCnYCaGvT/z/2/hD3tO8WxC4/JqFueTSMT1MFxIgKb3FPV/G+r0jiMn9Tv1iH
         vYQP/EZdUoWDOIDeGh6snWccAzxOu9D4LHifDwSQsiAqnZEOGMsn53TXBWhYPw4ImH0U
         nQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9wc1xh7M4tGZkaG6DnBoBBvaGPLVvpDByScheRa0e4=;
        b=pdivaUx5orSqqYQxUsi7Cmw6WeyBu3Pgm5HZ7laKZyxRShhIKPYoyriQG5nLTj2LT0
         Q3P+lDEIwtdRCavFlta7JB0MSnhvvFuo25YMcrVH+DoHAz4Y9t2qUYQDruIzK+DOHrsR
         TugkVCo+Brc+kNfOcn6FyVaDKv5zS6AmBJUHKH9Em8P/LUjQNWkrC2EIgCOcu5oCJtWV
         ZnaMMe8+IqGs4FuFriAt2gvPUbTPmBXJAc+3SliOpwEddZVwwDb1Z1e3Syu5tPX6EzUF
         tcKkQzNvQ+U0Ek04i0cBr0bfXHhRGXCgWaNh9NEeT70+vYFVP3+KIgnXZ+CuZ3BUcbx5
         9vpg==
X-Gm-Message-State: APjAAAVQiB2Yu2g6loHBrIdqG0Y60iJijmqU+fszdTp5DoeeK5sbxYFO
        BvreuybOEXcD31gIzbI+n+CGL0RNXgA16i0vHzci6g==
X-Google-Smtp-Source: APXvYqxpcTuuIOKfFM6brJu22jsCHSQmkZA1hCnHTCCwwyaiDcjBVDI07WKdUZ7mazuRBnlTJxDKjmNPios/zjcf3t0=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr3159003itb.107.1554201370844;
 Tue, 02 Apr 2019 03:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <f0c838f0-2f75-2b05-1aeb-3db4743ce89a@iee.org> <xmqqftr2uhmg.fsf@gitster-ct.c.googlers.com>
 <8850d755-07ce-d8d2-6e5c-88393fce34de@iee.org>
In-Reply-To: <8850d755-07ce-d8d2-6e5c-88393fce34de@iee.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 2 Apr 2019 17:35:44 +0700
Message-ID: <CACsJy8Bs6uso4oL6sSz9xC5gv-xcxkNc2KRcxX=eCT5KcMjSSQ@mail.gmail.com>
Subject: Re: test suite: why does git add large_file create a pack, rather
 than an object?
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 1, 2019 at 10:10 PM Philip Oakley <philipoakley@iee.org> wrote:
>
> hi Junio,
> On 01/04/2019 11:47, Junio C Hamano wrote:
> > Philip Oakley <philipoakley@iee.org> writes:
> >
> >> At the moment I'm using an extended _test_ case that starts by adding
> >> a ~5.1Gb file and then using verify-pack, which aborts with an error.
> >>
> >>          dd if=/dev/zero of=file bs=1M count=5100 &&
> >>          git config core.compression 0 &&
> >>          git config core.looseCompression 0 &&
> >>          git add file &&
> >>          git verify-pack -s .git/objects/pack/*.pack &&
> >>          git fsck --verbose --strict --full &&
> >>          ...
> >>
> >> If however I simple execute the commands from the GfW bash, the added
> >> file is stored as a blob object, rather than a pack.
> >>
> >> I'm at a loss to understand the reason for the change in behaviour
> >> [store file as pack, vs store as object] between running the code as a
> >> test script and at the terminal. What am I missing?
> > To which test are you adding the above piece?  Perhaps one of those
> > that configures core.bigfilethreashold?
> The test script (t-large-files-on-winows.sh: [1] below) was specific to
> this debugging.
>
> I didn't set core.bigfilethreshold - Is that done (or unset) by the test
> setup at all?
>
> It does prompt me to check that all the bigfilethreshold checks are
> actually size_t, rather than a simple 'long'/uInt which would only be
> 32bits on Windows and potentially a downcast comparison, resulting in
> mistaken bigfile actions because of the modulo 2^32 action.
>
> So when I run the test script [1] on Windows I get my error from
> verify-pack, and the trash directory contains a single pack file.
> I tried doing the commands singly on a fresh repo, but that time found
> that the add/verify produced a blob object (rather than a pack with one
> object), so it got me wondering if I was testing like for like.
>
> When I tried using gdb at the add stage, with a break point, I got a
> back trace [2], and when run to completion it had the loose object, so I
> was confused. (my fixup code is at [3])

Streaming a blob directly to a pack is done by index_stream(). I
suggest you force a crashwhen that function is called (from your test
script) then examine with gdb for more info. You should be able to see
what's its caller (in case it's not index_fd), then perhaps you could
add a bunch of printtfs to show all the conditions that lead (or not
lead) to that function?

There are some would_convert_ calls in index_fd(). Maybe some other
config keys are affecting this.

PS. I also don't know what index_stream_convert_blob() does. Not sure
if it's really streaming to blob or streaming from somewhee to a
converter. You might want to check that too.
-- 
Duy
