Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F482BF006
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396885; cv=none; b=A/WFfuM5f7ZCkkvMKLIrQOeENQ/o0jDLNX4FCn945cv3/HNzUhypjeWIUR4J7P1U8dvWhy3xUZRwZvi61ZkHV08kYdD3ARg2vCiIZctWYJVcuAhU+h0fS4JkbUdIgnYKvG9HG/I+FP0u/jqm+kHfx0UqscCPr0IsHTrBLvCmbSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396885; c=relaxed/simple;
	bh=kkPETEEBUhTC+jbMw1lZQdSAWMonERcSaZWd0tvO6dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkSo7iC5ZnaobYbJsbErFuLfJjat7NGh4O4ifIPOeoAO2hGZi62Ps0Lg4MiwIguDXxBMit8dGeVgmSoL+Ok2oWhSF0/eX5MzeZZ+ZHIGqeZtgFFWOWP0LgH208P+eVrmsU94RviOfQSvzHMw/sUNas8mUivDWvaPMbV1kWNqIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIfWzVX9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIfWzVX9"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso2358834f8f.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 08:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763396881; x=1764001681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RIDbxOJMQnAtwq58g4AKaw3t0nReb8SoYegq6vyiUB0=;
        b=EIfWzVX9SyKSIo87WaK3MJeaLG0X4d+zyCAvedKO5CK/mnOnJ4gORKt7NUzYQ50WEs
         KIEOAEdj+lgRxPWXw6g7OLWpTUyMe5bX/4BXQZ4fipdbZZ+Omc/pQFbYThEVBcGVqiBW
         9UlIZSv+DUAdlXePyZQa4JVW3kl2QKHAnMxkJk0kKXon4BwBmfGlKbU5/14ocdVz5Sf5
         7unjQNe+nAcK6URgLvBvRv3pyha0XnUiCyq10FBsDZFTjMQ4kviO/dVJDTr0h+L9dVFi
         RC6Ln4AO0J+Im5/rvJBuwA5U0rpVy1MHKDSsVTQO1D989f0RSXfCZKZaIWyHUYwLLJTa
         al9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763396881; x=1764001681;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIDbxOJMQnAtwq58g4AKaw3t0nReb8SoYegq6vyiUB0=;
        b=gB1DUnCZW0/inEUDC5cHP7/t+prhpvK6F3XkSQnESs7fIiQ3GkXoJDez4olTzQdj+i
         b4gX1vzOt6jUgamxw0uhP138nm/W41Lim8yMAl5Q1nsz4GJ7lQUU1sqneJ+Hvtwyame8
         042h3gLMayeRKL3MpSKfZq0FsrpGZVci58TVCnkJKZ6VlDc1sLIkcPAtURVCtuBs2AT/
         wreOAZo6fV1usXtP9yDVsZYDrxE7mCKEhfTIC/kxSHQo6JeT61bFEwf1Se0FUWNfGm4N
         2wrnNUeK6pkVdP0rTnS2m3fDagtvSwvKsLigeqYLN1y/w7/jD8d584iGv4Si6YrrhIIE
         rdkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn5Gn1rv5aDEtNym7bSuxZo5ExzjguB0Kiar38foqeRe4RWY3MlJFj6rdthgwhvUHGLHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNudRxfH+q1Fdbi9opC/+rco2oBV1lL+iR6LDTNsyO0gnnQc7A
	tz2B0bTTAOQ9xo0ORnEbdtplpMSYG49lK3OR4cAGUnpSSFVZqRbIdUn+
X-Gm-Gg: ASbGncs2+IrWcFHFwxbL+c+Z5JgGUI0uLKb5sya5DmSLSpRJ8/DAmHn0cIumTCvlCsG
	bfer5aFBl2xyJMH37QJ7lQU7C078QPqAy6tD/ddisr3biw2Dl6T5SeewyD2dYigLQAxnLVE26XI
	/pU9g3C1a+6mBh/M9nH8pZ+Z70zg7NMmPBwkPkfoKh9AeHfT9DrlpQlZUPYDUHXBUiqhGCZvWeR
	IQjTedsbJOrmR0Lo/JEqBDTmAHNco/SdhS4n9XIbbQlZw1RleruY8TubQOjGh1aAuOM9IBF8YfZ
	79EKuzosetxccHjzbU9HbQb8R5uC3SSZe8q4hqj3+Qrfg5tQ44uuD8hJOD9FGxhZ+HBTBOm/7co
	rxEmBA3DdzvKYRiUtiXVqi3+fppenZTRtE1a/5xe8ZU8iuCEHF7gxHkb0L4b9Gn3IIJHmiSwk9m
	30tBxhTLqnxdJtopgr+Z9ZrGcDGIhwVYnYjt+u8H11YNuJ0+8LqcKBZzNht+3gyptonWeQLJ383
	A==
