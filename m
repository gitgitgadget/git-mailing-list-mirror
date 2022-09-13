Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A498ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 21:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiIMVdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 17:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIMVdr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 17:33:47 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A24461113
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 14:33:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54107145A74;
        Tue, 13 Sep 2022 17:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NJEFBEkgJPGd
        joqU72siX2UOLL0DMvPhCm9JLlqoyAI=; b=IPNuayBzcSrDbNg4CDf7wvhhrjZF
        1l5gZO4UdvJHEhw3+sFsmRDvyRRYdhEDA5TQFzL5GTWm6Wh6nR3VP3sxwLdTgM6A
        Bh4OHoaLXdaymuJILgrPa4NujOZ8y2GNjw6GuKKtEiRfMbur/iUE93fhTSQIcDD3
        I4BJCfIMl2td6wk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4893A145A73;
        Tue, 13 Sep 2022 17:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACFDF145A72;
        Tue, 13 Sep 2022 17:33:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] t1800: correct test to handle Cygwin
References: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>
        <4s7o04s9-3052-rqq6-584n-978p9758p580@tzk.qr>
        <xmqqy1uusyez.fsf@gitster.g>
        <CA+kUOa=DP6c417ZXXtxsJuyqJgpLZeAyr4URQPtMs0JhH1zVWQ@mail.gmail.com>
Date:   Tue, 13 Sep 2022 14:33:43 -0700
In-Reply-To: <CA+kUOa=DP6c417ZXXtxsJuyqJgpLZeAyr4URQPtMs0JhH1zVWQ@mail.gmail.com>
        (Adam Dinwoodie's message of "Tue, 13 Sep 2022 22:08:10 +0100")
Message-ID: <xmqq8rmn7ydk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BE8700FA-33AB-11ED-B0FE-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> ... It makes sense
> given the history of Git for Windows, but it's not a term many people
> are likely to be familiar with unless they've already been playing
> around with the MinGW/Cygwin environments, and I'm not sure that's a
> useful prerequisite for folk to be able to contribute to Git. I'm not
> sure what a better solution here might be; maybe retire "MINGW" and
> redefine "WINDOWS" to take its place, with current uses of "WINDOWS"
> being replaced with "WINDOWS || CYGWIN"?

It sounds more like "the world would've could've been a better place
if we did X", which is too late.  As a non-Windows person, I think
the current approach is OK that assumes that those who write and
read to understand our tests can answer the question: "You're on
Windows?  There are MINGW or CYGWIN, which one do you have?"

>> As =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh pointed out, the TODO: c=
omment may need to be
>> updated.  For future-proofing, perhaps "a more similar) error on all
>> platforms." would be appropriate.
>
> I'll respin with some updated comments shortly=E2=80=A6

Thanks.
