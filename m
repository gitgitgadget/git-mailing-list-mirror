Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ED0C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 21:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiFXVxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 17:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFXVxr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 17:53:47 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A68828B5
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 14:53:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5941414D3F8;
        Fri, 24 Jun 2022 17:53:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3c3uRQMO2kKr
        Zw/AjHM98tsbzqU4D04rATuQmNjiWws=; b=h3xAnoB7T5/hea7xtPdIVMCvscaO
        5W55R2OU1TH2cHIWWGpylyAnoelts4Drf4VvO76pA1rgeZAPCa3xIRSt6V/0U2vJ
        mxTpOPF0DCmYoBmuiT2orIrcfVhNqzyOFtyilpKcldKDLoMTyFyg5Ule3au5EDDX
        eseWhNoggPdBs+I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5199314D3F7;
        Fri, 24 Jun 2022 17:53:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABE7114D3F6;
        Fri, 24 Jun 2022 17:53:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 0/1] scalar: move to the top-level, test, CI and
 "install" support
References: <patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com>
        <cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com>
        <2f3067e1-43fb-26b3-83c4-6ca0722149a0@github.com>
        <220623.86k097js9k.gmgdl@evledraar.gmail.com>
        <c93c8e75-6c88-ac99-d8c3-1e2e7dd06ea3@github.com>
        <220624.86y1xmi5wo.gmgdl@evledraar.gmail.com>
Date:   Fri, 24 Jun 2022 14:53:42 -0700
In-Reply-To: <220624.86y1xmi5wo.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 24 Jun 2022 13:59:36 +0200")
Message-ID: <xmqqzgi1u3rt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1DB9AFAC-F408-11EC-9328-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Especially as I'm not insisting that I be the one to drive anything
> forward on the scalar topic, I think it makes much more sense that it's
> Victoria.
>
> This patch is just offered as a way to help that effort along. Perhaps
> she'd ack it as-is, find it useful as it reveals some edge cases she
> didn't know about, or drop it and go for some other approach. Whatever
> gets us to the end-goal sooner than later is fine by me.

Careful ...

> Once you "git rm" the scalar Makefile there's not really a lot of ways
> you can go other than something approximating the upthread patch. Given
> that some of the edge cases are tricky I deemed it worthwhile to share
> it.
> ...
> I'm not saying that, but "you seem to be trying to do X, and may or may
> not be aware of a past patch that does X, here is is in case it help!.
> ...
> Some of the edge cases in the Makefile integration are subtle. I trust
> that someone looking at it would probably discover those eventually.

... Even though you ask to assume good intent, an attitude shown by
repeated "I've done that, I already know *the* solution to the
problem you are trying to solve, and you can learn from what I did"
gives recipients quite an impression different from what you intend
to give.

> But if I'd have gotten a patch from my future self with all the learned
> edge cases beforehand I'd have appreciated, so I figured I'd send it in=
.

In any case, if you stop sending *replacement* patches in response
to others' work, that alone will reduce the friction people around
you are feeling quite a lot.  A replacement patch is a horrible and
inefficient way to comment on others' work, if your goal is to be
understood.  The recipient would be forced to read and think like
you did, making comparison between the two approaches themselves if
they want to see if it is worth to use the replacement.

Making comparison between approaches, arguing for the alternative
approach to be better, and proposing the alternative to be taken, is
the responsibility of the party who is suggesting alternative
approaches, not that of the recipient.

For that reason, if you want to say something to other people's
work, you are better off doing that either by commenting in-line
(i.e. annotating their code you want to comment on), or if you
absolutely need to talk in code, or by giving an incremental update
once their work solidifies (i.e. pointing out a specific issue in
the existing code, explaining why it is a problem worth addressing,
and offering an update---just like when you are fixing a bug).

Thanks.
