Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19486C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 23:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiGVXTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 19:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGVXTC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 19:19:02 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C144D12B
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:19:00 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id bz13so4565519qtb.7
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNr86PxL0hEt/XNa+l01Rg4krYPvnZ4GVzAO7x7i8D8=;
        b=C4/BgYVP3WWU5Dc8GS+mzZJN3smHAKCvqc8b+fHwOtW/aWw1QJ0ZNnZGGb/cbK0E/F
         6nCm0gC81TFtxz75IJGQQhJw4Lb5DbXJlGbkD0Epm9ZavQqvLpBAYoam9xhHKPSrcwEi
         x8aVKWrrfePlo4Oda5r4owjLUfMJ5Q2E7x9QDMdhWo55rVTn8uaLs81k2KKs6PkOt/Qg
         FJkX7r46Bc5bo6m08EcV2GFQT2uZx2eqBIuzJH1YhGzLGIZZ62fl7Lup16/pYtd8efm7
         vUoxdth2sqSiCJIqpEzoTsiiNuQDGMY7JmUanHqnBSv6X0tQk9ROtaObDF1NFS7AA4ag
         NpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNr86PxL0hEt/XNa+l01Rg4krYPvnZ4GVzAO7x7i8D8=;
        b=QTozrIYJHXFxVY1nP2TJwQlchF0/16gUoIN+6jiknkS5yWuDB5nJbdsaxGyFJdbdb1
         mMD8jif+0WPUh70KXfue7E2cbwHlbeN5fn5o2cs3vqsrQclJt0LdwA+bfnzvAOkEXFiu
         ZuInvHBIMCTtWEKVCr8/0TFAPryPDZGtWnxoyww6M+DvUu9ZQEqE3V+XuVsGW7Dd5Jsq
         iycqSWAANHnYDVuij1Jm7T/ShGtEauu7chQi9azpuhQZzwC85iM0Oat8l5e39WNneW8h
         UTtkgxuh1fSp3zIska6Zf2i95nTd3humXpvYj06iYyyvERYWckoB5aXfKEh5fqcLnGxk
         P8vQ==
X-Gm-Message-State: AJIora/DPZ1fvU0p3QO/3Ui6EBI+wHi3EVzTA6FUcf3SD1Zw29ICXADU
        TTTrvg2tzA3YY0pUh6nqKztV9j57qC8po7b2MpD2+A/ZEkY=
X-Google-Smtp-Source: AGRyM1vGGYukFlsTwqKdv1PHsmlxewj3rdYv5+MxxWjxtxwNgrEu7MK+xz1ybkQfpxckHYoSObwz6eZ/OhE/2kSQK3Q=
X-Received: by 2002:a05:622a:412:b0:31e:daba:4fc9 with SMTP id
 n18-20020a05622a041200b0031edaba4fc9mr2158475qtx.541.1658531939245; Fri, 22
 Jul 2022 16:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220721151937.adgufwkj3uxkk3yb@meerkat.local>
In-Reply-To: <20220721151937.adgufwkj3uxkk3yb@meerkat.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 Jul 2022 16:18:48 -0700
Message-ID: <CABPp-BE2391i7syZJUK1Nqjk9VZhSxqto0pb7xBLDZR_fY3FXA@mail.gmail.com>
Subject: Re: [filter-repo] How to reorder commits
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 8:19 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Elijah:
>
> It seems filter-repo can be used to easily reorder commits, but I'm not able
> to quite figure out how to do it with callbacks. My goal is:
>
> - keep the cover letter at the start of the series in order to cleanly
>   delineate where their work starts (and thus avoid potential problems with
>   rebases and finding fork-points with base branches, which tends to give
>   newbies trouble)
> - when the author is ready to submit their work, move the cover letter to the
>   tip of the branch and tag it as "foo-bar-v1"
> - when the author is ready to work on their changes, they run --reroll and we
>   move the cover letter back to the start of the series, adding any necessary
>   template "changes in vX" entries to it
>
> (or maybe it will go completely differently -- it's all very fluid right now)
>
> Basically, is git-filter-repo the right tool to reorder commits, or is it best
> to go directly with fast-export/fast-import?
>
> Thanks in advance,
> Konstantin

Generally, it makes no sense to reorder commits in filter-repo, nor
does it make sense to do so using fast-export/fast-import directly.
fast-export/fast-import don't "apply a diff" to get a new tree, they
say "Make these files have these exact contents".  Perhaps an example
would help to explain what I mean...

Let's say you have a repository where some commit has a file
consisting of the numbers 2-9 on separate lines.  Then you had two
more commits after this one: Commit A has numbers 1-9 (i.e. inserting
a new first line with a "1"), and commit B has numbers 1-10 (i.e.
adding "10" to the last line of the file).  If you reverse those two
commits in the fast-export/fast-import stream, then B will still have
the numbers 1-10 and A will still have the numbers 1-9 in the file.
That makes it look like B added both lines, and then A removed the
final line, and the end result is a file with one less line than you
had before you reversed the commits.

So, generally, I think you should use a rebase-like tool for
reordering commits rather than anything based on
fast-export/fast-import.


Now, with an empty commit you wouldn't run into these issues and so
you could get away with reordering.  But there is another issue: in
the fast-import stream, you have to list all ancestors of a commit
before you list the commit.  And git-filter-repo parses commits as it
goes.  So you'd have to cache a commit or range of commits without
outputting them, and then later dump them once the new parents have
been output first.  I think a rebase-like tool would probably be
better for this job, but if you really want to, you could probably get
this working in filter-repo with a script similar to the ones in
contrib/filter-repo-demos, but making sure to use steps something like
the following:
  * Avoid commits getting dumped by setting "commit.dumped = 1" (a
"lie" which prevents git-filter-repo from immediately outputting the
commit after your callback)
  * Save the commits in a list somewhere
  * As you are processing the commit(s) that need to be moved earlier
modify the parents of these commit(s) (i.e. the commit.parents field)
appropriately
  * After you've output the commit(s) that needed to be moved earlier,
iterate through the saved commit(s) and modify their parents and call
commit.dump() on them.
