Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6421D3C5
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701391; cv=none; b=IheYMNKyP1vp0pnclBrAxmObnczYKaIdV3PC+K3R3mLsEwV3FIfIEy7NYFbrQF24niw56tDXaD6wL6Sjik/6Ze21+pN4BKHBCH9qobma2bWVtM9R7oRmfN9uWN6UjfmuuNp29iUM7dC1veunRw0RZY2Qb4RwOlbdCxdj5GsQkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701391; c=relaxed/simple;
	bh=bZjrZOz5n8CP5+ZlDd5X0qZ5ZnLpne3uMnhWJ2Rk1zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufnsnOA0VYCRXtP+T45CBZolQufq8qVhRyTxRJpGZHh8Q846CDueYRS/ElwBjVVhHFbxNEuhUmJ9VgCooR+GEx61QcDXONzsJRyqf0j31W09pkEeIBqIJXXI1Ht66viapfJvbUAbhHyTCpTYgCP0Ar3gnfm1poYXsQgSnrgTtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OWutV/lF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a6kfERKw; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OWutV/lF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a6kfERKw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7315814001E3;
	Tue,  2 Dec 2025 13:49:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 02 Dec 2025 13:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764701388;
	 x=1764787788; bh=aBggBEO3DIokCri1/cXCPJCgy6FnFoQOhIQY9HsV888=; b=
	OWutV/lFAIHMN2wGGrKuY9uNa/c68IY3YK+sq+F3DicpsyNxLbDftge9CeihbxLL
	lm9W9b7RVCs05yq0ez2sMGQp3HhmZxKVuADIC9RcW1Rzz1jERFV44lXBpvMST641
	iewZ9sFsS5xFPAFdIOv4mPDlfk62IN8nrLfQ7YgG5hcBm51XlZ9WGpJF30+nkd4J
	cbFwRygSycJFP1TlSKsiiyzzpPXfI2AV4T3ESKQZ7qkzNZqrp/+E3gIjZet8Oa8k
	JS04bGax6AeAabNA/C/otS3py6oBH4RtS0NM0JJyN+MAsPZmTAR/7ot4uY4UezGA
	Vd4r900z1qo0WoywksBuEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764701388; x=
	1764787788; bh=aBggBEO3DIokCri1/cXCPJCgy6FnFoQOhIQY9HsV888=; b=a
	6kfERKws3XdDLv/9A3/RdBhdtz9PWlXnfqiHghfdHUuJsjPrzKb3r+wmwnaaLVwk
	N2jLy/5jyU2Q/tvC8nN4Uu1Tm+y3X07yM2n2Qct2CIFtsB5BN+KbaWOENeCYi7JX
	dk7sNbUPo8s8XQB+PwBd+38GFgP4cMusEXFOy9+UGHMC6BCM2el8Fel9bXYODKAM
	wjYIwZyQojjTNcMgHmnJwKznJeNYbJAyrPYz5ad0MuFcRKHq9gPOFAlRzgm+2wXt
	YAzhpvAu/MvAAXcXSd7KkAgZk0CxSlTdRO5GulqQo563tZKN01GJAT1Inb2NBwyW
	6JimbyYtmsyzo41Jtw+vw==
X-ME-Sender: <xms:zDQvaUY6PTzkWKgi7bu95NoocEKQZL8rrWqL9jMIw6lSORal3_etGg>
    <xme:zDQvaR-UqEcs0iZz76MgO-ianJ2YHnaDdfD43fH2l6k6bNDXt3zknVc4p0oNAaEZ5
    T_KFY7EMEHyUG0fhk-SZl_1jSxZlosJfqvt9Olvki5zT8UEaY2bqA>
X-ME-Received: <xmr:zDQvaSnAjO2BENWm9u2SmlaTQJxBIZEbhE00KmEQq5t_rLTUTWeCrw_H7OiHbSY9huB9UVOwnNGFhZz3c6b1b2Amh0JsdwjZ864tIqWU-9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvd
    efjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilh
    drtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:zDQvaexc61r9E1tZkr2FQ_4ME2IZbjGtJFQNI7tvD4FtDLP8qPH3nA>
    <xmx:zDQvaU7Iwv5eMrzJbQxKlrI9WZzx9rl7kOS0LHZYF04hlBoqOUT2IA>
    <xmx:zDQvaWUTb9YWJd7pu1ymavC08MrgpummcS5rnimuJEIOn17xSajigA>
    <xmx:zDQvaUL82lgB9PmKHsXWoP5tzW0PaSFj96r60cLQgCVXEDu_6-2Vpg>
    <xmx:zDQvacXYbElWF_4vEM5dDm1GZr0FSp_ALAC_4pB5yNRQ2zOJTaRzbQ2C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 13:49:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a9d3b47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 18:49:45 +0000 (UTC)
Date: Tue, 2 Dec 2025 19:49:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 11/11] builtin/history: implement "split" subcommand
Message-ID: <aS80wzWB57VPGxIq@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-11-407dd3f57ad3@pks.im>
 <CABPp-BGP_BecoGf093MTK-FaXTc-B0SGRkH8SHkB39nAT5fb3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGP_BecoGf093MTK-FaXTc-B0SGRkH8SHkB39nAT5fb3Q@mail.gmail.com>

