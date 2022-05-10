Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982B6C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 13:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiEJNIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 09:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiEJNIT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 09:08:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9433526CC74
        for <git@vger.kernel.org>; Tue, 10 May 2022 06:04:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d5so23733531wrb.6
        for <git@vger.kernel.org>; Tue, 10 May 2022 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rh8tmAShUVxCUITT7t8kg1Dr2qTvkkEv+pfBkJdp0QE=;
        b=WJ5z45D01QlKGUHaSxmBJMJ4YBq2GsWYxVrnQiknxE3i9iyc8oQMOZCZ4g/Ag4w/YP
         ll5QfQnZWSvGIkiqyLZ5wf6yNBPFIVYFXSS2e7Vuve4tPWAsdLuyMygsaIAPnMRjLw/+
         mnXLKGPxkOkwTfiari1r2WaUEowYx7zFXzqJ7IsDIoUMbhXd+L04kVf3fINYkkZOfJxQ
         VjOcfVVZ2fbcLIixk652NPN5R2oPjyhrfIGuLUhReMRCUhDjAyy6C4qKXNweim0YVycR
         C/2h2zs2I31BNUfDFQ6O2GGlvBHExY1x3xm1V0JfxQ/Ver40V+O9ibM7kXns7ezZ8IlH
         0SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rh8tmAShUVxCUITT7t8kg1Dr2qTvkkEv+pfBkJdp0QE=;
        b=K+wB084uzubxDory4wJb4lThJY1PaCB7P3/YApCLYD0j+1KTbr+/e9hkPM1MMMS9hS
         1JumKC/QD+wcxgiHaX4R8+u7UGOoCPiitqP0UhZJVZTsh88TBxnL6YvN9sJkfn1ONg+t
         yXm4Z46VoIP8ZErWLqoT7BMkHgDR6gLAKynGzby7+1IIKm5XBJFlb0ikHqqznocbJxvN
         fK1ZEKntLCJvuzfPSmILWCz7StiXRGalwOxY9OVJoaCuMKfTbt99WnqKiVxJXTAjN/eF
         T06XNc6Uf3PpZzKmY56eiZYlSSmEXyeBsjchGLGXX3+FT4SyKs91g8tDIKOO9mTiSjUn
         AAEw==
X-Gm-Message-State: AOAM530YRYJVhqZF7Qzdx4yPc9SoCDocXPwPzVVSpx3DTFj9HIbeVSU+
        GfMfg+dWQ9M6nc/w+Za96MvdM38SH+8=
X-Google-Smtp-Source: ABdhPJzhVdPtoZXBXXote0pt+xJuyVxwYpYv9nZq82Rpr57T6EKSMScBPqjM26tNN02mGSX6K4k4rA==
X-Received: by 2002:a5d:5966:0:b0:20a:e810:5e9d with SMTP id e38-20020a5d5966000000b0020ae8105e9dmr18276694wri.240.1652187859880;
        Tue, 10 May 2022 06:04:19 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id n44-20020a05600c502c00b0039429bfebebsm4141451wmr.3.2022.05.10.06.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 06:04:19 -0700 (PDT)
Message-ID: <e21eaf9f-8784-88e1-e4d0-49135db1189b@gmail.com>
Date:   Tue, 10 May 2022 14:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 10/15] dir-iterator: refactor dir_iterator_advance()
Content-Language: en-US
To:     Plato Kiorpelidis <kioplato@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
 <20220509175159.2948802-11-kioplato@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220509175159.2948802-11-kioplato@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Plato

On 09/05/2022 18:51, Plato Kiorpelidis wrote:
> Simplify dir_iterator_advance() by converting from iterative to
> recursive implementation. This conversion makes dir-iterator more
> maintainable for the following reasons:
>    * dir-iterator iterates the file-system, which is a tree structure.
>      Traditionally, tree traversals, in textbooks, lectures and online
>      sources are implemented recursively and not iteratively. Therefore
>      it helps reduce mental load for readers, since it's easier to follow
>      as it reminds of the same tree traversals we use on tree structures.

