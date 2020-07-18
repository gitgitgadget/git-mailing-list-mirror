Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BACC433E1
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 18:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797712073A
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 18:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IizreWmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGRSH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 14:07:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56102 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRSH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 14:07:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39FC67303C;
        Sat, 18 Jul 2020 14:07:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3jXu0MplsqBT
        PcbW+fWehNEQm44=; b=IizreWmu6OGx8tZm7r55Ou1bqJinSdzE9hwYVYl8q+Dy
        x2beWA727yxpQyWSdstCq0Zz1Y56chV3gG8tullHoG411DycUdIPIKNsY6XCRoEm
        DYlC6gX945lcPM1dGFS9CDq12u4wk+i8MglSnK3pPADnvoR29sxxx1oYxZUpsQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XufJxZ
        Jwpr2ZFknEwnvfY14Dgj3IQADOWnh33nOFEG35atFkia0LD12yx/LmlJ9M2rnCYW
        6dqyiov326eTrOfNhrCM5sY3owKOWKWicummETUDKCFe+u8hIaq7H9L+iJUU3WVq
        pZ6ykip+KMht+hMIOAeBANP8C+PwgQzRGHsxo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 321297303B;
        Sat, 18 Jul 2020 14:07:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B50CC7303A;
        Sat, 18 Jul 2020 14:07:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>
Cc:     Jeff King <peff@peff.net>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: How can I search git log with ceratin keyword but without the other keyword?
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
        <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
        <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
        <20200716153159.GA1061124@coredump.intra.peff.net>
        <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
        <20200717063324.GB1179001@coredump.intra.peff.net>
        <xmqqd04ufutq.fsf@gitster.c.googlers.com>
        <xmqq7dv2fnpb.fsf@gitster.c.googlers.com>
        <CAAvDm6bG-s2m9fGXVtuyLB7_FSDRduhb3ptrBsL3ezR9LaS-hQ@mail.gmail.com>
Date:   Sat, 18 Jul 2020 11:07:54 -0700
In-Reply-To: <CAAvDm6bG-s2m9fGXVtuyLB7_FSDRduhb3ptrBsL3ezR9LaS-hQ@mail.gmail.com>
        (=?utf-8?B?IuWtmeS4lum+mQ==?= sunshilong"'s message of "Sat, 18 Jul 2020
 12:51:53 +0800")
Message-ID: <xmqqlfjgbssl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9ADDF1F0-C921-11EA-A1CE-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E5=AD=99=E4=B8=96=E9=BE=99 sunshilong <sunshilong369@gmail.com> writes:

> Thank you for your detailed explanation.
>
>>There is not much room for the line-level "--not" operator to
>>participate in this picture.
> After I have carefully read your explanation again and again.
> Maybe, I think there is a way to achieve this goal.
> Please point out if there is something wrong.

Sorry, it is currently not in the area of interest for me to examine
an extensive rewrite of the "grep" machinery for unknown benefit.
The cost-benefit ratio does not look too great to just add "X && !Y"
support to existing "X && Y" logic.  If we were seriously extending
the machinery, I'd rather see us shooting for even more generic
boolean expression support, not just "our --all-match currently
requires all of the AND-ed terms to positively match, but lets make
it possible to require some of these terms not to fire at all".

