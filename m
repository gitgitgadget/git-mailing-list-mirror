Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFF1C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 02:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835032084D
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 02:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="zoPlarcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDUCLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725829AbgDUCLM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 22:11:12 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96A4C061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 19:11:11 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g10so9334045lfj.13
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 19:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1Qyb4BwRQ65OhoIZ/8rLC4XT81DOhgQYPKrmmgCbLI=;
        b=zoPlarcZgptsjvAXvOThMK2lYhbiWKQ1YOmgta/gbGG98ENJYSMRHrafzJ8Qe9rVo7
         DWo8nvm7iZG7sPmcTA9YXKHzjxIKdsBTH16ZeSOCIBMW395YA0XHgLFtwh3ealKM7LR1
         pLzRjM0ePqcgNtKaWg8HeN+jMK92ayFIaQWZveXgd1Z2SEEDsS7hFqyav347sHHOhd70
         W2f5M52gwpbeQvshCDzAl+eK+JnOLmqLn5r3hWwVqqLcWn2Vf/lGi5L9ApbTBmqdbL3N
         LA7uY09BwG8VFOuVTQQj3X5+HI/M1IwBZ3nIjh3beWX4BGmUZuzWJXs5+Mtj0q5SIoXL
         yBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1Qyb4BwRQ65OhoIZ/8rLC4XT81DOhgQYPKrmmgCbLI=;
        b=EARNrcUqSmeXPC+C+xUuMKNL4U0uDymrEpa9piBV7Uv+G9rd6xibWONJ85Jo3x8vxF
         FiCqE/9uANMs+ktOcX4sKCqHbl0+yrWosMC3IhdpR/0cjGs442TUeWexQpAse49w7kgV
         mAHXtMk13dEd379c/KEHqfGZhMllT8GA6osVHVSoTmmKrW/m0i8Ivzkf4oa+IDkCu9BF
         ZxuXAxHJ5x3CScm07oWn3nsH921XL32MyiCxi3n4p6R0fy1no6Q2zBWxZBxwaJu0qRr1
         26S7NM+0jDq6BGyVAC++mhRkjYP8pa1AqRt6SXm7THkw4+QsKxmNkJQ36KzMlPx/Mf+h
         +nzQ==
X-Gm-Message-State: AGi0PubgCViw/4ycz72RcSYXblKQqrLuwZFyipqXsyCiZZS829QODDl4
        EJZkM7liG4W4UBV5SeBZczSMJPm0VwuwsMbKBsm8oA==
X-Google-Smtp-Source: APiQypI9XpmB4zYUs9EhuvpgbTCqikbCxU/bP4UZ3AVDMl6qBh0G0VBcb9P534Mki1jWmmx1A+wPf4BQ6T3VtDAZnD4=
X-Received: by 2002:ac2:5455:: with SMTP id d21mr12420037lfn.23.1587435070124;
 Mon, 20 Apr 2020 19:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com> <CAHd-oW7yfD74ymARoOHXUqB==RcS36S-8D4M8ysAoVcC6GBR9A@mail.gmail.com>
In-Reply-To: <CAHd-oW7yfD74ymARoOHXUqB==RcS36S-8D4M8ysAoVcC6GBR9A@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 20 Apr 2020 23:10:58 -0300
Message-ID: <CAHd-oW6PQNC-ZFj6ydbHFzfL4KpSwXVSd8s3H429tOiRgSra8A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Elijah, Stolee and others

On Tue, Mar 24, 2020 at 7:55 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Tue, Mar 24, 2020 at 4:15 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Mon, Mar 23, 2020 at 11:12 PM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> > >
> > > Something I'm not entirely sure in this patch is how we implement the
> > > mechanism to honor sparsity for the `git grep <commit-ish>` case (which
> > > is treated in the grep_tree() function). Currently, the patch looks for
> > > an index entry that matches the path, and then checks its skip_worktree
> >
> > As you discuss below, checking the index is both wrong _and_ costly.
> > You should use the sparsity patterns; Stolee did a lot of work to make
> > those correspond to simple hashes you could check to determine whether
> > to even walk into a subdirectory.
[...]
> OK, makes sense.

I've been working on the file skipping mechanism using the sparsity
patterns directly. But I'm uncertain about some implementation
details. So I wanted to share my current plan with you, to get some
feedback before going deeper.

The first idea was to load the sparsity patterns a priori and pass
them to grep_tree(), which recursively greps the entries of a given
tree object. If --recurse-submodules is given, however, we would also
need to load each surepo's sparse-checkout file on the fly (as the
subrepos are lazily initialized in grep_tree()'s call chain). That's
not a problem on its own. But in the most naive implementation, this
means unnecessarily re-loading the sparse-checkout files of the
submodules for each tree given to git-grep (as grep_tree() is called
separately for each one of them).

So my next idea was to implement a cache, mapping 'struct repository's
to 'struct pattern_list'. Well, not 'struct repository' itself, but
repo->gitdir. This way we could load each file once, store the pattern
list, and quickly retrieve the one that affect the repository
currently being grepped, whether it is a submodule or not. But, is
gitidir unique per repository? If not, could we use
repo_git_path(repo, "info/sparse-checkout") as the key?

I already have a prototype implementation of the last idea (using
repo_git_path()). But I wanted to make sure, does this seem like a
good path? Or should we avoid the work of having this hashmap here and
do something else, as adding a 'struct pattern_list' to 'struct
repository', directly?

Thanks,
Matheus
