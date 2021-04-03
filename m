Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD746C43460
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 03:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4BB611C0
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 03:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhDCDE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 23:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhDCDE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 23:04:58 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36375C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 20:04:56 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c24-20020a9d6c980000b02902662e210895so5958415otr.9
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdROCVsCVpmBmhHEPe6ocn6pSSKGp6LgpM+2ILnDhKU=;
        b=cqnjmYFbIEhFLo3gn7rTc7Z0ebqcSlqTHWnp3M9RDlpVoxNc6YQcHxkiiXVULlFjyA
         ZdPCFfnsV2LBse/OSzC0DKoENM3Bqsi8oQwHIUqKMVhPUDn7NVhf8yBqvsjZl07zdgIR
         qFkcnHLt5f+XLYSZssTV80pb3gzIZb7C2Q4/fL/+f72U9y/wFi1ryVHYWSVXutZiRBeh
         JvR5oG/aSeXOIx3DBCj66a3/3mYAochROPY/C93zpOTlThJW0FudwHAV+y9E90gp1f1Y
         VH+1msdFas0EhZCPa3KLBZ4+pv5kQ6oKAjpX1l9Rgp9W4XRt93d1GhAF51TF/A8tBCI+
         sXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdROCVsCVpmBmhHEPe6ocn6pSSKGp6LgpM+2ILnDhKU=;
        b=ARDk8ofjIOcWI1YzA6QwaVDiYW2x70VYKc4+DKqudzj5kPDawCg6OTqiDIz7L8jw2g
         FkCoZ46VnOeRPC31pe0B3swr7fVcyuu/wFrbTP2wsFhzSVMzYOd3EIDB512f8jKk74c6
         m9xi72mzL/34Tq8WOMpn6vZ9QE3k1ySA0JEk+eVEHpdVnL2f5QSt0d/+Er/4uANF26YP
         foQr8ipYOWd1A+ZMSa7AZNVYmxV+s+KDep+GHOxjSiG0XRgaUV64PzZvuw3IYlBrO7Lm
         Gv4DVAK19lDgSpsAz2L9cwXDqeiqL61vQfKToaLnb9N4/fJwFPhZe6HSfaeNgM3gWsyg
         m5yQ==
X-Gm-Message-State: AOAM5324AVRZIFmlFn76FZQ6/72iuOVKMsbKQZUW6CXSNEv6EtJhYXos
        MakXYGravbk2bdo/PmSkhlC5zPjJFc82AmfsviEZWSRJguBf3A==
X-Google-Smtp-Source: ABdhPJxlHCu4Q8iDTAOTV8xX0JO9jXCT1sC3hYCeg98f4jIneIQ+QwcX+LufPmzM/2Ex1ywY1poo/G1CBPWmr8VDzPA=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr13506786otf.162.1617419095400;
 Fri, 02 Apr 2021 20:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210403013410.32064-1-jerry@skydio.com>
In-Reply-To: <20210403013410.32064-1-jerry@skydio.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Apr 2021 20:04:44 -0700
Message-ID: <CABPp-BGSgyAH0w21Vrv_bdPaLg+rCPViktbUmM6fMbmxaK70qA@mail.gmail.com>
Subject: Re: [PATCH 0/1] git-apply: Allow simultaneous --cached and --3way options
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Git Mailing List <git@vger.kernel.org>, ross@skydio.com,
        abe@skydio.com, brian.kubisiask@skydio.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 2, 2021 at 6:36 PM Jerry Zhang <jerry@skydio.com> wrote:
>
> I'm creating a script/tool that will be able to cherry-pick
> multiple commits from a single branch, rebase them onto a
> base commit, and push those references to a remote.
>
> Ex. with a branch like "origin/master -> A -> B -> C"
> The tool will create "master -> A", "master -> B",
> "master -> C" and either make local branches or
> push them to a remote. This can be useful since code
> review tools like github use branches as the basis
> for pull requests.

Not sure I understand the "master -> A", "master -> B" syntax.  What
do you mean here?

> A key feature here is that the above happens without
> any changes to the user's working directory or cache.
> This is important since those operations will add
> time and generate build churn. We use these steps
> for synthesizing a "cherry-pick" of B to master.
>
> 1. cp .git/index index.temp
> 2. set GIT_INDEX_FILE=index.temp
> 3. git reset master -- . (git read-tree also works here, but is a bit slower)
> 4. git format-patch --full-index B~..B
> 5. git apply --cached B.patch
> 6. git write-tree
> 7. git commit-tree {output of 6} -p master -m "message"
> 8. either `git symbolic-ref` to make a branch or `git push` to remote

Yeah, folks have resorted to various variants of this kind of thing in
the past.  It is a clever way to handle some basic cases, but it does
often fall short.  It's unfortunate that cherry-pick and rebase cannot
yet just provide this functionality (more on that below).

It may also interest you that rebase has two different backends, one
built on am (which in turn is built on format-patch + apply), and one
built on the merge machinery (which the am --3way also uses when it
needs to).  We deprecated the format-patch + apply backend in part
because it sometimes results in misapplied patches; see the "Context"
subsection of the "BEHAVIORAL DIFFERENCES" section of the git-rebase
manpage.  However, the am version would at least handle basic renames,
which I believe might cause problems for a direct format-patch + apply
invocation like yours (I'll also discuss this more below).

> I'm looking to improve the git apply step in #5.
> Currently we can't use --cached in combination with
> --3way, which limits some of the usefulness of this method.
> There are many diffs that will block applying a patch
> that a 3 way merge can resolve without conflicts. Even
> in the case where there are real conflicts, performing
> a 3 way merge will allow us to show the user the lines
> where the conflict occurred.
>
> With the above in mind, I've created a small patch that
> implements the behavior I'd like. Rather than disallow
> the cached and 3way flags to be combined, we allow them,
> but write any conflicts directly to the cached file. Since
> we're unable to modify the working directory, it seems
> reasonable in this case to not actually present the user
> with any options to resolve conflicts. Instead, a script
> or tool using this command can diff the temporary cache
> to get the source of the conflict.

Looks like you're focusing on content conflicts.  What about path
conflicts?  For example, apply's --3way just uses a per-file
ll_merge() call, meaning it won't handle renames, so your method would
also often get spurious modify/delete conflicts when renames occur.
How does your plan to just "cache" conflicts work with these
modify/delete files?  Will users just look for conflict markers and
ignore the fact that both modified newfile and modified oldfile are
present?  I'm also curious how e.g. directory/file conflicts would be
handled by your scheme; these seem somewhat problematic to me from
your description.

> Happy to address any feedback. After I address any major
> changes I will add new tests for this path.

Don't know the timeframe you're looking at, but I'm looking to modify
cherry-pick and rebase to be able to operate on branches that are not
checked out, or in bare repositories.  The blocker to that
traditionally has been that the merge machinery required a working
directory.  The good news is that I wrote a new merge backend that
doesn't require a working directory.  The bad news is I'm still trying
to get that new merge backend through the review process, and no
current release of git has a complete version of that new backend yet.
Further, the changes to cherry-pick and rebase have not yet been
started.  There were some decisions to make too, such as how to handle
the case with conflicts -- just report them and tell the user to retry
with a checkout?  Provide some kind of basic information about the
conflicts?  What'd be useful to you?
