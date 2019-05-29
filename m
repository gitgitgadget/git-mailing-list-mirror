Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F33F1F462
	for <e@80x24.org>; Wed, 29 May 2019 16:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfE2Qxr (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 12:53:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62163 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfE2Qxr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 12:53:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B218F151B66;
        Wed, 29 May 2019 12:53:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KzKSBnH1BoTtU0et4zM5VDPgMwc=; b=AbrNyn
        7QmINpdW31omZDozmqLLNhEHUzOQ6oNN3a9A9mIzlx+OOa/kWGyTp6DRgpzBjJqY
        7TE0gk46dTmYBTa/+teJAvfLWUGAQBx0YZNIFGu+57g2jE0Zi90/VTzVvEXwM+w9
        eHV9/9z9bsYcbvFhkZbzV/Ue95vMA7j/zLOiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RbjhAhbVLSg3LYplfAD3HYeYIl4KCrLg
        eIa9HTMrBIspV3N2LoMbPigcDyV/f8ePnz+GRQ0kyzaYCcsy/KyyPCPIuJq7Llhm
        1iRtngiQ2BXV2vJlhYOwgWR6lT8XnTq6pvsAv5H2Bj10h23tW+ZtzhsA20Mn8MkA
        nLHkxwzLJl4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA5C2151B65;
        Wed, 29 May 2019 12:53:45 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16558151B64;
        Wed, 29 May 2019 12:53:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2019, #04; Tue, 28)
References: <xmqqtvdez0yo.fsf@gitster-ct.c.googlers.com>
        <20190528222604.GA14921@sigill.intra.peff.net>
Date:   Wed, 29 May 2019 09:53:44 -0700
In-Reply-To: <20190528222604.GA14921@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 28 May 2019 18:26:04 -0400")
Message-ID: <xmqqlfypyzfr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 523AE318-8232-11E9-B516-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, May 28, 2019 at 03:08:31PM -0700, Junio C Hamano wrote:
>
>> Quite a few new topics, most of which are fixes with different
>> urgency, have been picked up.  Perhaps we'd need an extra -rc for
>> this cycle to squash existing regression at the tip of 'master'.
>> At this point, the criteria for merging to 'master' is *NOT* "This
>> is an obviously correct fix", but is "This is an obviously correct
>> fix for a breakage we introduced during this cycle".
>>
>> [...]
>>
>> * ds/object-info-for-prefetch-fix (2019-05-28) 1 commit
>>  - sha1-file: split OBJECT_INFO_FOR_PREFETCH
>> 
>>  Code cleanup.
>> 
>>  Will merge to 'next'.
>
> I think this one is actually a bug-fix (we are refusing to prefetch for
> "QUICK" calls even though was not the intent), and it is new in this
> release.
>
> I'm not sure of the user-visible impacts, though. There are a lot of
> QUICK calls, and I'm not sure for which ones it is important to fetch.

Hmph.  I took it as primarily futureproofing, as I didn't find a way
to trigger bad behaviour from within the current codebase.



