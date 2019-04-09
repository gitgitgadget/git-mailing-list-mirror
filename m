Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E849B20248
	for <e@80x24.org>; Tue,  9 Apr 2019 11:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDILby (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 07:31:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34746 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfDILby (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 07:31:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so20455944wrq.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 04:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NN95/LuO9/fawkJnVvHyrV/XK+jp8urGXBqBRw6hud8=;
        b=Q2ktZ7xkTH1+YLY5EZkylUgd5XK6lhoGU9TA6wi+fkB51onRJrt3uchUoAiDy81AcZ
         BnHxINHP/uc4nlNIDzIfxoXvMuCivarj/wUlJe1lDSSOoE5P7o9qJ4bMZrkJes+wB/Cg
         ve5fG3G/yirHG1eSrkHmSgCQY7KbM4ahlh76BVJat2DZCQUJxjNhRA0KrwdtlwHpnAfM
         ebl6YeKUzZcPt+/3g/YmDcK+cJGC5FjAsKWNf0Ocsj2gtBLJR7xVsNH1tzSVRDfIKGS7
         SGqI2pu7iP42jVf8oWQR7Y3MRnu8zj5JegDyz7Wbj/Zjcj3yh4tjXhxS0jZk5npZoimh
         f6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=NN95/LuO9/fawkJnVvHyrV/XK+jp8urGXBqBRw6hud8=;
        b=OquJRLNwndYPRGqDDVGUs2zqVX7cgKmS17+jbXCuODXKi6NN75vWTuetEijHe2LW+g
         ySdQtgWS6mwBfkMd7id85vCSfFrmaElUu23pZY24ipAnGWebVnvPKIrz4H7zEQYFs1io
         bRIcpcvnf7HO/uuursm8bfkv4bPWtgRVhhQ3YZGqBN7dFRJwBxaOdmq3nbBXRboD7akI
         hSS8C2ro75/lo0lIKG4LEqdf+LEHlwcyIy6cFoxtFq5h3Rqusbl+s9aiIO+VcNvA3QRd
         ifgZgKghqxnIxO+tK+Hug61xB1VpmcQWU7MD0/5trd+RNjKxoIMBG0umHODGgPvHtrs/
         h9XQ==
X-Gm-Message-State: APjAAAV8zKThPDljVMmiLJVXmpJLnCajBhP/s9YRLejD12mEyeTySONO
        cXciXMVF08/WTpebw2Ebdng=
X-Google-Smtp-Source: APXvYqwAiFZ2unikxG2P6Ojk0sY3NZ2IhxyqmO+8TcPPwxihjoOI7IQiMVRE8klaZ6C0qf43t5DOKA==
X-Received: by 2002:adf:b612:: with SMTP id f18mr11285036wre.236.1554809511624;
        Tue, 09 Apr 2019 04:31:51 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y1sm95237331wrd.34.2019.04.09.04.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 04:31:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] Introduce "precious" file concept
References: <xmqqimvpb0bd.fsf@gitster-ct.c.googlers.com>
        <20190409102649.22115-1-pclouds@gmail.com>
Date:   Tue, 09 Apr 2019 20:31:50 +0900
In-Reply-To: <20190409102649.22115-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 9 Apr 2019 17:26:49 +0700")
Message-ID: <xmqqh8b75s9l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> A new attribute "precious" is added to indicate that certain files
> have valuable content and should not be easily discarded even if they
> are ignored or untracked.
>
> So far there are one part of Git that are made aware of precious files:

s/are/is/g

> "git clean" will leave precious files alone if --keep-precious is
> specified.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Here's the replacement patch that keeps "git clean" behavior the same
>  as before and only checks 'precious' attribute when --keep-precous is
>  specified.

OK.  So this is even gentler introduction, which we could turn into
the default once more commands start honoring the attribute and
wider adoption proves that it is a good feature, while allowing us a
room to back out by keeping it an optional feature and eventually
deprecate and remove if the experiment did not pan out.

> +--keep-precious::
> +	Do not remove untracked or ignored files if they have
> +	`precious` attribute.

> +Precious files
> +~~~~~~~~~~~~~~
> +
> +`precious`
> +^^^^^^^^^^
> +
> +This attribute is set on files to indicate that their content is
> +valuable. Some commands will behave slightly different on precious
> +files. linkgit:git-clean[1] may leave precious files alone.


When the second thing that cares about the attribute comes along,
the mention of 'git clean' here will become the first item in a
bullet list, while the second and subsequent ones are listed next to
it.  It may not be bad to start that enumerated list of count 1 from
the get-go, but for now this will do.

> @@ -193,9 +203,16 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
>  
>  		strbuf_setlen(path, len);
>  		strbuf_addstr(path, e->d_name);
> -		if (lstat(path->buf, &st))
> +		if (lstat(path->buf, &st)) {
>  			; /* fall thru */
> -		else if (S_ISDIR(st.st_mode)) {
> +		} else if ((!prefix && skip_precious_file(&the_index, path->buf)) ||
> +			   (prefix && skip_prefix(path->buf, prefix, &rel_path) &&
> +			    skip_precious_file(&the_index, rel_path))) {
> +			quote_path_relative(path->buf, prefix, &quoted);
> +			printf(dry_run ? _(msg_would_skip_precious) : _(msg_skip_precious), quoted.buf);
> +			*dir_gone = 0;
> +			continue;

An attribute is given to something that can be tracked, and a
directory would not get an attribute, because Git does not track
directories (there is a reason why skip_precious_file() takes
&the_index that is passed down the callchain to git_check_attr()).

Triggering this logic before excluding S_ISDIR(st.st_mode) feels
iffy.

But let's assume that being able to say "this directory and anything
(recursively) inside are precious" is a good idea and read on.

> +		} else if (S_ISDIR(st.st_mode)) {
>  			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
>  				ret = 1;
>  			if (gone) {
> @@ -915,6 +932,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL('x', NULL, &ignored, N_("remove ignored files, too")),
>  		OPT_BOOL('X', NULL, &ignored_only,
>  				N_("remove only ignored files")),
> +		OPT_BOOL(0, "keep-precious", &keep_precious,
> +			 N_("do not remove files with 'precious' attribute")),
>  		OPT_END()
>  	};

OK.

> @@ -1019,7 +1038,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		if (lstat(abs_path.buf, &st))
>  			continue;
>  
> -		if (S_ISDIR(st.st_mode)) {
> +		if (skip_precious_file(&the_index, item->string)) {
> +			qname = quote_path_relative(item->string, NULL, &buf);
> +			printf(dry_run ? _(msg_would_skip_precious) : _(msg_skip_precious), qname);
> +		} else if (S_ISDIR(st.st_mode)) {
>  			if (remove_dirs(&abs_path, prefix, rm_flags, dry_run, quiet, &gone))

Likewise.

> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 7b36954d63..ae600dafb5 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -669,4 +669,44 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
>  	test_path_is_missing foo/b/bb
>  '
>  
> +test_expect_success 'git clean -xd --keep-precious leaves precious files alone' '
> +	git init precious &&
> +	(
> +		cd precious &&
> +		test_commit one &&
> +		cat >.gitignore <<-\EOF &&
> +		*.o
> +		*.mak
> +		EOF
> +		cat >.gitattributes <<-\EOF &&
> +		*.mak precious
> +		.gitattributes precious
> +		*.precious precious

If the checking with skip_precious() before S_ISDIR() was
intentional (I cannot quite tell if it is), then this should also
have a pattern that matches a directory and mark it as precious.

On the other hand, if it was merely a thinko and the change does not
intend to allow attaching attributes to directories, then this test
is probably OK as-is.  We also _could_ have a pattern that matches a
directory and attempt to make it precious and then make sure the
directory goes away (i.e. any attribute, including 'precious', on
the directory was meaningless).

> +		EOF
> +		mkdir sub &&
> +		touch one.o sub/two.o one.mak sub/two.mak &&
> +		touch one.untracked two.precious sub/also.precious &&
> +		git clean -fdx --keep-precious &&
> +		test_path_is_missing one.o &&
> +		test_path_is_missing sub/two.o &&
> +		test_path_is_missing one.untracked &&
> +		test_path_is_file .gitattributes &&
> +		test_path_is_file one.mak &&
> +		test_path_is_file sub/two.mak &&
> +		test_path_is_file two.precious &&
> +		test_path_is_file sub/also.precious
> +	)
> +'

> +test_expect_success 'git clean -xd still deletes them all' '

OK, so this is exactly the same command as above, but without the
"--keep-precious" option.  It is good to test both positive and
negative.

> +	test_path_is_file precious/one.mak &&
> +	test_path_is_file precious/sub/two.mak &&
> +	test_path_is_file precious/two.precious &&
> +	test_path_is_file precious/sub/also.precious &&
> +	git -C precious clean -fdx &&
> +	test_path_is_missing precious/one.mak &&
> +	test_path_is_missing precious/sub/two.mak &&
> +	test_path_is_missing precious/two.precious &&
> +	test_path_is_missing precious/sub/also.precious
> +'
