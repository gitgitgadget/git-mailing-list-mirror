Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F52CA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 05:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjILFyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 01:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjILFyO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 01:54:14 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43115E73
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 22:54:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26d50941f68so7689119a91.1
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 22:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694498050; x=1695102850; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqfc4tYa0BbkKf5fsN/u0ujeH/LK35wZnMITuJPe3UQ=;
        b=nWQBW4L21hIDJUotOi46PIYlNSqbR64aJ3bnKnUZkSQarWMjhU/QK5A9oMl8OuSq2+
         /GVEwyHgstYXrSazk4lVeYKjEAGExV4ZYJqzZkk5QBnYdeCWQNRSnMUJSgWWcDsFpSP9
         JlXFM0ukcN7p24y3YFyh1pnNOXqxT6+NWZygC/wTFoCNSMKl8NEiIypVyOYwirPUP2bh
         Ao3eAaPi8gZ1ktGBjEVX36sCOT1gCqaiuQG0rNnFVd/10/wUVnAgfOsITxGjI9yc1Z61
         FAIZ6gy8DyWbTG+sdpbYYVNsaSQ/xHoRB6UY4Ew5KavilSundx5v7UFrH0rmX3A9Nmau
         qMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694498050; x=1695102850;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqfc4tYa0BbkKf5fsN/u0ujeH/LK35wZnMITuJPe3UQ=;
        b=fNYoF7Yi2O8YdA5mWD+Fke3HTZLt6o8IiWsxEXq9kMS3QhvF6PTwnJvzrxBrPaFQIL
         EH9IPj/TMciWO13e1Ofs1pIYA9rAs2hPyIsq2JtxJgaBp2iOmqL7ZwfL3P/aH3/d3U+p
         jnfUOMLx4FYv3WgpTQmdRq1pawdwnaEP7K8q3mATB1FKPjK6yFZpbTIxnVblsXWE/LKX
         31QsdqFGs2RCCZvRTfQQQ3OHk8qtRF9k5FDBMH+46mbfNjbsuvC/6t85fqC4MEpHwUFA
         bgrzg7qWWtZXkiy6hkvVj5gAFCJpmtP37/v/byn7IjfGWNga8J6XgMRJMhxDCSQMyhgA
         JuAA==
X-Gm-Message-State: AOJu0YzczDeWO/pOa3iNnTh5coxAODSuOrQbT70I7nDnpoHPmwFJBOnC
        IHXrurzwcK9yJjw8qiKVSEF9/3/1Y6M=
X-Google-Smtp-Source: AGHT+IHQTiJ87N6cb918sKPf8yuFsKqPxydamXE7VbuZKhhIATz8lsM9mveJZSXLME5rI5ePmrPSjLbzEOw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:f689:b0:1c3:c127:537 with SMTP id
 l9-20020a170902f68900b001c3c1270537mr1487593plg.12.1694498049769; Mon, 11 Sep
 2023 22:54:09 -0700 (PDT)
Date:   Mon, 11 Sep 2023 22:54:08 -0700
In-Reply-To: <20230818233729.2766281-3-gitster@pobox.com>
Mime-Version: 1.0
References: <20230818233729.2766281-1-gitster@pobox.com> <20230818233729.2766281-3-gitster@pobox.com>
Message-ID: <owlybke8kkcf.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 2/3] update-index: add --show-index-version
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "git update-index --version N" is used to set the index format

s/--version/--index-version

> version to a specific version, but there was no way to query the
> current version used in the on-disk index file.
>
> Teach the command a new "--show-index-version" option, and also
> teach the "--index-version N" option to report what the version was
> when run with the "--verbose" option.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-update-index.txt |  6 +++++-
>  builtin/update-index.c             | 19 +++++++++++++------
>  t/t2107-update-index-basic.sh      | 16 ++++++++++++++++
>  3 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index a367f8d65a..3f204891ce 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -162,7 +162,8 @@ you will need to handle the situation manually.
>  	Write the resulting index out in the named on-disk format version.
>  	Supported versions are 2, 3 and 4. The current default version is 2
>  	or 3, depending on whether extra features are used, such as
> -	`git add -N`.
> +	`git add -N`.  With `--verbose` option, also reports the

How about

    `git add -N`.  With `--verbose`, also report the

