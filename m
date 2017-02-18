Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 432AC201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 05:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbdBRF4F (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 00:56:05 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36168 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdBRF4E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 00:56:04 -0500
Received: by mail-pf0-f194.google.com with SMTP id c193so798610pfb.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 21:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RrN0hSG2wzXfb7ClYT+QXQb+l5dBukdyhrqjSy7Wbqk=;
        b=jetlV5eBawSdYKsZogsXyApUs6J8vAPzUexn98d97CLgIubqzYjLiQV0HAnloe/SKu
         d/ika8VdTCmrx0uoEkNV/vELJMQQgRS3NRPSfUNPtk8A49zuaMrNDQIHCWFRAypSHldO
         Oe92JFga4Y/xOpf4lXAKEjY10JrRUGDXHRN1eaxF4E3sRxzvZd2O5Brfutd5nWBk7cT2
         iagKiv/wfX0na1ht/UA+lm7qBVeKcDIyQcXhf3K7DRaa9x16Q+ce3KqmPWyUTVRUb9TT
         Dzt0cWprwI3fElYAlJQKH/8FM8mBZVpXoTwt3Qa4+qZSYfxr2qG5P6H+EyIKUa0s4vXA
         tFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RrN0hSG2wzXfb7ClYT+QXQb+l5dBukdyhrqjSy7Wbqk=;
        b=oAV1eXjUFYiCG1ubUAaTQTgYQzKdbhlGAl3exc9YS17oUH96AvFF38/2kCT0gwDJH8
         c7cyTmzkUDG9K6xm4YY2LeKYOboIFl+61zrV3NXMuktpOaM4eFmfdduR9Rw2q5zuL/yI
         l/qHAXCDU5FJqDBjw+0mCvhnHIExR0dPCL1RdHfh/c03mrRWdMNbWTUggEjjPqVcRxmO
         gWVMV5EsB1z4jJPCPfckUJTRAZiVlDP/lH+e274gpH05f6W61NfNWiq3lS3nR9QEU4PL
         Z9daTGVL8gqdSie3kRP7MdvWw7OYYhGPc5gfSMYJ6INQ6e8l442t65qz2QzL/LT9GARq
         R8/Q==
X-Gm-Message-State: AMke39nYdgAcI0aSb/cS9YhkeCw0bzbxSkPFExQCOrZbgir3I1k92ikaNQAge1cmx20gLw==
X-Received: by 10.99.219.21 with SMTP id e21mr14652922pgg.29.1487397363983;
        Fri, 17 Feb 2017 21:56:03 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id 66sm22674976pfx.29.2017.02.17.21.56.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 21:56:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/5] A series of performance enhancements in the memihash and name-cache area
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
        <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
        <20170215164416.tekykkzhm6qlj2h2@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 21:56:02 -0800
In-Reply-To: <20170215164416.tekykkzhm6qlj2h2@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 15 Feb 2017 11:44:16 -0500")
Message-ID: <xmqqvas8m499.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Feb 15, 2017 at 09:27:53AM -0500, Jeff Hostetler wrote:
>
>> I have some informal numbers in a spreadsheet.  I was seeing
>> a 8-9% speed up on a status on my gigantic repo.
>> 
>> I'll try to put together a before/after perf-test to better
>> demonstrate this.
>
> Thanks. What I'm mostly curious about is how much each individual step
> buys. Sometimes when doing a long optimization series, I find that some
> of the optimizations make other ones somewhat redundant (e.g., if patch
> 2 causes us to call the optimized code from patch 3 less often).

I am curious too.

To me 1/5 (reduction of redundant calls), 4/5 (correctly size the
hash that would grow to a known size anyway) and 5/5 (take advantage
of the fact that adjacent cache entries are often in the same
directory) look like no brainers to take, regardless of the others
(including themselves).

It is not clear to me if 3/5 (preload-index uses available cores to
compute hashes) is an unconditional win (an operation that is
pathspec limited may need hashes for only a small fraction of the
index---would it still be a win to compute the hash for all entries
upon loading the index, even if we are using otherwise-idel cores?).

Of course 2/5 is a prerequisite step for 3/5 and 5/5, so if we want
either of the latter two, we cannot avoid it.
