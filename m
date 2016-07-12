Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D72C1F744
	for <e@80x24.org>; Tue, 12 Jul 2016 02:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbcGLCBz (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 22:01:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752616AbcGLCBy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 22:01:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB56A2C8E6;
	Mon, 11 Jul 2016 22:01:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ys7cVaOYwgv+XFIUpVUItB+hyMA=; b=kkohfM
	LjbtnAx1s4i0Y/eioCLA0qv/Pf6LY5f7HqT3gEsfc0bCopyLvkrowU9uOPQbt+kQ
	6/d+uHF39h5gu3Gdtc/z0gxjldUhuE2db5jlwR/csGoORgtJunXAduBSvO+IhC7D
	jiuwKDbShT0GLbqMvu24R4spOOIVHBmEjhKm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tVe1DQdxEOA6IOLYwqlRaVNQCVdThTs4
	0JDgL5dvpsXuZQ6SIl+V3nueUTAet1AP08pWQUITi7uwbXidEn3AWv5kI4koaaoY
	Uzs8OeB/vvcyGPjKGShcfl1it2K8OMcGPKeuDcdF/5C3Xfm7iPxW/ReXr8q7VvP3
	EqQvjl7HUnA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E34B12C8E5;
	Mon, 11 Jul 2016 22:01:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 692CF2C8E4;
	Mon, 11 Jul 2016 22:01:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] doc/pretty-formats: describe index/time formats for %gd
References: <20160711050201.GA18031@sigill.intra.peff.net>
	<20160711050513.GC32514@sigill.intra.peff.net>
	<20160711164834.GC3890@thunk.org>
	<20160712000841.GB26163@sigill.intra.peff.net>
Date:	Mon, 11 Jul 2016 19:01:50 -0700
In-Reply-To: <20160712000841.GB26163@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 11 Jul 2016 20:08:42 -0400")
Message-ID: <xmqqtwfv7gxd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A0AC316-47D4-11E6-9EA3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Maybe this on top of the other documentation patches?
>
> -- >8 --
> Subject: [PATCH] doc/pretty-formats: explain shortening of %gd
>
> The actual shortening rules aren't that interesting and
> probably not worth getting into (I gloss over them here as
> "shortened for human readability"). But the fact that %gD
> shows whatever you gave on the command line is subtle and
> worth mentioning. Since most people will feed a shortened
> refname in the first place, it otherwise makes it hard to
> understand the difference between the two.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/pretty-formats.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 36a300a..b95d67e 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -149,9 +149,12 @@ endif::git-rev-list[]
>  - '%GK': show the key used to sign a signed commit
>  - '%gD': reflog selector, e.g., `refs/stash@{1}` or
>    `refs/stash@{2 minutes ago`}; the format follows the rules described
> -  for the `-g` option
> -- '%gd': shortened reflog selector, e.g., `stash@{1}` or
> -  `stash@{2 minutes ago}`
> +  for the `-g` option. The portion before the `@` is the refname as
> +  given on the command line (so `git log -g refs/heads/master` would
> +  yield `refs/heads/master@{0}`).
> +- '%gd': shortened reflog selector; same as `%gD`, but the refname
> +  portion is shortened for human readability (so `refs/heads/master`
> +  becomes just `master`).

Sounds about the right amount of detail to me.  Thanks.

>  - '%gn': reflog identity name
>  - '%gN': reflog identity name (respecting .mailmap, see
>    linkgit:git-shortlog[1] or linkgit:git-blame[1])
