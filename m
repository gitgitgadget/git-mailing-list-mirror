Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1D4F1F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 02:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeKYMwG (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 07:52:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64343 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeKYMwF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 07:52:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EF4D3C1CC;
        Sat, 24 Nov 2018 21:02:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=APBbu7onLdj7C+X01NHa6ezhWbk=; b=sRygok
        DL/btWfgnUX+FsZTopkiJ9NAtQLQNbDcbSJvEVg4b2jrEquWRP0dVST0gyUeMnZI
        j/6So5PmGIy1p/Qyhoox1iR2Kf4TaI9zXMuk3qazH0eh9ikyrZild+eXQ/IumyiG
        qilXlcJgZPorf1NpXlWtIdqi1Edg1Y/FOYmeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AF6AiVubK0kzdaF7LqeFPkB2i/JhvP0M
        wSUft5FxUSSxUffboMYiepyNAB8aO/dFHPfIKdTdha/Fj5BCBdEHkmf9bYb3Jshj
        9CXFAI+YvruvaRYkN2w9hoc3rf0kJgjKKawype6eJvqtcnHyT+UhmwagzdwqCnUd
        igJtSQV8E+0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 779063C1CB;
        Sat, 24 Nov 2018 21:02:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 898F33C1CA;
        Sat, 24 Nov 2018 21:02:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
        <87muq2zoy9.fsf@evledraar.gmail.com>
        <20181122175259.GC22123@sigill.intra.peff.net>
        <87efbd0xix.fsf@evledraar.gmail.com>
        <20181124120950.GB19257@sigill.intra.peff.net>
Date:   Sun, 25 Nov 2018 11:02:05 +0900
In-Reply-To: <20181124120950.GB19257@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 24 Nov 2018 07:09:50 -0500")
Message-ID: <xmqqpnut29uq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CCC35BA-F056-11E8-AFCD-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do also think in the long run we should be fixing the "unreachable
> always become loose" issues.

I think I've seen an idea of collecting them into a garbage pack
floated for at least a few times here.  What are the downsides?  We
no longer will know when these unreachable ones were last accessed
individually so we need to come up with a different policy around
their expiration?  As the common traits among objects in such a
garbage pack (iow the way we discover the objects that need to be
placed in there) does not involve path information and we lose the
ability to compress them well?



