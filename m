Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352603254B2
	for <git@vger.kernel.org>; Sun, 17 May 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779028344; cv=none; b=GlLrShz0/rn3/LuEA+rFdcGFz2mKGyF16e53orOucPjjGARvb7roDNfsjfaqrKP3GLIbrVN8urxRNyWyUDoebP6P2OQ/hCstipl5DJa9EOu+aBzJ+e4eYomO+YfIx9VxMP8jIU1tIBV6c0aRg0IjJUkolHUia8xfa+6bsqIJHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779028344; c=relaxed/simple;
	bh=3bbSSDx8OSHRLWlU0vLH92S5WmXJWf5S6ofx7D2835c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HdCPke93vAXs3RFU9Aupmr+pQxnc6kbzOkFqeacb315xCr10uNKVWQ9pguhhFkaoxr2lZmkZTcIJDbVZ66aR5kJWpbiaTSJ/hnadd23LRPyyMbeipn9q4nlA8zkBuJ+mNXhj/416YpPteTZHd9AS+lrUnwB8ZvVnU6wGvWPhQF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=c3+EKfaG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="c3+EKfaG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779028333; x=1779633133;
	i=johannes.schindelin@gmx.de;
	bh=geiKRYFnrxrY/YTOHDZrMCfEe3gwG417CvL32uCnUYA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c3+EKfaGAWtFj7SZXUzofALIT0moLkIlcIHFxpYIFkTKDRG8Hd5j+pymGd236VDy
	 Vf7OtJyONgWsmkwYCR5koJLKGmWrElvlQtQ0n38Op4md5FUKcZPKJ0+/+Yrf1xyNr
	 7bPPJ1BijVXR8XmbHHyH9IcIqRCzH83bkwMgm92r9jrPg+2gRk/rcU3qXy8yNWCbz
	 LeJVPfucCSeVqoGMT4TS5/Z/tGLA2cYRBhCAWBMhETgQAIkn2+QdfdV+/6qJiiH8D
	 /DJMBqPYYh048p2ohs0tk6puep53fhcAo+go9L1NaRzfDsOXJqvrVLEbj4VfLpA9g
	 YvqHVsDG9fWkAwlz8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1wSByU10sJ-00G3O3; Sun, 17
 May 2026 16:32:13 +0200
Date: Sun, 17 May 2026 16:32:11 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phillip Wood <phillip.wood123@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH/RFC 1/5] replay: support replaying 2-parent merges
In-Reply-To: <72901ee2-1212-46cd-b752-f451cce6e1ff@gmail.com>
Message-ID: <e094879e-ead9-879b-b889-038025e8e822@gmx.de>
References: <pull.2106.git.1778107405.gitgitgadget@gmail.com> <034ab0f83822e6db67baa423d9fcb753b12b5ac8.1778107405.git.gitgitgadget@gmail.com> <72901ee2-1212-46cd-b752-f451cce6e1ff@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L1W2PDBjSkl9kISkU/MBTV3hZ9DpCLfCWOKqpkjJKyhHSVgU4M3
 3Y1aKgfL1lwmX37TupguB7wvWeDk2+Zm/UlPGD0dDucF+9Spunwb4RuHk0Um3Oq/U2wjmyt
 3EIT+vWTgaerif1sJINfJGRA0rvCj4/bn53DktADYMtP+H2pEYoRSmIhgCrGGpt2jKAJtom
 ZQi0zL27PG9gDKeZkxwuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dFZL3OYBn84=;U6509oBmj2UzPaCgDpL1dVJNIPB
 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
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Fri, 8 May 2026, Phillip Wood wrote:

