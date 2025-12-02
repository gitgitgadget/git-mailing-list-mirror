Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35623E229
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701478; cv=none; b=qIU7/Td5+1kUYv0CKBDAuXIgVlPRyot4AhuspsTf1XhAudeDywsRW6RXlrIOOy29xYatx+96XIqjBtITirTd7516STdT/DEUOBQpn1ZL2MyDl3A9ggIaz7ueX6lguFxBY7DWidX//qlD4ATVdfcNSG7tV4Ry/MtKqbT91BC2BHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701478; c=relaxed/simple;
	bh=RB3dRmUBMS/+35QPodBWmOou/u/MsHDJxWGgOKcfrgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2TLp83Csn8PZP9YDRq073IRCnIZ0vkjlvXhAS6ZFvsffvX2U69Wy/5egkFj1LpgnjZYD8b4E6sHr2pzt3R+Mkbo4dRKbDJbUdhcTQ+YysUJTmZVqaMXz8eZn3SxbhpCHqeTPBY/0rDraQPattR1eFgobgUFrwFT4n5aJfZHr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jeIsNegG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNde5jzq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jeIsNegG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNde5jzq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A138EEC00D2;
	Tue,  2 Dec 2025 13:51:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 02 Dec 2025 13:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764701475; x=1764787875; bh=WY8SAeh5GA
	nsqvYpDmXcOoPqMRkk8ieEMI9CaLRiHTg=; b=jeIsNegGw4CL5NRReDlAt6eLFM
	j33FxVrMYvse0vplBcRGhyPhdZ5QWi4hDR+OFD46pyi4S0lwfe1I54k483bePNp6
	4Lj1Z/hCDNUa5dQiOXveQnlHERtfwR2uwNW0epSMvsdcLya81wI1VUhJEv8K8tSK
	NFN2BJUIEsRwKN48H3Qgw048l4KYbWdDERc5wqRAeTniBj6s/AzuHqW7X+6ljD//
	mzwAVIneCfs/14jvUi/E97ypqMrlwAclez9dGT5o7UpD34RIRZVzZZl3c31rGg/2
	i/FFgxvzk7j+M2huknWelzvYfMv7Aeg1GW6/DNfQkIX8fs9iuEyWYM2kNP4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764701475; x=1764787875; bh=WY8SAeh5GAnsqvYpDmXcOoPqMRkk8ieEMI9
	CaLRiHTg=; b=lNde5jzqaS3Owy6nRAECPOIB+v4Ntuel6hqRbt4AbpMYbkJx9Qk
	MQnJ2iuuxBbrdLECFMuDaD+ox96XfE8f0WNVAqA3V+FadP/S1TbIduhzaDWxLsUl
	SKEU2GtZn0uwzaXl7us4LiGt5VUDDfqEOGM79SzFDR37f1wkjWWQzqH0k+cYP2yC
	WSXHnlbbvIP5dA4VXSdhHv9XpaY9PQfOEjWCyg7xvCX6jd4v3uB5qA6PTvLDPFMy
	D7itnR414kms2dGMB7Zdf3YuwDTSCk0DlgwwX4MtW48ninbgx+aaoZMG8fx+1FmZ
	5KTpYeJXXYRkoxs465jKbnm2DrTmj3DBpCw==
X-ME-Sender: <xms:IzUvaeFZsOmYu5p92w_c7w_j2Z7CmOPz6im30mUj6MMkgIn1flsPtg>
    <xme:IzUvaSZstxqVyTE2PjLJuRaQQhTjk5ljd5e45D_GeXhZ5RGlINjoWy8RPAO0cpavU
    LyArCkZjEIdH-5C8bPa4FsrB77bm0DJSWdOFz7crHWgevQl3zU7D2c>
