Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A86C4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 18:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0964520575
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 18:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ov1HBGT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgKPSzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:55:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56042 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgKPSzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 13:55:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A70E2F42C5;
        Mon, 16 Nov 2020 13:55:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=u+lx0IA/0vuk
        eDlMt5HlCi+naeo=; b=ov1HBGT0zIeyuJoZpM0A6PqJjXEzFByLGGi+rl2xxuy3
        FKfIyHdaPqpQiH63whsYO4G5N7NbJyXMSLTlEGUVWxam6JwsQELOwmCdXhLr13dK
        JhciLlqdJe8jhXa7Oq8BLTiAOJ87x/nshSesxcPy0g0Lua1Cm27XwAD9r+dzkIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZMIXz2
        ZzHxSZrCGRn3HSmGFKwu/58El79jlWmUWQR2k56XNm7eCyfLLset47w9GJq1ptTn
        zAWfkJhoHx04gOxI05MlBiFRZOeBQu6kEVXs0DkJdPw+3NPGp4iu2PIwv6kWclah
        UFu+pIBL5SWNbrU+eoff0Z4ST0WdPa/994n4s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0D4DF42C4;
        Mon, 16 Nov 2020 13:55:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB8A2F42C3;
        Mon, 16 Nov 2020 13:55:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Adam Spiers <git@adamspiers.org>,
        git mailing list <git@vger.kernel.org>
Subject: Re: git-log: documenting pathspec usage
References: <20201116122230.eyizwe2bmqkmftch@gmail.com>
        <878sb1fpep.fsf@evledraar.gmail.com>
Date:   Mon, 16 Nov 2020 10:55:40 -0800
In-Reply-To: <878sb1fpep.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 16 Nov 2020 13:37:50 +0100")
Message-ID: <xmqqblfx9ln7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5471ED7C-283D-11EB-AA8C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It seems like a good idea to make these consistent, if you're feeling
> more ambitious than just git-log's manpage then:
>    =20
>     $ git grep '<pathspec>' -- Documentation/git-*.txt|wc -l
>     54
>     $ git grep '<path>' -- Documentation/git-*.txt|wc -l
>     161
>
> Most/all of these should probably be changed to one or the other.

There is another thing we want to normalize.

Originally <pathspec> was invented to be a collective noun (i.e. a
set of one or more wildmatch patterns that specify paths that match
any of these patterns is called a pathspec).  These days, however,
we more often refer to each individual pattern as <pathspec> than
using the word in its original way.  We can look for '<pathspec>...'
in the documentation to find these more modern usage.

This latter form would match readers' expectation better, but there
still are a few places (e.g. "stash forget <pathspec>") that use the
word as a collection of pattterns.  While these places may be using
the word "correctly", in the modern world, they give an incorrect
impression that the command somehow is special and can take a
pathspec with only a single pattern, when they can take one or more
patterns.

We should make sure we use "<pathspec>..."  uniformly in the
documentation in these places.

Thanks.

