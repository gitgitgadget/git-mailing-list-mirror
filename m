Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBE6C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABBC610FC
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhDOUu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:50:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53101 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhDOUu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 16:50:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4364123B24;
        Thu, 15 Apr 2021 16:50:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vEKeL6M/B6avOuaBzuuJpdbQs5k=; b=rmI7bl
        QVEwgdOMaToWQyYnKpM4J+nSBd3JNDUw5L4u04NEocMyXEV7B6WIW8H/jw2phXRn
        XywJ9iM4/Qpwx1iq0TRjikJwxM1a6JyKa9lCvaIx6DhvrihAeJFKGyOAJUTEI/0x
        yU2723ybirGtTSitWoEo5RmCiXbizsuRcbHmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FpHyEY0CBtsphC4XnTmheBW9Fhz4BSlm
        7muwR7JzADlWsyYSASic0IDeMaVN4G6xQwWL87o++YeHyGZPGY/ynTXBBOruhnrS
        IIgSxZmNMmvnvvjpQlniXDDZFilFkm5ER5g1M8AHfPFG/+JWwgs36+kxxua0rlE9
        wSMvWMFaYdc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C4D8123B23;
        Thu, 15 Apr 2021 16:50:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E73C0123B22;
        Thu, 15 Apr 2021 16:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Maste <emaste@freebsd.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Albert Cui <albertqcui@gmail.com>,
        git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
        <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
        <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
        <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
        <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net>
        <87tuoijzsy.fsf@evledraar.gmail.com>
        <9af3770f-204b-253b-d7f2-c9d5e7cf2fdb@gmail.com>
        <CAPyFy2A25EApYOivqhD_-sUNpep9c98DXHh0tXLd7T17qQLFLg@mail.gmail.com>
        <xmqq7dl3qqrh.fsf@gitster.g>
        <CAPyFy2Bf8t_2HggKG7LMY4u=9qBJ0-+xcx-gCv_kh7KYHg1-hw@mail.gmail.com>
Date:   Thu, 15 Apr 2021 13:50:30 -0700
In-Reply-To: <CAPyFy2Bf8t_2HggKG7LMY4u=9qBJ0-+xcx-gCv_kh7KYHg1-hw@mail.gmail.com>
        (Ed Maste's message of "Thu, 15 Apr 2021 16:37:54 -0400")
Message-ID: <xmqqh7k7p90p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 388F8136-9E2C-11EB-B6A6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Maste <emaste@freebsd.org> writes:

> Yes - this is what I'm wondering about. It seems this information is
> not available other than by inspecting config.mak.uname or reading
> mailing list archives. I can also look at .travis.yml, .cirrus.yml,
> and .github/workflows/main.yml to get a sense of the platforms
> supported by Git's CI. That includes at least various versions or
> flavours of Linux, macOS, Windows, and FreeBSD. Is it worth putting a
> sentence or two in README.md about this?

I do not think that README, which is end-user facing, is a good
place for that.

If anything, I am inclined to say that developer facing documents
like SubmittingPatches and CodingGuidelines may be a better place to
say that things are expected to work on X, Y and Z platforms, but I
would think it is perfectly OK to start with a new feature that
works only on, say, macOS, and leave it unimplemented for other
platforms until somebody who is motivated enough to help fills the
gap.  So in that sense, "things are expected to work on these
platforms" may be already stronger than what we want to say.