X-ME-Received: <xmr:IzUvaSwIaS701w0qEfmixvWHiInT5QCLpQLjY1zwexzBvxXcJRrjGjWGX4RcFbDsKwQDGZqyp6kdpG8b-ctJRPwUdvGE-3qAcjskqhXCLmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevke
    ekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtg
    homhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphht
    thhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:IzUvaUR6oqkwLT2LmKez5m-Kt2bIHRgDfpYjCaFSyRnkoUPxkCgFbw>
    <xmx:IzUvafKPd3bDepv279hCW_YEZ6w7v-bUO-bMynhMGvXpjJNcWNOjVw>
    <xmx:IzUvabXGxS2OhjQtDvRQDwNz6pf-kkViqGAmeC0yfz_jtHtlUswTaA>
    <xmx:IzUvaTT7EtwgrTA71QHsxVEEbPCsAJWW820iCbLjIgInqHdQZoVCPA>
    <xmx:IzUvafMQJeLy7guqjoAZC0NprwacU_r09emmmULgVTncDEsFJXZatGbv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 13:51:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b79ba1b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 18:51:12 +0000 (UTC)
Date: Tue, 2 Dec 2025 19:51:04 +0100
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
Subject: Re: [PATCH v6 11/11] builtin/history: implement "split" subcommand
Message-ID: <aS81GAuKV79x_V2K@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-11-407dd3f57ad3@pks.im>
 <a27fce64-0d4c-4280-93e5-00cce812d1b2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a27fce64-0d4c-4280-93e5-00cce812d1b2@gmail.com>

On Fri, Nov 21, 2025 at 02:31:14PM +0000, Phillip Wood wrote:
> Hi Patrick
> 
> On 27/10/2025 11:33, Patrick Steinhardt wrote:
> > It is quite a common use case that one wants to split up one commit into
> > multiple commits by moving parts of the changes of the original commit
> > out into a separate commit. This is quite an involved operation though:
> > 
> >    1. Identify the commit in question that is to be dropped.
> > 
> >    2. Perform an interactive rebase on top of that commit's parent.
> > 
> >    3. Modify the instruction sheet to "edit" the commit that is to be
> >       split up.
> > 
> >    4. Drop the commit via "git reset HEAD~".
> > 
> >    5. Stage changes that should go into the first commit and commit it.
> > 
> >    6. Stage changes that should go into the second commit and commit it.
> > 
> >    7. Finalize the rebase.
> > 
> > This is quite complex, and overall I would claim that most people who
> > are not experts in Git would struggle with this flow.
> 
> If they want to test the split commit it's even more complicated because
> they need to stash the unstaged changes. We should think about how we can
> add support for testing split commits to this command in the future.
> 
> > Introduce a new "split" subcommand for git-history(1) to make this way
> > easier. All the user needs to do is to say `git history split $COMMIT`.
> >  From hereon, Git asks the user which parts of the commit shall be moved
> > out into a separate commit and, once done, asks the user for the commit
> > message. Git then creates that split-out commit and applies the original
> > commit on top of it.
> 
> As others have said (and I thought we'd agreed c.f.
> <aMfdR3JE4zq-2j9b@pks.im>) I think it would be better to prompt the user to
> edit the existing commit message when creating both commits. Elsewhere
> Elijah mention being able to split a commit into more than two commits. I
> wonder if we could loop running run_add_p_index() and committing the result
> until there are no more changes left. It does mean that the user has to
> actively select changes for the final commit though which might be annoying.
> We can always play with that later.

Ah, right. Changing this now to prompt for both commit messages.

