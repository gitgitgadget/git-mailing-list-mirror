Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1824677B
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701755; cv=none; b=Ih5Pv2sbKhQGzu0a0Xuf27XmAwIIPfpSQCn75QUyjWadzm+QDlzDc8WugRda0nhMpdDy8bmrSukDx4UV2FJhw1FgKjEVOd4PtDKJmnSMVfg8k7ICg5Tq1tDDf0w4B8Q99l4u7mKNQNS0zGSutsnqwPPGC9ztK5rDIjCzKoOKreE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701755; c=relaxed/simple;
	bh=QHRg8mzOdeSMy32pysN7OBAwlvxCkySUEoSg8ocRSMw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=h7DKx5aplV0lEgXddjmKkbEV3oLWXPAAOj9JFpLPscdbfMlQQzFKC8Jxh5Nae1ZrnuZUWLRyP0j84iKfGfwQZgcIqy1hqWthjAZ3MjVd0jPKR7bNRvjEaBk/6q2XQoI1dBdkcqqzEPlVLAvvxnf9u8AL19yevOV/YedjdsLnrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb005rXU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb005rXU"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso1468406a91.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701753; x=1784306553; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JSB2l2ET7JHuc/0yFPiK4iz4L2iQTo2pgKHs5KyhF4M=;
        b=Wb005rXUdBHkTE1gRyAEA18x4/XUJ/r7FCW4V/mu+n6xrhsnhvdf1br4QfImrFWsEk
         ovmPxtcQWJ3poUMrGt3f+sk2QB1o7Th+6y2TxcxRDhvlk3e2IPi7XW7dNrSoCLA5XpIW
         /0imNJ7Uo7FWVsBE2CbeW+PPgIZMZe3/3jzYuwYftXo359UgeufYDCBctdES7NP18dK5
         p1b8hg/84PF3lklo3eYznPsasUzkTZAIvnMbgOOePsPFpYhfOKN7UEl0T8c58+9S59LG
         JEoLkMJ2hZ/259ygvt8O8j32KmmnLtvacvVYeKg5h7O7LArXtgXFQlPXPUVyERCCeVIk
         4W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701753; x=1784306553;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JSB2l2ET7JHuc/0yFPiK4iz4L2iQTo2pgKHs5KyhF4M=;
        b=DToeeLHUTI+PhRVtq5tiG/FV8ZPZ3CTrOiB1oKAxY75qbJbUIpNIjFcP/jUq/UZa/S
         MR4qtmLSednGeq37izwl/Ad+LGV4bkPVy5+qvkalgogMY2LmUfdGMlzNcxx0iQ4FHHK6
         HoMl15UubfzJ3MFPLsaxV/86IEU2Nz0i+nj2yR+JXn1135kuhemh8ANmRToOLrkgC1O1
         gH9B1/SeCMSmkH1qGEcq7ZrAAdwXPd/ljxFrvsTny2aISTG2rU3YTrlzmHIAkuklwVds
         l85iAiXdKKDY/ZkAkahVevoQrYrhvp/JjGR7Bo1G54Tn+Twldhip3hpweds/dba867de
         Q7IA==
X-Forwarded-Encrypted: i=1; AHgh+RrcweXcxqx0TlQVcVqZ8QQqUN+n4ULazuC0/NvkWfTG5MxK3blvoM6yvuhuLLt8loxMpos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ432a0CwMs2c82KFrzCG4Cw9KJjR+VzcP5lRHK/3x+FcfQRf4
	8SYJz1CJtNWvoWMuqwjEi7GRRe5uU3StEdBdixb0K7Wj+1Qzri7M3Eo1
