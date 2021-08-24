Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA1EC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD16613AB
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhHXTHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:07:44 -0400
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:50732 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhHXTHn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 15:07:43 -0400
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id E326631487;
        Tue, 24 Aug 2021 15:06:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pGaclB8mAsS6
        j/Nr55n0oE080gU=; b=OvGqeYBaUFBt+5OCUCNHMuxmvLuIMv7ayIaUIBbtjcxu
        kC7auvJ597bcnsr8uXt/6dYCaMT0gdYE2dkGtRpCcOoHyeHVCtD+H2kmP47EdLIf
        Q0+rtyl1uwqT2S63OgtMLZHHCHjwBpMbCMg46zCklE4oWh1DBq8ytgf2r0w44dI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tzm1h6
        qcgrLaI5dyr3RDwGBKrHLbtTHSXF0angoZq3yaEo09poZRoKtDDDlH4v5UIonGPi
        trT3M/WVOGOsq1lJycmY3jKA7dAQhnOhJX39/az8hfz3/C6SYkAu5cUBJf8zxw2A
        8WrwV6bHwgWlZh+QhkzyxnmVXsfV/Nfhs9UVg=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id BFEF631486;
        Tue, 24 Aug 2021 15:06:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17017F0A65;
        Tue, 24 Aug 2021 15:06:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
References: <20210822161325.22038-1-worldhello.net@gmail.com>
        <20210822161325.22038-2-worldhello.net@gmail.com>
        <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet>
        <xmqqsfyzq1wq.fsf@gitster.g>
        <CANYiYbHUB-1LTyqCU2eFdYB7rHYq8v-ZBtL7ZR2wERfZry8TqQ@mail.gmail.com>
Date:   Tue, 24 Aug 2021 12:06:55 -0700
In-Reply-To: <CANYiYbHUB-1LTyqCU2eFdYB7rHYq8v-ZBtL7ZR2wERfZry8TqQ@mail.gmail.com>
        (Jiang Xin's message of "Tue, 24 Aug 2021 21:36:02 +0800")
Message-ID: <xmqqilzuoe5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7325C6C2-050E-11EC-BAB6-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>> > One such solution could be to make the `git-po-helper` job contingen=
t on
>> > part of the repository name. For example:
>> >
>> >   git-po-helper:
>> >     if: endsWith(github.repository, '/git-po')
>> >     [...]
>> >
>> > would skip the job unless the target repository's name is `git-po`.
>>
>> Nice.
>>
>> Can this be made into a matter purely local to git-l10n/git-po
>> repository and not git/git repository?  I am wondering if we can ee
>> if the current repository is git-l10n/git-po or its fork and run it
>> only if that is true.
>
> I have read almost all the github documents on github actions, and
> tried to find if I can use a local branch, such as "github-action" to
> hold local github-actions, but no locky.
>
> That is to say, the workflow file must be introduced to the master
> branch of =E2=80=9Cgit-l10n/git-po=E2=80=9D. As "git-l10n/git-po" is a =
fork of
> "git/git", the new workflow should be part of "git/git", and provide a
> way to disable it by default.

Yeah, that part I am agreeing with you.  I was just wondering if we
can do better than Dscho's heuristics (the repository name ending
with /git-po) to catch git-l10n/git-po or its fork to enable the
workflow in.
