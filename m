Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660A71F424
	for <e@80x24.org>; Thu, 10 May 2018 04:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbeEJE01 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 00:26:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50716 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeEJE00 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 00:26:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id t11-v6so1790464wmt.0
        for <git@vger.kernel.org>; Wed, 09 May 2018 21:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sBbp0ar117wtkthT4OHzkfaPXq6UQssZFR9MCGJQzTc=;
        b=ZxNzwBVj3CW/ZHELo2jGZsuC3voMw4Ow/XvBwRV95VhwJiH9gUHZcymdMn5GIr0E4X
         6Y5+fzn+6gJZjaAXKlMMIO4jIycir55PFVkg9pVlqKgvKP1VgZsfrVmM3j7v3KVmw2aV
         +Npkg0ppdr9uCAtBaQxk9U2LmukHy4wT6m/7zYi/XXL379ezvYUcQy8jYN95jds3BT9+
         8LliJwm1FnJ7WYuKNzoF7ndwe7lfrNVUF8ajXnNEycfoicnHb6skZUENlB3JROygoYI5
         vaQ5eYOFWAZguMVnlaygtAjy/oNWg4AD5k6jaqVqUoEPzKTSX49ZycT6jZC/JqeYmHGC
         IwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sBbp0ar117wtkthT4OHzkfaPXq6UQssZFR9MCGJQzTc=;
        b=GB+BUoeJ6qxPP1vt66rhMWYffdwlRWzi3FUJ9Pk/eim7BSlsnM8et7TIYBF0YxnJA6
         ryfvIigUMzY1AreRVN28JlVhMf5ckP6YezsWEPqDP6aMuzLixQiJeXBl+utcwP7X3LWC
         i8SMTBcjCDnpmsTSTPw7RIAnifKGpLZkfs6GT8YI6wqAde+GdVXUtS7ejNo8mzSJM5en
         QrTKS5GSYB7fWkLRSvxOclJjalzovwSNy6LrhLmpqtgdM7UXvLem8n/0H8q11I79zWcg
         fRsbt+FGPM0h2fGEyYstMbfMCif/bx08AnckWyWLSfoXgI7HsjoVsv5HX7bsFavGTz2B
         rJXA==
X-Gm-Message-State: ALKqPwd59Idj78LMPvsYKEIdqNG++qdJwIaxehZ1kBQw6CHkYzpcsm7r
        NUSoL7NvkWfAoFwut5x2EF4=
X-Google-Smtp-Source: AB8JxZpimzcdT6QYArJG+c1/VJONj+P4QJ1kADyajVDH5BABYUsNn2Y/Vckz2DsQP8ahxBkpfTkSqg==
X-Received: by 2002:a1c:7e8d:: with SMTP id z135-v6mr113101wmc.6.1525926385273;
        Wed, 09 May 2018 21:26:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a14-v6sm47466922wra.84.2018.05.09.21.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 21:26:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] lock_file: make function-local locks non-static
References: <20180506141031.30204-5-martin.agren@gmail.com>
        <CACsJy8DyRhQ0DKy8UyK+r7Kmw=0hHD=W6aXXKutk4e-wtGTdNg@mail.gmail.com>
        <CACsJy8Btuc2J4aCTymkvLYyMV5zJrdMUdtV5NDnPqXOjsTVw4w@mail.gmail.com>
        <CAN0heSpA5H7Gwwx0TEY9=iFJrgKb0SPXqKOwHK=4NxPYoGjZ7A@mail.gmail.com>
        <CACsJy8DDyrUinwXx1b66DCHB+2DLt1KBmFt_83R1+HWjbzGH2A@mail.gmail.com>
        <20180508181839.GC7210@sigill.intra.peff.net>
        <CACsJy8BDaHUs+DMOM7h6Lgbn8qB8yE4-O4iG=t85nG6sQ77zOw@mail.gmail.com>
        <CAN0heSr7mdaMRxsy-Aev3RpBf-9Xvg6Gw_=UyRqV0FPCVx0KNQ@mail.gmail.com>
Date:   Thu, 10 May 2018 13:26:24 +0900
In-Reply-To: <CAN0heSr7mdaMRxsy-Aev3RpBf-9Xvg6Gw_=UyRqV0FPCVx0KNQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 9 May 2018 19:07:36
 +0200")
Message-ID: <xmqq1sekkufj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> On 9 May 2018 at 18:19, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, May 8, 2018 at 8:18 PM, Jeff King <peff@peff.net> wrote:
>
>>> It should be totally safe. If you look at "struct lock_file", it is now
>>> simply a pointer to a tempfile allocated on the heap (in fact, I thought
>>> about getting rid of lock_file entirely, but the diff is noisy and it
>>> actually has some value as an abstraction over a pure tempfile).
>>
>> Ah.. I did miss that "everything on heap" thing. Sorry for the noise
>> Martin and thanks for clarification Jeff :)
>
> Hey, no problem. In fact, the "noise" as you call it had some signal in
> it: the commit messages should obviously say more about this.

Thanks all for working it out.
