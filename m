Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91A7C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 11:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiGYLG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 07:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYLG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 07:06:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCECE1208C
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 04:06:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id va17so19952939ejb.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SE7WnC0evJV2zDVpN49Wwk5Uvv5cMQWd4YHZf9IhLQc=;
        b=E5a6plW2C2j8lIiD0kTpjDs2QgFbc/Tsd7P9lGLUYlHj+j7z9YWylDYZ9346TmCRve
         CaTHX0SsQDG/jZP0ctiUtMO0eI9BKfO/9XD0H/YgqOo9m+qIluXDC0pC/f7geior3TzM
         S0XpsfW+oFIv6hlfrRRqb+tCnf2oxFinsv6LZvjNtEv7CFvUySakHGPNYOeZrACvWCRc
         sPBcEnhpIPAqUFaYfb4UeFJDdFrJrPDo7veCXYFj4rqNqS7PLQ97PzPWvezukt5VNI7B
         DRnxh5BfJaBjD5Pw+hObVmbLTrvZD4qfJCraod9Ztu8kY4+JxLES20Nozu4GpRkzyIUA
         WKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SE7WnC0evJV2zDVpN49Wwk5Uvv5cMQWd4YHZf9IhLQc=;
        b=rcM++408aLXI7ndeA0aUpU2vXppDAecntu8reYXGMB3S5MD2DNbRZpE6XXWTDd0iMd
         /0wK7/0RVXBNm6UY1drV84cbpxkEw7sn/dT1VxPAGuafnQEnXtf1I4KD3Q9mP0gCdY8B
         a26WjOc75ooj04cLbONidijl8G++/+zG6FiHIY9vp1FDPULnScZcIvvwCKwyJnXiZ/Hw
         JoqCUvYA5BpnUHhmYu3FKlEZHDD+tfdK46LxBQXZFuLXBgHKE8RXsgIKFqX2nmZSu/Sk
         FfCqR7zRVHQ5UR0/5PoZvCewKkwUtDNwcAHtejHIulMfnlD/jJSy2OZzin93PcSZxSVg
         jLJQ==
X-Gm-Message-State: AJIora9jE9P5Fl+P2ZQG3pJ1nNLN/AAHK03/Bnh4bnpvQ2p55O3tKp3P
        ovvgL2/nWKETo4xzCwNlrnrGw/EhsIk=
X-Google-Smtp-Source: AGRyM1snSaGV+ugJ9yKh+rJMLj7Ws0wxIyv7TzcJ0gKXrOIoyokArvf7CvhaObkqhSphKMpRkuQQfg==
X-Received: by 2002:a17:907:72d1:b0:72b:6da5:9bb with SMTP id du17-20020a17090772d100b0072b6da509bbmr9293200ejc.681.1658747212737;
        Mon, 25 Jul 2022 04:06:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090623e900b0072b565507c5sm5196872ejg.203.2022.07.25.04.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 04:06:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oFvvH-005eN9-B3;
        Mon, 25 Jul 2022 13:06:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/7] merge: do not abort early if one strategy fails
 to handle the merge
Date:   Mon, 25 Jul 2022 12:38:15 +0200
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
 <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <b41853e3f9908ab458bcb28684d817677e32367b.1658391391.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <b41853e3f9908ab458bcb28684d817677e32367b.1658391391.git.gitgitgadget@gmail.com>
