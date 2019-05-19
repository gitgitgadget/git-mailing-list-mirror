Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTTP_EXCESSIVE_ESCAPES,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C571F461
	for <e@80x24.org>; Sun, 19 May 2019 01:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfESBM1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 21:12:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51103 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfESBM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 21:12:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD62E6282B;
        Sat, 18 May 2019 21:12:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lt5tFtHp/62t4Mjzt8CHIm+VZKI=; b=qSX5IO
        OQ8V3jnuzgpRpDTsc3Cm0vuYLwv6TtliYEEVt/AulpYMayacxc1G15ttea7kynjN
        jeHaCCVgBE0uC71ADU7cQZB6ykZW/0uQZJ8J1O5jJWxBDosGK2cnglx3PjSRPZsg
        AHWhqZVjVAKVf5uEc6zG9Xkft6m7f9kweh/lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q+DUlXvXufOpysf6kN1rSxU9IREt2VjV
        mTqgKh5kAexnukOCqkNzYQaYDdSsuwTeftwYYGqDEZ2rXz9JTnUAlbBynRIhBB9t
        udrJuM+FgmTnECGdZF/0a0tb40d+cpD9TyY4a17gWgos61C7dfcnF5wtWFSFdrDV
        GX7D8ItQnVg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C71AA6282A;
        Sat, 18 May 2019 21:12:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 04C0362825;
        Sat, 18 May 2019 21:12:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com
Subject: Re: [RFC PATCH 3/3] list-objects-filter: implement composite filters
References: <20190514001610.GA136746@google.com>
        <cover.1558030802.git.matvore@google.com>
        <02a8c9b017d8df056d7e90aff907d6e0b5506467.1558030802.git.matvore@google.com>
        <xmqqwoip3gp0.fsf@gitster-ct.c.googlers.com>
        <1E174CAA-BD57-400B-A83B-4AABFAFBC04B@comcast.net>
Date:   Sun, 19 May 2019 10:12:16 +0900
In-Reply-To: <1E174CAA-BD57-400B-A83B-4AABFAFBC04B@comcast.net> (Matthew
        DeVore's message of "Fri, 17 May 2019 06:17:43 -0700")
Message-ID: <xmqq5zq72qof.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25C6A4C8-79D3-11E9-B349-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@comcast.net> writes:

> My justification for the URL-encoding scheme is:
> ...
> 3. Continuing to use a single filter line seemed the least
> disruptive considering both this codebase and Git clones like
> JGit. Other clones will likely fail saying "unknown filter
> combine:" or something like that until it gets implemented. A
> paranoid consideration is that clones and proprietary server
> implementations may currently allow the "filter" line to be
> silently overridden if it is repeated.
>
> 4. Assuming we *do* use a single filter line over the wire, it
> makes sense to allow the user to specify the raw filter line as
> well as have the more friendly UI of repeating --filter flags.
>
> 5. If we use repeated "filter" lines over the wire, and later
> start implementing a more complete DSL for specifying filters (see
> Mercurial's "revsets") the repeated-filter-line feature in the
> protocol may end up becoming deprecated and we will end up
> back-pedaling to allow integration of the "&" operator with
> whatever new operators we need.

OK, that's fair.

> 1. Allow anything to be encoded. I chose this because it's how I
> usually think of URL encoding working. For instance, if I go to
> https://public-inbox.org/git/?q=cod%65+coverage in Chrome, the
> browser automatically decodes the %65 to an e in the address
> bar. Safari does not automatically decode, but the server
> apparently interprets the %65 as an e. I am not really attached to
> this choice.

OK, so the rule is "when you see 'combine:' (this part is never
encoded), take the rest as a single string, separate it at '+' (these
pluses are never encoded), and URLdecode each part---each of these
parts is a filter", which totally makes sense.  I somehow didn't see
that clearly written in your description.

