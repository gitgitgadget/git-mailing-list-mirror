Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67C1C2BB40
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 22:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FD622510
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 22:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbgLNWul (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 17:50:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60235 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441071AbgLNWu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 17:50:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9999E94E35;
        Mon, 14 Dec 2020 17:49:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eBdwRzzf1XQ1
        NqhdY5DosfGB/M4=; b=ej9LtZju9vvHz93lNfYMcguWMWH0//hHgoZk58D9Pwtj
        I1x9adYGmEhPWa8TCV4gFIbDs0aEGo6Ltrb/MKC3ZVEKpZuhI7NIbwI3ftQqSIfj
        41GQhY2P+/0L4RiBprI76GeBlWu5M1ri6A7kPGeZFArYQpIvi0jHpJgHV5TLci8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=i8+KQu
        r45N/L6Od/MNyGAE6dN0ggieXrEIJAdRyoKSdOlR3Uq/UIlyFHNkNzGAYit+tUyK
        RPiIuseMakrlfjl+F7GOZVB0hvx/brHbtPB+rck+BnmJjfV67Kzqsx71on6obwdj
        /OdN7lp7AwoS0FXJ2snR/m3q+RLSkc0ciEXfg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FEC894E34;
        Mon, 14 Dec 2020 17:49:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E71994E33;
        Mon, 14 Dec 2020 17:49:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Modernizing the contept of plumbing v.s. porcelain
References: <878sa7xujm.fsf@evledraar.gmail.com>
        <xmqqczzi3h3a.fsf@gitster.c.googlers.com>
        <87v9d9wxwd.fsf@evledraar.gmail.com>
Date:   Mon, 14 Dec 2020 14:49:44 -0800
In-Reply-To: <87v9d9wxwd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 10 Dec 2020 15:14:58 +0100")
Message-ID: <xmqq8sa0atpz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A9288ABA-3E5E-11EB-B2AD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I.e. the existing advice was to say "just use plumbing", now it takes a
> more nuanced view of e.g. pointing out that certin porcelain commands
> have "-z" options that can be considered as reliable as things
> explicitly marked as plumbing.

Yup, and we have --porcelain option to some commands that are meant
to help Porcelain writers.

> It's widespread traditional wisdom when discussing git that there's
> plumbing and porcelain, but I think ever since all the builtins were
> shellscripts way-back-when this distinction has blurred.

Yeah, it is somewhat unfortunate that it is human nature to be
excited by shiny new toys that are end results; some of the newer
features we added and only available at the Porcelain level may be
better made available to the plumbing, but that is one of the
easiest corners authors can cut.

>  2. Either inline at the bottom, or probably better in a new
>     gitplumbing(5) (or gitapi(5) or something) explain the nuance, that
>     some commads are pure-plumbing, some pure-porcelain, and some are
>     hybrids.
>
>     That you can follow some general rules (does it have "-z" output,
>     can probably be relied on) to determine "plumbing-like", or
>     porcelain-like (is it stdout/stderr output in English, does it
>     change under i18n?), that not all manpages might explicitly call ou=
t
>     plumbing / porcelain, and that when in doubt ask the list.

OK.
