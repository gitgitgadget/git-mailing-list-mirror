Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED8C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B5464FC6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCKAKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCKAKc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:10:32 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164D1C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:10:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mm21so42401410ejb.12
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0v6CFVzP7tCcWEDwwA354gwk0bLpO9bKR90F1vasOu0=;
        b=A3/2AbIMBL55h7gwn8tSo3zfUOn/ps2YmPtx7Ak7840pqRZAEP9gNx6NalCX3nnR/x
         RSq+dl8ON+pOcG/uXYiosr6ieY6mKOYdCARQ27HDa2GtaUS2i9EuaSTVk2iqfl6inMSD
         Y6GN3bEcwvVngXufT3owvq8SIkTW/QDKLowNaBiExep7Sn0k/UopG/meMDIatJocumIl
         yHqRn0BAmW4qaSVjpGKSOGeKcg3OxzOLIUo58yRTYVEThso97G6iKhruhF9C01Yxlwhj
         nVUTtvxFRQ1l+s3BXDSKCOMwZqsTfKkRDbIIJRJc4d1GQmvCzkti/gXuoqFkvigADKho
         fhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0v6CFVzP7tCcWEDwwA354gwk0bLpO9bKR90F1vasOu0=;
        b=bKa/hMvt8cQrnY8kz95zU3Ku6ksuQ3WV+ICuG4rRAq09lZwvzidIVOgA55bQURpzz9
         czw6x4Kmu8SZic/t5HVEMXVsOZKzwuim3Pq/T2WQozg4galjMR2x2BJZ7X8khnqcdUOm
         FTj2IqbQ41JvvU0Ig/senCydL3+0lQoKTCwybRUmuyaq8RIEJISj6zed9XTu68cVCyN4
         LaRmySm2dNCOa0YZ7dKhDKxC1yOuI6BMJqqkeYmPKI4ryOU8Opz+csbA6k9rv9nl8tdI
         nSZlkYkB5zyn1eWeiW1OojjarZo6jNCubgdwvqLwXNdZdTlovuZsZ8ZD2opZA8FwN/p6
         aENg==
X-Gm-Message-State: AOAM531FydQrm8ooDURmvEReWDRbseifQ38T/bfO4ZzjBypVor5lN4yi
        8ZM5qguRqXJhNt3QmO1GoiU=
X-Google-Smtp-Source: ABdhPJwswtEjEzB+M+iOjlkDWDe4U8UaXPeMEQWqYRsvyCpLwG/VKmCcwmHLdfrKQMJ9xPTzNu4Izw==
X-Received: by 2002:a17:906:3295:: with SMTP id 21mr449849ejw.88.1615421430818;
        Wed, 10 Mar 2021 16:10:30 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id la15sm471975ejb.46.2021.03.10.16.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:10:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] t7003: test ref rewriting explicitly
References: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
 <YEj8x5fQl1fyLGNg@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YEj8x5fQl1fyLGNg@coredump.intra.peff.net>
Date:   Thu, 11 Mar 2021 01:10:29 +0100
Message-ID: <87wnueh7nu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 10 2021, Jeff King wrote:


I've read it all over, looks good to me.

> Note these all pass currently, but the latter two will fail when run
> with GIT_TEST_DEFAULT_HASH=sha256.

I don't know if anyone relies on that. Probably fine to have this as-is.

But wouldn't fixing that just be a matter of adding these tests as
test_expect_failure, and then flipping them to test_expect_success in
3/3?
