Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494E338F20
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958908; cv=none; b=C56hYCWLULK52WVFP/3nwINMNXi44KrjHOrdg5L/7MoQc+rDNCmWzwwnKmoqypLA5vR3n7Tj7svFHeyaTig8bEDyfKCQt+TO4pwmIz2gKaBZkDSK16znjZs28RX5+t9CVDDMKG/MqHOm4yi+TboaDx+8VUPu5Q2biVfg443wz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958908; c=relaxed/simple;
	bh=LVpkWxlLKbzTjAjS8bJ8KsvLmJZUfY20nxB/3yrEj+M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=lMLPuvDxIpTZFAYZ9G90PABCScv+Rl5/VtWy9bt6K6jH6jo8rhJMIGnVmEvIc8zR+bOHRPNPEI2PF1QHXCLq3/LV3ShJSNeb5QwAl41XV9vPfb1j4rgOZO2V1nPItTAduLHz/xPf2zlX/s0xE2MOHeBEt7tNJw0E6h7PMemsZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNOgANY3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNOgANY3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477632b0621so6171475e9.2
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 06:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762958903; x=1763563703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxyfCMhjzA7G8m/7EcmmH0BKubpQ5LHZuO1idWU//40=;
        b=VNOgANY3LfHuYKdRsxK7dkbQ8XQH5aHL/aX42M/AjJ8yXKv29rpqS8AMLpiF5lk4Ni
         l8zggoHzd3Af/hjFYQoyEhtMELkWOkkk/b+uGwSvtq9EionWMZ4DSoiYkZBZ33ti698m
         4kfIezX/cFLULWzBJ8ebFnUv0NCEOOF2ZFXAFdFyHQrJiVAbZ90vbyGNYQCu9qdyr6Y4
         p9UmuCrbMVkkJ48hGwFLry5HYkTbmBo5p08zpKFnjNP3B+VwClte3a3KD7nq+bBjDjie
         74DNhrkE96oS5EYt92fHdWR2ie0BJJklFWhZNcUMCAehPlBG2y72UHpLVqHie9zuMqlY
         3rBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958903; x=1763563703;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxyfCMhjzA7G8m/7EcmmH0BKubpQ5LHZuO1idWU//40=;
        b=B0mFfGfOSA36LTGSqtL6ET8xn7BEsF4q8p9Ihr03CqWwKsonTz1twAnMfTmpk1URzz
         h0m0cujXDJULI3tMfygZpO0aQ8kHbK0ndh8F6ID8LXtQijSVlK9KDAIRrYqafQNtn3+X
         RDjmNI0cykmvKRgk3Bzp4YLsTyw0+MtNhaKlMly62Zh7ELQe2+27JzAH6AuXdXBKcM7E
         paC+ZQ3KPYIcCGKWY9CKD7JKaLIsh1TLMhlmvpHRaJAxhYu15aQbVhYjSmPc3YGFrVox
         bHo+07snMN8qYVrMSBNK3kuDwkzBjt6N33TyxqQQJU/yvhuQvOZQBl05zdy/xeRO7+9B
         zGwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgWwptEY1SUNSDZu93cOu/knxqTIBzPaj7N8jpDNfbbieiKtPHYk+wHHhZoZoq4iBFdiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMdoI4Ze91TXakGlVWnpzfGDdL3Idi6DHKzfiBcCXSq5e/DKqx
	S5c41O2oP1CrkpKAhiQXNRQDEH0ZWBX6LL/JpPkSlRcHGnmFLGKg0JSr
X-Gm-Gg: ASbGncs8e1aEeYlCaq3q/OkyDho2KHdLpMDAcPyj6la0zNOCcP/qhbxLc90nST5LZrM
	J2czUscvmmPJDkge1M0jvSmd/cdnI53CTfzMeqnj/t+xo3vEMiafvEily8b0kIIa+Wqjc77L2YX
	FkDi8xhXe3Inu2wyWhANT/VYF7GlD1Wk7FZUwi/wfUxKu3vxIBvRNcn1qnywWmSIbzV+2e38Okw
	wSAB0TwiCCQcUwiVLHT+3IX2cDzE1+RkMaEqHDNt8yilcytoI8SONRWnHs6IL2OV2nA0FBy9RK2
	aLZ/9KHNoe9HDZD7N5QcMJF+//wnMJX95FiCo6v9GXpaoEtRltxxbKBpUDRQeyydHiWpU8nILbm
	AIPlbqzyZpMvomgXFDQQUO2HEOrls18ewnGEp0WrVSpxcq4omgr3XhHcAUZRwJMdDYon8/Um7gp
	VmoEQPtjSNLmiL/CfO2l29eBWkfDqxw5QWINMssr9B5ylS7hNGUkQY
