Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92076211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 09:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeK3Ucv (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 15:32:51 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42677 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeK3Ucv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 15:32:51 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so4249017edp.9
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 01:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=e/vMPaap6asF5k+Dd7G1sUeCTwkr504PvTRk43wRPoI=;
        b=WSNEP7qlhD6UHV0lv6zvnV+wq29HXn9Z5kTiCx4PdaWMYCVelW9fEaZA02TwzU/kkv
         Emf3VhFSvfWfFRHonvtwegUmCiA5YD0T/GWJ4XHH5Os0BpG6Nqa1WETByjGwHyGNp8GC
         qe5BN6yeSdzHS5JPlcu2RDWrj+CQtpudEK9Sao05i7+erDzQYLMmUSwYXmX2DVcwDB+o
         3gY9XW48gtlZlgcKNF9uyowdJuZxNVvu6Oh8Ovqi19gsrAVq3DTZlrQteYXRYnvVw9An
         EXWhcxtUl1FT1k9/g+D3bMQxWbu/Hj4floA50HUUhODvubTil4ajciF6s2z/CH9BPn75
         btXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=e/vMPaap6asF5k+Dd7G1sUeCTwkr504PvTRk43wRPoI=;
        b=GcdqNfC4180xaik31jsXYk57E5HlLPTF0NQQfgVPeZfXWGZQoYor7DgB+SaeDi5T2V
         iRHFMStq2ys/ReD+rvBjuZWpS0Yso6a6EdBfxKbLc5QFSXVsDyVn4Y2Y4dsVExJS/RAA
         OikDNJxE8jx3wlnWESZYcEjyahP6kZjn3W1VKdwfYogM0qYNs6GaDJ2IgYEoH+/OGTKZ
         5I5wPyyUQ4++XUhXCArDEYfevoUKDxlr+Zd3gi39zIhtNMxCVEEq6LqOmM/3umw6Jt9c
         9wlf3Alkt0zJ6nvk0k70gwH8zLm7FhByLXLg3u6fh0qBuxPWN4GqCYTE0Ev+JW2/H3k9
         GfAw==
X-Gm-Message-State: AA+aEWbSf93PS5MGhFOKH2dBozL317pIR8UvYNvWBtGw75uaZxID113m
        jJ+W+fwcxyxTUMEBSKJqX0s=
X-Google-Smtp-Source: AFSGD/UZl31z8t4Pd7RWo9C+NrU23+mcxD/VS6N2cEuYldhp3fiVYAUty3tq/U6KlljBW1pCppE0Qg==
X-Received: by 2002:aa7:c6d1:: with SMTP id b17mr4617476eds.249.1543569849765;
        Fri, 30 Nov 2018 01:24:09 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id j31sm1279752eda.46.2018.11.30.01.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 01:24:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: do not let its diff-options affect --range-diff (was Re: [PATCH 2/2] format-patch: allow for independent diff & range-diff options)
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com> <20181128201852.9782-3-avarab@gmail.com> <nycvar.QRO.7.76.6.1811291103190.41@tvgsbejvaqbjf.bet> <8736rkyy4h.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811291307070.41@tvgsbejvaqbjf.bet> <871s74yms3.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811291641090.41@tvgsbejvaqbjf.bet> <87tvjzyiph.fsf@evledraar.gmail.com> <xmqq7egvmh54.fsf@gitster-ct.c.googlers.com> <xmqqwoovkx5s.fsf_-_@gitster-ct.c.googlers.com> <xmqq36rjkkn7.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq36rjkkn7.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 30 Nov 2018 10:24:07 +0100
Message-ID: <871s72x6iw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 30 2018, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> I had to delay -rc2 to see these last minute tweaks come to some
>>> reasonable place to stop at, and I do not think we want to delay the
>>> final any longer or destablizing it further by piling last minute
>>> undercooked changes on top.
>>
>> So how about doing this on top of 'master' instead?  As this leaks
>> *no* information wrt how range-diff machinery should behave from the
>> format-patch side by not passing any diffopt, as long as the new
>> code I added to show_range_diff() comes up with a reasonable default
>> diffopts (for which I really would appreciate extra sets of eyes to
>> make sure), this change by definition cannot be wrong (famous last
>> words).
>
> As listed in today's "What's cooking" report, I've merged this to
> 'next' in today's pushout and planning to have it in the -rc2.  I am
> not married to this exact implementation, and I'd welcome to have an
> even simpler and less disruptive solution if exists, but I am hoping
> that this is a good-enough interim measure for the upcoming release,
> until we decide what to do with the customizability of range-diff
> driven by format-patch.
>
> In addition to this, I am planning the "rebase --stat" and "reflog
> that does not say 'rebase -i' but 'rebase'" fixes merged to 'master'
> before cutting -rc2.

Thanks a lot, yeah having this wait looks good to me.
