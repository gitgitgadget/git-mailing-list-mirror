Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81A1C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC4A6108B
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbhDSTPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbhDSTPa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 15:15:30 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D832C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:15:00 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 66so18152581vsk.9
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=57zOmhGy1JIQy759OCkvJ2ItWOkDNMgiZUGN8TQGxZI=;
        b=SDOVGAaK752wvLyZ19i38xJEmywYdE+INuWQVFQCLZY4DNowxhwbzAT65S4OPf0PQz
         St443wD4r0quGHlBxX/By8fPEQ6YPgdZzQFdedmgC762arBKObRY/BtG0CJ42KmiESNK
         nGbcG7S90YPUFOV+9CbADG/C169AJxXSU75/vJ/eAumszo43rQB0etP1Y8yONVYTTIda
         wiac5CYVrLqdM19KrmE75KLFRX2Mc+PLcN9f53jSmxifR2PckJV3ngxdUkMXQbhycOvH
         rreu0nUkMRr/oUhk9bzKSB51VbyFcU3ucOW9EzOiTNLrU8FLLO53LbMZe/NlnrHkeMRi
         HW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=57zOmhGy1JIQy759OCkvJ2ItWOkDNMgiZUGN8TQGxZI=;
        b=J1CooL9wYqDfWzRFwcaL6ZFpPxrNTWkpXuTYQuw9qQxB1fLy4tPm94rya2ojORHOOK
         3a8IcGLWYiofMHuk28lq4yATTi+2rAg9ekXWNssS+eRvt2loD7ndNcS1rlkuvSamUcNR
         /TY7AqbPzE96PzoGRvShnr42cmlQX0icwlxr6h5YByLAnYDmjgZq9Es9cGPX26ToXE5p
         2yL5PiU+1yMYFRRsRGgohFBATANAL6iTwWu2pMzVPyYkhgiKIPuAk4fBhQpV41JOtk5+
         IvezRj+Y1m2vNWtb1Vct6o39DXzSSiA6b9RbgR8PtsSrqpkH1aR5ZblJKl6nyUwL8XeW
         rvNg==
X-Gm-Message-State: AOAM532jWPOdi6rS5oQf3i0q7qWouCDCWXUzli0YVy5inxjbfGY/n4tu
        8QFUuJP/+IcIovicwLQtHT0HC3dqBwepoTiLJUg=
X-Google-Smtp-Source: ABdhPJyzneEgKUF7PtY0Tg4Ai8TFukW6rp/jean2/G7r8Xy0zWPOztG4yBspuwKPPCGRYZT2a5suG2qx9fKdJ3s2+ms=
X-Received: by 2002:a67:69ce:: with SMTP id e197mr6880537vsc.27.1618859699302;
 Mon, 19 Apr 2021 12:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <YHofmWcIAidkvJiD@google.com>
In-Reply-To: <YHofmWcIAidkvJiD@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 19 Apr 2021 12:14:48 -0700
Message-ID: <CA+P7+xqzsD+pU=-9YUYdGDAqT4uVk=XS4sdxA5WnAXL_7GwM5Q@mail.gmail.com>
Subject: Re: RFC/Discussion - Submodule UX Improvements
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, albertcui@google.com,
        Junio C Hamano <gitster@pobox.com>, matheus.bernardino@usp.br
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 4:38 PM Emily Shaffer <emilyshaffer@google.com> wro=
te:
>
> Hi folks,
>
> As hinted by a couple recent patches, I'm planning on some pretty big sub=
module
> work over the next 6 months or so - and =C3=86var pointed out to me in
> https://lore.kernel.org/git/87v98p17im.fsf@evledraar.gmail.com that I pro=
bably
> should share some of those plans ahead of time. :) So attached is a light=
ly
> modified version of the doc that we've been working on internally at Goog=
le,
> focusing on what we think would be an ideal submodule workflow.
>
> I'm hoping that folks will get a chance to read some or all of it and let=
 us
> know what sounds cool (or sounds extremely broken). The best spot to star=
t is
> probably the "Overview" section, which describes what the "main path" wou=
ld look
> like for a user working on a project with submodules. Most of the work th=
at
> we're planning on doing is under the "What doesn't already work" headings=
.
>
> Thanks in advance for any time you spend reading/discussing :)
>
>  - Emily
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> It's worth mentioning that the main goal that's funding this work is to p=
rovide
> an alternative for users whose projects use repo
> (https://source.android.com/setup/develop#repo) today. That means that th=
e main
> focus is to try and reach feature parity to repo for an easier transition=
 for
> those who want to switch. As a result, some of the direction below is aim=
ed
> towards learning from what has worked well with repo (but hopefully more
> flexible for users who want to do more, or differently).
>
> There are also a few things mentioned that are specifically targeted to e=
ase use
> with Gerrit, which is in wide use here at Google (and therefore also a
> consideration we need to make to keep getting paid ;) ).
>
> Overview
> =3D=3D=3D=3D=3D=3D=3D
>

One thing that I think I didn't see covered when I scanned this, that
is something I find difficult or annoying to resolve is using "blame"
with submodules. I use blame a lot to do code history analysis to
understand how something got to the way it is. (Often this helps
resolve issues or bugs by using new context to understand why an old
change was broken).

It has bothered me in the past when I try to do "git blame
<path/to/submodule>" and I get nothing. Obviously there are ways
around this: you can for example just log the path and get the commit
that changed it most recently, or try to search for when the submodule
was set to a given commit.

A sort of dream I had was a flow where I could do something from the
parent like "git blame <path/to/submodule>/submodule/file" and have it
present a blame of that files contents keyed on the *parent* commit
that changed the submodule to have that line, as opposed to being
forced to go into the submodule and figure out what commit introduced
it and then go back to the parent and find out what commit changed the
submodule to include that submodule commit.

> When the work is completed, users should be able to have a clean, obvious
> workflow when using best practices:
>
> To download the code, they should be able to run simply git clone
> https://example.com/superproject to download the project and all its subm=
odules;
> if partial clone is configured, they should receive only the objects allo=
wed by
> the filter in their superproject as well as in each submodule.
>
> To begin working on a feature, from the superproject they can 'git switch=
 -c
> feature', and since the new branch is being created, a new branch 'featur=
e' will
> be created for each submodule, pointing to the submodule's current 'HEAD'=
. They
> can move to a submodule directory and begin to make changes, and when the=
y
> commit these changes normally with 'git commit' from the submodule direct=
ory,
> running git status in the superproject will reflect that a submodule has
> changed. Next, they can switch to a second submodule, making and committi=
ng more
> changes.
>
> When they are ready to send these changes which are ready for review but =
need to
> be linked together, they can switch back to the superproject, where 'git =
status'
> indicates that there are changes in both submodules. They can commit thes=
e
> changes to the superproject and use 'git push' to send a review; Git will
> recurse into affected submodules and push those submodule commits appropr=
iately
> as well.
>
> While the user is waiting for feedback on their review, to work on their =
next
> task, they can 'git switch other-feature', which will checkout the branch=
es
> specified in the superproject commit at the tip of 'other-feature'; now t=
he user
> can continue working as before.
>
> When it's time to update their local repo, the user can do so as with a
> single-repo project. First they can 'git checkout main && git pull' (or '=
git
> pull -r'); Git will first checkout the branches associated with main in e=
ach
> submodule, then fetch and merge/rebase in each submodule appropriately. F=
inally,
> they can 'git switch feature && git rebase', at which time Git will recur=
sively
> checkout the branches associated with 'feature' in each submodule and reb=
ase
> each submodule appropriately.
>
