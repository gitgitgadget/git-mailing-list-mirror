Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36B61F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 10:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeKPUSp (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 15:18:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64494 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeKPUSp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 15:18:45 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08E0A10B8A9;
        Fri, 16 Nov 2018 05:07:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NBVPuHRQC9pLWymYFxWV6bJ/Aoc=; b=AyF2SH
        D1UhkzCNXxdq2hInReoAjCCz/iicIQGLGFGOj8jfOduO7XBv7cny2C8SxU8khImN
        Bdava5ZKgVN9W+SVECjg4EOHKzKA9VuqO5I+AFfZt2tNKHShMOJ5hQPD6KUPhJow
        t/zn9La7otKgSzbf6KccxggnGddAceAJVMfug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MlrPSqmozdXtxQJZ68c+uyXWoqdZg0mF
        n6F13Z+J732vDHKwcuX/bzDZKu4a/LMeZkVyR2S8eIB4zkrp3s/U71IhMbDYgHFF
        z1Ue4Td3aIFUFpAZ+w9ArHBOi701p7NMRv9jbb88TmulvR5Lyqm7Tm7HJ6ZycSx7
        usvLyJ8ASn0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00BB910B8A7;
        Fri, 16 Nov 2018 05:07:05 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73A0910B8A6;
        Fri, 16 Nov 2018 05:07:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] ref-filter: don't look for objects when outside of a repository
References: <xmqq5zytpa65.fsf@gitster-ct.c.googlers.com>
        <20181114122725.18659-1-szeder.dev@gmail.com>
        <20181115093844.GA14218@sigill.intra.peff.net>
        <20181115094320.GA18790@sigill.intra.peff.net>
        <xmqq36s1libw.fsf@gitster-ct.c.googlers.com>
        <20181116085602.GB20828@sigill.intra.peff.net>
Date:   Fri, 16 Nov 2018 19:07:03 +0900
In-Reply-To: <20181116085602.GB20828@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 16 Nov 2018 03:56:03 -0500")
Message-ID: <xmqqwopdibeg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E30837E-E987-11E8-A80B-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If you are arguing that even in a repo we should reject "authorname"
> early (just as we would outside of a repo), I could buy that.

Yup, that (and replace 'authorname' with anything that won't work
with missing objects) for consistency was what I meant.

