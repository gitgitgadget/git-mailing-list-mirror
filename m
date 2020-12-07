Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B54C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 23:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59551239FF
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 23:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgLGXJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 18:09:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58377 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLGXJi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 18:09:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9738511E59F;
        Mon,  7 Dec 2020 18:08:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jvs8Y8ePHUWVChH/WhIePbwlkMA=; b=gz0UWo
        UxmmvI6iItcXn4Vt7UBRM8ez0MFYF6ftD9DAz0GBZLYarmQz68GQl0pTkpFaM2Uv
        01DJOp6Y65S0IIu7kAyXrch3e+b9/rwq+763iaS5RolpXrP1uwquGfrJqUMVwXcn
        RuDBwdp2lOVFaJTIJEPK69EqR70RNRuOSegkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Db2i/utNuyCCa65LLecUqR1mapPhneAp
        Bh5PtbTNrN4PPiMtFCOgvUH8nzTm9Un7gOrxYNZFmcWsE8p26MEbm6v6C31uiRx0
        MwOFodsjTML1ouumCBLtIcNxowMpP5j5uxYG4kznaNWrLz4gQvFpCy0no15m6OE4
        wKqlH8iIWrs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F69111E59E;
        Mon,  7 Dec 2020 18:08:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D4D1511E59A;
        Mon,  7 Dec 2020 18:08:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>, Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v3 01/16] doc: pull: explain what is a fast-forward
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
        <20201205195313.1557473-2-felipe.contreras@gmail.com>
        <xmqq8sa99wh3.fsf@gitster.c.googlers.com>
        <CAMP44s1ZDXzGfEqpTeiG=aGAYK40ebnBLQKAbA7KGtcePGARfw@mail.gmail.com>
        <CABPp-BEkKMuZHWJ8mrFUFm3okDDsMHeZZNxtGzgq-RLLddMxdw@mail.gmail.com>
Date:   Mon, 07 Dec 2020 15:08:50 -0800
In-Reply-To: <CABPp-BEkKMuZHWJ8mrFUFm3okDDsMHeZZNxtGzgq-RLLddMxdw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 7 Dec 2020 14:40:37 -0800")
Message-ID: <xmqqblf58b99.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BD14142-38E1-11EB-9B67-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> > ... I find the phrase "in a fast-forward way" a bit awkward.
>> > Perhaps use the 'fast-forward' as a verb, i.e.
>> >
>> >         Then `git pull` notices that what is being merged is a
>> >         descendant of our current branch, and fast-forwards our
>> >         'master' branch to the commit.
>> >
>> > or something like that?  It should be in line with the spirit in
>> > which glossary defines fast-forward, I would think.
>> ...
> If you read the release notes and even various messages printed by
> git, "fast-forwards", "fast-forwarded", "fast-forwarding", and "to
> fast-forward" all appear multiple times.  And yes, "fast-forward" also
> appears multiple times as a noun in addition to the various uses as a
> verb.  So, I'd say the glossary just isn't comprehensive because in
> this case we have a word that serves as both a noun and a verb.

Ah, sorry, I didn't mean noun-vs-verb when I mentioned the glossary.

I thought that the idea that the word can be used as a verb, after
discussing advise() messages that tells the users that they can
"merge, rebase or fast-forward", was given and not something anybody
needs to be explained about.

The other half of what I suggested was to explain what situation is
fast-forwardable, i.e. "notices ... is a descendant of", and I made
sure that the explanation was in line with the grossary.  Without it
explained in-place in the text, readers who need to be told what a
fast-forward is needs to go to and come back from the glossary while
reading this page, which was what I tried to improve while we are
trying to find a better phrasing.
