Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 615311F461
	for <e@80x24.org>; Mon, 24 Jun 2019 12:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfFXMz2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 08:55:28 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:46348 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfFXMz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 08:55:28 -0400
Received: by mail-vs1-f47.google.com with SMTP id l125so8459943vsl.13
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLng9uw1fYOghgltZpduFvmuHnXpxnFgGJ/8zJe25M0=;
        b=gxgrDOCar303dAAo7iWlhHQ3w9sp2Sw5/46noaQoRJacisOBygSyMbQ2XkjYkWLhxA
         5yPLIRIg90PiuLNYPvr6ww1WqoNJq/w1/k3es+kB6bgdL54ZnwZHKNsNIuoz9V0qS6MT
         IGh9xbnSBPxKHzHmBRH2l2VjJhGudZEzMJZYflwAL4co3AAWA+/8H9wEf0zGxmro0VX0
         jvp7CjBujw43rsObB677Atc9g7qPtm0LpcKgcjvBchpybeFXrG3nzSHeCbELilz0QDYG
         hNRkUeQUreWRZ1dyi+P8FwlxgCihKX18Vs6vVgDkRUj8pCa6AJwEUf0Kt4q7jdjhDfNH
         mdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLng9uw1fYOghgltZpduFvmuHnXpxnFgGJ/8zJe25M0=;
        b=ijJLmaDY9oXPfVMwiibjt/cXowhlogs+GVBWejaNPrP8LbXC6pLxzFXsjP2ES6BtaA
         Q2Ijb3hi99SHUwGBwZK1I0oCSlsCE9Ab1xWKaqTK7gS+dQWxclA1zHztW7SAkKd8OO2N
         YeA/06lxN+tawwDjPIhacVZ6taSOn/riqQ64oCEGvFp4gimPydZp8NxEZVY98ch/Rl3r
         4DpWP+C0sIX2k43ykIX9F3x0y6nbvDLMTNDBuxs+jXvJDL5+rxiPNYL4MhCOPy2wwMmh
         QfPCY0AVkJp+bm+MCD9PlqO3UH+JCmNlUjjLTUsr/q/mlNeovXAfkgm/Ki6x6mxpOFOV
         aqAA==
X-Gm-Message-State: APjAAAXfUT7dP9TDoObLgEdQGDkj+cj89dvKThpPBpEgFzoQOzzspF9/
        2C1jakvhA7+P3QPHa0CfoPdTZc9K1BcpCC4vrkc=
X-Google-Smtp-Source: APXvYqxTDwzbVnRjehPCxdX0Ux8w3t3rxV8Ib9wkZ+MF6nwHVvrswVKw9pMsxwoXNjL16jvo2BrUbIUSVP7TGX5irO4=
X-Received: by 2002:a67:c419:: with SMTP id c25mr70621560vsk.136.1561380926936;
 Mon, 24 Jun 2019 05:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <95EF0665-9882-4707-BB6A-94182C01BE91@gmail.com>
In-Reply-To: <95EF0665-9882-4707-BB6A-94182C01BE91@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 24 Jun 2019 06:55:15 -0600
Message-ID: <CABPp-BFLJ48BZ97Y9mr4i3q7HMqjq18cXMgSYdxqD1cMzH8Spg@mail.gmail.com>
Subject: Re: [BUG] Symbolic links break "git fast-export"?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 5:05 AM Lars Schneider <larsxschneider@gmail.com> wrote:
>
> Hi folks,
>
> Is my understanding correct, that `git fast-export | git fast-import`
> should not modify the repository?

I forgot to respond to this part.  The answer is mostly yes, but actually no:

* fast-export strips any extended commit headers, if any (it only
looks for expected headers and handles those)
* fast-export omits any tags of trees
* fast-export sometimes rewrites tags of tags of commits to tags of
commits (depends on options passed; it either mistakenly does this, or
dies with an error)
* fast-export defaults to re-encoding commits to be in UTF-8, with no
option in git <= 2.22.0 to leave the encoding alone
* annotated tags outside of the refs/tags/ namespace will have their
location mangled
* references that include commit cycles in their history (which can be
created with git-replace(1)) will not be flagged to the user as an
error but will be silently deleted by fast-export as though the branch
or tag contained no interesting files
* fast-export or fast-import may die on some repositories (e.g. if
there are tags of blobs, if there are signed tags and no
--signed-tags= option passed, if a commit has improperly formatted
info such as a timezone with more than four digits (which exist in the
wild, e.g. in the rails repo, and google will find you more), or in
latest git master if the commit has a recorded encoding and no
--reencode option is passed)
* ...and the bug you just found.

It's a valid question whether these are bugs or not; I'd say that some
definitely are, but not all.  I had to document all of these up at
https://github.com/newren/git-filter-repo#inherited-limitations, among
one or two others based on the options I default to passing to
fast-export.

Hope that helps,
Elijah
