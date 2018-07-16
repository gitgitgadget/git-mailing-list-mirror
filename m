Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00CCC1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 19:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeGPTij (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:38:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37000 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbeGPTij (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:38:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so996161pgq.4
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 12:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kpuCkp0g7Kvv3JwiRqCtd4JjexoaKAGAaWi3z5vi+j0=;
        b=gxTiNGP4wAwZDIqeMNmW3B40i7S+MpK1duBw4aQepIxnRJQzL0EWfnbf3+eqTTWCgC
         Np7J3NAB29mzwDGRk47EARdlsqbuUAf8/K8jRSSql+snmn1dDWQ7ZvRzWwR9SOu5ofE4
         y2HacVpOa0mLrFHVanMGvFOWK0owXEhYFj9I//ActktuJuHG7URgjOnCST6hPwYgh904
         G8cUokG+LgClfnhYYyUfx1FgFjs2ytDnzk+YllBvV7kgKtaoS1xRfln6ec8wuCo9/jQk
         gL41nk65RZ9SySdK4oqQzEG7K/kAP0O8lBQfhcM29grim40bzz//ZMt++/1Hti61D0kf
         VQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kpuCkp0g7Kvv3JwiRqCtd4JjexoaKAGAaWi3z5vi+j0=;
        b=Y3SFBn+j6fOsxM93dD2kTGZrHmUQKhZHjys0bXaBPGz3ngUA5qUvSKUHa+2ISZVFlY
         HLhHNwLImQguh3mB1nprIDSbR4iGAkIqBSXumTWhEymfLpbtGRBZ9ITcTMFX0Qb5ctT9
         ub8Sn/rpCfoLCy+NDC+k9CSNg0MBQi8lg+LVYGxSHckCw973mi+WjjLdOysxswskeJR6
         G+0qqRUHMAG8JYOLxEGbsME5ibS3d5UlCcXKgK1zdda3txucbT86FekzoQEfTFrECktu
         RGaqaMezlY7ueBgybgKPgNWJgnge1wAtVLVV9fhHO8tORTyM+2YeN777sNrx0qxGlJ1Q
         OEIw==
X-Gm-Message-State: AOUpUlHJ7d5BhamAWwUs46iF2Ns9VvdyyJRoWPZvaohmBfYrT1qGYhP9
        9DTHiW/1LL1qQXXOoOehrDo=
X-Google-Smtp-Source: AAOMgpecMfcvUUxDjLvpcM+NXr3RMhN44aigfzgC0SZXpGOriV+ZthrVXe/FlLWc1hZmxviydjN7cw==
X-Received: by 2002:a62:ccd0:: with SMTP id j77-v6mr19113799pfk.22.1531768191635;
        Mon, 16 Jul 2018 12:09:51 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n5-v6sm51481600pgd.7.2018.07.16.12.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 12:09:50 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:09:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716190949.GB11513@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716175103.GB18636@sigill.intra.peff.net>
 <20180716182207.GA11513@aiede.svl.corp.google.com>
 <20180716185255.GC22298@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716185255.GC22298@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Mon, Jul 16, 2018 at 11:22:07AM -0700, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> So while I completely agree that it's not a great thing to encourage
>>> users to blindly run "git prune", I think it _is_ actionable.
>>
>> To flesh this out a little more: what user action do you suggest?  Could
>> we carry out that action automatically?
>
> Er, the action is to run "git prune", like the warning says. :)

I don't think we want to recommend that, especially when "git gc --auto"
does the right thing automatically.

Can you convince me I'm wrong?

[...]
>> I mentally make a distinction between this warning from "git gc
>> --auto" and the warning from commands like "git gui".
[...]
> I don't think those warnings are the same. The warning from "git gui"
> is: you may benefit from running gc.
>
> The warning that is deleted by this patch is: you _just_ ran gc, and hey
> we even did it automatically for you, but we're still in a funky state
> afterwards. You might need to clean up this state.

This sounds awful.  It sounds to me like you're saying "git gc --auto"
is saying "I just did the wrong thing, and here is how you can clean
up after me".  That's not how I want a program to behave.

But there's a simpler explanation for what "git gc --auto" was trying
to say, which Jonathan described.

[...]
>> Yes, this is a real problem, and it would affect any other warning
>> (or even GIT_TRACE=1 output) produced by gc --auto as well.  I think we
>> should consider it a serious bug, separate from the symptom Jonathan is
>> fixing.
>>
>> Unfortunately I don't have a great idea about how to fix it.  Should
>> we avoid writing warnings to gc.log in daemon mode?  That would
>> prevent the user from ever seeing the warnings, but because of the
>> nature of a warning, that might be reasonable.
>
> If you do that without anything further, then it will break the
> protection against repeatedly running auto-gc, as I described in the
> previous email.

Do you mean ratelimiting for the message, or do you actually mean
repeatedly running auto-gc itself?

If we suppress warnings, there would still be a gc.log while "git gc
--auto" is running, just as though there had been no warnings at all.
I believe this is close to the intended behavior; it's the same as
what you'd get without daemon mode, except that you lose the warning.

[...]
>> Should we put warnings
>> in a separate log file with different semantics?  Should we change the
>> format of gc.log to allow more structured information (include 'gc'
>> exit code) and perform a two-stage migration to the new format (first
>> learn to read the new format, then switch to writing it)?
>
> Any of those would work similarly to the "just detect warnings" I
> suggested earlier, with respect to keeping the "1 day" expiration
> intact, so I'd be OK with them. In theory they'd be more robust than
> scraping the "warning:" prefix. But in practice, I think you have to
> resort to scraping anyway, if you are interested in treating warnings
> from sub-processes the same way.

Can you say more about this for me?  I am not understanding what
you're saying necessitates scraping the output.  I would strongly
prefer to avoid scraping the output.

Thanks,
Jonathan
