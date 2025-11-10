Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DCF319619
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793410; cv=none; b=hdI94f2UY4qH95/3uv0539ZIGCcQMFvkH2ug3OZIyG5ylCQOjUEnpBMibFasvTrnGS6BA/5UalQYDH2HppSbz2hBy7AY8K+uOdPavhunBEuRvu1Ie5GljtLva+cM75vZ+exu/Pe8S57BDIjyCiyzVk6beKsvbQM8IRu7eRXTJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793410; c=relaxed/simple;
	bh=QLAZ85eYjPbFIZzrFE0BSOkOYtfzqx1C1CCrQEkZxZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enjFHeaMy8eBXg19dhaqpL8d0Jy703TrX6uVSNa8kKRKrpkTPwLV5rYZnni27TB68MMKC4ig2l2PF2acmT7IJp9NviotVQ4DNk23CgowSOLd2opzwwc9RFswLk6FA1CCWhtzJSjXbsDbKLVgnDuCj4emxAUVpKMFkhmmPa1jbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ6ixxq8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ6ixxq8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477770019e4so23045265e9.3
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762793406; x=1763398206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XBFzToMx8FJBUednuVJuOO89xIR4ButmSbvgKVDruUI=;
        b=MZ6ixxq8IpXMVlhAtlyYuEhaAsIBmfCzPf5x99wRoqFpXTnWKZ8lHqwJPh2c/XRFlN
         OBzfO61bm4dY75jSHFRK98ZW9fkjHo9fj20NHnSiOwk2xh1hSpniohJ8GVpQpeVzG1wp
         fBTSjjQfkFwN/tx8jbcJ21nhB49DyRZfJwGUzYGOmeSmNUCocS6WICWeCh6XIE8fTOa5
         VkPtRfJziAvp2LCjG3k9+MTL6QdhmWmOHWny98oxhnApYFhbrYvmu/KJcd4MCw4ENn8C
         EyapDCNGZZ3pYfSTjLDHymCXVlwKa3udAfdKz99gNOfM6vmMfXhOULxvR36g45r6KO0a
         Lm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793406; x=1763398206;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBFzToMx8FJBUednuVJuOO89xIR4ButmSbvgKVDruUI=;
        b=kIsbKBTKlXVwGaV2xy4RVbJEgqZkqFtLydUPLu3b2rwrmlTwqMT85vT9C15trcJI1y
         0XjXaY0k881Hru4fhGlk+TG9mki6FM3NswWq9USnSuTgsXm2cOQJNobU1WDwikTJ3EDk
         j3LSEkm9zcnKGHTt0KgJoEiCbuGHGDh36TaFdyou05Yvq1FumJlZqx8TCEFeeqNbho9L
         eIOQTfi9AohtkdFTdinESsF5fdluLCFMi+jxo0CD5T+gNcaA5zQcTcaU6qe4TiSsfmMn
         foBy7VpVtYoWSPCXSmCzVJ8tCXBUmDRO8QeKbLip6MoBtFLs3fwyTMN+hT7a10Rp0tUD
         2Mgw==
X-Forwarded-Encrypted: i=1; AJvYcCVcGPFJAnZEeR8mNvlGAYire19l17AKIHILwCqBTNKjOHbbZEDL2MJPeQBVDZzDRAEpG68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9799zQvYk88Z8ym44+hAMcO6TGj2+jNbvuRM0X2mDshzt7m2
	7xeK//kxxq62NJVdVjnOX4hVDVoA/ujFDfK+2IyYgZ8K1g99jjj4DE0a
