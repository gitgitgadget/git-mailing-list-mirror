Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2001EC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1012072F
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LB00VFqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFKB45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:56:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52430 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFKB4x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 21:56:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3960C04F2;
        Wed, 10 Jun 2020 21:56:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1WERMRCFYAJn
        /vK5NNkaNzDterM=; b=LB00VFqrdYiPPuuVGX6ei76MWmhCsWDIE2yZf6y8hbXu
        cH7Q6LXV9AEfMtRYgxxDYz2L0RrdZXbj0n95FNcLRexR8qax7wYmvhY6dwSC4qpR
        7j0f7KwkUK8MqwA2FG/xuKlRYba/+Jk9b9srus1psokKKhAAJEJwg0SWc3kDSoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UM9jvB
        g8yIdsIzt6xWRANVcehg72LtxYfjt25kk+KQkFiAHSr40u2uOWWP17qincp7MkbH
        zhQ6xooYW2I3iuwPjNNG5aCeeBAdyq9jzLzzNyuqbtilQJIIZGU160fnsVkkRzKc
        +rQasb7dmZC3Zm+DlXJyEKSXAuXbUQoth8fRw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC81FC04F1;
        Wed, 10 Jun 2020 21:56:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 30C20C04F0;
        Wed, 10 Jun 2020 21:56:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2020, #02; Wed, 10)
References: <xmqq7dweebnl.fsf@gitster.c.googlers.com>
        <CA+P7+xpMp1Zu6UAoN=uebZ-KOjuhSAJTTnCyHMPxZENweMvCjQ@mail.gmail.com>
Date:   Wed, 10 Jun 2020 18:56:47 -0700
In-Reply-To: <CA+P7+xpMp1Zu6UAoN=uebZ-KOjuhSAJTTnCyHMPxZENweMvCjQ@mail.gmail.com>
        (Jacob Keller's message of "Wed, 10 Jun 2020 17:16:16 -0700")
Message-ID: <xmqqbllqcqlc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0048EEC-AB86-11EA-AC72-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Jun 10, 2020 at 4:40 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
>> * jk/complete-git-switch (2020-05-28) 16 commits
>>  - completion: improve handling of --orphan option of switch/checkout
>>  - completion: improve handling of -c/-C and -b/-B in switch/checkout
>>  - completion: improve handling of --track in switch/checkout
>>  - completion: improve handling of --detach in checkout
>>  - completion: improve completion for git switch with no options
>>  - completion: improve handling of DWIM mode for switch/checkout
>>  - completion: perform DWIM logic directly in __git_complete_refs
>>  - completion: extract function __git_dwim_remote_heads
>>  - completion: replace overloaded track term for __git_complete_refs
>>  - completion: add tests showing subpar switch/checkout --orphan logic
>>  - completion: add tests showing subpar -c/C argument completion
>>  - completion: add tests showing subpar -c/-C startpoint completion
>>  - completion: add tests showing subpar switch/checkout --track logic
>>  - completion: add tests showing subar checkout --detach logic
>>  - completion: add tests showing subpar DWIM logic for switch/checkout
>>  - completion: add test showing subpar git switch completion
>>
>>  The command line completion (in contrib/) learned to complete
>>  options that the "git switch" command takes.
>>
>>  Is this ready?
>>
>
> I don't think anyone besides you has reviewed this, and no one has
> commented on the most recent round. I believe this is ready, and in my
> day-to-day experience while using this has greatly improved. However,
> given that no one else has reviewed it...
>
> Based on a quick blame it looks like some of the most recent
> contributors who might be good persons to review this include SZEDER,
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, and Jonathan Nieder.

Alright.  Unless I hear otherwise by a few days, I'll plan to merge
this topic to 'next'.

Thanks.
