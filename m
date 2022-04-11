Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0153C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 13:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbiDKN3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346513AbiDKN25 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 09:28:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E48C3BBD9
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:26:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h16so9925917wmd.0
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LczNiIwvAF5unFylLBECQQ7PgCGAQqXaBiP0V1YzzhM=;
        b=VUJDoc/Zx2NhGfHUXwqOXignJflQqXQPlV1o2k4xwEtFS0wU1V5hSEGNqpm2qjBbjn
         ThlYMBL/KNmMCmqjEDYa7J9ZC9xKiBOHzk2wo2xcJW9+Y323TWeKeAyFtWKulIO0ZE7H
         LMpfcsSgoMkgSnIufLq7ttOC+NuZmgEfy+eLytRsK7csr7beYxrlsAcxrpvh8GBNLY3M
         uBG5+XN7Z7GARpOuXG7VrEpY1vbqG3JCZhE7/jIukJqn5W8Mly4s3mMmzzcqli2jc+V6
         GRUpYD01Sdaxw2v1TedoDnrTSAM3Y+VFJy463k7QZLIcKJmdqOLO10noUTO4gT9B4+wg
         l15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LczNiIwvAF5unFylLBECQQ7PgCGAQqXaBiP0V1YzzhM=;
        b=VDVU8oypILb41drBtsp2g3bo4LVUtHlBNDovl11c1AR3S9XLxi/v9jihw/cjBa58o9
         Q5OAaYUiF4VfMaD/yefwwnHudT4El1Rsmf47+5+6GOz5fa+aB0PfAHjsclnsiUibs1bX
         Zd+uEecVyjocsPakNhXUBLKofr1FolkjPwrFHnksGGFYzaHzub7IQ/ZM0ZJwM4K4+VtQ
         6WIBWfTdsXOevjZfrh9bKCngJBwEYcNZn9aywtq6ZHaqUuJRRyMle4RzEvFiLirbrnMS
         rrb/LIEpd2kVFdo4f9PWnBjAy3Ljwiu20j97FdJpcCJhYryrp+b6Ize+fb5gWcFVvrNJ
         v2gA==
X-Gm-Message-State: AOAM532eQesT1rQKjQp86RWiTkZkdAiMdlY42rhLBhzXd6aaL6kx+he1
        Bj1eNRiwl9BXgbvf8cuMmhs=
X-Google-Smtp-Source: ABdhPJx7Q5uYm2MDxdHBvS7Pked2dH+H7wp7CyGTJC0Myd0JTpjsTXrpK9uu5dCzY+Kgaj77DXvSGw==
X-Received: by 2002:a1c:f005:0:b0:38c:b6d5:5c2a with SMTP id a5-20020a1cf005000000b0038cb6d55c2amr29297614wmb.89.1649683596282;
        Mon, 11 Apr 2022 06:26:36 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d59a8000000b00204178688d3sm30289160wrr.100.2022.04.11.06.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:26:35 -0700 (PDT)
Message-ID: <35160d46-d337-2110-f968-238abb7e9f0e@gmail.com>
Date:   Mon, 11 Apr 2022 14:26:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 3/6] dir-iterator: refactor dir_iterator_advance()
Content-Language: en-GB-large
To:     Plato Kiorpelidis <kioplato@gmail.com>, git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, mhagger@alum.mit.edu,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-4-kioplato@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220410111852.2097418-4-kioplato@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Plato

On 10/04/2022 12:18, Plato Kiorpelidis wrote:
> Simplify dir_iterator_advance by switch from iterative to recursive
> implementation. In each recursive step one action is performed.
> 
> This makes dir-iterator easier to work with, understand and introduce
> new functionality.

I think that this message could explain a bit more about why it is 
necessary to use a recursive approach. As we are implementing an 
iterator we cannot keep state in the stack between iterations so how 
does using recursive approach help us?

I reviewed this series as a way to learn the directory iterator code as 
I'd not looked at it before. Having read the existing code I think the 
it is fairly easy to follow. I'm not sure the changes here improve that. 
I also found these changes harder to follow because they renamed 
existing functions and variables in addition to moving the code around.

In order in implement returning the directory name after its contents I 
think all we need is to remember whether we've returned the name when we 
readdir() returns NULL so we don't pop it too soon. It's not clear that 
we need a lot of refactoring to do that, especially as the patches you 
linked to in the cover letter seem to avoid that.

Best Wishes

Phillip

> Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> ---
>   dir-iterator.c          | 225 ++++++++++++++++++++++++++--------------
>   t/t0066-dir-iterator.sh |   4 +-
>   2 files changed, 148 insertions(+), 81 deletions(-)
> 
> diff --git a/dir-iterator.c b/dir-iterator.c
> index b17e9f970a..0f9ed95958 100644
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
> @@ -45,34 +45,53 @@ struct dir_iterator_int {
>   
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
> +	if (!S_ISDIR(iter->base.st.st_mode)) return 0;
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
> + * Activate most recent pushed level.
> + *
> + * Return 1 on success.
> + * Return -1 on failure when errno == ENOENT, leaving the stack unchanged.
> + * Return -2 on failure when errno != ENOENT, leaving the stack unchanged.
> + */
> +static int activate_level(struct dir_iterator_int *iter)
> +{
> +	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
> +	int saved_errno;
> +
> +	if (level->dir)
> +		return 1;
> +
> +	if ((level->dir = opendir(iter->base.path.buf)) != NULL)
> +		return 1;
> +
> +	saved_errno = errno;
> +	if (errno != ENOENT) {
> +		warning_errno("error opening directory '%s'", iter->base.path.buf);
>   		errno = saved_errno;
> -		return -1;
> +		return -2;
>   	}
> -
> -	return 0;
> +	errno = saved_errno;
> +	return -1;
>   }
>   
>   /*
> @@ -81,12 +100,10 @@ static int push_level(struct dir_iterator_int *iter)
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
> @@ -94,82 +111,121 @@ static int pop_level(struct dir_iterator_int *iter)
>   
>   /*
>    * Populate iter->base with the necessary information on the next iteration
> - * entry, represented by the given dirent de. Return 0 on success and -1
> - * otherwise, setting errno accordingly.
> + * entry, represented by the given relative path to the lowermost directory,
> + * d_name.
> + *
> + * Return values:
> + * 1 on successful exposure of the provided entry.
> + * -1 on failed exposure because entry does not exist.
> + * -2 on failed exposure because of error other than ENOENT.
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
> +		return -2;  // Stat failed not with ENOENT.
> +	} else if (stat_err && errno == ENOENT)
> +		return -1;  // Stat failed with ENOENT.
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
> +	return 1;
>   }
>   
>   int dir_iterator_advance(struct dir_iterator *dir_iterator)
>   {
> -	struct dir_iterator_int *iter =
> -		(struct dir_iterator_int *)dir_iterator;
> -
> -	if (S_ISDIR(iter->base.st.st_mode) && push_level(iter)) {
> -		if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
> -			goto error_out;
> -		if (iter->levels_nr == 0)
> -			goto error_out;
> +	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
> +	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
> +
> +	struct dirent *dir_entry = NULL;
> +
> +	int expose_err, activate_err;
> +
> +	/* For shorter code width-wise, more readable */
> +	unsigned int PEDANTIC = iter->flags & DIR_ITERATOR_PEDANTIC;
> +
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
> +	if (activate_err == -2 && PEDANTIC)
> +		goto error_out;
> +	else if (activate_err == -2 || activate_err == -1) {
> +		/*
> +		 * We activate the root level at `dir_iterator_begin()`.
> +		 * Therefore, there isn't any case to run out of levels.
> +		 */
> +
> +		--iter->levels_nr;
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
> +	if (dir_entry == NULL) {
> +		if (errno) {
> +			warning_errno("errno reading dir '%s'", iter->base.path.buf);
> +			if (iter->flags & DIR_ITERATOR_PEDANTIC) goto error_out;
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
> +	if (expose_err == -2 && PEDANTIC)
> +		goto error_out;
> +
> +	if (expose_err == 1)
> +		push_level(iter);
> +
> +	if (expose_err == -1)
> +		return dir_iterator_advance(dir_iterator);
> +
> +	return ITER_OK;
>   
>   error_out:
>   	dir_iterator_abort(dir_iterator);
> @@ -207,6 +263,7 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
>   
>   	strbuf_init(&iter->base.path, PATH_MAX);
>   	strbuf_addstr(&iter->base.path, path);
> +	strbuf_trim_trailing_dir_sep(&iter->base.path);
>   
>   	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
>   	iter->levels_nr = 0;
> @@ -226,6 +283,16 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
>   		goto error_out;
>   	}
>   
> +	if (push_level(iter) != 1) {
> +		saved_errno = ENOTDIR;
> +		goto error_out;
> +	}
> +
> +	if (activate_level(iter) != 1) {
> +		saved_errno = errno;
> +		goto error_out;
> +	}
> +
>   	return dir_iterator;
>   
>   error_out:
> diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
> index 0a98dd54ba..2437ab21c4 100755
> --- a/t/t0066-dir-iterator.sh
> +++ b/t/t0066-dir-iterator.sh
> @@ -285,7 +285,7 @@ test_expect_success 'iteration of dir w/ complex structure w/o symlinks' '
>   '
>   
>   test_expect_success POSIXPERM,SANITY \
> -'dir_iterator_advance() should fail on root dir w/o perms' '
> +'dir_iterator_begin() should fail on root dir w/o perms' '
>   
>   	mkdir -p dir12/a &&
>   	>dir12/a/b &&
> @@ -293,7 +293,7 @@ test_expect_success POSIXPERM,SANITY \
>   
>   
>   	cat >expected-no-permissions-out <<-EOF &&
> -	dir_iterator_advance failure
> +	dir_iterator_begin failure: ESOMETHINGELSE
>   	EOF
>   
>   	test_must_fail test-tool dir-iterator ./dir12 >actual-out &&