X-Gm-Gg: ASbGnct/vIAtbPgWNQIovc+UCnqkxe8fQVXABL7dHDDe7C/N+4DM+sOipNplTG3aOWX
	zdrc0Xwgd9u06bKYtF7s8U8fMe5DXbViYV3epJb5xc5yLmy+K8SdsvkegTT3D4TmwcQ3ZZeHdH/
	hUEnEAO3AimTXZ7HGe7CpS3pbGsBGtU5GxKImPHyIN0ifpgZjY+6VwjbfPe5Tq6om34eAiLIWqP
	ZMRY0wjqlcwONZy0noiWdxkti/iIYNYTb5vs/CN2RH4G6BoZYPTZmwy1mIh7gcz4zPRkElKVlkx
	658D+c9CGJGjgWdgwEq9YxVRX/hVR4O+3eTVw3rvOOMZ3vLqaBKGNR1T27Xud8UwUFha+5O9oUS
	SUB0X3w3CicZ8L7uKqDy+osxGZNvqmW0DcEkcAkY9yiFGpaLfF+qpO3AP2fLzERimnG9okkBRJ/
	p6WEKutvrC9DJHGynGllb9HOXG7QXuQ/3plrYCeBkMjGzSFEztzyr3
X-Google-Smtp-Source: AGHT+IFJJNeLBmkv3cd2vMUBeH2rfElrlIE4rK0UcuI2Kmu7UJ+RvG1DOjLWbScT71/5h99BFKPc3g==
X-Received: by 2002:a05:600c:3554:b0:477:557b:6917 with SMTP id 5b1f17b1804b1-4777323ae5bmr84694795e9.18.1762793405845;
        Mon, 10 Nov 2025 08:50:05 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd51dfsm212433695e9.5.2025.11.10.08.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:50:05 -0800 (PST)
Message-ID: <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
Date: Mon, 10 Nov 2025 16:50:04 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] commit: add --committer option
To: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 ZheNing Hu <adlternative@gmail.com>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi ZheNing

On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
>      
>      This patch introduces the --committer option to git-commit, providing:
>      
>       1. Consistency with the existing --author option
>       2. A more convenient alternative to environment variables
>       3. Better support for automated workflows and scripts
>       4. Improved user experience when managing multiple identities

What's the use case for the same person committing under different 
identities? We already have a config mechanism to set different 
identities for different repositories but I'm struggling to see why 
someone would want to create commits under multiple identities in a 
single repository. For scripts it easy enough to set the relevant 
environment variables if a tool wants to create commits under its own 
identity.

Thanks

Phillip

