Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1732D238D
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701450; cv=none; b=b+FuAzgeuBMTQMQRzC1GwATrvgjenrLXLoFs7GHO8KuJjhumtoD3bqMde5XPr0p0QrQ2il+/yqnfB1sfA80RDbgqtdIRS7z9SRZJjtOk1olIvYY3C2H9GF2RU0OJcJgTxWvKt7+HoPIgu3xxJvs8p03zVfU2YRfEJy+JcJLiJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701450; c=relaxed/simple;
	bh=2NkXihZrkYEkOLwOHPGZOKswSnzxNW1xS0fb2bsNDBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW5f64fdja9T/+3CUr0J9V7TbIHp6gsgUFozURCrxMi50AWEjrxbbLdEORTqko83KmnLfUo4mkN2dqJ+NlODbL/DbiRSBIxrBPprK//jCGFbWCHRYJcHovX46Pm3wqnmUSosTjLUYuHGaybr9RcDtznVYn4NIJBe5OLxV+OAMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HdxPDqyP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LYv8A77J; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HdxPDqyP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LYv8A77J"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B7A1FEC05A3;
	Tue,  2 Dec 2025 13:50:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 02 Dec 2025 13:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764701447; x=1764787847; bh=2nvVFOQOvH
	v3zqCUDUczstlc3i5mYiXrQ0IDkpOwzts=; b=HdxPDqyPwy5YBiwG3kiPz5opDx
	Ri2KJKwO144yhR8SvmkoFvJtmR36YznqyHSYuytjIqYpXt76nzzxHOwv9g75/mJ+
	9P95VAhkTHuqNyr9VE7bD3UliXWJ4MdL8SAAfB3XVXwCmnAH0G/2Xv5qf37DG85K
	VlI3fMUgI7tCekioDjYjhEBWWzKg2pXqDAHLMIPsIB5iuudPus8L3IY+DidSG3iY
	7jUfN4ZpFg2JSrS0rXOKenKqzby8ZE2xQunBQrqzqv6oIYi43VKR+Vld6Zh280MB
	Whwsr6hH7KbW3Bf8GOBJ/Y6PgbFxVT0lQhPEVVd9bL4Q+jxNDUEgXKj7hYew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764701447; x=1764787847; bh=2nvVFOQOvHv3zqCUDUczstlc3i5mYiXrQ0I
	DkpOwzts=; b=LYv8A77J3Fsd4LV/5lQIOn2cJgHBBWrW2IkDjkdkkzTjDWENNVu
	3WVczjWyi5hn0/fZC9sy3i1yYsBuc/5dxhkYdeW8VbE5zbSBmexB5z4IuNmOTE7/
	ZkCsigoV+WEDXNYcdk1Mj/m8J9dKy+3a/tNnFdgty7R8Qvx+Z92STcNxy3zBRiSi
	f334QFT3BUM3wiuaM61NFok44Fwo8vZAVcJh0YX+Nzre2y7Yvp5ceuQc+cRjpbS/
	bqs+efyFpNfUqRLTnddXJurSOrFf1TmrlwooKrrVM1Mlrzo5HXD1cOWNmsQi1PZI
	uK5sFg0ug/ttg+S34a9GburQBhMJSbg/yhw==
X-ME-Sender: <xms:BzUvabmxSwsmUWxma3nchpMjuNcmNnQ6kDDZwQaK0BH6Aj_XZC56gA>
    <xme:BzUvaR7j50U-t1c20zTA2GCmGYc523Q0q58zTzCP2Clxal9k4XzmpR0NOhULPYLyu
    bt7Nkrd9vwbgFJxW0J7KhCDxhQsRMa8tY2YQ6DLoub_T5xDdR4UwxM>
X-ME-Received: <xmr:BzUvacR_jtk5JcvhugD71VLtH3MS9luWaiFU2LwIWwxzD3DQ-1jqFbFjYjt1imYlwgkvk-EyGq7rWp1bQzfy1HXeQI699esv245yENTMLgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevke
    ekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepsh
    horhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilh
    grsehfrhgvvgdrfhhrpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:BzUvafz1KEKzIVkcTme9IEsku7hIRnBJjekQvXkb4KteRk2oRxq6pw>
    <xmx:BzUvaUqNgdjKBzlbw_-SL-1YTGBs363ffE_8a8tC5M2el9ZDfCPv5g>
    <xmx:BzUvaS21w8I7-zTVRyLvHOnotmHVaPGewT5Rp7cjsRwFbh1H5fkxWg>
    <xmx:BzUvaUxUEVdL-f0BquDy5Mo9QhQzUpJsEFV1-Y5pvLyZOeRovInsMw>
    <xmx:BzUvaZlJX0qNFfIT-6opsTGmEKJI_ASyHWVDFOi19jHyvKfUc2FLj3tD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 13:50:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b423eb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 18:50:45 +0000 (UTC)
