Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D339FC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 00:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8199064E79
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 00:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhBQAEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 19:04:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57793 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhBQAEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 19:04:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 266C99F4EA;
        Tue, 16 Feb 2021 19:03:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jn8t0WMbnuoD
        2qsBd6GoTpzEFCY=; b=xYuNKVflNhSoyp5Kv9LkwqOCiCvH1F0XMNjykMDbJt5v
        k5Ri4hTU8eZCbQrkkinSbZGrRoTzXsDNsLzku1cVrASqpf5/Dc4OeSuzl6ZZA5O/
        h19K6b61Wx2H4v76QnZCfK3Dwmv2UTlFtNpGX9iEiKw80esS6TdTVeaaaxjsHxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RbpHFN
        FzrMNczW79jOg6GZ3OuVZzIzmC6pYjRtepUWDSOH/dnvfFwJrdVXTbSpZZ+Xy8Kj
        SP9aBaZVOKy8MmqR+1GuYE87/i3M5nj8iAwSPjy724JhZRB0YUoEQNvtGxZ2lcZo
        s+AFp19rnNfvPFcPmuicThFBtQs6EGs3XOZTg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C3A99F4E8;
        Tue, 16 Feb 2021 19:03:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F3D59F4E7;
        Tue, 16 Feb 2021 19:03:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 19/27] gitattributes doc: document multi-line
 userdiff patterns
In-Reply-To: <20210215154427.32693-20-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 15 Feb 2021 16:44:19 +0100")
References: <20210215005236.11313-1-avarab@gmail.com>
        <20210215154427.32693-20-avarab@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
Date:   Tue, 16 Feb 2021 16:03:52 -0800
Message-ID: <xmqq4kibo907.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F203E82-70B3-11EB-9955-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -There are built-in patterns shipped as part of git itself. A more
> -advanced version of the `tex` pattern discussed above is one of them.
> +Multiple patterns can be supplied by listing them one per line
> +separated by `\n`. They will be matched one at a time from left to
> +right. Do not supply a trailing "\n" for the last pattern. E.g.:

I've always thought that this was modelled after "grep --file=3DFILE",
where patterns are listed one per line, so "from left to right"
looked a bit funny, at least to me.

If the "do not supply" is because "it would result in giving an
empty string '' as the final pattern, which may not be what you
want", then it is a good idea to spell it out.

> +------------------------
> +[diff "perl"]
> +	xfuncname =3D "!^=3Dhead\n^[^ ]+.*"
> +------------------------
> +
> +Patterns in in a list of multiple that begin with "!" are negated. A

"in in"???

> +matching negated pattern will cause the matched line to be
> +skipped. Use it to skip a later pattern that would otherwise match. It
> +is an error if one or more negated patterns aren't followed by a
> +non-negated pattern.
> +
> +To match a literal "!" at the start of a line, use some other regex
> +construct that will match a literal "!" without "!" being the first
> +character on that line, such as "[!]".
> +
> +If the pattern contains a `$1` capture it will be used instead of the
> +entire matching line (`$0`) to display the hunk header. This can be
> +used e.g. to strip whitespace from the beginning of the line, or to
> +only display the function name as part of a longer function
> +definition.
> +
> +There are built-in patterns shipped as part of git itself, see the
> +full listing below.

Other than the minor nits above, the new text is written very well.
