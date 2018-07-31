Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C90E1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 15:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeGaQnX (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 12:43:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37310 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbeGaQnX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 12:43:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id b10-v6so5509171eds.4
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cCM13QM/N2objTdV0MEiutNQeE9zeVEU12P1qpGbqfQ=;
        b=hLEj8t0ZrrvbxU4F3Whw/GyRVpXh2BT0k2oOYvq4mQSxrNuD/wlccdl9P9CeW3ACRN
         PpQfhZVKDk4Dsc3cCQMQEbNV6ZS1Ghq6FtJUtjnyFAlyT7+X/I88m+das/koc3FP4dt9
         HiQnLog7KE16cxqH4BGfgYdu3yZNg2TCoYP/s3eGeZ8LS9lD96Ig6mAD+40mI5fDCPPk
         +GGq33/ZtOsgdMhzjR+v7SVHLzC+MGcu6UblTBiTtShCERz6LRBvf8e9JJTPrbSlWziD
         qA/+MkayopTJ5oBe/hWSqvaSipFUSrne+bCBFVnVBDSGzn2ceKKwd9JdegFTJPfv7bTW
         ObZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cCM13QM/N2objTdV0MEiutNQeE9zeVEU12P1qpGbqfQ=;
        b=a0K1bWqLmKsZd3rj7rHZS5D6VBhRuOg7jgCkGex3+HmJPY4mX0RSvvI9wwkyNcidRp
         Afzv27Tn8nxhKK2eTNmBzRxS3+eFfcGYAs9vGugDNaPInPKI7c9UNq5Q4HmYp/8LLJXp
         SSZTg/r6YTvokakr1IcYT3vYtKM3Phk42TZCzz4tcqZCMCRpwACqEiiUBh6dTJOMS7Ta
         aWsP0rI+YUPVhWXxriwteUJEmOl78611Z928wl5pznkSgg/h+I93k2rQsnARFKcATw3w
         1to/5rk4IexkKLE9Z9GPpHDdRR0rsTdeCw3H+R4fKYVQs2dyfgdoVc1Y0bNRXC0e9kvr
         kmEQ==
X-Gm-Message-State: AOUpUlEm/AEQy15+Ii5dSjvwIIDI5LqqkULzFFOdmHZDNmVSrpGopU5M
        mtQXD8Qd6IooBDfG+EPItiQ=
X-Google-Smtp-Source: AAOMgpdfTD0XnfVNXU1tdpp6xElgmiE7UlpnyAKyoFu9oMPa+ihXTmuMsL/+Af3dBb+8M+PWb2xraQ==
X-Received: by 2002:a50:ba3b:: with SMTP id g56-v6mr59986edc.85.1533049358156;
        Tue, 31 Jul 2018 08:02:38 -0700 (PDT)
Received: from evledraar ([5.57.20.50])
        by smtp.gmail.com with ESMTPSA id t44-v6sm3570073edh.18.2018.07.31.08.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 08:02:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] negotiator/skipping: skip commits during fetch
References: <20180716184401.168576-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180716184401.168576-1-jonathantanmy@google.com>
Date:   Tue, 31 Jul 2018 17:02:36 +0200
Message-ID: <87r2jjtpmb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 16 2018, Jonathan Tan wrote:

Didn't catch this until this was in next, sorry.

Re-arranged the diff a bit:

> -void fetch_negotiator_init(struct fetch_negotiator *negotiator)
> +void fetch_negotiator_init(struct fetch_negotiator *negotiator,
> +			   const char *algorithm)
>  {
> +	if (algorithm && !strcmp(algorithm, "skipping")) {
> +		skipping_negotiator_init(negotiator);
> +		return;
> +	}
>  	default_negotiator_init(negotiator);
>  }

Okey, I understand that's how it works now, but....

> +fetch.negotiationAlgorithm::
> +	Control how information about the commits in the local repository is
> +	sent when negotiating the contents of the packfile to be sent by the
> +	server. Set to "skipping" to use an algorithm that skips commits in an
> +	effort to converge faster, but may result in a larger-than-necessary
> +	packfile; any other value instructs Git to use the default algorithm
> +	that never skips commits (unless the server has acknowledged it or one
> +	of its descendants).
> +

...let's instead document that there's just the values "skipping" and
"default", and say "default" is provided by default, and perhaps change
the code to warn about anything that isn't those two.

Then we're not painting ourselves into a corner by needing to break a
promise in the docs ("any other value instructs Git to use the default")
if we add a new one of these, and aren't silently falling back on the
default if we add new-fancy-algo the user's version doesn't know about.

Also, switching gears entirely, I'm very excited about this whole thing
because it allows me to address something I've been meaning to get to
for a while.

At work I sometimes want to see what commits I've made to all our git
repos, for remembering what I was doing last February or whatever (this
is for filling in quarterly reports).

So I have this script that basically does this:

    for repo in $(get-list-of-all-the-things)
    do
        git config "remote.$repo.url" git@git-server.example.com:$repo.git
        git config "remote.$repo.fetch" "+HEAD:$repo/HEAD"
        git config "remote.$repo.tagOpt" "--no-tags"
    done &&
    git fetch --all

I.e. for every repo like git/git I'll fetch its upstream HEAD as the
branch git/git/HEAD. Then I can do stuff like:

    git shortlog --author=Ævar --since=2018-02-01 --until=2018-03-01

Now, running that "git fetch --all" takes ages, and I know why. It's
because the in the negotiation for "git fetch some/small-repo" I'm
emitting hundreds of thousands of "have" lines for SHA1s found in other
unrelated repos, only to get a NAK for all of them.

One way to fix that with this facility would be to have some way to pass
in arguments, similar to what we have for merge drivers, so I can say
"just emit 'have' lines for stuff found in this branch". The most
pathological cases are when I'm fetching a remote that has one commit,
and I'm desperately trying to find something in common by asking if the
remote has hundreds of K of commits it has no chance of having.

Or there may be some smarter way to do this, what do you think?
