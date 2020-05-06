Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131AFC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFB420936
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dukNdqcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgEFQeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:34:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51905 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbgEFQeD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 12:34:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 569D6C52B2;
        Wed,  6 May 2020 12:34:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JA8tvYJjtBVf
        l1KPhml9PZPBNb4=; b=dukNdqcs0wGvj068vVSg+Z9R56iPoAbH/r19rkXTkuor
        qPcaXkeOVRMODygziIvpBGrzJW3ppRxGdGVfA/vtJoHxiytXgeGHNbmhymxNKcFX
        r49C/wdzQSdQCN99+sJufeKT29b4H6j4CBtKOICJIf6V1oMomQntoFKmApcFftg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ka3VYk
        gjxJ3/6Res1dvLT3Vto3O1ldrEmncyTqovJl5VKuGc8t9gQdXgHtJVGsNkZWAZYM
        7nHCJS+UcqIj46LQAPnm+euUyQK6uG+l/Bk5yHf/N1z6gPeS9Ar4u10G4m5fuy8P
        qUtNmZyxyMF7HXiLei8c1w8PEpaUTAQ2vMogI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F2F0C52B1;
        Wed,  6 May 2020 12:34:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8E7F6C52B0;
        Wed,  6 May 2020 12:33:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures with file name/line number
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <cover.1586538752.git.congdanhqx@gmail.com>
        <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
        <20200504174636.GG86805@Carlos-MBP> <20200504232511.GB29599@danh.dev>
        <xmqqlfm7cj7s.fsf@gitster.c.googlers.com>
        <20200506073045.GA52959@Carlos-MBP>
        <nycvar.QRO.7.76.6.2005061447010.56@tvgsbejvaqbjf.bet>
        <20200506134659.GA75901@Carlos-MBP>
Date:   Wed, 06 May 2020 09:33:56 -0700
In-Reply-To: <20200506134659.GA75901@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 6 May 2020 06:46:59 -0700")
Message-ID: <xmqq368d81l7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 62B42608-8FB7-11EA-8E85-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

>> Unfortunately, it completely breaks the feature. At that point, `$LINE=
NO`
>> is either unset (e.g. in `dash`) or it contains the number of the line
>> _containing the `echo`. That is totally useless information at this po=
int,
>> we want the line number of the caller.
>
> that seems like a bug in dash, which NetBSD sh doesn't have, as LINENO
> wouldn't be unset.

I thought you already gave a perfectly well working eval '...' approach.
Was it insufficient?

