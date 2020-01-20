Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137A3C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E557222525
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATRwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:52:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:40436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726876AbgATRwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 12:52:11 -0500
Received: (qmail 1683 invoked by uid 109); 20 Jan 2020 17:52:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Jan 2020 17:52:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4722 invoked by uid 111); 20 Jan 2020 17:58:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Jan 2020 12:58:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Jan 2020 12:52:10 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v4 1/5] doc: move author and committer information to
 git-commit(1)
Message-ID: <20200120175210.GA3989@coredump.intra.peff.net>
References: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
 <20200120173343.4102954-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200120173343.4102954-2-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 20, 2020 at 05:33:39PM +0000, brian m. carlson wrote:

> diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
> index 4b90b9c12a..adc2e0d4b7 100644
> --- a/Documentation/git-commit-tree.txt
> +++ b/Documentation/git-commit-tree.txt
> @@ -42,6 +42,10 @@ tend to just write the result to the file that is pointed at by
>  `.git/HEAD`, so that we can always see what the last committed
>  state was.
>  
> +A commit comment is read from stdin. If a changelog
> +entry is not provided via "<" redirection, 'git commit-tree' will just wait
> +for one to be entered and terminated with ^D.
> +
>  OPTIONS
>  -------
>  <tree>::

This text got moved up, which kind of make sense to me, but...

> @@ -79,26 +82,6 @@ A commit encapsulates:
>  - author name, email and date
>  - committer name and email and the commit time.
>  
> -While parent object ids are provided on the command line, author and
> -committer information is taken from the following environment variables,
> -if set:
> -
> -	GIT_AUTHOR_NAME
> -	GIT_AUTHOR_EMAIL
> -	GIT_AUTHOR_DATE
> -	GIT_COMMITTER_NAME
> -	GIT_COMMITTER_EMAIL
> -	GIT_COMMITTER_DATE
> -
> -(nb "<", ">" and "\n"s are stripped)
> -
> -In case (some of) these environment variables are not set, the information
> -is taken from the configuration items user.name and user.email, or, if not
> -present, the environment variable EMAIL, or, if that is not set,
> -system user name and the hostname used for outgoing mail (taken
> -from `/etc/mailname` and falling back to the fully qualified hostname when
> -that file does not exist).
> -
>  A commit comment is read from stdin. If a changelog
>  entry is not provided via "<" redirection, 'git commit-tree' will just wait
>  for one to be entered and terminated with ^D.

it stayed here, so now it's duplicated. Should the old one be dropped?
Or is moving the new text a leftover mistake from rebasing (IIRC, in
your original you dropped this whole "here's how commits work" section).

Other than that, the patch looks good to me.

-Peff
