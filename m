Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF59C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776A661130
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhFHBoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 21:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhFHBoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 21:44:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0A2C061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 18:42:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mp5-20020a17090b1905b029016dd057935fso4891607pjb.5
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 18:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n5TZv14Ae9l7mLlnG7w9HOGjvT4qsJrQtAKx/EZ6kIg=;
        b=mwWB9MrF5Qu1YjuB/B7+SHjwgTU0Sma7SzCzeR+G4hejSBMUOHDR1TcVGO1FfDA32H
         hgIF4hde1LPOC9iny8dwmeRCq+gUBT0ZrUv5WonwCa3MWqS0NINnslJ+pqqPh3fhfGZD
         vnXPqJI7Jg73LcyubE/BD2nqLRUbs3fO/lkb/0dDeah1PJYbZLmJflAkZQ/Mv5QzaHiq
         htFdqTicWquyfXASRLNpMUkksKEWQSMLpkUlOiL73NJk6EELhi+Uf7nboEfz+T2R6W62
         3mrxMMo9h/BN8kZe9Y5CiwAQonIXQeLx3PYU2IyFSjlXmemue2sIoJwX+1xTtrjNFSRE
         k+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n5TZv14Ae9l7mLlnG7w9HOGjvT4qsJrQtAKx/EZ6kIg=;
        b=S4Z7nud6tPRbsqKTXJ5HALNHJFLCPgS5iatrNBtzoJmJOiF+VIvEPvOSZCvwTVbLoc
         MJ6SSVk4Ojw63TvDg/tHDne+YIUChr7DYInWU0EeXKrDDZ4F444nmaAiH4pDvCEpQDU2
         9ovb5b/HTzwNDrzxOmHEFqos1xfRxAfi6FS4ExefIJugO4vAssDZD3MDpR7B9vme4mjz
         kzNEzujQ4hOlDgJNBpqVsL864ePPP3eODtRtvtBBbEniI7UiVrQH3p+3c8xixIfsjzg9
         XKluCVNgoKtz3Zsx/rrMiCJDvt5KuwTv+8z5RdpPre8/FfYfMzrCdr6qatfNDRieZyba
         Os2A==
X-Gm-Message-State: AOAM5305uC+MHypMuv6vNxKPGiXKSzctI2BAThbOpxCKfCwcvMclbGGM
        0PqX5RbafvWZsRmJ1ISQmsloI25dsTANYQ==
X-Google-Smtp-Source: ABdhPJzcILYRgSK1J+JrGcftLmN8IgMeUpLHRgmhSvHTnD5mcK0rrbFy9FylQ3dJey1GOgq5GkbUmA==
X-Received: by 2002:a17:902:d48f:b029:10a:d4e:7991 with SMTP id c15-20020a170902d48fb029010a0d4e7991mr20879504plg.41.1623116524339;
        Mon, 07 Jun 2021 18:42:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:2096:9338:a9c3:81da])
        by smtp.gmail.com with ESMTPSA id q21sm9473537pfn.81.2021.06.07.18.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:42:03 -0700 (PDT)
Date:   Mon, 7 Jun 2021 18:41:57 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] promisor-remote: teach lazy-fetch in any repo
Message-ID: <YL7K5fuoBPMAYZlu@google.com>
References: <cover.1622580781.git.jonathantanmy@google.com>
 <b70a00b9b06e5142bb95891cfc2faa87d708ef0d.1622580781.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b70a00b9b06e5142bb95891cfc2faa87d708ef0d.1622580781.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 02:34:19PM -0700, Jonathan Tan wrote:
