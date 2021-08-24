Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63237C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 19:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C275613B1
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 19:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhHXTMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:12:12 -0400
Received: from pb-sasl-trial20.pobox.com ([173.228.157.50]:54670 "EHLO
        pb-sasl-trial20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhHXTML (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 15:12:11 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 15:12:11 EDT
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 3D0733C767;
        Tue, 24 Aug 2021 15:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xiFmLuQoRTZSao3uQWm+FsVIPuY=; b=raCVWc
        tCRSaO/8uHS8nM2HTGaq5u8IHooENpXaDAgOyyPHEqoWkMl7tUOcSGQVLTT55FOc
        Wfkw8q1spbZ68ueKHPBEPs23hMgw+CD9aFVnCkepJakaiCuFubwTNSO8YQUC9DJ/
        fs7b2wSRqlX5hg+ut8vVrbX4AMs2zEYI3AUog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kqn0CZFx/GE+Wpys6mLMTHbG6AYOM+yB
        9mcxDjtvMV99XBUgIwryFHuPf3jAaEyUuKDUmM7AAkON8GE+IWXrOck/PXFqAn+l
        HuAjXvmgc7uviRQWrZk8Q3owHGNPwqOXuHrw9UwE9252ETio5q4cPsIG5Z7R4s0t
        NQqd0OUVbNU=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 2F34B3C764;
        Tue, 24 Aug 2021 15:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 65851143AAC;
        Tue, 24 Aug 2021 15:04:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
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
        <nycvar.QRO.7.76.6.2108241126190.55@tvgsbejvaqbjf.bet>
Date:   Tue, 24 Aug 2021 12:04:38 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2108241126190.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 Aug 2021 11:27:44 +0200 (CEST)")
Message-ID: <xmqqmtp6oe9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2246C382-050E-11EC-AEB4-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Can this be made into a matter purely local to git-l10n/git-po
>> repository and not git/git repository? I am wondering if we can ee if
>> the current repository is git-l10n/git-po or its fork and run it only if
>> that is true.
>
> The biggest problem is that there are forks of `git-l10n/git-po` that
> accept PRs in their own right. That is what I tried to address by using
> just the repository name, without the org/user prefix.

Well, it is why I wondered if we can see "if the repository is
git-l10n/git-po or its fork".  Perhaps I should have written "or
(recursively) its fork"?  I guess the repository name being git-po
may be a usable approximation ;-)
