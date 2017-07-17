Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6236920357
	for <e@80x24.org>; Mon, 17 Jul 2017 23:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbdGQXWj (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 19:22:39 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33645 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbdGQXWh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 19:22:37 -0400
Received: by mail-pf0-f177.google.com with SMTP id e26so2137388pfd.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 16:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gk0soYiIFLx/+3ADFiyYNJtDpN1QsaW4hVsuSJtaFfY=;
        b=j2uQE0qOgQu8zHbLhoeiRiA3KZHrR+yuEP2/URyNY/XpJsTpQq2trx4+zLl/U7rpWR
         H8fb96wRVUceqXDZtd0XJUwI2nBxsv9PJcpz1mRnmVfPRmrMFoDcDYfeh0iDBSF/4aHh
         4mabO2UXopkz/OBnGtc8nRhFCAqvW+TffhscpO7ZK/WqWxJiU4mz5DlWRLTYdg33dsTL
         WnWkoR9UMirFy0aj+wm7/vRkyUeKTw62RbScxAzP8M/MAneWSOsU6CoD4WtYrteBi19E
         vD1HE06Yc4jz2geDlAk68ax+GRek0Ncs6AG4Nz+YOjartHghz/h1ZMPliHBv+aYpaUgq
         N6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gk0soYiIFLx/+3ADFiyYNJtDpN1QsaW4hVsuSJtaFfY=;
        b=mAmCYRPhpsQtEKkFkSV/B38WVipF6ID2IhMkxlPxthwEoplkwqI9cz70H+yU5tWXrL
         MZ5ArNvKvYPY6ICJ4zAQizyFp7kHQq8rL00FfzmMenLRBcnzffMdhBVwqPPWEJu2YZdO
         zYT8H7UpMM522dhCJKDR3RV8k5u9Vkk92nnxkKOYQ6i/uMcftvU6uCxGpP9uYifjs4lM
         tKkDxr4wLkbRBLeR25dAtO6QTNKmOmt6HYFRhs8ueltvQQZuDm/6cJxguJprrMlNZOs/
         v1xeBGbhX5DccgzWo+9l9ehVfJwJqyzD+CWrpfPKPOC1wRdVjKxEQqsjH5mOXBGEhzuZ
         5GfA==
X-Gm-Message-State: AIVw111eS+FJTC7SynNTFCEKGZWFbnKt9l8Y7manNO3g0eEJvjS5RztY
        H9j67yCPy5qZsKCbRSkTBcdXdmjYfzKnP1zkNQ==
X-Received: by 10.99.149.79 with SMTP id t15mr3386905pgn.247.1500333756921;
 Mon, 17 Jul 2017 16:22:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Mon, 17 Jul 2017 16:22:36 -0700 (PDT)
In-Reply-To: <xmqqvamqg2fy.fsf@gitster.mtv.corp.google.com>
References: <20170711010639.31398-1-sbeller@google.com> <xmqqvamqg2fy.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Jul 2017 16:22:36 -0700
Message-ID: <CAGZ79kY=j-sgrAFwAhP-_9EKBsa6FXARaVuCxM6gPHV7M+1OAA@mail.gmail.com>
Subject: Re: [PATCH] RFC: A new type of symbolic refs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 2:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I _think_ a symbolic HEAD that points upwards to the gitlink entry in
> the superproject's index is the easiest to understand and it is
> something we can define a clear and useful semantics for.

ok, let's start with that. Once we have that we can see if that also
makes sense for the non-submodule/superproject world.

> When a recursive checkout of a branch 'foo' is made in the
> superproject, the index in the superproject would name the commit in
> the submodule to be checked out.  We traditionally detech the HEAD
> at the submodule to that commit, but instead we could say "check the
> index of the superproject to see where the HEAD should be pointing
> at" in the submodule.  Either way, immediately after such a
> recursive checkout, "git status" inside the submodule would find
> that the HEAD points at the commit recorded in the 'foo' branch of
> the superproject and things are clean.

Right.

> After you work in the submodule and make a commit, an equivalent of
> "git update-ref HEAD" is done behind the scene to update HEAD in the
> submodule.  In the traditional world, that is done to detached HEAD
> and nothing else changes, but if the symref HEAD points upwards into
> the index of the superproject, what needs to be done is very obvious;
> we do "git add submodule" in the superproject.  And this is not just
> limited to creating a commit in the submodule.  "reset --hard HEAD~2"
> in the submodule to rewind the HEAD by two commits would also be an
> update to HEAD and through the symref-ness of the HEAD should result
> in an update to the index of the superproject.

agreed. we'd find out what HEAD~2 is and then write the gitlink in the
superproject index to be that commit.

> However, I do not think a good explanation of what should mean when
> this new-style symbolic HEAD points at a commit in the superproject,
> whether its limited to its HEAD or a tip of an arbitrary branch that
> may not even be checked out.

The proposal only inspects the currently staged value of a gitlink, there
is no way to reference a specific commit or (non-checked-out) branch,
so it is not possible to point at them with the given read syntax.
So in case the superproject changes its HEAD (such as checking
out a different branch, or detaching the HEAD), then the submodules
HEAD changes automatically as the superprojects tree may change.


>  These are not something we can easily
> change without affecting wider context.  Our submodule, when we make
> a new commit, may be ready to advance, but our superproject and
> other submodules may not be ready to be included in a new commit in
> the superproject.

That is an interesting problem, as un-staging the submodule
is not as easy as un-staging a change in a file. Assume we
have a layout as

  git init super
  git -C super init sub
  echo change >>super/sub/file
  git -C super/sub commit -a -m "submodule changes"

then the following behaviors seem reasonable:

    git -C super reset --soft sub
      As the superprojects index is not touched, so is the
      submodules HEAD and working tree. The submodule
      stays as is.

    git -C super reset --mixed sub
      As this resets the index of the superproject, but not the working
      tree, I'd expect the submodules HEAD to be detached keeping
      the new content alive, such that it can be added as
        git -C super add --re-attach-with-new-symref-mode sub

    git -C super reset --hard sub
      This resets the index and the working tree in the superproject,
      so the submodules commit with the new content would be lost,
      the submodules HEAD is still the new symbolic ref.  The subs
      working tree is dirty and contains the change unless
      --recurse-submodules is given in addition, which would wipe
      the subs working directory in addition.

> So I think the idea this patch illustrates is on to something
> interesting and potentially useful, but I am not sure if it makes
> sense to tie it to anything but the index of the superproject.

Hypothetical use case:

  Your project targets multiple platforms and you are interested
  in not producing the perfect history like we do, but you never
  change a commit once created (for policy legal reasons).
  Naturally this produces a lot of duds.
  Create a a gitlink for each platform that points to the latest
  commit known to work for the platform. Point HEAD to the
  repository *itself*, and gitlink of the platform that you want to
  follow. After each fetch, checking out the latest HEAD is known
  to work for your platform.  (This hypothetical HEAD reference
  to itself is entertaining for sure.)

> Even if we limit ourselves to pointing at the index of the
> superproject, there probably are a handful of interesting issues
> that need to be clarified (not in the sense of "this and that issues
> exist, so this won't be a useful feature", but in the sense of "we'd
> be able to do these useful things using this feature, and we need to
> fill in more details"), such as:
>
>  - Making new commits in the submodule available to the upstream.
>    Just like a detached HEAD in the submodule, this is not tied to
>    any concrete branch, and it is unclear how a recursive "push"
>    from the superproject should propagate the changes to the
>    upstream of the submodule;

In Gerrit land people are trained to use
  git push HEAD:refs/for/master
which would work fine when propagated to the submodule as-is.

There are two answers for the life without Gerrit in a dumb git remote.
(a) In the far future in the ideal world, where version control is a
solved problem, submodules can reside inside the superproject
on the remote as well, i.e. in $GIT_DIR/modules/name, the URL
may be twisted to not expose the "modules/name" part, though such that

    example.org/superproject
    example.org/superproject/submodule

is possible. In this world a push of the superproject would also transfer
the relevant submodule commits, such that the remote has all of the
submodules history that contains all gitlink entries.

Pushing from inside the submodule may either push the superproject
(as you can push from a directory of the superproject) or it would
abort to not confuse a user.

(b) In the near future, I have no idea how to best solve this.
Maybe we can push it as a detached HEAD to the remote?

>  - Switching between branches that bind the same commit for the
>    submodule in the superproject would work just like switching
>    between branches that record the same blob for a path, i.e. it
>    will carry forward a local modification.

Right.

>
>  - The index entry in the superproject may now have to get involved
>    in fsck and reachability study in the submodule as reachability
>    root.  A corollary to this is that submodules behave more
>    similarly to regular blobs wrt "git reset --hard" in the
>    superproject, which is a good thing.  "git -C submodule commit &&
>    git reset --hard" will create a new commit in the submodule, add
>    it to the index of the superproject, and then lose that change
>    from the index of the superproject, making the commit
>    unreachable, just like "edit file && git add file && git reset
>    --hard" in the superproject will make the blob that records the
>    updated content of the file unreachable.

This is in sync with my understanding above.

Thanks,
Stefan
