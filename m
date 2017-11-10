Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591BE1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 18:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbdKJSNJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:13:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61624 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751541AbdKJSNI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 13:13:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 075ABBDD97;
        Fri, 10 Nov 2017 13:13:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oj/YVY/mBH/YbWHDuWUBpKQMXNY=; b=KZPVPP
        Kf3zSoLc4FBDW00liIlz2IHdPjZ+sRzUo2FCE4T7a+ZUzIZdjWXTsbFFCkPWS0x8
        EkYkf9lHlWegkwR5zIdnoq6Xq1MfMvJyylaOp3zrESqzDNBD2N/pCTjcM4Ql43Un
        6LhuU5d0X4/dd/z7jQalBSXzAjjqraOQz9D5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xg7/Rib2VhgM4v5Hkh2QfGW0KDISq2wc
        Ylc/YqXTM6AYy19ZyoFbkQIP/kjoGoA/hZAcHCyBJkXwhlGUN6aq7h7s+PWmU7x4
        gZlx7oqtqNk7RyHzin6FsrGgU6xElqowIA5vVm+cLceXz4A20ZPzv8aaO7VdIcr5
        S157TK7TZaY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F4092BDD96;
        Fri, 10 Nov 2017 13:13:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65A9CBDD95;
        Fri, 10 Nov 2017 13:13:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Joseph Strauss <josephst@bhphoto.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug - Status - Space in Filename
References: <655aaa9d2abf4be1b6ade0574d88c999@EXMBX01B.bhphotovideo.local>
        <xmqqvaikjfoj.fsf@gitster.mtv.corp.google.com>
        <20171109132939.3v2z6sf22b4tnwpq@sigill.intra.peff.net>
        <xmqqvaijhs5b.fsf@gitster.mtv.corp.google.com>
        <20171110095808.igydpwweyceu6qcf@sigill.intra.peff.net>
Date:   Sat, 11 Nov 2017 03:13:06 +0900
In-Reply-To: <20171110095808.igydpwweyceu6qcf@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 10 Nov 2017 09:58:09 +0000")
Message-ID: <xmqqfu9mf1e5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD66EB0C-C642-11E7-B51D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Are there callers who don't just print the result? If not, we could just
> always emit. That's slightly more efficient since it drops the expensive
> strbuf_insert (though there are already so many copies going on in
> quote_path_relative that it hardly matters). But it also drops the need
> for the caller to know about the strbuf at all.

I am fine by that, too.  Consider that I'm still suffering from the
trauma caused by some patches (not in this area but others) that
changed output we have long been directly emiting to stdio to
instead capture to strings ;-)

This might also be a good bite-sized material for the weekend thing
;-)