X-Google-Smtp-Source: AGHT+IEwWPTJXbFwATPObecKsKMDQ2gJgeYq1zEnm9IH+HtcVJ/hBkIrxp8CKFHwuUJ6OI9huVPA4Q==
X-Received: by 2002:a05:6000:26d3:b0:42b:3155:21db with SMTP id ffacd0b85a97d-42b5935e34bmr12644554f8f.2.1763396880994;
        Mon, 17 Nov 2025 08:28:00 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm27619141f8f.26.2025.11.17.08.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 08:28:00 -0800 (PST)
Message-ID: <b36a644e-2d8d-41cf-b59b-e72ce0ca855c@gmail.com>
Date: Mon, 17 Nov 2025 16:27:59 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 05/11] builtin/history: implement "reword" subcommand
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-5-407dd3f57ad3@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20251027-b4-pks-history-builtin-v6-5-407dd3f57ad3@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick
On 27/10/2025 11:33, Patrick Steinhardt wrote:

> +static int collect_commits(struct repository *repo,
> +			   struct commit *old_commit,
> +			   struct commit *new_commit,
> +			   struct strvec *out)

Now that we're not using the sequencer it would be nice to stop messing 
about converting object ids to and from strings and return an array of 
"struct commit" instead of "struct strvec"
  > +{
> +	struct setup_revision_opt revision_opts = {
> +		.assume_dashdash = 1,
> +	};
> +	struct strvec revisions = STRVEC_INIT;
> +	struct commit *child;
> +	struct rev_info rev = { 0 };
> +	int ret;
> +
> +	repo_init_revisions(repo, &rev, NULL);
> +	strvec_push(&revisions, "");
> +	strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
> +	if (old_commit)
> +		strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
> +
> +	setup_revisions_from_strvec(&revisions, &rev, &revision_opts);
> +	if (revisions.nr != 1 || prepare_revision_walk(&rev)) {

I'm not that familiar with the revision walking api, what 'revisions.nr 
!= 1' check for here?

> +static int apply_commits(struct repository *repo,
> +			 const struct strvec *commits,
> +			 struct commit *onto,
> +			 struct commit *orig_head,
> +			 const char *action)
> +{
> +	struct reset_head_opts reset_opts = { 0 };
> +	struct strbuf buf = STRBUF_INIT;
> +	int ret;
> +
> +	for (size_t i = 0; i < commits->nr; i++) {
> +		struct object_id commit_id;
> +		struct commit *commit;
> +		const char *end;
> +
> +		if (parse_oid_hex_algop(commits->v[i], &commit_id, &end,
> +					repo->hash_algo)) {
> +			ret = error(_("invalid object ID: %s"), commits->v[i]);
> +			goto out;
> +		}
> +		commit = lookup_commit(repo, &commit_id);
> +		if (!commit || repo_parse_commit(repo, commit)) {
> +			ret = error(_("failed to look up commit: %s"), oid_to_hex(&commit_id));
> +			goto out;
> +		}


Using an array of "struct commit" rather than "struct strvec" would mean 
we could delete everything in the loop body up to here.

> +		if (!onto) {
> +			onto = commit;
> +		} else {
> +			struct tree *tree = repo_get_commit_tree(repo, commit);
> +			onto = replay_create_commit(repo, tree, commit, onto);
> +			if (!onto)
> +				break;

Don't we want to avoid updating HEAD if replay_create_commit() fails?

> +		}
> +	}
> +
> +	reset_opts.oid = &onto->object.oid;
> +	strbuf_addf(&buf, "%s: switch to rewritten %s", action, oid_to_hex(reset_opts.oid));

We're not switching branches so I wonder if saying "history: <action> 
<oid> <commit subject>" might be a more useful reflog entry

> +static int fill_commit_message(struct repository *repo,
> +			       const struct object_id *old_tree,
> +			       const struct object_id *new_tree,
> +			       const char *default_message,
> +			       const char *action,
> +			       struct strbuf *out)
> +{
> +	const char *path = git_path_commit_editmsg();
> +	const char *hint =
> +		_("Please enter the commit message for the %s changes."

Maybe "Please edit the commit message"? Also do we want to tell the user 
they can abort by clearing the commit message?

> +		  " Lines starting\nwith '%s' will be ignored.\n");
> +	struct wt_status s;
> +
> +	strbuf_addstr(out, default_message);
> +	strbuf_addch(out, '\n');
> +	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
> +	write_file_buf(path, out->buf, out->len);
> +
> +	wt_status_prepare(repo, &s);
> +	FREE_AND_NULL(s.branch);
> +	s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
> +	s.commit_template = 1;
> +	s.colopts = 0;
> +	s.display_comment_prefix = 1;
> +	s.hints = 0;
> +	s.use_color = 0;
> +	s.whence = FROM_COMMIT;
> +	s.committable = 1;

"git commit" reads a load of status related config settings, is any of 
that relevant here?

> +	s.fp = fopen(git_path_commit_editmsg(), "a");
> +	if (!s.fp)
> +		return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
> +
> +	wt_status_collect_changes_trees(&s, old_tree, new_tree);
> +	wt_status_print(&s);
> +	wt_status_collect_free_buffers(&s);
> +	string_list_clear_func(&s.change, change_data_free);
> +
> +	strbuf_reset(out);
> +	if (launch_editor(path, out, NULL)) {
> +		fprintf(stderr, _("Please supply the message using the -m option.\n"));

I'm not sure that's a very helpful suggestion as we don't support "-m" 
(it's not very helpful when "git commit --amend" suggests it either). We 
should just give up if the editor fails.

> +static int cmd_history_reword(int argc,
> +			      const char **argv,
> +			      const char *prefix,
> +			      struct repository *repo)
> +{
> +	const char * const usage[] = {
> +		GIT_HISTORY_REWORD_USAGE,
> +		NULL,
> +	};
> +	struct option options[] = {
> +		OPT_END(),
> +	};
> +	struct strbuf final_message = STRBUF_INIT;
> +	struct commit *original_commit, *parent, *head;
> +	struct strvec commits = STRVEC_INIT;
> +	struct object_id parent_tree_oid, original_commit_tree_oid;
> +	struct object_id rewritten_commit;
> +	struct commit_list *from_list = NULL;
> +	const char *original_message, *original_body, *ptr;
> +	char *original_author = NULL;
> +	size_t len;
> +	int ret;
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +	if (argc != 1) {
> +		ret = error(_("command expects a single revision"));
> +		goto out;
> +	}
> +	repo_config(repo, git_default_config, NULL);
> +
> +	original_commit = lookup_commit_reference_by_name(argv[0]);
> +	if (!original_commit) {
> +		ret = error(_("commit to be reworded cannot be found: %s"), argv[0]);
> +		goto out;
> +	}
> +	original_commit_tree_oid = repo_get_commit_tree(repo, original_commit)->object.oid;

Looking at the implementation of repo_get_commit_tree() it can return NULL

> +
> +	parent = original_commit->parents ? original_commit->parents->item : NULL;
> +	if (parent) {
> +		if (repo_parse_commit(repo, parent)) {
> +			ret = error(_("unable to parse commit %s"),
> +				    oid_to_hex(&parent->object.oid));
> +			goto out;
> +		}
> +		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
> +	} else {
> +		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
> +	}
> +
> +	head = lookup_commit_reference_by_name("HEAD");
> +	if (!head) {
> +		ret = error(_("could not resolve HEAD to a commit"));
> +		goto out;
> +	}
> +
> +	commit_list_append(original_commit, &from_list);
> +	if (!repo_is_descendant_of(repo, head, from_list)) {
> +		ret = error (_("split commit must be reachable from current HEAD commit"));

s/split/reword/

> +		goto out;
> +	}
> +
> +	/*
> +	 * Collect the list of commits that we'll have to reapply now already.
> +	 * This ensures that we'll abort early on in case the range of commits
> +	 * contains merges, which we do not yet handle.
> +	 */

Ah, I wondered if we should be checking that the reworded commit wasn't 
a merge when we look at the parents above but we don't need to because 
we will error out here if it is.

> diff --git a/t/t3450-history.sh b/t/t3450-history.sh
> index 417c343d43b..f513463b92b 100755
> --- a/t/t3450-history.sh
> +++ b/t/t3450-history.sh
> @@ -5,13 +5,13 @@ test_description='tests for git-history command'
>   . ./test-lib.sh
>   
>   test_expect_success 'does nothing without any arguments' '
> -	git history >out 2>&1 &&
> -	test_must_be_empty out
> +	test_must_fail git history 2>err &&
> +	test_grep "need a subcommand" err
>   '
>   
>   test_expect_success 'raises an error with unknown argument' '
>   	test_must_fail git history garbage 2>err &&
> -	test_grep "unrecognized argument: garbage" err
> +	test_grep "unknown subcommand: .garbage." err
>   '
>   
>   test_done

Do we really need a separate test file just for a couple of tests. I can 
see that having a separate test file for each subcommand makes sense but 
can't we just add these two tests to one of those?

> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> new file mode 100755
> index 00000000000..09dbc463c59
> --- /dev/null
> +++ b/t/t3451-history-reword.sh
> @@ -0,0 +1,237 @@
> +#!/bin/sh
> +
> +test_description='tests for git-history reword subcommand'
> +
> +. ./test-lib.sh
> +
> +reword_with_message () {
> +	cat >message &&
> +	write_script fake-editor.sh <<-EOF &&
> +	cp "$(pwd)/message" "\$1"

Let's hope $(pwd) doesn't contain any dollar signs, backticks, 
backslashes or double quotes. Doing

	export MSG_PATH="$(pwd)/message"
	write_script fake-editor.sh <<-\EOF &&
	cp "$MSG_PATH" "$1"
	EOF

would be safer

> +test_expect_success 'refuses to work with merge commits' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(

Do we really need to set up a separate repo for each test? The test 
suite is slow enough already without running "git init" followed by a 
bunch calls to test_commit() in each test. Can we instead run "git reset 
--hard <known-starting-point> at the beginning of each test? That 
removes any interdependence between tests but saves a bunch of processes.
> +test_expect_success 'can reword root commit' '

It's nice that unlike "git rebase" this works without much effort from 
the implementation.

> +test_expect_success 'can use editor to rewrite commit message' '

Don't all the other tests check that? This test is checking what's 
presented to the user which is a good idea but I wouldn't have guessed 
that from the test name.

> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +
> +		write_script fake-editor.sh <<-\EOF &&
> +		cp "$1" . &&
> +		printf "\namend a comment\n" >>"$1"
> +		EOF
> +		test_set_editor "$(pwd)"/fake-editor.sh &&
> +		git history reword HEAD &&
> +
> +		cat >expect <<-EOF &&
> +		first
> +
> +		# Please enter the commit message for the reworded changes. Lines starting
> +		# with ${SQ}#${SQ} will be ignored.
> +		# Changes to be committed:
> +		#	new file:   first.t
> +		#
> +		EOF
> +		test_cmp expect COMMIT_EDITMSG &&
> +
> +		cat >expect <<-EOF &&
> +		first
> +
> +		amend a comment
> +
> +		EOF
> +		git log --format=%B >actual &&
> +		test_cmp expect actual

We have test_commit_message() to do this which will accept the expected 
message on stdin.

> +	)
> +'
> +
> +# For now, git-history(1) does not yet execute any hooks. This is subject to
> +# change in the future, and if it does this test here is expected to start
> +# failing. In other words, this test is not an endorsement of the current
> +# status quo.
> +test_expect_success 'hooks are not executed for rewritten commits' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +
> +		write_script .git/hooks/prepare-commit-msg <<-EOF &&
> +		touch "$(pwd)/hooks.log

This has the same problem of expanding $(pwd) as fake-editor.sh. For 
debugging it would be nicer if the hook scripts did

	echo "$hook_name" >>hooks.log

so we can easily see which hooks are causing the test to fail.

> +		EOF
> +		write_script .git/hooks/post-commit <<-EOF &&
> +		touch "$(pwd)/hooks.log
> +		EOF
> +		write_script .git/hooks/post-rewrite <<-EOF &&
> +		touch "$(pwd)/hooks.log
> +		EOF

This is good idea. We should add tests for the "pre-commit" and 
"commit-msg" hooks as well.

Overall the test coverage looks good, the only thing we might want to 
add is a check for the reflog message. Thanks for working on this, I'll 
try and look at the rest of the patches sometime this week.

Phillip

