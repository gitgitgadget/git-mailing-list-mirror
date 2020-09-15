Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11085C43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8EC020809
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mnVqIcEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgIOWc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:32:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55555 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgIOWcU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 18:32:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 587827F6EF;
        Tue, 15 Sep 2020 18:32:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0z0psLbDhL4MFaspurS8BI5Nyqs=; b=mnVqIc
        EL+C/N5x/RY1ClQOBXnWrL7DwIrWaGSjZgfcCOE6Q679cOP0V2odg/IrvRohbSwf
        mLrKzkfTJbIiHyG6ZQCM9adMM01CSLiBwKwqRgK9yONExF0uMi24kjYzsp788adQ
        dvWImzPuYUY+i49lZWdxiL7XT2ftD8OEjhVbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E/rTvVOFT4qcgw6CDMKG4GbgugtWE4wH
        IB/4aytUOJASZRCnBEX2fI6ii3znHLHrdc0o0ciUWXDR/qXtoL75xLH56D1oHsON
        d1De6U6wEvja3omSsYJO/QD6g7kq2wiWtSc3+zXn0jJsngnhMn4kNoR4sNTNurL6
        ftLjxdahAik=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F1F87F6ED;
        Tue, 15 Sep 2020 18:32:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF4497F6EC;
        Tue, 15 Sep 2020 18:32:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        git <git@vger.kernel.org>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com>
        <85ft7ivp1t.fsf@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me>
        <xmqqimcezqs5.fsf@gitster.c.googlers.com>
        <CANQwDwc3-n4X16F1Xuf-y-yLeXoGRTeT5c=kVVFXH1E6P=ZEqA@mail.gmail.com>
        <xmqqzh5qyar4.fsf@gitster.c.googlers.com>
        <20200915214802.GB1741@nand.local>
Date:   Tue, 15 Sep 2020 15:32:16 -0700
In-Reply-To: <20200915214802.GB1741@nand.local> (Taylor Blau's message of
        "Tue, 15 Sep 2020 17:48:02 -0400")
Message-ID: <xmqqr1r2y8lr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FC1B48A-F7A3-11EA-833D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I completely agree with Junio's sentiment here. The overflow handling
> needs to exist no matter what, but let's remember what's common and what
> isn't.
>
> Since it's not common to be towards the end of even just the 32-bit
> range, let's "optimize" for that and store the fields as 32 bits wide.

Thanks.  I realize I wasn't clear but that is what I meant.  If we
need to deal with overflowing situation sensibly anyway, there may
not be much advantage in using 64-bit until year 2038.
