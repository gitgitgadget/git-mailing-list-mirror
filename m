Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA8D1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 02:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeJ2LDT (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 07:03:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39833 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbeJ2LDT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 07:03:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id r10-v6so6934393wrv.6
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 19:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fWCMedN4HPTmkZvBpbS9Iq6+sqW6YjOxKpQcjMqXp98=;
        b=aWiCMpWkKq9IMcPB0t0GqOdy21uehNrFNpRA3X2xI1GTGDhrGdzdU96X92d932me8w
         lSEunH46JCs60qi4rRRtRX0TlAql34HTOyksPENtRF2zKmv290qjTYa9UAIrxyXqSbMW
         IJ5cN2o8qdhtAbmq28eDx75IXjZu9Fqn48uf3vKTzwI2OBNGnQPxtW59dyfCX6P/X0qw
         QKjqG6fDuSqWnKRNxx1OUGFsbSMCx/BUXKZcU5TBKaT3ZGHMIhiVdw/EW11aiYxbrprm
         liyeaYHxLDVWm8KZOWfCtdI24DBq0tP2LIhAHlq9U8eXF1xFhR51tFcRO2ztY3K+lUPe
         kbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fWCMedN4HPTmkZvBpbS9Iq6+sqW6YjOxKpQcjMqXp98=;
        b=cjpUMgxqvAlSxIKJGQVr4E/mSVMdnE9lIVdCGetUOZyhjhRHADX2HKr1ijYgi70d1p
         eKxvGIaNs76zvLFnVGqc4KsqbvyaVwXQGGdLX9vPa7du8/dpiwgE+aJfnbH1rGQ2nI63
         yMD2yReXEFa0u5woOX4H7z70JxcF11uSmQ/StwMZFGYPKFx3KfaYYPkQhj2ykW4PLFt4
         8zaty14px2oaN1jCvIWrEWhNRNJG7uf7oxBrkebt0YuUgz0FwPUg80dM69r2YPPMp50j
         ypV1kcbbwbYabhSmQ5aiDizXCXSZJnI73qtC6eDLqxPhCG3SF3jEN5Ni2SB5fo3+hfuu
         lVKg==
X-Gm-Message-State: AGRZ1gLTbZ1aAm7tHA9WYHDGuNRC+SwSuglFQNAymqU5oM0p0MXCkMkr
        Xiuziet22mNUEZDPTb+BLGNSNtOqOEU=
X-Google-Smtp-Source: AJdET5d+/e2EVgWS33byQm6LGFJ5X2ZfINE1RFTG/UBcioiZWeSbudyJY3kyGXrZHvQmD6IaxBOntg==
X-Received: by 2002:adf:aa05:: with SMTP id p5-v6mr3422461wrd.56.1540779403429;
        Sun, 28 Oct 2018 19:16:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x8-v6sm48942831wrd.54.2018.10.28.19.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 19:16:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 06/10] grep: remove #ifdef NO_PTHREADS
References: <20181027071003.1347-1-pclouds@gmail.com>
        <20181027071003.1347-7-pclouds@gmail.com>
        <20181027074443.GE26685@sigill.intra.peff.net>
Date:   Mon, 29 Oct 2018 11:16:39 +0900
In-Reply-To: <20181027074443.GE26685@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 27 Oct 2018 03:44:44 -0400")
Message-ID: <xmqqo9bd8pko.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Cases like this are kind of weird. I'd expect to see wait_all() return
> immediately when !HAVE_THREADS. But we don't need to, because later we
> do this:
>
>> -	if (num_threads)
>> +	if (HAVE_THREADS && num_threads)
>>  		hit |= wait_all();
>
> Which I think works, but it feels like we're introducing some subtle
> dependencies about which functions get called in which cases. I'd hoped
> in general that the non-threaded code paths could mostly just collapse
> down into the same as the "threads == 1" cases, and we wouldn't have to
> ask "are threads even supported" in a lot of places.

True, but the way "grep" code works with threads is already strange,
and I suspect that the subtle strangeness you feel mostly comes from
that.  The single threaded code signaled "hit" with return value of
individual functions like grep_file(), but the meaning of return
value from them is changed to "does not matter--we do not have
meaningful result yet at this point" when threading is used.

In the new world order where "threading is the norm but
single-threaded is still supported", I wonder if we would want to
drive the single threaded case the same way with the add_work(run)
interface and return the "did we see hits?" etc. from the same (or
at lesat "more similar than today's") interface, so that the flow of
data smells the same in both cases.

> I dunno. My comment isn't really an objection exactly, but mostly just
> an indication that I'm still thinking through what the best approach is,
> and what end state we want to end up in.
>
> -Peff
