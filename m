Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25722C2BB9A
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4C322CBB
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgLOVAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:00:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57892 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgLOVA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 16:00:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A3489D3F3;
        Tue, 15 Dec 2020 15:59:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TcPEu8pDhJ6mwV/CMoZVHqlyuVU=; b=hXxWq9
        6GmMq+AVCXWHUudsoLBtBTR3eXN3CV4h5gCiMZlMO5VD39CPzPOu84/MfuC7byBN
        HX1o1zFB/Lb7h+z9woKvWlMawOmWFXLGVGtmZrny3WhLprZumAzFnwWZEK0zCvLr
        Zw2GR+v+g99CwugxMFOmY8BTiI1HfSyC52CYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LdCLhCo/dUmu1Vj1nwX5iSaEAGR1IERF
        3+lMvnbJD21fsCMrsZEm5OATNIWJjc3qVCZNZIxN2bJ+lxjLghwcxVibQo8yNmU2
        2LrPz2Aba0ZqjRR8wKN8nsKXnLwCaeCo9K6R+bU3Gp4IUk09R5UuG2KrVrT+VHXO
        /NXc18ZeHzY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01E619D3F2;
        Tue, 15 Dec 2020 15:59:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81B279D3F1;
        Tue, 15 Dec 2020 15:59:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/init-defaultbranch-advice, was Re: What's cooking in git.git
 (Dec 2020, #02; Mon, 14)
References: <xmqq3608duhp.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012151708110.25979@tvgsbejvaqbjf.bet>
Date:   Tue, 15 Dec 2020 12:59:39 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2012151708110.25979@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 15 Dec 2020 17:09:10 +0100
        (CET)")
Message-ID: <xmqqczza945g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72F77F54-3F18-11EB-A547-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 14 Dec 2020, Junio C Hamano wrote:
>
>> * js/init-defaultbranch-advice (2020-12-13) 4 commits
>>  - init: provide useful advice about init.defaultBranch
>>  - get_default_branch_name(): prepare for showing some advice
>>  - branch -m: allow renaming a yet-unborn branch
>>  - init: document `init.defaultBranch` better
>>
>>  Our users are going to be trained to prepare for future change of
>>  init.defaultBranch configuration variable.
>
> Do I understand correctly that you won't consider this for v2.30.0?

It is not even in 'next' yet, so it is too early to decide if we'd
keep it in 'next' until the final, or we'd like it so much that we'd
merge it to 'next' and then down to 'master' before -rc's.

So, no, you do not understand correctly.

I have the latest from you, I think, and I do not recall seeing
anything fishy in it myself, so I am leaning toward merging it at
least to 'next', but I do not know right at this moment how strongly
others support its inclusion in the upcoming release.

Thanks for pinging.
