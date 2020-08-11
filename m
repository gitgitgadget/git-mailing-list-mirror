Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D58BC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC9F206DC
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CtYxsTmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHKVDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:03:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53687 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgHKVDz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:03:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB23EF32A5;
        Tue, 11 Aug 2020 17:03:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5yX279hQ3Umi
        O/QPb/zGWXP8kRc=; b=CtYxsTmPWdyViK6Rec1PVaDmtGhZ1Hm4HtotdQo3bwwl
        Syp2Le6ai5+TEu199TSKB100YNHsdTj5l1jGuip8qlBmE1KT/CXHXuWmxuO97I+E
        dqlqFsyTHid1N10h8AVnjGHoSI4b0pUvyS/XPRiUMnA9TnXrAPWKFPTZb5swx00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LipQk2
        /E8gtO3Tei0m03K3FIz3C5gwbs6O51c98sdapAv6Ga0XNUus5SqvgAuG8yVQFW3x
        WeqwpjcJHcc5lbv+mDeiAMVR1sTJH7T0mJOnR/ygzjtTY+PLgoR4GiM/NeQQ8+0n
        L2mGitK5pZRM1WcXQ3XVvcYAjpufhxsh6yH6o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4872F32A3;
        Tue, 11 Aug 2020 17:03:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C1A2BF32A2;
        Tue, 11 Aug 2020 17:03:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/11] renaming argv_array
References: <20200728202124.GA1021264@coredump.intra.peff.net>
        <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
        <xmqqk0y59fdg.fsf@gitster.c.googlers.com>
        <CA+P7+xq_eGaGNXd+0Ggxzofa5M_uESVXDaA-0ktH34fuONya0g@mail.gmail.com>
Date:   Tue, 11 Aug 2020 14:03:48 -0700
In-Reply-To: <CA+P7+xq_eGaGNXd+0Ggxzofa5M_uESVXDaA-0ktH34fuONya0g@mail.gmail.com>
        (Jacob Keller's message of "Tue, 11 Aug 2020 13:39:03 -0700")
Message-ID: <xmqqpn7w99or.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 277CA758-DC16-11EA-8245-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Aug 11, 2020 at 12:02 PM Junio C Hamano <gitster@pobox.com> wro=
te:
>>
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>> > 7.31.13 goes on: "Function names that begin with str, mem, or wcs an=
d a
>> > lowercase letter may be added to the declarations in the <string.h>
>> > header."  So the names of the strvec functions are reserved.
>>
>> Ugh, strbuf functions are reserved, too?
>
> At least that paper is proposing a better solution in the long term...

I am not sure what the "potentially" really buys to our fellow
developers.  At least we are not folks "targeting a specific version
of the standard"; we care about the future standards, too X-<.
