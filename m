Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3205C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 15:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiGMPVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 11:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbiGMPVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 11:21:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930E243303
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 08:21:34 -0700 (PDT)
Received: (qmail 15084 invoked by uid 109); 13 Jul 2022 15:21:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jul 2022 15:21:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13159 invoked by uid 111); 13 Jul 2022 15:21:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jul 2022 11:21:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jul 2022 11:21:32 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] Documentation: use allowlist and denylist
Message-ID: <Ys7i/GWSNRHqSZNQ@coredump.intra.peff.net>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <ec81aac05c40318755f5311a20e8f9cc55d289fc.1657718450.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec81aac05c40318755f5311a20e8f9cc55d289fc.1657718450.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 01:20:48PM +0000, Derrick Stolee via GitGitGadget wrote:

> Using "allowlist" and "denylist" is a more precise definition of the
> functionality they provide. The previous color-based words assume
> cultural interpretation to provide the meaning.
> 
> Focus on replacements in the Documentation/ directory since these are
> not functional uses.

Thanks, the direction looks reasonable to me. I knew at least about the
one for protocol.*, which I think I introduced, and had been meaning to
grep for others.

I think you need some grammatical fixups, though. E.g.:

> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index fdc28c041c7..ff74a90aead 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -33,7 +33,7 @@ It verifies that the directory has the magic file "git-daemon-export-ok", and
>  it will refuse to export any Git directory that hasn't explicitly been marked
>  for export this way (unless the `--export-all` parameter is specified). If you
>  pass some directory paths as 'git daemon' arguments, you can further restrict
> -the offers to a whitelist comprising of those.
> +the offers to a allowlist comprising of those.

You'd want s/a/an/ here.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 302607a4967..384718ee677 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -887,7 +887,7 @@ for full details.
>  	protocols has `protocol.<name>.allow` set to `always`
>  	(overriding any existing configuration). In other words, any
>  	protocol not mentioned will be disallowed (i.e., this is a
> -	whitelist, not a blacklist). See the description of
> +	allowlist, not a denylist). See the description of
>  	`protocol.allow` in linkgit:git-config[1] for more details.

Ditto here.

>  'git daemon' as inetd server::
>  	To set up 'git daemon' as an inetd service that handles any
> -	repository under the whitelisted set of directories, /pub/foo
> +	repository under the allowlisted set of directories, /pub/foo
>  	and /pub/bar, place an entry like the following into
>  	/etc/inetd all on one line:

This one is more gut feeling.  Somehow "allowlisted" as an adjective
seems more awkward than "whitelisted". Probably because I've just seen
"whitelisted" so many more times. Or maybe it just crosses my personal
line of too many syllables. ;)

I don't know if there's an easy way around it. I don't have a suggestion
that's better than "allowlist" for the general term, and we want to use
the terms consistently. You could probably write it as:

  ...any repository under the set of directories in the allowlist...

but I'm sure somebody probably likes that less. :) So I register it only
as a suggestion, not a request for a change.

-Peff
