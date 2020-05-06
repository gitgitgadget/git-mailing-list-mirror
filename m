Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F16C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 14:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C313B2073A
	for <git@archiver.kernel.org>; Wed,  6 May 2020 14:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="Dl8GNqbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgEFOBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 10:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728667AbgEFOBA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 10:01:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27010C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 07:01:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a8so2008341edv.2
        for <git@vger.kernel.org>; Wed, 06 May 2020 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MtsiH8OKcC4z60PoTixeij+B+GSe3P+Erpa/BJq6G2k=;
        b=Dl8GNqbjSOef2bvkc1a3l8ZPK6Ge6aI0Lgbn9dj3+sz4zHUYZOFJzr+SHiWsiBR/Rb
         s54wMnb1X3uMzGjOrPqSmFvx3TRcOlJlVKNcoZsTtlKbBa12LLq5THtKdbw1krS7wzF2
         I7cnKW/ubDVjU2aOhD8GOZq9kvAsr5NhyGcIuYr/IQW2RmWkBTpjJnzgfCSjDh7y3nqw
         7rtAYkfiF24ES1AvMl8QgFwJxXCNE7xNTwy91JOYsyfavCoQfiW8Nqrc+znKdTIvZYBq
         PMvT3QnqKYNW3a/DNVAuplesFz8ujoiRIvmo0O6TmDNj91be7TNuaHm66pOt8Kk2Ag2K
         lYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MtsiH8OKcC4z60PoTixeij+B+GSe3P+Erpa/BJq6G2k=;
        b=bu7UpfhpNg2An/m3WqB+QKWv4vunW/XZKhbXZUzH7h0PncE/9dLBiabyXFxdaK2MV6
         QWBaKTdZsr0jFAoaDTkD4SiIdjd0UQ86jCkQsSUURUJb/Ktkm/3BvxfGXr8CiVoRcHUn
         r9jTc/9zvlrb3o2wWVHI363Hl3VNxGchBMoKw/unSJH2jVCxjVRfxBPRRrgcNPJIoaEr
         xLoYj0haSsPyelGu53k3PiuWJnaZllLXhdtcWC9aiiBedgm/mMcAGLI3sU6zp0ySO1Nw
         0KOMIO7uQXt0Qz5MYc+JR8TiOCt3b0l985+JGvOCQG2r4GEk3Xrs2a8VX0sCQbeMuHzT
         Ht6A==
X-Gm-Message-State: AGi0PubaGlVGUEcEN0yepZxqFaWkkXese2SdFN1p7rF2XvVVSuHiSHt2
        RZLsKWiI6nS+pDRGKWGedU8DNf8uXAUja0uJYlcbAnj6Lw==
X-Google-Smtp-Source: APiQypKkEG44YhVIt5Gy3LMvWgwE3xjrex0bfnfRydEmCa0duACr5xY7QBAfqo+BcZb8MiNNaKqGRGywtSpvHYhBErM=
X-Received: by 2002:a05:6402:1008:: with SMTP id c8mr6666152edu.242.1588773658514;
 Wed, 06 May 2020 07:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+GP4bqEjK2V7fGqXsJMkRURod8zVzZAQQ7woUUtqybxfnmSVg@mail.gmail.com>
In-Reply-To: <CA+GP4bqEjK2V7fGqXsJMkRURod8zVzZAQQ7woUUtqybxfnmSVg@mail.gmail.com>
From:   Claus Schneider <claus.schneider@eficode.com>
Date:   Wed, 6 May 2020 16:00:47 +0200
Message-ID: <CA+GP4bou+_bvGjnd3Z+fctXX4V2sE=Ta9ivCnYmbn1+JUxKRQg@mail.gmail.com>
Subject: [RFC] subtree: handle unmerged history trees
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi..

I would like to enhance git subtree functionality

Problem outline:
In a scenario where a team develops a software subsystem and part of
the code is internal and parts (source and/or interfaces) should be
delivered continuously for others to incorporate into their
system/product.

One solution is to use submodules structure for both the development
team and product which is a hassle for the development team. They need
to make logical commits across submodule and parent repository which
can be a problem with parallel development and verification.

Subtree has the feature of splitting the repository in order to
achieve this, but there are some constraints that I would fix.
- In bare mode it pushes changes to a separate branch containing the
prefix changes which is fine. You get a problem when you run the next
split. Either you re-split all the commits again - Or you add the
-rejoin parameter with the result that the splitted prefix patches are
part of your history twice or even more if you have further extracts.
So this is either a performance issue or a usability issue.
- You lose traceability from the extracted subtree commit back to you
original commits,

Solution outline using subtree:
- Add traceability to each extracted commit in new history
  - It enables humans to trace from the extracted commit to the
original commit by basic reading, clicking in tools like gitk and
scripting if desired
  - Enable subtree itself to utilize the above mentioned traceability
and simulate the add repository or rejoin merge commit. Subtree can
then "behave" similarly independent of the method being used.
  - Add option for rev-list so it can list based on
prefix/subdirectory. I have not been able to find any error, issues or
side effects adding the "-- $dir" to the rev-list command. All the
manual tests, I have done, behave correctly in my total patched git
revision. It gives a heck of performance for many-commit repositories.
 - Example: split contrib/subtree out of git repository.
    Without the option: parsing ~28000 commit
    With the option: parsing ~100 commits

Patches can be found here:
https://github.com/git/git/compare/master...Praqma:split-append-info-options-master
Commits related to this:
* cd712dda39 subtree: use append-info to only extract new commits in the prefix
* deb2e1cd8b subtree: add append-info option for adding info about
original commit
* ff73b37e22 subtree: Add option for listing commits based on prefix

Best regards
Claus Schneider
