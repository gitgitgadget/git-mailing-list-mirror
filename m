Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BA6920756
	for <e@80x24.org>; Tue, 17 Jan 2017 19:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbdAQTVC (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 14:21:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65161 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750918AbdAQTVB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 14:21:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18381615B4;
        Tue, 17 Jan 2017 14:21:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1bmhmqiiyGX1TaafeG1vnKNKTUs=; b=Zvg0Yo
        FZPNHYG6kOxmfB5vmkDdFIlJbCPVyI7k31hpR0yicxHbIoC0rX8hZWAKXRuu8GLk
        Y3IDnSAxUXhYaCx9Nhh5C6ZaxG3leOiMLNUR0LSceWKZd2zRdeq14zTqWEeytlqe
        ZGS3gxvDm1lTb9oXkCKlNslbYub8h6r03nD+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Em0ovzwCeGug/4/pfk4uDCL8hXenbKpB
        JP845RpGjJsleCwNrRU/R2d7vavsY8Kdnz18+dQXaeg3YaxeJ8c/lEhf6LrkAXEu
        EndvJ4bzjR0SJqaFEwfBafk6Gdaa2Nr2jqIrpkL89NRqwAWnCd3Rj2tLPIIj2+DI
        cyUwNRt+e3M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09FA3615B3;
        Tue, 17 Jan 2017 14:21:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B4A2615B2;
        Tue, 17 Jan 2017 14:20:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
        <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
        <alpine.DEB.2.20.1701161251100.3469@virtualbox>
        <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701161746200.3469@virtualbox>
        <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
Date:   Tue, 17 Jan 2017 11:20:58 -0800
In-Reply-To: <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Jan 2017 17:00:14 -0500")
Message-ID: <xmqqk29tfq79.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13CB30DC-DCEA-11E6-A911-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Documentation/CodingGuidelines says:
>
>  - We avoid using braces unnecessarily.  I.e.
>
>         if (bla) {
>                 x = 1;
>         }
>
>    is frowned upon.  A gray area is when the statement extends
>    over a few lines, and/or you have a lengthy comment atop of
>    it.  Also, like in the Linux kernel, if there is a long list
>    of "else if" statements, it can make sense to add braces to
>    single line blocks.
>
> I think this is pretty clearly the "gray area" mentioned there. Which
> yes, does not say "definitely do it this way", but I hope makes it clear
> that you're supposed to use judgement about readability.

I always took "gray area" to mean "we do not have strong preference
either way, i.e.

 * It is OK for you to write your new code in either style (the
   usual "match existing style in surrounding code" applies,
   obviously);

 * It is not OK for you to churn the codebase with a patch that only
   changes existing code to flip between the two styles.
