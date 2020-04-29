Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91453C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449012083B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k9ZyCkiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgD2RJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:09:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60296 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgD2RJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 13:09:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34856D6BB3;
        Wed, 29 Apr 2020 13:09:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XMY+ilGCdp+t61rlE+MJ0WjfSxg=; b=k9ZyCk
        iELKufAu2cZcpV0SwgwrsCMT9oQJBCjlbz6g51ZD21uwZbU6BYglVgMWJuqxojAq
        fdMky7czXmUb2EAWyyp1wzOa39xyTAmRcLuuXHXxkesB4Byxr/i5gupqZqKaTJYp
        u5W/4ROka9Vuy3dj2hhR+v/lJYDVoxQypuE0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N+ykYDqQameV+dpCZnnkijX7AZy/Xfau
        IrujDtzBwUSSByEOqnsZw+8UfZA+wLtREtTXvruNoxKRKVzaog6KjBCkIdswcj4O
        DmfvUjPpJ23BmX803vRh3EXFdNWDUm7p+/hPPEZJH+2XEtkxDWXQkw7Xjdct+Ivl
        uik2VhMqb9o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BC62D6BB2;
        Wed, 29 Apr 2020 13:09:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CEFCD6B94;
        Wed, 29 Apr 2020 13:09:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        sandals@crustytoothpaste.net,
        Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/4] gitfaq: shallow cloning a repository
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
        <20200429093811.8475-3-shouryashukla.oo@gmail.com>
Date:   Wed, 29 Apr 2020 10:09:44 -0700
In-Reply-To: <20200429093811.8475-3-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 29 Apr 2020 15:08:10 +0530")
Message-ID: <xmqq7dxyxlpj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A0A5496-8A3C-11EA-AA8A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Add issue in 'Common issue' section which covers issues with cloning
> large repositories. Use partial cloning to selectively clone the
> repository.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> I wanted to ask why is there no mention of partial cloning in
> the 'git-clone' documentation? Is it because it is an experimental
> feature?

If the folks that have been pushing the feature haven't bothered to
document it fully, by definition, it must be a work in progress that
is not ready for the prime time ;-)

Jokes aside, the --filter=<filter-spec> option is mentioned in the
documentation and it says "...is used for the partial clone filter",
without even defining what a "partial clone filter" really is.

The topic deserves its own subsection, between the "Git URLs" and
the "Examples" sections, in git-clone(1).

>  Documentation/gitfaq.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 7d294306f9..6f32846e3d 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -243,6 +243,16 @@ I want to change the remote of my repository. How do I do that?::
>  One can list the remotes of a repository using `git remote -v` command.
>  The default name of a remote is 'origin'.
>  
> +[[shallow-cloning]]
> +The repository I am trying to clone is too big. Is there an alternative
> +way of cloning it in lesser space?::
> +	A good way to save up space when cloning a repository is
> +	by using `partial clones`. A partial clone will clone the
> +	full history of the repository but will skip out the entities
> +	specified by the `--filter` option one uses in `git clone`.
> +	Any entity which has not been cloned to save space can be cloned
> +	on-demand. See linkgit:partial-clone[1].

Where does this link go?