On Wed, Nov 19, 2025 at 11:05:37PM -0800, Elijah Newren wrote:
> On Mon, Oct 27, 2025 at 4:34 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index bd903875120..3d6b2665f8d 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -37,6 +38,26 @@ Several commands are available to rewrite history in different ways:
> >         details of this commit remain unchanged. This command will spawn an
> >         editor with the current message of that commit.
> >
> > +`split <commit> [--] [<pathspec>...]`::
> > +       Interactively split up <commit> into two commits by choosing
> > +       hunks introduced by it that will be moved into the new split-out
> > +       commit. These hunks will then be written into a new commit that
> > +       becomes the parent of the previous commit. The original commit
> > +       stays intact, except that its parent will be the newly split-out
> > +       commit.
> 
> Always two?  Should we allow someone to split into three or four?

For now it's always two, yes. This is mostly modeled after `jj split`,
which also does the same. For the sake of simplicity I'd suggest to keep
it like this by default, but I could certainly see that we introduce a
new option in the future that allows the user to split into multiple
commits. In that case, we would simply loop around the interactive
prompt until all remaining hunks have been selected.

> > ++
> > +The commit message of the new commit will be asked for by launching the
> > +configured editor. Authorship of the commit will be the same as for the
> > +original commit.
> 
> Which one is the new one?  Aren't they both?

I'll change the behaviour to ask for a message for both commits, so I'll
adapt this.

> > ++
> > +If passed, _<pathspec>_ can be used to limit which changes shall be split out
> > +of the original commit. Files not matching any of the pathspecs will remain
> > +part of the original commit. For more details, see the 'pathspec' entry in
> > +linkgit:gitglossary[7].
> > ++
> > +It is invalid to select either all or no hunks, as that would lead to
> > +one of the commits becoming empty.
> 
> If the user edits a hunk, what happens then?  Is this function
> prepared to deal with that?

The second commit will retain the original tree, so there wouldn't be a
conflict even in that case. It's a good question though -- maybe we
should disable editing hunks for now?

> > +diff --git a/foo b/foo
> > +new file mode 100644
> > +index 0000000..257cc56
> > +--- /dev/null
> > ++++ b/foo
[snip]
> > +       /* We retain authorship of the original commit. */
> > +       original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
> > +       ptr = find_commit_header(original_message, "author", &len);
> > +       if (ptr)
> > +               original_author = xmemdupz(ptr, len);
> > +
> > +       ret = fill_commit_message(repo, &parent_tree_oid, &split_tree->object.oid,
> > +                                 "", "split-out", &split_message);
> > +       if (ret < 0)
> > +               goto out;
> > +
> > +       ret = commit_tree(split_message.buf, split_message.len, &split_tree->object.oid,
> > +                         original_commit->parents, &out[0], original_author, NULL);
> 
> As with reword, you are discarding all extended headers?

Good catch, will fix!

> > +       if (ret < 0) {
> > +               ret = error(_("failed writing split-out commit"));
> > +               goto out;
> > +       }
> > +
> > +       /*
> > +       * The second commit is much simpler to construct, as we can simply use
> > +       * the original commit details, except that we adjust its parent to be
> > +       * the newly split-out commit.
> > +       */
> > +       find_commit_subject(original_message, &original_body);
> > +       first_commit = lookup_commit_reference(repo, &out[0]);
> > +       commit_list_append(first_commit, &parents);
> > +
> > +       ret = commit_tree(original_body, strlen(original_body), &original_commit_tree_oid,
> > +                         parents, &out[1], original_author, NULL);
> 
> I don't understand why the second commit is the one that is to retain
> the commit message.  I can see that users would sometimes want that,
> but I don't see why it'd be hardcoded.

My thinking here is that "I am splitting changes out of a specific
commit", so that commit still continues to exist.

[snip]
> > +       commit_list_append(original_commit, &from_list);
> > +       if (!repo_is_descendant_of(repo, head, from_list)) {
> > +               ret = error(_("split commit must be reachable from current HEAD commit"));
> > +               goto out;
> > +       }
> 
> Again, I don't see why the commit to be split needs to be an ancestor
> of HEAD; seems like an arbitrary requirement.

This is done for the sake of simplicity: I'd rather want to be as
restrictive as possible initially and then extend git-history(1) to
handle more cases as we go forward.

[snip]
> > +       /*
> > +        * Then we split up the commit and replace the original commit with the
> > +        * new ones.
> > +        */
> > +       ret = split_commit(repo, original_commit, &pathspec, split_commits);
> > +       if (ret < 0)
> > +               goto out;
> > +
> > +       replace_commits(&commits, &original_commit->object.oid,
> > +                       split_commits, ARRAY_SIZE(split_commits));
> > +
> > +       ret = apply_commits(repo, &commits, parent, head, "split");
> > +       if (ret < 0)
> > +               goto out;
> 
> Much like with "reword", I think we could drop your auxiliary
> functions (collect_commits(), replace_commits(), apply_commits()),
> since replay already handles revision walking.

