Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6A2C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 06:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4760217F4
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 06:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NDM8b5VD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgAWGG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 01:06:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60721 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgAWGG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 01:06:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C1E9AF4D7;
        Thu, 23 Jan 2020 01:06:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=59G5FmlLqkJy
        gThBfprBbQiTXD0=; b=NDM8b5VD+b0h5hVLErUoS/BMDP7YPPszGCqIfNcfvfuX
        3avTABhqEM+8mSazbLrzAK2pXlsYwyKsaOXE125nLW6K9ReKceELCJH4Du5FgKIP
        aIbhExk7EsoiNwjs7G3BGbqLYbcZRVH1g5wX7KZXkegCs7pqNm9pSeAi90cpJuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JM/Dk9
        p0BCVAy8flroq72F32iELRQxHB3z3bP1s9kUJVtgwhiFZUqMFNEyC8LwFp5MzirR
        62jnF0KnjgNi4LMcs/RnBVcPAwu9xv0/eubVlzEMxSprkR2cxvmBdcNQdcj1jWnT
        pWVI3E6TR6wophk9H5GcFB5lti2bHRrmJpBNc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34565AF4D6;
        Thu, 23 Jan 2020 01:06:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5FB28AF4D4;
        Thu, 23 Jan 2020 01:06:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
        <20200122235333.GA6837@szeder.dev>
Date:   Wed, 22 Jan 2020 22:06:19 -0800
In-Reply-To: <20200122235333.GA6837@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Thu, 23 Jan 2020 00:53:33 +0100")
Message-ID: <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7A4ECDF8-3DA6-11EA-8421-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Wed, Jan 22, 2020 at 02:18:05PM -0800, Junio C Hamano wrote:
>> * yz/p4-py3 (2020-01-15) 14 commits
>>  - ci: also run linux-gcc pipeline with python3.5 environment
>
> I still think that this last patch needs to be reworked before this
> series is merged any further.
>
> The only Python script we have is 'git p4', so the Python version is
> only relevant for 'git p4' tests ('t98*'), while the rest of Git and
> the test suite couldn't care less [1].  This patch, however, not only
> builds Git and runs the full test suite for each of the two Python
> versions, but, worse, runs the full test suite _twice_ for each, first
> as a "regular" test run and then again with all the GIT_TEST_* knobs
> enabled.  Consequently, it adds ~50mins to every build's runtime.
>
> That's just too wasteful.

Thanks for a reminder.  Yes, I do recall you raised the above point
and I agree with the assessment.

What's the ideal endgame wrt the tests?  Build with Py$N and run
full test suite once, and run full test suite again with the unusual
knobs enabled, which is what is done without this series, plus build
with Py(5-$N) and run and run only t98?? tests?
