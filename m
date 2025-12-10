Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200623B62C
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360381; cv=none; b=geY/80y8lh167gnYKv+d2A1dWA1wl5i7u0x2its/bVQIJ1FkIslm1OG5MSVfxpnTskp8q00et7qLMeuOY/UkAdRL+xnWsi80oCEHV0xkMxruajqwOCshhzWoT8GNA3ilLk+Rb3mprvFYk2OLkH+F7jLkFKXXQCYP1sQo1qaVDZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360381; c=relaxed/simple;
	bh=aoRPV2E4aH4+gyd4rXzsT2F3RbjHC7plwfGgwwagFH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0qI/FwgZvdjK415HDHHCyj6C+hZy75Hr7Y2dEK678H+xuSQ86AYk/GLfPcN301DzN79wDiGMjZ3cvUzHmo02tLMpnuMrbj+sS8GcmZLkmkbYSFKOJCPRG7KkaGRjzQzMaiZLcIFIugmcQiqULR7cLU4fLQvwACJzeMMDUDlYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDJhheIV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDJhheIV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so62107205e9.2
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 01:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765360378; x=1765965178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F46AKJHQ/P/i7zMocUm0iYbyn65ORCNcs1zwy4kVC7M=;
        b=gDJhheIVbM5Y0aqIvgqtoaOr+cGHuRUWcI+tzClEMiB37mVax/ZoSiJBqkdzllGSV1
         dRsDeVNy3ZgpJwc5k0vqyy++opYbfw5wgktTPd4L4GUWH11EeJx66bRh9+FM4e3OBhRZ
         xj5NgTyc/gr97tAAxpA5PON6CkGev14VTJ1M0Qa4WTpVeFQFSvmX2a5vWkshf5zvRXH0
         tKamOUBEjmXnE2XxikbDGSThHv8q+pbvJoqYTnsy88rz0k+cPKYPR0lblK6+zEyGoCyK
         I/X1aaIz2gUZ6zrI+UEu2zyeQXM5d1pPfYUzIR0VOOwkymzrQBIyk1HoJ9DtmgeLKPfZ
         JATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765360378; x=1765965178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F46AKJHQ/P/i7zMocUm0iYbyn65ORCNcs1zwy4kVC7M=;
        b=EuXHiMpghNKBA+i1/edNKMEF2TCyZeY4BRqUmXVMxbE8DT/0/7qD5URU1sZM3277Y+
         vLcg1AHHE19yDUokCcEStALG4CR38W4a6a3IykeJ/3URoxvINmat4s9yjiA0v6CBEpmq
         AClHqoAEXJggCMhzV1IYRSwcVmoRVLt4CFiPnT9gDIfun28g7rRLkCngx+HSSVcC+OaV
         kwbYSf2OCB7vPU1vwNwj7zmIqU32hlAf40qtbavUY6XOHxDrrwjqM42TQvjo1vUbnc0A
         GecUlnMi/aaO0CsW51djRYjYXmOHyXkTCx7AX5hl5BZtobgeiOHU7t+0CvT7rBukg7/5
         w0hQ==
X-Gm-Message-State: AOJu0YxjGKKUmzFkE1Wc3D/30TsrB/JPgMm04XrAcUS7qcAVyAh/PdZS
	z5mDT7HdKkHU/oYns89557pNT2bPxr/R+rnlaz4RrJ5wLrJjlE406Kiq
