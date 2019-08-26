Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9DD71F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbfHZQCS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:02:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54839 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbfHZQCS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:02:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B91FB72B79;
        Mon, 26 Aug 2019 12:02:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2XmKmtzxwV/YMXgAncprw7YQfHg=; b=u2rIWb
        +zn1zqWTXa6MBTr4jnm5j7LwU2SKVsgby3NUKZJvicays4mniqYeX1KDdru/QETu
        sZxuczNi6AGy9XAyz/IUbrVn+1JJEUbzIc3BZ3paReRn9KVdOcZ3wU+PE7pD/rvi
        ngjt4Tgxr0xD+3Ek2LPA+j8zScKGkXAS/Tx60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q3kj617NKsHok8r9oXU8ijRoiJr+zdDG
        Js/yLcBveImjs4m0fXUmEYLqNFsFjSYJHSRZmKcy3msMc0nK9qNbksZfaReiG/Pe
        N09XwRXum5vVIUbLQXrci/yMeTRG50FjU8EF/e13cyJc/tV2ORrKv0gBidAb1ATf
        inbtbIcdsrA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B073F72B78;
        Mon, 26 Aug 2019 12:02:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC61172B76;
        Mon, 26 Aug 2019 12:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Beat Bolli <dev+git@drbeat.li>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] grep: under --debug, show whether PCRE JIT is enabled
References: <20190818201727.31505-1-dev+git@drbeat.li>
        <xmqqk1b8x0ac.fsf@gitster-ct.c.googlers.com>
        <CAPUEspg9F7RutCUCoRAAXmRePjiunq3-zG7cN3uz_t5DVMxP=g@mail.gmail.com>
        <nycvar.QRO.7.76.6.1908261626450.46@tvgsbejvaqbjf.bet>
        <CAPUEspivEfc82ZM=VaUA_sYhQbz+GtoOODVZK2i9LcCkmHq=Sg@mail.gmail.com>
Date:   Mon, 26 Aug 2019 09:02:11 -0700
In-Reply-To: <CAPUEspivEfc82ZM=VaUA_sYhQbz+GtoOODVZK2i9LcCkmHq=Sg@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 26 Aug 2019 07:42:56 -0700")
Message-ID: <xmqqftlnkj98.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE80DCFA-C81A-11E9-B727-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> ... but
> ab/pcre-jit-fixes and UTF-8 validation are likely to make that more
> difficult (even if it is a mostly self inflicted wound AFAIK)

Hmm, in what way?  Do you mean that we'd be invested even more in
pcre1 in an effort to keep supporting, that the sunk cost would
dissuade us from deprecating the support even more, or something?

