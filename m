Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6911D0E1F
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709606; cv=none; b=dAHZNWG+gM/9MiQ5V2lqcSlr6jRmuT0EoIDF+vGUN0zY5x0zM4jMviGOs4Z/4/w59civhGPUZ5hdAza2AKVuGHgnFstyB9aPDjmfF7HgaylKQEtBhQ6QpBfGO03Xyjq2tV0j0PeYBq6j2YGuYsv30pQPWe8QDLGqRpaSqP9O2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709606; c=relaxed/simple;
	bh=czsbKrP2rwK3GZ7CREg6o4+zQlyjbYHKSIRabhNYdTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiA4xUYnN1EDKJaEQTNWTOzfirFrGtvkrf9dy1BYyWXRxdurFJOCA6OwDW8SEgAlPooslLFRY4EHX3Hh6RLH/3YfDyo2M1I/JCKrxRdcyOSwGtx/jhtiXfzDlmgG59uD11fy6FPQwysFP0ggUTiGD/X60Z946GzNrHZcsQY+dkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/WkViHI; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/WkViHI"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4608dddaa35so439501cf.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729709603; x=1730314403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8butiUg7nNtIfaRqdRFmK9rf3ZKt5pX+IaVXh8ETJ0=;
        b=h/WkViHI8jvKDRfofQjca/nO1JAGmxKqRI8ZxxGCxwtfV2wGXy+vpDT33dTGAqdHlo
         UqPSaYc3ru8jjf8N5Lth7ClWk3SCttn+RpD5QdwBjech90iJrQa6omT17L1+UGVho3q+
         Addg9pU2zT8RKPotKYnR6UedemN77TxyoX5MMgc1AdPgfCQv/E0VFvhszO1a+4oUvjBG
         0+tDOEMEexO1aXZ0oU+OLC4S0bOWcExmXxBhs2jZD6+T+1xcvPr/dmXtQydo6XqJ6f66
         EWHUceL55MlTDoIEdgyfGgi+zqpPhXWsuJ1VIHzmZZkhvG7YVNrYAxsEQB0bqcvmTQNC
         rH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709603; x=1730314403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8butiUg7nNtIfaRqdRFmK9rf3ZKt5pX+IaVXh8ETJ0=;
        b=agWmOh+TwYg0VXAexewwQWZo/qr4VPvUH+cZMKg5ohW17WyRnren4eS4ubICdhpnnx
         x0MCnObuTDL6Vxt0R3xTLjUUQzeW+TgkzeYrkiw4ok9j/r1PDbUk4FlIsCQGzsdpvvAm
         ZptwG0WiPwZvJUO05IeCVssC2qXBKRuEDWb0PkemiXj+rE+KgLZit2H6P/IgZ8rtougH
         mNEN/14MK9nKPDdcaKz9eTZ5x5Se/qQiwCKNPyRZbOFsHdu4kQFjWOQ0jAPYlrjp9BnQ
         7NCT3CY0XuAjg3EGaKLTI54QFRQagbM3aq7966eiqsk3gOqxhtmcHFmD7HQ0dadUsEjQ
         gItQ==
X-Gm-Message-State: AOJu0Yz50T2U9IDTO2qPcqoWVhNF47oSbBrPjXvTxUoBCEGPSyCNfXOs
	ucOzS6z0Jd2acY5oY5746kRxjglpuekCKakwXQ63oLbrx5FGXpBosuCuuQK14liffW40X/rdJFN
	vMkEjsRnmtO/lT3EPh0Ec21PSpAxkgEELPrM7e4iMqQhn7j8Z2Q==
X-Google-Smtp-Source: AGHT+IFJDS/PPf6nCNiqe6D4jXiFeE3tKr1VfCmONYzDDhb5HOm67fQDxPDpAIW4nmSCbNZnItZ7dprQy/hwHj2ULvU=
X-Received: by 2002:a05:622a:5e8e:b0:456:7ef1:929d with SMTP id
 d75a77b69052e-4612348af4emr536791cf.12.1729709602918; Wed, 23 Oct 2024
 11:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003223546.1935471-1-emilyshaffer@google.com> <20241023002806.367082-1-emilyshaffer@google.com>
In-Reply-To: <20241023002806.367082-1-emilyshaffer@google.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Wed, 23 Oct 2024 11:53:08 -0700
Message-ID: <CAJoAoZkcWVo1Hav1s-9Tqa7eddA8PcPxXdRjA4727LFYen83DA@mail.gmail.com>
Subject: Re: [PATCH v2] fetch-pack: don't mark COMPLETE unless we have the
 full object
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Han Young <hanyang.tony@bytedance.com>, 
	Jonathan Tan <jonathantanmy@google.com>, sokcevic@google.com, 
	Junio C Hamano <gitster@pobox.com>, robert.coup@koordinates.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(I missed ccing reviewers from last round; adding now, although I know
Junio is vacationing. Sorry about that.)

