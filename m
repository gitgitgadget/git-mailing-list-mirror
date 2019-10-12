Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6C2C1F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 00:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfJLA1z (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 20:27:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51669 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJLA1z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 20:27:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AE4F2D604;
        Fri, 11 Oct 2019 20:27:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PNwKDAUk/JPFGQGxHudsTeRRv9M=; b=rTXGSe
        ZHHDvjTxuc0xLoEIRLfpCotS8bE3KLlQkvc/LsJbKdIsHUjXDRFwqA1m+5PhnjjU
        pOpSMQB4MWsR2DiGa/uIajuN17EsfNiOM3QpMcEGlU2IO6/0YEMX1JVIrO9kXVqz
        6gLfgIN/3YPi1jeicTXzvAX0O+6E45HAAGa/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VSkNmfZ1XvJ1nKljAzQdZe9fRfqBJhUd
        otlFgGYc9DYakOE24fEqlEd3yWEnk2Dd4IALQITnQlti4f/WiXopa7H6Hndjf/Fl
        GGsFcbOe9DWWmJKa3Dp3sGNoCf0zMUT8uqZXW6j/9ljJ8eFohmDIueGhIxaVVddw
        rKozBKlOKus=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0284F2D603;
        Fri, 11 Oct 2019 20:27:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CF4F2D602;
        Fri, 11 Oct 2019 20:27:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     James Coglan <jcoglan@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 01/11] graph: automatically track visible width of `strbuf`
References: <pull.383.git.gitgitgadget@gmail.com>
        <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
        <20191010230550.GA42541@generichostname>
        <xmqq7e5cjbwj.fsf@gitster-ct.c.googlers.com>
        <20191011050111.GA94866@generichostname>
        <nycvar.QRO.7.76.6.1910111800220.46@tvgsbejvaqbjf.bet>
        <79463ee5-a171-53a8-4903-84a825c4e8d8@gmail.com>
Date:   Sat, 12 Oct 2019 09:27:47 +0900
In-Reply-To: <79463ee5-a171-53a8-4903-84a825c4e8d8@gmail.com> (James Coglan's
        message of "Fri, 11 Oct 2019 18:20:43 +0100")
Message-ID: <xmqqo8ymg64c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E4D040E-EC87-11E9-A80A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

James Coglan <jcoglan@gmail.com> writes:

> - We don't want a general solution to this problem for everything
> `strbuf` could be used for; it only needs to address the graph
> padding problem.

Of course.  Somebody may use strbuf to hold rows of a table and you
do not want to contaminate strbuf with fields like width of each
column etc, that are very specific to the application.  IOW, strbuf
is merely _one_ component of a larger solution to each specific
problem, and the latter may be things like "struct graphbuf" like
Dscho suggested, which might use strbuf as an underlying
<byte-string, length> tuple mechanism, but that is an implementation
detail that should not be exposed to the users of the struct (and
that is why he did not call, and you should not call, the data
structure "graph-strbuf" or anything with "strbuf").

> - We only want to count printing characters, not color formatting sequences.

OK.  But I'd phrase "count printing characters" as "measure display
width" for at least two reasons.  Whitespaces are typically counted
as non-printing, but you do want to take them into account for this
application.  Also the graph may not be limited to ASCII graphics
forever, and byte- or character-count may not match display width on
a fixed-width display.

> - We only need to consider the width of a small set of characters:
> { | / \ _ - . * }. We don't need to worry about Unicode, and the
> simple character counting in graph.c was working fine.

I have to warn you that we saw attempts to step outside these ASCII
graphics and use Unicode characters for prettier output in the past.
If you can do so without too much complexity, I'd suggest you try
not to close the door to those people who follow your footsteps to
further improve the system by pursuing the avenue further.

> To this end I've prepared a different implementation that
> introduces the indirection described above, and does not modify
> `strbuf`:
>
> +struct graph_strbuf {
> +	struct strbuf *buf;
> +	size_t width;
> +};

Is there a reason why you need a pointer to a strbuf that is
allocated separately?  E.g. would it make it harder to manage
if the above were

	struct graphbuf {
		struct strbuf buf;
		int width; /* display width in columns */
	};

which is essentially what Dscho suggested?

> +static inline void graph_strbuf_addch(struct graph_strbuf *sb, int c)
> +{
> +	strbuf_addch(sb->buf, c);
> +	sb->width++;
> +}
> +
> +void graph_strbuf_addchars(struct graph_strbuf *sb, int c, size_t n)
> +{
> +	strbuf_addchars(sb->buf, c, n);
> +	sb->width += n;
> +}
> +
> +static inline void graph_strbuf_addstr(struct graph_strbuf *sb, const char *s)
> +{
> +	strbuf_addstr(sb->buf, s);
> +	sb->width += strlen(s);
> +}

I'd probably introduce another helper that takes color code and
graphbuf (also notice how I name the variables and types; calling
something sb that is not a strbuf is misleading and inviting
unnecessary bugs):

    static inline void graphbuf_addcolor(struct graphbuf *gb, unsigned short color)
    {
            strbuf_addstr(gb->buf, column_get_color_code(color));
    }

if I were writing this code.  The goal is to make any strbuf_add*()
that is done directly on gb->buf outside these helpers a bug--that
way, grepping for strbuf_add* in this file would become a very easy
way to catch such a bug that bypasses the graphbuf_add*() layer and
potentially screw up the column counting.

Other than these three points (i.e. naming without "strbuf" that is
an implementation detail, embedded vs pointer of strbuf in the
graphbuf, and making sure everything can be done via graphbuf_add*()
wrappers to make it easier to spot bugs), it seems you are going in
the right direction.  Thanks for working on this.