> On 06/05/2026 23:43, Johannes Schindelin via GitGitGadget wrote:
> >=20
> > Elijah Newren spelled out a way to lift this limitation in his
> > replay-design-notes [1] and prototyped it in a 2022
> > work-in-progress sketch [2]. The idea is that a merge commit M on
> > parents (P1, P2) records both an automatic merge of those parents
> > AND any manual layer the author put on top of that automatic merge
> > (textual conflict resolution and any semantic edit outside conflict
> > markers). Replaying M onto rewritten parents (P1', P2') must
> > preserve that manual layer, but the rewritten parents change the
> > automatic merge, so a simple cherry-pick is wrong: the manual layer
> > would be re-introduced on top of stale auto-merge text.
> >=20
> > What works instead is a three-way merge of three trees the existing
> > infrastructure already knows how to compute. Let R be the recursive
> > auto-merge of (P1, P2), O be M's actual tree and N be the recursive
> > auto-merge of (P1', P2'). Then `git diff R O` is morally
> > `git show --remerge-diff M`: it captures exactly what the author
> > added on top of the automatic merge. A non-recursive 3-way merge
> > with R as the merge base, O as side 1 and N as side 2 layers that
> > manual contribution onto the freshly auto-merged rewritten parents
> > (N) and produces the replayed tree.
>=20
> So we cherry-pick the difference between the user's conflict resolution =
O and
> the auto-merge M of the original parents onto the auto-merge N of the re=
played
> parents. If we have a topology that looks like
>=20
>         |
>        A
>       /|\
>      / B \
>      E  |  D
>         C /
>         |/
>         O
>=20
> then running
>=20
>     git replay --onto E --ancestry-path B..O
>=20
> will replay C and O onto E. If the changes in E and D conflict but those
> conflicts do not overlap with the conflicts in M that were resolved to c=
reate
> O then the replayed version of O will contain conflict markers from the
> conflicting changes in E and D. Because the previous conflict resolution
> applies to N without conflicts we do not recognize that there are still
> conflicts in N that need to be resolved.

Very good point, and exactly the kind of feedback I was hoping for when I
marked this as an RFC. Thank you!

> Having realized this I went to look at Elijah's notes and they recognize
> this possibility and suggest extending the xdiff merge code to detect
> when N has conflicts that do not correspond to the conflicts in M. That
> sounds like quite a lot of work. I've not put much effort into coming up
> with a counterexample but think that because "git replay" and "git
> history" do not yet allow the commits in the merged branches to be
> edited we may be able to safely use the implementation proposed in this
> series if both merge parents have been rebased (or we might want all the
> merge bases of the new merge to be a descendants of "--onto"). In the
> example above if both the parents were rebased onto E then any new
> conflicts would happen when picking D rather than when recreating the
> merge.

Right. I have to admit that I missed this corner-case when I looked at the
original notes.

And while `git history`'s `reword` and `split` subcommands won't be
affected, the upcoming `fixup` subcommand _will_ be affected.

I am reworking the patches as we speak, loosely following Elijah's notes.
So far, I'm confident that this will address that problem.

What I am not confident at all so far (because I'm still trying to get the
actual algorithm to work, and haven't had a chance to test this on
real-world scenarios) is that the _conflict output_ is helpful. That is,
whether the conflict markers in case of corner-cases (merge conflicts in
R overlapping with merge conflicts in N, but not being identical, for
example) are clear enough to act upon, or will only lead to despair in the
keen reader.

For example, I noticed that a merge conflict resolution in O that is no
longer necessary in N leads to a quite unhelpful output...

I know that `git replay` is not designed as an interactive tool, but `git
history` is, and will ultimately _have_ to find ways to surface such merge
conflicts and help the user resolve them and then continue the replay.

For now, however, I do agree that we need to capture the error modes
correctly.

Ciao,
Johannes

