Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2DDC433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 10:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5933D60E94
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 10:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241731AbhIFKEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241464AbhIFKEz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 06:04:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F87AC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 03:03:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i6so8833145edu.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 03:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2h1TYyvsaKQ/w0yeBxsRVtYz1LaDYwbMSjeLKxuKkLY=;
        b=l/kx1ktYJJae7TFTwsgxrw8NJtcFH3xJUTCGpvqsTctp+TQcMtTtaqOFJ0gGTQE2Bq
         ItFHrm9NTpTpvQJCGhu6EzSqCFZKxApwJ5DOT1Qrj/dZQSezDztKPkWOaRzCnUiqomp5
         XXveULempg1Bt4l85C0Y2NFCOysAHr71wyQ2NpNM7UGZOUI9Kz6bKtPHL/YPKJ/Vz1IL
         gxvKw6movZ+FtlNqu4XoO4PYonOolc0mEPayTHkIFfgCu2gBFM5H9HvKb2V/yHLavPsF
         WEtB7U2wcPDhy0bKbPuj+lx6sNH7kGsV8ChcsKA7ksxtZhcZ8F6km+8SmPODqa42qJcb
         15ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2h1TYyvsaKQ/w0yeBxsRVtYz1LaDYwbMSjeLKxuKkLY=;
        b=hNfo2+OEgmqsNRKkz215STyBb76HizB2eVoU2wCgdAmbruuITh3PyxzRzMdYxUWA7g
         FrPdMm8VhAv+k3a03v2vyCUyR/6A+krLDBWQJqp3qkko/XeUkc8fauk9IiB+3P7jRURj
         aMGJTzrJKNfSp+nYrFLG3KPm4shP5xhWre9vKvdmBP386SUKe8mRJU2iQiMNfTlWFJ44
         RM1oaUDd7nO8XDsMmVUWlx9ryEq1pkNHMhBa5mPt3hvQea16mSUdsyiLRrA0fZY9gbQa
         bHP42JKFKOt8zcguW2bXnl6Tm6moYU6wPU4I4qr+RYd81uGGj49vkiCK0CU435By0yCM
         Tgvw==
X-Gm-Message-State: AOAM533U2S562atx5hfc42ZUhLzV2jpfpGrYbNjfqOxfLB6CYIEY4H6t
        SP2ltM1mOZ6jf5qr56xu+no=
X-Google-Smtp-Source: ABdhPJwoLrj/KzE0x6I6lwmOcWvFlWKm7PPaVmIuJZyAKpFAjvPClgLis/OJp4F65FoPY1wPdJ8A+w==
X-Received: by 2002:aa7:d487:: with SMTP id b7mr12240435edr.61.1630922628943;
        Mon, 06 Sep 2021 03:03:48 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s23sm4295641eds.12.2021.09.06.03.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 03:03:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
Date:   Mon, 06 Sep 2021 12:02:26 +0200
References: <xmqq35qmiofp.fsf@gitster.g>
 <CAPUEspgnRFNRoFuEvP1hpY3iKukk3OnF4zk85wkdkmiVuPuRTw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAPUEspgnRFNRoFuEvP1hpY3iKukk3OnF4zk85wkdkmiVuPuRTw@mail.gmail.com>
Message-ID: <87tuiynhq4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 06 2021, Carlo Arenas wrote:

>> * fs/ssh-signing (2021-08-29) 9 commits
>>  - ssh signing: test that gpg fails for unknown keys
>>  - ssh signing: tests for logs, tags & push certs
>>  - ssh signing: duplicate t7510 tests for commits
>>  - ssh signing: verify signatures using ssh-keygen
>>  - ssh signing: provide a textual signing_key_id
>>  - ssh signing: retrieve a default key from ssh-agent
>>  - ssh signing: add ssh key format and signing code
>>  - ssh signing: add test prereqs
>>  - ssh signing: preliminary refactoring and clean-up
>>
>>  Use ssh public crypto for object and push-cert signing.
>>
>>  Will merge to 'next'.
>
> This is causing ssh-keygen from OpenSSH 8.7 to segfault,
> would it be reasonable to hold it until they get a chance to fix that?
>
> Carlo
>
> PS. provided them with a patch, and crash is reproducible with the tests

Per my <87tuj7xhqo.fsf@evledraar.gmail.com:
    
    I'm also interested in this one. My reading of
    <9075cdd1-e34d-5dcb-f2b8-69ae4abf587b@gigacodes.de> is that the author
    plans to re-roll it sometimes around mid-September. I personally punted
    on reviewing the current version while waiting for that.

I see it's made it to 'next' already though...
