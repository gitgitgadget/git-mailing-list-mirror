Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14EB01F597
	for <e@80x24.org>; Sun,  5 Aug 2018 06:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbeHEI0q (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 04:26:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45377 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeHEI0p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 04:26:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so4724532pgq.12
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 23:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xXKtV1ROBXFGwTQCFpC2rm/ZXWgoYvivhKO54Q7CFtg=;
        b=V5WDHLCMN1zHDKEs16qC1Mq+0hEQiZQbJhEn2MBqVDEzs1OMgJcpMETQ6r8t38+RXD
         JL2L1Su1BWIPSGy5XZWOz1lf0I2E+44oAqvHFJmT5wt3/I794TARvu2MWpKKxS+2vtbs
         AFK0VzKKZWxl3i7QzpMSWzrQ9/teZmlBaSZplpNmWbFqgFW6P8GIckZsh/smeIDSmWRV
         Yp90kHDTqYgqTVC4Tjvug8JpTh/6uiwVR8VCL5FV6qrABCZVUJAsUdB1u0QCI2DZpH5f
         9Vy/Mhsc2KGO2nwML3rZ8NhmGJr1Xj0jb/lKTeOVUPcs7vNwEgWGGPc+eQQnarOrTj/q
         zeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xXKtV1ROBXFGwTQCFpC2rm/ZXWgoYvivhKO54Q7CFtg=;
        b=lEr8m+GFiPiT1qDjrQNDPe8PmuaLV46Gy6qAzJxuUYOndTcBGuoNSbXitAji4pkvsI
         g23xSPSL++b1vt1VkzYuOJ4ospw4ztPXhf+0pfyfQRYMcqWXKgb+G/iUhPdsaIAlb+Wo
         U4ghGk6qwU0vyPixV5HKYlTGMV+fu4B8DQ2lWZSlqfxE9D44+6M8uqK4O2aGi6AQKvqH
         hIBOcn1UB7VcQRX0uN9IBWBtditGWZEw0ec6d50oyzoxDIgU7nUjIJwd55OKrgW/URZ8
         uV6jB4ddpEmH4DJVy4tJ6j0H34SWCFw+nQhLVcRfhxSeGt0i7sP6CS1v1HRIEjnzi6Xh
         jVDg==
X-Gm-Message-State: AOUpUlF8cdUFC476tngkeMwbFRE7i6qQ6gppOwjj8+0ULtH92lGP76c3
        aCz8VmoU/+snRBtdHaMjdA4=
X-Google-Smtp-Source: AAOMgpfdpld131MmnQNOJKBiJg+UI/zI7uLRORLcn7iN/66YvAP1ufC62NHBiCxKGFegaMh+KHMEfA==
X-Received: by 2002:a65:5205:: with SMTP id o5-v6mr9916084pgp.108.1533450198322;
        Sat, 04 Aug 2018 23:23:18 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u83-v6sm31766643pfj.37.2018.08.04.23.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 23:23:17 -0700 (PDT)
Date:   Sat, 4 Aug 2018 23:23:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Chargin <wchargin@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] t/test-lib: make `test_dir_is_empty` more robust
Message-ID: <20180805062316.GB44140@aiede.svl.corp.google.com>
References: <20180805022002.28907-1-wchargin@gmail.com>
 <20180805022002.28907-2-wchargin@gmail.com>
 <20180805041956.GI258270@aiede.svl.corp.google.com>
 <xmqqftzts63d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftzts63d.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> but $'' is too recent of a shell feature to count on (e.g., dash doesn't
>> support it).  See t/t3600-rm.sh for an example of a portable way to do
>
> Is that "too recent"?  I thought it was bashism, not even in POSIX,
> but I may be mistaken.

You're right.  I got a little ahead of myself: it's not part of POSIX
yet but is likely to be so once the details get ironed out:
http://austingroupbugs.net/view.php?id=249

> Quite honestly, our tests are still run inside a sort-of controlled
> environment, so if it _requires_ use of things we have avoided so
> far, like "ls -A" and "xargs -0", in order to be resistant to
> funnyly-named files like dot-LF-dot, I would say it is not worth
> worrying about them--instead we can simply refrain from using such a
> pathological name, can't we?

The "xargs -0" is a bit of a red herring.  That construct is
definitely not needed for the test it was used in.

For "ls -A", I agree with you that the benefit is not very high, so
the cost would have to be pretty low for this to be worth it.  But
given the lineage of "ls -A", I feel there's a chance that it's
widespread enough that it would meet that bar.

> "ls -A" may be in POSIX, but our attitude generally is to avoid
> saying things like "it is in POSIX so it's your platform's fault
> that it is not yet supported".  We instead say "even it may be in
> POSIX, in real life many people don't have it, so let's avoid it".
> And "xargs -0" I do not think is.

Indeed.

Thanks,
Jonathan
