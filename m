Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEFCB1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 15:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeIDUXW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 16:23:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52084 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeIDUXW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 16:23:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so5011514wma.1
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2lXy1c2AxOV540k9ghQX8dN96SwP8CmmIaQTJAUswDw=;
        b=DkWTcdn4arS9XJPqSbS0KHVSc0gQRsfsWR96Ob9IE7LorVZA4b7nt2/SUOfMtHgg0P
         +3xdWG/h/0UZFwId+dvus+18T+sAWATJdY2v3RmiS9kDG58Scl3kzcpsDlTSBpgh7/1l
         LjuKI0qv6Wi17CUi5Uod0BFAhY8GxYENhY2sIx0ePtldZTZDzI80ACvowcvw5lH9/L0N
         C4JLVdw3gVd+fW/eEkBz9O3g/5A0k1ajyVgG2sOfjMZvNgwZLyXckycqKRz4p4Y1FGSW
         hJkJI4PJ/rRAqhuzos2ZTNZRUxh1w3IWQ9loaWtVEd8ALJQV4ASAN/OVRmR02nYl9XIU
         7emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2lXy1c2AxOV540k9ghQX8dN96SwP8CmmIaQTJAUswDw=;
        b=UBPgQBtOhnxcNaf/Uy9KC4++aBJ+uvVlNfovhYtPKLM7mFqQKilFuNp9zYVOYpoQYn
         v6U+b4cT0mDvsLMt9XxZ5WZiNWM2KPrNBuRQrDUV9nZcKgzkgabOOlW0z91aFrFkYHE6
         0V5YDrwrihmebEfm7ekwCeE3tqrhLVTMNJsN2FUzLNtAkWHdPliSBunUEs1srBKLT2/a
         eDiBgM9vsC2H6V30YSg/A0C2BcjGthp17DHGgEHlKGAtK4qu8hHK9g39T9IwgHM8LKCh
         LG/IbDAgH9fYcLrNbPKSRPg9A+lXbaABi8gd/COr2s2u7Htww4eN/ud/9G30j9gV5CdV
         jLMA==
X-Gm-Message-State: APzg51Cgw+eaOgYaTkjaDhroUAFPIrWvInO9pxQmZ/TIXG1BgySfJx3O
        cTwTFzY8xzZacjPIarzimAk=
X-Google-Smtp-Source: ANB0VdYHHeFfo5c58/z71iYv6bRJc0uExr5oVHLaMp7hVD0FLCSp+SIqNIrCFyTqg8EpXkOFD2OnBQ==
X-Received: by 2002:a1c:448b:: with SMTP id r133-v6mr2816711wma.128.1536076657114;
        Tue, 04 Sep 2018 08:57:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k63-v6sm18059017wmd.46.2018.09.04.08.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 08:57:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [BUG] index corruption with git commit -p
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
        <87tvn8c166.fsf@evledraar.gmail.com>
        <20180902050803.GA21324@sigill.intra.peff.net>
        <20180902071204.GA2868@duynguyen.home>
        <20180902072408.GA18787@sigill.intra.peff.net>
Date:   Tue, 04 Sep 2018 08:57:35 -0700
In-Reply-To: <20180902072408.GA18787@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 2 Sep 2018 03:24:09 -0400")
Message-ID: <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 2be7bdb331..60f30b3780 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -432,6 +432,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>>  		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
>>  			if (reopen_lock_file(&index_lock) < 0)
>>  				die(_("unable to write index file"));
>> +			ftruncate(index_lock.tempfile->fd, 0);
>>  			if (write_locked_index(&the_index, &index_lock, 0))
>>  				die(_("unable to update temporary index"));
>>  		} else
>
> Doh, of course. I even thought about this issue and dug all the way into
> reopen_lock_file(), but for some reason temporarily forgot that O_WRONLY
> does not imply O_TRUNC.
>
> Arguably this should be the default for reopen_lockfile(), as getting a
> write pointer into an existing file is not ever going to be useful for
> the way Git uses lockfiles. Opening with O_APPEND could conceivably be
> useful, but it's pretty unlikely (and certainly not helpful here, and
> this is the only caller). Alternatively, the function should just take
> open(2) flags.
>
> At any rate, I think this perfectly explains the behavior we're seeing.

Thanks all for digging this down (I am a bit jealous to see that I
seem to have missed all this fun over the weekend X-<).
