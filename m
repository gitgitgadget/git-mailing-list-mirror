Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B5CC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 15:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D88520781
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 15:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC6VE+q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405601AbgFYPQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405309AbgFYPQr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 11:16:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6E2C08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 08:16:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so6253950wrm.4
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 08:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CokIFQxbtQJ5+tuUj3viWlwJdYfq8sncWJMv3BWMGyk=;
        b=PC6VE+q+CCkMWz1DnhRzsjG14j8rDX0UqC8eTq3dBk+iFm0tQIG4sP5+bldOGKwazJ
         TnC5Eb+z0XmwEG3A+8wLkJ8z41yjmAfrQtXcuvlIuvJixbLBpEV6YiGLVn8zKEqFwosm
         wSSL6MHEH3AelLzCCVubDS1ohVFVa+AaHG1PuVg4MwFU8w7EnmQ5vXoOM8WJW8uZWYcQ
         GAhTcZz8ty1xl+WDu/0oA7BMYTYsRk9SSANh0bZcxAPRbg8uzvDSzIkNIt+yHiUhg+6e
         fEoydRHjcMblCrL2Er+k1R/EEuENPI8DQvzUiiN4N2J7G5lIjCKtn4ChwCHOnyD1fITi
         E9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CokIFQxbtQJ5+tuUj3viWlwJdYfq8sncWJMv3BWMGyk=;
        b=dJ6fpBpUEu2cYEvzrRm+RbuXo6cFsykkKzLlEYB6ImNgML2LnbtC2EhPrPaZHoZmtR
         Tr78ZWT6aGDX/SCtifV9vMdWpPcmYLy7/n1X7ghSWfhDeOwfulUHKlIVfT23gplW1kgj
         ifmNAt+ZV8Sgvgm1QpmqUxWBdT+6/J6ScNGggzN91Le6f/7GFLx+IPmp3M+JcVvuAVvO
         j3TKwCXquAv7+Dm295pT//m0sCkvItpShSyRu3FluLqm5gnYvyCAJuLyS2exLYHpDTq8
         SehVJxw+gYfaw61XMITURcly7pJlWwPc5hsmySDOUKNcN3RlX/KFiMQesfaIVKS2Y0ck
         R7Iw==
X-Gm-Message-State: AOAM533rj0HGJ0sDGLzmcY15Gm6VsSxrFSIFgeSMISElfWxRrQSdnKh7
        TaMuWnv6Bq8rD00foVFv8QAKgHr7
X-Google-Smtp-Source: ABdhPJzUsOOZx83Hx2nSskQ5uaBYFIDWiDtuQN5JHtU5Nch2zhaQxzjxrY4CXK8McnKYJFDw2Gj0lw==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr35739810wrs.235.1593098205193;
        Thu, 25 Jun 2020 08:16:45 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id o7sm11147269wmb.9.2020.06.25.08.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 08:16:44 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v1 02/17] merge-one-file: rewrite in C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200625121953.16991-3-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <80af2da7-d943-94ef-999a-7035bbec0f0d@gmail.com>
Date:   Thu, 25 Jun 2020 16:16:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625121953.16991-3-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

I think this series is a great idea

