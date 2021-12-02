Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9797CC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 19:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376361AbhLBTIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 14:08:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54328 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348377AbhLBTIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 14:08:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB31E15FE52;
        Thu,  2 Dec 2021 14:05:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4ymYTNqsICCf3Q+/IPdBP4NsYwVgIj8NWDzTp4
        GG4xw=; b=GB7tFVRZdtCBw8nFC8RIh+AQ7JQ8OWso1ojIyxNraUjRlWtRQ7vEGs
        BR3q0DLE+DYYqRYs97QuTOfNDWKHx/d/tergR7cdK2b4QM4175Vq52tJl3bJea2B
        M/hhzkN+BgGW126ME4uJEgFAq+i7SVU2+X6YiYWgmze+DwdXjkfso=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D377715FE51;
        Thu,  2 Dec 2021 14:05:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B64715FE50;
        Thu,  2 Dec 2021 14:05:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Mahdi Hosseinzadeh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
Subject: Re: [PATCH] githubci: add a workflow for creating GitHub release notes
References: <pull.1146.git.git.1637840216877.gitgitgadget@gmail.com>
        <AM0PR04MB60196EFE984652ECCBD591A8A5629@AM0PR04MB6019.eurprd04.prod.outlook.com>
        <nycvar.QRO.7.76.6.2111261455590.63@tvgsbejvaqbjf.bet>
        <AM0PR04MB601972377B5CC2E24B6BA1DFA5639@AM0PR04MB6019.eurprd04.prod.outlook.com>
        <211129.86k0grf7lj.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111301239480.63@tvgsbejvaqbjf.bet>
Date:   Thu, 02 Dec 2021 11:05:08 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111301239480.63@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 30 Nov 2021 12:46:02 +0100 (CET)")
Message-ID: <xmqqy252u8t7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C58E1BA2-53A2-11EC-9D96-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Rather than hardcode given repositories, which e.g. for testing the CI
>> itself can be bothersome, perhaps a better thing is to put this into the
>> existing ci-config? I.e. git/git.git could opt itself in to behavior
>> that would be off by default?
>
> You probably missed that the purpose of this workflow is something that
> does not make sense in the forks of git.git.
>
> Its purpose is to create releases for all tags that are pushed to the
> repository. Most forks of git.git have no business creating releases, and
> those that do already have their own processes in place.
>
> As such, the situation is very different from the CI/PR runs that some
> contributors might want to restrict to only certain branches in their
> forks.

All true.  But https://github.com/git/git/ itself has no business
creating releases, as we already have the release process that
pushes the release material to kernel.org to be distributed from
there.

So... do we still need to discuss this patch?  In other words,
what's the benefit of creating "releases for all tags that are
pushed to the repository" there?  Does it give us redundancy in case
kernel.org goes down?  Does it risk confusing users having to wonder
release materials from which source is more "genuine"?


