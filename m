Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5801C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 04:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D83461212
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 04:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhKEEXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 00:23:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53292 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKEEXE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 00:23:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4DB0F14A6;
        Fri,  5 Nov 2021 00:20:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=lRXtSgQWglAL1dltjbBEIG6S0
        mbLRpRZStn9gzAuLxc=; b=KC1llVxlCJNwCZiF7t9eoSqrAPkAjyQDJP+sfy/tE
        lJUgoT8vfmUnXeLn5+eZ5CpM+Hvad1UDscE4jn8WYz5nYsj52bsBLqzUS3kovLjJ
        cWrpWsCKfxK/Et+5edY0up/4JRz93RkFGIq+XkKkrlYN5uE6ckzuLKDMM9Ztmvjr
        0I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B96EF14A5;
        Fri,  5 Nov 2021 00:20:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0697F14A3;
        Fri,  5 Nov 2021 00:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Victoria Dye <vdye@github.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [Discussion] The architecture of Scalar (and others) within Git
References: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com>
        <xmqqbl33a2fr.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111031833580.56@tvgsbejvaqbjf.bet>
Date:   Thu, 04 Nov 2021 21:20:22 -0700
Message-ID: <xmqq7ddnz115.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B255091A-3DEF-11EC-910B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Even so, I targeted `contrib/` with my patch series because
> `contrib/README` says:
>
>     The intention is to keep interesting tools around git here, maybe
>     even experimental ones, to give users an easier access to them,
>     and to give tools wider exposure, so that they can be improved
>     faster.
>
> Does this README's intent still apply, or has the purpose of contrib/
> changed?

The intent may still be the same, but my suspicion is that the world
has changed sufficiently to make contrib/ that is offered with such
an intent no longer is useful.  In other words, "contrib/" as a
nursery may have been our dream, but the dream did not materialize
and may have outlived its usefulness.

> Would you like me to organize the code and patches such that they more
> clearly fall under your maintenance once the patches are merged? If tha=
t
> is your preference, I will gladly put in the work.
>
> When I submitted the Scalar patches, I did not want to burden you with
> maintaining it, I expected to maintain Scalar going forward, but maybe
> that is not your preference? I assumed it to be my maintenance burden, =
we
> aim to support backward compatibility for existing Scalar users, after
> all. Absolutely everything else, however, is up for discussion, subject=
 to
> the full scrutiny of the community and to the same standards of a
> submission to the core of the project.
>
> And I see your point about backward compatibility: The Git project has
> plenty of experience with maintaining backward compatibility and _still=
_
> improving on initial designs. I therefore can easily give up my hard =E2=
=80=9Cthis
> command-line interface must not be changed=E2=80=9D stance.

It depends on how you define "maintenance".

Many parts of the system (e.g. difftool, commit-graph, pack bitmaps,
multi-pack index, sparse-index, po, and gitweb) may "fall under my
maintenance", but you can see that I am not heavily involved in any
of these areas, other than serving mostly as a traffic cop.  If a
patch that touches some area comes, I may trust input from folks who
are more deeply involved in the area (e.g. input from Taylor better
than from other folks, including mine, for a patch that touches
midx) when deciding if the patch needs revising or if it is ready.

I would expect that is more or less how things would work for
anything that is in my tree.  And I do not think it would be any
different for Scalar.  I would expect that any bugfixes or new
features would be redirected to you folks.  Ehh, not that you would
need redirecting---I'd expect you'd jump on them even _before_ I
would react ;-)
