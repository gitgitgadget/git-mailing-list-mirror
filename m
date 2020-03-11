Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBFBC0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE022074D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWzOCZy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgCKUsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:48:09 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:43135 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgCKUsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 16:48:09 -0400
Received: by mail-lf1-f49.google.com with SMTP id q9so2888308lfc.10
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 13:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4+PqvaO+C7RxHkpOja1vO9XlUCrXFnScJtxiJnK1m4s=;
        b=CWzOCZy7NqtxqcvUOXFfs50bwx2sRn+VawjpWClIdgt1QlJ6oSUsZQ96QZvyI36Nx2
         y4jWJ8t/H3TQ9VjxbQUQAZXOaAcmSdWNfwFpTkfy0cidyrAUYRxPGCumWf9rAf5M3t9S
         7TkgYuI0qk4e+QvoGbUwRXpQJUgHl0rNiK3oN85f5FoPHbsuXlcI+Fz2gLW335p2Qhto
         CleyTC42jVh3phpT998Q8WV1patFBVS976K7FR2TM/2nE1pEbGvLekLvt0V1LnGG6oKX
         rWwOwnSV/cL3iQZcAkHgXPVFzaP18RfIaMSKlOciDKc91Z6K2MqlXC+0FaXvakqDJ6rO
         IfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4+PqvaO+C7RxHkpOja1vO9XlUCrXFnScJtxiJnK1m4s=;
        b=oSQkEnD9x2e/RIrfZHvBvl2pxT0fNaks8hbqI/NLuo2YrUKOSzA0wSMRqSDc/u1kTL
         mwEHnOCN77K6YHb9y9nGScvK88UW2BcGFbBzheGXxfcO7WKQaUSUvKm8OqklV5twHFao
         owBCv5n3tk9k3y7yA4Sk0l8FZrp380qj+bc2QSkDlRN2SpXnIM0/oPNZssLsAHDg6UYr
         FuO6UWwLb5kYwIucLWjzHIdlxe8i5ylVPqkvByc/4yVgh04NtEiXBEepPNlqZIswBNQ8
         Bb9VFyy2O/yG2TigPrphXoqWZnpENyamUl77oG3xWs13pw+03scG/U22E9qFNWwAXClf
         28/Q==
X-Gm-Message-State: ANhLgQ046FKx/PWuYXWH0nzzxGuaGNsxb9EOpwqM3Q6NBYKjq9yGzevP
        +gpSCbCZBNoHatiLbCD6q2ZKlzOxybp9FIpde8U=
X-Google-Smtp-Source: ADFU+vvIH+rqdMZxiNV1je5i3saPPMs1pcWEg5oR2LSFode1/edDIWac1yDL+5H5ZejS1qzhqqHmXOB+kYxltwjEX00=
X-Received: by 2002:a19:c18e:: with SMTP id r136mr3040685lff.4.1583959684846;
 Wed, 11 Mar 2020 13:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAGa6KtSgGOLVjHdubwRW=Bvnjnp2PoP7jJ5_NxNWGFLrVYT9SA@mail.gmail.com>
 <2001043.V3P9HlvaID@mfick-lnx> <CAGa6KtQ2dQWPWxbk2MH8QJxemM8QD_O=B3aYzsP5AH-sN-7PSw@mail.gmail.com>
 <12099923.Cjvj2aPIT9@mfick-lnx>
In-Reply-To: <12099923.Cjvj2aPIT9@mfick-lnx>
From:   Christos Pappas <chrispappas99@gmail.com>
Date:   Wed, 11 Mar 2020 22:47:56 +0200
Message-ID: <CAGa6KtTRv1UZcVAWbwUR56wjeK2YE1NqyLe-yT3MrGC8sUYCvw@mail.gmail.com>
Subject: Re: [Feature request] Give non-unique names to commits for grouping
To:     Martin Fick <mfick@codeaurora.org>
Cc:     git@vger.kernel.org, annulen@yandex.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> By "different", do you mean the mechanism, or the content of the "hashtag=
"
> itself? I would imagine that you would expect the hashtags to be differen=
t,
> and that you are concerned that they might be stored differently on each
> site, maybe on one site as a note like
>
>  hashtag: awesome
>
> and on another:
>
>  label: awesome
>
> Is that correct?
>
> If so, then it seems like a reasonable suggestion that some tooling be bu=
ilt
> to potentially enforce something like that using git notes and/or commit
> messages?

Yes, I think that every project would end up having a different convention.

> Right, maybe git notes is just the storage mechanism for such a feature?

Maybe some code could be shared behind the scenes(I don't know the
code architecture), but the interface should be different.

I would expect a commit log to look like this:

commit {commit_hash} (HEAD -> master, tag: maybe_a_tag_here, labels:
bug_fix front_end, origin/master, origin/HEAD)
Author: ...
Date: ...

Commit Message

This also requires at least one command to create a label (git label
create {name}), and a different command to assign one of the available
labels (git label assign {label} {commit}), to avoid mistakes (The
levenshtein algorithm could also be used when the user makes a typo
and tries to assign a label that doesn't exist)

=CE=A3=CF=84=CE=B9=CF=82 =CE=A4=CE=B5=CF=84, 11 =CE=9C=CE=B1=CF=81 2020 =CF=
=83=CF=84=CE=B9=CF=82 9:31 =CE=BC.=CE=BC., =CE=BF/=CE=B7 Martin Fick
<mfick@codeaurora.org> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
>
> On Wednesday, March 11, 2020 8:56:44 PM MDT Christos Pappas wrote:
> > Thank you for your answers.
>
> FYI: the list preference is inline instead of top-posting.
>
> > From what I can deduce, both of your suggestions require that the
> > commit messages(or notes) must have some special text for which we can
> > search for, which is hacky and would be different on every repository.
>
> By "different", do you mean the mechanism, or the content of the "hashtag=
"
> itself? I would imagine that you would expect the hashtags to be differen=
t,
> and that you are concerned that they might be stored differently on each
> site, maybe on one site as a note like
>
>  hashtag: awesome
>
> and on another:
>
>  label: awesome
>
> Is that correct?
>
> If so, then it seems like a reasonable suggestion that some tooling be bu=
ilt
> to potentially enforce something like that using git notes and/or commit
> messages?
>
> > What I am suggesting is something like, labels on GitHub, hashtags on
> > Social-Media, or Tags in News sites. It's a well known concept so it
> > will be easy to understand and use.
> >
> > We could initially create the concept of marks/labels/{another name}
> > ('tags' is already in use by another git command) and then
> > incrementally enhance the git commands to use this functionality (like
> > the example I gave above, with git blame).
>
> Right, maybe git notes is just the storage mechanism for such a feature?
>
> -Martin
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code
> Aurora Forum, hosted by The Linux Foundation