> +	version the index file uses before and after this command.
>  +
>  Version 4 performs a simple pathname compression that reduces index
>  size by 30%-50% on large repositories, which results in faster load
> @@ -171,6 +172,9 @@ and support for it was added to libgit2 in 2016 and to JGit in 2020.
>  Older editions of this manual page called it "relatively young", but
>  it should be considered mature technology these days.
>
> +--show-index-version::
> +	Report the index format version used by the on-disk index file.
> +	See `--index-version` above.

Looks good.

>  -z::
>  	Only meaningful with `--stdin` or `--index-info`; paths are
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 5fab9ad2ec..e713e2a04c 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1089,6 +1089,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  			resolve_undo_clear_callback),
>  		OPT_INTEGER(0, "index-version", &preferred_index_format,
>  			N_("write index in this format")),
> +		OPT_SET_INT(0, "show-index-version", &preferred_index_format,
> +			    N_("show index format version"), -1),

How about

    "show on-disk index format version"

for the help text? Also "report" may be preferable instead of "show" for
consistency with the manpage.

Also, I think it would be easier to read if we didn't overload
preferred_index_format here and instead used a new variable (perhaps named
"show_index_format").

And I just realized that we are now using not only "show" and "report"
interchangeably in this patch, but also "format" and "version" ---
it would be nice to clean up as #leftoverbits.

>  		OPT_BOOL(0, "split-index", &split_index,
>  			N_("enable or disable split index")),
>  		OPT_BOOL(0, "untracked-cache", &untracked_cache,
> @@ -1181,15 +1183,20 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>
>  	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
>  	if (preferred_index_format) {
> -		if (preferred_index_format < INDEX_FORMAT_LB ||
> -		    INDEX_FORMAT_UB < preferred_index_format)
> +		if (preferred_index_format < 0) {
> +			printf(_("%d\n"), the_index.version);
> +		} else if (preferred_index_format < INDEX_FORMAT_LB ||
> +			   INDEX_FORMAT_UB < preferred_index_format) {
>  			die("index-version %d not in range: %d..%d",
>  			    preferred_index_format,
>  			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
> -
> -		if (the_index.version != preferred_index_format)
> -			the_index.cache_changed |= SOMETHING_CHANGED;
> -		the_index.version = preferred_index_format;
> +		} else {
> +			if (the_index.version != preferred_index_format)
> +				the_index.cache_changed |= SOMETHING_CHANGED;
> +			report(_("index-version: was %d, set to %d"),
> +			       the_index.version, preferred_index_format);
> +			the_index.version = preferred_index_format;
> +		}
>  	}

Looks good. But if you decide to use a new variable like
"show_index_format" as suggested above, you might want to refactor this
out to a separate function. Then you could obviously do away with the
chained if/else and replace them with early returns, which would be
easier to read.

>  	if (read_from_stdin) {
> diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
> index 89b285fa3a..c78d1e9396 100755
> --- a/t/t2107-update-index-basic.sh
> +++ b/t/t2107-update-index-basic.sh
> @@ -111,4 +111,20 @@ test_expect_success '--chmod=+x and chmod=-x in the same argument list' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success '--index-version' '
> +	git commit --allow-empty -m snap &&
> +	git reset --hard &&

Not sure why this "git reset --hard" is needed here --- is it to clear
out state from previous test cases? If so, perhaps it's better to run
this as the very first command in this test case?

But this also makes me wonder why "git commit --allow-empty -m snap" is
even necessary (if we already have a git repo)?

> +	git update-index --index-version 2 >actual &&
> +	test_must_be_empty actual &&

Before we do "--index-version 2", it may be desirable to run the
"--show-index-version" flag first to see what we have before modifying
it with "2".

> +	git update-index --show-index-version >actual &&
> +	echo 2 >expect &&
> +	test_cmp expect actual &&
> +
> +	git update-index --index-version 4 --verbose >actual &&
> +	echo "index-version: was 2, set to 4" >expect &&
> +	test_cmp expect actual
> +'

How about adding this check below to check what happens if the newly-set
version is the same as the existing version?

        git update-index --index-version 4 --verbose >actual &&
        echo "index-version: was 4, set to 4" >expect &&
        test_cmp expect actual

And also how about a similar check, but for downgrading from a higher
version number to a lower one?

        git update-index --index-version 2 --verbose >actual &&
        echo "index-version: was 4, set to 2" >expect &&
        test_cmp expect actual

> +
>  test_done
> --
> 2.42.0-rc2-7-gf9972720e9
