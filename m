Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31562C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0263921532
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="czXkBgre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFQU2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:28:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51099 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgFQU2P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:28:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55929C1F10;
        Wed, 17 Jun 2020 16:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PWotY5PRdXLQ
        1u5hjPtpJK89Rco=; b=czXkBgreLcTb/72Wzicse16ddy9LeQdO7vNlxmwb1aHg
        2YXi8hjSy/5cnTPYxAAJKA1aq7al8Vc3/FpP+qxKNwaFaZV1OHmp44xjxBc6H7hE
        PFCvz6lGT0NASL4lGgjr2643Z61lHGWtsGKmUdp0vn30blRDWIN9qG3nAzXCMH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EhktMr
        pUedAYx3s6iyzFaoRunrgeUmUkf6UDSTLYJQ2Ghuh8aOYnRYW/KXzMX00LYRoZHf
        yoYtPKVqeNpzOfm7b50BCoo2IU36elhuThKzfRfg2LmfFQTKjhfzRwluzlZmkhBk
        XE75TNruZVboKOnLH3N2MpFeGXg3stfIQ5rps=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DF77C1F0F;
        Wed, 17 Jun 2020 16:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90B10C1F0E;
        Wed, 17 Jun 2020 16:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default branch
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <875zbrcpgh.fsf@evledraar.gmail.com>
Date:   Wed, 17 Jun 2020 13:28:07 -0700
In-Reply-To: <875zbrcpgh.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 16 Jun 2020 11:47:10 +0200")
Message-ID: <xmqqd05xtp2g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F1BC846-B0D9-11EA-8CF0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>  1. The special case in fmt-merge-msg we always had for "master" sucked
>     in terms of producing more verbose merge messages for those of us
>     who had repos where the main branch wasn't "master", but at least i=
t
>     was consistent.
>
>     Now we've created a situation where a user's local config impacts
>     what we put in the machine-generated commit messages.
>
>     Now, these messages were never "plumbing", and other users could us=
e
>     different git frontends than "core git" etc, but it's a really
>     useful property we've tried to maintain that a user's local
>     configuration doesn't change what we put in these messages. It's wh=
y
>     we've left them out of the i18n mechanism.

I doubt the last sentence reflects the reality.  As the person who
invented the fmt-merge-msg's mechanism (including it special casing
of 'master'), I know that it was the sentence lego that made it
impossible to localize and left the code pretty much intact since
the days it was introduced.

Having said that, I am personally inclined to vote for getting rid
of the special casing of any branch by "git fmt-merge-msg" and "git
fast-export --anonymize".  We still need a mechanism to let users
configure the word used by "git init" to give the first branch it
creates as its name, but that is merely the first branch created in
the repository and does not have to be the primary.

>  2. The whole core.mainBranch thing rubs me the wrong way. So now if we
>     rename a branch we munge it, but if you've got an older git version
>     or whatever you get different results and the config isn't carried
>     forward.

And we can get rid of this worry at the same time by doing so.

