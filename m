Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA167C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9367F61108
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345972AbhIGSjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:39:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51037 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhIGSjA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 14:39:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEAECE5F9A;
        Tue,  7 Sep 2021 14:37:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=l76StsUSJylJ
        CPfhqVQEb33fIG672CnXxCGg1PlLAvo=; b=cRQqx5A7rh/805r05GXPXSCdGecT
        e7YOLojRype7PM7CbKiYbYg0xtvc9DNa40PER3UM0oS4tzJP/1Ozu8D/BnBs+151
        16r8mfHQmUdvBtXt0FG/7TWmZmgwNP2zAPLArAc3KjPJX/QsnIuEpH57NIqxIiBR
        bw2y5JHm+/vQ5gg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5CD2E5F99;
        Tue,  7 Sep 2021 14:37:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C6EDE5F97;
        Tue,  7 Sep 2021 14:37:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 1/7] git-sh-setup: remove unused git_pager() function
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
        <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
        <patch-v2-1.7-8eb1dfbff5d-20210906T070201Z-avarab@gmail.com>
        <55293c43-811b-b030-9512-7525f5ebfd12@gmail.com>
        <87czplnxn3.fsf@evledraar.gmail.com>
        <8912317f-7eb0-edae-29e3-2e05099bc696@gmail.com>
        <87eea0n04u.fsf@evledraar.gmail.com>
Date:   Tue, 07 Sep 2021 11:37:51 -0700
In-Reply-To: <87eea0n04u.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 07 Sep 2021 12:22:58 +0200")
Message-ID: <xmqqh7ewb5a8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B5979786-100A-11EC-A624-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> No, they need to know to call 'git var GIT_PAGER' rather than using
>> the environment variable directly to pick up core.pager[...]
>
> Sorry, I should have said "...directly via git var GIT_PAGER". I also
> see that we could improve some of the doc cross-referencing here,
> i.e. "git help git") doesn't make this explicit or point to "git var",
> but we cover this in "git help var" itself.
>
>> [...]should be checking whether stdout is a tty. That is why this func=
tion
>> existed and we didn't just check the value of GIT_PAGER in our scripts
>
> For a hypothetical out-of-tree user is this really something anyone
> strictly needs? It's just an optimization. If you don't do it you'll
> just use your pager to pipe output to a non-tty.

The question we should be asking when we advocate to remove things
is "is this really something we absolutely cannot live with?"

But answering your question, if an out-of-tree user wants to behave
just like Git, pretending that it would have been part of Git and
the only reason why it is not is because it weren't invented here,
yes, not forcing the end-user to pipe the tool's output to pager is
something they would want to have a handy way to mimic, I would
think.

Thanks.
