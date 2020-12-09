Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92317C4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BC023BC6
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbgLITje (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:39:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63889 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgLITjX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:39:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DB56110269;
        Wed,  9 Dec 2020 14:38:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pVBA/GZcMGeD
        KBie89/CIGBSQyI=; b=wb1Cw8Vwwo5S5WP4yycLpme5ougeeef5H2hUk1OBUbGL
        ff2c0ocgTXq5Yvhl/R4yVQM6RSw9eB4Xq4rAqRuwVvLMHd3JC7czX8Q2CHG/Rbca
        O0kFmjeGvb4Ae6tv+KAvVrm2iYbXk6opANBODZfZRAUPW/mBcyV2PCXkHmXV/1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZTNjEp
        soSnyQc7z++dNlTIhCwJTQkSULzr9mmJQJQ2+AtkjORyvUaJk6U2JIu22e6E+Qp9
        MjAZwFTaNgZSQJO8z3d02dsTXqrk7JKLj4VuHt7IX5Pfo9gMP4BTetjYV9MmHKQU
        R5CR66oB9zZ3F0gIHU81YxFhifFbhdXWAvXiM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66B54110268;
        Wed,  9 Dec 2020 14:38:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5F452110267;
        Wed,  9 Dec 2020 14:38:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Modernizing the contept of plumbing v.s. porcelain
References: <878sa7xujm.fsf@evledraar.gmail.com>
Date:   Wed, 09 Dec 2020 11:38:33 -0800
In-Reply-To: <878sa7xujm.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 09 Dec 2020 09:17:33 +0100")
Message-ID: <xmqqczzi3h3a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 20A24B24-3A56-11EB-834B-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> A lot of external guides and people's mental models of /usr/bin/git as =
a
> scriptable client reference the concept of plumbing & porcelain. Just
> one such example [1] prompted me to write this E-Mail.
>
> I've wondered if we shouldn't be updating this concept to reflect the
> reality on the ground in the git command ecosystem.

The example tells me that they are trying to be a good ecosystem
citizen by sticking to the plumbing and refraining from using
Porcelain command when writing their script.  The practice gives
them assurance that we won't unilaterally break them, and gives us
the freedom to improve Porcelain for human consumption.

> I.e. if you look at "git help git"'s list of plumbing v.s. porcelain it
> makes no mention or distinction between those commands & functionalitie=
s
> that are truly transitory "porcelain". E.g. the specific error message =
a
> command might return, and those that are effectively plumbing. E.g. som=
e
> "git config" functionality, "git init", the pretty formats in "git log"
> etc.
>
> I'm not quite sure what I'm proposing if anything, just putting out
> feelers to see if others think this documentary status quo has drifted
> from reality.
>
> One potential change would be to mostly/entirely remove the
> "porcelain/ancillary/plumbing" distinction in "git help git" (except
> maybe e.g. "hash-object") and instead make a mention of the status of
> the command at the top of its own manpage, which could then also
> (e.g. in the case of "git log") document the API reliability of its
> various sub-features.
>
> 1. https://gitlab.com/gitlab-org/gitaly/-/blob/afc90e3c2/doc/serverside=
_git_usage.md#L11-17

I am not sure what you want to propose as a solution, but even
before that, what problem you are perceiving.  Are you wondering if
it may be a better general direction for us to tell "no, no, there
is no value in sticking to the plumbing because we will break you
anyway in the future" to those who wrote [1]?