X-Gm-Gg: AfdE7cnrtU/EC/mG1LpDb06x1DriaRo7J/n6OodGbIdEb/QssAbGa8wregj8kFi19NH
	+fogsmC+Nt9pgNra5jPe3v4JHSozPYHaOeY2tVsVnwkitcDNMEjJs09asO5Ehr13yKf8mUbNNfe
	FNBP9KVuWJceMmDExVmpW9sFDfDffAGFPK+EukxjG/0rfrT7kqlrr7oJ+SNkhap2JvjIAZ8w97Z
	8rzTpFPHa4TBood3uyzGw+nG3Y965XfTyH6yKYvfmyQ/uVWl8B6L6Gnk8pQNQM8qoK3AN6onhar
	OiMi/DGNH+97nSZLK7aWwZbM76W/7mwZ7yD9588uWVjOtkawcKzeRlWGv0hJDuxPGUKSYepZO6d
	qLuLEfAIPFnlGy/dAaTz0cgGBzdMrN/Cv+R/lpx8D4eDfZSI9mdDXii9Udlwu+DQQaTtvMPKaX3
	ZyRZ5w0DVEvhn0RA==
X-Received: by 2002:a17:90b:2f06:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-38941101dfemr12442589a91.7.1783701752930;
        Fri, 10 Jul 2026 09:42:32 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm11762635eec.6.2026.07.10.09.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 09:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 09:42:31 -0700
Message-Id: <DJV1I085BRB7.20RAPPD7AXC41@gmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>, "Elijah Newren"
 <newren@gmail.com>, "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano"
 <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: honor --empty when a fixup!/squash! empties
 its target
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Phillip Wood" <phillip.wood123@gmail.com>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com>
 <afb76b98-661a-4663-8e8b-fd00572db5ba@gmail.com>
In-Reply-To: <afb76b98-661a-4663-8e8b-fd00572db5ba@gmail.com>

On Fri Jul 10, 2026 at 6:28 AM PDT, Phillip Wood wrote:

Phillip,

Thank you for responding. This is my first submission to the Git mailing
list.

I want to be forthecoming that I'm not familiar with the Git codebase,
and (maybe unsurprisingly) I have been leveraging LLMs to help me
understand the code and write the patch. I consulted the Git
contribution guidelines and it says that should be OK as long as it's
not "slop". I'm diligent to remaining in the loop (HITL) and reviewing
the code and tests to the best of my understanding of the codebase.

I will send the V2 shortly. Thank you!

> Hi Farid
>
> On 10/07/2026 05:13, Farid Zakaria wrote:
>> When "git rebase --autosquash" melds a "fixup!" or "squash!" commit into
>> its target, the result can be a commit that no longer changes anything
>> relative to its parent, for example when the melded change reverts the
>> target.  Rather than dropping or keeping this empty commit, the rebase
>> stops with
>>=20
>> 	You asked to amend the most recent commit, but doing so would
>> 	make it empty. ...
>>=20
>> and the "--empty" option has no effect on it.  This makes backing a
>> change out of a series awkward: reverting a commit as a "fixup!" and
>> running "git rebase --autosquash --empty=3Ddrop" ought to remove both th=
e
>> commit and its revert, but it halts instead.
>
> I agree this is a use case that we want to support
>
>> The reason is that allow_empty() decides emptiness with
>> is_index_unchanged(), which compares the index to HEAD.  A "fixup!" is
>> applied by amending HEAD, so the commit it produces has HEAD's parent as
>> its parent; it is empty when the index matches the tree of that parent,
>> not of HEAD.  A meld that cancels out its target is therefore never
>> recognized as having become empty, and falls through to "git commit
>> --amend", which refuses to create an empty commit.
>
> and with this diagnosis.
>
>> Teach is_index_unchanged() to compare against the tree of HEAD's parent
>> when amending, and teach allow_empty() to classify the result as "became
>> empty" (and thus subject to --empty) unless the commit being melded into
>> was itself already empty, in which case it "started empty" and is
>> governed by allow_empty as before.
>
> However, I think that rather than changing the current check which=20
> changes the behavior of a fixup commit that becomes empty we should add=
=20
> an additional check to see if applying the fixup makes the target commit=
=20
> empty. With the patch here a fixup commit that becomes empty is only=20
> seen as empty if the commit being fixed up is empty in which case we=20
> always accept the fixup, whereas the current behavior is always to=20
> respect what --empty says. When I'm planning out a series of commits I=20
> sometimes create empty commits where the messages says what I'm=20
> intending to do and then I create fixups for them when I get round to=20
> writing the code. If one of those fixups becomes empty I want to know=20
> about it because it means I need to drop the empty commit that's being=20
> fixed up as well.
>

