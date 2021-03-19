Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0FCC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 17:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1376197F
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 17:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCSRsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 13:48:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63891 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhCSRsb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 13:48:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4FED116E1B;
        Fri, 19 Mar 2021 13:48:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a6j1GWDpCTldQ4GVwAkD30lyur0=; b=hv67J/
        4qXuq5jN10r6j2lyNcnI6Si5EkfWAlfKInNOeHrGo+aDQzGxgwfouTgl3a5hmsE+
        lF5avDk/kxVEiZEdmKyjyay6J1b+HAS4M8AlJfiw5xrgMjUGylWgEYCYrPSmndhC
        8hU1gjhRd9clLcCH0wxtPJfathCUzi8uCult4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=atb1StuQlauLMyiJ6N9SlgvJSS7HSE7P
        kpciAneWGJ5NcYWw5pxYIB5uMHBmZCq8Mh8hqXzW8G37wtrhpVI1zrIToY2fDMlx
        cjrPE4Yx3GcCw1elX8aXCQym3wEWKKkQiAb7Z3gM5vYHCYIt6/BBVjTUf+yQzs8R
        8yW3nZgtpWE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD3AF116E1A;
        Fri, 19 Mar 2021 13:48:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 302F2116E19;
        Fri, 19 Mar 2021 13:48:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqn?= =?utf-8?B?biBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v11] [GSOC] commit: add --trailer option
References: <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
        <pull.901.v11.git.1616155517590.gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 10:48:26 -0700
In-Reply-To: <pull.901.v11.git.1616155517590.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Fri, 19 Mar 2021 12:05:17 +0000")
Message-ID: <xmqq4kh7nifp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FC02F56-88DB-11EB-A59B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +--trailer <token>[(=|:)<value>]::
> +	Specify a (<token>, <value>) pair that should be applied as a
> +	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
> +	<committer@example.com>" --trailer "Helped-by:C O Mitter \
> +	<committer@example.com>"` will add the "Signed-off-by" trailer
> +	and the "Helped-by" trailer in the commit message.)

s/in the commit message/to the commit message/ probably.

> +	Use `git -c trailer.* commit --trailer` to make the appropriate
> +	configuration. See linkgit:git-interpret-trailers[1] for details.

I doubt this is a good advice for a few reasons.

 (1) The "git -c var=val" is meant to be used as a single-shot
     oddball configuration.  If the user will be working on the
     project long enough to be worth using the --trailer option
     (otherwise a single-shot drive-by patch can just add these
     trailers while editing the log message in the editor), the user
     would not want to use "git -c var=val" mechanism to use
     different configuration every time the --trailer option is
     used.

 (2) The "appropriate configuration" is too vague and does not give
     enough incentive to the reader to go look in the other manual
     page.  At least there should be a cursory mention of what kind
     of things are possible by the configuration.

Prehaps

    The `trailer.*` configuration variables (see linkgit:...) can be
    used to define if a duplicated trailer is omitted, where in the
    run of trailers each trailer would appear, and other details.

or something along the line (Christian would be a better person to
suggest what good examples are than I am, though).

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 739110c5a7f6..4b06672bd07d 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -113,6 +113,7 @@ static int config_commit_verbose = -1; /* unspecified */
>  static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>  static char *sign_commit, *pathspec_from_file;
> +static struct strvec trailer_args = STRVEC_INIT;
>  
>  /*
>   * The default commit message cleanup mode will remove the lines
> @@ -131,6 +132,14 @@ static struct strbuf message = STRBUF_INIT;
>  
>  static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
>  
> +static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
> +{
> +	BUG_ON_OPT_NEG(unset);
> +
> +	strvec_pushl(&trailer_args, "--trailer", arg, NULL);
> +	return 0;
> +}
> +
>  static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
>  {
>  	enum wt_status_format *value = (enum wt_status_format *)opt->value;
> @@ -958,6 +967,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  
>  	fclose(s->fp);
>  
> +	if (trailer_args.nr) {
> +		struct child_process run_trailer = CHILD_PROCESS_INIT;
> +
> +		strvec_pushl(&run_trailer.args, "interpret-trailers",
> +			     "--in-place", git_path_commit_editmsg(), NULL);
> +		strvec_pushv(&run_trailer.args, trailer_args.v);
> +		run_trailer.git_cmd = 1;
> +		if (run_command(&run_trailer))
> +			die(_("unable to pass trailers to --trailers"));
> +		strvec_clear(&trailer_args);

OK.  run_command() cleans the run_trailer.args when it returns, so
we only need to clear our own array here.

> +	}
> +

> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index 6396897cc818..024cf3c81b18 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -154,6 +154,341 @@ test_expect_success 'sign off' '
>  
>  '
>  
> +test_expect_success 'commit --trailer without -c' '
> +	echo "fun" >>file &&
> +	git add file &&
> +	cat >expected <<-\EOF &&
> +
> +	Signed-off-by: C O Mitter <committer@example.com>
> +	Signed-off-by: C1 E1
> +	Helped-by: C2 E2
> +	Reported-by: C3 E3
> +	Mentored-by: C4 E4
> +	EOF
> +	git commit -s --trailer "Signed-off-by:C1 E1 " \
> +		--trailer "Helped-by:C2 E2 " \
> +		--trailer "Reported-by:C3 E3" \
> +		--trailer "Mentored-by:C4 E4" \
> +		-m "hello" &&
> +	git cat-file commit HEAD >commit.msg &&
> +	sed -e "1,6d" commit.msg >actual &&

This 1,6d depends on the exact line organization of the underlying
object detail, which is not good.  You'd want to grab the run of the
consecutive non-empty lines at the end, so that commit object headers
and the log message "fun" can change over time by changes to Git and
changes to this test, without breaking this test.

> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'commit --trailer with -c and "replace" as ifexists' '
> +	echo "fun" >>file1 &&
> +	git add file1 &&
> +	cat >expected <<-\EOF &&
> +
> +	Signed-off-by: C O Mitter <committer@example.com>
> +	Signed-off-by: C1 E1
> +	Reported-by: C3 E3
> +	Mentored-by: C4 E4
> +	Helped-by: C3 E3
> +	EOF
> +	git -c trailer.ifexists="replace" \
> +		commit --trailer "Mentored-by: C4 E4" \
> +		 --trailer "Helped-by: C3 E3" \
> +		--amend &&
> +	git cat-file commit HEAD >commit.msg &&
> +	sed -e "1,6d" commit.msg >actual &&
> +	test_cmp expected actual

The same comment applies, and also by using "--amend", this relies
on the outcome of the previous test, which is not great.

> +'
> +
> +test_expect_success 'commit --trailer with -c and "add" as ifexists' '
> +	echo "fun" >>file1 &&
> +	git add file1 &&
> +	cat >expected <<-\EOF &&
> +
> +	Signed-off-by: C O Mitter <committer@example.com>
> +	Signed-off-by: C1 E1
> +	Reported-by: C3 E3
> +	Mentored-by: C4 E4
> +	Helped-by: C3 E3
> +	Helped-by: C3 E3
> +	Helped-by: C3 E3
> +	EOF
> +	git -c trailer.ifexists="add" \
> +		commit --trailer "Helped-by: C3 E3" \
> +		--trailer "Helped-by: C3 E3" \
> +		--amend &&

And it makes things worse by keep amending.

At least, establish a baseline commit that has known set of
trailers, tag it, and reset the HEAD to that commit at the beginning
of each test that tries to amend an existing commit.  That way, the
correctness of each individual test would depend only on the test
that creates the baseline commit and tags it.

