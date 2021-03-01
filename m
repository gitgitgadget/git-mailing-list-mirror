Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93115C43331
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDA164E41
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbhCASrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 13:47:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56938 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbhCASpN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 13:45:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7339AAB3AA;
        Mon,  1 Mar 2021 13:44:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iMt/xWrWeycXXUSeCC9TuFzEC7Q=; b=aImBHT
        vAGXCh6HgXOgp4qVWlFlYtKpC9/fiwHFka/YnCFfD3fJZ7FHEU6cEYijdWSWza5m
        +VW7YyXRwIpsabwxClIexyBg7hJhpEWQPBvaIPVq4QTIK0dyPnw/u17XCOhHJphP
        zA0Hr9vDbhAHiQ0U/TSQ//IFoMWbFbUgW5Dwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YUxC/evSwmPdH2SGUhY9IUG+9vA0dhYW
        IeyVr9ZM39y9P/UqH+HfIzc3VEKxUXmVPeQb5OoQk3sVJpMCl9wBH/7UWUzqR9xI
        JuT2IRcYxGISsYTU4rTupnLaHmg6VO+jfXqaJEejNRjgVRYrAt88wRkSLwrUWwQ4
        embNJSXnlnA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BCF6AB3A9;
        Mon,  1 Mar 2021 13:44:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E47D6AB3A8;
        Mon,  1 Mar 2021 13:44:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210301084512.27170-7-charvi077@gmail.com>
Date:   Mon, 01 Mar 2021 10:44:30 -0800
In-Reply-To: <20210301084512.27170-7-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Mon, 1 Mar 2021 14:15:14 +0530")
Message-ID: <xmqqczwir9wx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28AA706E-7ABE-11EB-B764-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> +--fixup=[(amend|reword):]<commit>::
> +	Without `amend:` or `reword:`, create a `fixup!` commit where
> +	the commit message will be the subject line from the specified
> +	commit with a prefix of "fixup!'". The resulting "fixup!" commit

What's the single quote in "fixup!'"???  We also have an "amend!'"
below.

> +	is further used with `git rebase --autosquash` to fixup the
> +	content of the specified commit.
> ++
> +The `--fixup=amend:<commit>` form creates an "amend!" commit to
> +fixup both the content and the commit log message of the specified
> +commit. The resulting "amend!" commit's commit message subject
> +will be the subject line from the specified commit with a prefix of
> +"amend!'" and the message body will be commit log message of the
> +specified commit. It also invokes an editor seeded with the log
> ...
> +The `--fixup=amend:` and `--fixup=reword:` forms cannot be used with
> +other options to add to the commit log message i.e it is incompatible

"i.e."

> +with `-m`/`-F`/`-c`/`-C` options.
> ++