> 
> This is one step towards supporting partial clone submodules.
> 
> Even after this patch, we will still lack partial clone submodules
> support, primarily because a lot of Git code that accesses submodule
> objects does so by adding their object stores as alternates, meaning
> that any lazy fetches that would occur in the submodule would be done
> based on the config of the superproject, not of the submodule. This also
> prevents testing of the functionality in this patch by user-facing
> commands. So for now, test this mechanism using a test helper.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Makefile                      |  1 +
>  object-file.c                 |  7 ++-----
>  promisor-remote.c             | 14 +++++++++-----
>  t/helper/test-partial-clone.c | 34 ++++++++++++++++++++++++++++++++++
>  t/helper/test-tool.c          |  1 +
>  t/helper/test-tool.h          |  1 +
>  t/t0410-partial-clone.sh      | 24 ++++++++++++++++++++++++
>  7 files changed, 72 insertions(+), 10 deletions(-)
>  create mode 100644 t/helper/test-partial-clone.c
> 
> diff --git a/Makefile b/Makefile
> index c3565fc0f8..f6653bcd5e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -725,6 +725,7 @@ TEST_BUILTINS_OBJS += test-oidmap.o
>  TEST_BUILTINS_OBJS += test-online-cpus.o
>  TEST_BUILTINS_OBJS += test-parse-options.o
>  TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
> +TEST_BUILTINS_OBJS += test-partial-clone.o
>  TEST_BUILTINS_OBJS += test-path-utils.o
>  TEST_BUILTINS_OBJS += test-pcre2-config.o
>  TEST_BUILTINS_OBJS += test-pkt-line.o
> diff --git a/object-file.c b/object-file.c
> index f233b440b2..ebf273e9e7 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1570,15 +1570,12 @@ static int do_oid_object_info_extended(struct repository *r,
>  		}
>  
>  		/* Check if it is a missing object */
> -		if (fetch_if_missing && has_promisor_remote() &&
> -		    !already_retried && r == the_repository &&
> +		if (fetch_if_missing && repo_has_promisor_remote(r) &&
> +		    !already_retried &&

So we remove the explicit "if we've got promisors and are operating on
the repo we launched in" and instead ask "if the repo we're operating on
has promisors" - definitely a step towards in-process submodule
happiness :)

>  		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
>  			/*
>  			 * TODO Investigate checking promisor_remote_get_direct()
>  			 * TODO return value and stopping on error here.
> -			 * TODO Pass a repository struct through
> -			 * promisor_remote_get_direct(), such that arbitrary
> -			 * repositories work.
>  			 */
>  			promisor_remote_get_direct(r, real, 1);

And this seems like a stale comment, since I see we were already passing
'r' here. But arbitrary repositories still don't just work, right? Or, I
guess your point was "partial clone + submodules don't just work,
because of the alternates thing" - so maybe this part is OK?

> @@ -150,7 +156,7 @@ static void promisor_remote_init(struct repository *r)
>  		xcalloc(sizeof(*r->promisor_remote_config), 1);
>  	config->promisors_tail = &config->promisors;
>  
> -	git_config(promisor_remote_config, config);
> +	repo_config(r, promisor_remote_config, config);

Should this change have happened when we added 'r' to
promisor_remote_init? If r==the_repository then there's no difference
between these two calls, right?

> diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
> new file mode 100644
> index 0000000000..e7bc7eb21f
> --- /dev/null
> +++ b/t/helper/test-partial-clone.c
> @@ -0,0 +1,34 @@
> +#include "cache.h"
> +#include "test-tool.h"
> +#include "repository.h"
> +#include "object-store.h"
> +
> +static void object_info(const char *gitdir, const char *oid_hex)
> +{
> +	struct repository r;
> +	struct object_id oid;
> +	unsigned long size;
> +	struct object_info oi = {.sizep = &size};
> +	const char *p;
> +
> +	if (repo_init(&r, gitdir, NULL))
> +		die("could not init repo");
> +	if (parse_oid_hex(oid_hex, &oid, &p))
> +		die("could not parse oid");
> +	if (oid_object_info_extended(&r, &oid, &oi, 0))
> +		die("could not obtain object info");
> +	printf("%d\n", (int) size);
> +}
> +
> +int cmd__partial_clone(int argc, const char **argv)
> +{
> +	if (argc < 4)
> +		die("too few arguments");
> +
> +	if (!strcmp(argv[1], "object-info"))
> +		object_info(argv[2], argv[3]);
> +	else
> +		die("invalid argument '%s'", argv[1]);
> +
> +	return 0;
> +}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index c5bd0c6d4c..b21e8f1519 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -46,6 +46,7 @@ static struct test_cmd cmds[] = {
>  	{ "online-cpus", cmd__online_cpus },
>  	{ "parse-options", cmd__parse_options },
>  	{ "parse-pathspec-file", cmd__parse_pathspec_file },
> +	{ "partial-clone", cmd__partial_clone },
>  	{ "path-utils", cmd__path_utils },
>  	{ "pcre2-config", cmd__pcre2_config },
>  	{ "pkt-line", cmd__pkt_line },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index e8069a3b22..f845ced4b3 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -35,6 +35,7 @@ int cmd__oidmap(int argc, const char **argv);
>  int cmd__online_cpus(int argc, const char **argv);
>  int cmd__parse_options(int argc, const char **argv);
>  int cmd__parse_pathspec_file(int argc, const char** argv);
> +int cmd__partial_clone(int argc, const char **argv);
>  int cmd__path_utils(int argc, const char **argv);
>  int cmd__pcre2_config(int argc, const char **argv);
>  int cmd__pkt_line(int argc, const char **argv);
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 584a039b85..e804d267e6 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -604,6 +604,30 @@ test_expect_success 'do not fetch when checking existence of tree we construct o
>  	git -C repo cherry-pick side1
>  '
>  
> +test_expect_success 'lazy-fetch when accessing object not in the_repository' '
> +	rm -rf full partial.git &&
> +	test_create_repo full &&
> +	printf 12345 >full/file.txt &&
> +	git -C full add file.txt &&
> +	git -C full commit -m "first commit" &&
I think there is some test_commit or similar function here that's more
commonly used, right?

> +
> +	test_config -C full uploadpack.allowfilter 1 &&
> +	test_config -C full uploadpack.allowanysha1inwant 1 &&
I wasn't sure what these configs are for, but it looks like .allowfilter
is to allow 'full' to serve as a remote to a partial clone. But what do
you need .allowAnySha1InWant for here? Are we expecting to ask for SHAs
that 'full' doesn't have?

> +	git clone --filter=blob:none --bare "file://$(pwd)/full" partial.git &&
> +	FILE_HASH=$(git hash-object --stdin <full/file.txt) &&
> +
> +	# Sanity check that the file is missing
> +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
> +	grep "[?]$FILE_HASH" out &&
> +
> +	OUT=$(test-tool partial-clone object-info partial.git "$FILE_HASH") &&
> +	test "$OUT" -eq 5 &&

Hm. I guess I am confused about why this fetches the desired object into
partial.git. Maybe the test-helper needs a comment (and maybe here too)
on the line where fetch will be triggered?

> +
> +	# Sanity check that the file is now present
> +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
> +	! grep "[?]$FILE_HASH" out

 - Emily
