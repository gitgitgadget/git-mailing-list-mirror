Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564A6C2BB9A
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 15:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8412251E
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 15:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439483AbgLNPvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 10:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439386AbgLNPvs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 10:51:48 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E581C0613D6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 07:51:08 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id x13so10599651oic.5
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 07:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ts2zBAEdm7cXCuuj5qC0wbDkKfOcJYwqmq+e5QNz2Eo=;
        b=PQrZIRtoFMT2WkcF+VNQKIvddJvLMXYEPkeqwEXil8mWT6WKQRAHBVW0b3Y6Po2l9O
         kU4YlT04GjD+RBaWA1Lx67dnWt0la5C+sZfqPI7mYwBC7rhld+5w1r2YzAsqmYiylJEJ
         ZgkASpFTXpDNItymODymZWodXFqSxwe57/cZXaN7XZvITldJFWXuEJRp13oE7XSnUvak
         02GfYxB1M9KZLHi8jEex9wv3cqRiVtpmrB7062oCm+gNXPfzCc94Iuxkh6Zojx9rju6S
         m3wrXLjBYOlkzElP4FLOEQOO7I3iTdtysz8W46kpzGgiZo1NYBe5t43wP/sBbloqwfOp
         MIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ts2zBAEdm7cXCuuj5qC0wbDkKfOcJYwqmq+e5QNz2Eo=;
        b=PwXHm5PiSau0Z0NYMEOIKhDJZf5UYK7jtkX2mAkvMc9xFsCP/HiSGUfhfCX+6T0WUd
         Aq29/9TwaVsYwEAnpBeYn3SF6qfJFdpuuHTndeCLl1mRYxDbrJ/hQ8pVsGP3e5Ucqk6S
         SoRw+AnWpW1bSeurhwT2WhqJ44FBZsD21cMbX9W5Mmj6EnIvZW1938dozkBtZ06vKREA
         nuvbEq7tF/g8GrfF6GeSG2gIBmxmfWEfQngVh6E3v7eizflMyDN8vO+G0Phv9/61D5zq
         p2vitkteuuzYWVL+v7fi1fFfIMwcE5yOFMaDS6haMidr+THO+YZiIQcaMFnbzeU7zJcb
         RjFA==
X-Gm-Message-State: AOAM531n0NDDDudYQJWtGsB5xCPitYMYWV+X0kEMOMsC+Lj4dCpIJCxw
        E0qcgFtIpQzTw4t7FQ+adPE=
X-Google-Smtp-Source: ABdhPJyibrrbuKoW9d9InKBy6mgHVt2X9kpSVg/yz7il0FsUR8ApcFhSIUPiUcIJV4QsuKnyk7M8cw==
X-Received: by 2002:aca:410:: with SMTP id 16mr18740918oie.97.1607961067540;
        Mon, 14 Dec 2020 07:51:07 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q127sm4446029oia.18.2020.12.14.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 07:51:06 -0800 (PST)
Date:   Mon, 14 Dec 2020 09:51:05 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Message-ID: <5fd789e99119d_d21eb208c1@natae.notmuch>
In-Reply-To: <87blewwoil.fsf@evledraar.gmail.com>
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <20201211210508.2337494-1-jonathantanmy@google.com>
 <87blewwoil.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Dec 11 2020, Jonathan Tan wrote:
> =

> > When cloning an empty repository, a default branch is created. Howeve=
r,
> > it is named after the locally configured init.defaultBranch, not the
> > default branch of the remote repository.
> >
> > To solve this, the remote needs to communicate the target of the HEAD=

> > symref, and "git clone" needs to use this information.
> >
> > Currently, symrefs that have unborn targets (such as in this case) ar=
e
> > not communicated by the protocol. Teach Git to advertise and support =
the
> > "unborn" feature in "ls-refs" (guarded by the lsrefs.unborn config).
> > This feature indicates that "ls-refs" supports the "unborn" argument;=