On 25/06/2020 13:19, Alban Gruin wrote:
> This rewrites `git merge-one-file' from shell to C.  This port is very
> straightforward: it keeps using external processes to edit the index,
> for instance.  Errors are also displayed with fprintf() instead of
> error().  Both of these will be addressed in the next few commits,
> leading to its libification so its main function can be used from other
> commands directly.
> 
> This also fixes a bug present in the original script: instead of
> checking if a _regular_ file exists when a file exists in the branch to
> merge, but not in our branch, the rewritten version checks if a file of
> any kind (ie. a directory, ...) exists.  This fixes the tests t6035.14,
> where the branch to merge had a new file, `a/b', but our branch had a
> directory there; it should have failed because a directory exists, but
> it did not because there was no regular file called `a/b'.  This test is
> now marked as successful.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   Makefile                        |   2 +-
>   builtin.h                       |   1 +
>   builtin/merge-one-file.c        | 275 ++++++++++++++++++++++++++++++++
>   git-merge-one-file.sh           | 167 -------------------
>   git.c                           |   1 +
>   t/t6035-merge-dir-to-symlink.sh |   2 +-
>   6 files changed, 279 insertions(+), 169 deletions(-)
>   create mode 100644 builtin/merge-one-file.c
>   delete mode 100755 git-merge-one-file.sh
> 
> diff --git a/Makefile b/Makefile
> index 372139f1f2..19574f5133 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -596,7 +596,6 @@ SCRIPT_SH += git-bisect.sh
>   SCRIPT_SH += git-difftool--helper.sh
>   SCRIPT_SH += git-filter-branch.sh
>   SCRIPT_SH += git-merge-octopus.sh
> -SCRIPT_SH += git-merge-one-file.sh
>   SCRIPT_SH += git-merge-resolve.sh
>   SCRIPT_SH += git-mergetool.sh
>   SCRIPT_SH += git-quiltimport.sh
> @@ -1089,6 +1088,7 @@ BUILTIN_OBJS += builtin/mailsplit.o
>   BUILTIN_OBJS += builtin/merge-base.o
>   BUILTIN_OBJS += builtin/merge-file.o
>   BUILTIN_OBJS += builtin/merge-index.o
> +BUILTIN_OBJS += builtin/merge-one-file.o
>   BUILTIN_OBJS += builtin/merge-ours.o
>   BUILTIN_OBJS += builtin/merge-recursive.o
>   BUILTIN_OBJS += builtin/merge-tree.o
> diff --git a/builtin.h b/builtin.h
> index a5ae15bfe5..9205d5ecdc 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -172,6 +172,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix);
>   int cmd_merge_index(int argc, const char **argv, const char *prefix);
>   int cmd_merge_ours(int argc, const char **argv, const char *prefix);
>   int cmd_merge_file(int argc, const char **argv, const char *prefix);
> +int cmd_merge_one_file(int argc, const char **argv, const char *prefix);
>   int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
>   int cmd_merge_tree(int argc, const char **argv, const char *prefix);
>   int cmd_mktag(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
> new file mode 100644
> index 0000000000..4992a6cd30
> --- /dev/null
> +++ b/builtin/merge-one-file.c
> @@ -0,0 +1,275 @@
> +/*
> + * Builtin "git merge-one-file"
> + *
> + * Copyright (c) 2020 Alban Gruin
> + *
> + * Based on git-merge-one-file.sh, written by Linus Torvalds.
> + *
> + * This is the git per-file merge script, called with
> + *
> + *   $1 - original file SHA1 (or empty)
> + *   $2 - file in branch1 SHA1 (or empty)
> + *   $3 - file in branch2 SHA1 (or empty)
> + *   $4 - pathname in repository
> + *   $5 - original file mode (or empty)
> + *   $6 - file in branch1 mode (or empty)
> + *   $7 - file in branch2 mode (or empty)

nit pick - these are now argv[1] etc rather than $1 etc

> + *
> + * Handle some trivial cases.. The _really_ trivial cases have
> + * been handled already by git read-tree, but that one doesn't
> + * do any merges that might change the tree layout.
> + */
> +
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
> +#include "cache.h"
> +#include "builtin.h"
> +#include "commit.h"
> +#include "dir.h"
> +#include "lockfile.h"
> +#include "object-store.h"
> +#include "run-command.h"
> +#include "xdiff-interface.h"
> +
> +static int create_temp_file(const struct object_id *oid, struct strbuf *path)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf err = STRBUF_INIT;
> +	int ret;
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "unpack-file", oid_to_hex(oid), NULL);
> +	ret = pipe_command(&cp, NULL, 0, path, 0, &err, 0);
> +	if (!ret && path->len > 0)
> +		strbuf_trim_trailing_newline(path);
> +
> +	fprintf(stderr, "%.*s", (int) err.len, err.buf);
> +	strbuf_release(&err);
> +
> +	return ret;
> +}

I know others will disagree but personally I'm not a huge fan of 
rewriting shell functions in C that forks other builtins and then 
converting the C to use the internal apis, it seems a much better to 
just write the proper C version the first time. This is especially true 
for simple function such as the ones in this file. That way the reviewer 
gets a clear view of the final code from the patch, rather than having 
to piece it together from a series of additions and deletions.

> +
> +static int add_to_index_cacheinfo(unsigned int mode,
> +				  const struct object_id *oid, const char *path)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "update-index", "--add", "--cacheinfo", NULL);
> +	argv_array_pushf(&cp.args, "%o,%s,%s", mode, oid_to_hex(oid), path);
> +	return run_command(&cp);
> +}
> +
> +static int remove_from_index(const char *path)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "update-index", "--remove", "--", path, NULL);
> +	return run_command(&cp);
> +}
> +
> +static int checkout_from_index(const char *path)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "checkout-index", "-u", "-f", "--", path, NULL);
> +	return run_command(&cp);
> +}
> +
> +static int merge_one_file_deleted(const struct object_id *orig_blob,
> +				  const struct object_id *our_blob,
> +				  const struct object_id *their_blob, const char *path,
> +				  unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
> +{
> +	if ((our_blob && orig_mode != our_mode) ||
> +	    (their_blob && orig_mode != their_mode)) {
> +		fprintf(stderr, "ERROR: File %s deleted on one branch but had its\n", path);
> +		fprintf(stderr, "ERROR: permissions changed on the other.\n");
> +		return 1;
> +	}
> +
> +	if (our_blob) {
> +		printf("Removing %s\n", path);
> +
> +		if (file_exists(path))
> +			remove_path(path);
> +	}
> +
> +	return remove_from_index(path);
> +}
> +
> +static int do_merge_one_file(const struct object_id *orig_blob,
> +			     const struct object_id *our_blob,
> +			     const struct object_id *their_blob, const char *path,
> +			     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
> +{
> +	int ret, source, dest;
> +	struct strbuf src1 = STRBUF_INIT, src2 = STRBUF_INIT, orig = STRBUF_INIT;
> +	struct child_process cp_merge = CHILD_PROCESS_INIT,
> +		cp_checkout = CHILD_PROCESS_INIT,
> +		cp_update = CHILD_PROCESS_INIT;
> +
> +	if (our_mode == S_IFLNK || their_mode == S_IFLNK) {
> +		fprintf(stderr, "ERROR: %s: Not merging symbolic link changes.\n", path);
> +		return 1;
> +	} else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK) {
> +		fprintf(stderr, "ERROR: %s: Not merging conflicting submodule changes.\n",
> +			path);
> +		return 1;
> +	}
> +
> +	create_temp_file(our_blob, &src1);
> +	create_temp_file(their_blob, &src2);
> +
> +	if (orig_blob) {
> +		printf("Auto-merging %s\n", path);
> +		create_temp_file(orig_blob, &orig);
> +	} else {
> +		printf("Added %s in both, but differently.\n", path);
> +		create_temp_file(the_hash_algo->empty_blob, &orig);
> +	}
> +
> +	cp_merge.git_cmd = 1;
> +	argv_array_pushl(&cp_merge.args, "merge-file", src1.buf, orig.buf, src2.buf,
> +			 NULL);
> +	ret = run_command(&cp_merge);
> +
> +	if (ret != 0)
> +		ret = 1;
> +
> +	cp_checkout.git_cmd = 1;
> +	argv_array_pushl(&cp_checkout.args, "checkout-index", "-f", "--stage=2",
> +			 "--", path, NULL);
> +	if (run_command(&cp_checkout))
> +		return 1;
> +
> +	source = open(src1.buf, O_RDONLY);
> +	dest = open(path, O_WRONLY | O_TRUNC);
> +
> +	copy_fd(source, dest);
> +
> +	close(source);
> +	close(dest);
> +
> +	unlink(orig.buf);
> +	unlink(src1.buf);
> +	unlink(src2.buf);
> +
> +	strbuf_release(&src1);
> +	strbuf_release(&src2);
> +	strbuf_release(&orig);

The whole business of creating temporary files and forking seems like a 
lot of effort compared to calling ll_merge() which would also mean we 
respect any merge attributes

> +
> +	if (ret) {
> +		fprintf(stderr, "ERROR: ");
> +
> +		if (!orig_blob) {

I think the original does if (ret || !orig_blob) not &&
> +			fprintf(stderr, "content conflict");
> +			if (our_mode != their_mode)
> +				fprintf(stderr, ", ");

sentence lego, in any case the message below should be printed 
regardless of content conflicts. We should probably mark all these 
messages for translation as well.

> +		}
> +
> +		if (our_mode != their_mode)
> +			fprintf(stderr, "permissions conflict: %o->%o,%o",
> +				orig_mode, our_mode, their_mode);
> +
> +		fprintf(stderr, " in %s\n", path);
> +
> +		return 1;
> +	}
> +
> +	cp_update.git_cmd = 1;
> +	argv_array_pushl(&cp_update.args, "update-index", "--", path, NULL);
> +	return run_command(&cp_update);
> +}
> +
> +static int merge_one_file(const struct object_id *orig_blob,
> +			  const struct object_id *our_blob,
> +			  const struct object_id *their_blob, const char *path,
> +			  unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
> +{
> +	if (orig_blob &&
> +	    ((our_blob && oideq(orig_blob, our_blob)) ||
> +	     (their_blob && oideq(orig_blob, their_blob))))
> +		return merge_one_file_deleted(orig_blob, our_blob, their_blob, path,
> +					      orig_mode, our_mode, their_mode);

It would be nice to preserve the comments from the script as I find they 
help a lot in understanding which case each piece of code is handling. 
The code above appears to be handling deletions but does not appear to 
check that one side is actually missing. Shouldn't it be something like

if (orig_blob &&
     ((!their_blob && (our_blob && oideq(orig_blob, our_blob))) ||
      (!our_blob && (their_blob && oideq(orig_blob, their_blob))))

Maybe this could do with a test case

> +	else if (!orig_blob && our_blob && !their_blob) {
> +		return add_to_index_cacheinfo(our_mode, our_blob, path);
> +	} else if (!orig_blob && !our_blob && their_blob) {
> +		printf("Adding %s\n", path);
> +
> +		if (file_exists(path)) {
> +			fprintf(stderr, "ERROR: untracked %s is overwritten by the merge.\n", path);
> +			return 1;
> +		}
> +
> +		if (add_to_index_cacheinfo(their_mode, their_blob, path))
> +			return 1;
> +		return checkout_from_index(path);
> +	} else if (!orig_blob && our_blob && their_blob &&
> +		   oideq(our_blob, their_blob)) {
> +		if (our_mode != their_mode) {
> +			fprintf(stderr, "ERROR: File %s added identically in both branches,", path);
> +			fprintf(stderr, "ERROR: but permissions conflict %o->%o.\n",
> +				our_mode, their_mode);
> +			return 1;
> +		}
> +
> +		printf("Adding %s\n", path);
> +
> +		if (add_to_index_cacheinfo(our_mode, our_blob, path))
> +			return 1;
> +		return checkout_from_index(path);
> +	} else if (our_blob && their_blob)
> +		return do_merge_one_file(orig_blob, our_blob, their_blob, path,
> +					 orig_mode, our_mode, their_mode);
> +	else {
> +		char *orig_hex = "", *our_hex = "", *their_hex = "";
> +
> +		if (orig_blob)
> +			orig_hex = oid_to_hex(orig_blob);
> +		if (our_blob)
> +			our_hex = oid_to_hex(our_blob);
> +		if (their_blob)
> +			their_hex = oid_to_hex(their_blob);
> +
> +		fprintf(stderr, "ERROR: %s: Not handling case %s -> %s -> %s\n",
> +			path, orig_hex, our_hex, their_hex);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static const char builtin_merge_one_file_usage[] =
> +	"git merge-one-file <orig blob> <our blob> <their blob> <path> "
> +	"<orig mode> <our mode> <their mode>\n\n"
> +	"Blob ids and modes should be empty for missing files.";
> +
> +int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
> +{
> +	struct object_id orig_blob, our_blob, their_blob,
> +		*p_orig_blob = NULL, *p_our_blob = NULL, *p_their_blob = NULL;
> +	unsigned int orig_mode = 0, our_mode = 0, their_mode = 0;
> +
> +	if (argc != 8)
> +		usage(builtin_merge_one_file_usage);
> +
> +	if (!get_oid(argv[1], &orig_blob)) {
> +		p_orig_blob = &orig_blob;
> +		orig_mode = strtol(argv[5], NULL, 8);

It would probably make sense to check that strtol() succeeds (and the 
mode is sensible), and also that get_oid() fails because argv[1] is 
empty, not because it is invalid.

Thanks for working on this
Best Wishes

Phillip


> +	}
> +
> +	if (!get_oid(argv[2], &our_blob)) {
> +		p_our_blob = &our_blob;
> +		our_mode = strtol(argv[6], NULL, 8);
> +	}
> +
> +	if (!get_oid(argv[3], &their_blob)) {
> +		p_their_blob = &their_blob;
> +		their_mode = strtol(argv[7], NULL, 8);
> +	}
> +
> +	return merge_one_file(p_orig_blob, p_our_blob, p_their_blob, argv[4],
> +			      orig_mode, our_mode, their_mode);
> +}
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> deleted file mode 100755
> index f6d9852d2f..0000000000
> --- a/git-merge-one-file.sh
> +++ /dev/null
> @@ -1,167 +0,0 @@
> -#!/bin/sh
> -#
> -# Copyright (c) Linus Torvalds, 2005
> -#
> -# This is the git per-file merge script, called with
> -#
> -#   $1 - original file SHA1 (or empty)
> -#   $2 - file in branch1 SHA1 (or empty)
> -#   $3 - file in branch2 SHA1 (or empty)
> -#   $4 - pathname in repository
> -#   $5 - original file mode (or empty)
> -#   $6 - file in branch1 mode (or empty)
> -#   $7 - file in branch2 mode (or empty)
> -#
> -# Handle some trivial cases.. The _really_ trivial cases have
> -# been handled already by git read-tree, but that one doesn't
> -# do any merges that might change the tree layout.
> -
> -USAGE='<orig blob> <our blob> <their blob> <path>'
> -USAGE="$USAGE <orig mode> <our mode> <their mode>"
> -LONG_USAGE="usage: git merge-one-file $USAGE
> -
> -Blob ids and modes should be empty for missing files."
> -
> -SUBDIRECTORY_OK=Yes
> -. git-sh-setup
> -cd_to_toplevel
> -require_work_tree
> -
> -if test $# != 7
> -then
> -	echo "$LONG_USAGE"
> -	exit 1
> -fi
> -
> -case "${1:-.}${2:-.}${3:-.}" in
> -#
> -# Deleted in both or deleted in one and unchanged in the other
> -#
> -"$1.." | "$1.$1" | "$1$1.")
> -	if { test -z "$6" && test "$5" != "$7"; } ||
> -	   { test -z "$7" && test "$5" != "$6"; }
> -	then
> -		echo "ERROR: File $4 deleted on one branch but had its" >&2
> -		echo "ERROR: permissions changed on the other." >&2
> -		exit 1
> -	fi
> -
> -	if test -n "$2"
> -	then
> -		echo "Removing $4"
> -	else
> -		# read-tree checked that index matches HEAD already,
> -		# so we know we do not have this path tracked.
> -		# there may be an unrelated working tree file here,
> -		# which we should just leave unmolested.  Make sure
> -		# we do not have it in the index, though.
> -		exec git update-index --remove -- "$4"
> -	fi
> -	if test -f "$4"
> -	then
> -		rm -f -- "$4" &&
> -		rmdir -p "$(expr "z$4" : 'z\(.*\)/')" 2>/dev/null || :
> -	fi &&
> -		exec git update-index --remove -- "$4"
> -	;;
> -
> -#
> -# Added in one.
> -#
> -".$2.")
> -	# the other side did not add and we added so there is nothing
> -	# to be done, except making the path merged.
> -	exec git update-index --add --cacheinfo "$6" "$2" "$4"
> -	;;
> -"..$3")
> -	echo "Adding $4"
> -	if test -f "$4"
> -	then
> -		echo "ERROR: untracked $4 is overwritten by the merge." >&2
> -		exit 1
> -	fi
> -	git update-index --add --cacheinfo "$7" "$3" "$4" &&
> -		exec git checkout-index -u -f -- "$4"
> -	;;
> -
> -#
> -# Added in both, identically (check for same permissions).
> -#
> -".$3$2")
> -	if test "$6" != "$7"
> -	then
> -		echo "ERROR: File $4 added identically in both branches," >&2
> -		echo "ERROR: but permissions conflict $6->$7." >&2
> -		exit 1
> -	fi
> -	echo "Adding $4"
> -	git update-index --add --cacheinfo "$6" "$2" "$4" &&
> -		exec git checkout-index -u -f -- "$4"
> -	;;
> -
> -#
> -# Modified in both, but differently.
> -#
> -"$1$2$3" | ".$2$3")
> -
> -	case ",$6,$7," in
> -	*,120000,*)
> -		echo "ERROR: $4: Not merging symbolic link changes." >&2
> -		exit 1
> -		;;
> -	*,160000,*)
> -		echo "ERROR: $4: Not merging conflicting submodule changes." >&2
> -		exit 1
> -		;;
> -	esac
> -
> -	src1=$(git unpack-file $2)
> -	src2=$(git unpack-file $3)
> -	case "$1" in
> -	'')
> -		echo "Added $4 in both, but differently."
> -		orig=$(git unpack-file $(git hash-object /dev/null))
> -		;;
> -	*)
> -		echo "Auto-merging $4"
> -		orig=$(git unpack-file $1)
> -		;;
> -	esac
> -
> -	git merge-file "$src1" "$orig" "$src2"
> -	ret=$?
> -	msg=
> -	if test $ret != 0 || test -z "$1"
> -	then
> -		msg='content conflict'
> -		ret=1
> -	fi
> -
> -	# Create the working tree file, using "our tree" version from the
> -	# index, and then store the result of the merge.
> -	git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4" || exit 1
> -	rm -f -- "$orig" "$src1" "$src2"
> -
> -	if test "$6" != "$7"
> -	then
> -		if test -n "$msg"
> -		then
> -			msg="$msg, "
> -		fi
> -		msg="${msg}permissions conflict: $5->$6,$7"
> -		ret=1
> -	fi
> -
> -	if test $ret != 0
> -	then
> -		echo "ERROR: $msg in $4" >&2
> -		exit 1
> -	fi
> -	exec git update-index -- "$4"
> -	;;
> -
> -*)
> -	echo "ERROR: $4: Not handling case $1 -> $2 -> $3" >&2
> -	;;
> -esac
> -exit 1
> diff --git a/git.c b/git.c
> index a2d337eed7..058d91a2a5 100644
> --- a/git.c
> +++ b/git.c
> @@ -532,6 +532,7 @@ static struct cmd_struct commands[] = {
>   	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
>   	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
>   	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
> +	{ "merge-one-file", cmd_merge_one_file, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>   	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>   	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>   	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
> diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
> index 2eddcc7664..5fb74e39a0 100755
> --- a/t/t6035-merge-dir-to-symlink.sh
> +++ b/t/t6035-merge-dir-to-symlink.sh
> @@ -94,7 +94,7 @@ test_expect_success SYMLINKS 'a/b was resolved as symlink' '
>   	test -h a/b
>   '
>   
> -test_expect_failure 'do not lose untracked in merge (resolve)' '
> +test_expect_success 'do not lose untracked in merge (resolve)' '
>   	git reset --hard &&
>   	git checkout baseline^0 &&
>   	>a/b/c/e &&
> 

