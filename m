Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2134DC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 20:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiLUU5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 15:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUU5i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 15:57:38 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2560664F2
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 12:57:37 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg10so50118wmb.1
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 12:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VYkM8wyhYVrIpfOPw9AtgWWcyCK3oq8QNngLVXnR6A=;
        b=dhuYZEll1DZKtrUqE9xYRV/rbsJyxp5y9wrJdc5ccTyI18rLKlJ+ureNWA6t6n+RJf
         t/WaSkNjq6XHbzdeQ8tTPjRNfvfaGlhKavSJHLF5Reziqpy9jbj4PHqoHkYSODhPXHHJ
         BA4d1h/bVIoQsYYfGsgQFMkmGGyYBpNesUpTRz1tWH/178OSOBQM1Lz8UMOvj6n5xNDj
         ooFMNbgZyqu5CITvInAtu0NOomFbTp6ALw02OJckyxo0qVp/GPUDzY/Ze+ptcHwv5UzR
         Kjl2zby1nGVIkT14t40z+pM3zdUDMsvJEPD8Yy7RsnNS5rmjX9/Lx4QM26gXR2daEvqN
         xHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VYkM8wyhYVrIpfOPw9AtgWWcyCK3oq8QNngLVXnR6A=;
        b=BgxBmNWjekL2MCqL8MGdh0a4kjq4XzyGeYOQbz7coaGGXKoBEmhRZU7V1/odITMNFU
         2iE/n73XUA15VlSVOFYWGukkB/YOLknZJdvarsbj0hsIg5F+hW9beyx48wA79mbeAFB1
         6iVA8TouDNBmLnYkKJ8OLdkUXoXzaBWBxAcVQHqMXep9HukVhJCjiDxjpjyr/X59pEEq
         yJILK/1M93RilcACj9+ghISyZOaUKrEOg5R7FY5y0+uBIPWah6Stss8Z8kSv2c0NWzbt
         7nZMqIjUS88ND7mrAweXcJNs00jEJVLyBi8GrjLlg3S0dOTMdccP59UfmFupKqLN367p
         NE3w==
X-Gm-Message-State: AFqh2kryccK+HgUNvhV+ULlVBWRMa4cX1CfdEJI5UMBfQq+UNNZU1e/M
        A0u1k2jvN2QtqcgOsCFgWoI=
X-Google-Smtp-Source: AMrXdXszSJA0IJriHrHwoZXfryP89c/1Lq3hqIBYE98MBsfo3slvEVSlQF5hHqrfYLWa+o6ZYEfrGQ==
X-Received: by 2002:a05:600c:a4a:b0:3d3:3d1b:6354 with SMTP id c10-20020a05600c0a4a00b003d33d1b6354mr2416727wmq.3.1671656255465;
        Wed, 21 Dec 2022 12:57:35 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b003b4cba4ef71sm3779360wmb.41.2022.12.21.12.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 12:57:35 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <cc2e5f1e-8f53-ad83-1f5d-ae910ab60c53@dunelm.org.uk>
Date:   Wed, 21 Dec 2022 20:57:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] attr: add flag `--revision` to work with revisions
To:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc:     Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
References: <https://lore.kernel.org/git/20221216093552.3171319-1-karthik.188@gmail.com/>
 <cover.1671630304.git.karthik.188@gmail.com>
 <a161dbdf8b70354716d0bfeccc707c242c7f33a1.1671630304.git.karthik.188@gmail.com>
Content-Language: en-US
In-Reply-To: <a161dbdf8b70354716d0bfeccc707c242c7f33a1.1671630304.git.karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Karthik

On 21/12/2022 13:47, Karthik Nayak wrote:
> The contents of the .gitattributes files may evolve over time, but "git
> check-attr" always checks attributes against them in the working tree
> and/or in the index. It may be beneficial to optionally allow the users
> to check attributes taken from a commit other than HEAD against paths.
> 
> Add a new flag `--revision` which will allow users to check the
> attributes against a commit (actually any tree-ish would do). When the
> user uses this flag, we go through the stack of .gitattributes files but
> instead of checking the current working tree and/or in the index, we
> check the blobs from the provided tree-ish object. This allows the
> command to also be used in bare repositories.
> 
> Since we use a tree-ish object, the user can pass "--revision
> HEAD:subdirectory" and all the attributes will be looked up as if
> subdirectory was the root directory of the repository.

We should be clear in the documentation and option help that --revision 
takes a tree-ish (i.e. --revision=<tree-ish>). Maybe calling the option 
--tree would be clearer.

> We cannot simply use the `<rev>:<path>` syntax without the `--revision`
> flag, similar to how it is used in `git show` because any non-flag
> parameter before `--` is treated as an attribute and any parameter after
> `--` is treated as a pathname.
> 
> The change involves creating a new function `read_attr_from_blob`, which
> given the path reads the blob for the path against the provided revision and
> parses the attributes line by line. This function is plugged into
> `read_attr()` function wherein we go through the stack of attributes
> files.

The implementation looks good apart from failing to bail out if it 
cannot parse the argument to --revision (perhaps we should add a test 
for that). I've left a few suggestions below.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> Co-authored-by: toon@iotcl.com

> diff --git a/attr.c b/attr.c
> index 42ad6de8c7..6c69e82080 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -11,8 +11,12 @@
>   #include "exec-cmd.h"
>   #include "attr.h"
>   #include "dir.h"
> +#include "strbuf.h"
> +#include "tree-walk.h"