In a traditional recursive tree walk the function that walks the tree 
applies a user supplied function to each node, the function that walks 
the tree does not return until every node has been visited. The 
recursive implementation relies on the initial call not returning until 
all the nodes have been visited and as Junio pointed out will exhaust 
the stack if the tree is too deep. This is not a traditional recursive 
tree walk though because we're implementing a iterator so our function 
returns each node that it visits rather than applying a user supplied 
function to the node thereby loosing any benefit offered by a recursive 
implementation.


>    * recursion requires one less indentation depth because we get rid of
>      the while loop and instead recurse, using the program's stack.
>    * in each recursive step a set of instructions are executed and
>      recursion lays out the code structurally in a better way, such that
>      these instructions stand out symmetrically for each recursive step.
> 
> This makes dir-iterator easier to work with, understand and introduce
> new functionality, like post-order on some directory entries, because it
> reminds us of the same operations we use to traverse tree structures.

I'm afraid I'm still not convinced the end result is easier to 
understand or use. It is unusual for a patch that adds twice as many 
lines as it removes to make the code simpler.

Best Wishes

Phillip

> Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> ---
>   dir-iterator.c | 223 ++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 146 insertions(+), 77 deletions(-)
> 
> diff --git a/dir-iterator.c b/dir-iterator.c
> index b17e9f970a..3adcfbc966 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -7,8 +7,7 @@ struct dir_iterator_level {
>   	DIR *dir;
>   
>   	/*
> -	 * The length of the directory part of path at this level
> -	 * (including a trailing '/'):
> +	 * The length of the directory part of path at this level.
>   	 */
>   	size_t prefix_len;
>   };
> @@ -34,8 +33,9 @@ struct dir_iterator_int {
>   	size_t levels_alloc;
>   
>   	/*
> -	 * A stack of levels. levels[0] is the uppermost directory
> -	 * that will be included in this iteration.
> +	 * A stack of levels. levels[0] is the root directory.
> +	 * It won't be included in the iteration, but iteration will happen
> +	 * inside it's subdirectories.
>   	 */
>   	struct dir_iterator_level *levels;
>   
> @@ -43,36 +43,63 @@ struct dir_iterator_int {
>   	unsigned int flags;
>   };
>   
> +enum {
> +	OK,
> +	FAIL_ENOENT,
> +	FAIL_NOT_ENOENT,
> +};
> +
>   /*
>    * Push a level in the iter stack and initialize it with information from
> - * the directory pointed by iter->base->path. It is assumed that this
> - * strbuf points to a valid directory path. Return 0 on success and -1
> - * otherwise, setting errno accordingly and leaving the stack unchanged.
> + * the directory pointed by iter->base->path. Don't open the directory.
> + *
> + * Return 1 on success.
> + * Return 0 when `iter->base->path` isn't a directory.
>    */
>   static int push_level(struct dir_iterator_int *iter)
>   {
>   	struct dir_iterator_level *level;
>   
> +	if (!S_ISDIR(iter->base.st.st_mode))
> +		return 0;
> +
>   	ALLOC_GROW(iter->levels, iter->levels_nr + 1, iter->levels_alloc);
>   	level = &iter->levels[iter->levels_nr++];
>   
> -	if (!is_dir_sep(iter->base.path.buf[iter->base.path.len - 1]))
> -		strbuf_addch(&iter->base.path, '/');
> +	level->dir = NULL;
> +
>   	level->prefix_len = iter->base.path.len;
>   
> -	level->dir = opendir(iter->base.path.buf);
> -	if (!level->dir) {
> -		int saved_errno = errno;
> -		if (errno != ENOENT) {
> -			warning_errno("error opening directory '%s'",
> -				      iter->base.path.buf);
> -		}
> -		iter->levels_nr--;
> +	return 1;
> +}
> +
> +/*
> + * Activate most recent pushed level. Stack is unchanged.
> + *
> + * Return values:
> + * OK on success.
> + * FAIL_ENOENT on failed exposure because entry does not exist.
> + * FAIL_NOT_ENOENT on failed exposure because of errno other than ENOENT.
> + */
> +static int activate_level(struct dir_iterator_int *iter)
> +{
> +	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
> +	int saved_errno;
> +
> +	if (level->dir)
> +		return OK;
> +
> +	if ((level->dir = opendir(iter->base.path.buf)) != NULL)
> +		return OK;
> +
> +	saved_errno = errno;
> +	if (errno != ENOENT) {
> +		warning_errno("error opening directory '%s'", iter->base.path.buf);
>   		errno = saved_errno;
> -		return -1;
> +		return FAIL_NOT_ENOENT;
>   	}
> -
> -	return 0;
> +	errno = saved_errno;
> +	return FAIL_ENOENT;
>   }
>   
>   /*
> @@ -81,12 +108,10 @@ static int push_level(struct dir_iterator_int *iter)
>    */
>   static int pop_level(struct dir_iterator_int *iter)
>   {
> -	struct dir_iterator_level *level =
> -		&iter->levels[iter->levels_nr - 1];
> +	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
>   
>   	if (level->dir && closedir(level->dir))
> -		warning_errno("error closing directory '%s'",
> -			      iter->base.path.buf);
> +		warning_errno("error closing directory '%s'", iter->base.path.buf);
>   	level->dir = NULL;
>   
>   	return --iter->levels_nr;
> @@ -94,82 +119,119 @@ static int pop_level(struct dir_iterator_int *iter)
>   
>   /*
>    * Populate iter->base with the necessary information on the next iteration
> - * entry, represented by the given dirent de. Return 0 on success and -1
> - * otherwise, setting errno accordingly.
> + * entry, represented by the given relative path to the lowermost directory,
> + * d_name.
> + *
> + * Return values:
> + * OK on successful exposure of the provided entry.
> + * FAIL_ENOENT on failed exposure because entry does not exist.
> + * FAIL_NOT_ENOENT on failed exposure because of errno other than ENOENT.
>    */
> -static int prepare_next_entry_data(struct dir_iterator_int *iter,
> -				   struct dirent *de)
> +static int expose_entry(struct dir_iterator_int *iter, char *d_name)
>   {
> -	int err, saved_errno;
> +	int stat_err;
>   
> -	strbuf_addstr(&iter->base.path, de->d_name);
> -	/*
> -	 * We have to reset these because the path strbuf might have
> -	 * been realloc()ed at the previous strbuf_addstr().
> -	 */
> -	iter->base.relative_path = iter->base.path.buf +
> -				   iter->levels[0].prefix_len;
> -	iter->base.basename = iter->base.path.buf +
> -			      iter->levels[iter->levels_nr - 1].prefix_len;
> +	strbuf_addch(&iter->base.path, '/');
> +	strbuf_addstr(&iter->base.path, d_name);
>   
>   	if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
> -		err = stat(iter->base.path.buf, &iter->base.st);
> +		stat_err = stat(iter->base.path.buf, &iter->base.st);
>   	else
> -		err = lstat(iter->base.path.buf, &iter->base.st);
> +		stat_err = lstat(iter->base.path.buf, &iter->base.st);
>   
> -	saved_errno = errno;
> -	if (err && errno != ENOENT)
> +	if (stat_err && errno != ENOENT) {
>   		warning_errno("failed to stat '%s'", iter->base.path.buf);
> +		return FAIL_NOT_ENOENT;
> +	} else if (stat_err && errno == ENOENT) {
> +		return FAIL_ENOENT;
> +	}
>   
> -	errno = saved_errno;
> -	return err;
> +	/*
> +	 * We have to reset relative path and basename because the path strbuf
> +	 * might have been realloc()'ed at the previous strbuf_addstr().
> +	 */
> +
> +	iter->base.relative_path =
> +		iter->base.path.buf + iter->levels[0].prefix_len + 1;
> +	iter->base.basename =
> +		iter->base.path.buf + iter->levels[iter->levels_nr - 1].prefix_len + 1;
> +
> +	return OK;
>   }
>   
>   int dir_iterator_advance(struct dir_iterator *dir_iterator)
>   {
> -	struct dir_iterator_int *iter =
> -		(struct dir_iterator_int *)dir_iterator;
> +	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
> +	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
> +	struct dirent *dir_entry = NULL;
> +	int expose_err, activate_err;
> +	/* For shorter code width-wise, more readable */
> +	unsigned int PEDANTIC = iter->flags & DIR_ITERATOR_PEDANTIC;
>   
> -	if (S_ISDIR(iter->base.st.st_mode) && push_level(iter)) {
> -		if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
> -			goto error_out;
> -		if (iter->levels_nr == 0)
> +	/*
> +	 * Attempt to open the directory of the last level if not opened yet.
> +	 *
> +	 * Remember that we ignore ENOENT errors so that the user of this API
> +	 * can remove entries between calls to `dir_iterator_advance()`.
> +	 * We care for errors other than ENOENT only when PEDANTIC is enabled.
> +	 */
> +
> +	activate_err = activate_level(iter);
> +
> +	if (activate_err == FAIL_NOT_ENOENT && PEDANTIC) {
> +		goto error_out;
> +	} else if (activate_err != OK) {
> +		--iter->levels_nr;
> +
> +		if (iter->levels_nr == 0)  /* Failed to open root directory */
>   			goto error_out;
> +
> +		return dir_iterator_advance(dir_iterator);
>   	}
>   
> -	/* Loop until we find an entry that we can give back to the caller. */
> -	while (1) {
> -		struct dirent *de;
> -		struct dir_iterator_level *level =
> -			&iter->levels[iter->levels_nr - 1];
> +	strbuf_setlen(&iter->base.path, level->prefix_len);
> +
> +	errno = 0;
> +	dir_entry = readdir(level->dir);
> +
> +	if (!dir_entry) {
> +		if (errno) {
> +			warning_errno("errno reading dir '%s'", iter->base.path.buf);
> +			if (PEDANTIC)
> +				goto error_out;
>   
> -		strbuf_setlen(&iter->base.path, level->prefix_len);
> -		errno = 0;
> -		de = readdir(level->dir);
> -
> -		if (!de) {
> -			if (errno) {
> -				warning_errno("error reading directory '%s'",
> -					      iter->base.path.buf);
> -				if (iter->flags & DIR_ITERATOR_PEDANTIC)
> -					goto error_out;
> -			} else if (pop_level(iter) == 0) {
> +			return dir_iterator_advance(dir_iterator);
> +		} else {
> +			/*
> +			 * Current directory has been iterated through.
> +			 */
> +
> +			if (pop_level(iter) == 0)
>   				return dir_iterator_abort(dir_iterator);
> -			}
> -			continue;
> +
> +			return dir_iterator_advance(dir_iterator);
>   		}
> +	}
>   
> -		if (is_dot_or_dotdot(de->d_name))
> -			continue;
> +	if (is_dot_or_dotdot(dir_entry->d_name))
> +		return dir_iterator_advance(dir_iterator);
>   
> -		if (prepare_next_entry_data(iter, de)) {
> -			if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
> -				goto error_out;
> -			continue;
> -		}
> +	/*
> +	 * Successfully read entry from current directory level.
> +	 */
>   
> -		return ITER_OK;
> -	}
> +	expose_err = expose_entry(iter, dir_entry->d_name);
> +
> +	if (expose_err == FAIL_NOT_ENOENT && PEDANTIC)
> +		goto error_out;
> +
> +	if (expose_err == OK)
> +		push_level(iter);
> +
> +	if (expose_err != OK)
> +		return dir_iterator_advance(dir_iterator);
> +
> +	return ITER_OK;
>   
>   error_out:
>   	dir_iterator_abort(dir_iterator);
> @@ -207,6 +269,8 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
>   
>   	strbuf_init(&iter->base.path, PATH_MAX);
>   	strbuf_addstr(&iter->base.path, path);
> +	/* expose_entry() appends dir seperator before exposing an entry */
> +	strbuf_trim_trailing_dir_sep(&iter->base.path);
>   
>   	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
>   	iter->levels_nr = 0;
> @@ -226,6 +290,11 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
>   		goto error_out;
>   	}
>   
> +	if (!push_level(iter)) {
> +		saved_errno = ENOTDIR;
> +		goto error_out;
> +	}
> +
>   	return dir_iterator;
>   
>   error_out:

