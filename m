Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44FCC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 13:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346522AbiDKNeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346513AbiDKNeF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 09:34:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7423B57E
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:31:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p189so9908743wmp.3
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1rzrY+8+fY7i+ct1qU+1nOXs+UEEDL1+2+b9vVHkKuk=;
        b=fX4tmG2nfSKRF2skn57HC/Hxst0g0xn1tWaBS0wjCViB89ukmVfXD8S6b60hfD9Cso
         pWj40+zoXNT/kilPxdWYwmqYPbmEzIUPvicrnXjjHfGXqU7eywpTAmK+kwcSOKMI+qiJ
         5SQejPpbLlp3ESHLjQSJ2hiGX2EZVk6hEi34RhagUCx03YVEzan3Ta017qBy3qv3MHiQ
         UpYlNY3M6UQte1aPd2YCzfQC+QLAlj6I4JVRFxVuLTnoRhk0dadumdYFxcaugL0XFrmp
         3+3zxc+z5dYBOIsetRfZ3c50GahnSOlloC6dK57+voOCGW5dHnjTcJx8Ns62EWbwsxfL
         iCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1rzrY+8+fY7i+ct1qU+1nOXs+UEEDL1+2+b9vVHkKuk=;
        b=FEnPElNnbqORJE/g2aWf1taALrB1jnA0pbIT51E1Q2nlzxSN/IZNA4mRoSQlQ/9hsc
         1dT0OL44BtSMygsAkRO+Z8LIS+7ATdLjxOIQ34e20HPu++zUeQd4PCJai+f+WBEMg+o4
         Q8ds64p7oqH7/+8yKnmRKOqVRX+Fps2UJdo3cMfLeIfe/82r1esq+DoiKpat/lHHXu1G
         BB3ETFHquOvw1GrsG47B8bzqIAprFZgLmVY2KoUqgUsz1LAuqeX5zdAIwwUAdWWOMw9G
         +UdNrNyMqfezK7JvDNGV8KGsJiF8IWEXGBIoTjEiAvSZjOUCI1unnFYv/MFqr2SxNMl4
         WUyA==
X-Gm-Message-State: AOAM533oTlrqdMF5/04PfaVJZcclm6fF4HjB+zrrq/v+eoSkShedbAcB
        DfuhLP3DVLWXBirp0IZw63w=
X-Google-Smtp-Source: ABdhPJxLlNnM9hVblJnQkTyklFkz8yu8jM7Y0rYzDGAjIA5e9YjBZmuHZHF5A+zNVpEM54gQnsU9Qw==
X-Received: by 2002:a05:600c:3d86:b0:38d:581:89ad with SMTP id bi6-20020a05600c3d8600b0038d058189admr29660559wmb.42.1649683906211;
        Mon, 11 Apr 2022 06:31:46 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b0038c949ef0d5sm20719985wmq.8.2022.04.11.06.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:31:45 -0700 (PDT)
Message-ID: <b75aaee8-c037-e8e0-6ee0-729922059352@gmail.com>
Date:   Mon, 11 Apr 2022 14:31:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 4/6] dir-iterator: iterate dirs before or after their
 contents
Content-Language: en-GB-large
To:     Plato Kiorpelidis <kioplato@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     matheus.bernardino@usp.br, mhagger@alum.mit.edu
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-5-kioplato@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220410111852.2097418-5-kioplato@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Plato

On 10/04/2022 12:18, Plato Kiorpelidis wrote:
> Introduce a new feature to dir-iterator, using dir_iterator_begin()
> flags parameter, allowing to control whether or not directories will
> appear before or after their contents.
> 
> The new default behavior (i.e. flags set to 0) does not iterate over
> directories.

This is introducing two changes at once adding the "AFTER" flag and 
changing the default behavior. I think it wolud make sence to separate 
those into two separate commits. You could change the default adding the 
"BEFORE" flag and adjusting the existing callers first and then 
implement the "AFTER" flag in a second commit.

It would also be nice to see the "AFTER" flag being used by changing 
remove_dir_recursively() for example.

Best Wishes

Phillip

  Flag DIR_ITERATOR_DIRS_BEFORE iterates over a directory
