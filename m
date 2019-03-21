Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B425020248
	for <e@80x24.org>; Thu, 21 Mar 2019 02:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCUCRt (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 22:17:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36406 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUCRt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 22:17:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so1135845wml.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 19:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eOR60u7bRPHevNc1yLogoGGAhvBayMibMwIErHsqcWs=;
        b=Z1uv1nOCodt2d3tkjDoY/MjBFa4wZrwiJXKYYhA2n1t/SS7QUf88H+XaH10FqEA8o9
         U9C7sDAGGRYBOQvqAjSM+1FZBVqN1dR1RvJ+mGEimDDx8oGbzD39X0hlokmhn3cBCZLs
         uFrgRMRmCJsx08aoAMOg/t2euwICqOzkvdHgkf0d14BcxQYrsyl0/5UJvONCUcyCgDZs
         OwSf5auBjs8QbDSAlrFNI34Us2dhZQK5dnSM2GcyEO1M/ketySK/gpE+OpomVyAyle9j
         GU1lkmgwNC8kQbqpNbcaVBs6z/FMEgYkQ/OrXOYG/+ZYEoKhoG15HDehBu4ymEhwVEIm
         jTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eOR60u7bRPHevNc1yLogoGGAhvBayMibMwIErHsqcWs=;
        b=g8r4TKgyR8B9B/ZXXlG+iq03xe3E3GqtAeKVAhde6A/QGRETBIfJOsj0ep3Fza7sdN
         yz1d97AoTjjmCOCqHTqw54oiVMsgljpGPvCeor4uMR1BDjFDQy6LJSvcLbPRi9tARP9e
         +MAmIIA1XH6BkzbpiQgkPafHk9sk/u7O1nLbBh5rP5m37ZK+ir5XKFFAZynFLrDpfnKk
         k4FCDXmRzwVu/uCLQ/CIrGFso/LUGYmh4xXBy3nCWAG5gmi8wVosBcpTk0Tpy7Uoamoq
         CZYyqiuxf3qp51iJ3+CE3iTo/bUq1rd2Amxjg5nFKfxwohfQGj4duZaexWsMLV5s2L2q
         p3Tg==
X-Gm-Message-State: APjAAAXfDgNGdgq0p5zUH52up3QJxaUU0E55sfDo9GJ0P8XdLm56HupA
        oaUsrgMJL1owSB14Xw8plH4=
X-Google-Smtp-Source: APXvYqybe6mU4heFd0MY7klzqZLW8e1zMAwnT1IrDYBko3xg3ew6l20j//Y3bWmsV4PUuIx1R82PKg==
X-Received: by 2002:a1c:3c02:: with SMTP id j2mr799696wma.72.1553134667117;
        Wed, 20 Mar 2019 19:17:47 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j3sm12151973wrg.54.2019.03.20.19.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 19:17:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
        <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>
        <871s31vjo7.fsf@javad.com>
        <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
Date:   Thu, 21 Mar 2019 11:17:46 +0900
In-Reply-To: <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 20 Mar 2019 08:39:16 -0600")
Message-ID: <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This worries me that it'll lead to bad surprises.  Perhaps some folks
> cherry-pick merges around intentionally, but I would want that to be a
> rare occurrence at most.  There are lots of folks at $DAYJOB that
> cherry-pick things, not all of them are expert git-users, and I am
> certain several have erroneously attempted to cherry-pick merges
> before.

It was a lot simpler back when "git cherry-pick" did not accept
ranges.  You are either knowingly cherry-picking a merge, or doing
so by mistake, and because the command rejected cherry-picking a
merge without being told with "-m $n" which parent the mainline is
by default, we are assured that the user knew that s/he was picking
a merge commit when we saw "-m $n".

It's not so simple in the world after we started allowing picks of a
range.  "cherry-pick -m1 A..B" did not work when the range A..B is a
mixture of merges and non-merges (which is the case 100% of the
time), as the command used to error out when given the -m option for
a single-parent commit.  Earlier we said that "as long as the $n
does not exceed the number of actual parents, let's allow '-m $n'
even for non-merge commits." to fix it.

We can just reject this RFC patch and we'd be in a slightly safer
place.  You still need to tell us with "-m 1" on the command line
that you are picking a range with merges in it.  But then I am sure
that clueless people blindly would alias "pick = cherry-pick -m1" and
use "git pick" and blindly pick ranges here and there, so I am not
sure such a slightly-more safety buys us very much.

