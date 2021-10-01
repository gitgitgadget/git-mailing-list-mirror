Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E99C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 23:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5590C61A7A
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 23:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhJAXSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 19:18:52 -0400
Received: from [50.213.99.139] ([50.213.99.139]:61762 "EHLO eddie.starwolf.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhJAXSv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 19:18:51 -0400
Received: by eddie.starwolf.com (Postfix, from userid 118)
        id 9EFEA55B0; Fri,  1 Oct 2021 16:17:06 -0700 (PDT)
Received: from [172.21.12.13] (topaz.middle-earth.starwolf.com [172.21.12.13])
        by eddie.starwolf.com (Postfix) with ESMTP id 8C0FC55B0;
        Fri,  1 Oct 2021 16:17:04 -0700 (PDT)
Subject: Re: ANSI sequences produced on non-ANSI terminal
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20210923052122.2F655CE@eddie.starwolf.com>
 <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <592a799b-0d16-1615-4737-3c634d029d7f@starwolf.com>
 <YU64WQOg/zY7P+Gh@coredump.intra.peff.net>
From:   Greywolf <greywolf@starwolf.com>
Message-ID: <c6c853d8-990a-2085-5e91-ced12536c125@starwolf.com>
Date:   Fri, 1 Oct 2021 16:17:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YU64WQOg/zY7P+Gh@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/24/2021 22:49, Jeff King wrote:

> OK, that makes things a bit easier. The colors, as you noticed, can be 
> disabled by config. The other thing you're seeing is ANSI ESC[K, which is 
> used to clear to the end of line. We use this in a couple places, notably 
> when relaying progress lines from the server (with the "remote:" prefix) 
> which may use carriage-returns to overwrite lines.

Those would be some of the culprits.  I'll have to do a 'script' and see what
it is spitting out.

> Anyway, there's no config option to disable that. However, we do disable
> it if TERM is empty or set to "dumb" (and instead just write some extra
> spaces to clear out the line). So that may be an option, though of course
> setting TERM=dumb may affect other programs you use.

Editors, in particular, tend not to like interacting with TERM=dumb as they 
have no idea how to behave around one ("I need CE and UP" comes to mind).

> I don't think it would be unreasonable to have a config option to select 
> whether we use the ANSI or dumb-term version.

GIT_TERM might be an option to override TERM, but I am loath to actually
suggest YAEV.

> Nah, it sounds like you actually set the variables correctly. We've just 
> assumed that we can get by with ANSI codes as a lowest common denominator 
> in the modern world, without having to resort to all the complexities of 
> using a terminfo library. It's worked pretty well so far. ;)

Laughing out loud at that.  Part of me is apologetic to be The Weird Kid.
The other part of me is looking for more ways to be weird.

Thank you for taking a look at this.

> 
> -Peff
> 

				Cheers,

				--*greywolf;
