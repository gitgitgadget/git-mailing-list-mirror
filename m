Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3867BC2D0E4
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 21:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C7822201
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 21:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g+EK+Ptx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgKTVws (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 16:52:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58310 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgKTVws (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 16:52:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4901810921D;
        Fri, 20 Nov 2020 16:52:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lj7Ee9O3kBYkxBUJ7Lzr8TgG6p0=; b=g+EK+P
        txRspUjgd/8TvrV2hSKJrWHhME+i7cN6bVLOsfZ2VwRWVVeckbLDg9ETtlj8AqwJ
        TIqQuD/yXD8m4D3PcRROHfI8nrz11Hlu21CFtijobvVAYkBuQBpNqct5GlZJr/iA
        FvzGva3hx0ISqLqJ6s5gGVeLGSvrSLObEVNGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vhOu5ltcRcP4rP03cE45NGoDU5rRM5Gt
        +5AyaUtaD4r3iIpY1n1aHeFTzZFxyOozcjZUDDsQLC2hJF8vLGn4HH2CW2+66TZR
        9aPpJMawgNyBlSvwp1oL+gqjggkKyKfjL234RGbhXKnLAqySYIKz5+3FcMCRdEU5
        s8OosTD6rck=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42AA310921C;
        Fri, 20 Nov 2020 16:52:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D55B10921B;
        Fri, 20 Nov 2020 16:52:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/7] config: add --literal-value option
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <87k0ugp3mg.fsf@evledraar.gmail.com>
        <e7973fe1-eb64-2f5a-ecb3-fadf2ba9764d@gmail.com>
        <xmqqk0ufubha.fsf@gitster.c.googlers.com>
        <3a347d16-8549-5244-c7db-82b97d7311de@gmail.com>
Date:   Fri, 20 Nov 2020 13:52:41 -0800
In-Reply-To: <3a347d16-8549-5244-c7db-82b97d7311de@gmail.com> (Derrick
        Stolee's message of "Fri, 20 Nov 2020 13:51:16 -0500")
Message-ID: <xmqqft53u252.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7E171BC-2B7A-11EB-83AE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Since there is already asymmetry between the key and value (only one
> mode, --get-regexp, has a "name_regex"), I would prefer to treat the
> value_regex in isolation here.

Ah, I forgot about --get-regexp vs --get; so the ship has already
sailed---I agree with you that --(fixed|literal)-value is all we
need.

Thanks.
