Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E547C2BB55
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209132083E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c4QXkHWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDJTKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:10:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59137 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJTKP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 15:10:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA2486103D;
        Fri, 10 Apr 2020 15:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rQ7FUKnX9sFC
        8ltT4Q558cwITdw=; b=c4QXkHWpKiUve5vZDvd9yMJCIHrwET51tNVAvPUgVfXE
        f5y6YFWfnenEGA7ldTR4nzuQ9JQWqnDhFaIjTFskDjvkstWN6pJkOnKmCYftD3es
        QjJdiH8HNcQpKdMsEz/TaSt3H6MLSxUPxnNMgkkl5NLlohIFAARVMAPr0ryFDKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xWroSv
        slE2q8jbeZMI8g62ahB+JjWSxwW0G6GWKGoQ4VXFfPCD6NZOKihLzRRCcSrqzopg
        xYz21Wn5ukIdKHMem2JNoX3VwTsRZ6Tp4AgNcd13WRJeJoMSgvFWXQuNtlapsT3d
        rhIbaY5TVMuxbkuhOrqtgpBePhU5qLOIa4tFU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A098F6103C;
        Fri, 10 Apr 2020 15:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 23AF86103B;
        Fri, 10 Apr 2020 15:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] ci/lib: allow running in GitHub Actions
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <d9227c87a7bb2872f6a69f48f6a4988f08545d8a.1585658913.git.gitgitgadget@gmail.com>
        <20200403084654.GK2224@szeder.dev>
        <nycvar.QRO.7.76.6.2004042207410.46@tvgsbejvaqbjf.bet>
        <20200410153131.GM2224@szeder.dev>
Date:   Fri, 10 Apr 2020 12:10:12 -0700
In-Reply-To: <20200410153131.GM2224@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 10 Apr 2020 17:31:31 +0200")
Message-ID: <xmqq7dynjgx7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E7A3AA72-7B5E-11EA-9E5A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> > CI_OS_NAME=3Dosx.  This is head-scratchingly backwards, and I think
>> >
>> >   test "$CI_OS_NAME" =3D macos && CI_OS_NAME=3Dosx
>> >
>> > would read better.
>>=20
>> I can understand where you come from, but your code is not `set -e` sa=
fe,
>
> It works as expected in at least in dash, Bash, BusyBox sh, ksh,
> ksh93, mksh/lksh, yash, posh, FreeBSD /bin/sh, NetBSD /bin/sh.

Thanks for a clarification.  I do not use "set -e" myself (it is not
a good idea to rely on it in general), and was wondering if what was
said up there was true, as it did not sound like a useful behaviour
at all.  Not complaining about a non-zero exit before && or || makes
it usable ;-)



