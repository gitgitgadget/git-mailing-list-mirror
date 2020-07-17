Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F86C433DF
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 07:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20A42071A
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 07:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FCOKPByH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgGQHp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:45:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58217 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgGQHp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 03:45:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5AAF66880;
        Fri, 17 Jul 2020 03:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PWniAjDfDv66qmnn6HkyTTyHky8=; b=FCOKPB
        yHuxjXYSjiFfMff9hP9dgzpjhWixxMZvYnxKaZ+bUwsmLggDRrb+SnbScQTVkM/e
        6aNauPWRweE0Hw56MAiL4z+6DQeeHV+GQ4YJFfo3F0Q4secM2MV8GlEkHaDp1OJZ
        5KQHkKETDX1/p0DVrCz/y/OpgaNX8V4CVaYn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IrCXYUn2qSIkJ1zYSpw4rcLyTFJ12Ox3
        mC8RMsdJkYVfHoRr2l+vTdpdmcUFO6GHvfNDKe9A7nD/YGhPRXReQGZ90kWgNQEC
        w5u9vT7t9GiC1njQCoAjWtE/hbb0JMEhysHwnO3cSz02lxSqtjHWVUVNchlQneMS
        iH/Ofgfe0LE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C765F6687F;
        Fri, 17 Jul 2020 03:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B3D26687E;
        Fri, 17 Jul 2020 03:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: How can I search git log with ceratin keyword but without the other keyword?
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
        <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
        <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
        <20200716153159.GA1061124@coredump.intra.peff.net>
        <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
        <20200717063324.GB1179001@coredump.intra.peff.net>
Date:   Fri, 17 Jul 2020 00:45:53 -0700
In-Reply-To: <20200717063324.GB1179001@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 17 Jul 2020 02:33:24 -0400")
Message-ID: <xmqqd04ufutq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AFE35EA-C801-11EA-8FE1-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But none of that is exposed via the command-line of "git log". I think
> it would be possible to do so, but I'm not sure how tricky it would be
> (certainly one complication is that "--not" already means something else
> there, but presumably we could have "--grep-and", "--grep-not", etc).

Perhaps the definition of "distant future" is about 8 years ;-)

https://lore.kernel.org/git/7vr4q45y65.fsf@alter.siamese.dyndns.org/

