Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC35C636D4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 03:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBKCyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 21:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKCyG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 21:54:06 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447F87F80B
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:54:05 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w5so8559204plg.8
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ph+Vj2o3ItZjIu/aerzz6N0Zr8i343rcILbeybOxTTQ=;
        b=AcrdentGflQDtfwtEALhMUygv4BIAJtmCDstVlunc38EyRsYF8tXIfOOHerj9athZ4
         5GP9zm7eJeyraZbEiIU/imufApByV+3Cnlu/mtAKWfuxbKFfTegPH1BW8ntHR3IaaKGz
         e0WjqTqRpGKt422E0nyjGvNy5HcDkfeLwcY6Lo/7PAT/33UejCGqyR/ApfBu39U7HXL7
         cX6K2mssWqUnjUqbtA6rZWw4lcjZLSJ8KhK1GggzOGNhmWpSGrnI6/Ppl2lEn/XRa49W
         nKGB/WaUGfZGEzaL0GtI0GRf0R1nWE3fCiFDTz42jYuckiFu+vBLelR+qmZr27Arp2J2
         mRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ph+Vj2o3ItZjIu/aerzz6N0Zr8i343rcILbeybOxTTQ=;
        b=2tH1dOtYYu5c4NRo4vkcNKSWBnLThreTQdm2gSRXwgsC8Cl/uHrWwTQElN54KG0RfG
         ZYWyKQOT296AEOATPq42yM3j6pTyxrd44TqKDClpKQ9b/lShVsu+kKMk2O5xqh4UBbXw
         1QGpHGOl7CjSI76/otkkJikVFN1UjZVhzR7S69bkRegmlwf2ZoGwALLTCM8i/0w1b1Gl
         sCPwWJnlxzWe2NehHAWBs2uS5ytC30uzV2wzIb8Hj1WKh9+9Vr5ZOWgrrMOuzRZBidZ5
         n1WSp436A3mNstoZIhL4jMBd5n5sUMSWDnRRbLbL9PreWr4ALfZ1IscveAF4oUtT2ivw
         xDlg==
X-Gm-Message-State: AO0yUKUz/GNU2rC47FORJAaJbmeQOU3G5M2d4+tmfecsHnaHsKfbh72F
        32xpQXTMbFRvQEkunr/nJps=
X-Google-Smtp-Source: AK7set+Gp2ospxqSr7PzA6Tu9nglNGOb9aQZ6QAnHHkvvOBnFBgPd+FV5B1IaA2nOrgPwRAAwL4ccw==
X-Received: by 2002:a17:902:e807:b0:196:8d48:8760 with SMTP id u7-20020a170902e80700b001968d488760mr20143105plg.31.1676084044583;
        Fri, 10 Feb 2023 18:54:04 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709027c1600b0019907b82a24sm4004349pll.273.2023.02.10.18.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 18:54:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     William Blevins <wblevins001@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/ls-remote: clarify pattern format
References: <Y+cAdZTs5y0yiTkM@coredump.intra.peff.net>
        <Y+cBFF0OPSq8DGnA@coredump.intra.peff.net>
Date:   Fri, 10 Feb 2023 18:54:03 -0800
In-Reply-To: <Y+cBFF0OPSq8DGnA@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 10 Feb 2023 21:44:36 -0500")
Message-ID: <xmqq5yc8gbec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We document that you can specify "refs" to ls-remote, but we don't
> explain any further than that they are "matched" as patterns. Since this
> can be interpreted in a lot of ways, let's clarify that they are
> tail-matched globs.
>
> Likewise, let's use the word "patterns" to refer to them consistently,
> rather than "refs", and mention more explicitly that only one pattern
> needs to be matched (though there is also an example already that shows
> this in action).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-ls-remote.txt | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index f17567945f..2a941292a4 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
>  	      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
> -	      [--symref] [<repository> [<refs>...]]
> +	      [--symref] [<repository> [<patterns>...]]

Micronit.

builtin/ls-remote.c::ls_remote_usage[] needs a matching update.

>  
>  DESCRIPTION
>  -----------
> @@ -85,11 +85,14 @@ OPTIONS
>  	either a URL or the name of a remote (see the GIT URLS and
>  	REMOTES sections of linkgit:git-fetch[1]).
>  
> -<refs>...::
> +<patterns>...::
>  	When unspecified, all references, after filtering done
> -	with --heads and --tags, are shown.  When <refs>... are
> -	specified, only references matching the given patterns
> -	are displayed.
> +	with --heads and --tags, are shown.  When <patterns>... are
> +	specified, only references matching one or more of the given
> +	patterns are displayed. Each pattern is interpreted as a glob
> +	(see `glob` in linkgit:gitglossary[7]) which is matched against
> +	the "tail" of a ref, starting from a slash separator (so `bar`
> +	matches `refs/heads/bar` but not `refs/heads/foobar`).

Good.  Is it too obvious that the pattern `refs/heads/bar` matches
the ref `refs/heads/bar`, even though it becomes fuzzy what
"starting from a slash separator" means in such a scenario?
