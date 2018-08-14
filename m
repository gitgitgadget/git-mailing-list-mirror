Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51451F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeHOAFg (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 20:05:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43923 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeHOAFg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 20:05:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id j21-v6so10846359edp.10
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0SP95EVbVdzVZFiK4mX+lDBLXEJ8qnZK91BNpXcPM/I=;
        b=nUbtnOmHw7xAUBeF3kImy6URabqS7HTABDMw4ULoeBr9CIZbZBshOGByjmC6EMzPvZ
         Hxd7MlAA7ugatjxdfYVlVlevy9w8t76w711xgvKKa9Ow8RMw9YsHMOFmpDAVr1MBNXnw
         CnBTxJ1TO7XQ3ISRYUid7ITJYgaQUrBb3ZwdqmxUtWWve5G7hFEvWQcJ3U0qJNvIP+IQ
         a0yIs6hN18wNYjxo9UBs2gRKEmxrRW9prYBRLP+qakfhWGMcLwmpRtCb1IJg9queFBjd
         XfdXZCWFQQz+jqq6MAHmLXxS9Ant7xQiACAeB/FxXXH4q3WFbjGVk8CbIfAfZ7VkIqBN
         fLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0SP95EVbVdzVZFiK4mX+lDBLXEJ8qnZK91BNpXcPM/I=;
        b=s0pQD+FL5PdotPYbuq9ix8O5HZtrwqHy7xQXqgPRt1L69WdeyWM2QNLbZxfm4pzRxa
         N8PIOPoHGPAXA8iJ7tEr+knn7K7NJX174iu36IwhGgTUDxxEWI/wOUgANW74jZprcJU3
         t4f/d//XFOzO8qo+axEbr52h3YbBvu4+Q3gdXrBoKDim/HwRX40myuoFROqFkyrkZixm
         upFOzjiXbiQqEZfTg2+xCD+kTl+C+G1k45I1XbmwMjIQldqvkC43rbi4ZlLQU0croCrv
         Fm/UXNF/lAzWDI3esLFC0+jxnMlH0OcGXF28fq2+1QZkr2wyTJQFeWS3yVDK6OV6BjR9
         rY6A==
X-Gm-Message-State: AOUpUlFvKg819J2R87psq5c3XqjU2KWoRr73WarC1bseUAjRc47lGzJd
        Ir75MR5Y4bO4GadUwYTG37xqtptlhRI=
X-Google-Smtp-Source: AA+uWPxYpdf5C4dhM3KvhyarOPuhxKhv1EkFDUFBLrZEyFvTvzKNVzcICspTJbEVEpITR5ymzSUgfw==
X-Received: by 2002:aa7:c70f:: with SMTP id i15-v6mr29841350edq.231.1534281392346;
        Tue, 14 Aug 2018 14:16:32 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id f11-v6sm21430361ede.76.2018.08.14.14.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 14:16:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] submodule: add more exhaustive up-path testing
References: <20180814185906.2680-1-avarab@gmail.com>
        <CAGZ79kaK8Wt0TGvo-PyDZRLWr9PU0BRo4=DiYUXvv8c8nZ+M8A@mail.gmail.com>
        <87d0ukhd5g.fsf@evledraar.gmail.com>
        <CAGZ79kZuH8DKkoNb3AgHFxwYccOGHeVWOE7ov5QvavtomSxyAQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 27.0.50; mu4e 1.1.0
In-reply-to: <CAGZ79kZuH8DKkoNb3AgHFxwYccOGHeVWOE7ov5QvavtomSxyAQ@mail.gmail.com>
Date:   Tue, 14 Aug 2018 23:16:30 +0200
Message-ID: <87bma4hcnl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 14 2018, Stefan Beller wrote:

> On Tue, Aug 14, 2018 at 2:05 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> > So ideally we'd also error out as soon as the host name is touched?
>>
>> Do we have some utility function that'll take whatever we have in
>> remote.<name>.url and spew out the username / host / path? We must,
>> since the clone protocol needs it, but I haven't found it.
>
> Nope. Welcome to the wonderful world of submodules.
> As submodules are in the transition state towards "in C",
> we could do some refactorings that would allow for easy access to
> these properties, but the transition is done via faithful conversion from
> shell to C, which did not have these functions either, but could just
> do some string hackery. And that is how we ended up with this
> function in the first place.

The remote/clone machinery is in C and so is the resolve-relative-url
helper. What's the missing bridge here?

Maybe we don't have that function yet, but we can presumably expose it,
and this seems unrelated to some other bits of submodules being in
shellscript.

No?