Date: Tue, 2 Dec 2025 19:50:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 05/11] builtin/history: implement "reword" subcommand
Message-ID: <aS80_rTVHP44JKhx@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-5-407dd3f57ad3@pks.im>
 <b36a644e-2d8d-41cf-b59b-e72ce0ca855c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b36a644e-2d8d-41cf-b59b-e72ce0ca855c@gmail.com>

On Mon, Nov 17, 2025 at 04:27:59PM +0000, Phillip Wood wrote:
> Hi Patrick
> On 27/10/2025 11:33, Patrick Steinhardt wrote:
> 
> > +static int collect_commits(struct repository *repo,
> > +			   struct commit *old_commit,
> > +			   struct commit *new_commit,
> > +			   struct strvec *out)
> 
> Now that we're not using the sequencer it would be nice to stop messing
> about converting object ids to and from strings and return an array of
> "struct commit" instead of "struct strvec"

I was trying to avoid using a strvec, but honestly that turned out to be
more pain than it is worth. We don't have functions like
`strvec_splice()` for simple arrays, and there is no commit array struct
that provides similar wrappers, either.

>  > +{
> > +	struct setup_revision_opt revision_opts = {
> > +		.assume_dashdash = 1,
> > +	};
> > +	struct strvec revisions = STRVEC_INIT;
> > +	struct commit *child;
> > +	struct rev_info rev = { 0 };
> > +	int ret;
> > +
> > +	repo_init_revisions(repo, &rev, NULL);
> > +	strvec_push(&revisions, "");
> > +	strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
> > +	if (old_commit)
> > +		strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
> > +
> > +	setup_revisions_from_strvec(&revisions, &rev, &revision_opts);
> > +	if (revisions.nr != 1 || prepare_revision_walk(&rev)) {
> 
> I'm not that familiar with the revision walking api, what 'revisions.nr !=
> 1' check for here?

It's basically a check that the revision arguments have all been
consumed, except for the initial empty argument. The interface is a bit
weird.

[snip]
> > +		if (!onto) {
> > +			onto = commit;
> > +		} else {
> > +			struct tree *tree = repo_get_commit_tree(repo, commit);
> > +			onto = replay_create_commit(repo, tree, commit, onto);
> > +			if (!onto)
> > +				break;
> 
> Don't we want to avoid updating HEAD if replay_create_commit() fails?

Good point, yes.

> > +		}
> > +	}
> > +
> > +	reset_opts.oid = &onto->object.oid;
> > +	strbuf_addf(&buf, "%s: switch to rewritten %s", action, oid_to_hex(reset_opts.oid));
> 
> We're not switching branches so I wonder if saying "history: <action> <oid>
> <commit subject>" might be a more useful reflog entry

We're not switching branches, true, but we do switch to the rewritten
commit. Also I'm not sure that printing the commit subject here would
make sense, as the question becomes which subject to print: the one
we're moving to, which is the new tip of the branch but may not be the
commit we have rewritten? Or do we print the subject of the rewritten
commit?

> > +static int fill_commit_message(struct repository *repo,
> > +			       const struct object_id *old_tree,
> > +			       const struct object_id *new_tree,
> > +			       const char *default_message,
> > +			       const char *action,
> > +			       struct strbuf *out)
> > +{
> > +	const char *path = git_path_commit_editmsg();
> > +	const char *hint =
> > +		_("Please enter the commit message for the %s changes."
> 
> Maybe "Please edit the commit message"? Also do we want to tell the user
> they can abort by clearing the commit message?

The "Please edit the commit message" thing is taken from other commands
that phrase it similarly. But it certainly does make sense to note that
clearing the commit message aborts, will add.

> > +		  " Lines starting\nwith '%s' will be ignored.\n");
> > +	struct wt_status s;
> > +
> > +	strbuf_addstr(out, default_message);
> > +	strbuf_addch(out, '\n');
> > +	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
> > +	write_file_buf(path, out->buf, out->len);
> > +
> > +	wt_status_prepare(repo, &s);
> > +	FREE_AND_NULL(s.branch);
> > +	s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
> > +	s.commit_template = 1;
> > +	s.colopts = 0;
> > +	s.display_comment_prefix = 1;
> > +	s.hints = 0;
> > +	s.use_color = 0;
> > +	s.whence = FROM_COMMIT;
> > +	s.committable = 1;
> 
> "git commit" reads a load of status related config settings, is any of that
> relevant here?

Yeah, some of it is. We don't handle them all yet, but this will be
backfilled in the future.

> > +	s.fp = fopen(git_path_commit_editmsg(), "a");
> > +	if (!s.fp)
> > +		return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
> > +
> > +	wt_status_collect_changes_trees(&s, old_tree, new_tree);
> > +	wt_status_print(&s);
> > +	wt_status_collect_free_buffers(&s);
> > +	string_list_clear_func(&s.change, change_data_free);
> > +
> > +	strbuf_reset(out);
> > +	if (launch_editor(path, out, NULL)) {
> > +		fprintf(stderr, _("Please supply the message using the -m option.\n"));
> 
> I'm not sure that's a very helpful suggestion as we don't support "-m" (it's
> not very helpful when "git commit --amend" suggests it either). We should
> just give up if the editor fails.

Ah, this is a leftover error message from previous iterations.

> > +static int cmd_history_reword(int argc,
> > +			      const char **argv,
> > +			      const char *prefix,
> > +			      struct repository *repo)
> > +{
> > +	const char * const usage[] = {
> > +		GIT_HISTORY_REWORD_USAGE,
> > +		NULL,
> > +	};
> > +	struct option options[] = {
> > +		OPT_END(),
> > +	};
> > +	struct strbuf final_message = STRBUF_INIT;
> > +	struct commit *original_commit, *parent, *head;
> > +	struct strvec commits = STRVEC_INIT;
> > +	struct object_id parent_tree_oid, original_commit_tree_oid;
> > +	struct object_id rewritten_commit;
> > +	struct commit_list *from_list = NULL;
> > +	const char *original_message, *original_body, *ptr;
> > +	char *original_author = NULL;
> > +	size_t len;
> > +	int ret;
> > +
> > +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> > +	if (argc != 1) {
> > +		ret = error(_("command expects a single revision"));
> > +		goto out;
> > +	}
> > +	repo_config(repo, git_default_config, NULL);
> > +
> > +	original_commit = lookup_commit_reference_by_name(argv[0]);
> > +	if (!original_commit) {
> > +		ret = error(_("commit to be reworded cannot be found: %s"), argv[0]);
> > +		goto out;
> > +	}
> > +	original_commit_tree_oid = repo_get_commit_tree(repo, original_commit)->object.oid;
> 
> Looking at the implementation of repo_get_commit_tree() it can return NULL

> > diff --git a/t/t3450-history.sh b/t/t3450-history.sh
> > index 417c343d43b..f513463b92b 100755
> > --- a/t/t3450-history.sh
> > +++ b/t/t3450-history.sh
> > @@ -5,13 +5,13 @@ test_description='tests for git-history command'
> >   . ./test-lib.sh
> >   test_expect_success 'does nothing without any arguments' '
> > -	git history >out 2>&1 &&
> > -	test_must_be_empty out
> > +	test_must_fail git history 2>err &&
> > +	test_grep "need a subcommand" err
> >   '
> >   test_expect_success 'raises an error with unknown argument' '
> >   	test_must_fail git history garbage 2>err &&
> > -	test_grep "unrecognized argument: garbage" err
> > +	test_grep "unknown subcommand: .garbage." err
> >   '
> >   test_done
> 
> Do we really need a separate test file just for a couple of tests. I can see
> that having a separate test file for each subcommand makes sense but can't
> we just add these two tests to one of those?

I felt it was dirty to randomly add it to any of the other test suites,
so I decided to instead have it in its own standalone file. It may also
become relevant in the future if we ever needed commands like for
example `git history --continue`, same as the sequencer-based commands
have.

> > diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> > new file mode 100755
> > index 00000000000..09dbc463c59
> > --- /dev/null
> > +++ b/t/t3451-history-reword.sh
> > @@ -0,0 +1,237 @@
> > +#!/bin/sh
> > +
> > +test_description='tests for git-history reword subcommand'
> > +
> > +. ./test-lib.sh
> > +
> > +reword_with_message () {
> > +	cat >message &&
> > +	write_script fake-editor.sh <<-EOF &&
> > +	cp "$(pwd)/message" "\$1"
> 
> Let's hope $(pwd) doesn't contain any dollar signs, backticks, backslashes
> or double quotes. Doing
> 
> 	export MSG_PATH="$(pwd)/message"
> 	write_script fake-editor.sh <<-\EOF &&
> 	cp "$MSG_PATH" "$1"
> 	EOF
> 
> would be safer

True. Will use this:

diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 8b353e74dc..4c87953176 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -6,11 +6,11 @@ test_description='tests for git-history reword subcommand'
 
 reword_with_message () {
 	cat >message &&
-	write_script fake-editor.sh <<-EOF &&
-	cp "$(pwd)/message" "\$1"
+	write_script fake-editor.sh <<-\EOF &&
+	cp "$ORIG_PATH/message" "$1"
 	EOF
 	test_set_editor "$(pwd)"/fake-editor.sh &&
-	git history reword "$@" &&
+	ORIG_PATH="$(pwd)" git history reword "$@" &&
 	rm fake-editor.sh message
 }
 

> > +test_expect_success 'refuses to work with merge commits' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> 
> Do we really need to set up a separate repo for each test? The test suite is
> slow enough already without running "git init" followed by a bunch calls to
> test_commit() in each test. Can we instead run "git reset --hard
> <known-starting-point> at the beginning of each test? That removes any
> interdependence between tests but saves a bunch of processes.

I prefer that style as it is extremely hard to reason about tests that
have interdependencies, and not all the state may be removed by a hard
reset.

> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit first &&
> > +
> > +		write_script fake-editor.sh <<-\EOF &&
> > +		cp "$1" . &&
> > +		printf "\namend a comment\n" >>"$1"
> > +		EOF
> > +		test_set_editor "$(pwd)"/fake-editor.sh &&
> > +		git history reword HEAD &&
> > +
> > +		cat >expect <<-EOF &&
> > +		first
> > +
> > +		# Please enter the commit message for the reworded changes. Lines starting
> > +		# with ${SQ}#${SQ} will be ignored.
> > +		# Changes to be committed:
> > +		#	new file:   first.t
> > +		#
> > +		EOF
> > +		test_cmp expect COMMIT_EDITMSG &&
> > +
> > +		cat >expect <<-EOF &&
> > +		first
> > +
> > +		amend a comment
> > +
> > +		EOF
> > +		git log --format=%B >actual &&
> > +		test_cmp expect actual
> 
> We have test_commit_message() to do this which will accept the expected
> message on stdin.

Ah, indeed.

> > +	)
> > +'
> > +
> > +# For now, git-history(1) does not yet execute any hooks. This is subject to
> > +# change in the future, and if it does this test here is expected to start
> > +# failing. In other words, this test is not an endorsement of the current
> > +# status quo.
> > +test_expect_success 'hooks are not executed for rewritten commits' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit first &&
> > +		test_commit second &&
> > +		test_commit third &&
> > +
> > +		write_script .git/hooks/prepare-commit-msg <<-EOF &&
> > +		touch "$(pwd)/hooks.log
> 
> This has the same problem of expanding $(pwd) as fake-editor.sh. For
> debugging it would be nicer if the hook scripts did
> 
> 	echo "$hook_name" >>hooks.log
> 
> so we can easily see which hooks are causing the test to fail.

I'll rephrain from doing this as it would require `<<-EOF` instead of
`<<-\EOF`.

> > +		EOF
> > +		write_script .git/hooks/post-commit <<-EOF &&
> > +		touch "$(pwd)/hooks.log
> > +		EOF
> > +		write_script .git/hooks/post-rewrite <<-EOF &&
> > +		touch "$(pwd)/hooks.log
> > +		EOF
> 
> This is good idea. We should add tests for the "pre-commit" and "commit-msg"
> hooks as well.
> 
> Overall the test coverage looks good, the only thing we might want to add is
> a check for the reflog message. Thanks for working on this, I'll try and
> look at the rest of the patches sometime this week.

Thanks!

Patrick
