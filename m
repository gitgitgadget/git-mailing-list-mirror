Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D99C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 05:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA7A65014
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 05:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCEFkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 00:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCEFkE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 00:40:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE08AC061574;
        Thu,  4 Mar 2021 21:40:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b7so923650edz.8;
        Thu, 04 Mar 2021 21:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBCWGdO9ttBa6bwSQbn6+grvew9hSstcWY182hlBYEM=;
        b=rJQXYGimR08jN/gQDfES8jfSvwKcM0pia534mWsfkeY46w1w3Ns96ld7txEzSa4Tp7
         m8xbaH5WMDyWwWnu9++GSiUhFFMx8y9jlrujXEZJk+XMNKtzMKR+CgG2xTPiAHKlZbTN
         cbKrjY2rgsjs66hPNlFHETHTpAzjIj9w1hBZ9wuRb3+FVHe0sMNV/NcwypoU8UWGSbJy
         WLu9RDf7f5FIfwOgBbHLdOHndQcEJxVcxxShvY3zMswgeSoaUkU45SOtYYGZ9p8snaXz
         FgXkPNSkrKSqk9k7mi+2C2OqtRMEkVrAHjqB0xe4OJFV48q00//6gte9HM/fgxKd0w5U
         XFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBCWGdO9ttBa6bwSQbn6+grvew9hSstcWY182hlBYEM=;
        b=gchJ42pu7qWg3oEadxmQyLJ/xb04OtqFqlev8T/XPqgg3VTof/YyuwfReURxdy5uJe
         NL5Lw3+AtGlUJkAZnF7hnTqizTF+6n63JN3ejnoT2XngyYkMFNAZR3KiA96/vJd+8O2y
         PoWfHLD73amUtnT6EeT1t+yssEyP3EIDmP7nBHBVH3AM2vlsTqvfTlGWyDtgUPceyOxD
         AoC4vxFlkw0xaxCColTJwnjEYXFlT32e6LKwkNNnD87pwpBBRWVkeZg/GMtUJ7EBegeR
         o7UEDqShxY/W2F12Z8777UfTVpjPujoDxZtpLy2FTMvVRmOSyT1TKWk9adUK9PWv90Rf
         lYYg==
X-Gm-Message-State: AOAM533fNj40DcBsiC74AWTNmbIVk88H3oB5KD8ECH2M9yN4s7Ukxcbl
        4lL+lhkCB0eaRJxKHfs076jVLSiwAd7Lk85JJ4yJnphSiGs/MA==
X-Google-Smtp-Source: ABdhPJwRYPqV/WwnWo7oMVkuV/nG6sJ/y9vzbn1Nm9xklW0+3v+eQWia67FEOL3YXyt3hmuJKCns0CIPbYxLeZv/mXE=
X-Received: by 2002:a05:6402:5244:: with SMTP id t4mr6521852edd.87.1614922802651;
 Thu, 04 Mar 2021 21:40:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
 <YEFIXFyP5tWrPDMw@localhost>
In-Reply-To: <YEFIXFyP5tWrPDMw@localhost>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 5 Mar 2021 06:39:51 +0100
Message-ID: <CAP8UFD07ezNOXU5Q3RZAHOJGMjuaJY-R=x=hhQcQvYOAKzKF2g@mail.gmail.com>
Subject: Re: A note on the 5.12-rc1 tag
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 5, 2021 at 1:58 AM Josh Triplett <josh@joshtriplett.org> wrote:
> On Wed, Mar 03, 2021 at 12:53:18PM -0800, Linus Torvalds wrote:

> > One additional reason for this note is that I want to not just warn
> > people to not run this if you have a swapfile - even if you are
> > personally not impacted (like I am, and probably most people are -
> > swap partitions all around) - I want to make sure that nobody starts
> > new topic branches using that 5.12-rc1 tag. I know a few developers
> > tend to go "Ok, rc1 is out, I got all my development work into this
> > merge window, I will now fast-forward to rc1 and use that as a base
> > for the next release". Don't do it this time. It may work perfectly
> > well for you because you have the common partition setup, but it can
> > end up being a horrible base for anybody else that might end up
> > bisecting into that area.
>
> Even if people avoid basing their topic branches on 5.12-rc1, it's still
> possible for a future bisect to end up wandering to one of the existing
> dangerous commits, if someone's trying to find a historical bug and git
> happens to choose that as a halfway point. And if they happen to be
> using a swap file, they could end up with serious data loss, years from
> now when "5.12-rc1 is broken" isn't on the top of their mind or even
> something they heard about originally.
>
> Would it make sense to add a feature to git that allows defining a
> "dangerous" region for bisect? Rough sketch:
> - Add a `/.git-bisect-dangerous` file to the repository, containing a
>   list of of commit range expressions (contains commit X, doesn't
>   contain commit Y) and associated messages ("Do not use these kernels
>   if you have a swap file; if you need to bisect into here, disable swap
>   files first").
> - git-bisect, as it navigates commits, always checks that file for any
>   commit it processes, and adds any new entries it sees into
>   `.git/bisect-dangerous`; it never removes entries from there.

The `git bisect skip` machinery uses `refs/bisect/skip-<commit>` refs
instead of such a file, so I wonder if such a file is needed. It could
be used to store a map between skipped commits and the associated
messages though. Or git notes could be used for that purpose.

By the way I wonder what should happen if a commit is associated with
a message by a `/.git-bisect-dangerous` file, but in another branch
such file associates it with a different message. I guess all the
different messages should be stored, and then displayed.

> - git-bisect avoids choosing bisection points anywhere in that range
>   until it absolutely has to (because it's narrowed an issue to that
>   range). This can use something similar to the existing `git bisect
>   skip` machinery. Manual bisections print the message at that point.
>   Automated bisections (`git bisect run`) stop and print the range
>   without narrowing further, unless the user passes something like
>   `--dangerous-ok=commit-range`.

Yeah, using the `git bisect skip` machinery looks like a good idea.
Instead of `/.git-bisect-dangerous`, the file could actually be called
`/.git-bisect-skip` and could also store ranges where the code doesn't
compile, or completely misbehave, without necessarily being dangerous.
The dangerous status would only be conveyed by the associated messages
then.

Another way could be to directly share some special refs similar to
the existing `refs/bisect/skip-<commit>` refs, instead of a
`/.git-bisect-dangerous` file. This would likely raise some issues
about how to create and share these refs and the associated messages
though.

> (git notes would be nice for this, but they're hard to share reliably;
> the above mechanism to accumulate entries from a file in the repo seems
> simpler. I can imagine other possibilities.)

If the notes are created automatically from the `/.git-bisect-skip`
files and stored in `refs/notes/skip`, then they might not need to be
shared. If people already share notes, they would just need to stop
sharing those in `refs/notes/skip`.

> Does something like this seem potentially reasonable, and worth doing to
> help people avoid future catastrophic data loss?

It seems reasonable as part of the skip mechanism.
