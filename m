Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77B320450
	for <e@80x24.org>; Wed,  1 Nov 2017 03:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754272AbdKADek (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 23:34:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62168 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754267AbdKADej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 23:34:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEC25BCF51;
        Tue, 31 Oct 2017 23:34:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PRKpyqvGOTYjE+XbW5BqBvxyDvU=; b=LLhXTb
        W4uTPQzrsyV2V+CZxagOrQPllZkSKk+4n8ZfbbpDiDQMfORnBPHIk/SxAx1vit5c
        GbkU9g4QR3h6Rzb7EOHdqDJnUPOzF4OYCQLcYl0rQoVRjnWMLMUKtWbVrxu6BsE3
        dqh0t66adI1UTVSliZ0SR51EKvgsMLugrl2ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q3VRX+29XgEMh7Z15+UjyWLG7n1eRM4K
        qEQBFk5CmqAXqd/9HCR5MejYSlkf1nnvH8dm0gKKxwbGS+U+qFCkkNAMT2gDAZa9
        GHe443H6sgBgL2TWZYJxTBXGwzNfvpEvW2RAtYfGq4ls9CG71fPWdz8Xk5txxFWT
        fip4IZSy7sE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6E62BCF50;
        Tue, 31 Oct 2017 23:34:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20659BCF4F;
        Tue, 31 Oct 2017 23:34:38 -0400 (EDT)
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
Date:   Wed, 01 Nov 2017 12:34:36 +0900
In-Reply-To: <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 31 Oct 2017 12:16:30 -0700")
Message-ID: <xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96811AD4-BEB5-11E7-9E65-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>  Given the difficulty in
>> coming up with the single-liner description of what it does we saw
>> above, I suspect that splitting SYNOPSIS out into two very distinct
>> operating mode might make it easier to read.
>>
>>     SYNOPSIS
>>     --------
>>     [verse]
>>     'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
>>    +'git describe' [<options>...] <blob>...
>>
>> Then this additional paragraph can say "When describin a <blob>",
>> without using a (technically nonsense) phrase "if <commit-ish>
>> refers to a blob", which is never true.
>
> ok, do we know about 'blob-ish' as a term?

No, and I do not think there is any need to say -ish at all for this
use case.

After all, when we accept a <commit> when a <tree-ish> is called
for, that is only because there is only one way to use the commit in
place of the wanted <tree>; we take the top-level tree contained in
it.  You cannot say you take <blob-ish> and take a <tree>, as it is
unclear which entry in the <tree> can act as the substitute for the
wanted <blob>.

You accept blob object name in this mode, so just saying <blob> is
sufficient.
