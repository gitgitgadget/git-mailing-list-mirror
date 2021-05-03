Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89A8C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 03:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BA561376
	for <git@archiver.kernel.org>; Mon,  3 May 2021 03:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhECDjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 23:39:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55997 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhECDjT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 23:39:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBDBA113D59;
        Sun,  2 May 2021 23:38:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WIHShctaQYUc8zt+rYl4yV8PBlToYK+F/spSq5
        ljQTQ=; b=K7RgAl4TKvo6KqYqnuJImuFgDs0Klml0xEWhf7sS9ubehoA7INlHTK
        bzRw75j2iFUWbGPa5/DtyAM2DCcWsNDlyuM8XZRtft5fzLok+bfICpvoRdlhWNpP
        agF/0U24hfDOiGbMYWJ8eGtisxCZrQNxQlGvbCK/xOuofexYbyYm8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A34C5113D58;
        Sun,  2 May 2021 23:38:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 91FEE113D57;
        Sun,  2 May 2021 23:38:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] urlmatch: do not allow passwords in URLs by default
References: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
        <CAP8UFD1Wm2e7Q3XY346-fFWMhdGHV_1Kp=wo8cqsx71j7Sg-dQ@mail.gmail.com>
Date:   Mon, 03 May 2021 12:38:21 +0900
In-Reply-To: <CAP8UFD1Wm2e7Q3XY346-fFWMhdGHV_1Kp=wo8cqsx71j7Sg-dQ@mail.gmail.com>
        (Christian Couder's message of "Sat, 1 May 2021 08:39:53 +0200")
Message-ID: <xmqqk0oga3ma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 033AEA32-ABC1-11EB-885D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Another helpful thing to do might be to add --user and maybe
> --password options to some commands like 'clone', 'fetch', 'remote
> add', etc.

Why?

We cannot get rid of <scheme>://<user>:<pass>@<host>/<path> right
away, but I'd imagine that we'd prefer to see fewer places on the
command line for users to leave the password that would end up in
their .bashrc and other places.

And I like the idea raised elsewhere in the thread to forward the
<pass> to credential helper and leave ":<pass>" part out of the
stored URL.

Thanks.
