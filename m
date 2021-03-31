Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD675C433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9749861957
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhCaAcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 20:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhCaAcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 20:32:31 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05056C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 17:32:31 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so17333417otb.7
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 17:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0n20smEq7a8KOw+8Czxmvja17FS7VvvJgmHB/Mc3kpU=;
        b=kFLxPBHPXaPR2h4lhr3oukVZUB2gPWPM0Ry+w8LYAGnN1fv+TcDZyuYTQBlzG0x9tU
         gBHx4azf9aI+VQYYJCO/jLDwBdntSZqMqAyzpn75X07TDoNFjDQppLAJsW9G90ljVNKw
         jNChLssAtG9ZzCAmc4w6pRd6qvjD27XZXevZbs9KmCfrfGhAG7FN0u6qs+wHZo49z9NC
         qYCoRef2wOZTjq6NcTs4ouD7yoen14zAhYmy/558XnQrtMgv2VZsoQsMR/i2gDTDLdn0
         GvexKgDlCZyLoxiKKB5kR4p2R1nbsoKj6XvL1G+zSfzkVhuodJwlH38KGU1AK/mb1eBL
         oIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0n20smEq7a8KOw+8Czxmvja17FS7VvvJgmHB/Mc3kpU=;
        b=AbgvATxjX4BwDFBBlg8J1j3kgDGXpZpYDqbVNiPjZR3FtoiiZdSy1uX/FvfUPsJqd2
         OnemHUp+bg7cb1P1pYiKvnJWB2C5dNZxU3WUO04dklT22m7KVPj1OEWzE5/peMrXZrVj
         bavNgkVR3vGOmFYLzEfms6hTGf5ZoJZe/RxINQgaPb+VsF/qWcjXEOAcK/SN1gIvRqGW
         oJz4q3kqPWvMJeO47br16VR0XhPj/5nvrEffSs2F6+75NRQAKCLhXtdOYw+ieZz6nSMp
         l30b8vGK1d48sPuOOTHCBsSwAvKZKOxHzubYYSesbzG9D57z+wZgdCuVAaSrqkEh+RWP
         Y/vQ==
X-Gm-Message-State: AOAM532QmdsMrKd8gih+U+X/4rd7A1PFjHagMkibvcMNp7FkZpc11bKR
        AYPEKDBIf56XNXr1Smlxod7O1W0NqCPQ6NPdkTI=
X-Google-Smtp-Source: ABdhPJxV6W+Jwjh7abA78H2Mgc97lgPSWCbfQc4jigT/Kbdt6CxHaXydpW8VjGQlii3PX3OebINY83vI6p1JKmuXw3s=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr399832otf.345.1617150749963;
 Tue, 30 Mar 2021 17:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEAbN05+hCtK=xhGg5uZFqbUvH9hMcCNMcBWp5JWLqzPw@mail.gmail.com>
 <YGLNBFJv8NKmrbvz@coredump.intra.peff.net> <xmqq35wceae6.fsf@gitster.g>
 <CABPp-BEE0eksCJSAviDh5GyqsOu=i_mW3VY6SEULa4kx0NsUMg@mail.gmail.com>
 <xmqqa6qkcnqa.fsf@gitster.g> <CABPp-BEVFi+EsGMCv=qEhe_OGwmWwXF-mg9rjWYNuF0tDZnASg@mail.gmail.com>
 <xmqqlfa4b5we.fsf@gitster.g>
In-Reply-To: <xmqqlfa4b5we.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Mar 2021 17:32:18 -0700
Message-ID: <CABPp-BG+xKr10BpziijMB4j9+F=PCozAFQRdJ1DVBuGGjir40Q@mail.gmail.com>
Subject: Re: Bug report: git branch behaves as if --no-replace-objects is passed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 4:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Your "as long as" is I think the assumption that's violated in the
> > workflow in question.  You may have the replace ref defined, but
> > others don't[1].  Neither party has the actual original deadbeef
> > commit[2].  Having deadbeef in refs/heads/foobar leads eventually to
> > creating commits with deadbeef as an explicit parent, as we discussed
> > above.  While that's internally consistent, as you point out, can you
> > push your new commit elsewhere without pushing the replace refs too?
>
> I think the change to "branch --contains" would be an improvement
> whether you actually have deadbeef or not, but in any case, defining

Great, we agree that branch --contains can be improved.

> (eh, rather, being able to define) a replacement for something you
> do not have is the ultimate source of the problem.  And that "bug"
> has not very much specific to how "branch --contains" should behave.

Okay, perhaps you consider the ability to create a replacement for an
object that doesn't exist as a bug.  How do we handle this bug,
though?  That's not at all clear to me.  Is it documentation updates?
More error messages from various commands?  Code changes to handle
these cases better?  Something else?  This behavior has been allowed
for over a decade, the refs can be created outside of "git replace"
and the replacement mechanism comes with
* documentation claiming there are only two restrictions on
replacement or replaced refs, both bypassable[1]
* documentation claims of robustness for the replace mechanism[2]
* documentation claiming that all non-reachability traversal related
commands will translate replacement refs to the real commit IDs[3]
* user-facing UI to support creating/updating/deleting replace refs

Based on the above, filter-repo has been creating replacement refs for
years now, one for every commit in the repository that wasn't filtered
out.  And I thought it all worked great without any problems, until
the recent report.  I guess I only ever used the old commit IDs to
pass to things like diff, log, etc., and I guess most users either
didn't use the replace refs at all or only used them that way
too...until this week. However, I'm planning to do a very big testcase
of history rewriting (ancient and huge binary blobs) at $DAYJOB later
this year including replace refs for some of the release-team folks,
so I'm kind of concerned about what I need to fix in git or at least
what I need to document.

[1] See the part up to "...There is no other restriction on the
replaced and replacement objects.", from git-replace(1)
[2] "Note that the grafts mechanism is outdated and can lead to
problems...see git-replace(1) for a more flexible and robust system",
from gitrepository-layout(1)
[3] "Replacement references will be used by default by all Git
commands except those doing reachability traversal", from
git-replace(1)

> > Why does `git branch` (in conjunction with one user deciding to fetch
> > replace refs) make it so easy to create a branch that cannot readily
> > be shared with others?
>
> In other words, I do not think it is "git branch" or "git checkout -b"
> that brought your repository into a broken state.  The "replace"
> mechanism may have room for improvement to avoid such a corruption.
>
> IIRC, the original "graft" mechanism did not even have any UI, so it
> was pretty much "you can graft any parent to any child, and if you
> break the repository you can keep both halves".  Now "replace" has a
> dedicated UI component in the form of "git replace" command, we should
> be able to teach it how to record replacement more safely.

I would like to avoid corruption, and I'm happy to have alternate
solutions.  I don't understand how this could be fixed in "git
replace", though, especially since "git replace" was not even invoked
in the real use case under consideration (git filter-repo uses "git
update-ref --stdin" to create the replace objects).

Are there other alternative ways to fix this outside of "git
branch"/"git checkout -b"?

If not, are there technical reasons that "git branch <branchname>
<replace-hash>" and other commands like it could not be adjusted to
write the replacement hash rather than the replaced hash to the new
branch?

Even if there are no alternative fixes and there are technical reasons
that "git branch" and other commands like it cannot be adjusted, I
still feel that translate-old-commit-hashes via
replacement-of-non-existent-commits feature is valuable enough to keep
in filter-repo anyway.  It'd make me a little uneasy, but I'd continue
creating the replace refs and just document the drawbacks in that
scenario.
