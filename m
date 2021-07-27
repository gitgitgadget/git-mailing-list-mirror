Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242BBC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF40461019
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhG0RZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:25:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59064 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0RZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:25:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CB49134AA0;
        Tue, 27 Jul 2021 13:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7bW4syoUwHVGUt6IadEnYD8Jcglh+S+Qxl7RqJ
        gPw/w=; b=J1sDk68vVkdI131K6wJrT+gc2ERNWKlsFmcyUcd3/fwKcbfREowbgN
        iZiOIhmjhXa6z5LOIkyH94Jf1Gj+g4Os7L/HlUDMPLOpOqW/MEJz8423D7BLfKhR
        iE384Fc2mzf5tvtTmR4DAMXuXoGAukPVi2vwy2Xvb0bUc+2n1lMi0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 139A2134A9E;
        Tue, 27 Jul 2021 13:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 36B31134A9D;
        Tue, 27 Jul 2021 13:25:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 12/34] fsmonitor-fs-listen-macos: stub in backend for
 MacOS
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
        <587580489473a7a2ad665bdf3c482ea5d2c54f61.1625150864.git.gitgitgadget@gmail.com>
        <87sg0xbq9v.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2107161748050.59@tvgsbejvaqbjf.bet>
        <871r7yxkq8.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2107262338320.55@tvgsbejvaqbjf.bet>
        <xmqqr1fkfyh3.fsf@gitster.g>
        <38c22648-df46-2464-0c04-347dedbd04c6@jeffhostetler.com>
Date:   Tue, 27 Jul 2021 10:25:01 -0700
In-Reply-To: <38c22648-df46-2464-0c04-347dedbd04c6@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 27 Jul 2021 08:46:16 -0400")
Message-ID: <xmqqo8anekk2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9405AC2E-EEFF-11EB-81BB-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I'm not sure that there is a "correct" answer here, but for the sake
> of harmony, in V4 I'll set this to "darwin" and update the name of
> the backend driver source file to match.  So that we are consistently
> using 1 term throughout "Makefile" and "config.mak.uname".
>
> 	ifeq ($(uname_S),Darwin)
> 	...
> 		FSMONITOR_DAEMON_BACKEND = darwin
> 	endif
> ...

I do not think it would help "harmony" to change the name, but any
one of 'darwin', 'macos' and 'osx' would be fine.

It was irritating to see a simple "why is this particular name
chosen?" answered with such a hostility, when even a "we have no
deep reasoning behind the choice of the name. It is only seen by
developers in names of the source files, and it does not make much
difference" would have been sufficient.  I somehow view it more
problematic.

I guess the blame goes both ways, though.  We all have worked with
each other long enough to know which of your recipients are prone to
go overly defensive when asked questions, and we should know that it
would help to prepend "I am just being curious but..." to your
questions whose answers do not make a huge difference at the end
either way (or not asking such questions at all).

Thanks.