> > when it is specified, "ls-refs" will send the HEAD symref with the na=
me
> > of its unborn target.
> >
> > On the client side, Git will always send the "unborn" argument if it =
is
> > supported by the server. During "git clone", if cloning an empty
> > repository, Git will use the new information to determine the local
> > branch to create. In all other cases, Git will ignore it.
> =

> I'm not a fan of this change not because of the whole s/master/whatever=
/
> discussion, but because of the magic it adds for seemingly little gain =
&
> without any documentation.

I am against the master rename, and yet I am in favor of this patch.

I have been running git with "init.defaultbranch=3Dfoobar" to prepare
myself to a future in which the Git project chooses an objectively
inferior default branch name.

When I clone an empty repository, I expect the branch name to be chosen
by the person who created that repository (not 'foobar'). If GitHub
chooses to name the default branch "main", they can tell their users to
always clone the empty repository, and the users don't need to be
instructed to do anything else (like "git init -b main").

This way the Git project could follow a simple maxim:

  He who creates the repository chooses the master branch name

And this in addition offloads the burden on the Git project to choose a
particular default branch name.

> So if I have init.defaultBranch explicitly set that'll be ignored on
> "clone", but on "init/git remote add/fetch" it won't?

It is already ignored on clone... except when the repository is empty.

> I think so, and I swear I knew yesterday when I read this patch, but no=
w
> I can't remember. Anyway, the point that I avoided re-reading the patch=

> to find out, because even if there's an on-list answer to that it shoul=
d
> really be documented because I'll forget it next week, and our users
> will never know :)

I think the patch does bring the expected behavior. The current behavior
is the one that is unexpected, and has been unnoticed simply because
most repositories use the name "master".

Some people would call that unexpected behavior a bug.

By removing the bug we don't have to document it.

> This patch also leaves Documentation/config/init.txt untouched, and now=

> under lsrefs.unborn it explicitly contradicts the behavior of git:
> =

>     Allows overriding the default branch name e.g. when initializing
>     a new repository or when cloning an empty repository.

That should be updated.

> Shouldn't this at the very least be a
> init.defaultBranchFromRemote=3D<bool> which if set overrides
> init.defaultBranch? We could turn that to "true" by default and get the=

> same behavior as you have here, but with less inexplicable magic for th=
e
> user, no?

I don't think init.defaultbranch has lived long enough for people to
rely on the "buggy" behavior.

> It seems if you're a user and wonder why a clone of a bare repo doesn't=

> give you "init" defaults the only way you'll find out is
> GIT_TRACE_PACKET and the like.

Yeah, but who created that repository?

If you configure Git to use "master", and cloning a new repository from
GitHub fetches "main", you know who to blame.

Let them take backlash.

I suspect they will eventually be forced to provide an option.

> Another reason I'm not a fan of it is because it's another piece of
> magic "clone" does that you can't emulate in "init/fetch". We have
> e.g. --single-branch as an existing case of that (although you can at
> least do that with parse ls-remote -> init -> config -> fetch), and
> that's a case that doesn't fit into a refspec.
> =

> But shouldn't there at least be a corresponding "fetch" option? On init=

> we'll create head, but "git fetch --clobber-my-idea-of-HEAD-with-remote=

> ..."?

That would be better, yes.

But let's not let the perfect be the enemy of the good.

> And on the "litte gain" side of things: I very much suspect that the
> only users who'll ever use this will be some big hosting providers (but=

> maybe not, the commit doesn't suggest a use-case).

Yes, and that's enough reason.

I say let's offload the branch name decision to them, and let *them*
deal with the fallback from their users.

> Wouldn't this be even more useful in those cases by just a pre-receive
> hook on their side detecting an initial push refusing "master", and:

But that's not what they want to do (I suspect).

They want the default branch name be "main", but still the user could
rename the branch, do the initial commit, and push without problems.

Yes, it would take years to roll this change, but it also takes years
for them to update their initial repository instructions too (they
haven't included "git init -b main" yet).

Cheers.

-- =

Felipe Contreras=
