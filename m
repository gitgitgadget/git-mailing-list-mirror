Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43139C433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2057A60ED4
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhIZTXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 15:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhIZTXw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 15:23:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066F7C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:22:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b26so11394445edt.0
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Bujh/J0yFErr20AH2qibDkKCxQSDl9H313PjokihAQY=;
        b=JdRFTsoPVSbepmpwvDUSyFlFeivjox7p7gt1yA39tINP/ARllrcZYiCPE67jq6wGFh
         i8xoueCSSb/xVccTniJ4+Fc3/kPRWyCMpg43x8gJMnpZAFWiFsMcnbAT4keFOISmeFRL
         iMMRfCZvlOnzoNstX18bn8jEKzcIhiGFSCYou95zayWJKWtclCzavdouHgoa0+0W1ntF
         B+B/kOzxz7lyp/nJxFBRT3KvccjQM5TcTQIYmxBF5Iiov/4CRd9H0Mj7dvHp/e5F6w+Q
         ojjsCH711CWutQRF46TxXrkQh1VUyZaqPPwN8g1qJkeZSFo+viItWL2ERWfIom2Ow5nP
         hspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Bujh/J0yFErr20AH2qibDkKCxQSDl9H313PjokihAQY=;
        b=qdzHo/gYOsS6ANLBNhguvFTmJxM0Pbq3+uv6SC2Gsoz/NIygTBIBxTeKatmdXEeilq
         wjOBysgmmJqovQ+rPVJqvqRbar2w2+krkwnzslIs360AmUe0+P3Ym8yg3mRp6oHf9igA
         XSGLMxyZdcJLJE+GTmJ/3aMTCaD4GR/kGILV9+6dDRoXcC8K3Qps2SBExQt6fDvmoISd
         HdAr/twpc4/0GAUeIaR3JEmOHIhLQNYEFLutjdZgSHwHkU2h5UIpfi1TwGeOa2BG601N
         yOgvv0mBIjgx728fD3lGo9b95IDyvaO7AURmBC5fY7RP6q1gxlOmU8O5arHIwa0RKl/K
         aAaA==
X-Gm-Message-State: AOAM533wohcE/7gk3My+MMqO+/Rx+68tSP7E/kQgDQJ58oWppFwtAtwM
        D5r8/jDqo0jEOwmJyTCEvJ8=
X-Google-Smtp-Source: ABdhPJw/vso/UvctJj8ldz4UQEJWsugGRQk2uWiIqSTBCUYJAzk0uh6yhJxH1O+uL0Kr0xEYRUMG7Q==
X-Received: by 2002:aa7:d392:: with SMTP id x18mr19206631edq.334.1632684134550;
        Sun, 26 Sep 2021 12:22:14 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t4sm9564789edc.2.2021.09.26.12.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:22:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 01/15] scalar: create a rudimentary executable
Date:   Sun, 26 Sep 2021 21:15:37 +0200
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
 <852ec003109b8244e2f9360ec64749779989c4a2.1631630356.git.gitgitgadget@gmail.com>
 <87sfxu2kyc.fsf@evledraar.gmail.com> <xmqqy27lvoyb.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqy27lvoyb.fsf@gitster.g>
Message-ID: <8735pr2lcq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 24 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> ... the
>> usage.c API, which is generally being phased out.
>
> That is news to me.  Any reason why you think so?

Perhaps better phrased as "generally going unused where we're using
parse-options.c", although some quick historical trends I ran as an
ad-hoc show usage() standing still since v1.6.0 in number of builtin*.c
files[1], v.s. a 3x growth in usage_with_options() since then[2].

But in this case we're using an ad-hoc parser in cmd_main(), seemingly
because it ends up copy/pasting a very small part of git.ci
functionality over there, which is something that's been discussed as
something we should move over to parse_options() sooner than later.

It looks like a better approach to just use parse_options() consistently
in scalar.c, as e.g. commit-graph.c, stash.c, multi-pack-index.c
etc. that all implement a similar cmd/subcommand pattern do.

The end-state of duplicating the "-C" and "-c" options from git.c can
then easily be handled by parse-options.c, IIRC the stumbling point in
migrating over git.c was some of the statefulness of other parts
potentially needing incremenatl parsing (i.e. via parse_options_step()
and friends).

1. $ parallel "printf "%s: " {} && git grep -l '\busage\(' {} -- 'builtin*.=
c' | wc -l" ::: v1.{1..9}.0 v2.{0..32}.0
v1.1.0:0
v1.2.0:0
v1.3.0:0
v1.4.0:20
v1.5.0:51
v1.7.0:35
v1.6.0:40
v1.8.0:34
v2.1.0:32
v1.9.0:33
v2.0.0:33
v2.2.0:32
v2.3.0:32
v2.4.0:32
v2.5.0:32
v2.6.0:31
v2.7.0:31
v2.9.0:29
v2.8.0:30
v2.11.0:29
v2.10.0:29
v2.12.0:29
v2.13.0:29
v2.14.0:31
v2.15.0:31
v2.16.0:31
v2.17.0:31
v2.19.0:32
v2.18.0:31
v2.22.0:31
v2.21.0:32
v2.24.0:31
v2.23.0:31
v2.20.0:32
v2.25.0:30
v2.26.0:30
v2.27.0:30
v2.32.0:29
v2.31.0:30
v2.29.0:31
v2.28.0:29
v2.30.0:31

2. $ parallel "printf "%s: " {} && git grep -l '\busage_with_options\(' {} =
-- 'builtin*.c' | wc -l" ::: v1.{1..9}.0 v2.{0..32}.0
v1.1.0:0
v1.2.0:0
v1.3.0:0
v1.4.0:0
v1.5.0:0
v1.6.0:19
v1.7.0:33
v1.8.0:42
v2.0.0:42
v1.9.0:42
v2.1.0:43
v2.2.0:43
v2.3.0:43
v2.4.0:43
v2.5.0:44
v2.6.0:45
v2.8.0:44
v2.10.0:45
v2.7.0:44
v2.9.0:45
v2.11.0:45
v2.12.0:45
v2.13.0:46
v2.14.0:47
v2.15.0:47
v2.16.0:47
v2.17.0:47
v2.19.0:50
v2.18.0:49
v2.20.0:52
v2.21.0:52
v2.22.0:53
v2.24.0:54
v2.23.0:54
v2.25.0:56
v2.26.0:55
v2.27.0:55
v2.28.0:55
v2.30.0:58
v2.32.0:60
v2.29.0:58
v2.31.0:58
