Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349F31F403
	for <e@80x24.org>; Wed, 13 Jun 2018 22:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935490AbeFMWei (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 18:34:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53968 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935256AbeFMWeh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 18:34:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so7266945wmc.3
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Hu4DDAH6QGTfgBYUUOuyKPVtw+ZjZhok99h1lUWxYt8=;
        b=RvLsxOKHcIvyJeE8Ur9UWrrCp2spxIdw540qqlxK8845Kfi0+lqYi+kTt9IfGh39mr
         MSsVeeIy60T7b5NWrB1f0dnNz44A0VM4aRUI4ZBO9A7auzfLdAWogxHBmVO3Gym7DD2p
         yNwZgDX3Djue/M4uUk7kbb+gOjDECriRqe8RYNVxcP/IIeUs2/yYUqQVM5EkvXEKGavy
         DaBg7LrkY3+zcIGIcfMldhzKIEj1CzPRrS2hxZuJXsj3qA1hX4ZTBdsFxdH9w/vL1q8K
         Mjxz61ttqNdeBMAFJb3m0Y+KxXh+ZMmFBIA8Hj3vh5VP7wPDVL7xSLi121oygXH8V2AW
         wMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Hu4DDAH6QGTfgBYUUOuyKPVtw+ZjZhok99h1lUWxYt8=;
        b=OUjg+SwPgVKXsswjKpyNtw+rWt+PnMVq85TmVRuzZnRFutfZYJxEf0oSUnUFPlhFH+
         vXXmoaR6Ne3pmROiJskRXK84obj802z+uLyjcJ/tplQNW+dBHVi2PK9zV1xPtmibdsvn
         nSx32TLi8WoaTfUCCHLu3LFWo8yutJbXRU8WR4ifr2W0YVYWFNiyyFIrTo5tiA7j1v+b
         Pr9plXBxE3k7GaEG2SyikHIb/OW3Yea4pfMdDvfXrwk0o8iatCDUOmJq/ucBiRKNlu9u
         aMqW1aWWJ9PIL2eBxGeBO7ai5GF6w9o8mGT8KNA6UW8IawxolNYuJ4KbLgbE4+ssfRjD
         q+Lg==
X-Gm-Message-State: APt69E1A8kLwiR5q3cDMT6Mm3u/sxiYK7YlnSVOiz/an7CyqPwPLFx3Z
        iJ6RcEMYC4Y2csk0ITh+xyI=
X-Google-Smtp-Source: ADUXVKLa3w41LDT1aY93d1AW4sPyuecs1T4BTlF+xs5wAz/TPM5TQaaS1i15X0b04zGWl0bDmYCxQg==
X-Received: by 2002:a1c:c342:: with SMTP id t63-v6mr20643wmf.123.1528929275754;
        Wed, 13 Jun 2018 15:34:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m65-v6sm4492286wmd.1.2018.06.13.15.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 15:34:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 19/20] abbrev: support relative abbrev values
References: <20180608224136.20220-1-avarab@gmail.com>
        <20180608224136.20220-20-avarab@gmail.com>
        <xmqqvaan95os.fsf@gitster-ct.c.googlers.com>
        <871sdawcmh.fsf@evledraar.gmail.com>
Date:   Wed, 13 Jun 2018 15:34:34 -0700
In-Reply-To: <871sdawcmh.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 14 Jun 2018 00:22:14 +0200")
Message-ID: <xmqqa7ry5n9h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> E.g. here's a breakdown of my dotfiles repo:
>
>     $ git -c core.abbrev=4 log  --pretty=format:%h|perl -nE 'chomp;say length'|sort|uniq -c|sort -nr
>         784 4
>          59 5
>           7 6
>
> I don't have a single commit that needs 7 characters, yet that's our
> default. This is a sane trade-off for the kernel, but for something
> that's just a toy or something you're playing around with something
> shorter can make sense.
>
> SHA-1s aren't just written down, but also e.g. remembered in wetware
> short-term memory.

That's a fine example of what I called "supporting absurdly small
absolute values like 4"; I still do not see why you want "negative
relative values" from that example.