Message-ID: <220725.864jz5qwms.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 21 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> builtin/merge is setup to allow multiple strategies to be specified,
> and it will find the "best" result and use it.  This is defeated if
> some of the merge strategies abort early when they cannot handle the
> merge.  Fix the logic that calls recursive and ort to not do such an
> early abort, but instead return "2" or "unhandled" so that the next
> strategy can try to handle the merge.
>
> Coming up with a testcase for this is somewhat difficult, since
> recursive and ort both handle nearly any two-headed merge (there is
> a separate code path that checks for non-two-headed merges and
> already returns "2" for them).  So use a somewhat synthetic testcase
> of having the index not match HEAD before the merge starts, since all
> merge strategies will abort for that.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge.c                          |  6 ++++--
>  t/t6402-merge-rename.sh                  |  2 +-
>  t/t6424-merge-unrelated-index-changes.sh | 16 ++++++++++++++++
>  t/t6439-merge-co-error-msgs.sh           |  1 +
>  4 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 13884b8e836..dec7375bf2a 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -754,8 +754,10 @@ static int try_merge_strategy(const char *strategy, =
struct commit_list *common,
>  		else
>  			clean =3D merge_recursive(&o, head, remoteheads->item,
>  						reversed, &result);
> -		if (clean < 0)
> -			exit(128);
> +		if (clean < 0) {
> +			rollback_lock_file(&lock);
> +			return 2;
> +		}
>  		if (write_locked_index(&the_index, &lock,
>  				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>  			die(_("unable to write %s"), get_index_file());
> diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
> index 3a32b1a45cf..772238e582c 100755
> --- a/t/t6402-merge-rename.sh
> +++ b/t/t6402-merge-rename.sh
> @@ -210,7 +210,7 @@ test_expect_success 'updated working tree file should=
 prevent the merge' '
>  	echo >>M one line addition &&
>  	cat M >M.saved &&
>  	git update-index M &&
> -	test_expect_code 128 git pull --no-rebase . yellow &&
> +	test_expect_code 2 git pull --no-rebase . yellow &&
>  	test_cmp M M.saved &&
>  	rm -f M.saved
>  '
> diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unr=
elated-index-changes.sh
> index f35d3182b86..8b749e19083 100755
> --- a/t/t6424-merge-unrelated-index-changes.sh
> +++ b/t/t6424-merge-unrelated-index-changes.sh
> @@ -268,4 +268,20 @@ test_expect_success 'subtree' '
>  	test_path_is_missing .git/MERGE_HEAD
>  '
>=20=20
> +test_expect_success 'resolve && recursive && ort' '
> +	git reset --hard &&
> +	git checkout B^0 &&
> +
> +	test_seq 0 10 >a &&
> +	git add a &&
> +
> +	sane_unset GIT_TEST_MERGE_ALGORITHM &&
> +	test_must_fail git merge -s resolve -s recursive -s ort C^0 >output 2>&=
1 &&
> +
> +	grep "Trying merge strategy resolve..." output &&
> +	grep "Trying merge strategy recursive..." output &&
> +	grep "Trying merge strategy ort..." output &&
> +	grep "No merge strategy handled the merge." output
> +'
> +
>  test_done
> diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs=
.sh
> index 5bfb027099a..52cf0c87690 100755
> --- a/t/t6439-merge-co-error-msgs.sh
> +++ b/t/t6439-merge-co-error-msgs.sh
> @@ -47,6 +47,7 @@ test_expect_success 'untracked files overwritten by mer=
ge (fast and non-fast for
>  		export GIT_MERGE_VERBOSITY &&
>  		test_must_fail git merge branch 2>out2
>  	) &&
> +	echo "Merge with strategy ${GIT_TEST_MERGE_ALGORITHM:-ort} failed." >>e=
xpect &&
>  	test_cmp out2 expect &&
>  	git reset --hard HEAD^
>  '

I'm re-rolling ab/leak-check, and came up with the below (at the very
end) to "fix" a report in builtin/merge.c, reading your commit message
your fix seems obviously better.

Mine's early WIP, and I e.g. didn't notice that I forgot to unlock the
&lock file, which is correct.

I *could* say "that's not my problem", i.e. we didn't unlock it before
(we rely on atexit). The truth is I just missed it, but having said that
it *is* true that we could do without it, or do it as a separate chaneg.

I'm just posting my version below to help move yours forward, i.e. to
show that someone else has carefully at least this part.

But it is worth noting from staring at the two that your version is
mixing several different behavior changes into one, which *could* be
split up (but whether you think that's worth it I leave to you).

Maybe I'm the only one initially confused by it, and that's probably
just from being mentally biased towards my own "solution". Those are (at
least):

 1. Before we didn't explicitly unlock() before exit(), but had atexit()
    do it, that could be a one-line first commit. This change is
    obviously good.

 2. A commit like mine could come next, i.e. we bug-for-bug do what we
    do do now, but just run the "post-builtin" logic when we return from
    cmd_merge().

    Doing it as an in-between would be some churn, as we'll need to get
    rid of "early_exit" again, but would allow us to incrementally move
    forward to...

 3. ...then we'd say "but it actually makes sense not to early abort",
     i.e. you want to change this so that we'll run the logic between
     try_merge_strategy() exiting with 128 now and the return from
     cmd_merge().

     This bit is my main sticking point in reviewing your change,
     i.e. your "a testcase for this is somewhat difficult" somewhat
     addresses this, but (and maybe I'm wrong) it seems to me that=20

     Editing that code the post-image looks like this, with my
     commentary & most of the code removed, i.e. just focusing on the
     branches we do and don't potentially have tests for:

     		/* Before this we fall through from ret =3D=3D 128 (or ret =3D=3D 2.=
..) */
		if (automerge_was_ok) { // not tested?
		if (!best_strategy) {
			// we test this...
			if (use_strategies_nr > 1)
				// And this: _("No merge strategy handled the merge.\n"));
			else
				// And this: _("Merge with strategy %s failed.\n"),
		} else if (best_strategy =3D=3D wt_strategy)
			// but not this?
		else
			// Or this, where we e.g. say "Rewinding the tree to pristene..."?
=09
		if (squash) {
			// this?
		} else
			// this? (probably, yes)
			write_merge_state(remoteheads);
=09
		if (merge_was_ok)
			// this? (probably, yes, we just don't grep it?)
		else
			// this? maybe yes because it's covered by the
			// "failed" above too?
			ret =3D suggest_conflicts();
=09
	done:
		if (!automerge_was_ok) {
			// this? ditto the first "not tested?"
		}

   I.e. are you confident that we want to continue now in these various
   cases, where we have squash, !automerge_was_ok etc. I think it would
   be really useful to comment on (perhaps by amending the above
   pseudocode) what test cases we're not testing / test already etc.

 4. Having done all that (or maybe this can't be split up / needs to
    come earlier) you say that we'd like to not generically call this
    exit state 128, but have it under the "exit(2)" umbrella.

Again, all just food for thought, and a way to step-by-step go through
how I came about reviewing this in detail, I hope it and the below
version I came up with before seeing yours helps.

P.s.: The last paragraph in my commit message does not point to some
hidden edge case in the code behavior here, it's just that clang/gcc are
funny about exit() and die() control flow when combined with
-fsanitize=3Daddress and higher optimization levels.

-- >8 --
Subject: [PATCH] merge: return, don't use exit()

Change some of the builtin/merge.c code added in f241ff0d0a9 (prepare
the builtins for a libified merge_recursive(), 2016-07-26) to ferry up
an "early return" state, rather than having try_merge_strategy() call
exit() itself.

This is a follow-up to dda31145d79 (Merge branch
'ab/usage-die-message' into gc/branch-recurse-submodules-fix,
2022-03-31).

The only behavior change here is that we'll now properly catch other
issues on our way out, see e.g. [1] and the interaction with /dev/full
for an example.

The immediate reason to do this change is because it's one of the
cases where clang and gcc's SANITIZE=3Dleak behavior differs. Under
clang we don't detect that "t/t6415-merge-dir-to-symlink.sh" triggers
a leak, but gcc spots it.

1. https://lore.kernel.org/git/87im2n3gje.fsf@evledraar.gmail.com/

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 23170f2d2a6..a8d5d04f622 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -709,10 +709,12 @@ static void write_tree_trivial(struct object_id *oid)
=20
 static int try_merge_strategy(const char *strategy, struct commit_list *co=
mmon,
 			      struct commit_list *remoteheads,
-			      struct commit *head)
+			      struct commit *head, int *early_exit)
 {
 	const char *head_arg =3D "HEAD";
=20
+	*early_exit =3D 0;
+
 	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
 		return error(_("Unable to write index."));
=20
@@ -754,8 +756,10 @@ static int try_merge_strategy(const char *strategy, st=
ruct commit_list *common,
 		else
 			clean =3D merge_recursive(&o, head, remoteheads->item,
 						reversed, &result);
-		if (clean < 0)
-			exit(128);
+		if (clean < 0) {
+			*early_exit =3D 1;
+			return 128;
+		}
 		if (write_locked_index(&the_index, &lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
@@ -1665,6 +1669,8 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
=20
 	for (i =3D 0; !merge_was_ok && i < use_strategies_nr; i++) {
 		int ret, cnt;
+		int early_exit;
+
 		if (i) {
 			printf(_("Rewinding the tree to pristine...\n"));
 			restore_state(&head_commit->object.oid, &stash);
@@ -1680,7 +1686,10 @@ int cmd_merge(int argc, const char **argv, const cha=
r *prefix)
=20
 		ret =3D try_merge_strategy(use_strategies[i]->name,
 					 common, remoteheads,
-					 head_commit);
+					 head_commit, &early_exit);
+		if (early_exit)
+			goto done;
+
 		/*
 		 * The backend exits with 1 when conflicts are
 		 * left to be resolved, with 2 when it does not
@@ -1732,12 +1741,18 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
 	} else if (best_strategy =3D=3D wt_strategy)
 		; /* We already have its result in the working tree. */
 	else {
+		int new_ret, early_exit;
+
 		printf(_("Rewinding the tree to pristine...\n"));
 		restore_state(&head_commit->object.oid, &stash);
 		printf(_("Using the %s strategy to prepare resolving by hand.\n"),
 			best_strategy);
-		try_merge_strategy(best_strategy, common, remoteheads,
-				   head_commit);
+		new_ret =3D try_merge_strategy(best_strategy, common, remoteheads,
+					     head_commit, &early_exit);
+		if (early_exit) {
+			ret =3D new_ret;
+			goto done;
+		}
 	}
=20
 	if (squash) {
--=20
2.36.1

