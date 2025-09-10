Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05F322A13
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513110; cv=none; b=uSaQRxP258sRsUUuOc9t5sesJIpmWDEGlKynNrkcWgLYcdqLdldcLkoshyjpXm+rjp+CCJaOmymHlBiI182zjiMz/MajQ5PT/tWHqYnQcuD9R2X4Im9sCFuCWEiRZkhAfZpU5WmQV1vjtjwJaUjDqOgTH4d6TVwxhb3MyWDR0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513110; c=relaxed/simple;
	bh=4WGjRFRp9ih8HA7/RXKoGYWXxyHzcdYLoRsZQZ162gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPQwxfJv2/gAooc29L4v5WaTkQVg+EOxsgwW7XpgbuvRbiikKrsyPcFHkFfu0kgJLGO1JWoidaOALMZSOx6CAAblFLq6InKkMdDPLDNLLL7ZrMZsXZjqKDhVXV6PtDR5neIGfFZnb9m/Mx23PLKZerfkI7hc8hDCnFxN8x6tjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQNnRvUy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQNnRvUy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so24245565e9.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513106; x=1758117906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1J5k5uenuSfrxkj336e7ZXsuam2MWqjrwfFpeyq92SQ=;
        b=mQNnRvUydJjWnAmgrnaRsxI6a1DI26D5CC5QuCIO/jVNu0Z62wAVh1NKeAM1rSEtOW
         /JMN38Sr7J4rwKYyCkmy9Z4MGJaRi3Rai/Ai9bW0CmBzlKNXtfUP6+Vvvq6nyDkIBi5Q
         +UZ7Z4W0tOlorssDk4gUCQR6fuXbbsa9dfTYm5cvN6SYYseZdmF9ptySMgvn5aOilxAT
         U2Pv2OKoZ176BHg7qPyiB4WHQ92vFjyRnL/wX9/ljJ6GU4ltQAkxzPWtGJSIyCDGlb8q
         Xn+teZcoT0o84RrADM4SaJQpb5+TRCdSFkUyPmGu7je2fOj7eyaregOXvVFnPo9kXYfb
         B/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513106; x=1758117906;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1J5k5uenuSfrxkj336e7ZXsuam2MWqjrwfFpeyq92SQ=;
        b=uOeWr+G7YbcINP+V+vsmgDSi8d2x1bU0xa0RQwTZ0AvMil0XjCeCbMd9m+GLtwhfaS
         Urs/6A0cEZn6uzKbGE/KhT69ZQbeH71jB+H7q91X/2LeXBAOIaps8V616MVY1IEojoiE
         4pMjxV5sQ53Y4BQrrJw9bs/eSb78nCkq2giH0nH4MUAlcDi3Zc+NIwLKj5EqgJ2B0ctm
         QhS/gBgbDC4cP2JK3A/ilsQbAj6w6/wXTS+BQhsTQZH5tae2U6HoaP1o6i+v6YewezWN
         rt4N5RIs6nTwY9Q0e+nlbxtBZXA3QO8A9aP8WTO6gIY46N5KJ0nKnIru0boeZ2vnxE0c
         Lm1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL+Y+BTNYba2lbMch+FjYpolsbLNgozDdHTAe9KDYkIr5z1fPXEhvoJrdK8D9hDt7PG48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzKaBE0VBrrKMQrunrgvZumN56es+UcpGTsn4qQpUbzMrnJrg
	TJAFC4C1dUXRZmsI8g/g9BBryZZl27Gih1z/wkpSceIkYjZuXuWaQKox
