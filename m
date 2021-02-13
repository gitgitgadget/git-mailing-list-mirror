Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76215C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C63264DEB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 14:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBMOjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 09:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBMOjt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 09:39:49 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66914C061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 06:39:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id w1so4106125ejf.11
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=P3ZTyyP7fZboTps2vh45yYWwPCm0CfSD4K71pcV2w1o=;
        b=LncNOSIW+7g79DQqftPOOWeSJdMHw3O7dpJ5hLVwdlEmDmT4TLC1C/kWQf8R+4jfvD
         nH3lecj/GEJ51m9/j+MB+2PS8jrkeuCUkKVpqPkq/F45/dlBJBz53L7gfEASpGmOuRFJ
         cmR4SR4xdD4yjlBRErPNUr6AuK/f75swdUzJ8jn6/3mtvNhpCewX97QAFa4IAIfDCzkL
         oGKjuml+aitbjE6RSXwDwC80moGX7hTpbDMuXedW2flCQpmq2rC7t1SJs56lzgASWUQc
         GqDZDVYhrVbhk08p+cgTTjCanJXbTE286325JFq+R7TJMIDFtBukmfYRAlaZr7PXnp0N
         OT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=P3ZTyyP7fZboTps2vh45yYWwPCm0CfSD4K71pcV2w1o=;
        b=GzYk3jKgMUk6IDplmAJQ22g09b0Uq0+mmwzTVpW4T8tElvuJokrCEF7xffmW+m6Jqk
         xaOnlXTXTByncVAhCFfYVR0uOo9exvDXxBsltqsVL0OuCcC8/CfiDgU1BKtXz0edv/qQ
         Wm5ptJEzsVPiWFDxBYg+bHi2VCLyLuOBPfVMSLPjJOu2O38rU/iIKaAvhCTdnq85/m+w
         0xhrsyACuLdEZv5Ta81BzCuSrpEBhJLuPsnvWJGpXMkVyim98O66mwXNf7VHaexo046K
         JplOg8jRHqSDkmnVnBSplbrzDanAHokLIRVHueN12beeV8wRQZd9ickZpba+3i3X4StO
         LSIw==
X-Gm-Message-State: AOAM533WUqRkaUsjlPVQi+8LnLKUDoRp8io++CNWl0jFRMZbFAbT6F10
        /l4KaBm9os6KNJwHkykCrHs=
X-Google-Smtp-Source: ABdhPJydB5fJnN6D1kA7zKZLsXC9kYfv0WmYLOn7DHX801mutmngIMb8P20ugUdN+qyejwk94J7jdQ==
X-Received: by 2002:a17:907:2bef:: with SMTP id gv47mr7796556ejc.457.1613227147024;
        Sat, 13 Feb 2021 06:39:07 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id bw22sm359844ejb.78.2021.02.13.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 06:39:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 12/12] test-lib-functions: split out {debug,path,text}
 helpers
References: <20210209214159.22815-1-avarab@gmail.com>
 <20210209214159.22815-13-avarab@gmail.com>
 <xmqqpn18yee4.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2102112317330.29765@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <nycvar.QRO.7.76.6.2102112317330.29765@tvgsbejvaqbjf.bet>
Date:   Sat, 13 Feb 2021 15:39:05 +0100
Message-ID: <87zh08av7a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 11 2021, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 9 Feb 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>> > Split out the debug, path and text miscellaneous helpers into their
>> > own files. The "test -[efsd]" etc. helpers were not all in one place
>> > in test-lib-functions.sh, I think moving them into their own file
>> > makes it easier to follow the code.
>>
>> I'd prefer not to see this done.  It would be fine to move them in
>> different sections but still in the same file to group related
>> helpers together, but I am having enough trouble when deciding to
>> look into which between test-lib.sh and test-lib-functions.sh in the
>> current organization already.  And it will make the situation even
>> worse if we did this, no?
>
> As much as I would love to see a better organization, I agree with Junio
> that this split would make it more tedious to find the correct function.
>
> I had a look over the rest of the series and like what I saw, leaving only
> one or two comments.

Junio / SZEDER / Johannes: Yeah I agree that that 12/12 sucked in its
current form.

Having eyeballed test-lib.sh and test-lib-functions.sh as part of this
though there seems to be a pretty obvious way to split this up which I
think would increase the readability:

 * test-lib.sh: main entry, reading/setting global vars/state,
   command-line parsing (and other CLI / Makefile interface), loading
   test-lib-functions.sh, set global prereqs, actual setup for the test
   about to be run.

 * test-lib-functions.sh: the top-level "library" used everywhere,
   i.e. test_expect_success/test_expect_failure etc, Hopefully we could
   move the internal functions like test_ok_, test_failure_ etc. from
   test-lib.sh to test-lib-functions.sh (they need some global variables
   in test-lib.sh now).

   Also things part of core test "flow" like test_config,
   test_when_finished, nongit etc.

 * lib-common.sh: what I was trying to start with in this 12/12,
   i.e. utility functions common enough that we want them
   "everywhere". We'd just have test-lib-functions.sh load this.

That seems like a much more obvious split & organization to me than the
mis-match with a bit of everything everyhere we have right now.