Thank you for this catch. I will apply the changes you suggest in V2 and
add test cases for this missing behavior.

>> When --empty=3Ddrop applies, the emptied commit has already been created
>> by the preceding "pick", so drop it by moving HEAD back to its parent.
>> Do so before the rewritten-commit list is flushed, so that --update-refs
>> and the other rewrite consumers map the dropped commit to its parent.
>
> If we're dropping the commit then we should not record it as rewritten=20
> so we need to remove the rewritten-pending file. Any labels and=20
> update-ref commands that come immediately after the dropped commit will=
=20
> see HEAD pointing to the dropped commits rewritten parent.
>

I will address this in V2 as well.

>> Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
>> ---
>> At Meta we maintain a fork of LLVM that we regularly rebase onto
>> upstream.  A set of internal patches rides on top, and we keep each one
>> as a single commit by folding follow-up changes into it with autosquash
>> "fixup!" commits.  That works well for evolving a patch, but not for
>> retiring one: to back an internal patch out today we delete it from the
>> history by hand with an interactive rebase and then force-push, which is
>> easy to get wrong on a shared branch.
>
> You'll still need a forced push though because you're dropping the=20
> commit. I think the change you're proposing to git would be useful but=20
> you could automate your existing workflow by setting GIT_SEQUENCE_EDITOR=
=20
> to a script that drops the commit and it's fixups from the todo list.
>

True. I guess I should have clarified we run with a script that already
uses GIT_SEQUENCE_EDITOR and force-pushes. I just wanted to avoid cases
where a developer has to intervene in the rebase and force-push.
Developers must still intervene and force-push when a conflict arises in
our workflow though....

>> One open question, for a possible follow-up.  A natural next step would
>> be a "revert!" autosquash directive (and a "git commit --revert" to
>> create it), mirroring "fixup!"/"squash!", so
>> that retiring a patch would not require generating the reverse diff by
>> hand.  I have deliberately left it out of this series, because its
>> semantics are not obvious: in particular, whether a "revert!" commit
>> should carry the reverse patch as its own content (and thus be an
>> ordinary fixup that this patch already drops), or be an empty marker
>> that instructs the rebase to revert the target commit during the meld.
>> Opinions on whether such a directive is wanted, and which of those two
>> shapes is preferred, would be welcome before I attempt it.
>
> I think having support for creating and squashing revert! (or possibly=20
> drop!) commits is a good idea (I've a feeling there is some discussion=20
> about that in the gitgitgadget issue tracker). Using an empty commit has=
=20
> a marker has the advantage that applying it cannot create conflicts, so=
=20
> you only have to deal with the conflicts caused by the commit being=20
> dropped, not the by fixup not applying cleanly.
>

This seems like a nice ergonomic improvement but I chose to leave it out
since it seems particularly thorny to get right.
I know for us at Meta, we use Phabricator (similar to Gerrit) and
working with empty commits is I think problematic for the code review
tooling (unsubstantiated).

If this current patch series makes it's way through though I can tackle
an approach as an RFC.

