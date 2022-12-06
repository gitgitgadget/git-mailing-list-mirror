Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E58C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 11:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiLFLgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 06:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiLFLgo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 06:36:44 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C0BE1B
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 03:36:42 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m18so3926855eji.5
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 03:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9gKfXmC9gKQC836zfcpebJa/L39X/yamn1Nvg3xP6Q=;
        b=JJ3Ef4DReVHgkoBg6YHFtDehDzOwC/M0vIXBb4Rhzodf0W8+tkLj03wAT1Z98IuElT
         PB9rIX+7KWwZRfCl9twz7lxMNcEYISPdofRrRyu/W6ElLU3/EIPWzwYOQIot4/7FtlVU
         VMz35W5NNB8BT7fkRzkguxmh+1OC0SgWvLxdeLh5t5M6HN97hebGYXzIRil2wzPFVJEk
         dimxVRIFZkK6DQbqIXugrhFcqpbG1ajRX5T0xoex6aMlsfP3i58p+SqMdFAHqtnb23FV
         A8gF7pNQFd4chOlXD7WVUQVtacZPrkHbOXi7+zUBtH+cOnX9IpSOYIdkXiFBAu+VMM3q
         TT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9gKfXmC9gKQC836zfcpebJa/L39X/yamn1Nvg3xP6Q=;
        b=qCt3NHxtqLqWQCHC1TuXHYV0C8DQUJgzKzyolSOSQjC5qdpIHDnTaXhA/J0waagJ53
         X08bMxaDpqNDjRawKTeKko/sg01SMmZj3EIFrYVH4u2CCIY9pRqaWQyklMPAFrjeLYyG
         X3P3SR6SxJQNig50NEmvATMKYpyZO/ehuny1RXpTQieYljwLOsz1JRgKvPU7e9sKuo24
         9c1h2O5ujoIIkENyn+vDOpdODU8mPOec8uOOVT2ZTX/AU3ZOYfpyEJ7EXklnFIRG27Qw
         QYnbqaht+jj2nodF+wyJrndNY09YbUZVxqJhvFbANLfflq1qGdmqsu02V5pFtsNpF+Sc
         rvFg==
X-Gm-Message-State: ANoB5plp6tgxcz50ey9Dy2zioTY4KvH1iPABJnsPMoOn2TogmRAkR9Tw
        h+TVzDNaCl9tTDKDsesCuAU=
X-Google-Smtp-Source: AA0mqf5vg5z3i7ssePdVJhd12ySWe99hQ9TEkaJrBEOeTxyS7rxZXizJnlNWnIyLV9lJOAigd/YRCw==
X-Received: by 2002:a17:906:7f16:b0:7c0:f2cf:8e09 with SMTP id d22-20020a1709067f1600b007c0f2cf8e09mr6999454ejr.257.1670326601317;
        Tue, 06 Dec 2022 03:36:41 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b0077b523d309asm7206141ejf.185.2022.12.06.03.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:36:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2WFc-003qBP-16;
        Tue, 06 Dec 2022 12:36:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH 2/2] attr: add flag `-r|--revisions` to work with revisions
Date:   Tue, 06 Dec 2022 12:27:46 +0100
References: <20221206103736.53909-1-karthik.188@gmail.com>
 <20221206103736.53909-3-karthik.188@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221206103736.53909-3-karthik.188@gmail.com>
Message-ID: <221206.861qpcdarb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Karthik Nayak wrote:

> Git check-attr currently doesn't check the git worktree, it either
> checks the index or the files directly. This means we cannot check the
> attributes for a file against a certain revision.
>
> Add a new flag `--revision`/`-r` which will allow it work with
> revisions. This command will now, instead of checking the files/index,
> try and receive the blob for the given attribute file against the
> provided revision. The flag overrides checking against the index and
> filesystem and also works with bare repositories.
>
> We cannot use the `<rev>:<path>` syntax like the one used in `git show`
> because any non-flag parameter before `--` is treated as an attribute
> and any parameter after `--` is treated as a pathname.
>
> This involves creating a new function `read_attr_from_blob`, which given
> the path reads the blob for the path against the provided revision and
> parses the attributes line by line. This function is plugged into
> `read_attr()` function wherein we go through the different attributes.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> Co-authored-by: toon@iotcl.com
> ---
>  archive.c              |   2 +-
>  attr.c                 | 120 ++++++++++++++++++++++++++++-------------
>  attr.h                 |   7 ++-
>  builtin/check-attr.c   |  25 ++++-----
>  builtin/pack-objects.c |   2 +-
>  convert.c              |   2 +-
>  ll-merge.c             |   4 +-
>  pathspec.c             |   2 +-
>  t/t0003-attributes.sh  |  56 ++++++++++++++++++-
>  userdiff.c             |   2 +-
>  ws.c                   |   2 +-
>  11 files changed, 165 insertions(+), 59 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 941495f5d7..bf64dbdce1 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -120,7 +120,7 @@ static const struct attr_check *get_archive_attrs(struct index_state *istate,
>  	static struct attr_check *check;
>  	if (!check)
>  		check = attr_check_initl("export-ignore", "export-subst", NULL);
> -	git_check_attr(istate, path, check);
> +	git_check_attr(istate, path, check, NULL);
>  	return check;
>  }
>  
> diff --git a/attr.c b/attr.c
> index 42ad6de8c7..42b67a401f 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -11,8 +11,12 @@
>  #include "exec-cmd.h"
>  #include "attr.h"
>  #include "dir.h"
> +#include "git-compat-util.h"

As a rule in this project we include either cache.h at the top, or
git-compat-util.h, and the former includes the latter.

This file already has cache.h at the top, so it won't need this.

> +	if (buf == NULL)

if (!buf)

> +		more = (*ep == '\n');

Nit: parens not needed.

> +	struct object_id oid;
> +	unsigned long sz;
> +	enum object_type type;
> +	void *buf;
> +	struct strbuf sb;
> +
> +	if (object_name == NULL)

Ditto !object_name test.

> +		return NULL;
> +
> +	strbuf_init(&sb, strlen(path) + 1 + strlen(object_name));
> +	strbuf_addstr(&sb, object_name);
> +	strbuf_addstr(&sb, ":");
> +	strbuf_addstr(&sb, path);

Is this really performance sensitive so we need to pre-size this, or
would a simpler:

	struct strbuf sb = STRBUF_INIT;
        strbuf_addf(&sb, "%s:%s", path, object_name);

Do?

> +	} else if (object_name != NULL) {

else if (object_name)

>  void git_check_attr(struct index_state *istate,
> -		    const char *path, struct attr_check *check);
> +					const char *path, struct attr_check *check,
> +					const char *object_name);

This (and possibly other places) seem funnily indented..

>  	if (collect_all) {
> -		git_all_attrs(&the_index, full_path, check);
> +		git_all_attrs(&the_index, full_path, check, object_name);
>  	} else {
> -		git_check_attr(&the_index, full_path, check);
> +		git_check_attr(&the_index, full_path, check, object_name);
>  	}

Earlier you do a get_oid(), shouldn't that be a
repo_get_oid(istate->repo, ...) to be future-proof? I.e. use the repo of
the passed-in index.

I think it'll always be "the_repository" for now, but for an API it
makes sense to hardcode that assumption in fewer places.

> +test_expect_success 'bare repository: with --revision' '
> +	(
> +		cd bare.git &&
> +		(
> +			echo "f	test=f" &&
> +			echo "a/i test=a/i"

You don't need a subshell just to echo a string. You can use {}-braces,
but in this case just:

    printf "%s\n", "f test=f" "a/i test=a/i" | git hash-object .... &&


> +		) | git hash-object -w --stdin > id &&
> +		git update-index --add --cacheinfo 100644 $(cat id) .gitattributes &&

Split the "cat" into a varible, otherwise its failure will be hidden.

> +		git write-tree > id &&

We use ">id" style for redirection, not "> id".

> +		git commit-tree $(cat id) -m "random commit message" > id &&

Ditto..