X-Google-Smtp-Source: AGHT+IHU1LKFpMcKsLE/+pM6DeXhDMqWLySyHUcAL5bf2Q+GfsYCgEJpl092zp2GpElyVvWi7IuSQg==
X-Received: by 2002:a05:600c:a05:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-477870962d8mr35465645e9.22.1762958902612;
        Wed, 12 Nov 2025 06:48:22 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm33174201f8f.9.2025.11.12.06.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:48:22 -0800 (PST)
Message-ID: <0413bf2e-52c4-4944-a349-2a922dd463a2@gmail.com>
Date: Wed, 12 Nov 2025 14:48:21 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 4/4] rebase: support --trailer
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20251105142944.73061-1-me@linux.beauty>
 <20251105142944.73061-5-me@linux.beauty>
Content-Language: en-US
In-Reply-To: <20251105142944.73061-5-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Li

On 05/11/2025 14:29, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 005caf6164..4d2fe4be6e 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -487,9 +487,16 @@ See also INCOMPATIBLE OPTIONS below.
>   	Add a `Signed-off-by` trailer to all the rebased commits. Note
>   	that if `--interactive` is given then only commits marked to be
>   	picked, edited or reworded will have the trailer added.
> -+
> +
>   See also INCOMPATIBLE OPTIONS below.
>   
> +--trailer=<trailer>::
> +       Append the given trailer line(s) to every rebased commit

I'm not sure we need to say "line(s)" here. "Append the given trailer to 
every ..." would be fine I think.

> +       message, processed via linkgit:git-interpret-trailers[1].
> +       When this option is present *rebase automatically implies*
> +       `--force-rebase` so that fast‑forwarded commits are also
> +       rewritten.

Normally in cases like this we just say "This option implies 
`--force-rebase`".

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index c468828189..a88abe08b4 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -500,6 +508,23 @@ static int read_basic_state(struct rebase_options *opts)
>   		opts->gpg_sign_opt = xstrdup(buf.buf);
>   	}
>   
> +	strbuf_reset(&buf);
> +
> +	if (strbuf_read_file(&buf, state_dir_path("trailer", opts), 0) >= 0) {
> +		const char *p = buf.buf, *end = buf.buf + buf.len;
> +
> +		while (p < end) {
> +			char *nl = memchr(p, '\n', end - p);
> +			if (!nl)
> +				die("nl shouldn't be NULL");
> +			*nl = '\0';
> +
> +			if (*p)
> +				strvec_push(&opts->trailer_args, p);
> +
> +			p = nl + 1;
> +		}
> +	}

As "--trailer" is only supported by the "merge" backend we only need to 
read this file in sequencer.c:read_populate_opts(), there is no point in 
reading it here.

>   	strbuf_release(&buf);
>   
>   	return 0;
> @@ -528,6 +553,21 @@ static int rebase_write_basic_state(struct rebase_options *opts)
>   	if (opts->signoff)
>   		write_file(state_dir_path("signoff", opts), "--signoff");
>   
> +	/*
> +	 * save opts->trailer_args into state_dir/trailer
> +	 */

As "--trailer" is not supported by the "apply" backend we can just rely 
on this being written by sequener.c:write_basic_state(), we don't need 
to do it here

> +	if (opts->trailer_args.nr) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		for (size_t i = 0; i < opts->trailer_args.nr; i++) {
> +				strbuf_addstr(&buf, opts->trailer_args.v[i]);
> +				strbuf_addch(&buf, '\n');
> +		}
> +		write_file(state_dir_path("trailer", opts),
> +				   "%s", buf.buf);
> +		strbuf_release(&buf);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -1132,6 +1172,8 @@ int cmd_rebase(int argc,
>   			.flags = PARSE_OPT_NOARG,
>   			.defval = REBASE_DIFFSTAT,
>   		},
> +		OPT_STRVEC(0, "trailer", &options.trailer_args, N_("trailer"),
> +				N_("add custom trailer(s)")),

