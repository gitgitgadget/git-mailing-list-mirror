Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD95211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 22:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeLZW3T (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 17:29:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38691 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeLZW3S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 17:29:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so16187036wml.3
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 14:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HGF6DQAYWIzHOyaNXvoL/s4cA3CUucj76nx7WVibMFs=;
        b=ZNTZzrtU52CKY9mixO4yazJtfpaLsX02+ebxMZxvpc8WME0bGM/D9i8dX0c8gBMy4H
         /W0MwN+rwMHQI91Rrtbrpa4JxrKfZkeipxtSSzptDYiuQjDW/Wej/Jnbus0FtI/+9UIF
         jDJndhGl7B9EUC4Ew3ll3zNXKAsPLrgqpHVBLuQC5MFaBwSuXkJ88V9Wn5P8wETcqYEn
         62mNYs0daUpbu2cSXtYA/mkGsQMtjcAA4vzfygAEkiB6MBjcN4L9RNSaWM8rYU6oIwcF
         IK/ZsRBrb6VZaWCimJKpt698yfw3yf42BZ/30s+OaiZgFdj2dq0fkJJpLl5FZPH4kkfe
         4UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HGF6DQAYWIzHOyaNXvoL/s4cA3CUucj76nx7WVibMFs=;
        b=MvBU1zUCAvIq/qr0Zz8F6tt9FIGMhWp1Ai1Bl6rXZn/AaXZpFcDMpMQ7JnuhOWSpoW
         fB7x2gQwpirEvMVDso6orFF593T0oLCtyhPtKhSu37aHQMtIGEBZ2AcO+Rvr0MTMfUIB
         zLymyXp3q+Ooe6HMNrsitGMzq5mQ2CdjUnNm95qjfeuTbgz2pY+KKHp/kVSQaaDx2zeJ
         CCcx5+x+1Op7gyhmlRRQaewBzXOra8POgtSyvsH64EokF126/65hGoaH2BxXDT0PXm5C
         nkLFwUS194MAUCgXm5PvyqkIPPw5+bTUlgM36beYOcmiiEDqNFGEASExiA8jN/+9COls
         wE9A==
X-Gm-Message-State: AJcUukd8PrD5qhSQeeXqHm+2OVsBKyZZ1eGVxFFI65l403SGXUEkpqRV
        yoKN7sJ4DfnPPgEJLB9KNf4=
X-Google-Smtp-Source: AFSGD/Vq7FogoR+YxGKs3FlZ1U6P5M8+8DUAdKjcKceQHVlI5iaDvW6NSf5v8EFp4dLc5xssWMLlOA==
X-Received: by 2002:a1c:4301:: with SMTP id q1mr19034974wma.44.1545863355135;
        Wed, 26 Dec 2018 14:29:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f14sm28107587wrv.56.2018.12.26.14.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 14:29:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/3] Add commit-graph fuzzer and fix buffer overflow
References: <cover.1544048946.git.steadmon@google.com>
        <cover.1544729841.git.steadmon@google.com>
        <20181218173539.GA31070@sigill.intra.peff.net>
        <20181218210551.GG37614@google.com>
        <20181219155107.GD14802@sigill.intra.peff.net>
Date:   Wed, 26 Dec 2018 14:29:14 -0800
In-Reply-To: <20181219155107.GD14802@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 19 Dec 2018 10:51:07 -0500")
Message-ID: <xmqqbm57rkg5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Dec 18, 2018 at 01:05:51PM -0800, Josh Steadmon wrote:
>
>> On 2018.12.18 12:35, Jeff King wrote:
>> > On Thu, Dec 13, 2018 at 11:43:55AM -0800, Josh Steadmon wrote:
>> > 
>> > > Add a new fuzz test for the commit graph and fix a buffer read-overflow
>> > > that it discovered. Additionally, fix the Makefile instructions for
>> > > building fuzzers.
>> > > 
>> > > Changes since V3:
>> > >   * Improve portability of the new test functionality.
>> > 
>> > I thought there was some question about /dev/zero, which I think is
>> > in this version (I don't actually know whether there are portability
>> > issues or not, but somebody did mention it).
>> > 
>> > -Peff
>> 
>> I've only found one reference [1] (from 1999) of OS X Server not having
>> a /dev/zero. It appears to be present as of 2010 though [2].
>
> Thanks for digging. That seems like enough to assume we should try it
> and see if any macOS people complain.

Our tests have been relying on /dev/zero since 852a1710 ("am: let
command-line options override saved options", 2015-08-04) that
appeared in v2.6.0.  Anybody who has trouble with /dev/zero now has
kept silent for about a dozen major releases, I think, and will be
silent with this one, too ;-)

>
> I do wonder if we'll run into problems on Windows, though.
>
> -Peff
