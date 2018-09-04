Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1991F404
	for <e@80x24.org>; Tue,  4 Sep 2018 15:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeIDUTc (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 16:19:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54595 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeIDUTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 16:19:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so4983446wmb.4
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uPcMYcT1CaTyMoIuMrEsmq34J629swTFFDWnQ4aJOh8=;
        b=bK7zIkMYSzhIhw8DvW77sAkdR78SW6g6TDpexlmPte8kjchksry5Tkb3Sc5h0aID2d
         gFgCkF3w1pSzIw5mJtTok2wQbloUrrBtWAN5szzELRjuxHmgnSgnevWKiHtjh1zv4cfP
         eQRAe0VI0cADbRLP7aQvZHo/NS6ie41Nrol3s3KrcCERK/tBYgRUdgtJai05GRrFKfF2
         3QkbVFbYz3raU1nEq2k7t8LNwoJ4Opwc5b/fPRZUxFqy/+pId+75BsJb/X/ZBNyz1FWk
         KnyaADgQO+TfMizWScHYCMhxSLVPjhUIZwQv+3JRXvV8hG95ViXLXnsjXKSSsfhtBXof
         sBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uPcMYcT1CaTyMoIuMrEsmq34J629swTFFDWnQ4aJOh8=;
        b=MTpi2WeAQ4juudOIhpTbyiNel/M4u6lebcCeiM/e13j8TuTqfVUx+UKPVW/IRQvfTx
         YKeb32Z+pQCoAfmzYzpsfLrsJdxAtGujgie5CYEHviXajCd0CPFxT9Aokt1+Yxiq4MPr
         RdT4Bml1MzoU/DbFuLv5WAVrwkuhcpnNkSQud84mpy8jGnZi+1gbyLK8AimR3EsDsb2/
         wFjtHn/MeTZ03+RA43lOG0h1lie4lJlhYX0izZvFsiK59TaKqS8oMXt6uhPbq+fPwvKr
         j9uPCSGcxfwbVcx65viGfMfuSt0RdWSVvki74bnjpcaxQ9Y7nYFx1a+uTREy2Qfq+6pw
         W49g==
X-Gm-Message-State: APzg51A8WvPbvdyc0TY9FLzoFnoAe3EvBx6QKSJS6VN3mDmGGGj7RStZ
        Clo6+RQhE1rGI8L6Q1E9Wa2WQXx4
X-Google-Smtp-Source: ANB0VdZiakyZr/Dei78rwiUjI1AcROGKtCX5phV4rYgXXB2arTAKnkbKv7ZH9jUrGH/kcC9+TO4Z7w==
X-Received: by 2002:a1c:dc85:: with SMTP id t127-v6mr260489wmg.164.1536076428196;
        Tue, 04 Sep 2018 08:53:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 75-v6sm32274711wml.21.2018.09.04.08.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 08:53:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
        <20180816155714.GA22739@sigill.intra.peff.net>
        <87bma2qcba.fsf@evledraar.gmail.com>
        <87y3clbcqf.fsf@evledraar.gmail.com>
        <20180902074656.GB18787@sigill.intra.peff.net>
        <20180902075528.GC18787@sigill.intra.peff.net>
Date:   Tue, 04 Sep 2018 08:53:44 -0700
In-Reply-To: <20180902075528.GC18787@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 2 Sep 2018 03:55:29 -0400")
Message-ID: <xmqq7ek1cl87.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That code isn't lib-ified enough to be run in process, but I think the
> patch below should give similar behavior to what fsck currently does.
> We'd need to tell index-pack to use our fsck.* config for its checks, I
> imagine. The progress here is still per-pack, but I think we could pass
> in sufficient information to have it do one continuous meter across all
> of the packs (see the in-code comment).
>
> And it makes the result multi-threaded, and lets us drop a bunch of
> duplicate code.
>
> ---
>  builtin/fsck.c |  53 +++++++------
>  pack-check.c   | 142 -----------------------------------
>  pack.h         |   1 -
>  3 files changed, 32 insertions(+), 164 deletions(-)

The numbers here are nice, even to readers who do not necessarily
care about the progress meter output ;-)

