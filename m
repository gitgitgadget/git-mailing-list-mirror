Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1761F461
	for <e@80x24.org>; Tue,  9 Jul 2019 20:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfGIUYC (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 16:24:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46242 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfGIUYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 16:24:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id i8so9999198pgm.13
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mC9yxapmrBLeEn8R2ca4YGiAIGNoup/5JgUKaIZ7v0Y=;
        b=Fm5Nn/B7skAS0G1P2uw9xn4uLW7o8YItdX3MGHKIPrDVrKhxs9BVpAQrdvZ2JsEpww
         oh4X/Vtpt/+aGRbWinaUbaJpQlBI37T0VwEANIvL3DR1wufvuAPTV/wJkph6fBjmyLyT
         QCp5OhIF6+RymgPVWuMNeMWinHT5Ek/BYLGe0gHTRdNWEKAuu8/9tVVSUtauK/WmJHxm
         tD5twSBJc9pfN3ZytaPMFbZfyUzWFTlDURAt3HvC3t6ak2ualX7LnQXbmWIFfSkXUDv7
         I/RRgqwSrMaLxZkcPN8z2vljzrvvK7w4ewLbzNTKbq95YwmApQ7+nf5cd2kGA5Ym2ZIl
         5Wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mC9yxapmrBLeEn8R2ca4YGiAIGNoup/5JgUKaIZ7v0Y=;
        b=Q5L45n4X3QzbPk64TdT1qerBBw/8ZBao7DdLNN4b8AZXtjhJCRWvciPX+rmR+5R208
         /WoUcisAXongnVZ5hNfYCAkunMlqrd+J3TlDdmmZ4/DZWGMBoO7Qk+iH/NjD4J5+MJ0F
         vsv0ClYFddYWEG1Pa69dy0Jiw+0ZHuvTLqSdKgrzAPASCtopolQQpgD/oCvsfFWVe3jt
         iHuCWRnoPUDfG7ivJfMSohvuIHpKxjGDTcGCNNWU+CPGLW5VSduqespNOVrTrg5M/vhb
         1vOBgHGeUHGeFSBiNpZ/js2tk+O0nWjCBCtkRpyQWflmTP+qS4rtDIl2O5erJkWSRTjC
         jjag==
X-Gm-Message-State: APjAAAUERuYaNiSXnbJHJdiCVWVd5Edu9YvxHfc7FbD0nc0kNRaE2Dxu
        atrWpTdvRh4HNWvPPP8BXfgjsw==
X-Google-Smtp-Source: APXvYqwb4d5JOXxiit1ktWKws4eGGG4qDa7h5dN/2seGBo1J9jmZN/nI/vunPJRVISZdOAS3oIzUzg==
X-Received: by 2002:a63:124a:: with SMTP id 10mr1522571pgs.254.1562703840268;
        Tue, 09 Jul 2019 13:24:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id e63sm21203640pgc.62.2019.07.09.13.23.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 13:23:59 -0700 (PDT)
Date:   Tue, 9 Jul 2019 13:23:55 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
Message-ID: <20190709202355.GA113966@google.com>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1907021540330.48@tvgsbejvaqbjf.bet>
 <20190703185535.GC121233@google.com>
 <nycvar.QRO.7.76.6.1907032137210.44@tvgsbejvaqbjf.bet>
 <20190703205755.GF121233@google.com>
 <nycvar.QRO.7.76.6.1907040947170.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907040947170.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firstly, sorry for the delay, I wasn't working for national holiday from
the 4th til yesterday.

> If I were tasked with developing this further, I would try to move as much
> of the setup into the initial test case (if there is already a `setup`
> test case; otherwise I would create one). In fact, I would try to reuse as
> much of the existing setup test case as possible, and only add commands if
> really necessary. Then, I would try to combine the three test cases in the
> patch into a single one, structuring it by white space and using comments
> to clarify what is happening.
> 
> In my mind, even just adding an empty line before the comments like "Make
> master incompatible with up/master" would make it much easier for me to
> read, were I to analyze a test breakage.
> 
> I have to admit that I have a hard time understanding what the intention
> of those three test cases is because I get confused: where does the set-up
> end, where is the code that is expected to fail, where are the
> expectations tested?
> 
> Also, I get confused by how similar the test cases look, and have a hard
> time discerning what the differences are (i.e. what are the interesting
> bits, where the entropy comes from).
> 
> I could imagine that I would have had an easier time reading something
> like this:
> 
> test_expect_success 'push --atomic' '
> 	: set up two branches, one which will require a force push &&
> 	git checkout -b fast-forwarding master &&
> 	test_commit push-atomic &&
> 	git checkout -b non-fast-forwarding &&
> 
> 	: now, initialize the bare repository to push to &&
> 	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic.git &&
> 	git clone --bare . $d &&
> 
> 	: modify the two branches and create a third one &&
> 	git reset --hard HEAD^ &&
> 	git checkout fast-forwarding &&
> 	test_commit no-need-to-force &&
> 	git branch new-branch &&
> 
> 	: now the atomic push must fail &&
> 	test_must_fail git push --atomic "$HTTPD_URL"/smart/atomic.git \
> 		fast-forwarding non-fast-forwarding new-branch 2>err &&
> 
> 	: verify that new-branch was not pushed &&
> 	test_must_fail git -C $d rev-parse --verify refs/heads/new-branch &&
> 
> 	: fast-forwarding should be mentioned even if it would have been OK &&
> 	grep fast-forwarding err
> '

After I read your initial comment this is close to what my rewrite
started to look like; I suppose we're only the same page after all :)

> 
> Of course, everybody has their preferences, and their personal style. I do
> not want you to imitate my style just to "pacify" me. That's not the point
> of this example.
> 
> The point is that I need some structure to walk along, especially when I
> am a bit annoyed at a test case that shows that I introduced a regression
> and all I want is to understand as quickly as possible what I did wrong
> again so that I can fix it and move on.
> 
> The point is that I want a regression test case to _not_ distract me from
> the essential part, ideally I should be able to ignore all the set-up code
> and deduce from the command-line of the failing command what is going on.
> 
> For example, if the test case fails in the line `grep fast-forwarding err`
> above, that command-line alone does not tell me anything, it just
> frustrates me. If there is a comment above that line (which is ideally
> part of the `-x` trace, that's why I used `:` instead of `#`) that states
> the intention in what I consider to be clear, simple English, it is a lot
> easier to figure out what the heck is going wrong.
> 
> Of course, it would be even better if we had a function, say,
> `must_contain` that runs that `grep` and shows the file contents and the
> regular expression if that `grep` failed. That's of course outside of the
> concern of your patch. But this idea illustrates what I want in a
> regression test case: I want it to _help_ me figure out things when it
> breaks.
> 
> Ciao,
> Dscho
> 
> P.S.: Please note that the many test cases _I_ introduced into Git's test
> suite mostly do not conform to what I wrote above. I learned _quite_ a
> lot of how I want regression test cases to look like in the past six
> months, not from writing them, but from analyzing literally hundreds of
> Azure Pipelines builds. And your question forced me to think about my
> learnings to formulate the above (hopefully clear) explanation of what I
> want in a regression test, so: thank you.
> 

This writeup is great, and I think your example is very clear and
readable. I'll push a reroll with my similar-looking reformat soon.
Thanks, Johannes.

 - Emily
