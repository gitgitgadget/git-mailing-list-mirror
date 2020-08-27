Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA18EC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 01:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B5B2087C
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 01:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KneDth2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgH0Br2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgH0Br2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 21:47:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D7C061347
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 18:47:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g1so2176875pgm.9
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 18:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SMe2B3OujUAyTX66D3v5SmJli4IQnuMxm/MtyZZUs4g=;
        b=KneDth2vAqD2hPafEGTZPb1vY4TWIp0Z2opxj0majKErMNaKeseZ7U7QCE3eKPHFVl
         n4ownOPhlwLJus2mFpaaKjoP30y5fDv7bgtR2eAdLLS2jNBVGtwAYYLdQtxe+3OfBaAQ
         p2id9SyRUstNaoRJq/coMtxTM6u9ybNHP2g3u9GVNvxWFcy9nIMw5u+zYCGb9jbU1rau
         GQ0+QEY0TbOdvpUIfDZX1CDyKaSZJ3zcmc695MyG/e2I2n4hpwTV24nCR6ZCTm/qHBrg
         zVGcpR1/vCQxjyKcdhNuITNcgetlhijpcnt0pfwAz5iwTKYq66X8DhrCjomn83/tj/g5
         xz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMe2B3OujUAyTX66D3v5SmJli4IQnuMxm/MtyZZUs4g=;
        b=Ct3D0ioybfdfRfUpvGolEeTpKRIr9UEI8aHSNx8OhneYjL4ZnYkYLCm3uzHFrPC55h
         lsy5qJO5g1MX9Ja3nAZQazO/jhxFMbk29AiwLIeHDFrJcc58buI4H6/qCk9XRzae1EeW
         RpC5gqsv/viv8qc4HrxlYzPzUdSnU0QwSCQJk/fZrJckS084dv3DQ09PVWvnjG3Vxsmq
         uk/WMCZViENhbXUtWtHVA4BOOVEu/y96R+LzQ+xirVuQzW0ORQueS15HW1Tseq/QFF0J
         3MMYve4a/lbdcUopfcJCl9oLKf7TWWKFQHb1KiTfPNtmGD/rrWElZo6sDj3jXYK8QnZZ
         mgBg==
X-Gm-Message-State: AOAM532y1GjqgDgVGn40u0bP9HWmWYKZnsQkzniT9AYQ5DyEFk95SvU4
        QigdBTb4MuzCLexslFxd+2TKdt/63aI=
X-Google-Smtp-Source: ABdhPJzPkxAk6P3blv3MK8+sjRrQngOqZOdYEn8hEnLPwEPla8FPdYhP+ZdaNCtDcXl9Mxw0RpwZsg==
X-Received: by 2002:a62:fb0e:: with SMTP id x14mr14745471pfm.34.1598492846378;
        Wed, 26 Aug 2020 18:47:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id s8sm290867pgp.36.2020.08.26.18.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 18:47:25 -0700 (PDT)
Date:   Wed, 26 Aug 2020 18:47:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] wt-status: expand, not dwim, a "detached from" ref
Message-ID: <20200827014723.GA750502@google.com>
References: <20200513004058.34456-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513004058.34456-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> When a user checks out the upstream branch of HEAD and then runs "git
> branch", like this:
>
>   git checkout @{u}
>   git branch
>
> an error message is printed:
>
>   fatal: HEAD does not point to a branch

Interesting.  Even worse, it happens when I run "git status".

