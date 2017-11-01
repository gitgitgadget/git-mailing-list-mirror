Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0637B20450
	for <e@80x24.org>; Wed,  1 Nov 2017 03:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754160AbdKADoY (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 23:44:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57348 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754095AbdKADoY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 23:44:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D267BA917;
        Tue, 31 Oct 2017 23:44:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I2rLVbqmJ9745BcF3m1uXy01B4w=; b=XLXsxw
        QRJJpx7WRAZCu+6lpNDaNGu7QfWky0S0LRBhz8Vk/MvVzUZew7wMH5onFnkLu0PD
        bktKehGitR2nuYgLrupiiq8y36A0RSNSu17K8x2gdW2l5sDuOMRWHgLGbtdjNmLz
        Iwv+FVFznwEgHaT1vQ7TvADbr3HIYN0H+5fl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N18jHqic5dI+D/djz267GItwUKyZPhkL
        YZjK0FGKBKqIKy2JEUPLCxOyRi7UKJivrx2qt+oMPmNJCJVQWnvmdhHT+gEV1h5u
        WwxdIybhco+OLKBFrcB6m0NmhpnuKp5oXchGajxO4RSBiGzjbeFP3Zf/aiIwjSib
        8tEVryAl/+g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 447D0BA916;
        Tue, 31 Oct 2017 23:44:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD929BA913;
        Tue, 31 Oct 2017 23:44:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
References: <20171028004419.10139-1-sbeller@google.com>
        <20171031003351.22341-1-sbeller@google.com>
        <20171031003351.22341-7-sbeller@google.com>
        <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com>
Date:   Wed, 01 Nov 2017 12:44:21 +0900
In-Reply-To: <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 31 Oct 2017 12:16:30 -0700")
Message-ID: <xmqqzi86vf1m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2F0E6FE-BEB6-11E7-972B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Maybe
>
>   "git-describe - Describe a blob or commit using graph relations"
>
> though that sounds too generic, but it is accurate as all we do is
> a heuristic for graph walk ways.

We used to describe commit using commit ancestry (i.e. finding the
place where a "wanted" commit sits in the commit ancestry graph).
Now we are extending it to describe an object by finding the place
where it sits in the graph that shows object reachability relation,
but saying "graph" without saying "graph over what" is probably not
descriptive enough for most readers.
