Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677621FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 20:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754298AbcK2Uzc (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 15:55:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58788 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752187AbcK2Uzb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 15:55:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C97552BFE;
        Tue, 29 Nov 2016 15:55:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SMG6vOJE5Vo0gDS/pRy6yKrj3U0=; b=gbqpSb
        HU6XrimubZzBM0ufGn5Tjm/udCgJj0Zn1CL7+1eJ4nL9gHcZcg1bvFbD9prtnLp7
        7ouZIsoOCXoLeK0b59BKxtbQ6knK2kXHgx6V45Ft2KY9E/KU6YaqhrIkqmm5Echt
        WSFkfFJveU/ueVIgQlv1XRFQkVjqLnLIKKUHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bA6SgIpHA8npSRoFgz9DRHitPgwRCjpi
        N3FKGkCjdq4CKRqJ4wNTV4YK3NmCKieKxf22eOf37+Db/ub3d1HcH4SNdEDctD2A
        LpQD3WEKrN5Ng3ZVXv4S0tUwtSTjOxJUfDdToEMf+jwsRRliMuFLsJrLup0B64X4
        kARfn7hkvVI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34E7D52BFD;
        Tue, 29 Nov 2016 15:55:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACFF552BFC;
        Tue, 29 Nov 2016 15:55:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611242211450.117539@virtualbox>
        <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611251201580.117539@virtualbox>
        <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611251841030.117539@virtualbox>
        <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611261320050.117539@virtualbox>
        <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611261400300.117539@virtualbox>
        <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net>
        <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611281830040.117539@virtualbox>
        <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611292128340.117539@virtualbox>
Date:   Tue, 29 Nov 2016 12:55:28 -0800
In-Reply-To: <alpine.DEB.2.20.1611292128340.117539@virtualbox> (Johannes
        Schindelin's message of "Tue, 29 Nov 2016 21:36:55 +0100 (CET)")
Message-ID: <xmqqshqadn0f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 295545E0-B676-11E6-B472-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So the suggestion by both you and Peff, to use an environment variable,
> which is either global, or requires the user to set it manually per
> session, is simply not a good idea at all.

As I already said, I do not have a strong preference between config
and env.  I raised the env as a possible alternative that you can
think about its pros and cons, and as I already said, if you thought
and your concluded that config would work better for your needs,
that is fine by me.
