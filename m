Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8601D20248
	for <e@80x24.org>; Thu, 21 Mar 2019 08:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfCUIba (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 04:31:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35854 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfCUIba (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 04:31:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so1748408wml.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=p2CFt3NmrejWc8HAnBbJN8Mjv4UeItVUoUZQSObOnQQ=;
        b=ut/S8iv6ys4AB37HYkFxCkpJCSxMKaiicZUkX71n7XDf22/FZLciO4TT1mbDd5Hh5m
         YBQnpmBDt6Km0vsos4lFk6nNArHItLIZ9oXKNfW2NI9ob+OWHeP9AGzG+QYVuzwin428
         IJuzjQtflrM6S6gGp3QM+ZZIf4SIQjaDhWnduqJ3sZN2vWXSvUmt+z0/q824BOrbc/kj
         blrgEVUFbt1uYYLyiFzjcX3+gWrurw9PBJcU7khOqUiprVZ6OYAazgb4oE//V1tZNlDS
         M+++wQcqc78uahdD+ZXyyaCCHdEbHcbqp2KcH9YwQLKTZSP7q3YkJubbtWRV+umHsNNb
         mB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=p2CFt3NmrejWc8HAnBbJN8Mjv4UeItVUoUZQSObOnQQ=;
        b=ipYy5Sy0LRZViVrlk/7TEVomZf0+ts1iJaD7oInn0b04KqVNmqYPoOQMsnqISOgZJa
         M6eKeNqbfK+fblDiBzvL6UeKdDmA4Tkp+eN8hBxC1YSqEuv+ISnIYGoIVruqoN4dgzpb
         CrqtlWsYfLYHj4hlP6GLWGigCSdsUP4RzBCXGocsCkPuUVRi6BMes9exBhIw/XYVto3P
         NxKj89GIGboyapc4MSZNsrf3qXlrdw/dLvx6V3Cfpp/ixGLmDwY2KGb/i7Lxow4kKqOb
         g64ms7KQsf36DC3BLGGhbJneycaMEEhRSEdzfFYRfwYVzycyTga/YQoz0N3kn6NJLFR3
         haQg==
X-Gm-Message-State: APjAAAUDMlt6kFTfURQyiIXn3pF/d3nF1tfeDQ1aWF2V8pjuNJkW5u7J
        VY5t787EZu0xzcuRzl9sQ/0=
X-Google-Smtp-Source: APXvYqxho4m6FlMh+8gRyZLsUvr5XvnW3cWYniQsQy1IJP4qv+qpg/BAmLMlOf0IhbHyY2Lxnre/FA==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr1569155wmb.73.1553157088356;
        Thu, 21 Mar 2019 01:31:28 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 26sm5611242wmg.42.2019.03.21.01.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 01:31:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
In-Reply-To: <878sx8lpqw.fsf@javad.com> (Sergey Organov's message of "Thu, 21
        Mar 2019 09:12:55 +0300")
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
        <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>
        <871s31vjo7.fsf@javad.com>
        <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
        <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com>
        <xmqq4l7wuddk.fsf@gitster-ct.c.googlers.com>
        <87pnqklr8a.fsf@javad.com>
        <xmqqlg18srrp.fsf@gitster-ct.c.googlers.com>
        <878sx8lpqw.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 21 Mar 2019 17:31:27 +0900
Message-ID: <xmqqbm24sk68.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> The same effect can be had by just reverting "let's allow -m1 for
>> single-parent commit", can't it?  That is a far simpler solution, I
>> would say.
>
> Those one didn't introduce the issue currently at hand, as we still
> don't allow merges by default, so why do we need to rewind it?

With it reverted, "[alias] cp = cherry-pick -m1" can be used to
train the user to blindly pick a range that has a merge without
thinking, which is what I meant by "ship has already sailed".

With it reverted, a range pick of a straight single strand of pearls
would still work just fine.  And the user is forced to think and
chop a range with a merge into a set of subranges each of which is a
single strand of pearls, plus picking individual merges (if picking
these merges is really what the user wants, that is).  As ensuring
the users to think is the whole point of excercise, the original
system before we allowed "-m1" for single parent commit was after
all giving us the right balance, I guess, without having to add yet
another new option.