X-Gm-Gg: ASbGncsEZ/o4vlvbSjOCLsjyLUIONsgl3vpBeIwuafzasZWKCj7zx+EuEhNWoBrVQNN
	andYlquKENW1xY/1mkfECdC4svfHKOY0ldHOfmVwNiCZy4J6cOGpXKc0zcMXYqZnPrFbRTxqtu5
	bIdKm7gLHs334HvGK6YGsqUXSDXYoyCrYifmrv09AaDclyE+SJx7GpopvqEUh+vFcOJB2SwINKw
	LBK8tF/s9K60xMUSgLc66lT0YuUQJLo9hY/edkKr/XiAX26NIvRkIIClZsPXqsxkvviF7zttYwW
	mqVlmJOjrTX8rfhCTdLZNvA0CxLs5oMQD1ja5rIbVomd/UjLI2NoaSUHJcNSC/MYLJSW3rYC0zu
	5Fdt6U3zx7ABbQ0SNUNNatMW47U1gDSmXhzAsRsnoO6BkMh6iu8lS8x4A0F8YznJfhs2rLwkv26
	hNg14X3wMrUQ==
X-Google-Smtp-Source: AGHT+IHuEPuNBy7M2nu3wdDpKhZTj+Zy6dXDdUwTUEuOUymhWdHfoeyeJE5P4UsfAVcJKxz4XDnJBA==
X-Received: by 2002:a05:600c:4585:b0:45b:8ac2:9759 with SMTP id 5b1f17b1804b1-45dddecf557mr147674645e9.23.1757513105716;
        Wed, 10 Sep 2025 07:05:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8247c3fsm29508945e9.11.2025.09.10.07.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 07:05:05 -0700 (PDT)
Message-ID: <10696a16-3f2b-4844-9f9c-9815976b3e1e@gmail.com>
Date: Wed, 10 Sep 2025 15:05:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v3 18/18] builtin/history: implement "reword"
 subcommand
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <20250904-b4-pks-history-builtin-v3-18-509053514755@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250904-b4-pks-history-builtin-v3-18-509053514755@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 04/09/2025 15:27, Patrick Steinhardt wrote:
> Implement a new "reword" subcommand for git-history(1). This subcommand
> is essentially the same as if a user performed an interactive rebase
> with a single commit changed to use the "reword" verb.

The sequencer already knows how to reword a commit, it would be much 
simpler to reuse that code.

Thanks

