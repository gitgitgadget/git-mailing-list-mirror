Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2A0320756
	for <e@80x24.org>; Sat,  7 Jan 2017 22:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbdAGWDe (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 17:03:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58952 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751357AbdAGWDd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 17:03:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21AC35D993;
        Sat,  7 Jan 2017 17:03:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AdWvxQmW4TMmxxiojnbST7JAuUk=; b=en2AY3
        AYLXi42fKc2TA3QmD+z9SZCyxSinUZnb46Oi+a9oqYVwjdxOr6/YAjTnVgull0Gm
        8AECO1XYE5W3N8WsTcEnnf55mtBBt/BbXny+HHBUnegzRxLTSb5BPj/iCcBAHShT
        YyA1ZsSXqriZDo9yWlWCk95VmiMQ96/czRrr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pKN7kMbdBHtQ+B4O5sqgiI+IhYZpNRcq
        R37Mwa8ctAk3Inr6f0IUh5STlIMiDCj50ySzlyfhYEiYgXQghViZ7O85VdJfPFct
        tL6jtWOQy5TU9oeRfmPwj6or1boZznT5OHNX379yr+bqK+jEFgNcncfc59MdmFvm
        by3Eq8YPHBU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 196465D992;
        Sat,  7 Jan 2017 17:03:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8134E5D991;
        Sat,  7 Jan 2017 17:03:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by `asciidoctor`
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
        <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
        <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
Date:   Sat, 07 Jan 2017 14:03:30 -0800
In-Reply-To: <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 4 Jan 2017 03:08:52 -0500")
Message-ID: <xmqqbmvi34ul.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20662EA4-D525-11E6-AF18-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jan 02, 2017 at 05:03:57PM +0100, Johannes Schindelin wrote:
>
>> From: =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>
>> 
>> The `user-manual.txt` is designed as a `book` but the `Makefile` wants
>> to build it as an `article`. This seems to be a problem when building
>> the documentation with `asciidoctor`. Furthermore the parts *Git
>> Glossary* and *Appendix B* had no subsections which is not allowed when
>> building with `asciidoctor`. So lets add a *dummy* section.
>
> The git-scm.com site uses asciidoctor, too, and I think I have seen some
> oddness with the rendering though. So in general I am in favor of making
> things work under both asciidoc and asciidoctor.
>
> I diffed the results of "make user-manual.html" before and after this
> patch. A lot of "h3" chapter titles get bumped to "h2", which is OK. The
> chapter titles now say "Chapter 1. Repositories and Branches" rather
> than just "Repositories and Branches". Likewise, references now say
>
>   Chapter 1, _Repositories and Branches_
>
> rather than:
>
>   the section called "Repositories and Branches".
>
> which is probably OK, though the whole thing is short enough that
> calling the sections chapters feels a bit over-important.

Is that a longer way to say that the claim "... is designed as a
book" is false?

> So I dunno. I really do think "article" is conceptually the most
> appropriate style, but I agree that there are some book-like things
> (like appendices).

... Yeah, I should have read forward first before starting to insert
my comments.