> Thanks
>
> Phillip
>
>> ---
>> base-commit: f60db8d575adb79761d363e026fb49bddf330c73
>> ---
>>   Documentation/git-rebase.adoc | 12 ++++++
>>   sequencer.c                   | 96 +++++++++++++++++++++++++++++++++++=
++++----
>>   t/t3415-rebase-autosquash.sh  | 64 +++++++++++++++++++++++++++++
>>   3 files changed, 163 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.ad=
oc
>> index f6c22d1598..7eb8bbe95f 100644
>> --- a/Documentation/git-rebase.adoc
>> +++ b/Documentation/git-rebase.adoc
>> @@ -282,6 +282,11 @@ by `git log --cherry-mark ...`) are detected and dr=
opped as a
>>   preliminary step (unless `--reapply-cherry-picks` or `--keep-base` is
>>   passed).
>>   +
>> +A commit can also become empty as a result of `--autosquash`, when a
>> +`fixup!` or `squash!` commit cancels out all of the changes of the
>> +commit it is melded into.  Such a commit is treated the same way and is
>> +dropped, kept, or stopped at according to this option.
>> ++
>>   See also INCOMPATIBLE OPTIONS below.
>>  =20
>>   --no-keep-empty::
>> @@ -591,6 +596,13 @@ changed from `pick` to `squash`, `fixup` or `fixup =
-C`, respectively, and they
>>   are moved right after the commit they modify.  The `--interactive` opt=
ion can
>>   be used to review and edit the todo list before proceeding.
>>   +
>> +If melding a `fixup!` or `squash!` commit cancels out all of the change=
s of
>> +the commit it is applied to, the result is an empty commit.  The handli=
ng of
>> +these empty commits can be configured with the `--empty` option: the em=
ptied
>> +commit is dropped, kept, or stopped at.  This makes it possible to back=
 a
