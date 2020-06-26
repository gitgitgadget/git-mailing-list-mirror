Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77682C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0D7207FC
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cj2Wa6tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgFZQ32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:29:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53749 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgFZQ32 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 12:29:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEA30C2E75;
        Fri, 26 Jun 2020 12:29:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YkhQEpX9hOQytssXtVUlJX5CP3g=; b=cj2Wa6
        tgWfOo/mQ1NfzvmoSBKYWeNrbQRHeG66BmLBO1IJ/YTpfdu1LqkgYonF6f7nSge6
        6t2Yr0bBAmSKEdz3lsa0D1vTj1Q4bZ3vlEHxU7OYVVCjvyb+N+nG79H+2WQXMqjE
        48HzLjnji/kRrREyMzcJeY/jvgQ0GJ2iVN8ME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S59hYZW+asVZzT/2dZQEtUUWVM4xpUw7
        XIJlAMdyQfAzqIrbqWINO9JMM6qKNv4u8PTdrHMugAcsllDqmLzGH1+tJpXnhm+m
        5MRxM29NWwm+2sY2BNbv0B8YiXp7ZRQWqgI0QCTsFF4ZmTndXqIQMImP4fCXfboy
        4vmCg6utNNM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CFB7AC2E74;
        Fri, 26 Jun 2020 12:29:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 057B5C2E70;
        Fri, 26 Jun 2020 12:29:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 4/5] rebase -i: support --ignore-date
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200626095528.117524-1-phillip.wood123@gmail.com>
        <20200626095528.117524-5-phillip.wood123@gmail.com>
Date:   Fri, 26 Jun 2020 09:29:21 -0700
In-Reply-To: <20200626095528.117524-5-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Fri, 26 Jun 2020 10:55:27 +0100")
Message-ID: <xmqqftahhjtq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3186CA82-B7CA-11EA-8EE5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> +/* Construct a free()able author string with current time as the author date */
> +static char *ignore_author_date(const char *author)
> +{
> +	int len = strlen(author);

I'd rather not to see this initialization, because ...

> +	struct ident_split ident;
> +	struct strbuf new_author = STRBUF_INIT;
> +
> +	if (split_ident_line(&ident, author, len) < 0) {

... it is away from this line.  This line is better written

	if (split_ident_line(&ident, author, strlen(author)) < 0) {

to show what the third parameter is about.  It is not just "len",
but is the length of the second parameter, author.

> +		error(_("malformed ident line '%s'"), author);
> +		return NULL;
> +	}
> +
> +	len = ident.mail_end - ident.name_begin + 1;
> +	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);
> +	datestamp(&new_author);
> +	return strbuf_detach(&new_author, NULL);
> +}
