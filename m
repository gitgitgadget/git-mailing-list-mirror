Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FB2C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 00:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C58E20657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 00:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fb19+78k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgERA03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 20:26:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55997 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgERA02 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 20:26:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FEACDF221;
        Sun, 17 May 2020 20:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wX9yafCp/ddqMt+jpVAtRZZR7Zo=; b=fb19+7
        8kw9Ilz+9A402oJG9UgWyKgrGwRtIPboP8clGuw7/hx7gD26AOrmp10aucUxNH6e
        Xvhw9nOpsyv8w+cPIQfIAKdRg7m4wvcrfaqXJoQ8RhFgghA74oRsAqv9lNx4Inc/
        WrARE5EYqpU3/5GMxA98Z+CmfOXNye/0GTMCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J5TK0ZIuGm48aYutuw4NNdWLtZK+8xv4
        KFvEC2T3Wvz0h3uPL1b5PSTz0e6isltNtgUfJh6z36nlTc67MIkO9Bb6ussCe0TL
        yP/N8Pt/VaYYuWXT4nrXvkjvh3lJkAAFGuAe3uI+8z20OndEGwhMato3CODBLzHt
        nm9IrlF8mKg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 081BBDF220;
        Sun, 17 May 2020 20:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF6B3DF21D;
        Sun, 17 May 2020 20:26:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kenneth Lorber <keni@hers.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 4/6] Include NAMESPACE COLLISIONS doc into gitrepository-layout.txt
References: <1589681624-36969-1-git-send-email-keni@hers.com>
        <1589681624-36969-5-git-send-email-keni@hers.com>
Date:   Sun, 17 May 2020 17:26:21 -0700
In-Reply-To: <1589681624-36969-5-git-send-email-keni@hers.com> (Kenneth
        Lorber's message of "Sat, 16 May 2020 22:13:42 -0400")
Message-ID: <xmqqr1vi5brm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 344DE0DE-989E-11EA-AD2B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kenneth Lorber <keni@hers.com> writes:

> From: Kenneth Lorber <keni@his.com>
>
> Signed-off-by: Kenneth Lorber <keni@his.com>
> ---
>  Documentation/gitrepository-layout.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

As I said elsewhere, I am not sure if we want to even let
third-party tools direct access at the filesystem level to
$GIT_DIR/.  We do want to say things like where the ref namespace
that are taken as "per worktree" are located, so that a third-party
tool wants to carve out a hierarchy out of the per-worktree part of
the ref namespace, that may indirectly influence where on the
filesystem under $GIT_DIR/ their stuff is stored, but how we decide
to store refs inside $GIT_DIR/ should still be blackbox to these
third-party tools (e.g. we may not be using loose or packed refs,
but using a chain of reftable files).  

So from that point of view, we shouldn't have to touch the
repository layout document, I would think.

> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
> index a84a4df513..8050e8cc1f 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -290,9 +290,10 @@ worktrees/<id>/locked::
>  worktrees/<id>/config.worktree::
>  	Working directory specific configuration file.
>  
> -include::technical/namespace-collisions.txt[]
>  include::technical/repository-version.txt[]
>  
> +include::technical/namespace-collisions.txt[]
> +
>  SEE ALSO
>  --------
>  linkgit:git-init[1],