> Looking below I do wonder if we can share more code between subcommands when
> it comes to checking the commit we're given on the command line and
> re-creating a commit and having the user edit the message.
> 
> > +static int split_commit(struct repository *repo,
> > +			struct commit *original_commit,
> > +			struct pathspec *pathspec,
> > +			struct object_id *out)
> > {
> > [...]> +	/*
> > +	* Construct the first commit. This is done by taking the original
> > +	* commit parent's tree and selectively patching changes from the diff
> > +	* between that parent and its child.
> > +	*/
> > +	repo_git_path_replace(repo, &index_file, "%s", "history-split.index");
> > +
> > +	read_tree_cmd.git_cmd = 1;
> > +	strvec_pushf(&read_tree_cmd.env, "GIT_INDEX_FILE=%s", index_file.buf);
> > +	strvec_push(&read_tree_cmd.args, "read-tree");
> > +	strvec_push(&read_tree_cmd.args, oid_to_hex(&parent_tree_oid));
> > +	ret = run_command(&read_tree_cmd);
> 
> Why do we need to fork "read-tree" here rather than call unpack_trees()
> ourselves?

This is an artifact of how the `run_add_p()` interfaces work. They
unfortunately do not work on top of an in-memory index, but they work on
an on-disk index.

> > [...]
> > +	/* We retain authorship of the original commit. */
> > +	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
> > +	ptr = find_commit_header(original_message, "author", &len);
> > +	if (ptr)
> > +		original_author = xmemdupz(ptr, len);
> > +
> > +	ret = fill_commit_message(repo, &parent_tree_oid, &split_tree->object.oid,
> > +				  "", "split-out", &split_message);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = commit_tree(split_message.buf, split_message.len, &split_tree->object.oid,
> > +			  original_commit->parents, &out[0], original_author, NULL);
> > +	if (ret < 0) {
> > +		ret = error(_("failed writing split-out commit"));
> > +		goto out;
> > +	}
> 
> Don't we have the same code for rewording a commit, maybe we should package
> this up into a shared helper function.

Hm, indeed, there's a bit of non-trivial logic here. I'll refactor this.

> > +static int cmd_history_split(int argc,
> > +			     const char **argv,
> > +			     const char *prefix,
> > +			     struct repository *repo)
> > +{
> > +	const char * const usage[] = {
> > +		GIT_HISTORY_SPLIT_USAGE,
> > +		NULL,
> > +	};
> > +	struct option options[] = {
> > +		OPT_END(),
> > +	};
> > +	struct oidmap rewritten_commits = OIDMAP_INIT;
> > +	struct commit *original_commit, *parent, *head;
> > +	struct strvec commits = STRVEC_INIT;
> > +	struct commit_list *from_list = NULL;
> > +	struct object_id split_commits[2];
> > +	struct pathspec pathspec = { 0 };
> > +	int ret;
> > +
> > +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> > +	if (argc < 1) {
> > +		ret = error(_("command expects a revision"));
> > +		goto out;
> > +	}
> > +	repo_config(repo, git_default_config, NULL);
> > +
> > +	original_commit = lookup_commit_reference_by_name(argv[0]);
> > +	if (!original_commit) {
> > +		ret = error(_("commit to be split cannot be found: %s"), argv[0]);
> > +		goto out;
> > +	}
> > +
> > +	parent = original_commit->parents ? original_commit->parents->item : NULL;
> > +	if (parent && repo_parse_commit(repo, parent)) {
> > +		ret = error(_("unable to parse commit %s"),
> > +			    oid_to_hex(&parent->object.oid));
> > +		goto out;
> > +	}
> > +
> > +	head = lookup_commit_reference_by_name("HEAD");
> > +	if (!head) {
> > +		ret = error(_("could not resolve HEAD to a commit"));
> > +		goto out;
> > +	}
> > +
> > +	commit_list_append(original_commit, &from_list);
> > +	if (!repo_is_descendant_of(repo, head, from_list)) {
> > +		ret = error(_("split commit must be reachable from current HEAD commit"));
> > +		goto out;
> > +	}
> 
> This is very similar to cmd_history_reword() up to this point. When we add
> the "drop" and "amend" subcommands they're going to want to do the same
> checks.
> 
> > +	parse_pathspec(&pathspec, 0,
> > +		PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PATHSPEC_PREFIX_ORIGIN,
> > +		prefix, argv + 1);
> 
> This and calling split_commit() below are the only real differences with
> cmd_history_reword(), is it worth trying to share some more code between the
> two?

Yup, done.

Thanks!

Patrick