This line should be indented so that the "N_" aligns with "0" above like 
all the other options here. Putting this next to "--signoff" is a good 
choice.

> diff --git a/sequencer.c b/sequencer.c
> index 5476d39ba9..fbf35cb474 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2025,6 +2027,10 @@ static int append_squash_message(struct strbuf *buf, const char *body,
>   		if (opts->signoff)
>   			append_signoff(buf, 0, 0);
>   
> +		if (opts->trailer_args.nr &&
> +			amend_strbuf_with_trailers(buf, &opts->trailer_args))
> +			return error(_("unable to add trailers to commit message"));

amend_strbuf_with_trailers() cannot really fail so this should be

		if (opts->trailer_args.nr)
			amend_strbuf_with_trailers(buf, &opts->trailer_args));

> @@ -2443,6 +2449,14 @@ static int do_pick_commit(struct repository *r,
>   	if (opts->signoff && !is_fixup(command))
>   		append_signoff(&ctx->message, 0, 0);
>   
> +	if (opts->trailer_args.nr && !is_fixup(command)) {
> +		if (amend_strbuf_with_trailers(&ctx->message,
> +					       &opts->trailer_args)) {
> +			res = error(_("unable to add trailers to commit message"));
> +			goto leave;
> +		}

As above amend_strbuf_with_trailers() cannot fail so we don't need this 
error handling

> +	}
> +
>   	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
>   		res = -1;
>   	else if (!opts->strategy ||
> @@ -2517,6 +2531,7 @@ static int do_pick_commit(struct repository *r,
>   			_("dropping %s %s -- patch contents already upstream\n"),
>   			oid_to_hex(&commit->object.oid), msg.subject);
>   	} /* else allow == 0 and there's nothing special to do */
> +

We try to avoid introducing unrelated white space changes

> @@ -3234,6 +3249,17 @@ static int read_populate_opts(struct replay_opts *opts)
>   
>   		read_strategy_opts(opts, &buf);
>   		strbuf_reset(&buf);
> +		if (strbuf_read_file(&buf, rebase_path_trailer(), 0) >= 0) {
> +			char *p = buf.buf, *nl;
> +
> +			while ((nl = strchr(p, '\n'))) {
> +				*nl = '\0';
> +				if (*p)

As we're in control of what's written to the file it is a BUG() if to 
contains any empty line.

> diff --git a/sequencer.h b/sequencer.h
> index 719684c8a9..e21835c5a0 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -44,6 +44,7 @@ struct replay_opts {
>   	int record_origin;
>   	int no_commit;
>   	int signoff;
> +	struct strvec trailer_args;

I think it would be better to add this after all the flag options

>   	int allow_ff;
>   	int allow_rerere_auto;
>   	int allow_empty;
> @@ -82,8 +83,9 @@ struct replay_opts {
>   	struct replay_ctx *ctx;
>   };
>   #define REPLAY_OPTS_INIT {			\
> -	.edit = -1,				\

".edit" is the first member so it makes sense to leave this at the start.

>   	.action = -1,				\
> +	.edit = -1,				\
> +	.trailer_args = STRVEC_INIT, \
>   	.xopts = STRVEC_INIT,			\
>   	.ctx = replay_ctx_new(),		\
>   }

> diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
> new file mode 100755
> index 0000000000..d0e0434664
> --- /dev/null
> +++ b/t/t3440-rebase-trailer.sh
> @@ -0,0 +1,134 @@
> +#!/bin/sh
> +#
> +
> +test_description='git rebase --trailer integration tests
> +We verify that --trailer works with the merge backend,
> +and that it is rejected early when the apply backend is requested.'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh # test_commit_message, helpers
> +
> +REVIEWED_BY_TRAILER="Reviewed-by: Dev <dev@example.com>"
> +
> +expect_trailer_msg() {
> +	test_commit_message "$1" <<-EOF
> +	$2
> +
> +	${3:-$REVIEWED_BY_TRAILER}
> +	EOF
> +}
> +
> +test_expect_success 'setup repo with a small history' '
> +	git commit --allow-empty -m "Initial empty commit" &&
> +	test_commit first file a &&
> +	test_commit second file &&
> +	git checkout -b conflict-branch first &&
> +	test_commit file-2 file-2 &&
> +	test_commit conflict file &&
> +	test_commit third file

This leaves us with conflict-branch checked out, is that intentional?

> +'
> +
> +test_expect_success 'apply backend is rejected with --trailer' '
> +	head_before=$(git rev-parse HEAD) &&

I'm not sure we really need to check that HEAD is unchanged here

> +	test_expect_code 128 \
> +	git rebase --apply --trailer "$REVIEWED_BY_TRAILER" \
> +				HEAD^ 2>err &&
> +	test_grep "fatal: --trailer requires the merge backend" err &&
> +	test_cmp_rev HEAD $head_before
> +'
> +
> +test_expect_success 'reject empty --trailer argument' '
> +	test_expect_code 128 git rebase -m --trailer "" HEAD^ 2>err &&

There is no need to pass "-m" in any of these tests as it is the default 
and if the default backend changes in the future we will want 
"--trailer" keeps working with the new default.

> +	test_grep "empty --trailer" err
> +'
> +
> +test_expect_success 'reject trailer with missing key before separator' '
> +	test_expect_code 128 git rebase -m --trailer ": no-key" HEAD^ 2>err &&
> +	test_grep "missing key before separator" err
> +'
> +
> +test_expect_success 'allow trailer with missing value after separator' '
> +	git rebase -m --trailer "Acked-by:" HEAD~1 third &&
> +	sed -e "s/_/ /g" <<-\EOF >expect &&
> +	third
> +
> +	Acked-by:_
> +	EOF
> +	test_commit_message HEAD expect

test_commit_message accepts a message on stdin so we don't need to 
create expect in all these tests. It is curious that we add a trailing 
space to the trailer, it would be nice if we could clean that up. 
Failing that other tests use SP=" " and then use ${SP} in the here 
document like

	test_commit_message HEAD <<-EOF
	third
	
	Acked-by:${SP}
	EOF

> +'
> +
> +test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
> +	git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add \
> +		rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 third &&
> +	cat >expect <<-\EOF &&
> +	third
> +
> +	Bug: 456
> +	EOF
> +	test_commit_message HEAD expect
> +'
> +
> +test_expect_success 'multiple Signed-off-by trailers all preserved' '
> +	git rebase -m \
> +			--trailer "Signed-off-by: Dev A <a@example.com>" \
> +			--trailer "Signed-off-by: Dev B <b@example.com>" HEAD~1 third &&

The massive indentation here leads to overly long lines.

	git rebase --trailer "Signed-off-by: Dev A <a@example.com>" \
		--trailer "Signed-off-by: Dev B <b@example.com>" HEAD~1 third &&

fits our 80 column limit

> +	cat >expect <<-\EOF &&
> +	third
> +
> +	Signed-off-by: Dev A <a@example.com>
> +	Signed-off-by: Dev B <b@example.com>
> +	EOF
> +	test_commit_message HEAD expect
> +'
> +
> +test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
> +	git checkout -B conflict-branch third &&

I'm not sure why we're recreating conflict-branch here, you can just run 
"git rebase [options] second third"
  > +	test_commit fourth file &&
> +	test_must_fail git rebase -m \
> +			--trailer "$REVIEWED_BY_TRAILER" \
> +			second &&

If you unfold this line it is 79 characters long which is perfctly fine.

> +	git checkout --theirs file &&
> +	git add file &&
> +	git rebase --continue &&
> +	expect_trailer_msg HEAD "fourth" &&

I think it would be easier to see what's being checked if we just used 
test_commit_message as we have done up to here and got rid of the 
test_trailer_msg.

> +	expect_trailer_msg HEAD^ "third"

This is good because we check that the conflicting commit gets a trailer 
and the commit picked by "git rebase --continue" does too.

> +'
> +
> +test_expect_success '--trailer handles fixup commands in todo list' '
> +	git checkout -B fixup-trailer HEAD &&

If you're going to create a new branch you should do it from a tag so it 
has a known starting point that is not dependent on the previous tests.

> +	test_commit fixup-base base &&
> +	test_commit fixup-second second &&
> +	first_short=$(git rev-parse --short fixup-base) &&
> +	second_short=$(git rev-parse --short fixup-second) &&

These two lines are unecessary as test_commit() creates a tag which we 
can use in the todo list. The here document should also be indented. So

> +	cat >todo <<EOF &&
> +pick $first_short fixup-base
> +fixup $second_short fixup-second
> +EOF

becomes
	cat >todo <<-\EOF &&
	pick fixup-base first-base
	fixup fixup-second fixup-second
	EOF
> +	(
> +		set_replace_editor todo &&
> +		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
> +	) &&
> +	expect_trailer_msg HEAD "fixup-base" &&

We check there is only one trailer after the fixup - good

> +	git reset --hard fixup-second &&
> +	cat >todo <<EOF &&
> +pick $first_short fixup-base
> +fixup -C $second_short fixup-second
> +EOF
> +	(
> +		set_replace_editor todo &&
> +		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
> +	) &&
> +	expect_trailer_msg HEAD "fixup-second"

We check that we add a trailer with "fixup -C" - good> +'
> +
> +test_expect_success 'rebase --root --trailer updates every commit' '
> +	git checkout first &&
> +	git -c trailer.review.key=Reviewed-by rebase --root \
> +		--trailer=review="Dev <dev@example.com>" &&

It would be good if the test title mentioned that we're also checking 
'trailer.<name>.key' here as well which is more interesting than "--root"
  > +	expect_trailer_msg HEAD  "first" &&
> +	expect_trailer_msg HEAD^ "Initial empty commit"

The test coverage looks good

> +'
> +test_done
> diff --git a/trailer.c b/trailer.c
> index f5838f5699..f6ff2f01ee 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -774,6 +775,30 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
>   	free(cl_separators);
>   }
>   
> +void validate_trailer_args_after_config(const struct strvec *cli_args)

I think "validate_trailer_args" would be a sufficient name
> +{
> +	char *cl_separators;
> +
> +	trailer_config_init();
> +
> +	cl_separators = xstrfmt("=%s", separators);
> +
> +	for (size_t i = 0; i < cli_args->nr; i++) {
> +		const char *txt = cli_args->v[i];
> +		ssize_t separator_pos;
> +
> +		if (!*txt)
> +			die(_("empty --trailer argument"));
> +
> +		separator_pos = find_separator(txt, cl_separators);
> +		if (separator_pos == 0)
> +			die(_("invalid trailer '%s': missing key before separator"),
> +		    txt);

Strange indentation here, but the implementation looks sensible.

Overall this is looking good. I've left lots of comments but they're all 
small issues

Thanks

Phillip

> +	}
> +
> +	free(cl_separators);
> +}
> +
>   static const char *next_line(const char *str)
>   {
>   	const char *nl = strchrnul(str, '\n');
> @@ -1226,8 +1251,8 @@ void trailer_iterator_release(struct trailer_iterator *iter)
>   	strbuf_release(&iter->key);
>   }
>   
> -static int amend_strbuf_with_trailers(struct strbuf *buf,
> -				      const struct strvec *trailer_args)
> +int amend_strbuf_with_trailers(struct strbuf *buf,
> +			       const struct strvec *trailer_args)
>   {
>   	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
>   	LIST_HEAD(new_trailer_head);
> diff --git a/trailer.h b/trailer.h
> index daea46ca5d..541657a11f 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -68,6 +68,8 @@ void parse_trailers_from_config(struct list_head *config_head);
>   void parse_trailers_from_command_line_args(struct list_head *arg_head,
>   					   struct list_head *new_trailer_head);
>   
> +void validate_trailer_args_after_config(const struct strvec *cli_args);
> +
>   void process_trailers_lists(struct list_head *head,
>   			    struct list_head *arg_head);
>   
> @@ -195,6 +197,9 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
>    */
>   void trailer_iterator_release(struct trailer_iterator *iter);
>   
> +int amend_strbuf_with_trailers(struct strbuf *buf,
> +			       const struct strvec *trailer_args);
> +
>   /*
>    * Augment a file to add trailers to it (similar to 'git interpret-trailers').
>    * Returns 0 on success or a non-zero error code on failure.