Phillip

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   Documentation/git-history.adoc |   5 +
>   builtin/history.c              | 104 +++++++++++++++++++++
>   t/meson.build                  |   1 +
>   t/t3454-history-reword.sh      | 202 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 312 insertions(+)
> 
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> index 6f0c64b90e..cbbcef3582 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -13,6 +13,7 @@ git history continue
>   git history quit
>   git history drop <commit>
>   git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)
> +git history reword [<options>] <commit>
>   git history split [<options>] <commit> [--] [<pathspec>...]
>   
>   DESCRIPTION
> @@ -53,6 +54,10 @@ child commits, as that would lead to an empty branch.
>   	be related to one another and must be reachable from the current `HEAD`
>   	commit.
>   
> +`reword <commit> [--message=<message>]`::
> +	Rewrite the commit message of the specified commit. All the other
> +	details of this commit remain unchanged.
> +
>   `split [--message=<message>] <commit> [--] [<pathspec>...]`::
>   	Interactively split up <commit> into two commits by choosing
>   	hunks introduced by it that will be moved into the new split-out
> diff --git a/builtin/history.c b/builtin/history.c
> index df04b8dfc6..39acf4df28 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -723,6 +723,108 @@ static int split_commit(struct repository *repo,
>   	return ret;
>   }
>   
> +static int cmd_history_reword(int argc,
> +			      const char **argv,
> +			      const char *prefix,
> +			      struct repository *repo)
> +{
> +	const char * const usage[] = {
> +		N_("git history reword [<options>] <commit>"),
> +		NULL,
> +	};
> +	const char *commit_message = NULL;
> +	struct option options[] = {
> +		OPT_STRING('m', "message", &commit_message, N_("message"), N_("commit message")),
> +		OPT_END(),
> +	};
> +	struct strbuf final_message = STRBUF_INIT;
> +	struct commit *original_commit, *head;
> +	struct strvec commits = STRVEC_INIT;
> +	struct object_id parent_tree_oid, original_commit_tree_oid;
> +	struct object_id rewritten_commit;
> +	const char *original_message, *original_body, *ptr;
> +	struct oidmap rewritten_commits = OIDMAP_INIT;
> +	struct replay_oid_mapping mapping = { 0 };
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
> +
> +	head = lookup_commit_reference_by_name("HEAD");
> +	if (!head) {
> +		ret = error(_("could not resolve HEAD to a commit"));
> +		goto out;
> +	}
> +
> +	/*
> +	 * Collect the list of commits that we'll have to reapply now already.
> +	 * This ensures that we'll abort early on in case the range of commits
> +	 * contains merges, which we do not yet handle.
> +	 */
> +	ret = collect_commits(repo, original_commit->parents ? original_commit->parents->item : NULL,
> +			      head, &commits);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* We retain authorship of the original commit. */
> +	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
> +	ptr = find_commit_header(original_message, "author", &len);
> +	if (ptr)
> +		original_author = xmemdupz(ptr, len);
> +	find_commit_subject(original_message, &original_body);
> +
> +	if (original_commit->parents)
> +		parent_tree_oid = *get_commit_tree_oid(original_commit->parents->item);
> +	else
> +		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
> +	original_commit_tree_oid = *get_commit_tree_oid(original_commit);
> +
> +	ret = fill_commit_message(repo, &parent_tree_oid, &original_commit_tree_oid,
> +				  original_body, commit_message, "reworded", &final_message);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = commit_tree(final_message.buf, final_message.len,
> +			  &repo_get_commit_tree(repo, original_commit)->object.oid,
> +			  original_commit->parents, &rewritten_commit, original_author, NULL);
> +	if (ret < 0) {
> +		ret = error(_("failed writing reworded commit"));
> +		goto out;
> +	}
> +
> +	replace_commits(&commits, &original_commit->object.oid, &rewritten_commit, 1);
> +
> +	mapping.entry.oid = rewritten_commit;
> +	mapping.rewritten_oid = original_commit->object.oid;
> +	oidmap_put(&rewritten_commits, &mapping);
> +
> +	ret = apply_commits(repo, &commits, head, original_commit,
> +			    &rewritten_commits, "reword");
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = 0;
> +
> +out:
> +	oidmap_clear(&rewritten_commits, 0);
> +	strbuf_release(&final_message);
> +	strvec_clear(&commits);
> +	free(original_author);
> +	return ret;
> +}
> +
>   static int cmd_history_split(int argc,
>   			     const char **argv,
>   			     const char *prefix,
> @@ -835,6 +937,7 @@ int cmd_history(int argc,
>   		N_("git history quit"),
>   		N_("git history drop <commit>"),
>   		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
> +		N_("git history reword [<options>] <commit>"),
>   		N_("git history split [<options>] <commit> [--] [<pathspec>...]"),
>   		NULL,
>   	};
> @@ -845,6 +948,7 @@ int cmd_history(int argc,
>   		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
>   		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
>   		OPT_SUBCOMMAND("reorder", &fn, cmd_history_reorder),
> +		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
>   		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
>   		OPT_END(),
>   	};
> diff --git a/t/meson.build b/t/meson.build
> index b3d33c8588..948223f453 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -380,6 +380,7 @@ integration_tests = [
>     't3451-history-drop.sh',
>     't3452-history-reorder.sh',
>     't3453-history-split.sh',
> +  't3454-history-reword.sh',
>     't3500-cherry.sh',
>     't3501-revert-cherry-pick.sh',
>     't3502-cherry-pick-merge.sh',
> diff --git a/t/t3454-history-reword.sh b/t/t3454-history-reword.sh
> new file mode 100755
> index 0000000000..97bdd755fa
> --- /dev/null
> +++ b/t/t3454-history-reword.sh
> @@ -0,0 +1,202 @@
> +#!/bin/sh
> +
> +test_description='tests for git-history reword subcommand'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'refuses to work with merge commits' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit base &&
> +		git branch branch &&
> +		test_commit ours &&
> +		git switch branch &&
> +		test_commit theirs &&
> +		git switch - &&
> +		git merge theirs &&
> +		test_must_fail git history reword HEAD~ 2>err &&
> +		test_grep "cannot rearrange commit history with merges" err &&
> +		test_must_fail git history reword HEAD 2>err &&
> +		test_grep "cannot rearrange commit history with merges" err
> +	)
> +'
> +
> +test_expect_success 'refuses to work with changes in the worktree or index' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit base file &&
> +		echo foo >file &&
> +		test_must_fail git history reword HEAD 2>err &&
> +		test_grep "Your local changes to the following files would be overwritten" err &&
> +		git add file &&
> +		test_must_fail git history reword HEAD 2>err &&
> +		test_grep "Your local changes to the following files would be overwritten" err
> +	)
> +'
> +
> +test_expect_success 'can reword tip of a branch' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +
> +		git symbolic-ref HEAD >expect &&
> +		git history reword -m "third reworded" HEAD &&
> +		git symbolic-ref HEAD >actual &&
> +		test_cmp expect actual &&
> +
> +		cat >expect <<-EOF &&
> +		third reworded
> +		second
> +		first
> +		EOF
> +		git log --format=%s >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'can reword commit in the middle' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +
> +		git symbolic-ref HEAD >expect &&
> +		git history reword -m "second reworded" HEAD~ &&
> +		git symbolic-ref HEAD >actual &&
> +		test_cmp expect actual &&
> +
> +		cat >expect <<-EOF &&
> +		third
> +		second reworded
> +		first
> +		EOF
> +		git log --format=%s >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'can reword root commit' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +		git history reword -m "first reworded" HEAD~2 &&
> +
> +		cat >expect <<-EOF &&
> +		third
> +		second
> +		first reworded
> +		EOF
> +		git log --format=%s >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'can use editor to rewrite commit message' '
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
> +		# with ${SQ}#${SQ} will be kept; you may remove them yourself if you want to.
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
> +	)
> +'
> +
> +test_expect_success 'hooks are executed for rewritten commits' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +		test_commit second &&
> +		test_commit third &&
> +
> +		write_script .git/hooks/prepare-commit-msg <<-EOF &&
> +		echo "prepare-commit-msg: \$@" >>"$(pwd)/hooks.log"
> +		EOF
> +		write_script .git/hooks/post-commit <<-EOF &&
> +		echo "post-commit" >>"$(pwd)/hooks.log"
> +		EOF
> +		write_script .git/hooks/post-rewrite <<-EOF &&
> +		{
> +			echo "post-rewrite: \$@"
> +			cat
> +		} >>"$(pwd)/hooks.log"
> +		EOF
> +
> +		git history reword -m "second reworded" HEAD~ &&
> +
> +		cat >expect <<-EOF &&
> +		third
> +		second reworded
> +		first
> +		EOF
> +		git log --format=%s >actual &&
> +		test_cmp expect actual &&
> +
> +		cat >expect <<-EOF &&
> +		prepare-commit-msg: .git/COMMIT_EDITMSG message
> +		post-commit
> +		prepare-commit-msg: .git/COMMIT_EDITMSG message
> +		post-commit
> +		post-rewrite: history
> +		$(git rev-parse second) $(git rev-parse HEAD~)
> +		$(git rev-parse third) $(git rev-parse HEAD)
> +		EOF
> +		test_cmp expect hooks.log
> +	)
> +'
> +
> +test_expect_success 'aborts with empty commit message' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +
> +		test_must_fail git history reword -m "" HEAD 2>err &&
> +		test_grep "Aborting commit due to empty commit message." err
> +	)
> +'
> +
> +test_done
> 

