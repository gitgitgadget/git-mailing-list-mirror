Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D17520193
	for <e@80x24.org>; Mon, 24 Oct 2016 20:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941009AbcJXUDR (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 16:03:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55793 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933409AbcJXUDR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 16:03:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 952E245674;
        Mon, 24 Oct 2016 16:03:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=vo9vG5AufKWzPYNVR9354GjVssc=; b=YLBbVr1ouZ52hY0l+zly
        cC+tXqS9+UcYtl/m/XDwV5w4kI8a+mIcW5p67RxNuLpA9YLrwx1o1+wNZO+oUNBe
        Cfsuur3CrpD1f6OxDt1UQYRolfgy4nqXRwv+XN8JkHkscQ+uKniAIQSFnFlVpHg0
        VKKpuGwW45Yp2mM66Gnz+JM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=D8g6Xjlfqiu0QKjTFJeDNEhtrw9pPwa1cEBAKTmMsy/JgZ
        tcROdoOv50lZkBHO5G+ET9Fe+5P9K3D1eR5d1eKiMHBNvlogAv/Uq2R6dFiZWONr
        wP7C5QtZrISIDViVyxSPC/9rei6sS1rR75dFC8JFUpqsozY01WT2RJPnsMlZY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C3B645672;
        Mon, 24 Oct 2016 16:03:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D59745671;
        Mon, 24 Oct 2016 16:03:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase -i patches
References: <cover.1476450940.git.johannes.schindelin@gmx.de>
        <cover.1477052405.git.johannes.schindelin@gmx.de>
        <xmqqinsk8g1b.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610231151140.3264@virtualbox>
Date:   Mon, 24 Oct 2016 13:03:13 -0700
Message-ID: <xmqqtwc13472.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6101E80-9A24-11E6-A47E-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I prefer to cook it in 'next' sufficiently long to ensure that we hear
>> feedbacks from non-Windows users if there is any unexpected breakage.
>
> FWIW I am using the same patches not only on Windows but also in my Linux
> VM.

Thanks for a datapoint, but when I said "non-Windows users", I was
not referring you as "the" Windows user.  I am expecting that you
would hear from Windows users who got exposure to your series by its
inclusion in Git for Windows.  They are the ones that I had in mind
as "Windows users"---and not hearing breakage reported by them would
be a good sign.

The primary reason why we want to cook a new topic in 'next' is to
expose it to people with different workflows using it on different
things, and that is especially more important for a change that
affects features that are flexible and can be used in different
ways---the set of options and commands used by the original author
of the series are often different from other people's.

Any change, when it hits 'next', is expected to be sufficiently
tested by the original author [*1*], but that is only true in the
context of the original author's daily use.  Both reviews and
author's tests are not sufficient to find bugs [*2*].

Topics that touch parts of the system that are more important to
users' daily Git life deserve extra time to find any unexpected
breakage in them.  Windows users are participating in that test by
inclusion of the topic in the released version of Git for Windows.
I want to see the the test for the rest of the world done by early
adopters who run 'next' (as 'pu' is too scary for daily use).


[Footnote]

*1* And me, as topics geting ready to be in 'next' are first merged
    to my private edition branch that is slightly ahead of 'next' to
    be used in my everyday use, but just like the original author is
    merely one user, I am also merely one user with a specific set
    of workflows that is different from others'.

*2* Bug finding is not the primary purpose of the review in the
    first place.  It is to find design mistakes both at the external
    and internal level, and bug finding "here you have off-by-one"
    is merely a side effect.  End user tests may expose the former
    (e.g. the design based on a wrong assumption may not accomodate
    certain workflow the original author and the reviewers failed to
    consider while writing and reviewing), but no amount of test
    will uncover the latter (e.g. internal API that is misdesigned
    will make future enhancement unnecessarily harder).

    I think it was one of the achievements of the review cycle of
    this particular series that we got rid of the _entrust() thing,
    for example.  That had no visible external effect that would
    have been caught by cooking on 'next' or releasing it to the
    public, but was the kind of thing the code review was expected
    to find and fix.