>> +change out of a series by committing a revert of it as a `fixup!` and l=
etting
>> +`--autosquash --empty=3Ddrop` remove both.
>> ++
>>   The recommended way to create commits with squash markers is by using =
the
>>   `--squash`, `--fixup`, `--fixup=3Damend:` or `--fixup=3Dreword:` optio=
ns of
>>   linkgit:git-commit[1], which take the target commit as an argument and
>> diff --git a/sequencer.c b/sequencer.c
>> index 0fe8fed6c3..435b100e3d 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -823,7 +823,7 @@ static struct object_id *get_cache_tree_oid(struct i=
ndex_state *istate)
>>   	return &istate->cache_tree->oid;
>>   }
>>  =20
>> -static int is_index_unchanged(struct repository *r)
>> +static int is_index_unchanged(struct repository *r, int amend)
>>   {
>>   	struct object_id head_oid, *cache_tree_oid;
>>   	const struct object_id *head_tree_oid;
>> @@ -856,7 +856,26 @@ static int is_index_unchanged(struct repository *r)
>>   		if (repo_parse_commit(r, head_commit))
>>   			return -1;
>>  =20
>> -		head_tree_oid =3D get_commit_tree_oid(head_commit);
>> +		if (amend) {
>> +			/*
>> +			 * When amending (e.g. melding a "fixup!" or "squash!"),
>> +			 * the commit we are about to create replaces HEAD, so
>> +			 * its parent is HEAD's parent.  It is therefore empty
>> +			 * when the index matches the tree of HEAD's parent
>> +			 * rather than the tree of HEAD itself.
>> +			 */
>> +			if (head_commit->parents) {
>> +				struct commit *parent =3D
>> +					head_commit->parents->item;
>> +				if (repo_parse_commit(r, parent))
>> +					return -1;
>> +				head_tree_oid =3D get_commit_tree_oid(parent);
>> +			} else {
>> +				head_tree_oid =3D the_hash_algo->empty_tree;
>> +			}
>> +		} else {
>> +			head_tree_oid =3D get_commit_tree_oid(head_commit);
>> +		}
>>   	}
>>  =20
>>   	if (!(cache_tree_oid =3D get_cache_tree_oid(istate)))
>> @@ -1786,7 +1805,7 @@ static int is_original_commit_empty(struct commit =
*commit)
>>    */
>>   static int allow_empty(struct repository *r,
>>   		       struct replay_opts *opts,
>> -		       struct commit *commit)
>> +		       struct commit *commit, int amend)
>>   {
>>   	int index_unchanged, originally_empty;
>>  =20
>> @@ -1798,13 +1817,33 @@ static int allow_empty(struct repository *r,
>>   	 * drop_redundant_commits determine whether the commit should be kept=
 or
>>   	 * dropped. If neither is specified, halt.
>>   	 */
>> -	index_unchanged =3D is_index_unchanged(r);
>> +	index_unchanged =3D is_index_unchanged(r, amend);
>>   	if (index_unchanged < 0)
>>   		return index_unchanged;
>>   	if (!index_unchanged)
>>   		return 0; /* we do not have to say --allow-empty */
>>  =20
>> -	originally_empty =3D is_original_commit_empty(commit);
>> +	/*
>> +	 * When amending (melding a "fixup!"/"squash!"), the resulting commit
>> +	 * replaces HEAD, so whether it "started" empty or "became" empty is
>> +	 * decided by whether the commit being melded into was itself empty: i=
f
>> +	 * HEAD had content that the fixup cancelled out, the commit became em=
pty
>> +	 * and is subject to keep/drop_redundant; if HEAD was already empty, t=
he
>> +	 * commit started empty and is subject to allow_empty as usual.
>> +	 */
>> +	if (amend) {
>> +		struct object_id head_oid;
>> +		struct commit *head_commit;
>> +
>> +		if (repo_get_oid(r, "HEAD", &head_oid))
>> +			return error(_("could not resolve HEAD commit"));
>> +		head_commit =3D lookup_commit_reference(r, &head_oid);
>> +		if (!head_commit)
>> +			return -1;
>> +		originally_empty =3D is_original_commit_empty(head_commit);
>> +	} else {
>> +		originally_empty =3D is_original_commit_empty(commit);
>> +	}
>>   	if (originally_empty < 0)
>>   		return originally_empty;
>>   	if (originally_empty)
>> @@ -2260,6 +2299,30 @@ static const char *reflog_message(struct replay_o=
pts *opts,
>>   	return buf.buf;
>>   }
>>  =20
>> +/*
>> + * A "fixup!"/"squash!" that melds into HEAD may empty it out.  In that=
 case,
>> + * with --empty=3Ddrop, we want to drop the commit entirely.  Since the=
 commit
>> + * being amended has already been created (by the preceding "pick"), an=
d the
>> + * index and worktree already match the tree of its parent, dropping it=
 is a
>> + * matter of moving HEAD back to that parent.
>> + */
>> +static int reset_head_to_parent(struct repository *r, struct replay_opt=
s *opts,
>> +				struct object_id *head)
>> +{
>> +	struct commit *head_commit =3D lookup_commit_reference(r, head);
>> +
>> +	if (!head_commit || repo_parse_commit(r, head_commit))
>> +		return error(_("could not parse HEAD commit"));
>> +	if (!head_commit->parents)
>> +		return error(_("cannot drop the root commit"));
>> +
>> +	return refs_update_ref(get_main_ref_store(r),
>> +			       reflog_message(opts, "fixup",
>> +					      "dropping emptied commit"),
>> +			       "HEAD", &head_commit->parents->item->object.oid,
>> +			       head, 0, UPDATE_REFS_MSG_ON_ERR);
>> +}
>> +
>>   static int do_pick_commit(struct repository *r,
>>   			  struct todo_item *item,
>>   			  struct replay_opts *opts,
>> @@ -2493,7 +2556,7 @@ static int do_pick_commit(struct repository *r,
>>   	}
>>  =20
>>   	drop_commit =3D 0;
>> -	allow =3D allow_empty(r, opts, commit);
>> +	allow =3D allow_empty(r, opts, commit, flags & AMEND_MSG);
>>   	if (allow < 0) {
>>   		res =3D allow;
>>   		goto leave;
>> @@ -2506,9 +2569,24 @@ static int do_pick_commit(struct repository *r,
>>   		unlink(git_path_merge_msg(r));
>>   		refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
>>   				NULL, REF_NO_DEREF);
>> -		fprintf(stderr,
>> -			_("dropping %s %s -- patch contents already upstream\n"),
>> -			oid_to_hex(&commit->object.oid), msg.subject);
>> +		if (flags & AMEND_MSG) {
>> +			/*
>> +			 * The "fixup!"/"squash!" emptied out the commit it was
>> +			 * melded into; that commit was already created by the
>> +			 * preceding "pick", so drop it by moving HEAD back to
>> +			 * its parent.
>> +			 */
>> +			res =3D reset_head_to_parent(r, opts, &head);
>> +			if (res)
>> +				goto leave;
>> +			fprintf(stderr,
>> +				_("dropping %s %s -- resulting commit is empty\n"),
>> +				oid_to_hex(&commit->object.oid), msg.subject);
>> +		} else {
>> +			fprintf(stderr,
>> +				_("dropping %s %s -- patch contents already upstream\n"),
>> +				oid_to_hex(&commit->object.oid), msg.subject);
>> +		}
>>   	} /* else allow =3D=3D 0 and there's nothing special to do */
>>   	if (!opts->no_commit && !drop_commit) {
>>   		if (author || command =3D=3D TODO_REVERT || (flags & AMEND_MSG))
>> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
>> index 5033411a43..508dcc7527 100755
>> --- a/t/t3415-rebase-autosquash.sh
>> +++ b/t/t3415-rebase-autosquash.sh
>> @@ -510,4 +510,68 @@ test_expect_success 'pick and fixup respect commit.=
cleanup' '
>>   	test_commit_message HEAD -m "something"
>>   '
>>  =20
>> +test_expect_success 'fixup! that empties its target is dropped with --e=
mpty=3Ddrop' '
>> +	git reset --hard base &&
>> +	test_commit --no-tag addX fileX 1 &&
>> +	test_commit --no-tag changeX fileX 2 &&
>> +	test_commit --no-tag later fileW hello &&
>> +	echo 1 >fileX &&
>> +	git commit -m "fixup! changeX" fileX &&
>> +
>> +	git rebase -i --autosquash --empty=3Ddrop HEAD~4 &&
>> +
>> +	git log --format=3D%s >actual &&
>> +	! grep changeX actual &&
>> +	grep addX actual &&
>> +	grep later actual &&
>> +	echo 1 >expect &&
>> +	test_cmp expect fileX &&
>> +	echo hello >expect &&
>> +	test_cmp expect fileW
>> +'
>> +
>> +test_expect_success 'fixup! that empties its target is kept with --empt=
y=3Dkeep' '
>> +	git reset --hard base &&
>> +	test_commit --no-tag addY fileY 1 &&
>> +	test_commit --no-tag changeY fileY 2 &&
>> +	echo 1 >fileY &&
>> +	git commit -m "fixup! changeY" fileY &&
>> +
>> +	git rebase -i --autosquash --empty=3Dkeep HEAD~3 &&
>> +
>> +	git log --format=3D%s >actual &&
>> +	grep changeY actual &&
>> +	: "the retained commit is empty" &&
>> +	git diff --exit-code HEAD~1 HEAD &&
>> +	echo 1 >expect &&
>> +	test_cmp expect fileY
>> +'
>> +
>> +test_expect_success 'fixup! that empties its target stops with --empty=
=3Dstop' '
>> +	git reset --hard base &&
>> +	test_commit --no-tag addZ fileZ 1 &&
>> +	test_commit --no-tag changeZ fileZ 2 &&
>> +	echo 1 >fileZ &&
>> +	git commit -m "fixup! changeZ" fileZ &&
>> +
>> +	test_when_finished "git rebase --abort" &&
>> +	test_must_fail git rebase -i --autosquash --empty=3Dstop HEAD~3
>> +'
>> +
>> +test_expect_success 'squash! that empties its target is dropped with --=
empty=3Ddrop' '
>> +	git reset --hard base &&
>> +	test_commit --no-tag addS fileS 1 &&
>> +	test_commit --no-tag changeS fileS 2 &&
>> +	echo 1 >fileS &&
>> +	git commit -m "squash! changeS" fileS &&
>> +
>> +	git rebase -i --autosquash --empty=3Ddrop HEAD~3 &&
>> +
>> +	git log --format=3D%s >actual &&
>> +	! grep changeS actual &&
>> +	grep addS actual &&
>> +	echo 1 >expect &&
>> +	test_cmp expect fileS
>> +'
>> +
>>   test_done
>>=20
>>=20
>>=20
>>=20