>=20
> Thanks
>=20
> Phillip
>=20
> > Implement `pick_merge_commit()` along those lines and dispatch to it
> > from `replay_revisions()` when the commit being replayed has exactly
> > two parents. Two specific points (learned the hard way) keep
> > non-trivial cases working where the WIP sketch [2] bailed out.
> > First, R and N use identical `merge_options.branch1` and `branch2`
> > labels ("ours"/"theirs"). When the original parents conflicted on a
> > region of a file, both R and N produce textually identical conflict
> > markers; the outer non-recursive merge then sees N =3D=3D R in that
> > region and the user's manual resolution from O wins cleanly. Without
> > this, the conflict-marker text would differ between R and N (because
> > the inner merges would label the conflicts differently), and the
> > outer merge would itself be unclean even when the user did supply a
> > clean resolution. Second, an unclean inner merge
> > (`result.clean =3D=3D 0`) is _not_ fatal: the tree merge-ort produces =
in
> > that case still has well-defined contents (with conflict markers in
> > the conflicted files) and is a valid input to the outer
> > non-recursive merge. Only a real error (`< 0`) propagates as
> > failure.
> >=20
> > The replay propagates the textual diffs the user actually made in M;
> > it does _not_ extrapolate symbol-level intent. If rewriting the
> > parents pulls in genuinely new content (for example, a brand-new
> > caller of a function that the merge renamed), that new content stays
> > as the rewritten parents have it. Symbol-aware refactoring is out of
> > scope here, just as it is for plain rebase.
> >=20
> > Octopus merges (more than two parents) and revert-of-merge are not
> > supported and are surfaced as explicit errors at the dispatch point.
> > The "split" sub-command of `git history` continues to refuse when
> > the targeted commit is itself a merge: split semantics do not apply
> > to merges. The pre-walk gate in `builtin/history.c` that previously
> > rejected any merge in the rewrite path now only rejects octopus
> > merges; rename it accordingly.
> >=20
> > A small refactor in `create_commit()` makes the merge case possible:
> > the helper now takes a `struct commit_list *parents` rather than a
> > single parent pointer and takes ownership of the list. The single
> > existing caller in `pick_regular_commit()` builds and passes a
> > one-element list; the new `pick_merge_commit()` builds a two-element
> > list, with the order of the `from` and `merge` parents preserved.
> >=20
> > Update the negative expectations in t3451, t3452 and t3650 that were
> > asserting the now-retired "not supported yet" message, replacing
> > them with positive coverage where it fits. Octopus rejection and
> > revert-of-merge rejection are covered by new positive tests in
> > t3650. A dedicated test script with merge-replay scenarios driven by
> > a new test-tool fixture builder will follow in a subsequent commit.
> >=20
> > [1] https://github.com/newren/git/blob/replay/replay-design-notes.txt
> > [2]
> > https://github.com/newren/git/commit/4c45e8955ef9bf7d01fd15d9106b3bdb8=
ea91b45
> >=20
> > Helped-by: Elijah Newren <newren@gmail.com>
> > Assisted-by: Claude Opus 4.7
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   builtin/history.c         |  16 ++-
> >   replay.c                  | 209 ++++++++++++++++++++++++++++++++++++=
=2D-
> >   t/t3451-history-reword.sh |  21 ++--
> >   t/t3452-history-split.sh  |   6 +-
> >   t/t3650-replay-basics.sh  |  46 ++++++++-
> >   5 files changed, 269 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/builtin/history.c b/builtin/history.c
> > index 9526938085..00097b2226 100644
> > --- a/builtin/history.c
> > +++ b/builtin/history.c
> > @@ -195,15 +195,15 @@ static int parse_ref_action(const struct option =
*opt,
> > const char *value, int uns
> >   	return 0;
> >   }
> >  =20
> > -static int revwalk_contains_merges(struct repository *repo,
> > -				   const struct strvec *revwalk_args)
> > +static int revwalk_contains_octopus_merges(struct repository *repo,
> > +					   const struct strvec *revwalk_args)
> >   {
> >    struct strvec args =3D STRVEC_INIT;
> >    struct rev_info revs;
> >    int ret;
> >  =20
> >   	strvec_pushv(&args, revwalk_args->v);
> > -	strvec_push(&args, "--min-parents=3D2");
> > +	strvec_push(&args, "--min-parents=3D3");
> >  =20
> >    repo_init_revisions(repo, &revs, NULL);
> >   @@ -217,7 +217,7 @@ static int revwalk_contains_merges(struct reposi=
tory
> > *repo,
> >    }
> >  =20
> >   	if (get_revision(&revs)) {
> > -		ret =3D error(_("replaying merge commits is not supported
> > yet!"));
> > +		ret =3D error(_("replaying octopus merges is not supported"));
> >    	goto out;
> >    }
> >   @@ -289,7 +289,7 @@ static int setup_revwalk(struct repository *repo=
,
> >    	strvec_push(&args, "HEAD");
> >    }
> >   -	ret =3D revwalk_contains_merges(repo, &args);
> > +	ret =3D revwalk_contains_octopus_merges(repo, &args);
> >    if (ret < 0)
> >     goto out;
> >   @@ -482,6 +482,9 @@ static int cmd_history_reword(int argc,
> >    if (ret < 0) {
> >     ret =3D error(_("failed replaying descendants"));
> >     goto out;
> > +	} else if (ret) {
> > +		ret =3D error(_("conflict during replay; some descendants were
> > not rewritten"));
> > +		goto out;
> >    }
> >  =20
> >   	ret =3D 0;
> > @@ -721,6 +724,9 @@ static int cmd_history_split(int argc,
> >    if (ret < 0) {
> >     ret =3D error(_("failed replaying descendants"));
> >     goto out;
> > +	} else if (ret) {
> > +		ret =3D error(_("conflict during replay; some descendants were
> > not rewritten"));
> > +		goto out;
> >    }
> >  =20
> >   	ret =3D 0;
> > diff --git a/replay.c b/replay.c
> > index f96f1f6551..3dbce095f9 100644
> > --- a/replay.c
> > +++ b/replay.c
> > @@ -1,6 +1,7 @@
> >   #define USE_THE_REPOSITORY_VARIABLE
> >  =20
> >   #include "git-compat-util.h"
> > +#include "commit-reach.h"
> >   #include "environment.h"
> >   #include "hex.h"
> >   #include "merge-ort.h"
> > @@ -77,15 +78,21 @@ static void generate_revert_message(struct strbuf =
*msg,
> >   	repo_unuse_commit_buffer(repo, commit, message);
> >   }
> >  =20
> > +/*
> > + * Build a new commit with the given tree and parent list, copying au=
thor,
> > + * extra headers and (for pick mode) the commit message from `based_o=
n`.
> > + *
> > + * Takes ownership of `parents`: it will be freed before returning, e=
ven on
> > + * error. Parent order is preserved as supplied by the caller.
> > + */
> >   static struct commit *create_commit(struct repository *repo,
> >           struct tree *tree,
> >           struct commit *based_on,
> > -				    struct commit *parent,
> > +				    struct commit_list *parents,
> >   				    enum replay_mode mode)
> >   {
> >    struct object_id ret;
> >    struct object *obj =3D NULL;
> > -	struct commit_list *parents =3D NULL;
> >    char *author =3D NULL;
> >    char *sign_commit =3D NULL; /* FIXME: cli users might want to sign =
again */
> >    struct commit_extra_header *extra =3D NULL;
> > @@ -96,7 +103,6 @@ static struct commit *create_commit(struct reposito=
ry
> > *repo,
> >    const char *orig_message =3D NULL;
> >    const char *exclude_gpgsig[] =3D { "gpgsig", "gpgsig-sha256", NULL =
};
> >   -	commit_list_insert(parent, &parents);
> >    extra =3D read_commit_extra_headers(based_on, exclude_gpgsig);
> >    if (mode =3D=3D REPLAY_MODE_REVERT) {
> >   		generate_revert_message(&msg, based_on, repo);
> > @@ -273,6 +279,7 @@ static struct commit *pick_regular_commit(struct
> > repository *repo,
> >   {
> >    struct commit *base, *replayed_base;
> >    struct tree *pickme_tree, *base_tree, *replayed_base_tree;
> > +	struct commit_list *parents =3D NULL;
> >  =20
> >    if (pickme->parents) {
> >   		base =3D pickme->parents->item;
> > @@ -327,7 +334,143 @@ static struct commit *pick_regular_commit(struct
> > repository *repo,
> >    if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oi=
d) &&
> >        !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
> >   		return replayed_base;
> > -	return create_commit(repo, result->tree, pickme, replayed_base, mode=
);
> > +	commit_list_insert(replayed_base, &parents);
> > +	return create_commit(repo, result->tree, pickme, parents, mode);
> > +}
> > +
> > +/*
> > + * Replay a 2-parent merge commit by composing three calls into merge=
-ort:
> > + *
> > + *   R =3D recursive merge of pickme's two original parents (auto-rem=
erge of
> > + *       the original merge, accepting any conflicts)
> > + *   N =3D recursive merge of the (possibly rewritten) parents
> > + *   O =3D pickme's tree (the user's actual merge, including any manu=
al
> > + *       resolutions)
> > + *
> > + * The picked tree comes from a non-recursive merge using R as the ba=
se,
> > + * O as side1 and N as side2. `git diff R O` is morally `git show
> > + * --remerge-diff $oldmerge`, so this layers the user's original manu=
al
> > + * resolution on top of the freshly auto-merged rewritten parents (se=
e
> > + * `replay-design-notes.txt` on the `replay` branch of newren/git).
> > + *
> > + * If the outer 3-way merge is unclean, propagate the conflict status=
 to
> > + * the caller via `result->clean =3D 0` and return NULL. The two inne=
r
> > + * merges (R and N) being unclean is _not_ fatal: the conflict-marker=
ed
> > + * trees they produce are valid inputs to the outer merge, and using
> > + * identical labels for both inner merges keeps the marker text
> > + * byte-equal between R and N so the user's resolution recorded in O
> > + * collapses the conflict cleanly there. Octopus merges (more than tw=
o
> > + * parents) and revert-of-merge are rejected by the caller before thi=
s
> > + * function is invoked.
> > + */
> > +static struct commit *pick_merge_commit(struct repository *repo,
> > +					struct commit *pickme,
> > +					kh_oid_map_t *replayed_commits,
> > +					struct merge_options *merge_opt,
> > +					struct merge_result *result)
> > +{
> > +	struct commit *parent1, *parent2;
> > +	struct commit *replayed_par1, *replayed_par2;
> > +	struct tree *pickme_tree;
> > +	struct merge_options remerge_opt =3D { 0 };
> > +	struct merge_options new_merge_opt =3D { 0 };
> > +	struct merge_result remerge_res =3D { 0 };
> > +	struct merge_result new_merge_res =3D { 0 };
> > +	struct commit_list *parent_bases =3D NULL;
> > +	struct commit_list *replayed_bases =3D NULL;
> > +	struct commit_list *parents;
> > +	struct commit *picked =3D NULL;
> > +	char *ancestor_name =3D NULL;
> > +
> > +	parent1 =3D pickme->parents->item;
> > +	parent2 =3D pickme->parents->next->item;
> > +
> > +	/*
> > +	 * Map the merge's parents to their replayed counterparts. With the
> > +	 * boundary commits pre-seeded into `replayed_commits`, every parent
> > +	 * either has an explicit mapping (rewritten or boundary -> onto) or
> > +	 * sits outside the rewrite range entirely; the latter must stay at
> > +	 * the original parent commit, so use `parent` itself as the fallbac=
k
> > +	 * for both sides.
> > +	 */
> > +	replayed_par1 =3D mapped_commit(replayed_commits, parent1, parent1);
> > +	replayed_par2 =3D mapped_commit(replayed_commits, parent2, parent2);
> > +
> > +	/*
> > +	 * R: auto-remerge of the original parents.
> > +	 *
> > +	 * Use the same branch labels for the inner merges that compute R
> > +	 * and N so conflict markers (if any) are textually identical
> > +	 * between the two; the outer non-recursive merge can then collapse
> > +	 * the manual resolution from O against them.
> > +	 */
> > +	init_basic_merge_options(&remerge_opt, repo);
> > +	remerge_opt.show_rename_progress =3D 0;
> > +	remerge_opt.branch1 =3D "ours";
> > +	remerge_opt.branch2 =3D "theirs";
> > +	if (repo_get_merge_bases(repo, parent1, parent2, &parent_bases) < 0)=
 {
> > +		result->clean =3D -1;
> > +		goto out;
> > +	}
> > +	merge_incore_recursive(&remerge_opt, parent_bases,
> > +			       parent1, parent2, &remerge_res);
> > +	parent_bases =3D NULL; /* consumed by merge_incore_recursive */
> > +	if (remerge_res.clean < 0) {
> > +		result->clean =3D remerge_res.clean;
> > +		goto out;
> > +	}
> > +
> > +	/* N: fresh merge of the (possibly rewritten) parents. */
> > +	init_basic_merge_options(&new_merge_opt, repo);
> > +	new_merge_opt.show_rename_progress =3D 0;
> > +	new_merge_opt.branch1 =3D "ours";
> > +	new_merge_opt.branch2 =3D "theirs";
> > +	if (repo_get_merge_bases(repo, replayed_par1, replayed_par2,
> > +				 &replayed_bases) < 0) {
> > +		result->clean =3D -1;
> > +		goto out;
> > +	}
> > +	merge_incore_recursive(&new_merge_opt, replayed_bases,
> > +			       replayed_par1, replayed_par2, &new_merge_res);
> > +	replayed_bases =3D NULL; /* consumed by merge_incore_recursive */
> > +	if (new_merge_res.clean < 0) {
> > +		result->clean =3D new_merge_res.clean;
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * Outer non-recursive merge: base=3DR, side1=3DO (pickme), side2=3D=
N.
> > +	 */
> > +	pickme_tree =3D repo_get_commit_tree(repo, pickme);
> > +	ancestor_name =3D xstrfmt("auto-remerge of %s",
> > +				oid_to_hex(&pickme->object.oid));
> > +	merge_opt->ancestor =3D ancestor_name;
> > +	merge_opt->branch1 =3D short_commit_name(repo, pickme);
> > +	merge_opt->branch2 =3D "merge of replayed parents";
> > +	merge_incore_nonrecursive(merge_opt,
> > +				  remerge_res.tree,
> > +				  pickme_tree,
> > +				  new_merge_res.tree,
> > +				  result);
> > +	merge_opt->ancestor =3D NULL;
> > +	merge_opt->branch1 =3D NULL;
> > +	merge_opt->branch2 =3D NULL;
> > +	if (!result->clean)
> > +		goto out;
> > +
> > +	parents =3D NULL;
> > +	commit_list_insert(replayed_par2, &parents);
> > +	commit_list_insert(replayed_par1, &parents);
> > +	picked =3D create_commit(repo, result->tree, pickme, parents,
> > +			       REPLAY_MODE_PICK);
> > +
> > +out:
> > +	free(ancestor_name);
> > +	free_commit_list(parent_bases);
> > +	free_commit_list(replayed_bases);
> > +	merge_finalize(&remerge_opt, &remerge_res);
> > +	merge_finalize(&new_merge_opt, &new_merge_res);
> > +	return picked;
> >   }
> >  =20
> >   void replay_result_release(struct replay_result *result)
> > @@ -407,17 +550,63 @@ int replay_revisions(struct rev_info *revs,
> >    merge_opt.show_rename_progress =3D 0;
> >    last_commit =3D onto;
> >    replayed_commits =3D kh_init_oid_map();
> > +
> > +	/*
> > +	 * Seed the rewritten-commit map with each negative-side ("BOTTOM")
> > +	 * cmdline entry pointing at `onto`. This matters for merge replay:
> > +	 * a 2-parent merge whose first parent is the boundary (e.g. the
> > +	 * commit being reworded) must replay onto the rewritten boundary,
> > +	 * yet pick_merge_commit uses a self fallback so the second parent
> > +	 * (a side branch outside the rewrite range) is preserved as-is.
> > +	 * Pre-seeding the boundary disambiguates the two: in the map ->
> > +	 * rewritten, missing -> kept as-is.
> > +	 *
> > +	 * Only do this for the pick path; revert mode chains reverts
> > +	 * through last_commit and a pre-seeded boundary would short-circuit
> > +	 * that chain.
> > +	 */
> > +	if (mode =3D=3D REPLAY_MODE_PICK) {
> > +		for (size_t i =3D 0; i < revs->cmdline.nr; i++) {
> > +			struct rev_cmdline_entry *e =3D &revs->cmdline.rev[i];
> > +			struct commit *boundary;
> > +			khint_t pos;
> > +			int hr;
> > +
> > +			if (!(e->flags & BOTTOM))
> > +				continue;
> > +			boundary =3D lookup_commit_reference_gently(revs->repo,
> > +
> > &e->item->oid, 1);
> > +			if (!boundary)
> > +				continue;
> > +			pos =3D kh_put_oid_map(replayed_commits,
> > +					     boundary->object.oid, &hr);
> > +			if (hr !=3D 0)
> > +				kh_value(replayed_commits, pos) =3D onto;
> > +		}
> > +	}
> > +
> >    while ((commit =3D get_revision(revs))) {
> >     const struct name_decoration *decoration;
> >     khint_t pos;
> >     int hr;
> >   -		if (commit->parents && commit->parents->next)
> > -			die(_("replaying merge commits is not supported
> > yet!"));
> > -
> > -		last_commit =3D pick_regular_commit(revs->repo, commit,
> > replayed_commits,
> > -						  mode =3D=3D REPLAY_MODE_REVERT ?
> > last_commit : onto,
> > -						  &merge_opt, &result, mode);
> > +		if (commit->parents && commit->parents->next) {
> > +			if (commit->parents->next->next) {
> > +				ret =3D error(_("replaying octopus merges is not
> > supported"));
> > +				goto out;
> > +			}
> > +			if (mode =3D=3D REPLAY_MODE_REVERT) {
> > +				ret =3D error(_("reverting merge commits is not
> > supported"));
> > +				goto out;
> > +			}
> > +			last_commit =3D pick_merge_commit(revs->repo, commit,
> > +							replayed_commits,
> > +							&merge_opt, &result);
> > +		} else {
> > +			last_commit =3D pick_regular_commit(revs->repo, commit,
> > replayed_commits,
> > +							  mode =3D=3D
> > REPLAY_MODE_REVERT ? last_commit : onto,
> > +							  &merge_opt, &result,
> > mode);
> > +		}
> >     if (!last_commit)
> >      break;
> >   diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> > index de7b357685..d103f866a2 100755
> > --- a/t/t3451-history-reword.sh
> > +++ b/t/t3451-history-reword.sh
> > @@ -201,12 +201,21 @@ test_expect_success 'can reword a merge commit' =
'
> >     git switch - &&
> >     git merge theirs &&
> >   -		# It is not possible to replay merge commits embedded in the
> > -		# history (yet).
> > -		test_must_fail git -c core.editor=3Dfalse history reword HEAD~
> > 2>err &&
> > -		test_grep "replaying merge commits is not supported yet" err
> > &&
> > +		# Reword a non-merge commit whose descendants include the
> > +		# merge: replay carries the merge through.
> > +		reword_with_message HEAD~ <<-EOF &&
> > +		ours reworded
> > +		EOF
> > +		expect_graph <<-EOF &&
> > +		*   Merge tag ${SQ}theirs${SQ}
> > +		|\\
> > +		| * theirs
> > +		* | ours reworded
> > +		|/
> > +		* base
> > +		EOF
> >   -		# But it is possible to reword a merge commit directly.
> > +		# And reword a merge commit directly.
> >     reword_with_message HEAD <<-EOF &&
> >     Reworded merge commit
> >     EOF
> > @@ -214,7 +223,7 @@ test_expect_success 'can reword a merge commit' '
> >     *   Reworded merge commit
> > |\
> > | * theirs
> > -		* | ours
> > +		* | ours reworded
> > |/
> >     * base
> >     EOF
> > diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
> > index 8ed0cebb50..ad6309f98b 100755
> > --- a/t/t3452-history-split.sh
> > +++ b/t/t3452-history-split.sh
> > @@ -36,7 +36,7 @@ expect_tree_entries () {
> >   	test_cmp expect actual
> >   }
> >  =20
> > -test_expect_success 'refuses to work with merge commits' '
> > +test_expect_success 'refuses to split a merge commit' '
> >    test_when_finished "rm -rf repo" &&
> >    git init repo &&
> >    (
> > @@ -49,9 +49,7 @@ test_expect_success 'refuses to work with merge comm=
its' '
> >     git switch - &&
> >     git merge theirs &&
> >     test_must_fail git history split HEAD 2>err &&
> > -		test_grep "cannot split up merge commit" err &&
> > -		test_must_fail git history split HEAD~ 2>err &&
> > -		test_grep "replaying merge commits is not supported yet" err
> > +		test_grep "cannot split up merge commit" err
> > )
> >   '
> >  =20
> > diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> > index 3353bc4a4d..368b1b0f9a 100755
> > --- a/t/t3650-replay-basics.sh
> > +++ b/t/t3650-replay-basics.sh
> > @@ -103,10 +103,48 @@ test_expect_success 'cannot advance target ...
> > ordering would be ill-defined' '
> >   	test_cmp expect actual
> >   '
> >  =20
> > -test_expect_success 'replaying merge commits is not supported yet' '
> > -	echo "fatal: replaying merge commits is not supported yet!" >expect =
&&
> > -	test_must_fail git replay --advance=3Dmain main..topic-with-merge
> > 2>actual &&
> > -	test_cmp expect actual
> > +test_expect_success 'using replay to rebase a 2-parent merge' '
> > +	# main..topic-with-merge contains a 2-parent merge (P) introduced
> > +	# via test_merge. Use --ref-action=3Dprint so this test does not
> > +	# mutate state for subsequent tests in this file.
> > +	git replay --ref-action=3Dprint --onto main main..topic-with-merge
> > >result &&
> > +	test_line_count =3D 1 result &&
> > +
> > +	new_tip=3D$(cut -f 3 -d " " result) &&
> > +
> > +	# Result is still a 2-parent merge.
> > +	git cat-file -p $new_tip >cat &&
> > +	grep -c "^parent " cat >count &&
> > +	echo 2 >expect &&
> > +	test_cmp expect count &&
> > +
> > +	# Merge subject is preserved.
> > +	echo P >expect &&
> > +	git log -1 --format=3D%s $new_tip >actual &&
> > +	test_cmp expect actual &&
> > +
> > +	# The replayed merge sits on top of main: walking back via the
> > +	# first-parent chain reaches main.
> > +	git merge-base --is-ancestor main $new_tip
> > +'
> > +
> > +test_expect_success 'replaying an octopus merge is rejected' '
> > +	# Build an octopus side-branch so the rest of the test state stays
> > +	# untouched.
> > +	test_when_finished "git update-ref -d refs/heads/octopus-tip" &&
> > +	octopus_tip=3D$(git commit-tree -p topic4 -p topic1 -p topic3 \
> > +		-m "octopus" $(git rev-parse topic4^{tree})) &&
> > +	git update-ref refs/heads/octopus-tip "$octopus_tip" &&
> > +
> > +	test_must_fail git replay --ref-action=3Dprint --onto main \
> > +		topic4..octopus-tip 2>actual &&
> > +	test_grep "octopus merges" actual
> > +'
> > +
> > +test_expect_success 'reverting a merge commit is rejected' '
> > +	test_must_fail git replay --ref-action=3Dprint --revert=3Dtopic-with=
-merge
> > \
> > +		topic4..topic-with-merge 2>actual &&
> > +	test_grep "reverting merge commits" actual
> >   '
> >  =20
> >   test_expect_success 'using replay to rebase two branches, one on top=
 of
> >   other' '
>=20
>=20
