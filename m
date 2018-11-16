Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567C31F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 09:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeKPUJv (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 15:09:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57803 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKPUJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 15:09:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6F243DDE1;
        Fri, 16 Nov 2018 04:58:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VjJwzyXwx3tLLzd9pnsdscQJL4I=; b=e5XHvK
        dGt3JrVPvOCrSw1L9ujfV/4xl6qIOo8et+2L67UGzrR5KLP4Kmq+ac/HjzyZTUcD
        4q6eRkjWcBAhcsb8WG2SbAHijCBkT/8kXBSsyNpWdGNwtJSbs7eKmSge4W8yde0T
        rAON6GYIA3d+94//tch9KOdgD5k+Yv7b+/oN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pThtmvv2Z0KgWbOXRlS6iLvdLYON3mK6
        Ot9rfR9wTYzQax9D+vEaEsp4EJOCAhSUMXMJUpXlU+QPtiWbNw2eXres0FsCXLgB
        xz9ozlp4aIIJrTyP3jfV18l0ApL2VFr2PrfmDDLTEAnybdxjhVG2eW1UbrzL/Sjm
        +1MuaqAxmQs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FA0A3DDE0;
        Fri, 16 Nov 2018 04:58:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B40463DDDF;
        Fri, 16 Nov 2018 04:58:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] rebase doc: document rebase.useBuiltin
References: <0181114090144.31412-1-avarab@gmail.com>
        <20181114091506.1452-2-avarab@gmail.com>
        <xmqqr2fllmft.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811161007030.41@tvgsbejvaqbjf.bet>
Date:   Fri, 16 Nov 2018 18:58:08 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811161007030.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 16 Nov 2018 10:35:39 +0100 (STD)")
Message-ID: <xmqq1s7ljqdr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 200EA658-E986-11E8-B6D8-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Meaning: essentially, `rebase.useBuiltin` was defaulting to `false`, and
> if a user installed Git for Windows with the experimental built-in rebase,
> it was set to `true` in the system config.

Oh, that changes the picture entirely.  If that was what was shipped
to Windows users for 2.19.X, then I'd say we should be able to trust
the switch well enough.  I just somehow thought that everybody in
the Windows land has been using the -in-C version.

>> Having said that, assuming that the switching back to scripted
>> version works correctly and assuming that we want to expose this to
>> end users, I think the patch text makes sense.
>
> Indeed.
>
> I would still love to see the built-in rebase to be used by default in
> v2.20.0, and I am reasonably sure that the escape hatch works (because, as
> I told you above, it worked in the reverse, making the built-in rebase an
> opt-in in Git for Windows v2.19.1).

Good.  That makes things a lot simpler.

Thanks.
