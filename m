Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35926C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 22:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0895C6023F
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 22:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhIEWh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 18:37:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56694 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhIEWh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 18:37:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67CBAF73DA;
        Sun,  5 Sep 2021 18:36:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S0KB7JlHBFBC
        lLjtI4o0ejDqXGLP7hoGskNSv3bpy8Y=; b=bLuoQ6lXaNJd/n+xh1NoPdq75mML
        Gx8jZsCM0btyVD/UY6hay8qfqu4UEEdd79nYUP9GANLahROP3P3nMVvRJBTsCEBh
        vRxJDkKlCAbNXhJucoUG79Z5830Z3NBjFTGHo61tmDtlGl7c9xyfaF4qjwJoLcN3
        mhFjVRG7DpgmpMI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 605AFF73D9;
        Sun,  5 Sep 2021 18:36:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E386DF73D8;
        Sun,  5 Sep 2021 18:36:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
        <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
        <87lf4f9gre.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109042138410.55@tvgsbejvaqbjf.bet>
        <87wnnvpiyj.fsf@evledraar.gmail.com>
Date:   Sun, 05 Sep 2021 15:36:23 -0700
In-Reply-To: <87wnnvpiyj.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 05 Sep 2021 09:32:28 +0200")
Message-ID: <xmqqlf4aejko.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B31D44BE-0E99-11EC-B719-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ... the
> git-sh-i18n's gettext() and eval_gettext() can't be useful to anyone ou=
t
> of git.git's tree, since they accept strings that are expected to be
> found in git.git's generated *.mo files.

True but removing it is probably outside the scope of this series.
Removal of helper functions from sh-i18n can be discussed once the
dust from this topic settles ("now the last caller of the helper is
gone from 'master', we can remove X, Y and Z").