On Tue, Oct 22, 2024 at 5:28=E2=80=AFPM Emily Shaffer <emilyshaffer@google.=
com> wrote:
>
> When fetching, we decide which objects to skip asking for marking
> certain commit IDs with the COMPLETE flag. This flag is set in
> fetch-pack.c:mark_complete(), which is called from a few different
> functions who decide what to mark or not mark. mark_complete() is
> insulated against null pointer deref and repeatedly writing the same
> commit to the list of objects to skip; because it's the central function
> which decides that an object is COMPLETE and doesn't need to be fetched,
> let's also insulate it against corruption where the object is not
> present (even though we think it is).
>
> Without this check, it's possible to reach a corrupted state where
> fetches can infinitely loop because we decide to skip fetching, but we
> don't actually have the skipped commit in our object store.
>
> This manifested at $DAYJOB in a repo with the following features:
>  * blob-filtered partial clone enabled
>  * commit graph enabled
>  * ref Foo pointing to commit object 6aaaca
>  * object 6aaaca missing[1]
>
> With these prerequisites, we noticed that `git fetch` in the repo
> produced an infinite loop:
> 1. `git fetch` tries to fetch, but thinks it has all objects, so it
>    noops.
> 2. At the end of cmd_fetch(), we try to write_commit_graph_reachable().
> 3. write_commit_graph_reachable() does a reachability walk, including
>    starting from Foo
> 4. The reachability walk tries to peel Foo, and notices it's missing
>    6aaaca.
> 5. The partial clone machinery asks for a per-object JIT fetch of
>    6aaaca.
> 6. `git fetch` (child process) is asked to fetch 6aaaca.
> 7. We put together the_repository->parsed_objects, adding all commit IDs
>    reachable from local refs to it
>    (fetch-pack.c:mark_complete_and_common_refs(), trace region
>    mark_complete_local_refs). We see Foo, so we add 6aaaca to
>    the_repository->parsed_objects and mark it as COMPLETE.
> 8. cmd_fetch notices that the object ID it was asked for is already
>    known, so does not fetch anything new.
> 9. GOTO 2.
>
> The culprit is that we're assuming all local refs already must have
> objects in place. Let's not assume that, and explicitly check
> has_object() before marking objects as COMPLETE.
>
> NEEDSWORK: It could be valuable to emit a trace event when we try to
> mark_complete() an object where we don't actually has_object() (to
> understand how often we're having to heal from corruption).
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
>
> 1: That commit object went missing as a byproduct of this partial clone
>    gc issue:
>    https://lore.kernel.org/git/20241001191811.1934900-1-calvinwan@google.=
com/
>
> ---
>
>
> On the list, Junio and Robert Coup suggested that we should notice cases
> when the list of object IDs we are trying to fetch gets filtered to
> nothing during a lazy fetch. However, this turned out to be quite tricky
> to implement - fetch-by-OID stores the OID in a ref object, so it's
> challenging to guess that the ref we care about is an OID instead of a
> normal ref. It also required some heuristic approach to catch the exact
> moment after we removed COMPLETE objects from the list we wanted to
> fetch, and to notice that the wrong objects were missing from that list.
>
> (From the list of alternatives I included with v1, v1 was approach iii;
> Junio and Robert suggested iv; this patch holds something close to ii.)
>
> Jonathan Tan suggested that instead, we could be more careful about what
> we mark COMPLETE or not; it seems like this is pretty straightforward to
> do.
>
> I do wonder if it's a layering violation to do the has_object() check in
> mark_complete(), which is otherwise a pretty stupid function; I included
> it there because all of the other flavors of mark_complete_* eventually
> boil down to mark_complete(), so we wouldn't need to remember to check
> for object existence any other time we're trying to do this COMPLETE
> marking thing.
>
> Note that I added a test to guarantee this behavior works, but without
> commit graph enabled, the test passes both before and after; I guess
> maybe it's better to add an explicit regression test for the
> combination? But, this test fails with reftable - because we don't have
> a way (that I know of) to force-create a ref with a bad ID, to force
> this error condition. In the test as written I'm writing to
> .git/refs/heads/bar directly; that doesn't work for reftable. But `git
> update-ref` is too smart to let me set a ref to garbage. Any tips there
> are welcome.

I keep thinking about this test, and the more I think, the less
valuable I believe it is.

I think we aren't super in the habit of writing regression tests, but
would it be that valuable to write a regression test in this case
instead? On the other hand, I think the code diff is quite obviously a
good idea, and we can see from the test suite that there isn't really
a performance hit from it. Is it necessary to add a test at all?

Or, I guess that we could try to inspect how many fetch attempts were
needed to do the JIT fetch in this test. I suspect the number will be
too high without this patch - I know it recurses at least more than
once. I dunno. Anybody have stronger opinions than me?

>
> The CI run is at
> https://github.com/nasamuffin/git/actions/runs/11470039702 - it seems
> the reftable tests are the only things failing.
>
> Also, I am sending this version, but if there are any additional
> comments or it requires more changes, please expect Jonathan Tan to take
> over driving this patch the rest of the way for me. As previously
> stated[2], I'll be OOO after this Friday for most of the rest of the
> year; the rest of this week I'm trying to get the rest of my
> non-upstream loose ends tied up, so I won't have time to do another
> iteration. See folks around Christmastime :)
>
>  - Emily
>
> 2: https://lore.kernel.org/git/CAJoAoZnovapqMcu72DGR40jRRqRn57uJVTJg82kZ_=
rohtGDSfQ@mail.gmail.com/
>
> Cover letter from v1 follows:
>
> There are a few alternative approaches for this issue that I talked
> about with some folks at $DAYJOB:
>
> i. Just disabling the commit graph rewrite allows this to fall
> eventually into a path where the fetch actually succeeds. I didn't like
> this solution - it's just whack-a-mole - so I didn't look too hard into
> why it succeeds that way. It *could* make sense to disable commit graph
> rewrite when we do a JIT fetch with blob or tree filter provided - but
> if later we want to implement commit filter (something we've talked
> about at Google) then I'd worry about this situation coming up again.
>
> ii. We could decide not to mark local refs (and commits reachable from
> them) as COMPLETE in the_repository->parsed_objects. I didn't try this
> solution out, and I'm not sure what the performance implications are,
> but Jonathan Tan likes this solution, so I may try it out and see what
> breaks shortly.
>
> iii. We could do all the JIT fetches with --refetch. In my opinion, this
> is the safest/most self-healing solution; the JIT fetch only happens
> when we really know we're missing the object, so it doesn't make sense
> for that fetch to be canceled by any cache. It doesn't have performance
> implications as far as I can guess (except that I think we still build
> the parsed_objects hash even though we are going to ignore it, but we
> already were doing that anyway). Of course, that's what this patch does.
>
> iv. We could do nothing; when cmd_fetch gets a fetch-by-object-id but
> decides there is nothing more to do, it could terminate with an error.
> That should stop the infinite recursion, and the error could suggest the
> user to run `git fsck` and discover what the problem is. Depending on
> the remediation we suggest, though, I think a direct fetch to fix this
> particular loop would not work.
>
> I'm curious to hear thoughts from people who are more expert than me on
> partial clone and fetching in general, though.
>
> This change is also still in RFC, for two reasons:
>
> First, it's intermittently failing tests for me locally, in weirdly
> flaky ways:
>
> - t0410-partial-clone.sh fails when I run it from prove, but passes when
>   I run it manually, every time.
> - t5601-clone.sh and t5505-remote.sh fail nonsensically on `rm -rf` that
>   should succeed (and does succeed if I stop the test with test_pause),
>   which makes me think there's something else borked in my setup, but
>   I'm not sure what.
> - t5616-partial-clone.sh actually does fail in a way that I could see
>   having to do with this change (since I guess we might download more
>   packs than usual), but I was so confused by the other two errors I
>   haven't looked closely yet.
>
> And secondly, I didn't write tests verifying the breakage and that this
> change fixes it yet, either.
>
> I'm going to work on both those things in the background, but I wanted
> to get the description and RFC out early so that folks could take a look
> and we could decide which approach is best.
>
> Thanks,
>  - Emily
> ---
>  fetch-pack.c             |  4 +++-
>  t/t0410-partial-clone.sh | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f752da93a8..8cb2ce4c54 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -603,7 +603,9 @@ static int mark_complete(const struct object_id *oid)
>  {
>         struct commit *commit =3D deref_without_lazy_fetch(oid, 1);
>
> -       if (commit && !(commit->object.flags & COMPLETE)) {
> +       if (commit &&
> +           !(commit->object.flags & COMPLETE) &&
> +           has_object(the_repository, oid, 0)) {
>                 commit->object.flags |=3D COMPLETE;
>                 commit_list_insert(commit, &complete);
>         }
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 818700fbec..95de18ec40 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -241,6 +241,36 @@ test_expect_success 'fetching of missing objects wor=
ks with ref-in-want enabled'
>         grep "fetch< fetch=3D.*ref-in-want" trace
>  '
>
> +test_expect_success 'fetching missing objects pointed to by a local ref'=
 '
> +       rm -rf reliable-server unreliable-client &&
> +       test_when_finished rm -rf reliable-server unreliable-client &&
> +       test_create_repo reliable-server &&
> +       git -C reliable-server config uploadpack.allowanysha1inwant 1 &&
> +       git -C reliable-server config uploadpack.allowfilter 1 &&
> +       test_commit -C reliable-server foo &&
> +
> +       git clone --filter=3Dblob:none "file://$(pwd)/reliable-server" un=
reliable-client &&
> +
> +       # to simulate the unreliable client losing a referenced object by
> +       # corruption, create the object on the server side, then create o=
nly a
> +       # reference to that object on the client side (without providing =
the
> +       # object itself).
> +       test_commit -C reliable-server bar &&
> +       HASH=3D$(git -C reliable-server rev-parse HEAD) &&
> +       echo "$HASH" >unreliable-client/.git/refs/heads/bar &&
> +
> +       # the object is really missing
> +       # check if we can rev-parse a partial SHA. partial so we do not f=
etch it,
> +       # but barely partial (trim only the last char) so that we do not =
collide
> +       test_must_fail git -C unreliable-client rev-parse ${HASH%%?} &&
> +
> +       # trigger a remote fetch by checking out `bar`
> +       git -C unreliable-client switch bar &&
> +
> +       # and now we have the missing object
> +       git -C unreliable-client rev-parse ${HASH%%?}
> +'
> +
>  test_expect_success 'fetching of missing objects from another promisor r=
emote' '
>         git clone "file://$(pwd)/server" server2 &&
>         test_commit -C server2 bar &&
>
> Range-diff against v1:
> 1:  092be0a655 ! 1:  4db6bbb4cd promisor-remote: always JIT fetch with --=
refetch
>     - ## promisor-remote.c ##
>     -@@ promisor-remote.c: static int fetch_objects(struct repository *re=
po,
>     -   strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=3Dnoo=
p",
>     -                "fetch", remote_name, "--no-tags",
>     -                "--no-write-fetch-head", "--recurse-submodules=3Dno"=
,
>     --               "--filter=3Dblob:none", "--stdin", NULL);
>     -+               "--filter=3Dblob:none", "--refetch", "--stdin", NULL=
);
>     -   if (!git_config_get_bool("promisor.quiet", &quiet) && quiet)
>     -           strvec_push(&child.args, "--quiet");
>     -   if (start_command(&child))
>     + ## fetch-pack.c ##
>     +@@ fetch-pack.c: static int mark_complete(const struct object_id *oi=
d)
>     + {
>     +   struct commit *commit =3D deref_without_lazy_fetch(oid, 1);
>     +
>     +-  if (commit && !(commit->object.flags & COMPLETE)) {
>     ++  if (commit &&
>     ++      !(commit->object.flags & COMPLETE) &&
>     ++      has_object(the_repository, oid, 0)) {
>     +           commit->object.flags |=3D COMPLETE;
>     +           commit_list_insert(commit, &complete);
>     +   }
>     +
>     + ## t/t0410-partial-clone.sh ##
>     +@@ t/t0410-partial-clone.sh: test_expect_success 'fetching of missin=
g objects works with ref-in-want enabled'
>     +   grep "fetch< fetch=3D.*ref-in-want" trace
>     + '
>     +
>     ++test_expect_success 'fetching missing objects pointed to by a local=
 ref' '
>     ++  rm -rf reliable-server unreliable-client &&
>     ++  test_when_finished rm -rf reliable-server unreliable-client &&
>     ++  test_create_repo reliable-server &&
>     ++  git -C reliable-server config uploadpack.allowanysha1inwant 1 &&
>     ++  git -C reliable-server config uploadpack.allowfilter 1 &&
>     ++  test_commit -C reliable-server foo &&
>     ++
>     ++  git clone --filter=3Dblob:none "file://$(pwd)/reliable-server" un=
reliable-client &&
>     ++
>     ++  # to simulate the unreliable client losing a referenced object by
>     ++  # corruption, create the object on the server side, then create o=
nly a
>     ++  # reference to that object on the client side (without providing =
the
>     ++  # object itself).
>     ++  test_commit -C reliable-server bar &&
>     ++  HASH=3D$(git -C reliable-server rev-parse HEAD) &&
>     ++  echo "$HASH" >unreliable-client/.git/refs/heads/bar &&
>     ++
>     ++  # the object is really missing
>     ++  # check if we can rev-parse a partial SHA. partial so we do not f=
etch it,
>     ++  # but barely partial (trim only the last char) so that we do not =
collide
>     ++  test_must_fail git -C unreliable-client rev-parse ${HASH%%?} &&
>     ++
>     ++  # trigger a remote fetch by checking out `bar`
>     ++  git -C unreliable-client switch bar &&
>     ++
>     ++  # and now we have the missing object
>     ++  git -C unreliable-client rev-parse ${HASH%%?}
>     ++'
>     ++
>     + test_expect_success 'fetching of missing objects from another promi=
sor remote' '
>     +   git clone "file://$(pwd)/server" server2 &&
>     +   test_commit -C server2 bar &&
> --
> 2.47.0.105.g07ac214952-goog
>
