Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10C0B1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 18:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJDBgw (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 21:36:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32994 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeJDBgw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 21:36:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id g26-v6so6332862edp.0
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EjdWyl8pKdj51rgzG5xDnKkL9+tEN0wW6dELVbPokX8=;
        b=HsP7hWpO/X0Wo2Jg2zyFGwEfKDDOWckUhXe1+iHP4HYsaTscaWuLm/niMiUn3/mNen
         4+IDnKMUql4DT+d+9dS7IQgovl+HiGUOgxvt9PXLN20PpLpzw4dmUR3b7dp1yi2UMK/D
         z55cUE2pQSuteLz2uz7xrc0UqsX9p7VulOb6CZ/ErBcxa7v8RIZjWMRiepPUSBmae3Ww
         +aQ2yz5QyY4t4vA++WFvPwSKJ/s1hCrJ1MRQeRfXg8kjQTg3O1K0sCf0iRrEsKJA2Dny
         fLTtMfRlZoaZyMNQzR4Sr0+paDhxs/v8jxCC07oB6n2QoNLB2yWECfmOr+ujxsRqCeyF
         dFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EjdWyl8pKdj51rgzG5xDnKkL9+tEN0wW6dELVbPokX8=;
        b=dWMKqy8XJIx74XrFsnP6meZExEUGH0AnHHfM0DuSuC/vhlnGbMd/yUNooHlDkwzUIl
         qPZ4CUY8vcYLWn04Ly0qXfdaMx0BxT+bglmOShCwMmsyuzZL+FyCYzhmTPMk/GB9byGz
         Aky1mJ23UJrgz+ms0tDXYPrRc5KQ5dHoAmM8WC8GEbB4B6NQpMevIy5sv26eY3btk78U
         qVBOQL53oHw6bmxZL9DVtnSFRGU344nqLuEuya2Fwlz3cNV3k5HEmR85nZxiS9JbtQXa
         P4LMyvb7ocBwbB0PHpo07EuLNi5PQM5g7b4gu7pldx3i+3MfW2Pt4Defko21RcP5qDlm
         Dprg==
X-Gm-Message-State: ABuFfoggyFhXddH2/9O8chcctzrE31GFPZA3BwN0OMLn4Akhnfwz4mdT
        BGto0z13BLmiawcWT7SkeHw=
X-Google-Smtp-Source: ACcGV63+9Y0PItLlZgNgvPYMKs4daSz6Ppj/eF3FU1K4Kix0stFZsjhrozQMsR9w6Jy+/bsmRPYNjg==
X-Received: by 2002:aa7:d441:: with SMTP id q1-v6mr4266241edr.26.1538592434641;
        Wed, 03 Oct 2018 11:47:14 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id x14-v6sm794665edb.84.2018.10.03.11.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 11:47:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com>
        <20181003133650.GN23446@localhost>
        <87r2h7gmd7.fsf@evledraar.gmail.com>
        <20181003141732.GO23446@localhost>
        <87o9cbglez.fsf@evledraar.gmail.com>
        <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
Date:   Wed, 03 Oct 2018 20:47:11 +0200
Message-ID: <87lg7ehnps.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 03 2018, Stefan Beller wrote:

>> So we wouldn't be spending 5 minutes repacking linux.git right after
>> cloning it, just ~10s generating the commit graph, and the same would
>> happen if you rm'd .git/objects/info/commit-graph and ran "git commit",
>> which would kick of "gc --auto" in the background and do the same thing.
>
> Or generating local bitmaps or pack idx files as well?

I'm less familiar with this area, but when I clone I get a pack *.idx
file, why does it need to be regenerated?

But yeah, in principle this would be a sensible addition, but I'm not
aware of cases where clients get significant benefits from bitmaps (see
https://githubengineering.com/counting-objects/), and I don't turn it on
for clients, but maybe I've missed something.