X-Gm-Gg: ASbGncvY+LiD64j4cIwMuRMQLCU82xYifhnE2Mv1dKoUiFUHpgp3V8DsrC/iPBCBcCZ
	4pbPGjOhzdyPJqXFGv+2oRuwUj/Hz82CsrrbgL+BCzXYoVelGccfoRwiZU5LtJbIwM7sLHSUnyC
	jdl8GAVSx7BKH47UTjLYkyfpwojJ3Eli/NLcFewrn+jG9WVooUdyDgS76WkvH1QVKgIl5ur1kpn
	m2bdmz6joDDO0e2IbEkr4j6OtO+yT8V0c88WZi0+tsa/o/zBPrljGcovaZtxfyVI5IjzRtNG4Tp
	CBMGTMH5aB0KKde5bJISuZWxOu4LnBNEwBo6FdiWx1juby5bcXLY58f1a3vEnUw2ZMxBhednPaX
	1dKl0yMf0CfYtaQuH9AvsdSO5cAg2Ddxo3e86tUpYtX2znU9CZEf0y7Z4weqMe0OvoMFFnOnMCU
	fB4W/BpiWpHRu9NJCXrvHnlQ3S+hSSOl5cW80rGygEklZ5+ijL1eJ067ZuwW+737A=
X-Google-Smtp-Source: AGHT+IGnwmyLbOD/wqmWgDIpOHWIS1pb2I+Aj5y5RMvyUy2/wuQK+4zUtvJtq0PrsvO0SmJ5YCQjWA==
X-Received: by 2002:a05:600c:6209:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-47a83607241mr18410615e9.0.1765360378000;
        Wed, 10 Dec 2025 01:52:58 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82d218b4sm37538765e9.6.2025.12.10.01.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 01:52:57 -0800 (PST)
Message-ID: <266a9cfc-142f-49c0-a2a0-1d67426479b9@gmail.com>
Date: Wed, 10 Dec 2025 09:52:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 05/11] builtin/history: implement "reword" subcommand
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-5-407dd3f57ad3@pks.im>
 <b36a644e-2d8d-41cf-b59b-e72ce0ca855c@gmail.com> <aS80_rTVHP44JKhx@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aS80_rTVHP44JKhx@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2025 18:50, Patrick Steinhardt wrote:
> On Mon, Nov 17, 2025 at 04:27:59PM +0000, Phillip Wood wrote:
>> Hi Patrick
>> On 27/10/2025 11:33, Patrick Steinhardt wrote:
>>
>>> +static int collect_commits(struct repository *repo,
>>> +			   struct commit *old_commit,
>>> +			   struct commit *new_commit,
>>> +			   struct strvec *out)
>>
>> Now that we're not using the sequencer it would be nice to stop messing
>> about converting object ids to and from strings and return an array of
>> "struct commit" instead of "struct strvec"
> 
> I was trying to avoid using a strvec, but honestly that turned out to be
> more pain than it is worth. We don't have functions like
> `strvec_splice()` for simple arrays, and there is no commit array struct
> that provides similar wrappers, either.

I'm surprised it was such a pain compared to the cost to using a strvec. 
We're forever converting from a string to a struct commit and back again 
which bloats the code and obscures the interesting and important parts. 
That cost will be paid each time we add a new subcommand. An 
implementation of 'struct commit_vec' that implements commit_vec_push(), 
commit_vec_splice() and commit_vec_clear() is only going to be 30 or 40 
lines of code and gives us a solid foundation for this series. Open 
coding the array and adding a SPLICE_ARRAY macro would also be pretty 
simple.

Thanks

Phillip

