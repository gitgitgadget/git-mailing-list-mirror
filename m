Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 747041F461
	for <e@80x24.org>; Tue, 27 Aug 2019 19:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbfH0TnI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 15:43:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52064 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbfH0TnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 15:43:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A93DB7FA71;
        Tue, 27 Aug 2019 15:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hm/2l0hZaxOG9HNKEOsalIaKcN8=; b=poD9L8
        pGfwxq1PVyI66TcypM5MTCAtPqB33fIW9UZAjqcf8iMVFwCHIThKUVM4seqMoCCn
        QaMfoPd+X67/jCvnn1nhKOZOgB2W+99QmkAkjaHi9D33+aybsh2bEW14JDs7l/IM
        1YeO1T+lp47CHYQgAlEOZmaASBSWuDraZB2m4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=smePyzRF7qaaXPR8fiVb+FFeLIR9NwrP
        DXGevrZBJV6OsFMDTyVBkNiitTKVkW140u7lqmC7cUS5Ko5iZ1eF3METvDUtUBEq
        cGqfj91ZsjghMkEGa6Vja+jf61v+FNVqtZU0TfOS9XYkCrL//IfnkWCLxvHXjz1c
        40oZyR6NSRY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0F867FA70;
        Tue, 27 Aug 2019 15:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B48FE7FA6F;
        Tue, 27 Aug 2019 15:43:03 -0400 (EDT)
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
        <xmqqftlnkj98.fsf@gitster-ct.c.googlers.com>
        <CAPUEspj4BJLjXorUXMiZnFtNcmhym_2QL5GUqeaGaCoxk=zjtw@mail.gmail.com>
Date:   Tue, 27 Aug 2019 12:43:00 -0700
In-Reply-To: <CAPUEspj4BJLjXorUXMiZnFtNcmhym_2QL5GUqeaGaCoxk=zjtw@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 26 Aug 2019 09:36:38 -0700")
Message-ID: <xmqqzhju2y4b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E26F16EA-C902-11E9-AE08-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> > ... but
>> > ab/pcre-jit-fixes and UTF-8 validation are likely to make that more
>> > difficult (even if it is a mostly self inflicted wound AFAIK)
>> ...
>  for example 685668faaa (grep: stop using a custom JIT stack with PCRE
> v1, 2019-07-26) adds 2 regressions as discussed in [1]
>
> * git grep -P will now throw an error if there are non UTF-8 documents
> in the haystack (even if JIT is available)
> * git grep -P '^([/](?!/)|[^/])*~/.*' will now fail with a cryptic
> PCRE error instead of succeeding (but at least will be consistent and
> show the same error with PCRE2)

Thanks.  This was exactly the kind of thing I wanted to hear when I
asked if ab/pcre-jit-fixes is a good base to further build on.

As far as I am concerned, ab/pcre-jit-fixes and anything pcre that
are still in flight are fair game for a reboot during this cycle (I
hope I did not merge any of them to 'next' by mistake yet).  If
there are bad apples queued on 'pu', let's make sure we eject them
and rethink the way to address the issue(s) they wanted to address.

