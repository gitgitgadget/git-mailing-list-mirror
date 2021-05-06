Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C543FC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 02:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43F5610E9
	for <git@archiver.kernel.org>; Thu,  6 May 2021 02:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhEFCRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 22:17:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63951 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhEFCRW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 22:17:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E24312FE23;
        Wed,  5 May 2021 22:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=esbBwIX0IWA03i3b/o7xma0W3
        BF+PWFZJ1tKX2FVMxw=; b=rCBL5qC1reOpEeU/7Z0Wp1N33AAVS8QF/ZIlm26nr
        ef8SRau31MZLFHqSMU86KISWmHPWtaUT24DqLEuURz1GmGzMP49fRilovhzeqIhb
        Gm1A8KAvs/k5or5NWmDG0EMkjOuwUiAn84n/iRIqYRrXchHHoIT1aUz0KuIVkvZ+
        fE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3891112FE22;
        Wed,  5 May 2021 22:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BCF612FE21;
        Wed,  5 May 2021 22:16:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
        <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
        <877dkdwgfe.fsf@evledraar.gmail.com>
Date:   Thu, 06 May 2021 11:16:20 +0900
Message-ID: <xmqq35v01ua3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D3B2446-AE11-11EB-BECB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I mean, I see why. You don't want a typo of "master" as "maaster" to
> create a new "maaster" branch, so really that's out. But it really
> should be:
>
>     # -n or -N for --new / --new --force (the latter just in case of a
>     # race, and just for consistency)
>     git switch -n doesnotexist

I do not see why --new is better than --create; we did choose not to
reuse --branch from "checkout" and I remember that was a deliberate
decision (i.e. once split into "switch" and "restore", "switch"
becomes only about branches, so unlike in the context of "checkout",
in the context of "switch", the word "branch" adds a lot less value,
and certainly does not signal we are creating a branch and switching
to it).

It would have been a stronger argument to favor --new if we had "git
branch --new <branchname>", but that is not the case.

