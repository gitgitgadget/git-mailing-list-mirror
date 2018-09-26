Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3C11F453
	for <e@80x24.org>; Wed, 26 Sep 2018 20:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeI0CeC (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 22:34:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38677 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeI0CeC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 22:34:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id j8-v6so241620wrw.5
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 13:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4L3qNsPwO5oq69HBqOM48I2pr2jt026B1EeoQukaEr8=;
        b=T3xedHnt00ivs2mjHOBSASOBGT+NKA6EcpFCkdyO7XYdT343RIqF9LjNIqPK5TrerA
         UfFR+zO+3O9vf23UhQFKvVdFGEEWcPMNpA1qYZH6+huzVJSeMHTxC87kvk51WSdM+6eC
         6ngQ1+Rl5W5aBdpooAUKcq5CRTgOVKF7dpOmg1j+Pnmo4LxpWLMB33MsWTnW3Hw+T5Oy
         WZqtK05nVYL/DtSO/EICk6SWphJW0QMhU96QQ2qNjgez0e9PnjiAzEMaOLZ45yHJ0JB1
         OtuP1N1AsrnANAXsoax1gOsMyA3CLPzcGwEh/pV3bB36CoQOahMcMR66F/wM8gqHwuqn
         FfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4L3qNsPwO5oq69HBqOM48I2pr2jt026B1EeoQukaEr8=;
        b=E7UhyD0atMvTZVJxu3s9Ba24ZMte7nILqM50lICH0j3TErMD3AnMLvJ7W0gOeLsyCl
         cvAhpUN80+adIcl2g+H2ylN/LWv+ih4NrUFkSnmtoFwR/STiy8kQ4vTNfqiBQiMIoex2
         pDofvWJeBrJiYe8n7nJmmGN5s3Ho3imA91q9Kr6aiHz6xeOGRDadjKJosILCsvgKTtbE
         eOZf8APMYTaL3oN8F/we81GEtR30Tz2hMiumBlacyMpGOsAesc2vPwqB8vVrHMOrYNkl
         40hq9Lhtp78caJEqKb6m9lzwzU+3k22yK8X/Y6BllCnpihRs/a7cimZXZmoih4VgSo9g
         TTBA==
X-Gm-Message-State: ABuFfohs+CClL6o7oKEl3omSt5QOTU0wSR74+zh8NbMs7JHMVGEVqeJB
        FXCSNxgRFuf4SJDm14L5Www=
X-Google-Smtp-Source: ACcGV60QBXuOdR62fubNzF190w/0vwpb6YAIX9Yc83W5n3FQLaJmuzGiiPzR5GHotBNo0waw9L/CWw==
X-Received: by 2002:adf:92e6:: with SMTP id 93-v6mr6442980wrn.124.1537993161529;
        Wed, 26 Sep 2018 13:19:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p9-v6sm187777wmc.37.2018.09.26.13.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:19:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
References: <20180921223558.65055-1-sbeller@google.com>
        <20180921223558.65055-2-sbeller@google.com>
        <87h8ihk7sl.fsf@evledraar.gmail.com>
        <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
        <20180926041517.GA2140@sigill.intra.peff.net>
        <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
        <87d0t0jghm.fsf@evledraar.gmail.com>
        <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
        <87a7o4je0t.fsf@evledraar.gmail.com>
        <20180926185812.GD30680@sigill.intra.peff.net>
        <xmqqtvmcjaxx.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbeQvLuH1nGPkf8hHbs49SmuPeme_XBdz7ek5fU5AZ9Zg@mail.gmail.com>
Date:   Wed, 26 Sep 2018 13:19:20 -0700
In-Reply-To: <CAGZ79kbeQvLuH1nGPkf8hHbs49SmuPeme_XBdz7ek5fU5AZ9Zg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 26 Sep 2018 12:59:30 -0700")
Message-ID: <xmqqpnx0j9kn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I agree on both counts.  I just like to read these in plain text
>> while I am coding for Git (or reviewing patches coded for Git).
>>
>> The reason why I have mild preference to D/technical/ over in-header
>> doc is only because I find even these asterisks at the left-side-end
>> distracting; it is not that materials in D/technical could be passed
>> through AsciiDoc.
>
>     /**
>     Would we be open to consider another commenting style?

No.  You still cannot write */ in that comment section, for example,
so you cannot do "plain text" still---that is not a great trade off
to deviate from the common comment style used for other stuff.

When I say I want plain text, I mean it.  Anything you write in .h
cannot be plain text, unless you make all readers agree with some
convention, and "there is always '*' at the left edge" is such an
acceptable convention can learn to live with, just like everybody
else does ; at least, that is consistent with other comments.

> (I am not seriously proposing unbalanced comments, but for
> longer documenting comments we may want to consider,
> omitting the asterisk?)

If this is not a serious proposal, then I'll stop wasting
everybody's time.

Now it is clear that the only pieces of consensus we got out of this
discussion so far is that we want to add to CodingGuidelines, that
my earlier "something like this" is not the text we want and that we
want everything in the header as comment.

So let's see if we can have usable alternative, apply that and move
on.
