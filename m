Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40DB1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 17:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeHPUKb (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 16:10:31 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36458 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbeHPUKb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 16:10:31 -0400
Received: by mail-io0-f173.google.com with SMTP id m4-v6so4485655iop.3
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqymGBGSijdRO2dfbfnXfhx7Qzciy5lURLvLLr68JfE=;
        b=HPH1HzTUTRKwyWPcjxAkehJRK70Tltmz+4nUZ5zhm5Vy8+7oXcHhXDj3l3y0rZ1jqY
         h5wc+z2w1NMW7UwsQaWjYacJaeqosajpdmLBRkhb56X7BxgxmCtlcu9t8XLzh/v6whFg
         dMz9YUUKL4ALvxXK2zmA+qI6wRcF8uVzuNz9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqymGBGSijdRO2dfbfnXfhx7Qzciy5lURLvLLr68JfE=;
        b=QgNV8Czs0qikjRMaMgodoOt6cqoezd+7ovnADCxcsBa4jp7KGgOhzOh5iT+HWK2D7Z
         Z6m76vZtnhEMaiJVbQ8Q14UZTU26ze0D5Tpa8/RqePXZieOkeHDnoYiNU/PwRXKuJGsV
         GGVIQ4bKkkUrBaZdSOoodSwZ9UyBaz3hKezd60pKO+W4mLhTz7eaDpFTXPZPTCn/MTFX
         5I61yAr14tCjqJMJZOuAuwt+ZffQKcDkJu0MzRjXaE0nDJ8IvDUDBVDfCVOiAQW8hp0i
         gIRkq1u7mrGKSMe0BHJjNTZlfA8a3eWJ00Yo+fdvW0yxGAuFr69Du3I/tHLYzJEgBMyN
         c81g==
X-Gm-Message-State: AOUpUlGHClcOWFCd1pyUG4Ao0K/aqDryVmSArSqiB7+rT+sDljLzU832
        EF1c2jjOEvQ+F7uG3AvORc/ZmHQviTWrr/mRNhU=
X-Google-Smtp-Source: AA+uWPxZcvWDkWSmO71W4+Vf8O6H1+F6luWUG+PIWcjfstvVjoYAEocuYmzkXvIW8II4gRGJwTETfEWwkcOfu1Avf0o=
X-Received: by 2002:a6b:7a08:: with SMTP id h8-v6mr22451713iom.238.1534439447021;
 Thu, 16 Aug 2018 10:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFzsVt9CJOBPGABcvg464W1THvwYpNhO+9DWUNw4X36Ndg@mail.gmail.com>
 <87k1orqpxj.fsf@evledraar.gmail.com> <CA+55aFxjUsvhHwQGthGiLr537BGHkd-LECXVv8KzBTMMCo1bKQ@mail.gmail.com>
 <e7fb0ae0-b3e3-d7ad-7f6e-c114ee563d59@greenwoodsoftware.com>
In-Reply-To: <e7fb0ae0-b3e3-d7ad-7f6e-c114ee563d59@greenwoodsoftware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Aug 2018 10:10:35 -0700
Message-ID: <CA+55aFzutOgNbw2jeKox81-9O4+eSDntgrSAqaZrf0-28sTSUg@mail.gmail.com>
Subject: Re: "less -F" is broken
To:     Mark Nudelman <markn@greenwoodsoftware.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, bug-less@gnu.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 9:50 AM Mark Nudelman
<markn@greenwoodsoftware.com> wrote:
>
> So I'm not sure what the best solution is.  Linus's proposal to disable
> the line counting stuff if -X is set seems reasonable.  I will look into
> that and see if there are any issues with it.

One option that I didn't try to go for - because I just don't know the
less code base well enough - is to basically make the behavior of '-F'
be something like this:

 - as long as all the lines are short and well-behaved, and we haven't
seen enough lines to fill the screen, act like 'cat' and just feed
them through

 - when you fill the screen (or when you hit some other condition that
makes you go "now I won't exit" - that could be a long line, but maybe
it could also be the user giving keyboard input for a less command?)
you send the init sequence and just redraw the whole screen.

That sounds like the best of both worlds.

In fact, right now "less -F" is in my opinion a bit broken in other
ways that my patch doesn't fix.

Do this:

    (echo 1; sleep 10; echo 2) | LESS=FX less

and with my patch it will show "a" immediately. So far so good.

But let's say that that was all the user was interested in, and the
user presses 'q' to quit less. That doesn't work at all - it will wait
for that full ten seconds.

That actually happens even without -F too.

Wouldn't it be good to react to things like searches to highlight
something (and to 'quit' for the 'never mind, alteady got it' case)
even if there isn't enough data to fill the whole screen yet?

that said, ^C works, and this is not new behavior, so I'm just
throwing this out as a "maybe a different approach would fix _both_
the -F behavior _and_ the above traditional issue"?

                        Linus
