Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556671F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 22:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdGYW1J (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 18:27:09 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34861 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbdGYW1I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 18:27:08 -0400
Received: by mail-pf0-f178.google.com with SMTP id h29so28343983pfd.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hQYiuv2BkTmFW3NQn0uMhX+toYxlAqqfyCzhd+y6Ltk=;
        b=hSzkLB309JUFVeCwpbKmtiBreohC4q9Mxy/fOUBlbkdGrW6EAviOwR0LbkrIrKfGi/
         MmEdrZ5Q8RFGyw5IDulkBp9tX3cbVYJVT+ieFHCBAc76xy//uXXFrOboGv0PQfmWx03o
         wHc9RPuphlnix/1NpbCwFyiUPZq1rOGJc9PfiaFW3X64Nwo4nsz0goC7j/g3cjrf1mD2
         1SJcBzCKvarN9XAahIPQB9kPcdl/2S7tHhYzXmbA21947f1p6IO+VEsCHz8bZc/RLUlH
         Pfl0HwnKWFLE5NETCgse61pIDEMQXOYiK5ZiqmQYBwJdcNYewgToP6F0wTqu0vkiwINR
         6yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hQYiuv2BkTmFW3NQn0uMhX+toYxlAqqfyCzhd+y6Ltk=;
        b=krsc19xK4snqOs7SJuoFHGTSyA7BnGh+w0ZwUdWgvrqA5DgNnVPKrHjZBU28wRazqQ
         bx4SajVcF88wQjV/5rE247GeiL6f5JpxaX/5dT48oLjYlojYzw92JsbFogHI95L8D5aL
         EXGhX7n8Qkflo9DZSLEohtGsZaO5FA/q/jtgGTnUCC/sTgckAGThpWsz36seboipraQX
         0+3wiErZNtBxPe2T9LV0Cl11NMautpJc4TsdVJP0WctvoCepqsY5HkRqeO6g5B+4zMEL
         zOPP5zThsV8wViC8/WZZlkmDxBvxWAm1lOnxlsvn4VRzOIDe96Dy/B/XBDuMaqtnGv2i
         +Fkw==
X-Gm-Message-State: AIVw111jt7yJGZMQEoqxg2apGFoJwNDwnjbUCqutb1WRcaYj2qCcskwU
        uJ4nJ9AUQ8YjJaa2I65gl4YmoLExVQEV
X-Received: by 10.99.54.138 with SMTP id d132mr20428258pga.156.1501021627561;
 Tue, 25 Jul 2017 15:27:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Tue, 25 Jul 2017 15:27:07 -0700 (PDT)
In-Reply-To: <xmqqr2x5bhk7.fsf@gitster.mtv.corp.google.com>
References: <20170724173601.19921-1-sbeller@google.com> <20170724180312.GE13924@aiede.mtv.corp.google.com>
 <xmqq8tjdcyf1.fsf@gitster.mtv.corp.google.com> <xmqqr2x5bhk7.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Jul 2017 15:27:07 -0700
Message-ID: <CAGZ79kZdoktBRBuNxVk-zehZR3Z-egEPG81KQ9WqHTEtrm+5uw@mail.gmail.com>
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 3:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Also, while I do agree with you that the problem exists, it is
>> unclear why this patch is a solution and not a hack that sweeps a
>> problem under the rug.
>>
>> It is unclear why this "silently detach HEAD without telling the
>> user" is a better solution than erroring out, for example [*1*].
>
> Just to avoid possible confusion; I am not claiming that it would be
> more (or less for that matter) sensible to error out than silently
> detaching HEAD, because I am not giving the reason to substantiate
> the claim and I do not have a strong opinion to favour which one (or
> another potential solution, if any).
>
> I am just saying that the patch that proposes a solution should be
> backed with an explanation why it is a good idea, especially when
> there are obvious alternatives that are not so clearly inferior.
>
> Thanks.

So I took a step back and wrote about different proposals where
we want to go long term. See below. This will help us
figuring out how to approach this bug correctly.
------



RFC: A new type of symbolic refs

A symbolic ref can currently only point at a ref or another symbolic ref.
This proposal show cases different scenarios on how this could change in
the future.



A: HEAD pointing at the superprojects index
===========================================

Introduce a new symbolic ref that points at the superprojects index of
the gitlink. The format is

  "repo:" <superprojects gitdir> '\0' <gitlink-path> '\0'

Ref read operations
-------------------
  e.g. git log HEAD

Just like existing symrefs, the content of the ref will be read and followed.
On reading "repo:", the sha1 will be obtained equivalent to:

    git -C <superproject> ls-files -s <gitlink-path> | awk '{ print $2}'

In case of error
(superproject not found, gitlink path does not exist), the ref is broken and

Ref write operations driven by the submodule, affecting symrefs
---------------------------------------------------------------
  e.g. git checkout <other branch> (in the submodule)

In this scenario only the HEAD is optionally attached to the superproject,
so we can rewrite the HEAD to be anything else, such as a branch just fine.
Once the HEAD is not pointing at the superproject any more, we'll leave the
submodule alone in operations driven by the superproject.

Ref write operations driven by the submodule, affecting target ref
------------------------------------------------------------------
  e.g. git commit, reset --hard, update-ref (in the submodule)

The HEAD stays the same, pointing at the superproject.
The gitlink is changed to the target sha1, using

  git -C <superproject> update-index --add \
      --cacheinfo 160000,$SHA1,<gitlink-path>

This will affect the superprojects index, such that then a commit in
the superproject is needed.

Ref write operations driven by the superproject, changing the gitlink
---------------------------------------------------------------------
  e.g. git checkout <tree-ish>, git reset --hard (in the superproject)

This will change the gitlink in the superprojects index, such that the HEAD
in the submodule changes, which would trigger an update of the
submodules working tree.

Consistency considerations (gc)
-------------------------------
  e.g. git gc --aggressive --prune=now

The repacking logic is already aware of a detached HEAD, such that
using this new symref mechanism would not generate problems as long as
we keep the HEAD attached to the superproject. However when commits/objects
are created while the HEAD is attached to the superproject and then HEAD
switches to a local branch, there are problems with the created objects
as they seem unreachable now.

This problem is not new as a superproject may record submodule objects
that are not reachable from any of the submodule branches. Such objects
fall prey to overzealous packing in the submodule.

This proposal however exposes this problem a lot more, as the submodule
has fewer needs for branches.




B: HEAD pointing at a superprojects branch
==========================================

Instead of pointing at the index of the superproject, we also
encode a branch name:

    repo:" <superprojects gitdir> '\0' <gitlink-path> '\0' branch '\0'

Ref read operations
-------------------
  e.g. git log HEAD

This is similar to the case of pointing at the index, except that the reading
operation reads from the tip of the branch:

    git -C <superproject> ls-tree <superproject branch> -- \
        <gitlink-path> | awk '{ print $3}'

Ref write operations driven by the submodule, affecting symrefs
---------------------------------------------------------------
  e.g. git checkout <other branch> (in the submodule)

HEAD will be pointed at the local target branch, dropping the affliation to
the superproject.

Ref write operations driven by the submodule, affecting target ref
------------------------------------------------------------------
  e.g. git commit, reset --hard, update-ref (in the submodule)

As we're pointing at the superprojects branch, this would have to create
a dummy(?) commit in the superproject, that just changes the submodule
pointer in the superprojects branch, such that the operation of storing
a new sha1 for the submodule is equivalent to

  git -C <superproject> update-index --add \
      --cacheinfo 160000,$SHA1,<gitlink-path>
  git -C <superproject> commit -m "Update submodule"

This behavior in the superproject is similar to Gerrits subscription model
where superprojects are updated from the submodule.

Each operation in the submodule triggers a local superproject commit.

Ref write operations driven by the superproject, changing the gitlink
---------------------------------------------------------------------
  e.g. git merge, git pull (in the superproject)

This will change the gitlink in the superprojects index, such that the HEAD
in the submodule changes, which would trigger an update of the
submodules working tree.

This would require a good merge strategy for submodules, i.e. on merge
the submodule would create a merge commit that is recorded in the
superprojects merge commit.

Consistency considerations (gc)
-------------------------------
  e.g. git gc --aggressive --prune=now

The repacking problem comes with a solution unlike the previous proposal.
This is because any relevant commit in the submodule is recorded in the
superproject via a commit in a branch. Then even non-fast-forward histories
in the submodule can all be kept by walking the superproject and looking at
all gitlink entries of the submodule.



C: All branches are symbolic references to the superproject
===========================================================

Instead of having just HEAD pointed at a superproject, all(!) branches
in the submodule point at the superprojects branch of the same name.
Symbolic refs that resolve to a local sha1 are not allowed, any symbolic ref
ends up pointing at the superproject eventually.
e.g. HEAD points at a submodule branch, which in turn points at
the superproject branch of the same name.

Ref read operations
-------------------
  e.g. git log

HEAD is read, which may be either (a) locally detached or (b) pointing at a
superproject branch. Resolve as in B.

Ref write operations driven by the submodule, affecting symrefs
---------------------------------------------------------------
  e.g. git checkout <other branch> (in the submodule)

As there is no other local branch, HEAD would point at the other submodule
branch, which then points at another branch in the superproject.

Ref write operations driven by the submodule, affecting target ref
------------------------------------------------------------------
  e.g. git commit, reset --hard, update-ref (in the submodule)

  same as B.

Ref write operations driven by the superproject, changing the gitlink
---------------------------------------------------------------------
  e.g. git merge, git pull (in the superproject)

  same as B.

Consistency considerations (gc)
-------------------------------
  e.g. git gc --aggressive --prune=now

As the superproject contains all knowledge, the gc starts with a
walk of all superproject branches, destilling the recorded gitlink entries
and then starts walking in the submodule from all the recorded gitlinks
to create a pack.

gc and repacking would either be forbidden in the submodule or deflected
to the superproject.
