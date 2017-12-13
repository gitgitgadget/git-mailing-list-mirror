Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD13D1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 17:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbdLMRib (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 12:38:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56008 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753792AbdLMRi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 12:38:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E26BB5D56;
        Wed, 13 Dec 2017 12:38:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0u4V6Ye+zEObKrKqSUf80odRMZo=; b=r2ATQd
        Yw+pg7YLfx2RDiOi/61hCvRXmVI6/+CnXiI3XhsQyKReBU7ZGP8bK+rObao6Aq2q
        /FcZ0VLoI+sYlroAtfyvUMuFRDWO3uBkysXFa3B8eg96ukFFC9GdHVaeBJEX+vip
        6qk19RnWWnWqwkGA6C8NarUBFgn/3qXr1M5VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=axvYSWgi6As2IEIpTDip+vOg5QqOejVT
        zm3q3u292utwwk0N7PSdw4OR4VF7XqJ+Y1t0ZJXfQKWnguSmGHfniMhD3wEIfM5n
        o6FWxFgLZGEK/ncawYBzA0SoL7pu29Vbrr9AbVuGEADIfqsbk/9vFHWjZZq6F/ZE
        Sn4KsXQBLH8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55197B5D54;
        Wed, 13 Dec 2017 12:38:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2D5BB5D52;
        Wed, 13 Dec 2017 12:38:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
References: <20171210212202.28231-4-t.gummerer@gmail.com>
        <20171211210948.6867-1-szeder.dev@gmail.com>
        <20171211214255.GA24597@hank>
        <C5F93DFF-D3DF-4507-8546-941BFA768705@gmail.com>
        <xmqq609b3gi3.fsf@gitster.mtv.corp.google.com>
        <09E575DE-ED7A-40FA-9A47-0ABB61452C28@gmail.com>
Date:   Wed, 13 Dec 2017 09:38:26 -0800
In-Reply-To: <09E575DE-ED7A-40FA-9A47-0ABB61452C28@gmail.com> (Lars
        Schneider's message of "Wed, 13 Dec 2017 18:21:52 +0100")
Message-ID: <xmqq4louy1d9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D7C2370-E02C-11E7-8E0C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I think your solution points into the right direction.
> Right now we have the following test matrix:
>
> 1. Linux - clang
> 2. Linux - gcc
> 3. Mac - clang
> 4. Mac - gcc
> 5. Linux - gcc - GET_TEXT_POISION
> 6. Linux - gcc - 32bit
> 7. Windows
>
> AFAIK your solution would run the split index test for 
> 1, 2, 3, and 4. I think that is too much.

Not that it matters too much, but I meant to add it to 1. and
6. when I said "only one of 64-bit build plus 32-bit one".  

> 1 runs the fastest and I would like to keep it that way
> to get a quick "general" result. I think only 2 should be
> extended in the way you are suggesting. We could run
> the tests with different env variables there. What else
> do we have besides GIT_TEST_SPLIT_INDEX?
>
> Would that work for everyone?

I am OK to make 2. use split-index (which unfortunately would mean
we lose tests without split-index under gcc), or add 2.5 that is a
copy of 2. plus split-index.
