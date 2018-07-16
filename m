Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5745C1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbeGPWZ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:25:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46085 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbeGPWZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:25:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id s11-v6so33351281wra.13
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l39Ru6Zvakudmq7JAmHKjWuIPpWDh340cmXF3/94694=;
        b=UJcLw0zsS9atsnb6TSpJ35prbjzGU/sAI7ruzSYRIfOvIFyEt9Gf6VGQ05SLg3qW8b
         dwsicgA3GBd8HuVuwkpt3hTryUaw2jzfvsllI3Vf3xwPnAnYeiQDNNT+Uxbinu+6nYd4
         p8BYM2XRCfMcVRrmStqNEuBtdJGz0gBhf3cN42zIx3Ha/ZCN8Z8Twb2oWIIZnAU2SWiy
         c/DWtP+VJaGxp4LrSqTdqbcKzSPPmF9H0TJM5hk2EHVNht7fjic5Eh0FSb74HFeYGBrX
         U0NBuxx/K9ND6V44Y2X0Hicxag36cbb3mYKX0vxP/CZZKiBZc3MgQWAlwikQJ0sMwcUD
         /3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l39Ru6Zvakudmq7JAmHKjWuIPpWDh340cmXF3/94694=;
        b=bJTpL+9aHl/chs8Cfsrnimc1yhp5AnfQsIhKoIwH4Ne9yDFuZEKZwIf+RfVOzY+cZT
         4m3pZGP7NIP0W8BbkFfuNUj5eSpoKPmwPYz/iiP0aJIgCWZxFimeKk/kc9jFMP1BBuif
         1IrqaKvaA6neC9X9JzfkQllHaFxphIgj0bUMZTE0pPPfeAKRm6vxcNFZexaJub8e4Jpi
         llIPy8I5Wuuy8R8IMEKQGb6k7c4+eqj4njgsT60XZi+oUDsuJ33Sb143P0zflt0PH8gH
         HsgC49FaLo4YgY3aby9bd5MXy38zCLKsKxXlU4JIOb53mrzyUu24sgfhJEZLzyaMVbu/
         9jtg==
X-Gm-Message-State: AOUpUlED/79b1Z1i7n5DYpi7rp07Awf6vrmo+wbLyCF8soyp2nC69AcN
        BrbhwSh/hzEP2EAHaIFSxNY=
X-Google-Smtp-Source: AAOMgpeEemUt5DLhLh30RAxgvcjnGZjC4IK1eL8/tDDoNJgaBvtDQOM6WpWFRHNvam2ohPL9ma3UhQ==
X-Received: by 2002:adf:a0f3:: with SMTP id n48-v6mr13920208wrn.23.1531778195844;
        Mon, 16 Jul 2018 14:56:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x7-v6sm10878165wrr.95.2018.07.16.14.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:56:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/9] gpg-interface: introduce new config to select per gpg format program
References: <cover.1531208187.git.henning.schild@siemens.com>
        <4905c1907a866c0fd1a4dac978dd6ca3e468ac43.1531208187.git.henning.schild@siemens.com>
        <20180710165412.GE23624@sigill.intra.peff.net>
        <20180710165638.GF23624@sigill.intra.peff.net>
        <20180714181347.GE1042117@genre.crustytoothpaste.net>
        <20180716213510.GJ25189@sigill.intra.peff.net>
Date:   Mon, 16 Jul 2018 14:56:34 -0700
In-Reply-To: <20180716213510.GJ25189@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 16 Jul 2018 17:35:11 -0400")
Message-ID: <xmqq36wisv3h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jul 14, 2018 at 06:13:47PM +0000, brian m. carlson wrote:
>
>> On Tue, Jul 10, 2018 at 12:56:38PM -0400, Jeff King wrote:
>> > On Tue, Jul 10, 2018 at 12:54:13PM -0400, Jeff King wrote:
>> > 
>> > > Should we allow:
>> > > 
>> > >   [gpg "OpenPGP"]
>> > >   program = whatever
>> > > 
>> > > given that we allow:
>> > > 
>> > >   [gpg]
>> > >   format = OpenPGP
>> > > 
>> > > ? I think just using strcasecmp() here would be sufficient. But I wonder
>> > > if it is a symptom of using the wrong tool (subsections) when we don't
>> > > need it.
>> > 
>> > I did just read the discussion in response to v1, where everybody told
>> > you the opposite. ;)
>> > 
>> > So I guess my question/points are more for brian and Junio.
>> 
>> I'm okay with us forcing "openpgp".  That seems sane enough for now, and
>> if people scream loudly, we can loosen it.
>
> Well, I specifically meant "are you sure subsections like this are a
> good idea". But it seems like people think so?

I admit that I did not even consider that there may be better tool
than using subsections to record this information.  What are the
possibilities you have in mind (if you have one)?

>
> If so, then I think the best route is just dictating that yes,
> gpg.format is case-sensitive because it is referencing
> gpg.<format>.program, which is itself case-sensitive (and "openpgp" is
> the right spelling).
>
> -Peff
