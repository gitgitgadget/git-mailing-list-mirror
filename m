Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925F61FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 16:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbcGSQFT (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 12:05:19 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36718 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbcGSQFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 12:05:16 -0400
Received: by mail-it0-f47.google.com with SMTP id f6so94956512ith.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 09:05:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9/fCLTeVA2UaTwYtl1JZQQvGeTw1uRQti6oM/IILmOY=;
        b=VFLFvi/GB/us7olt4NgCNGZZ5uuYZnrWXexUWC/2Z8rSsYdWAd0D92nwnIwLCcmzDA
         It454+84tLYEc8PNySz2YoaHwHDNXTZ0bMss8QiO1L3nm1eBgKko2QKg70UuWnQj561Y
         KOFk1Nd/XeRQSleUduJn9ZSU59VzcVeVzkHnVSbsB5QR8LoW/aR1BW0dRjN+XiG5xqLL
         yQlfoH68XH5iIihpQ6vsHRrBRyiZ3XsBid8q6R4Ibt5/wr/f7BK1RTTypY+Kd58QCSZn
         oU/c91LPRAp565px8hl3W2b5t/u+DfeHMcmYZ7iPMZwL6itnRLEWQ2vrieXlnkPQgA4M
         H1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9/fCLTeVA2UaTwYtl1JZQQvGeTw1uRQti6oM/IILmOY=;
        b=UIXBRlLu/18WB5+tqDDjmuNMfFcRnwBppIRRNUAbLbLKysVBeXuMZuyO7euk2a3m9w
         1NwYeYBq9bjH9EczT4FyeIaqF24e9V8eH2nEU4UERgbsBuUJaH3z9JYenj/IbEWFk2Qh
         ZOsQOuoIeYH9cUBnK82AwPZavHt0ydw8hgTC+bnkesGE9dSw5fEKbcwhAG47++dIg6GW
         IPFw36AkMb8dAfZVdy2JJKpc0RSYLb4SDUfOPmWawuki9Pinxe31Rqa36WK5KPbySc9+
         2z5OWscCyiMTkixPLeSFh52gmgA/BHPGxnXF2tBrsfFUj1cAVNyLS7PqcVtH4/D9AxLe
         sirQ==
X-Gm-Message-State: ALyK8tIX1nP5cDuI7huperDr7PL/7jo75qVgoMjEdqqaaC9czjDUH21OW5cl66QptkUB0K9R3gyii+zOvqIk2TnB
X-Received: by 10.36.228.138 with SMTP id o132mr49318327ith.49.1468944314862;
 Tue, 19 Jul 2016 09:05:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 19 Jul 2016 09:05:14 -0700 (PDT)
In-Reply-To: <20160719100730.GA5193@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net> <20160715104347.GL19271@sigill.intra.peff.net>
 <CAGZ79kbernZHx9SUG-_vbxy-g77_3ki1uc-21LCviwrH=aXp6w@mail.gmail.com>
 <20160716075621.GA10275@sigill.intra.peff.net> <CAGZ79kZPbSTAv6zjJ01PdqBOZrsfhRAte_v-mbBzXuOAWNK+Tg@mail.gmail.com>
 <20160719100730.GA5193@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 19 Jul 2016 09:05:14 -0700
Message-ID: <CAGZ79kZ7m94T5+SHjeWcY_cDLYSP9X74eDOOjfmZ1GwAb-C-7g@mail.gmail.com>
Subject: Re: [PATCH 12/12] receive-pack: send keepalives during quiet periods
To:	Jeff King <peff@peff.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 3:07 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 18, 2016 at 10:28:25PM -0700, Stefan Beller wrote:
>
>> On Sat, Jul 16, 2016 at 12:56 AM, Jeff King <peff@peff.net> wrote:
>> >> > +               if (use_keepalive == KEEPALIVE_AFTER_NUL && !keepalive_active) {
>> >> > +                       const char *p = memchr(data, '\0', sz);
>> >> > +                       if (p) {
>> >> > +                               /*
>> >> > +                                * The NUL tells us to start sending keepalives. Make
>> >> > +                                * sure we send any other data we read along
>> >> > +                                * with it.
>> >> > +                                */
>> >> > +                               keepalive_active = 1;
>> >> > +                               send_sideband(1, 2, data, p - data, use_sideband);
>> >> > +                               send_sideband(1, 2, p + 1, sz - (p - data + 1), use_sideband);
>> >> > +                               continue;
>> >>
>> >> Oh, I see why the turn_on_keepalive_on_NUL doesn't work as well as I thought.
>> >> I wonder if we can use a better read function, that would stop reading at a NUL,
>> >> and return early instead?
>> >
>> > How would you do that, if not by read()ing a byte at a time (which is
>> > inefficient)? Otherwise you have to deal with the leftovers (after the
>> > NUL) in your buffer. It's one of the reasons I went with a single-byte
>> > signal, because otherwise it gets rather complicated to do robustly.
>>
>> I do not question the concept of a single NUL byte, but rather the
>> implementation, i.e. if we had an xread_until_nul you would not need
>> to have a double send_sideband here?
>
> What would xread_until_nul() look like?
>
> The only reasonable implementation I can think of is:
>
>   ssize_t xread_until_nul(int fd, char *out, size_t len)
>   {
>         ssize_t total = 0;
>         while (total < len) {
>                 ssize_t ret = xread(fd, out + total, 1);
>                 if (ret < 0) {
>                         /* Oops, anything in out[0..total] is lost, but
>                          * we have no way of signaling both a partial
>                          * read and an error at the end; fixable by
>                          * changing the interface, but doesn't really
>                          * matter in practice for this application. */
>                         return -1;
>                 }
>                 if (ret == 0)
>                         break; /* EOF, stop reading */
>                 if (out[total] == '\0')
>                         break; /* got our NUL, stop reading */
>                 total++;
>         }
>         return total;
>   }
>
> There are two problems with this function:
>
>   1. Until we see the NUL, we're making an excessive number of read()
>      syscalls looking for it. You could make larger reads, but then what
>      do you do with the residual bytes (i.e., the ones after the NUL in
>      the buffer you read)? You'd have to somehow save it to return at
>      the next xread_until_nul(). Which implie some kind of internal
>      buffering.
>
>      The reason there are two send_sidebands is to cover the case where
>      we have some real data, then the signal byte, then some more data.
>      So instead of buffering, we just handle the data immediately.
>
>   2. How does it know when to return?
>
>      We want to send the data as soon as it is available, in as large a
>      chunk as possible. Using a single xread() as we do now, we get
>      whatever the OS has for us, up to our buffer size.
>
>      But after each 1-byte read above, we would not want to return;
>      there might be more data. So it keeps reading until NUL or we fill
>      our buffer. But that may mean the xread() blocks, even though we
>      have data that _could_ be shipped over the sideband.
>
>      To fix that, you'd have to poll() for each xread(), and return when
>      it says nothing's ready.
>
> I know that writing the function myself and then critiquing is the very
> definition of a strawman. :) But it's the best I could think of.  Maybe
> you had something more clever in mind?

Actually no, I had not. I was hoping you could come up with a clever thing.
My original point was the perceived added complexity to a simple
seemingly simple function (copy_to_sideband in your original patch),
so my gut reaction was to shove the complexity away into a helper function.
But no matter how it is done, there is always this one function that looks
complex for this problem. So I think your original approach is fine then?

Thanks,
Stefan


>
> -Peff