> before doing so over its contents. Flag DIR_ITERATOR_DIRS_AFTER
> iterates over a directory after doing so over its contents. These flags
> do not conflict with each other and may be used simultaneously:
>    * ignore directories
>    (DIR_ITERATOR_DIRS_BEFORE and DIR_ITERATOR_DIRS_AFTER are both false)
>    * expose them before opening and after exhausting them
>    (DIR_ITERATOR_DIRS_BEFORE and DIR_ITERATOR_DIRS_AFTER are both true).
> 
> Amend a call to dir_iterator_begin() in refs/files-backend.c and
> builtin/clone.c to enable DIR_ITERATOR_DIRS_BEFORE, since they need
> iteration over a directory before doing so over its contents.
> 
> Update t/t0066-dir-iterator.sh and t/helper/test-dir-iterator.c to test
> the new flags DIR_ITERATOR_DIRS_BEFORE, DIR_ITERATOR_DIRS_AFTER.
> 
> Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> ---
>   builtin/clone.c              |   4 +-
>   dir-iterator.c               | 101 ++++-
>   dir-iterator.h               |  34 +-
>   refs/files-backend.c         |   2 +-
>   t/helper/test-dir-iterator.c |  15 +-
>   t/t0066-dir-iterator.sh      | 844 ++++++++++++++++++++++++++++++++---
>   6 files changed, 923 insertions(+), 77 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5231656379..87ee764ba3 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -321,7 +321,9 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>   
>   	mkdir_if_missing(dest->buf, 0777);
>   
> -	flags = DIR_ITERATOR_PEDANTIC | DIR_ITERATOR_FOLLOW_SYMLINKS;
> +	flags = DIR_ITERATOR_DIRS_BEFORE |
> +		DIR_ITERATOR_PEDANTIC |
> +		DIR_ITERATOR_FOLLOW_SYMLINKS;
>   	iter = dir_iterator_begin(src->buf, flags);
>   
>   	if (!iter)
> diff --git a/dir-iterator.c b/dir-iterator.c
> index 0f9ed95958..41a1481bb4 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -116,16 +116,26 @@ static int pop_level(struct dir_iterator_int *iter)
>    *
>    * Return values:
>    * 1 on successful exposure of the provided entry.
> + * 0 on failed exposure because entry is directory and flags don't allow it.
>    * -1 on failed exposure because entry does not exist.
>    * -2 on failed exposure because of error other than ENOENT.
>    */
> -static int expose_entry(struct dir_iterator_int *iter, char *d_name)
> +static int expose_entry(struct dir_iterator_int *iter, char *d_name, char *dir_state)
>   {
>   	int stat_err;
>   
> +	unsigned int DIRS_BEFORE = iter->flags & DIR_ITERATOR_DIRS_BEFORE;
> +	unsigned int DIRS_AFTER = iter->flags & DIR_ITERATOR_DIRS_AFTER;
> +
>   	strbuf_addch(&iter->base.path, '/');
>   	strbuf_addstr(&iter->base.path, d_name);
>   
> +	/*
> +	 * We've got to check whether or not this is a directory.
> +	 * We need to perform this check since the user could've requested
> +	 * to ignore directory entries.
> +	 */
> +
>   	if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
>   		stat_err = stat(iter->base.path.buf, &iter->base.st);
>   	else
> @@ -137,6 +147,11 @@ static int expose_entry(struct dir_iterator_int *iter, char *d_name)
>   	} else if (stat_err && errno == ENOENT)
>   		return -1;  // Stat failed with ENOENT.
>   
> +	if (S_ISDIR(iter->base.st.st_mode)) {
> +		if (!DIRS_BEFORE && !strcmp(dir_state, "before")) return 0;
> +		if (!DIRS_AFTER && !strcmp(dir_state, "after")) return 0;
> +	}
> +
>   	/*
>   	 * We have to reset relative path and basename because the path strbuf
>   	 * might have been realloc()'ed at the previous strbuf_addstr().
> @@ -150,6 +165,21 @@ static int expose_entry(struct dir_iterator_int *iter, char *d_name)
>   	return 1;
>   }
>   
> +/*
> + * Get the basename of the current directory.
> + *
> + * Using iter->base.path.buf, find the current dir basename.
> + */
> +static char *current_dir_basename(struct dir_iterator_int *iter)
> +{
> +	char *start = strrchr(iter->base.path.buf, '/') + 1;
> +	char *basename = calloc(1, strlen(start) + 1);
> +
> +	memcpy(basename, start, strlen(start));
> +
> +	return basename;
> +}
> +
>   int dir_iterator_advance(struct dir_iterator *dir_iterator)
>   {
>   	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
> @@ -180,9 +210,28 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>   		 * Therefore, there isn't any case to run out of levels.
>   		 */
>   
> +		/*
> +		 * We need to make sure, in case DIRS_AFTER is enabled, to
> +		 * expose the entry in order to be consistent with what
> +		 * DIRS_BEFORE exposes in case of failed `opendir()` call.
> +		 */
> +
> +		char *d_name = current_dir_basename(iter);
> +
>   		--iter->levels_nr;
>   
> -		return dir_iterator_advance(dir_iterator);
> +		level = &iter->levels[iter->levels_nr - 1];
> +		strbuf_setlen(&iter->base.path, level->prefix_len);
> +
> +		expose_err = expose_entry(iter, d_name, "after");
> +		free(d_name);
> +
> +		if (expose_err == -2 && PEDANTIC)
> +			goto error_out;
> +		else if (expose_err == -1 || expose_err == 0)
> +			return dir_iterator_advance(dir_iterator);
> +		else
> +			return ITER_OK;
>   	}
>   
>   	strbuf_setlen(&iter->base.path, level->prefix_len);
> @@ -198,12 +247,41 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>   		} else {
>   			/*
>   			 * Current directory has been iterated through.
> +			 * We need to check if we need to expose current dir
> +			 * because of DIRS_AFTER flag.
> +			 */
> +
> +			char* d_name = current_dir_basename(iter);
> +
> +			/*
> +			 * We don't care to expose the root directory.
> +			 * Users of this API know when iteration starts on root
> +			 * directory - they call `dir_iterator_begin()` - and
> +			 * when ITER_DONE is returned they know when it's over.
> +			 */
> +
> +			/*
> +			 * Call to `pop_level()` needs to preceed call to
> +			 * `expose_entry()` because `expose_entry()` appends to
> +			 * current `iter->base` and we need to set it up.
>   			 */
>   
> -			if (pop_level(iter) == 0)
> +			if (pop_level(iter) == 0) {
>   				return dir_iterator_abort(dir_iterator);
> +			}
>   
> -			return dir_iterator_advance(dir_iterator);
> +			level = &iter->levels[iter->levels_nr - 1];
> +			strbuf_setlen(&iter->base.path, level->prefix_len);
> +
> +			expose_err = expose_entry(iter, d_name, "after");
> +			free(d_name);
> +
> +			if (expose_err == -2 && PEDANTIC)
> +				goto error_out;
> +			else if (expose_err == -1 || expose_err == 0)
> +				return dir_iterator_advance(dir_iterator);
> +			else
> +				return ITER_OK;
>   		}
>   	}
>   
> @@ -212,17 +290,26 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>   
>   	/*
>   	 * Successfully read entry from current directory level.
> +	 * In case it's a directory, we need to check, before exposing it, if
> +	 * it's allowed because of DIRS_BEFORE. In any case - allowed or not -
> +	 * we must push the directory to the levels stack, so the next call will
> +	 * read from it.
> +	 */
> +
> +	/*
> +	 * 'expose_entry()' function needs to know whether
> +	 * the exposure call is about DIRS_BEFORE or DIRS_AFTER.
>   	 */
>   
> -	expose_err = expose_entry(iter, dir_entry->d_name);
> +	expose_err = expose_entry(iter, dir_entry->d_name, "before");
>   
>   	if (expose_err == -2 && PEDANTIC)
>   		goto error_out;
>   
> -	if (expose_err == 1)
> +	if (expose_err == 0 || expose_err == 1)
>   		push_level(iter);
>   
> -	if (expose_err == -1)
> +	if (expose_err == 0 || expose_err == -1)
>   		return dir_iterator_advance(dir_iterator);
>   
>   	return ITER_OK;
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 08229157c6..dea4fc8f3e 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -8,19 +8,21 @@
>    *
>    * Iterate over a directory tree, recursively, including paths of all
>    * types and hidden paths. Skip "." and ".." entries and don't follow
> - * symlinks except for the original path. Note that the original path
> - * is not included in the iteration.
> + * symlinks except when DIR_ITERATOR_FOLLOW_SYMLINKS is set.
> + * Note that the original path is not included in the iteration.
>    *
>    * Every time dir_iterator_advance() is called, update the members of
>    * the dir_iterator structure to reflect the next path in the
>    * iteration. The order that paths are iterated over within a
> - * directory is undefined, directory paths are always given before
> - * their contents.
> + * directory is undefined. Directory paths are given before
> + * their contents when DIR_ITERATOR_DIRS_BEFORE is set and after when
> + * DIR_ITERATOR_DIRS_AFTER is set. Failure to set any of them results
> + * in directories themselves not being exposed, only their contents will be.
>    *
>    * A typical iteration looks like this:
>    *
>    *     int ok;
> - *     unsigned int flags = DIR_ITERATOR_PEDANTIC;
> + *     unsigned int flags = DIR_ITERATOR_PEDANTIC | DIR_ITERATOR_DIRS_BEFORE;
>    *     struct dir_iterator *iter = dir_iterator_begin(path, flags);
>    *
>    *     if (!iter)
> @@ -61,12 +63,25 @@
>    *   not the symlinks themselves, which is the default behavior. Broken
>    *   symlinks are ignored.
>    *
> + * - DIR_ITERATOR_DIRS_BEFORE: make dir-iterator expose a directory path before
> + *   iterating through that directory's contents.
> + *
> + * - DIR_ITERATOR_DIRS_AFTER: make dir-iterator expose a directory path after
> + *   iterating through that directory's contents.
> + *
> + * Note: any combination of DIR_ITERATOR_BEFORE and DIR_ITERATOR_AFTER works.
> + * Activating both of them will expose directories when descending into one and
> + * when it's been exhausted. Activating none will iterate through directories'
> + * contents but won't expose the directories themselves.
> + *
>    * Warning: circular symlinks are also followed when
>    * DIR_ITERATOR_FOLLOW_SYMLINKS is set. The iteration may end up with
>    * an ELOOP if they happen and DIR_ITERATOR_PEDANTIC is set.
>    */
>   #define DIR_ITERATOR_PEDANTIC (1 << 0)
>   #define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
> +#define DIR_ITERATOR_DIRS_BEFORE (1 << 2)
> +#define DIR_ITERATOR_DIRS_AFTER (1 << 3)
>   
>   struct dir_iterator {
>   	/* The current path: */
> @@ -97,12 +112,13 @@ struct dir_iterator {
>    * failure, return NULL and set errno accordingly.
>    *
>    * The iteration includes all paths under path, not including path
> - * itself and not including "." or ".." entries.
> + * itself, "." or ".." entries and directories according to specified flags.
>    *
>    * Parameters are:
>    *  - path is the starting directory. An internal copy will be made.
>    *  - flags is a combination of the possible flags to initialize a
> - *    dir-iterator or 0 for default behavior.
> + *    dir-iterator or 0 for default behavior which will ignore directory paths,
> + *    but will include non-directory directory contents.
>    */
>   struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags);
>   
> @@ -110,6 +126,7 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags);
>    * Advance the iterator to the first or next item and return ITER_OK.
>    * If the iteration is exhausted, free the dir_iterator and any
>    * resources associated with it and return ITER_DONE.
> + * On error, free the dir_iterator and return ITER_ERROR.
>    *
>    * It is a bug to use iterator or call this function again after it
>    * has returned ITER_DONE or ITER_ERROR (which may be returned iff
> @@ -119,8 +136,7 @@ int dir_iterator_advance(struct dir_iterator *iterator);
>   
>   /*
>    * End the iteration before it has been exhausted. Free the
> - * dir_iterator and any associated resources and return ITER_DONE. On
> - * error, free the dir_iterator and return ITER_ERROR.
> + * dir_iterator and any associated resources and return ITER_DONE.
>    */
>   int dir_iterator_abort(struct dir_iterator *iterator);
>   
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 95acab78ee..951a673e71 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2247,7 +2247,7 @@ static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
>   
>   	strbuf_addf(&sb, "%s/logs", gitdir);
>   
> -	diter = dir_iterator_begin(sb.buf, 0);
> +	diter = dir_iterator_begin(sb.buf, DIR_ITERATOR_DIRS_BEFORE);
>   	if (!diter) {
>   		strbuf_release(&sb);
>   		return empty_ref_iterator_begin();
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> index 659b6bfa81..c92616bd69 100644
> --- a/t/helper/test-dir-iterator.c
> +++ b/t/helper/test-dir-iterator.c
> @@ -15,7 +15,16 @@ static const char *error_name(int error_number)
>   
>   /*
>    * usage:
> - * tool-test dir-iterator [--follow-symlinks] [--pedantic] directory_path
> + * test-tool dir-iterator [OPTIONS] directory_path
> + *
> + * OPTIONS
> + *	--follow-symlinks
> + *	--pedantic
> + *	--dirs-before
> + *	--dirs-after
> + *
> + * example:
> + * test-tool dir-iterator --pedantic --dirs-before --dirs-after ./somedir
>    */
>   int cmd__dir_iterator(int argc, const char **argv)
>   {
> @@ -28,6 +37,10 @@ int cmd__dir_iterator(int argc, const char **argv)
>   			flags |= DIR_ITERATOR_FOLLOW_SYMLINKS;
>   		else if (strcmp(*argv, "--pedantic") == 0)
>   			flags |= DIR_ITERATOR_PEDANTIC;
> +		else if (strcmp(*argv, "--dirs-before") == 0)
> +			flags |= DIR_ITERATOR_DIRS_BEFORE;
> +		else if (strcmp(*argv, "--dirs-after") == 0)
> +			flags |= DIR_ITERATOR_DIRS_AFTER;
>   		else
>   			die("invalid option '%s'", *argv);
>   	}
> diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
> index 2437ab21c4..24a4f1afef 100755
> --- a/t/t0066-dir-iterator.sh
> +++ b/t/t0066-dir-iterator.sh
> @@ -14,44 +14,157 @@ test_expect_success 'setup -- dir with a single file' '
>   	[f] (a) [a] ./dir1/a
>   	EOF
>   '
> -test_expect_success 'iteration of dir with a file' '
> +test_expect_success 'dirs-ignore of dir with a file' '
>   	test-tool dir-iterator ./dir1 >actual-out &&
>   	test_cmp expected-out actual-out
>   '
> +test_expect_success 'dirs-before of dir with a file' '
> +	test-tool dir-iterator --dirs-before ./dir1 >actual-out &&
> +	test_cmp expected-out actual-out
> +'
> +test_expect_success 'dirs-after of dir with a file' '
> +	test-tool dir-iterator --dirs-after ./dir1 >actual-out &&
> +	test_cmp expected-out actual-out
> +'
> +test_expect_success 'dirs-before/dirs-after of dir with a file' '
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir1 >actual-out &&
> +	test_cmp expected-out actual-out
> +'
>   
>   test_expect_success 'setup -- dir with a single dir' '
>   	mkdir -p dir2/a &&
>   
>   
> -	cat >expected-out <<-EOF
> +	cat >expected-ignore-out <<-EOF &&
> +	EOF
> +
> +	cat >expected-before-out <<-EOF &&
> +	[d] (a) [a] ./dir2/a
> +	EOF
> +
> +	cat expected-before-out >expected-after-out &&
> +
> +	cat >expected-before-after-out <<-EOF
> +	[d] (a) [a] ./dir2/a
>   	[d] (a) [a] ./dir2/a
>   	EOF
>   '
> -test_expect_success 'iteration of dir with a single dir' '
> +test_expect_success 'dirs-ignore of dir with a single dir' '
>   	test-tool dir-iterator ./dir2 >actual-out &&
> -	test_cmp expected-out actual-out
> +	test_cmp expected-ignore-out actual-out
> +'
> +test_expect_success 'dirs-before of dir with a single dir' '
> +	test-tool dir-iterator --dirs-before ./dir2 >actual-out &&
> +	test_cmp expected-before-out actual-out
> +'
> +test_expect_success 'dirs-after of dir with a single dir' '
> +	test-tool dir-iterator --dirs-after ./dir2 >actual-out &&
> +	test_cmp expected-after-out actual-out
> +'
> +test_expect_success 'dirs-before/dirs-after of dir with a single dir' '
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir2 >actual-out &&
> +	test_cmp expected-before-after-out actual-out
>   '
>   
>   test_expect_success POSIXPERM,SANITY 'setup -- dir w/ single dir w/o perms' '
>   	mkdir -p dir3/a &&
> -	chmod 0 dir3/a &&
>   
>   
> -	cat >expected-out <<-EOF &&
> +	cat >expected-ignore-out <<-EOF &&
> +	EOF
> +	cat >expected-pedantic-ignore-out <<-EOF &&
> +	dir_iterator_advance failure
> +	EOF
> +
> +	cat >expected-before-out <<-EOF &&
>   	[d] (a) [a] ./dir3/a
>   	EOF
> -	cat >expected-pedantic-out <<-EOF
> +	cat >expected-pedantic-before-out <<-EOF &&
>   	[d] (a) [a] ./dir3/a
>   	dir_iterator_advance failure
>   	EOF
> +
> +	cat expected-before-out >expected-after-out &&
> +	cat >expected-pedantic-after-out <<-EOF &&
> +	dir_iterator_advance failure
> +	EOF
> +
> +	cat >expected-before-after-out <<-EOF &&
> +	[d] (a) [a] ./dir3/a
> +	[d] (a) [a] ./dir3/a
> +	EOF
> +	cat expected-pedantic-before-out >expected-pedantic-before-after-out
>   '
> -test_expect_success POSIXPERM,SANITY 'iteration of dir w/ dir w/o perms' '
> +test_expect_success POSIXPERM,SANITY 'dirs-ignore of dir w/ dir w/o perms' '
> +	chmod 0 dir3/a &&
> +
>   	test-tool dir-iterator ./dir3/ >actual-out &&
> -	test_cmp expected-out actual-out
> +	test_cmp expected-ignore-out actual-out &&
> +
> +	chmod 755 dir3/a
>   '
> -test_expect_success POSIXPERM,SANITY 'pedantic iteration of dir w/ dir w/o perms' '
> +test_expect_success POSIXPERM,SANITY 'pedantic dirs-ignore of dir w/ dir w/o perms' '
> +	chmod 0 dir3/a &&
> +
>   	test_must_fail test-tool dir-iterator --pedantic ./dir3/ >actual-out &&
> -	test_cmp expected-pedantic-out actual-out
> +	test_cmp expected-pedantic-ignore-out actual-out &&
> +
> +	chmod 755 dir3/a
> +'
> +test_expect_success POSIXPERM,SANITY 'dirs-before of dir w/ dir w/o perms' '
> +	chmod 0 dir3/a &&
> +
> +	test-tool dir-iterator --dirs-before ./dir3/ >actual-out &&
> +	test_cmp expected-before-out actual-out &&
> +
> +	chmod 755 dir3/a
> +'
> +test_expect_success POSIXPERM,SANITY 'pedantic dirs-before of dir w/ dir w/o perms' '
> +	chmod 0 dir3/a &&
> +
> +	test_must_fail test-tool dir-iterator --dirs-before \
> +		--pedantic ./dir3/ >actual-out &&
> +	test_cmp expected-pedantic-before-out actual-out &&
> +
> +	chmod 755 dir3/a
> +'
> +test_expect_success POSIXPERM,SANITY 'dirs-after of dir w/ dir w/o perms' '
> +	chmod 0 dir3/a &&
> +
> +	test-tool dir-iterator --dirs-after ./dir3/ >actual-out &&
> +	test_cmp expected-after-out actual-out &&
> +
> +	chmod 755 dir3/a
> +'
> +test_expect_success POSIXPERM,SANITY 'pedantic dirs-after of dir w/ dir w/o perms' '
> +	chmod 0 dir3/a &&
> +
> +	test_must_fail test-tool dir-iterator --dirs-after \
> +		--pedantic ./dir3/ >actual-out &&
> +	test_cmp expected-pedantic-after-out actual-out &&
> +
> +	chmod 755 dir3/a
> +'
> +test_expect_success POSIXPERM,SANITY \
> +'dirs-before/dirs-after of dir w/ dir w/o perms' '
> +
> +	chmod 0 dir3/a &&
> +
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir3/ >actual-out &&
> +	test_cmp expected-before-after-out actual-out &&
> +
> +	chmod 755 dir3/a
> +'
> +test_expect_success POSIXPERM,SANITY \
> +'pedantic dirs-before/dirs-after of dir w/ dir w/o perms' '
> +
> +	chmod 0 dir3/a &&
> +
> +	test_must_fail test-tool dir-iterator --dirs-before --dirs-after \
> +		--pedantic ./dir3/ >actual-out &&
> +	test_cmp expected-pedantic-before-after-out actual-out &&
> +
> +	chmod 755 dir3/a
>   '
>   
>   test_expect_success 'setup -- dir w/ five files' '
> @@ -71,26 +184,71 @@ test_expect_success 'setup -- dir w/ five files' '
>   	[f] (e) [e] ./dir4/e
>   	EOF
>   '
> -test_expect_success 'iteration of dir w/ five files' '
> +test_expect_success 'dirs-ignore of dir w/ five files' '
>   	test-tool dir-iterator ./dir4 >actual-out &&
>   	sort actual-out >actual-sorted-out &&
>   
>   	test_cmp expected-sorted-out actual-sorted-out
>   '
> +test_expect_success 'dirs-before of dir w/ five files' '
> +	test-tool dir-iterator --dirs-before ./dir4 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-sorted-out actual-sorted-out
> +'
> +test_expect_success 'dirs-after of dir w/ five files' '
> +	test-tool dir-iterator --dirs-after ./dir4 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-sorted-out actual-sorted-out
> +'
> +test_expect_success 'dirs-before/dirs-after of dir w/ five files' '
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir4 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-sorted-out actual-sorted-out
> +'
>   
>   test_expect_success 'setup -- dir w/ dir w/ a file' '
>   	mkdir -p dir5/a &&
>   	>dir5/a/b &&
>   
>   
> -	cat >expected-out <<-EOF
> +	cat >expected-ignore-out <<-EOF &&
> +	[f] (a/b) [b] ./dir5/a/b
> +	EOF
> +
> +	cat >expected-before-out <<-EOF &&
> +	[d] (a) [a] ./dir5/a
> +	[f] (a/b) [b] ./dir5/a/b
> +	EOF
> +
> +	cat >expected-after-out <<-EOF &&
> +	[f] (a/b) [b] ./dir5/a/b
> +	[d] (a) [a] ./dir5/a
> +	EOF
> +
> +	cat >expected-before-after-out <<-EOF
>   	[d] (a) [a] ./dir5/a
>   	[f] (a/b) [b] ./dir5/a/b
> +	[d] (a) [a] ./dir5/a
>   	EOF
>   '
> -test_expect_success 'iteration of dir w/ dir w/ a file' '
> +test_expect_success 'dirs-ignore of dir w/ dir w/ a file' '
>   	test-tool dir-iterator ./dir5 >actual-out &&
> -	test_cmp expected-out actual-out
> +	test_cmp expected-ignore-out actual-out
> +'
> +test_expect_success 'dirs-before of dir w/ dir w/ a file' '
> +	test-tool dir-iterator --dirs-before ./dir5 >actual-out &&
> +	test_cmp expected-before-out actual-out
> +'
> +test_expect_success 'dirs-after of dir w/ dir w/ a file' '
> +	test-tool dir-iterator --dirs-after ./dir5 >actual-out &&
> +	test_cmp expected-after-out actual-out
> +'
> +test_expect_success 'dirs-before/dirs-after of dir w/ dir w/ a file' '
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir5 >actual-out &&
> +	test_cmp expected-before-after-out actual-out
>   '
>   
>   test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
> @@ -98,16 +256,49 @@ test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
>   	>dir6/a/b/c/d &&
>   
>   
> -	cat >expected-out <<-EOF
> +	cat >expected-ignore-out <<-EOF &&
> +	[f] (a/b/c/d) [d] ./dir6/a/b/c/d
> +	EOF
> +
> +	cat >expected-before-out <<-EOF &&
>   	[d] (a) [a] ./dir6/a
>   	[d] (a/b) [b] ./dir6/a/b
>   	[d] (a/b/c) [c] ./dir6/a/b/c
>   	[f] (a/b/c/d) [d] ./dir6/a/b/c/d
>   	EOF
> +
> +	cat >expected-after-out <<-EOF &&
> +	[f] (a/b/c/d) [d] ./dir6/a/b/c/d
> +	[d] (a/b/c) [c] ./dir6/a/b/c
> +	[d] (a/b) [b] ./dir6/a/b
> +	[d] (a) [a] ./dir6/a
> +	EOF
> +
> +	cat >expected-before-after-out <<-EOF
> +	[d] (a) [a] ./dir6/a
> +	[d] (a/b) [b] ./dir6/a/b
> +	[d] (a/b/c) [c] ./dir6/a/b/c
> +	[f] (a/b/c/d) [d] ./dir6/a/b/c/d
> +	[d] (a/b/c) [c] ./dir6/a/b/c
> +	[d] (a/b) [b] ./dir6/a/b
> +	[d] (a) [a] ./dir6/a
> +	EOF
>   '
> -test_expect_success 'iteration of dir w/ three nested dirs w/ file' '
> +test_expect_success 'dirs-ignore of dir w/ three nested dirs w/ file' '
>   	test-tool dir-iterator ./dir6 >actual-out &&
> -	test_cmp expected-out actual-out
> +	test_cmp expected-ignore-out actual-out
> +'
> +test_expect_success 'dirs-before of dir w/ three nested dirs w/ file' '
> +	test-tool dir-iterator --dirs-before ./dir6 >actual-out &&
> +	test_cmp expected-before-out actual-out
> +'
> +test_expect_success 'dirs-after of dir w/ three nested dirs w/ file' '
> +	test-tool dir-iterator --dirs-after ./dir6 >actual-out &&
> +	test_cmp expected-after-out actual-out
> +'
> +test_expect_success 'dirs-before/dirs-after of dir w/ three nested dirs w/ file' '
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir6 >actual-out &&
> +	test_cmp expected-before-after-out actual-out
>   '
>   
>   test_expect_success POSIXPERM,SANITY \
> @@ -116,33 +307,123 @@ test_expect_success POSIXPERM,SANITY \
>   	mkdir -p dir7/a/b/c &&
>   	>dir7/a/b/c/d &&
>   
> -	cat >expected-out <<-EOF &&
> +
> +	cat >expected-ignore-out <<-EOF &&
> +	EOF
> +	cat >expected-pedantic-ignore-out <<-EOF &&
> +	dir_iterator_advance failure
> +	EOF
> +
> +	cat >expected-before-out <<-EOF &&
> +	[d] (a) [a] ./dir7/a
> +	[d] (a/b) [b] ./dir7/a/b
> +	EOF
> +	cat >expected-pedantic-before-out <<-EOF &&
> +	[d] (a) [a] ./dir7/a
> +	[d] (a/b) [b] ./dir7/a/b
> +	dir_iterator_advance failure
> +	EOF
> +
> +	cat >expected-after-out <<-EOF &&
> +	[d] (a/b) [b] ./dir7/a/b
> +	[d] (a) [a] ./dir7/a
> +	EOF
> +	cat >expected-pedantic-after-out <<-EOF &&
> +	dir_iterator_advance failure
> +	EOF
> +
> +	cat >expected-before-after-out <<-EOF &&
>   	[d] (a) [a] ./dir7/a
>   	[d] (a/b) [b] ./dir7/a/b
> +	[d] (a/b) [b] ./dir7/a/b
> +	[d] (a) [a] ./dir7/a
>   	EOF
> -	cat >expected-pedantic-out <<-EOF
> +	cat >expected-pedantic-before-after-out <<-EOF
>   	[d] (a) [a] ./dir7/a
>   	[d] (a/b) [b] ./dir7/a/b
>   	dir_iterator_advance failure
>   	EOF
>   '
>   test_expect_success POSIXPERM,SANITY \
> -'iteration of dir w/ three nested dirs w/ file, second w/o perms' '
> +'dirs-ignore of dir w/ three nested dirs w/ file, second w/o perms' '
>   
>   	chmod 0 dir7/a/b &&
>   
>   	test-tool dir-iterator ./dir7 >actual-out &&
> -	test_cmp expected-out actual-out &&
> +	test_cmp expected-ignore-out actual-out &&
>   
>   	chmod 755 dir7/a/b
>   '
>   test_expect_success POSIXPERM,SANITY \
> -'pedantic iteration of dir w/ three nested dirs w/ file, second w/o perms' '
> +'pedantic dirs-ignore of dir w/ three nested dirs w/ file, second w/o perms' '
>   
>   	chmod 0 dir7/a/b &&
>   
>   	test_must_fail test-tool dir-iterator --pedantic ./dir7 >actual-out &&
> -	test_cmp expected-pedantic-out actual-out &&
> +	test_cmp expected-pedantic-ignore-out actual-out &&
> +
> +	chmod 755 dir7/a/b
> +'
> +test_expect_success POSIXPERM,SANITY \
> +'dirs-before of dir w/ three nested dirs w/ file, second w/o perms' '
> +
> +	chmod 0 dir7/a/b &&
> +
> +	test-tool dir-iterator --dirs-before ./dir7 >actual-out &&
> +	test_cmp expected-before-out actual-out &&
> +
> +	chmod 755 dir7/a/b
> +'
> +test_expect_success POSIXPERM,SANITY \
> +'pedantic dirs-before of dir w/ three nested dirs w/ file, second w/o perms' '
> +
> +	chmod 0 dir7/a/b &&
> +
> +	test_must_fail test-tool dir-iterator --dirs-before \
> +		--pedantic ./dir7 >actual-out &&
> +	test_cmp expected-pedantic-before-out actual-out &&
> +
> +	chmod 755 dir7/a/b
> +'
> +test_expect_success POSIXPERM,SANITY \
> +'dirs-after of dir w/ three nested dirs w/ file, second w/o perms' '
> +
> +	chmod 0 dir7/a/b &&
> +
> +	test-tool dir-iterator --dirs-after ./dir7 >actual-out &&
> +	test_cmp expected-after-out actual-out &&
> +
> +	chmod 755 dir7/a/b
> +'
> +test_expect_success POSIXPERM,SANITY \
> +'pedantic dirs-after of dir w/ three nested dirs w/ file, second w/o perms' '
> +
> +	chmod 0 dir7/a/b &&
> +
> +	test_must_fail test-tool dir-iterator --dirs-after \
> +		--pedantic ./dir7 >actual-out &&
> +	test_cmp expected-pedantic-after-out actual-out &&
> +
> +	chmod 755 dir7/a/b
> +'
> +test_expect_success POSIXPERM,SANITY \
> +'dirs-before/dirs-after of dir w/ three nested dirs w/ file, second w/o perms' '
> +
> +	chmod 0 dir7/a/b &&
> +
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir7 >actual-out &&
> +	test_cmp expected-before-after-out actual-out &&
> +
> +	chmod 755 dir7/a/b
> +'
> +test_expect_success POSIXPERM,SANITY \
> +'pedantic dirs-before/dirs-after of dir w/ three nested dirs w/ file, second w/o perms' '
> +
> +	chmod 0 dir7/a/b &&
> +
> +	test_must_fail test-tool dir-iterator --dirs-before --dirs-after \
> +		--pedantic ./dir7 >actual-out &&
> +	test_cmp expected-pedantic-before-after-out actual-out &&
>   
>   	chmod 755 dir7/a/b
>   '
> @@ -154,24 +435,84 @@ test_expect_success 'setup -- dir w/ two dirs each w/ file' '
>   	>dir8/c/d &&
>   
>   
> -	cat >expected-out1 <<-EOF &&
> +	cat >expected-ignore-out1 <<-EOF &&
> +	[f] (a/b) [b] ./dir8/a/b
> +	[f] (c/d) [d] ./dir8/c/d
> +	EOF
> +	cat >expected-ignore-out2 <<-EOF &&
> +	[f] (c/d) [d] ./dir8/c/d
> +	[f] (a/b) [b] ./dir8/a/b
> +	EOF
> +
> +	cat >expected-before-out1 <<-EOF &&
>   	[d] (a) [a] ./dir8/a
>   	[f] (a/b) [b] ./dir8/a/b
>   	[d] (c) [c] ./dir8/c
>   	[f] (c/d) [d] ./dir8/c/d
>   	EOF
> -	cat >expected-out2 <<-EOF
> +	cat >expected-before-out2 <<-EOF &&
>   	[d] (c) [c] ./dir8/c
>   	[f] (c/d) [d] ./dir8/c/d
>   	[d] (a) [a] ./dir8/a
>   	[f] (a/b) [b] ./dir8/a/b
>   	EOF
> +
> +	cat >expected-after-out1 <<-EOF &&
> +	[f] (a/b) [b] ./dir8/a/b
> +	[d] (a) [a] ./dir8/a
> +	[f] (c/d) [d] ./dir8/c/d
> +	[d] (c) [c] ./dir8/c
> +	EOF
> +	cat >expected-after-out2 <<-EOF &&
> +	[f] (c/d) [d] ./dir8/c/d
> +	[d] (c) [c] ./dir8/c
> +	[f] (a/b) [b] ./dir8/a/b
> +	[d] (a) [a] ./dir8/a
> +	EOF
> +
> +	cat >expected-before-after-out1 <<-EOF &&
> +	[d] (a) [a] ./dir8/a
> +	[f] (a/b) [b] ./dir8/a/b
> +	[d] (a) [a] ./dir8/a
> +	[d] (c) [c] ./dir8/c
> +	[f] (c/d) [d] ./dir8/c/d
> +	[d] (c) [c] ./dir8/c
> +	EOF
> +	cat >expected-before-after-out2 <<-EOF
> +	[d] (c) [c] ./dir8/c
> +	[f] (c/d) [d] ./dir8/c/d
> +	[d] (c) [c] ./dir8/c
> +	[d] (a) [a] ./dir8/a
> +	[f] (a/b) [b] ./dir8/a/b
> +	[d] (a) [a] ./dir8/a
> +	EOF
>   '
> -test_expect_success 'iteration of dir w/ two dirs each w/ file' '
> +test_expect_success 'dirs-ignore of dir w/ two dirs each w/ file' '
>   	test-tool dir-iterator ./dir8 >actual-out &&
>   	(
> -		test_cmp expected-out1 actual-out ||
> -		test_cmp expected-out2 actual-out
> +		test_cmp expected-ignore-out1 actual-out ||
> +		test_cmp expected-ignore-out2 actual-out
> +	)
> +'
> +test_expect_success 'dirs-before of dir w/ two dirs each w/ file' '
> +	test-tool dir-iterator --dirs-before ./dir8 >actual-out &&
> +	(
> +		test_cmp expected-before-out1 actual-out ||
> +		test_cmp expected-before-out2 actual-out
> +	)
> +'
> +test_expect_success 'dirs-after of dir w/ two dirs each w/ file' '
> +	test-tool dir-iterator --dirs-after ./dir8 >actual-out &&
> +	(
> +		test_cmp expected-after-out1 actual-out ||
> +		test_cmp expected-after-out2 actual-out
> +	)
> +'
> +test_expect_success 'dirs-before/dirs-after of dir w/ two dirs each w/ file' '
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir8 >actual-out &&
> +	(
> +		test_cmp expected-before-after-out1 actual-out ||
> +		test_cmp expected-before-after-out2 actual-out
>   	)
>   '
>   
> @@ -183,44 +524,164 @@ test_expect_success 'setup -- dir w/ two dirs, one w/ two and one w/ one files'
>   	>dir9/d/e &&
>   
>   
> -	cat >expected-out1 <<-EOF &&
> +	cat >expected-ignore-out1 <<-EOF &&
> +	[f] (a/b) [b] ./dir9/a/b
> +	[f] (a/c) [c] ./dir9/a/c
> +	[f] (d/e) [e] ./dir9/d/e
> +	EOF
> +	cat >expected-ignore-out2 <<-EOF &&
> +	[f] (a/c) [c] ./dir9/a/c
> +	[f] (a/b) [b] ./dir9/a/b
> +	[f] (d/e) [e] ./dir9/d/e
> +	EOF
> +	cat >expected-ignore-out3 <<-EOF &&
> +	[f] (d/e) [e] ./dir9/d/e
> +	[f] (a/b) [b] ./dir9/a/b
> +	[f] (a/c) [c] ./dir9/a/c
> +	EOF
> +	cat >expected-ignore-out4 <<-EOF &&
> +	[f] (d/e) [e] ./dir9/d/e
> +	[f] (a/c) [c] ./dir9/a/c
> +	[f] (a/b) [b] ./dir9/a/b
> +	EOF
> +
> +	cat >expected-before-out1 <<-EOF &&
>   	[d] (a) [a] ./dir9/a
>   	[f] (a/b) [b] ./dir9/a/b
>   	[f] (a/c) [c] ./dir9/a/c
>   	[d] (d) [d] ./dir9/d
>   	[f] (d/e) [e] ./dir9/d/e
>   	EOF
> -	cat >expected-out2 <<-EOF &&
> +	cat >expected-before-out2 <<-EOF &&
>   	[d] (a) [a] ./dir9/a
>   	[f] (a/c) [c] ./dir9/a/c
>   	[f] (a/b) [b] ./dir9/a/b
>   	[d] (d) [d] ./dir9/d
>   	[f] (d/e) [e] ./dir9/d/e
>   	EOF
> -	cat >expected-out3 <<-EOF &&
> +	cat >expected-before-out3 <<-EOF &&
>   	[d] (d) [d] ./dir9/d
>   	[f] (d/e) [e] ./dir9/d/e
>   	[d] (a) [a] ./dir9/a
>   	[f] (a/b) [b] ./dir9/a/b
>   	[f] (a/c) [c] ./dir9/a/c
>   	EOF
> -	cat >expected-out4 <<-EOF
> +	cat >expected-before-out4 <<-EOF &&
>   	[d] (d) [d] ./dir9/d
>   	[f] (d/e) [e] ./dir9/d/e
>   	[d] (a) [a] ./dir9/a
>   	[f] (a/c) [c] ./dir9/a/c
>   	[f] (a/b) [b] ./dir9/a/b
>   	EOF
> +
> +	cat >expected-after-out1 <<-EOF &&
> +	[f] (a/b) [b] ./dir9/a/b
> +	[f] (a/c) [c] ./dir9/a/c
> +	[d] (a) [a] ./dir9/a
> +	[f] (d/e) [e] ./dir9/d/e
> +	[d] (d) [d] ./dir9/d
> +	EOF
> +	cat >expected-after-out2 <<-EOF &&
> +	[f] (a/c) [c] ./dir9/a/c
> +	[f] (a/b) [b] ./dir9/a/b
> +	[d] (a) [a] ./dir9/a
> +	[f] (d/e) [e] ./dir9/d/e
> +	[d] (d) [d] ./dir9/d
> +	EOF
> +	cat >expected-after-out3 <<-EOF &&
> +	[f] (d/e) [e] ./dir9/d/e
> +	[d] (d) [d] ./dir9/d
> +	[f] (a/b) [b] ./dir9/a/b
> +	[f] (a/c) [c] ./dir9/a/c
> +	[d] (a) [a] ./dir9/a
> +	EOF
> +	cat >expected-after-out4 <<-EOF &&
> +	[f] (d/e) [e] ./dir9/d/e
> +	[d] (d) [d] ./dir9/d
> +	[f] (a/c) [c] ./dir9/a/c
> +	[f] (a/b) [b] ./dir9/a/b
> +	[d] (a) [a] ./dir9/a
> +	EOF
> +
> +	cat >expected-before-after-out1 <<-EOF &&
> +	[d] (a) [a] ./dir9/a
> +	[f] (a/b) [b] ./dir9/a/b
> +	[f] (a/c) [c] ./dir9/a/c
> +	[d] (a) [a] ./dir9/a
> +	[d] (d) [d] ./dir9/d
> +	[f] (d/e) [e] ./dir9/d/e
> +	[d] (d) [d] ./dir9/d
> +	EOF
> +	cat >expected-before-after-out2 <<-EOF &&
> +	[d] (a) [a] ./dir9/a
> +	[f] (a/c) [c] ./dir9/a/c
> +	[f] (a/b) [b] ./dir9/a/b
> +	[d] (a) [a] ./dir9/a
> +	[d] (d) [d] ./dir9/d
> +	[f] (d/e) [e] ./dir9/d/e
> +	[d] (d) [d] ./dir9/d
> +	EOF
> +	cat >expected-before-after-out3 <<-EOF &&
> +	[d] (d) [d] ./dir9/d
> +	[f] (d/e) [e] ./dir9/d/e
> +	[d] (d) [d] ./dir9/d
> +	[d] (a) [a] ./dir9/a
> +	[f] (a/b) [b] ./dir9/a/b
> +	[f] (a/c) [c] ./dir9/a/c
> +	[d] (a) [a] ./dir9/a
> +	EOF
> +	cat >expected-before-after-out4 <<-EOF
> +	[d] (d) [d] ./dir9/d
> +	[f] (d/e) [e] ./dir9/d/e
> +	[d] (d) [d] ./dir9/d
> +	[d] (a) [a] ./dir9/a
> +	[f] (a/c) [c] ./dir9/a/c
> +	[f] (a/b) [b] ./dir9/a/b
> +	[d] (a) [a] ./dir9/a
> +	EOF
>   '
>   test_expect_success \
> -'iteration of dir w/ three dirs, one w/ two, one w/ one and one w/ none files' '
> +'dirs-ignore of dir w/ three dirs, one w/ two, one w/ one and one w/ none files' '
>   
>   	test-tool dir-iterator ./dir9 >actual-out &&
>   	(
> -		test_cmp expected-out1 actual-out ||
> -		test_cmp expected-out2 actual-out ||
> -		test_cmp expected-out3 actual-out ||
> -		test_cmp expected-out4 actual-out
> +		test_cmp expected-ignore-out1 actual-out ||
> +		test_cmp expected-ignore-out2 actual-out ||
> +		test_cmp expected-ignore-out3 actual-out ||
> +		test_cmp expected-ignore-out4 actual-out
> +	)
> +'
> +test_expect_success \
> +'dirs-before of dir w/ three dirs, one w/ two, one w/ one and one w/ none files' '
> +
> +	test-tool dir-iterator --dirs-before ./dir9 >actual-out &&
> +	(
> +		test_cmp expected-before-out1 actual-out ||
> +		test_cmp expected-before-out2 actual-out ||
> +		test_cmp expected-before-out3 actual-out ||
> +		test_cmp expected-before-out4 actual-out
> +	)
> +'
> +test_expect_success \
> +'dirs-after of dir w/ three dirs, one w/ two, one w/ one and one w/ none files' '
> +
> +	test-tool dir-iterator --dirs-after ./dir9 >actual-out &&
> +	(
> +		test_cmp expected-after-out1 actual-out ||
> +		test_cmp expected-after-out2 actual-out ||
> +		test_cmp expected-after-out3 actual-out ||
> +		test_cmp expected-after-out4 actual-out
> +	)
> +'
> +test_expect_success \
> +'dirs-before/dirs-after of dir w/ three dirs, one w/ two, one w/ one and one w/ none files' '
> +
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir9 >actual-out &&
> +	(
> +		test_cmp expected-before-after-out1 actual-out ||
> +		test_cmp expected-before-after-out2 actual-out ||
> +		test_cmp expected-before-after-out3 actual-out ||
> +		test_cmp expected-before-after-out4 actual-out
>   	)
>   '
>   
> @@ -231,25 +692,84 @@ test_expect_success 'setup -- dir w/ two nested dirs, each w/ file' '
>   	>dir10/a/c/d &&
>   
>   
> -	cat >expected-out1 <<-EOF &&
> +	cat >expected-ignore-out1 <<-EOF &&
> +	[f] (a/b) [b] ./dir10/a/b
> +	[f] (a/c/d) [d] ./dir10/a/c/d
> +	EOF
> +	cat >expected-ignore-out2 <<-EOF &&
> +	[f] (a/c/d) [d] ./dir10/a/c/d
> +	[f] (a/b) [b] ./dir10/a/b
> +	EOF
> +
> +	cat >expected-before-out1 <<-EOF &&
>   	[d] (a) [a] ./dir10/a
>   	[f] (a/b) [b] ./dir10/a/b
>   	[d] (a/c) [c] ./dir10/a/c
>   	[f] (a/c/d) [d] ./dir10/a/c/d
>   	EOF
> -	cat >expected-out2 <<-EOF
> +	cat >expected-before-out2 <<-EOF &&
>   	[d] (a) [a] ./dir10/a
>   	[d] (a/c) [c] ./dir10/a/c
>   	[f] (a/c/d) [d] ./dir10/a/c/d
>   	[f] (a/b) [b] ./dir10/a/b
>   	EOF
>   
> +	cat >expected-after-out1 <<-EOF &&
> +	[f] (a/b) [b] ./dir10/a/b
> +	[f] (a/c/d) [d] ./dir10/a/c/d
> +	[d] (a/c) [c] ./dir10/a/c
> +	[d] (a) [a] ./dir10/a
> +	EOF
> +	cat >expected-after-out2 <<-EOF &&
> +	[f] (a/c/d) [d] ./dir10/a/c/d
> +	[d] (a/c) [c] ./dir10/a/c
> +	[f] (a/b) [b] ./dir10/a/b
> +	[d] (a) [a] ./dir10/a
> +	EOF
> +
> +	cat >expected-before-after-out1 <<-EOF &&
> +	[d] (a) [a] ./dir10/a
> +	[f] (a/b) [b] ./dir10/a/b
> +	[d] (a/c) [c] ./dir10/a/c
> +	[f] (a/c/d) [d] ./dir10/a/c/d
> +	[d] (a/c) [c] ./dir10/a/c
> +	[d] (a) [a] ./dir10/a
> +	EOF
> +	cat >expected-before-after-out2 <<-EOF
> +	[d] (a) [a] ./dir10/a
> +	[d] (a/c) [c] ./dir10/a/c
> +	[f] (a/c/d) [d] ./dir10/a/c/d
> +	[d] (a/c) [c] ./dir10/a/c
> +	[f] (a/b) [b] ./dir10/a/b
> +	[d] (a) [a] ./dir10/a
> +	EOF
>   '
> -test_expect_success 'iteration of dir w/ two nested dirs, each w/ file' '
> +test_expect_success 'dirs-ignore of dir w/ two nested dirs, each w/ file' '
>   	test-tool dir-iterator ./dir10/ >actual-out &&
>   	(
> -		test_cmp expected-out1 actual-out ||
> -		test_cmp expected-out2 actual-out
> +		test_cmp expected-ignore-out1 actual-out ||
> +		test_cmp expected-ignore-out2 actual-out
> +	)
> +'
> +test_expect_success 'dirs-before of dir w/ two nested dirs, each w/ file' '
> +	test-tool dir-iterator --dirs-before ./dir10/ >actual-out &&
> +	(
> +		test_cmp expected-before-out1 actual-out ||
> +		test_cmp expected-before-out2 actual-out
> +	)
> +'
> +test_expect_success 'dirs-after of dir w/ two nested dirs, each w/ file' '
> +	test-tool dir-iterator --dirs-after ./dir10/ >actual-out &&
> +	(
> +		test_cmp expected-after-out1 actual-out ||
> +		test_cmp expected-after-out2 actual-out
> +	)
> +'
> +test_expect_success 'dirs-before/dirs-after of dir w/ two nested dirs, each w/ file' '
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir10 >actual-out &&
> +	(
> +		test_cmp expected-before-after-out1 actual-out ||
> +		test_cmp expected-before-after-out2 actual-out
>   	)
>   '
>   
> @@ -263,7 +783,15 @@ test_expect_success 'setup -- dir w/ complex structure w/o symlinks' '
>   	>dir11/d/e/d/a &&
>   
>   
> -	cat >expected-sorted-out <<-EOF
> +	cat >expected-ignore-sorted-out <<-EOF &&
> +	[f] (a/b/c/d) [d] ./dir11/a/b/c/d
> +	[f] (a/e) [e] ./dir11/a/e
> +	[f] (b) [b] ./dir11/b
> +	[f] (c) [c] ./dir11/c
> +	[f] (d/e/d/a) [a] ./dir11/d/e/d/a
> +	EOF
> +
> +	cat >expected-before-sorted-out <<-EOF &&
>   	[d] (a) [a] ./dir11/a
>   	[d] (a/b) [b] ./dir11/a/b
>   	[d] (a/b/c) [c] ./dir11/a/b/c
> @@ -276,12 +804,52 @@ test_expect_success 'setup -- dir w/ complex structure w/o symlinks' '
>   	[f] (c) [c] ./dir11/c
>   	[f] (d/e/d/a) [a] ./dir11/d/e/d/a
>   	EOF
> +
> +	cat expected-before-sorted-out >expected-after-sorted-out &&
> +
> +	cat >expected-before-after-sorted-out <<-EOF
> +	[d] (a) [a] ./dir11/a
> +	[d] (a) [a] ./dir11/a
> +	[d] (a/b) [b] ./dir11/a/b
> +	[d] (a/b) [b] ./dir11/a/b
> +	[d] (a/b/c) [c] ./dir11/a/b/c
> +	[d] (a/b/c) [c] ./dir11/a/b/c
> +	[d] (d) [d] ./dir11/d
> +	[d] (d) [d] ./dir11/d
> +	[d] (d/e) [e] ./dir11/d/e
> +	[d] (d/e) [e] ./dir11/d/e
> +	[d] (d/e/d) [d] ./dir11/d/e/d
> +	[d] (d/e/d) [d] ./dir11/d/e/d
> +	[f] (a/b/c/d) [d] ./dir11/a/b/c/d
> +	[f] (a/e) [e] ./dir11/a/e
> +	[f] (b) [b] ./dir11/b
> +	[f] (c) [c] ./dir11/c
> +	[f] (d/e/d/a) [a] ./dir11/d/e/d/a
> +	EOF
>   '
> -test_expect_success 'iteration of dir w/ complex structure w/o symlinks' '
> +test_expect_success 'dirs-ignore of dir w/ complex structure w/o symlinks' '
>   	test-tool dir-iterator ./dir11 >actual-out &&
>   	sort actual-out >actual-sorted-out &&
>   
> -	test_cmp expected-sorted-out actual-sorted-out
> +	test_cmp expected-ignore-sorted-out actual-sorted-out
> +'
> +test_expect_success 'dirs-before of dir w/ complex structure w/o symlinks' '
> +	test-tool dir-iterator --dirs-before ./dir11 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-before-sorted-out actual-sorted-out
> +'
> +test_expect_success 'dirs-after of dir w/ complex structure w/o symlinks' '
> +	test-tool dir-iterator --dirs-after ./dir11 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-after-sorted-out actual-sorted-out
> +'
> +test_expect_success 'dirs-before/dirs-after of dir w/ complex structure w/o symlinks' '
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir11 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-before-after-sorted-out actual-sorted-out
>   '
>   
>   test_expect_success POSIXPERM,SANITY \
> @@ -338,7 +906,7 @@ test_expect_success POSIXPERM,SANITY \
>   	[d] (a) [a] ./dir13/a
>   	EOF
>   
> -	test-tool dir-iterator ./dir13 >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir13 >actual-out &&
>   	test_cmp expected-no-permissions-out actual-out &&
>   
>   	chmod 755 dir13/a &&
> @@ -358,7 +926,8 @@ test_expect_success POSIXPERM,SANITY \
>   	dir_iterator_advance failure
>   	EOF
>   
> -	test_must_fail test-tool dir-iterator --pedantic ./dir13 >actual-out &&
> +	test_must_fail test-tool dir-iterator --dirs-before \
> +		--pedantic ./dir13 >actual-out &&
>   	test_cmp expected-no-permissions-pedantic-out actual-out &&
>   
>   	chmod 755 dir13/a &&
> @@ -373,7 +942,17 @@ test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
>   	ln -s ../b dir14/a/f &&
>   
>   
> -	cat >expected-dont-follow-sorted-out <<-EOF &&
> +	cat >expected-dont-follow-ignore-sorted-out <<-EOF &&
> +	[f] (a/d) [d] ./dir14/a/d
> +	[s] (a/e) [e] ./dir14/a/e
> +	[s] (a/f) [f] ./dir14/a/f
> +	EOF
> +	cat >expected-follow-ignore-sorted-out <<-EOF &&
> +	[f] (a/d) [d] ./dir14/a/d
> +	[f] (a/e) [e] ./dir14/a/e
> +	EOF
> +
> +	cat >expected-dont-follow-before-sorted-out <<-EOF &&
>   	[d] (a) [a] ./dir14/a
>   	[d] (b) [b] ./dir14/b
>   	[d] (b/c) [c] ./dir14/b/c
> @@ -381,7 +960,7 @@ test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
>   	[s] (a/e) [e] ./dir14/a/e
>   	[s] (a/f) [f] ./dir14/a/f
>   	EOF
> -	cat >expected-follow-sorted-out <<-EOF
> +	cat >expected-follow-before-sorted-out <<-EOF &&
>   	[d] (a) [a] ./dir14/a
>   	[d] (a/f) [f] ./dir14/a/f
>   	[d] (a/f/c) [c] ./dir14/a/f/c
> @@ -390,22 +969,99 @@ test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
>   	[f] (a/d) [d] ./dir14/a/d
>   	[f] (a/e) [e] ./dir14/a/e
>   	EOF
> +
> +	cat expected-dont-follow-before-sorted-out >expected-dont-follow-after-sorted-out &&
> +	cat expected-follow-before-sorted-out >expected-follow-after-sorted-out &&
> +
> +	cat >expected-dont-follow-before-after-sorted-out <<-EOF &&
> +	[d] (a) [a] ./dir14/a
> +	[d] (a) [a] ./dir14/a
> +	[d] (b) [b] ./dir14/b
> +	[d] (b) [b] ./dir14/b
> +	[d] (b/c) [c] ./dir14/b/c
> +	[d] (b/c) [c] ./dir14/b/c
> +	[f] (a/d) [d] ./dir14/a/d
> +	[s] (a/e) [e] ./dir14/a/e
> +	[s] (a/f) [f] ./dir14/a/f
> +	EOF
> +	cat >expected-follow-before-after-sorted-out <<-EOF
> +	[d] (a) [a] ./dir14/a
> +	[d] (a) [a] ./dir14/a
> +	[d] (a/f) [f] ./dir14/a/f
> +	[d] (a/f) [f] ./dir14/a/f
> +	[d] (a/f/c) [c] ./dir14/a/f/c
> +	[d] (a/f/c) [c] ./dir14/a/f/c
> +	[d] (b) [b] ./dir14/b
> +	[d] (b) [b] ./dir14/b
> +	[d] (b/c) [c] ./dir14/b/c
> +	[d] (b/c) [c] ./dir14/b/c
> +	[f] (a/d) [d] ./dir14/a/d
> +	[f] (a/e) [e] ./dir14/a/e
> +	EOF
>   '
>   test_expect_success SYMLINKS \
> -'dont-follow-symlinks of dir w/ symlinks w/o cycle' '
> +'dont-follow-symlinks dirs-ignore of dir w/ symlinks w/o cycle' '
>   
>   	test-tool dir-iterator ./dir14 >actual-out &&
>   	sort actual-out >actual-sorted-out &&
>   
> -	test_cmp expected-dont-follow-sorted-out actual-sorted-out
> +	test_cmp expected-dont-follow-ignore-sorted-out actual-sorted-out
>   '
>   test_expect_success SYMLINKS \
> -'follow-symlinks of dir w/ symlinks w/o cycle' '
> +'follow-symlinks dirs-ignore of dir w/ symlinks w/o cycle' '
>   
>   	test-tool dir-iterator --follow-symlinks ./dir14 >actual-out &&
>   	sort actual-out >actual-sorted-out &&
>   
> -	test_cmp expected-follow-sorted-out actual-sorted-out
> +	test_cmp expected-follow-ignore-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'dont-follow-symlinks dirs-before of dir w/ symlinks w/o cycle' '
> +
> +	test-tool dir-iterator --dirs-before ./dir14 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-dont-follow-before-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'follow-symlinks dirs-before of dir w/ symlinks w/o cycle' '
> +
> +	test-tool dir-iterator --dirs-before --follow-symlinks ./dir14 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-follow-before-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'dont-follow-symlinks dirs-after of dir w/ symlinks w/o cycle' '
> +
> +	test-tool dir-iterator --dirs-after ./dir14 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-dont-follow-after-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'follow-symlinks dirs-after of dir w/ symlinks w/o cycle' '
> +
> +	test-tool dir-iterator --dirs-after --follow-symlinks ./dir14 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-follow-after-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'dont-follow-symlinks dirs-before/dirs-after of dir w/ symlinks w/o cycle' '
> +
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir14 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-dont-follow-before-after-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'follow-symlinks dirs-before/dirs-after of dir w/ symlinks w/o cycle' '
> +
> +	test-tool dir-iterator --dirs-before --dirs-after --follow-symlinks ./dir14 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-follow-before-after-sorted-out actual-sorted-out
>   '
>   
>   test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/ cycle' '
> @@ -415,7 +1071,14 @@ test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/ cycle' '
>   	ln -s ../ dir15/a/b/e &&
>   	ln -s ../../ dir15/a/b/f &&
>   
> -	cat >expected-dont-follow-sorted-out <<-EOF &&
> +
> +	cat >expected-dont-follow-ignore-sorted-out <<-EOF &&
> +	[s] (a/b/d) [d] ./dir15/a/b/d
> +	[s] (a/b/e) [e] ./dir15/a/b/e
> +	[s] (a/b/f) [f] ./dir15/a/b/f
> +	EOF
> +
> +	cat >expected-dont-follow-before-sorted-out <<-EOF &&
>   	[d] (a) [a] ./dir15/a
>   	[d] (a/b) [b] ./dir15/a/b
>   	[d] (a/c) [c] ./dir15/a/c
> @@ -424,22 +1087,87 @@ test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/ cycle' '
>   	[s] (a/b/f) [f] ./dir15/a/b/f
>   	EOF
>   
> +	cat expected-dont-follow-before-sorted-out >expected-dont-follow-after-sorted-out &&
> +
> +	cat >expected-dont-follow-before-after-sorted-out <<-EOF &&
> +	[d] (a) [a] ./dir15/a
> +	[d] (a) [a] ./dir15/a
> +	[d] (a/b) [b] ./dir15/a/b
> +	[d] (a/b) [b] ./dir15/a/b
> +	[d] (a/c) [c] ./dir15/a/c
> +	[d] (a/c) [c] ./dir15/a/c
> +	[s] (a/b/d) [d] ./dir15/a/b/d
> +	[s] (a/b/e) [e] ./dir15/a/b/e
> +	[s] (a/b/f) [f] ./dir15/a/b/f
> +	EOF
> +
>   	cat >expected-pedantic-follow-tailed-out <<-EOF
>   	dir_iterator_advance failure
>   	EOF
>   '
>   test_expect_success SYMLINKS \
> -'dont-follow-symlinks of dir w/ symlinks w/ cycle' '
> +'dont-follow-symlinks dirs-ignore of dir w/ symlinks w/ cycle' '
>   
>   	test-tool dir-iterator ./dir15 >actual-out &&
>   	sort actual-out >actual-sorted-out &&
>   
> -	test_cmp expected-dont-follow-sorted-out actual-sorted-out
> +	test_cmp expected-dont-follow-ignore-sorted-out actual-sorted-out
>   '
>   test_expect_success SYMLINKS \
> -'pedantic follow-symlinks of dir w/ symlinks w/ cycle' '
> +'pedantic follow-symlinks dirs-ignore of dir w/ symlinks w/ cycle' '
>   
>   	test_must_fail test-tool dir-iterator \
> +		--follow-symlinks --pedantic ./dir15 >actual-out &&
> +	tail -n 1 actual-out >actual-tailed-out &&
> +
> +	test_cmp expected-pedantic-follow-tailed-out actual-tailed-out
> +'
> +test_expect_success SYMLINKS \
> +'dont-follow-symlinks dirs-before of dir w/ symlinks w/ cycle' '
> +
> +	test-tool dir-iterator --dirs-before ./dir15 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-dont-follow-before-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'pedantic follow-symlinks dirs-before of dir w/ symlinks w/ cycle' '
> +
> +	test_must_fail test-tool dir-iterator --dirs-before \
> +		--pedantic --follow-symlinks ./dir15 >actual-out &&
> +	tail -n 1 actual-out >actual-tailed-out &&
> +
> +	test_cmp expected-pedantic-follow-tailed-out actual-tailed-out
> +'
> +test_expect_success SYMLINKS \
> +'dont-follow-symlinks dirs-after of dir w/ symlinks w/ cycle' '
> +
> +	test-tool dir-iterator --dirs-after ./dir15 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-dont-follow-after-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'pedantic follow-symlinks dirs-after of dir w/ symlinks w/ cycle' '
> +
> +	test_must_fail test-tool dir-iterator --dirs-after \
> +		--pedantic --follow-symlinks ./dir15 >actual-out &&
> +	tail -n 1 actual-out >actual-tailed-out &&
> +
> +	test_cmp expected-pedantic-follow-tailed-out actual-tailed-out
> +'
> +test_expect_success SYMLINKS \
> +'dont-follow-symlinks dirs-before/dirs-after of dir w/ symlinks w/ cycle' '
> +
> +	test-tool dir-iterator --dirs-before --dirs-after ./dir15 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-dont-follow-before-after-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'pedantic follow-symlinks dirs-before/dirs-after of dir w/ symlinks w/ cycle' '
> +
> +	test_must_fail test-tool dir-iterator --dirs-before --dirs-after \
>   		--pedantic --follow-symlinks ./dir15 >actual-out &&
>   	tail -n 1 actual-out >actual-tailed-out &&
>   