I mostly introduced these functions because I want to extend
git-history(1) going forward to also handle cases that git-replay(1)
doesn't currently handle. This includes for example also reordering of
commits, which I think isn't easily possible with the replay subsystem?

> However, unlike with "reword" you've got a slight mess here.  If the
> user edits the hunk to be applied, then (1) the rest of the replayed
> commits may have conflicts (which replay doesn't handle yet), and (2)
> after replaying you'll need to reset your working tree and index to
> match the rebased result, which will be tricky if you had either
> staged or unstaged modifications.

Yeah, the "editing" part is an actual oversight on my part. I'll
restrict this for now.

> > diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
> > new file mode 100755
> > index 00000000000..2aac28afdf0
> > --- /dev/null
> > +++ b/t/t3452-history-split.sh
> > @@ -0,0 +1,432 @@
[snip]
> > +test_expect_success 'refuses to work with unrelated commits' '
> > +       test_when_finished "rm -rf repo" &&
> > +       git init repo &&
> > +       (
> > +               cd repo &&
> > +               test_commit base &&
> > +               git branch branch &&
> > +               test_commit ours &&
> > +               git switch branch &&
> > +               test_commit theirs &&
> > +               test_must_fail git history split ours 2>err &&
> > +               test_grep "split commit must be reachable from current HEAD commit" err
> > +       )
> > +'
> 
> I don't understand why this test is desirable.  I guess that's not
> surprising given that I called into question why you'd want this to be
> an error in the relevant code.

The question is what happens in the case where you edit a commit that is
unrelated to the current history. Which branches would be updated? Do we
update any at all? If not, what would the user-visible result be? We're
getting into territory where semantics are not immediately obvious, and
I want git-history(1) to be a command that makes history editing easy
for the most common use cases.

If we find good semantics in the future for how to perform such an
operation I'm very much in favor of adding that behaviour. But I think
that this is outside the scope of this series right now, as I rather
care about making the easy and obvious parts work first.

And meanwhile, while we still have restrictions like these in place, I
want to ensure that we don't accidentally do the wrong thing in cases
that we don't yet support. Hence the test.

> > +test_expect_success 'hooks are executed for rewritten commits' '
> > +       test_when_finished "rm -rf repo" &&
> > +       git init repo &&
> > +       (
> > +               cd repo &&
> > +               touch bar foo &&
> > +               git add . &&
> > +               git commit -m split-me &&
> > +               old_head=$(git rev-parse HEAD) &&
> > +
> > +               write_script .git/hooks/prepare-commit-msg <<-EOF &&
> > +               touch "$(pwd)/hooks.log"
> > +               EOF
> > +               write_script .git/hooks/post-commit <<-EOF &&
> > +               touch "$(pwd)/hooks.log"
> > +               EOF
> > +               write_script .git/hooks/post-rewrite <<-EOF &&
> > +               touch "$(pwd)/hooks.log"
> > +               EOF
> > +
> > +               set_fake_editor "split-out commit" &&
> > +               git history split HEAD <<-EOF &&
> > +               y
> > +               n
> > +               EOF
> > +
> > +               expect_log <<-EOF &&
> > +               split-me
> > +               split-out commit
> > +               EOF
> > +
> > +               test_path_is_missing hooks.log
> > +       )
> > +'
> 
> `test_path_is_missing hooks.log` suggests the hooks are NOT executed
> for rewritten commits; your cover letter and documentation said hooks
> wouldn't run either, so I'm guessing the test description is the bug
> here left over from an earlier round?

It is indeed, thanks!

> > +test_expect_success 'retains changes in the worktree and index' '
> > +       test_when_finished "rm -rf repo" &&
> > +       git init repo &&
> > +       (
> > +               cd repo &&
> > +               echo a >a &&
> > +               echo b >b &&
> > +               git add . &&
> > +               git commit -m "initial commit" &&
> > +               echo a-modified >a &&
> > +               echo b-modified >b &&
> > +               git add b &&
> > +               set_fake_editor "a-only" &&
> > +               git history split HEAD <<-EOF &&
> > +               y
> > +               n
> > +               EOF
> > +
> > +               expect_tree_entries HEAD~ <<-EOF &&
> > +               a
> > +               EOF
> > +               expect_tree_entries HEAD <<-EOF &&
> > +               a
> > +               b
> > +               EOF
> > +
> > +               cat >expect <<-\EOF &&
> > +                M a
> > +               M  b
> > +               ?? actual
> > +               ?? expect
> > +               ?? fake-editor.sh
> > +               EOF
> > +               git status --porcelain >actual &&
> > +               test_cmp expect actual
> > +       )
> > +'
> 
> ...but does this test mean we need to prevent users from editing hunks
> when splitting commits?  If we don't, how can we retain changes in the
> worktree and index?

I'll disallow editing hunks for now. We may reintroduce this ability in
the future, but let's focus on the easy parts for now :)

Patrick