These new includes are not required.

 > diff --git a/attr.h b/attr.h
 > index 3fb40cced0..f4a2bedd68 100644
 > --- a/attr.h
 > +++ b/attr.h
 > @@ -1,6 +1,8 @@
 >  #ifndef ATTR_H
 >  #define ATTR_H
 >
 > +#include "hash.h"

This include is not required.

> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> index 0fef10eb6b..04640e0297 100644
> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -1,3 +1,4 @@
> +#include "repository.h"

This include is not required. Also please add any new includes below 
cache.h as Junio has previously mentioned.

>   #define USE_THE_INDEX_VARIABLE
>   #include "builtin.h"
>   #include "cache.h"
> @@ -9,9 +10,10 @@
>   static int all_attrs;
>   static int cached_attrs;
>   static int stdin_paths;
> +static char *revision;
>   static const char * const check_attr_usage[] = {
> -N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
> -N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
> +N_("git check-attr [--revision <revision>] [-a | --all | <attr>...] [--] <pathname>..."),
> +N_("git check-attr --stdin [-z] [--revision <revision>] [-a | --all | <attr>...]"),
>   NULL
>   };
>   
> @@ -23,6 +25,7 @@ static const struct option check_attr_options[] = {
>   	OPT_BOOL(0 , "stdin", &stdin_paths, N_("read file names from stdin")),
>   	OPT_BOOL('z', NULL, &nul_term_line,
>   		 N_("terminate input and output records by a NUL character")),
> +	OPT_STRING(0, "revision", &revision, N_("revision"), N_("check attributes at this revision")),
>   	OPT_END()
>   };

> +	if (revision) {
> +		tree_oid = xmalloc(sizeof(struct object_id));

I think we prefer 'var = xmalloc(sizeof(*var));' to avoid errors if the 
type of var changes. This allocation does not appear to be freed 
anywhere. We could avoid the allocation by delcaring an automatic 
variable above and setting tree_oid to point to it here.

> +		if (repo_get_oid_tree(the_repository, revision, tree_oid))
> +			error("%s: not a valid revision", revision);

We should die() here rather than continuing with a bad tree.

> +	}
> +
>   	if (stdin_paths)
> -		check_attr_stdin_paths(prefix, check, all_attrs);
> +		check_attr_stdin_paths(prefix, check, tree_oid, all_attrs);
>   	else {
>   		for (i = filei; i < argc; i++)
> -			check_attr(prefix, check, all_attrs, argv[i]);
> +			check_attr(prefix, check, tree_oid, all_attrs, argv[i]);
>   		maybe_flush_or_die(stdout, "attribute to stdout");
>   	}
> [...]
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index b3aabb8aa3..6e6a909a46 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -25,7 +25,14 @@ attr_check_quote () {
>   	git check-attr test -- "$path" >actual &&
>   	echo "\"$quoted_path\": test: $expect" >expect &&
>   	test_cmp expect actual
> +}
> +
> +attr_check_revision () {
> +	path="$1" expect="$2" revision="$3" git_opts="$4" &&

Is that line valid posix shell? I know it works with local (which is not 
in posix) but is it allowed for global variables?

> +	git $git_opts check-attr --revision $revision test -- "$path" >actual 2>err &&

err is never used. Should we be doing 'test_must_be_empty err'?

> +	echo "$path: test: $expect" >expect &&
> +	test_cmp expect actual
>   }
>   
> [...]   
> +test_expect_success 'setup branches' '
> +	(
> +		echo "f	test=f" &&
> +		echo "a/i test=n"
> +	) 

We'd normally write this as

	test_write_lines "f test=f" "a/i test=n" | git hash-object ...

However I think it would be simpler to create the commit with something like

mkdir -p foo/bar &&
test_commit --printf "add .gitattributes" foo/bar/.gitattributes \
	"t test=f\na/i test=n\n" tag-1 &&
rm -r foo/bar/.gitattributes

which would also reduce the number of processes. Failing that a helper 
function to reduce the duplication would be a good idea.

| git hash-object -w --stdin >id &&
> +	git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
> +	git write-tree >id &&
> +	tree_id=$(cat id) &&

For future reference it is perfectly fine to write
	tree_oid=$(git write-tree) &&

as we will still detect a non-zero exit code from git.

> +	git commit-tree $tree_id -m "random commit message" >id &&
> +	commit_id=$(cat id) &&
> +	git update-ref refs/heads/branch1 $commit_id &&
> +
> +	(
> +		echo "g test=g" &&
> +		echo "a/i test=m"
> +	) | git hash-object -w --stdin >id &&
> +	git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
> +	git write-tree >id &&
> +	tree_id=$(cat id) &&
> +	git commit-tree $tree_id -m "random commit message" >id &&
> +	commit_id=$(cat id) &&
> +	git update-ref refs/heads/branch2 $commit_id
> +'
> [...]
>   test_expect_success 'setup bare' '
>   	git clone --template= --bare . bare.git
>   '
> @@ -306,6 +347,27 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
>   	)
>   '
>   
> +test_expect_success 'bare repository: with --revision' '
> +	(
> +		cd bare.git &&

You could create a bare clone of the existing repo rather than having to 
recreate the commits here.

Best Wishes

Phillip
