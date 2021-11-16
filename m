Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8FEC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0189663214
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhKPJEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:04:11 -0500
Received: from mout01.posteo.de ([185.67.36.65]:51425 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232486AbhKPJEH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:04:07 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AAF5F24002C
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:01:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1637053267; bh=o4pLgrwZZVppc1DOAtheDaz1Q4ouNhmJfq8JreT7muM=;
        h=Date:From:To:Cc:Subject:From;
        b=LyYx2O5jJJenclxagyuJeb+uE6VwVternwK8TvWSJaNyP6CD+Qj03cTCLpd7wpB9J
         +HQK+UwL1mPUi5nv7+UQAB1EXxevOUsVtKS5OOOQZdEk2nLnbtoCzGho+NjKXmDpBx
         8bAf2P7FqaVMAaEBsb0QtM5rO62guIC6vTWKy7uHqXAXkUsMszxiTgr38HO9ZWnQqs
         s5oloQYHF54GfP7CkhwOAHyHhEqreoqrfHkYBQyl+9R2wJ3UL2uILRnI/QyIPzgSg0
         hq8oFsN47dTS/uGEyHgtkaba/n4Uc6GZa/pEfLzafKJfxgaFaxg3s/nzlRvt91+ruI
         8zuSvQJV4nmDw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Htg5Z35HTz6tq5;
        Tue, 16 Nov 2021 10:01:06 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 16 Nov 2021 09:01:06 +0000
From:   andre_pohlmann@posteo.de
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: bug or a general misunderstanding
In-Reply-To: <YZLMVk3ULURAelQ2@coredump.intra.peff.net>
References: <0bb0056a59cda294d416762d7f8a9c47@posteo.de>
 <nycvar.QRO.7.76.6.2111101545000.21127@tvgsbejvaqbjf.bet>
 <3dd24fb6153cf8d67b74c6cea1a4a734@posteo.de>
 <YY2MXSZXIRSDLQCu@camp.crustytoothpaste.net>
 <468f30fbff6f1fcf708c484c19c287b7@posteo.de>
 <YZLMVk3ULURAelQ2@coredump.intra.peff.net>
Message-ID: <ee27d7905184a56e2d943602040f9a6c@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good Morning Peff,

I am not sure how to interpret the result. I just get a graph displayed.
Does this refer to the current branch?

Is it possible that the commit 48c8756e is in the history of a branch=20
but not an ancestor of ff2c8952?
Would this mean that GIT ignores commits in the history if they are not=20
direct ancestors of the commit from which the branch is created?

And why is the behavior of creating the branch different compared to Git=20
Hub Desktop?

Andr=C3=A9


Am 15.11.2021 22:08 schrieb Jeff King:
> On Mon, Nov 15, 2021 at 10:56:00AM +0000, andre_pohlmann@posteo.de=20
> wrote:
>=20
>> Starting from the relevant branch
>>=20
>> git branch TEST_1
>> git checkout TEST_1
>> git status
>=20
> OK, so TEST_1 points at something. We don't know what, but from below,
> it sounds like the BBV branch.
>=20
>> then
>>=20
>> git checkout BBV ---- that is the original Branch
>> git branch TEST_2 ff2c8952 ---- the commit to check out from
>=20
> OK, so now TEST_2 is created from ff2c8952. But from the details you've
> given, we don't know what relationship that has to what was on BBV, or
> any other commit.
>=20
>> git checkout TEST_2
>> git status
>=20
> And now it's our HEAD, though I don't think that matters, because...
>=20
>> git branch --contains 48c8756e ---- the commit with the specific code
>=20
> ...this is asking which branches contain 48c8756e, and doesn't care
> about HEAD at all.
>=20
>> the result is that only TEST_1 is shown, not TEST_2.
>> It looks to me like the commit is missing.
>=20
> I can't say if this is a bug or not, without knowing the relationship
> between 48c8756e and ff2c8952. Have you tried something like:
>=20
>   git log --oneline --graph 48c8756e...ff2c8952
>=20
> That should show you whether one is an ancestor of the other.
>=20
> -Peff