>      The implementation follows the same pattern as the --author option,
>      accepting the format "Name " and properly validating the input.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1997%2Fadlternative%2Fzh%2Fimplement-committer-option-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1997/adlternative/zh/implement-committer-option-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1997
> 
>   Documentation/git-commit.adoc |  9 +++-
>   builtin/commit.c              | 58 ++++++++++++++++++++++++-
>   t/t7509-commit-authorship.sh  | 80 +++++++++++++++++++++++++++++++++++
>   3 files changed, 144 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
> index 54c207ad45..a015c8328e 100644
> --- a/Documentation/git-commit.adoc
> +++ b/Documentation/git-commit.adoc
> @@ -12,7 +12,7 @@ git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]
>   	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
>   	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>   	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
> -	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> +	   [--date=<date>] [--committer=<committer>] [--cleanup=<mode>] [--[no-]status]
>   	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
>   	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
>   	   [--] [<pathspec>...]
> @@ -181,6 +181,13 @@ See linkgit:git-rebase[1] for details.
>   `--date=<date>`::
>   	Override the author date used in the commit.
>   
> +`--committer=<committer>`::
> +	Override the committer for the commit. Specify an explicit committer using the
> +	standard `A U Thor <committer@example.com>` format. Otherwise _<committer>_
> +	is assumed to be a pattern and is used to search for an existing
> +	commit by that author (i.e. `git rev-list --all -i --author=<committer>`);
> +	the commit author is then copied from the first such commit found.
> +
>   `-m <msg>`::
>   `--message=<msg>`::
>   	Use _<msg>_ as the commit message.
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0243f17d53..88e77cbaab 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -49,7 +49,7 @@ static const char * const builtin_commit_usage[] = {
>   	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]\n"
>   	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
>   	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
> -	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
> +	   "           [--date=<date>] [--committer=<committer>] [--cleanup=<mode>] [--[no-]status]\n"
>   	   "           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
>   	   "           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]\n"
>   	   "           [--] [<pathspec>...]"),
> @@ -112,6 +112,7 @@ static enum {
>   } commit_style;
>   
>   static const char *force_author;
> +static const char *force_committer;
>   static char *logfile;
>   static char *template_file;
>   /*
> @@ -690,6 +691,48 @@ static void determine_author_info(struct strbuf *author_ident)
>   	free(date);
>   }
>   
> +static void determine_committer_info(struct strbuf *committer_ident)
> +{
> +	char *name, *email, *date;
> +	struct ident_split committer;
> +
> +	name = xstrdup_or_null(getenv("GIT_COMMITTER_NAME"));
> +	email = xstrdup_or_null(getenv("GIT_COMMITTER_EMAIL"));
> +	date = xstrdup_or_null(getenv("GIT_COMMITTER_DATE"));
> +
> +	if (force_committer) {
> +		struct ident_split ident;
> +
> +		if (split_ident_line(&ident, force_committer, strlen(force_committer)) < 0)
> +			die(_("malformed --committer parameter"));
> +		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
> +		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
> +
> +		if (ident.date_begin) {
> +			struct strbuf date_buf = STRBUF_INIT;
> +			strbuf_addch(&date_buf, '@');
> +			strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
> +			strbuf_addch(&date_buf, ' ');
> +			strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
> +			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
> +		}
> +	}
> +
> +	if (force_date) {
> +		struct strbuf date_buf = STRBUF_INIT;
> +		if (parse_force_date(force_date, &date_buf))
> +			die(_("invalid date format: %s"), force_date);
> +		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
> +	}
> +
> +	strbuf_addstr(committer_ident, fmt_ident(name, email, WANT_COMMITTER_IDENT, date,
> +				IDENT_STRICT));
> +	assert_split_ident(&committer, committer_ident);
> +	free(name);
> +	free(email);
> +	free(date);
> +}
> +
>   static int author_date_is_interesting(void)
>   {
>   	return author_message || force_date;
> @@ -1321,6 +1364,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   	if (force_author && renew_authorship)
>   		die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
>   
> +	if (force_committer && !strchr(force_committer, '>'))
> +		force_committer = find_author_by_nickname(force_committer);
> +
>   	if (logfile || have_option_m || use_message)
>   		use_editor = 0;
>   
> @@ -1709,6 +1755,7 @@ int cmd_commit(int argc,
>   		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
>   		OPT_STRING(0, "author", &force_author, N_("author"), N_("override author for commit")),
>   		OPT_STRING(0, "date", &force_date, N_("date"), N_("override date for commit")),
> +		OPT_STRING(0, "committer", &force_committer, N_("committer"), N_("override committer for commit")),
>   		OPT_CALLBACK('m', "message", &message, N_("message"), N_("commit message"), opt_parse_m),
>   		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
>   		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
> @@ -1785,6 +1832,7 @@ int cmd_commit(int argc,
>   
>   	struct strbuf sb = STRBUF_INIT;
>   	struct strbuf author_ident = STRBUF_INIT;
> +	struct strbuf committer_ident = STRBUF_INIT;
>   	const char *index_file, *reflog_msg;
>   	struct object_id oid;
>   	struct commit_list *parents = NULL;
> @@ -1930,8 +1978,13 @@ int cmd_commit(int argc,
>   		append_merge_tag_headers(parents, &tail);
>   	}
>   
> +	if (force_committer) {
> +		determine_committer_info(&committer_ident);
> +	}
> +
>   	if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->cache_tree->oid,
> -				 parents, &oid, author_ident.buf, NULL,
> +				 parents, &oid, author_ident.buf,
> +				 force_committer ? committer_ident.buf : NULL,
>   				 sign_commit, extra)) {
>   		rollback_index_files();
>   		die(_("failed to write commit object"));
> @@ -1980,6 +2033,7 @@ cleanup:
>   	free_commit_extra_headers(extra);
>   	free_commit_list(parents);
>   	strbuf_release(&author_ident);
> +	strbuf_release(&committer_ident);
>   	strbuf_release(&err);
>   	strbuf_release(&sb);
>   	free(logfile);
> diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
> index 8e373b566b..45527f6a70 100755
> --- a/t/t7509-commit-authorship.sh
> +++ b/t/t7509-commit-authorship.sh
> @@ -12,6 +12,11 @@ author_header () {
>   	sed -n -e '/^$/q' -e '/^author /p'
>   }
>   
> +committer_header () {
> +	git cat-file commit "$1" |
> +	sed -n -e '/^$/q' -e '/^committer /p'
> +}
> +
>   message_body () {
>   	git cat-file commit "$1" |
>   	sed -e '1,/^$/d'
> @@ -171,4 +176,79 @@ test_expect_success '--reset-author with CHERRY_PICK_HEAD' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success '--committer option overrides committer' '
> +	git checkout Initial &&
> +	echo "Test --committer" >>foo &&
> +	test_tick &&
> +	git commit -a -m "test committer" --committer="Custom Committer <custom@committer.example>" &&
> +	committer_header HEAD >actual &&
> +	grep "Custom Committer <custom@committer.example>" actual
> +'
> +
> +test_expect_success '--committer with pattern search' '
> +	echo "Test committer pattern" >>foo &&
> +	test_tick &&
> +	git commit -a -m "test committer pattern" --committer="Frigate" &&
> +	committer_header HEAD >actual &&
> +	grep "Frigate <flying@over.world>" actual
> +'
> +
> +test_expect_success '--committer malformed parameter' '
> +	echo "Test malformed" >>foo &&
> +	test_tick &&
> +	test_must_fail git commit -a -m "test malformed" --committer="malformed committer"
> +'
> +
> +test_expect_success '--committer with --amend option' '
> +	git checkout -f Initial &&
> +	echo "Test committer with amend" >>foo &&
> +	test_tick &&
> +	git commit -a -m "initial commit for amend test" &&
> +	echo "Modified for amend" >>foo &&
> +	test_tick &&
> +	git commit -a --amend --no-edit \
> +		--author="Test Author <test@author.example>" \
> +		--committer="Test Committer <test@committer.example>" &&
> +	author_header HEAD >actual_author &&
> +	grep "Test Author <test@author.example>" actual_author &&
> +	committer_header HEAD >actual_committer &&
> +	grep "Test Committer <test@committer.example>" actual_committer
> +'
> +
> +test_expect_success 'GIT_COMMITTER_* environment variables' '
> +	git checkout -f Initial &&
> +	echo "Test env vars" >>foo &&
> +	test_tick &&
> +	GIT_COMMITTER_NAME="Env Committer" \
> +	GIT_COMMITTER_EMAIL="env@test.example" \
> +	git commit -a -m "test committer env vars" &&
> +	committer_header HEAD >actual &&
> +	grep "Env Committer <env@test.example>" actual
> +'
> +
> +test_expect_success '--committer overrides GIT_COMMITTER_* environment variables' '
> +	echo "Test override" >>foo &&
> +	test_tick &&
> +	GIT_COMMITTER_NAME="Env Committer" \
> +	GIT_COMMITTER_EMAIL="env@test.example" \
> +	git commit -a -m "test override" \
> +		--committer="Override Committer <override@test.example>" &&
> +	committer_header HEAD >actual &&
> +	grep "Override Committer <override@test.example>" actual
> +'
> +
> +test_expect_success '--date with --committer changes both author and committer dates' '
> +	git checkout -f Initial &&
> +	echo "Test date override" >>foo &&
> +	test_tick &&
> +	git commit -a -m "test date" \
> +		--author="Date Author <date@author.example>" \
> +		--committer="Date Committer <date@committer.example>" \
> +		--date="2024-06-15 10:30:00 +0800" &&
> +	git log -1 --format="%ai" >author_date &&
> +	git log -1 --format="%ci" >committer_date &&
> +	grep "2024-06-15 10:30:00 +0800" author_date &&
> +	grep "2024-06-15 10:30:00 +0800" committer_date
> +'
> +
>   test_done
> 
> base-commit: 4badef0c3503dc29059d678abba7fac0f042bc84

