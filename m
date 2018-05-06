Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E499F200B9
	for <e@80x24.org>; Sun,  6 May 2018 05:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbeEFFWJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 01:22:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40564 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeEFFWI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 01:22:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id j5-v6so10818857wme.5
        for <git@vger.kernel.org>; Sat, 05 May 2018 22:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J8L4ajxJ1PZa1J4joOeoynShSUAa7acbBciLnjyP3Ts=;
        b=u04YunZjp7oFcHWqr4Gdm4gQMo67IRCYHGNfARyis63J5DqP66PRQZ/TI0ZdBV17Lw
         jjD0HOCTs/OOyqBpfJMH+GcdKHbPMqgdfD8Keg3gD4pSgoSeQdGYwWTZx9JpbfYc8N9p
         qcEosk9n5Ma1B/yUvqQatHv7lX4YG3fzzhtQTaDzmXzlmZ/CGuoSmJK07lj6XdnMcKD4
         M5efzQZjIHrecoVBwO+1A7q0jw8ItT7lclx6fae+62/1eiX6xDZyn6nAWHxYjjJ4QDX7
         cE9tXOxWKryP122tohocKINY140YQpMp4u+u1OimhI44RtnL2cz40mq4idJ5E3sTVKXD
         mqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J8L4ajxJ1PZa1J4joOeoynShSUAa7acbBciLnjyP3Ts=;
        b=jUdEiq/dFyhVFvV8AlaGhS9klriQxY13HdXCTN6HHunMfgbMZD3ai+oUTZW7GpJIrs
         tbY3Xg2Bzw+VQ4zYq9rWVqsdxYYgUYnYXtusmEkRi7+oMp0gwa6i6V2aHK0CbcvyS2DY
         6aNd/INyUOD6t4RM5Za1F2TLkYXCDV5hP0te9TFjU5q3OxaQreyABJk865Acp6j5edAL
         Snk5YcGmQ41fDRtK0iZBY6d8ZreVmVw89iCt87AmublE0IECcwpkYeoX/4Vbw+aX4GjO
         AcFySgtsfMK193ucPI4/VPxQnUqerX4l+nAGcL3K9GCg1o7xhWFCYYvkEHJlV0mq1pqa
         tepQ==
X-Gm-Message-State: ALQs6tDGTPgfWYaMYZQLxTY7x9qY4s/P3udsUJbnSxNaHWXBAx4FI100
        13pICGaAaAqxPTDqlhO/LBk=
X-Google-Smtp-Source: AB8JxZq9LOSwT1eZSsV0K8KRp4sBTFZ+UVYTI8c7kynclBaIYlFMpHajJ+88M50/xKtC1+LWekvDsA==
X-Received: by 10.28.220.84 with SMTP id t81mr22939868wmg.90.1525584126831;
        Sat, 05 May 2018 22:22:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 194-v6sm7236059wml.20.2018.05.05.22.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 May 2018 22:22:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/18] Add `branch-diff`, a `tbdiff` lookalike
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
        <cover.1525448066.git.johannes.schindelin@gmx.de>
Date:   Sun, 06 May 2018 14:22:05 +0900
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 4 May 2018 17:34:27 +0200")
Message-ID: <xmqqzi1dqrya.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Johannes Schindelin (17):
>   Add a function to solve least-cost assignment problems
>   Add a new builtin: branch-diff

Perhaps retitling these to

    hungarian: a function to solve least-cost assignment problems
    branch-diff: a new builtin to compare iterations of a topic

may serve as good precedents to changes other people may later make
to these files.  Especially the second one is already consistent
with the several changes that are listed below ;-)

>   branch-diff: first rudimentary implementation
>   branch-diff: improve the order of the shown commits
>   branch-diff: also show the diff between patches
>...
