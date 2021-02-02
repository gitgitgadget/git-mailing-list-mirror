Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB9EC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F2560234
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhBBJXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:23:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:44142 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232968AbhBBJWR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:22:17 -0500
Received: (qmail 12501 invoked by uid 109); 2 Feb 2021 09:21:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Feb 2021 09:21:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32410 invoked by uid 111); 2 Feb 2021 09:21:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Feb 2021 04:21:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Feb 2021 04:21:33 -0500
From:   Jeff King <peff@peff.net>
To:     Paul Jolly <paul@myitcv.io>
Cc:     git@vger.kernel.org
Subject: Re: Bash completion suggests tags for git branch -D
Message-ID: <YBkZnY8X5VyNkXkR@coredump.intra.peff.net>
References: <CACoUkn6+9C3+HVVQF905t1siAD9Sqo1JvRa0Whw-J6x7V7icyg@mail.gmail.com>
 <YBkVFTOP6K1//i6m@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBkVFTOP6K1//i6m@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 04:02:13AM -0500, Jeff King wrote:

> > b-is-a-tag is not a branch, so should not be offered as a completion
> > candidate in this instance.
> 
> It looks like lowercase "-d" works. So maybe the "-d" here:
> 
>   $ sed -n '/git_branch/,/^}/p' contrib/completion/git-completion.bash | head 
>   _git_branch ()
>   {
>   	local i c=1 only_local_ref="n" has_r="n"
>   
>   	while [ $c -lt $cword ]; do
>   		i="${words[c]}"
>   		case "$i" in
>   		-d|--delete|-D|-m|--move)	only_local_ref="y" ;;
>   		-r|--remotes)		has_r="y" ;;
>   		esac
> 
> just needs to look for "-D", too?

Oops. I meant to paste the "before" snippet, but this is obviously after
I stuck "-D" in there. It does seem to work. :)

-Peff