[...]
> This is because "git branch" attempts to DWIM "@{u}" when determining
> the "HEAD detached" message, but that doesn't work because HEAD no
> longer points to a branch.
>
> Therefore, when calculating the status of a worktree, only expand such a
> string, not DWIM it. Such strings would not match a ref, and "git
> branch" would report "HEAD detached at <hash>" instead.
[...]
> -	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
> +	if (expand_ref(the_repository, cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
>  	    /* sha1 is a commit? match without further lookup */

Alas, as Junio mentions downthread, this patch produces a regression
in behavior: before,

	$ git checkout --quiet master@{u}
	$ git status | head -1
	HEAD detached at origin/master

after,

	$ git checkout --quiet master@{u}
	$ git status | head -1
	HEAD detached at 675a4aaf3b2

This ends up being a bit subtle.

The current branch can be in one of three states: I can be on a branch
(HEAD symref pointing to a ref refs/heads/branchname), detached (HEAD
psuedoref pointing to a commit), or on a branch yet to be born.
__git_ps1 in contrib/completion/git-prompt.sh, for example, is able to
show these three states.

Since b397ea4863a (status: show more info than "currently not on any
branch", 2013-03-13), "git status", on the other hand, gives richer
information.  In the detached case, naming the commit that HEAD points
to doesn't really give a user enough information to orient themself,
so we look at the reflog (!) to find out what the user had intended to
check out.  Reflog entries look like

	checkout: moving from master to v1.0

and the "v1.0" can tell us that v1.0 is the tag that we detached HEAD
on.

This strikes me as always having been strange in a few ways:

On one hand, this is using the reflog.  reflog entries are
historically meant to be human-readable.  They are a raw string, not
structured data.  They can be translated to a different human
language.  Other tools interacting with git repositories are not
guaranteed to use the same string.  Changes such as the introduction
of "git switch" could be expected to lead to writing "switch:" instead
of "checkout:" some day.

Beyond that, it involves guesswork.  As b397ea4863a explains,

	When it cannot figure out the original ref, it shows an
	abbreviated SHA-1.

The reflog entry contains the parameter passed to "git checkout" in
the form the user provided --- it is not a full ref name or string
meant to be appended to refs/heads/ but it can be arbitrary syntax
supported by "git checkout".  At the time that the checkout happened,
we know what *commit* that name resolved to, but we do not know what
ref it resolved to:

- refs in the search path can have been created or deleted since then
- with @{u} syntax, the named branch's upstream can have been
  reconfigured
- and so on

If we want to know what ref HEAD was detached at, wouldn't we want
some reliable source of that information that records it at the time
it was known?

Another example is if I used "git checkout -" syntax.  In that case,
the reflog records the commit id that I am checking out, instead of
recording "-".  That's because (after "-" is replaced by "@{-1}") the
"magic branch" handler strbuf_branchname replaces @{-1} with with the
branch name being checked out.  That branch name *also* comes from the
reflog, this time from the <old> side of the

	checkout: moving from <old> to <new>

line, and <old> is populated as a simple commit id or branch name read
from HEAD.  So this creates a bit of an inconsistency: if I run "git
status", "git checkout -", "git checkout -" again, and then "git
status" again, the first "git status" tells me what ref I had used to
detach HEAD but the second does not.

Okay, so much for background.

The motivating error producing

	fatal: HEAD does not point to a branch

is a special case of the "we do not know what ref it resolved to"
problem described above: the string @{upstream} represents the
upstream of the branch that HEAD pointed to *at the time of the
checkout*, but since then HEAD has been detached.

[...]
> One alternative is to plumb down a flag from dwim_ref() to
> interpret_branch_mark() that indicates that (1) don't read HEAD when
> processing, and (2) when encountering a ref of the form "<optional
> ref>@{u}", don't die when the optional ref doesn't exist, is not a
> branch, or does not have an upstream.

Given the context above, two possibilities seem appealing:

 A. Like you're hinting, could dwim_ref get a variant that returns -1
    instead of die()ing on failure?  That way, we could fulfill the
    intent described in b397ea48:

	When it cannot figure out the original ref, it shows an abbreviated
	SHA-1.

 B. Alternatively, in the @{u} case could we switch together the <old>
    and <new> pieces of the context from the

	checkout: moving from master to @{upstream}

    reflog line to make "master@{upstream}"?  It's still possible for
    the upstream to have changed since then, but at least in the
    common case this would match the lookup that happened at checkout
    time.

Thoughts?

Thanks,
Jonathan
