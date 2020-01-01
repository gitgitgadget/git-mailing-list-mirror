Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291B7C2D0DC
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 09:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58CC2073D
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 09:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgAAJVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 04:21:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36484 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAJVp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 04:21:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so3296405wma.1
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 01:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqPnxvbnkVomwkbhEkEGR1On4bssbJ7Um69ah+4jJDY=;
        b=JBkMQEVHV7VpJ2WLwHkGm/Z6e80jpcNme07wa5wjmkQgmjEnL6/d390+9GcANUw1gr
         iCLWb5CeuqlIR3vTGEsq8l1trulHMnL0aRTlQYYfhPLQ26x5W8ibe5C8YguoVOiAkcfY
         dVWbIaCe+DAbdT0GUO087Z980b3mXgFXbiNcFSc9kJwSHgj7maE+jiqSoJbrZVIfygZD
         geaswZNHVA7/FCk2DbmTatWFF0lziUk/zTE1LsgWAJuER1GerHxVihTcvGlAamFQNlRc
         JSyvEv/hWj6CJ7X51cwcqd5UunU8QQIaGh57ISxvImcYjCP7Xp9hVBDdTxVPGzJR4QB6
         UuxQ==
X-Gm-Message-State: APjAAAVH3k8xZOOgjFpCl8218SmPpUgi4qJCXd3fbnpqFgxcQRZHSrV0
        9pTW2XEqOd8y8iUKcj9ZtZuRFDuqsLA+dWqb8CY=
X-Google-Smtp-Source: APXvYqyY9CL0oLrfU5LCODeOgXN91BMd3Wup8NucjsKobk0+D7WLDL+5LvRXiD7RbcAaZfqe+e4/mjw8t0C+Hi1/O4M=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr8968439wml.55.1577870503041;
 Wed, 01 Jan 2020 01:21:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577454401.git.liu.denton@gmail.com> <4fe247c09df89ebe908f366ee7c2a4ec1c209d86.1577454401.git.liu.denton@gmail.com>
 <CAPig+cQmO2W7kcqWZwrSsC7-vkk_UVcC5NktY+0dddcyaegr6Q@mail.gmail.com> <20200101084840.GC5152@generichostname>
In-Reply-To: <20200101084840.GC5152@generichostname>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Jan 2020 04:21:31 -0500
Message-ID: <CAPig+cSeuZRySuaOAvNTiy1eyH0AQ4is-g8LLA7-wC+CztuH0A@mail.gmail.com>
Subject: Re: [PATCH 05/16] t2018: don't lose return code of git commands
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 1, 2020 at 3:48 AM Denton Liu <liu.denton@gmail.com> wrote:
> On Fri, Dec 27, 2019 at 04:42:53PM -0500, Eric Sunshine wrote:
> > On Fri, Dec 27, 2019 at 8:48 AM Denton Liu <liu.denton@gmail.com> wrote:
> > > We had some git commands wrapped in non-assignment command substitutions
> > > which would result in their return codes to be lost. Rewrite these
> > > instances so that their return codes are now checked.
> >
> > Try writing your commit messages in imperative mood:
> >
> >     Fix invocations of Git commands so their exit codes are not lost
> >     within command substitutions...
>
> I thought that the preferred form of commit messages is to introduce the
> problem that I'm trying to solve first ("We had some git commands losing
> return codes") then, after that, describe the changes I made in
> imperative mood ("Rewrite these instances...").

My suggested rewrite includes both the problem ("exit codes ... lost
within command substitutions") and the change in one sentence. The
shorter you can make the commit message without omitting important
information and without being outright cryptic, the better. Let the
patch itself do the talking as much as possible.

Here's an example, from another patch in this series, which provides
too much information:

    While we're at it, replace the test_might_fail(), which should
    only be used on git commands, with a compound command that always
    returns 0, even if the underlying ls fails.

The bit about "...with a compound command..." is unnecessary and
wastes reviewer time and is far more difficult to understand than
simply looking at the code in the patch itself. This would have been
sufficient:

    While here, stop using test_might_fail() with 'ls' since it should
    only be used with git commands.

> From what I can tell,
> all of my commit messages conform to this template.
> I'd prefer to keep the "problem statement" introduction in my commit
> messages as it primes readers so they know "why" before "what" but I
> can't think of any way to phrase the "problem statement" part in a way
> that sounds good without resorting to past tense. Any suggestions?

Using past tense makes it ambiguous to reviewers whether you're
talking about the state of the code which existed some time back or if
you're talking about the state of the code immediately before this
patch is applied. Try rewriting your commit messages without words
like "previously", "before", "had", "now", etc. For instance, the
commit message for this patch could be rewritten (keeping your wording
as much as possible) like this:

    t2018: don't lose return code of git commands

    The exit code of git commands wrapped in non-assignment command
    substitutions is lost. Rewrite these invocations so the exit codes
    are checked.