>>   > +{
>>> +	struct setup_revision_opt revision_opts = {
>>> +		.assume_dashdash = 1,
>>> +	};
>>> +	struct strvec revisions = STRVEC_INIT;
>>> +	struct commit *child;
>>> +	struct rev_info rev = { 0 };
>>> +	int ret;
>>> +
>>> +	repo_init_revisions(repo, &rev, NULL);
>>> +	strvec_push(&revisions, "");
>>> +	strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
>>> +	if (old_commit)
>>> +		strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
>>> +
>>> +	setup_revisions_from_strvec(&revisions, &rev, &revision_opts);
>>> +	if (revisions.nr != 1 || prepare_revision_walk(&rev)) {
>>
>> I'm not that familiar with the revision walking api, what 'revisions.nr !=
>> 1' check for here?
> 
> It's basically a check that the revision arguments have all been
> consumed, except for the initial empty argument. The interface is a bit
> weird.
> 
> [snip]
>>> +		if (!onto) {
>>> +			onto = commit;
>>> +		} else {
>>> +			struct tree *tree = repo_get_commit_tree(repo, commit);
>>> +			onto = replay_create_commit(repo, tree, commit, onto);
>>> +			if (!onto)
>>> +				break;
>>
>> Don't we want to avoid updating HEAD if replay_create_commit() fails?
> 
> Good point, yes.
> 
>>> +		}
>>> +	}
>>> +
>>> +	reset_opts.oid = &onto->object.oid;
>>> +	strbuf_addf(&buf, "%s: switch to rewritten %s", action, oid_to_hex(reset_opts.oid));
>>
>> We're not switching branches so I wonder if saying "history: <action> <oid>
>> <commit subject>" might be a more useful reflog entry
> 
> We're not switching branches, true, but we do switch to the rewritten
> commit. Also I'm not sure that printing the commit subject here would
> make sense, as the question becomes which subject to print: the one
> we're moving to, which is the new tip of the branch but may not be the
> commit we have rewritten? Or do we print the subject of the rewritten
> commit?
> 
>>> +static int fill_commit_message(struct repository *repo,
>>> +			       const struct object_id *old_tree,
>>> +			       const struct object_id *new_tree,
>>> +			       const char *default_message,
>>> +			       const char *action,
>>> +			       struct strbuf *out)
>>> +{
>>> +	const char *path = git_path_commit_editmsg();
>>> +	const char *hint =
>>> +		_("Please enter the commit message for the %s changes."
>>
>> Maybe "Please edit the commit message"? Also do we want to tell the user
>> they can abort by clearing the commit message?
> 
> The "Please edit the commit message" thing is taken from other commands
> that phrase it similarly. But it certainly does make sense to note that
> clearing the commit message aborts, will add.
> 
>>> +		  " Lines starting\nwith '%s' will be ignored.\n");
>>> +	struct wt_status s;
>>> +
>>> +	strbuf_addstr(out, default_message);
>>> +	strbuf_addch(out, '\n');
>>> +	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
>>> +	write_file_buf(path, out->buf, out->len);
>>> +
>>> +	wt_status_prepare(repo, &s);
>>> +	FREE_AND_NULL(s.branch);
>>> +	s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
>>> +	s.commit_template = 1;
>>> +	s.colopts = 0;
>>> +	s.display_comment_prefix = 1;
>>> +	s.hints = 0;
>>> +	s.use_color = 0;
>>> +	s.whence = FROM_COMMIT;
>>> +	s.committable = 1;
>>
>> "git commit" reads a load of status related config settings, is any of that
>> relevant here?
> 
> Yeah, some of it is. We don't handle them all yet, but this will be
> backfilled in the future.
> 
>>> +	s.fp = fopen(git_path_commit_editmsg(), "a");
>>> +	if (!s.fp)
>>> +		return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
>>> +
>>> +	wt_status_collect_changes_trees(&s, old_tree, new_tree);
>>> +	wt_status_print(&s);
>>> +	wt_status_collect_free_buffers(&s);
>>> +	string_list_clear_func(&s.change, change_data_free);
>>> +
>>> +	strbuf_reset(out);
>>> +	if (launch_editor(path, out, NULL)) {
>>> +		fprintf(stderr, _("Please supply the message using the -m option.\n"));
>>
>> I'm not sure that's a very helpful suggestion as we don't support "-m" (it's
>> not very helpful when "git commit --amend" suggests it either). We should
>> just give up if the editor fails.
> 
> Ah, this is a leftover error message from previous iterations.
> 
>>> +static int cmd_history_reword(int argc,
>>> +			      const char **argv,
>>> +			      const char *prefix,
>>> +			      struct repository *repo)
>>> +{
>>> +	const char * const usage[] = {
>>> +		GIT_HISTORY_REWORD_USAGE,
>>> +		NULL,
>>> +	};
>>> +	struct option options[] = {
>>> +		OPT_END(),
>>> +	};
>>> +	struct strbuf final_message = STRBUF_INIT;
>>> +	struct commit *original_commit, *parent, *head;
>>> +	struct strvec commits = STRVEC_INIT;
>>> +	struct object_id parent_tree_oid, original_commit_tree_oid;
>>> +	struct object_id rewritten_commit;
>>> +	struct commit_list *from_list = NULL;
>>> +	const char *original_message, *original_body, *ptr;
>>> +	char *original_author = NULL;
>>> +	size_t len;
>>> +	int ret;
>>> +
>>> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
>>> +	if (argc != 1) {
>>> +		ret = error(_("command expects a single revision"));
>>> +		goto out;
>>> +	}
>>> +	repo_config(repo, git_default_config, NULL);
>>> +
>>> +	original_commit = lookup_commit_reference_by_name(argv[0]);
>>> +	if (!original_commit) {
>>> +		ret = error(_("commit to be reworded cannot be found: %s"), argv[0]);
>>> +		goto out;
>>> +	}
>>> +	original_commit_tree_oid = repo_get_commit_tree(repo, original_commit)->object.oid;
>>
>> Looking at the implementation of repo_get_commit_tree() it can return NULL
> 
>>> diff --git a/t/t3450-history.sh b/t/t3450-history.sh
>>> index 417c343d43b..f513463b92b 100755
>>> --- a/t/t3450-history.sh
>>> +++ b/t/t3450-history.sh
>>> @@ -5,13 +5,13 @@ test_description='tests for git-history command'
>>>    . ./test-lib.sh
>>>    test_expect_success 'does nothing without any arguments' '
>>> -	git history >out 2>&1 &&
>>> -	test_must_be_empty out
>>> +	test_must_fail git history 2>err &&
>>> +	test_grep "need a subcommand" err
>>>    '
>>>    test_expect_success 'raises an error with unknown argument' '
>>>    	test_must_fail git history garbage 2>err &&
>>> -	test_grep "unrecognized argument: garbage" err
>>> +	test_grep "unknown subcommand: .garbage." err
>>>    '
>>>    test_done
>>
>> Do we really need a separate test file just for a couple of tests. I can see
>> that having a separate test file for each subcommand makes sense but can't
>> we just add these two tests to one of those?
> 
> I felt it was dirty to randomly add it to any of the other test suites,
> so I decided to instead have it in its own standalone file. It may also
> become relevant in the future if we ever needed commands like for
> example `git history --continue`, same as the sequencer-based commands
> have.
> 
>>> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
>>> new file mode 100755
>>> index 00000000000..09dbc463c59
>>> --- /dev/null
>>> +++ b/t/t3451-history-reword.sh
>>> @@ -0,0 +1,237 @@
>>> +#!/bin/sh
>>> +
>>> +test_description='tests for git-history reword subcommand'
>>> +
>>> +. ./test-lib.sh
>>> +
>>> +reword_with_message () {
>>> +	cat >message &&
>>> +	write_script fake-editor.sh <<-EOF &&
>>> +	cp "$(pwd)/message" "\$1"
>>
>> Let's hope $(pwd) doesn't contain any dollar signs, backticks, backslashes
>> or double quotes. Doing
>>
>> 	export MSG_PATH="$(pwd)/message"
>> 	write_script fake-editor.sh <<-\EOF &&
>> 	cp "$MSG_PATH" "$1"
>> 	EOF
>>
>> would be safer
> 
> True. Will use this:
> 
> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> index 8b353e74dc..4c87953176 100755
> --- a/t/t3451-history-reword.sh
> +++ b/t/t3451-history-reword.sh
> @@ -6,11 +6,11 @@ test_description='tests for git-history reword subcommand'
>   
>   reword_with_message () {
>   	cat >message &&
> -	write_script fake-editor.sh <<-EOF &&
> -	cp "$(pwd)/message" "\$1"
> +	write_script fake-editor.sh <<-\EOF &&
> +	cp "$ORIG_PATH/message" "$1"
>   	EOF
>   	test_set_editor "$(pwd)"/fake-editor.sh &&
> -	git history reword "$@" &&
> +	ORIG_PATH="$(pwd)" git history reword "$@" &&
>   	rm fake-editor.sh message
>   }
>   
> 
>>> +test_expect_success 'refuses to work with merge commits' '
>>> +	test_when_finished "rm -rf repo" &&
>>> +	git init repo &&
>>> +	(
>>
>> Do we really need to set up a separate repo for each test? The test suite is
>> slow enough already without running "git init" followed by a bunch calls to
>> test_commit() in each test. Can we instead run "git reset --hard
>> <known-starting-point> at the beginning of each test? That removes any
>> interdependence between tests but saves a bunch of processes.
> 
> I prefer that style as it is extremely hard to reason about tests that
> have interdependencies, and not all the state may be removed by a hard
> reset.
> 
>>> +	test_when_finished "rm -rf repo" &&
>>> +	git init repo &&
>>> +	(
>>> +		cd repo &&
>>> +		test_commit first &&
>>> +
>>> +		write_script fake-editor.sh <<-\EOF &&
>>> +		cp "$1" . &&
>>> +		printf "\namend a comment\n" >>"$1"
>>> +		EOF
>>> +		test_set_editor "$(pwd)"/fake-editor.sh &&
>>> +		git history reword HEAD &&
>>> +
>>> +		cat >expect <<-EOF &&
>>> +		first
>>> +
>>> +		# Please enter the commit message for the reworded changes. Lines starting
>>> +		# with ${SQ}#${SQ} will be ignored.
>>> +		# Changes to be committed:
>>> +		#	new file:   first.t
>>> +		#
>>> +		EOF
>>> +		test_cmp expect COMMIT_EDITMSG &&
>>> +
>>> +		cat >expect <<-EOF &&
>>> +		first
>>> +
>>> +		amend a comment
>>> +
>>> +		EOF
>>> +		git log --format=%B >actual &&
>>> +		test_cmp expect actual
>>
>> We have test_commit_message() to do this which will accept the expected
>> message on stdin.
> 
> Ah, indeed.
> 
>>> +	)
>>> +'
>>> +
>>> +# For now, git-history(1) does not yet execute any hooks. This is subject to
>>> +# change in the future, and if it does this test here is expected to start
>>> +# failing. In other words, this test is not an endorsement of the current
>>> +# status quo.
>>> +test_expect_success 'hooks are not executed for rewritten commits' '
>>> +	test_when_finished "rm -rf repo" &&
>>> +	git init repo &&
>>> +	(
>>> +		cd repo &&
>>> +		test_commit first &&
>>> +		test_commit second &&
>>> +		test_commit third &&
>>> +
>>> +		write_script .git/hooks/prepare-commit-msg <<-EOF &&
>>> +		touch "$(pwd)/hooks.log
>>
>> This has the same problem of expanding $(pwd) as fake-editor.sh. For
>> debugging it would be nicer if the hook scripts did
>>
>> 	echo "$hook_name" >>hooks.log
>>
>> so we can easily see which hooks are causing the test to fail.
> 
> I'll rephrain from doing this as it would require `<<-EOF` instead of
> `<<-\EOF`.
> 
>>> +		EOF
>>> +		write_script .git/hooks/post-commit <<-EOF &&
>>> +		touch "$(pwd)/hooks.log
>>> +		EOF
>>> +		write_script .git/hooks/post-rewrite <<-EOF &&
>>> +		touch "$(pwd)/hooks.log
>>> +		EOF
>>
>> This is good idea. We should add tests for the "pre-commit" and "commit-msg"
>> hooks as well.
>>
>> Overall the test coverage looks good, the only thing we might want to add is
>> a check for the reflog message. Thanks for working on this, I'll try and
>> look at the rest of the patches sometime this week.
> 
> Thanks!
> 
> Patrick
> 

