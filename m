Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59BF1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfGaPsj (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:48:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59450 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfGaPsg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:48:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D19277D676;
        Wed, 31 Jul 2019 11:48:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qZ0bo/0oaQx6k0B7gffkRNMq3FY=; b=nL6vnl
        Zn9qE/uG781ju3RPrba9rmWmfvQF2zPHlba9QELKHg22FN8ktnoGkngykRr4A5ri
        kxFswNPjgBSwsV2P8RMVPdCFEbfTscv302F4onAXiHlk/R5D3hMEtg/bdqu6iIwX
        Fyw6JgL5fH3m/yfLrBvG3ltq04HsyaqPmgz9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NDEVWsS1WCByZi2sXc5DSvAcAFRE40Ze
        f7VHLIC5pkbYju3dfDB3Ro+LZyFvcRJkyxqyIpum/Nd1EoPe6lrw2HROujDHtipQ
        Yh6IhsqQVM6Mb/snpuIhFdOFJjnEWgPrL2zX4onlmrjmzSYJGpCxLFdjoJoaNUBf
        +94cKCKxACU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C970F7D675;
        Wed, 31 Jul 2019 11:48:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E98407D674;
        Wed, 31 Jul 2019 11:48:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/5] repo-settings: add feature.manyCommits setting
References: <pull.292.v2.git.gitgitgadget@gmail.com>
        <pull.292.v3.git.gitgitgadget@gmail.com>
        <c0129066a02b39535110ae592c16ca0e5d6d6c24.1564515324.git.gitgitgadget@gmail.com>
        <xmqqh873s0jy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907311515210.21907@tvgsbejvaqbjf.bet>
Date:   Wed, 31 Jul 2019 08:48:30 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907311515210.21907@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 31 Jul 2019 15:17:59 +0200
        (CEST)")
Message-ID: <xmqq1ry6ryr5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6714F5E-B3AA-11E9-8238-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 30 Jul 2019, Junio C Hamano wrote:
>
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > +#define UPDATE_DEFAULT(s,v) do { if (s == -1) { s = v; } } while(0)
>>
>> [...]
>>  3. When we learn to set default values for variables that are not
>>     boolean in the future, we will regret that we did not name it
>>     UPDATE_DEFAULT_BOOL(slot, value).
>
> On the other hand, as we never promised any kind of API (and this is not
> even an internal API to begin with), it will be _easy_ to rename it in
> the unlikely event that we would ever introduce non-boolean defaults to
> override, wouldn't you agree?

I agree that it is easy to say that it is easy to rename it later
and burden somebody else with the task.

I know that the renaming itself is easy, when you limit yourself
within the scope of a single topic, whether done now or later.  I
also know that having to worry about other topics in flight has
non-zero cost.  I also know that you are not the one who will bear
it---I will be.

So from my point of view, if we can make a prediction, even with
limited knowledge that a name may need to be renamed in the future,
it is better not pick such a name and instead use one that we think
it has a better chance of surviving without needing a rename.

