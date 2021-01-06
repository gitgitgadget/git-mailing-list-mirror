Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1970C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 01:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BF822D01
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 01:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbhAFBt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:49:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60848 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAFBt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 20:49:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BCA310E9E7;
        Tue,  5 Jan 2021 20:48:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=esI2rUChu18l
        85XP9jsgZBJRogw=; b=T4tAYl1jx7vAKCRzUtNHlv9eCbh0aQILvyjmY/CCBHUM
        rUhIQGDIvs5CUU1BeY2kF/+Rmj5zqtL8A8jSZsimB2Sioq1yrbyIIa3XRjZo+MaY
        3s/xGIn/pobmvXJSH2digAlcerJgBowTwFQkmGlT64fZq7Lsykecgt9bbZNKi/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h4yfVk
        5lOOef7YLPbeRX6GvH8qgoFoek5VU2iOnTdq/VN/k7kba1nI6hicQGYRomKCkMQm
        nWJqkOOOxEULdnjUkb2WmreAFOQcS+1s5RJBmmjRjS7T12Od1BGsDyjOfvNu0hT9
        HsEm7t+GKa7hfwwjFDwN2R1zOzPLNePGX11/M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9403910E9E6;
        Tue,  5 Jan 2021 20:48:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF98010E9E5;
        Tue,  5 Jan 2021 20:48:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 23/23] mktag: add a --no-strict option
References: <20201223013606.7972-1-avarab@gmail.com>
        <20210105194252.627-24-avarab@gmail.com>
Date:   Tue, 05 Jan 2021 17:48:40 -0800
In-Reply-To: <20210105194252.627-24-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 5 Jan 2021 20:42:52 +0100")
Message-ID: <xmqq4kjuygw7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4DE8C556-4FC1-11EB-AE68-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Now that mktag has been migrated to use the fsck machinery to check
> its input, it makes sense to teach it to run in the equivalent of "git
> fsck"'s default mode, instead of hardcoding "git fsck --strict". Let's
> do that and support the "--no-strict" option.
>
> Since this is a new option we don't need to cater to parse-option.c's
> default of automatically supporting --strict. So let's use
> PARSE_OPT_NONEG, using a new trivial helper macro.

I do not understand the last paragraph.

    git mktag --no-strict --strict --no-strict

should follow the usual "the last one wins" rule, so I would say
that supporting "--strict", whether it is done automatically as a
natural consequence of use of parse-options or not, would be a good
thing (also I so not see PARSE_OPT_NONEG in this patch).  Perhaps
the log message (and the title) needs updating?

    mktag: add a --[no-]strict option

    Now that mktag has been migrated to use the fsck machinery to
    check its input, it makes sense to teach it to run in the
    equivalent of "git fsck"'s default mode.  For cases where mktag
    is used to (re)create a tag object using data from an existing
    and malformed tag object, the validation may optionally have to
    be loosened.  Teach the command to take the "--[no-]strict"
    option to do so.

or something?
