Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C46BC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 13:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbiEJNLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 09:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiEJNLx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 09:11:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717AE53B4B
        for <git@vger.kernel.org>; Tue, 10 May 2022 06:07:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q20so10156980wmq.1
        for <git@vger.kernel.org>; Tue, 10 May 2022 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q16qtkh1z3k5SUlfh9F2b7wa0/HzgPoBj30bupPZ1Bk=;
        b=EUXr146LB0ZqYDngfCGL1u6dsfeeUOkpEK4Mowi7tjp3Nmykb95q9gCDExLQO+4wev
         hhgloo33Cif69GDGIZYuDuB+okyDs60dhw9IE2uM/pvK5rKcA8XGXIgStMjtXRZ7baek
         oaNyXOsKUwaxV66CztYh92O5Cmr7CrLhgueGe9omOsl66eHz94qeO9pGjo5cJ3VUee0X
         2c78SszUO8wT6hr1d2bvKXRZ97uh55UG4/8eQwvn5MucHmM/gnPKXyy+PFxSlw30OsnE
         nJnkUidV8sDphfSTEYj2P7bk8SQQ/TBfdtZ/PbOKtR3P/hj8rjA806IFAM9QQaZGY64s
         5lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q16qtkh1z3k5SUlfh9F2b7wa0/HzgPoBj30bupPZ1Bk=;
        b=bHZbSBKFzZzMtr6Jx0a9sd/iLw3Y3iJUBAY2KA9knSo2HFdXOE78nY43OFZawCkdpR
         ggyBBAzO9yEbjCy9GkWeZywoFfa0DRWslCb1lKxHYwbFba2yPaMJtjRch908kXVgpO2s
         qZpOYwlSWGrU+CyNJm8ADTK6YZN2REZ5NqCYjAKUH3XLNyt8BiqPyEnPNEFN50igcGZ8
         GHusZrG8FByL20UgNDG4OqpyK6vZHRh4/DTYBVaxvjpP5e34YIwjDUxGv+Ima0RSarzF
         PHfyLH5npaIHpPNexcGws4snxg/rr0O1LhhAN6diH87vda29+ennIunxtHmDoJyOFI6n
         iwZw==
X-Gm-Message-State: AOAM531NemBXur4Y+jcg0rh3BNZ6VMGGIAx1YzVE8lOE9VVwLnNtWL/1
        4/RFv9/DhmGc5TzAFc/vVO6AL6niFxM=
X-Google-Smtp-Source: ABdhPJxjrSXO/ox7jTZmau2biTqYbQU8pr3PXr8JELZZuKM5/8rnaalUUKF3ZJlZoM6EsmhCkThHWQ==
X-Received: by 2002:a05:600c:1d95:b0:394:5d0d:6f70 with SMTP id p21-20020a05600c1d9500b003945d0d6f70mr21482499wms.48.1652188072629;
        Tue, 10 May 2022 06:07:52 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id a15-20020a056000100f00b0020c5253d8d9sm14040800wrx.37.2022.05.10.06.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 06:07:52 -0700 (PDT)
Message-ID: <88421b18-0fa0-236a-b74b-c5ee3ef53279@gmail.com>
Date:   Tue, 10 May 2022 14:07:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 13/15] dir-iterator: option to iterate dirs in
 pre-order
Content-Language: en-US
To:     Plato Kiorpelidis <kioplato@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com
References: <20220509175159.2948802-1-kioplato@gmail.com>
 <20220509175159.2948802-14-kioplato@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220509175159.2948802-14-kioplato@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Plato

On 09/05/2022 18:51, Plato Kiorpelidis wrote:
> Introduce a new option to dir-iterator, using dir_iterator_begin()
> flags parameter, allowing to control whether or not directories will
> be exposed before their contents. In essence, pre-order traversal over
> file system entries that are directories.
> 
> This changes the default behavior of the dir-iterator API. Instead
> of iterating directories before doing so over their contents, the new
> default behavior does not expose directories at all. Iteration is still
> performed, however, within directories, iterating over any other entry.
> Only directory paths are ignored.
> 
> To iterate over directories in pre-order, reproducing the previous
> default behavior, enable the new flag DIR_ITERATOR_DIRS_BEFORE in the
> flags parameter of dir_iterator_begin():
>    * ignore directories by not setting DIR_ITERATOR_DIRS_BEFORE
>    * iterate directories pre-order by enabling DIR_ITERATOR_DIRS_BEFORE
> 
> Adjust existing callers, in refs/files-backend.c and builtin/clone.c
> to enable DIR_ITERATOR_DIRS_BEFORE since these callers require iteration
> over directories before doing so over their contents.
> 
> Update t/t0066-dir-iterator.sh and t/helper/test-dir-iterator.c to test
> the new iteration scheme, which is the new default behavior, and the new
> flag DIR_ITERATOR_DIRS_BEFORE which reproduces the old default behavior.

It's great that you've split this change out from the next patch. I had 
not realized when I looked at the last round that all the existing 
callers require pre-order traversal. Given that is the case I'm finding 
it hard to see how changing the default behavior to one that no caller 
is using is an improvement.

Best Wishes

Phillip

> Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> ---
>   builtin/clone.c              |   4 +-
>   dir-iterator.c               |  29 +++-
>   dir-iterator.h               |  29 +++-
>   refs/files-backend.c         |   2 +-
>   t/helper/test-dir-iterator.c |  12 +-
>   t/t0066-dir-iterator.sh      | 321 ++++++++++++++++++++++++++++++++---
>   6 files changed, 361 insertions(+), 36 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 194d50f75f..68787623e7 100644
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
> index c36f549a78..c1475add27 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -47,6 +47,7 @@ enum {
>   	OK,
>   	FAIL_ENOENT,
>   	FAIL_NOT_ENOENT,
> +	FAIL_IGN_DIRS,
>   };
>   
>   /*
> @@ -124,12 +125,14 @@ static int pop_level(struct dir_iterator_int *iter)
>    *
>    * Return values:
>    * OK on successful exposure of the provided entry.
> + * FAIL_IGN_DIR on failed exposure because entry is dir and flags don't allow it.
>    * FAIL_ENOENT on failed exposure because entry does not exist.
>    * FAIL_NOT_ENOENT on failed exposure because of errno other than ENOENT.
>    */
> -static int expose_entry(struct dir_iterator_int *iter, char *d_name)
> +static int expose_entry(struct dir_iterator_int *iter, char *d_name, char *dir_state)
>   {
>   	int stat_err;
> +	unsigned int DIRS_BEFORE = iter->flags & DIR_ITERATOR_DIRS_BEFORE;
>   
>   	strbuf_addch(&iter->base.path, '/');
>   	strbuf_addstr(&iter->base.path, d_name);
> @@ -146,6 +149,17 @@ static int expose_entry(struct dir_iterator_int *iter, char *d_name)
>   		return FAIL_ENOENT;
>   	}
>   
> +	/*
> +	 * We've got to check whether or not this is a directory. We need to
> +	 * perform this check since the user could've requested to ignore
> +	 * directory entries.
> +	 */
> +
> +	if (S_ISDIR(iter->base.st.st_mode)) {
> +		if (!DIRS_BEFORE && !strcmp(dir_state, "before"))
> +			return FAIL_IGN_DIRS;
> +	}
> +
>   	/*
>   	 * We have to reset relative path and basename because the path strbuf
>   	 * might have been realloc()'ed at the previous strbuf_addstr().
> @@ -220,14 +234,23 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
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
>   	if (expose_err == FAIL_NOT_ENOENT && PEDANTIC)
>   		goto error_out;
>   
> -	if (expose_err == OK)
> +	if (expose_err == OK || expose_err == FAIL_IGN_DIRS)
>   		push_level(iter);
>   
>   	if (expose_err != OK)
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 08229157c6..c1d16a8c6d 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -8,19 +8,22 @@
>    *
>    * Iterate over a directory tree, recursively, including paths of all
>    * types and hidden paths. Skip "." and ".." entries and don't follow
> - * symlinks except for the original path. Note that the original path
> - * is not included in the iteration.
> + * symlinks except when DIR_ITERATOR_FOLLOW_SYMLINKS is set. If root
> + * path is a symlink it's followed regardless of flags. Note that the
> + * original path is not included in the iteration.
>    *
>    * Every time dir_iterator_advance() is called, update the members of
>    * the dir_iterator structure to reflect the next path in the
>    * iteration. The order that paths are iterated over within a
> - * directory is undefined, directory paths are always given before
> - * their contents.
> + * directory is undefined. Directory paths are given before their
> + * contents when DIR_ITERATOR_DIRS_BEFORE is set. Failure to set this
> + * flag results in directory paths not being exposed. Instead, iteration
> + * will happen within directories. Their contents will be exposed.
>    *
>    * A typical iteration looks like this:
>    *
>    *     int ok;
> - *     unsigned int flags = DIR_ITERATOR_PEDANTIC;
> + *     unsigned int flags = DIR_ITERATOR_PEDANTIC | DIR_ITERATOR_DIRS_BEFORE;
>    *     struct dir_iterator *iter = dir_iterator_begin(path, flags);
>    *
>    *     if (!iter)
> @@ -61,12 +64,19 @@
>    *   not the symlinks themselves, which is the default behavior. Broken
>    *   symlinks are ignored.
>    *
> + * - DIR_ITERATOR_DIRS_BEFORE: make dir-iterator expose a directory path
> + *   before iterating through that directory's contents.
> + *
> + * Note: Activating none of the flags will iterate through directories'
> + * contents but won't expose the directory paths.
> + *
>    * Warning: circular symlinks are also followed when
>    * DIR_ITERATOR_FOLLOW_SYMLINKS is set. The iteration may end up with
>    * an ELOOP if they happen and DIR_ITERATOR_PEDANTIC is set.
>    */
>   #define DIR_ITERATOR_PEDANTIC (1 << 0)
>   #define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
> +#define DIR_ITERATOR_DIRS_BEFORE (1 << 2)
>   
>   struct dir_iterator {
>   	/* The current path: */
> @@ -97,12 +107,13 @@ struct dir_iterator {
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
> + *    dir-iterator or 0 for default behavior which will ignore directory
> + *    paths, but will include the rest directory contents.
>    */
>   struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags);
>   
> @@ -110,6 +121,7 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags);
>    * Advance the iterator to the first or next item and return ITER_OK.
>    * If the iteration is exhausted, free the dir_iterator and any
>    * resources associated with it and return ITER_DONE.
> + * On error, free dir_iterator memory and return ITER_ERROR.
>    *
>    * It is a bug to use iterator or call this function again after it
>    * has returned ITER_DONE or ITER_ERROR (which may be returned iff
> @@ -119,8 +131,7 @@ int dir_iterator_advance(struct dir_iterator *iterator);
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
> index 8db7882aac..812f00c0f4 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2237,7 +2237,7 @@ static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
>   
>   	strbuf_addf(&sb, "%s/logs", gitdir);
>   
> -	diter = dir_iterator_begin(sb.buf, 0);
> +	diter = dir_iterator_begin(sb.buf, DIR_ITERATOR_DIRS_BEFORE);
>   	if (!diter) {
>   		strbuf_release(&sb);
>   		return empty_ref_iterator_begin();
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> index 55d8a58836..f05d5fde9d 100644
> --- a/t/helper/test-dir-iterator.c
> +++ b/t/helper/test-dir-iterator.c
> @@ -17,7 +17,15 @@ static const char *error_name(int error_number)
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
> + *
> + * example:
> + * test-tool dir-iterator --pedantic --dirs-before ./somedir
>    */
>   int cmd__dir_iterator(int argc, const char **argv)
>   {
> @@ -30,6 +38,8 @@ int cmd__dir_iterator(int argc, const char **argv)
>   			flags |= DIR_ITERATOR_FOLLOW_SYMLINKS;
>   		else if (strcmp(*argv, "--pedantic") == 0)
>   			flags |= DIR_ITERATOR_PEDANTIC;
> +		else if (strcmp(*argv, "--dirs-before") == 0)
> +			flags |= DIR_ITERATOR_DIRS_BEFORE;
>   		else
>   			die("invalid option '%s'", *argv);
>   	}
> diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
> index 8ab8811fb5..badd82d8a4 100755
> --- a/t/t0066-dir-iterator.sh
> +++ b/t/t0066-dir-iterator.sh
> @@ -9,7 +9,7 @@ test_expect_success 'setup -- dir with a single file' '
>   	mkdir dir1 &&
>   	>dir1/a
>   '
> -test_expect_success 'dirs-before of dir with a file' '
> +test_expect_success 'dirs-ignore of dir with a file' '
>   	cat >expected-out <<-EOF &&
>   	[f] (a) [a] ./dir1/a
>   	EOF
> @@ -17,22 +17,60 @@ test_expect_success 'dirs-before of dir with a file' '
>   	test-tool dir-iterator ./dir1 >actual-out &&
>   	test_cmp expected-out actual-out
>   '
> +test_expect_success 'dirs-before of dir with a file' '
> +	cat >expected-out <<-EOF &&
> +	[f] (a) [a] ./dir1/a
> +	EOF
> +
> +	test-tool dir-iterator --dirs-before ./dir1 >actual-out &&
> +	test_cmp expected-out actual-out
> +'
>   
>   test_expect_success 'setup -- dir with a single dir' '
>   	mkdir -p dir2/a
>   '
> +test_expect_success 'dirs-ignore of dir with a single dir' '
> +	cat >expected-out <<-EOF &&
> +	EOF
> +
> +	test-tool dir-iterator ./dir2 >actual-out &&
> +	test_cmp expected-out actual-out
> +'
>   test_expect_success 'dirs-before of dir with a single dir' '
>   	cat >expected-out <<-EOF &&
>   	[d] (a) [a] ./dir2/a
>   	EOF
>   
> -	test-tool dir-iterator ./dir2 >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir2 >actual-out &&
>   	test_cmp expected-out actual-out
>   '
>   
>   test_expect_success POSIXPERM,SANITY 'setup -- dir w/ single dir w/o perms' '
>   	mkdir -p dir3/a
>   '
> +test_expect_success POSIXPERM,SANITY 'dirs-ignore of dir w/ dir w/o perms' '
> +	cat >expected-out <<-EOF &&
> +	EOF
> +
> +	chmod 0 dir3/a &&
> +
> +	test-tool dir-iterator ./dir3/ >actual-out &&
> +	test_cmp expected-out actual-out &&
> +
> +	chmod 755 dir3/a
> +'
> +test_expect_success POSIXPERM,SANITY 'pedantic dirs-ignore of dir w/ dir w/o perms' '
> +	cat >expected-out <<-EOF &&
> +	dir_iterator_advance failure: EACCES
> +	EOF
> +
> +	chmod 0 dir3/a &&
> +
> +	test_must_fail test-tool dir-iterator --pedantic ./dir3/ >actual-out &&
> +	test_cmp expected-out actual-out &&
> +
> +	chmod 755 dir3/a
> +'
>   test_expect_success POSIXPERM,SANITY 'dirs-before of dir w/ dir w/o perms' '
>   	cat >expected-out <<-EOF &&
>   	[d] (a) [a] ./dir3/a
> @@ -40,7 +78,7 @@ test_expect_success POSIXPERM,SANITY 'dirs-before of dir w/ dir w/o perms' '
>   
>   	chmod 0 dir3/a &&
>   
> -	test-tool dir-iterator ./dir3/ >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir3/ >actual-out &&
>   	test_cmp expected-out actual-out &&
>   
>   	chmod 755 dir3/a
> @@ -53,7 +91,8 @@ test_expect_success POSIXPERM,SANITY 'pedantic dirs-before of dir w/ dir w/o per
>   
>   	chmod 0 dir3/a &&
>   
> -	test_must_fail test-tool dir-iterator --pedantic ./dir3/ >actual-out &&
> +	test_must_fail test-tool dir-iterator --dirs-before \
> +		--pedantic ./dir3/ >actual-out &&
>   	test_cmp expected-out actual-out &&
>   
>   	chmod 755 dir3/a
> @@ -67,7 +106,7 @@ test_expect_success 'setup -- dir w/ five files' '
>   	>dir4/d &&
>   	>dir4/e
>   '
> -test_expect_success 'dirs-before of dir w/ five files' '
> +test_expect_success 'dirs-ignore of dir w/ five files' '
>   	cat >expected-sorted-out <<-EOF &&
>   	[f] (a) [a] ./dir4/a
>   	[f] (b) [b] ./dir4/b
> @@ -81,18 +120,40 @@ test_expect_success 'dirs-before of dir w/ five files' '
>   
>   	test_cmp expected-sorted-out actual-sorted-out
>   '
> +test_expect_success 'dirs-before of dir w/ five files' '
> +	cat >expected-sorted-out <<-EOF &&
> +	[f] (a) [a] ./dir4/a
> +	[f] (b) [b] ./dir4/b
> +	[f] (c) [c] ./dir4/c
> +	[f] (d) [d] ./dir4/d
> +	[f] (e) [e] ./dir4/e
> +	EOF
> +
> +	test-tool dir-iterator --dirs-before ./dir4 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-sorted-out actual-sorted-out
> +'
>   
>   test_expect_success 'setup -- dir w/ dir w/ a file' '
>   	mkdir -p dir5/a &&
>   	>dir5/a/b
>   '
> +test_expect_success 'dirs-ignore of dir w/ dir w/ a file' '
> +	cat >expected-out <<-EOF &&
> +	[f] (a/b) [b] ./dir5/a/b
> +	EOF
> +
> +	test-tool dir-iterator ./dir5 >actual-out &&
> +	test_cmp expected-out actual-out
> +'
>   test_expect_success 'dirs-before of dir w/ dir w/ a file' '
>   	cat >expected-out <<-EOF &&
>   	[d] (a) [a] ./dir5/a
>   	[f] (a/b) [b] ./dir5/a/b
>   	EOF
>   
> -	test-tool dir-iterator ./dir5 >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir5 >actual-out &&
>   	test_cmp expected-out actual-out
>   '
>   
> @@ -100,6 +161,14 @@ test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
>   	mkdir -p dir6/a/b/c &&
>   	>dir6/a/b/c/d
>   '
> +test_expect_success 'dirs-ignore of dir w/ three nested dirs w/ file' '
> +	cat >expected-out <<-EOF &&
> +	[f] (a/b/c/d) [d] ./dir6/a/b/c/d
> +	EOF
> +
> +	test-tool dir-iterator ./dir6 >actual-out &&
> +	test_cmp expected-out actual-out
> +'
>   test_expect_success 'dirs-before of dir w/ three nested dirs w/ file' '
>   	cat >expected-out <<-EOF &&
>   	[d] (a) [a] ./dir6/a
> @@ -108,7 +177,7 @@ test_expect_success 'dirs-before of dir w/ three nested dirs w/ file' '
>   	[f] (a/b/c/d) [d] ./dir6/a/b/c/d
>   	EOF
>   
> -	test-tool dir-iterator ./dir6 >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir6 >actual-out &&
>   	test_cmp expected-out actual-out
>   '
>   
> @@ -119,6 +188,33 @@ test_expect_success POSIXPERM,SANITY \
>   	>dir7/a/b/c/d
>   '
>   test_expect_success POSIXPERM,SANITY \
> +'dirs-ignore of dir w/ three nested dirs w/ file, second w/o perms' '
> +
> +	cat >expected-out <<-EOF &&
> +	EOF
> +
> +	chmod 0 dir7/a/b &&
> +
> +	test-tool dir-iterator ./dir7 >actual-out &&
> +	test_cmp expected-out actual-out &&
> +
> +	chmod 755 dir7/a/b
> +'
> +test_expect_success POSIXPERM,SANITY \
> +'pedantic dirs-ignore of dir w/ three nested dirs w/ file, second w/o perms' '
> +
> +	cat >expected-out <<-EOF &&
> +	dir_iterator_advance failure: EACCES
> +	EOF
> +
> +	chmod 0 dir7/a/b &&
> +
> +	test_must_fail test-tool dir-iterator --pedantic ./dir7 >actual-out &&
> +	test_cmp expected-out actual-out &&
> +
> +	chmod 755 dir7/a/b
> +'
> +test_expect_success POSIXPERM,SANITY \
>   'dirs-before of dir w/ three nested dirs w/ file, second w/o perms' '
>   
>   	cat >expected-out <<-EOF &&
> @@ -128,7 +224,7 @@ test_expect_success POSIXPERM,SANITY \
>   
>   	chmod 0 dir7/a/b &&
>   
> -	test-tool dir-iterator ./dir7 >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir7 >actual-out &&
>   	test_cmp expected-out actual-out &&
>   
>   	chmod 755 dir7/a/b
> @@ -144,7 +240,8 @@ test_expect_success POSIXPERM,SANITY \
>   
>   	chmod 0 dir7/a/b &&
>   
> -	test_must_fail test-tool dir-iterator --pedantic ./dir7 >actual-out &&
> +	test_must_fail test-tool dir-iterator --dirs-before \
> +		--pedantic ./dir7 >actual-out &&
>   	test_cmp expected-out actual-out &&
>   
>   	chmod 755 dir7/a/b
> @@ -156,6 +253,22 @@ test_expect_success 'setup -- dir w/ two dirs each w/ file' '
>   	mkdir dir8/c &&
>   	>dir8/c/d
>   '
> +test_expect_success 'dirs-ignore of dir w/ two dirs each w/ file' '
> +	cat >expected-out1 <<-EOF &&
> +	[f] (a/b) [b] ./dir8/a/b
> +	[f] (c/d) [d] ./dir8/c/d
> +	EOF
> +	cat >expected-out2 <<-EOF &&
> +	[f] (c/d) [d] ./dir8/c/d
> +	[f] (a/b) [b] ./dir8/a/b
> +	EOF
> +
> +	test-tool dir-iterator ./dir8 >actual-out &&
> +	(
> +		test_cmp expected-out1 actual-out ||
> +		test_cmp expected-out2 actual-out
> +	)
> +'
>   test_expect_success 'dirs-before of dir w/ two dirs each w/ file' '
>   	cat >expected-out1 <<-EOF &&
>   	[d] (a) [a] ./dir8/a
> @@ -170,7 +283,7 @@ test_expect_success 'dirs-before of dir w/ two dirs each w/ file' '
>   	[f] (a/b) [b] ./dir8/a/b
>   	EOF
>   
> -	test-tool dir-iterator ./dir8 >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir8 >actual-out &&
>   	(
>   		test_cmp expected-out1 actual-out ||
>   		test_cmp expected-out2 actual-out
> @@ -185,6 +298,38 @@ test_expect_success 'setup -- dir w/ two dirs, one w/ two and one w/ one files'
>   	>dir9/d/e
>   '
>   test_expect_success \
> +'dirs-ignore of dir w/ two dirs, one w/ two and one w/ one files' '
> +
> +	cat >expected-out1 <<-EOF &&
> +	[f] (a/b) [b] ./dir9/a/b
> +	[f] (a/c) [c] ./dir9/a/c
> +	[f] (d/e) [e] ./dir9/d/e
> +	EOF
> +	cat >expected-out2 <<-EOF &&
> +	[f] (a/c) [c] ./dir9/a/c
> +	[f] (a/b) [b] ./dir9/a/b
> +	[f] (d/e) [e] ./dir9/d/e
> +	EOF
> +	cat >expected-out3 <<-EOF &&
> +	[f] (d/e) [e] ./dir9/d/e
> +	[f] (a/b) [b] ./dir9/a/b
> +	[f] (a/c) [c] ./dir9/a/c
> +	EOF
> +	cat >expected-out4 <<-EOF &&
> +	[f] (d/e) [e] ./dir9/d/e
> +	[f] (a/c) [c] ./dir9/a/c
> +	[f] (a/b) [b] ./dir9/a/b
> +	EOF
> +
> +	test-tool dir-iterator ./dir9 >actual-out &&
> +	(
> +		test_cmp expected-out1 actual-out ||
> +		test_cmp expected-out2 actual-out ||
> +		test_cmp expected-out3 actual-out ||
> +		test_cmp expected-out4 actual-out
> +	)
> +'
> +test_expect_success \
>   'dirs-before of dir w/ two dirs, one w/ two and one w/ one files' '
>   
>   	cat >expected-out1 <<-EOF &&
> @@ -216,7 +361,7 @@ test_expect_success \
>   	[f] (a/b) [b] ./dir9/a/b
>   	EOF
>   
> -	test-tool dir-iterator ./dir9 >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir9 >actual-out &&
>   	(
>   		test_cmp expected-out1 actual-out ||
>   		test_cmp expected-out2 actual-out ||
> @@ -231,6 +376,22 @@ test_expect_success 'setup -- dir w/ two nested dirs, each w/ file' '
>   	mkdir dir10/a/c &&
>   	>dir10/a/c/d
>   '
> +test_expect_success 'dirs-ignore of dir w/ two nested dirs, each w/ file' '
> +	cat >expected-out1 <<-EOF &&
> +	[f] (a/b) [b] ./dir10/a/b
> +	[f] (a/c/d) [d] ./dir10/a/c/d
> +	EOF
> +	cat >expected-out2 <<-EOF &&
> +	[f] (a/c/d) [d] ./dir10/a/c/d
> +	[f] (a/b) [b] ./dir10/a/b
> +	EOF
> +
> +	test-tool dir-iterator ./dir10/ >actual-out &&
> +	(
> +		test_cmp expected-out1 actual-out ||
> +		test_cmp expected-out2 actual-out
> +	)
> +'
>   test_expect_success 'dirs-before of dir w/ two nested dirs, each w/ file' '
>   	cat >expected-out1 <<-EOF &&
>   	[d] (a) [a] ./dir10/a
> @@ -245,7 +406,7 @@ test_expect_success 'dirs-before of dir w/ two nested dirs, each w/ file' '
>   	[f] (a/b) [b] ./dir10/a/b
>   	EOF
>   
> -	test-tool dir-iterator ./dir10/ >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir10/ >actual-out &&
>   	(
>   		test_cmp expected-out1 actual-out ||
>   		test_cmp expected-out2 actual-out
> @@ -262,6 +423,20 @@ test_expect_success 'setup -- dir w/ complex structure' '
>   	>dir11/a/e &&
>   	>dir11/d/e/d/a
>   '
> +test_expect_success 'dirs-ignore of dir w/ complex structure' '
> +	cat >expected-sorted-out <<-EOF &&
> +	[f] (a/b/c/d) [d] ./dir11/a/b/c/d
> +	[f] (a/e) [e] ./dir11/a/e
> +	[f] (b) [b] ./dir11/b
> +	[f] (c) [c] ./dir11/c
> +	[f] (d/e/d/a) [a] ./dir11/d/e/d/a
> +	EOF
> +
> +	test-tool dir-iterator ./dir11 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-sorted-out actual-sorted-out
> +'
>   test_expect_success 'dirs-before of dir w/ complex structure' '
>   	cat >expected-sorted-out <<-EOF &&
>   	[d] (a) [a] ./dir11/a
> @@ -277,7 +452,7 @@ test_expect_success 'dirs-before of dir w/ complex structure' '
>   	[f] (d/e/d/a) [a] ./dir11/d/e/d/a
>   	EOF
>   
> -	test-tool dir-iterator ./dir11 >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir11 >actual-out &&
>   	sort actual-out >actual-sorted-out &&
>   
>   	test_cmp expected-sorted-out actual-sorted-out
> @@ -287,7 +462,7 @@ test_expect_success POSIXPERM,SANITY 'setup -- dir w/o perms' '
>   	mkdir -p dir12/a &&
>   	>dir12/a/b
>   '
> -test_expect_success POSIXPERM,SANITY 'dirs-before of root dir w/o perms' '
> +test_expect_success POSIXPERM,SANITY 'dirs-ignore of root dir w/o perms' '
>   	cat >expected-out <<-EOF &&
>   	dir_iterator_begin failure: EACCES
>   	EOF
> @@ -299,7 +474,7 @@ test_expect_success POSIXPERM,SANITY 'dirs-before of root dir w/o perms' '
>   
>   	chmod 755 dir12
>   '
> -test_expect_success POSIXPERM,SANITY 'pedantic dirs-before of root dir w/o perms' '
> +test_expect_success POSIXPERM,SANITY 'pedantic dirs-ignore of root dir w/o perms' '
>   	cat >expected-out <<-EOF &&
>   	dir_iterator_begin failure: EACCES
>   	EOF
> @@ -311,6 +486,31 @@ test_expect_success POSIXPERM,SANITY 'pedantic dirs-before of root dir w/o perms
>   
>   	chmod 755 dir12
>   '
> +test_expect_success POSIXPERM,SANITY 'dirs-before of root dir w/o perms' '
> +	cat >expected-out <<-EOF &&
> +	dir_iterator_begin failure: EACCES
> +	EOF
> +
> +	chmod 0 dir12 &&
> +
> +	test_must_fail test-tool dir-iterator --dirs-before ./dir12 >actual-out &&
> +	test_cmp expected-out actual-out &&
> +
> +	chmod 755 dir12
> +'
> +test_expect_success POSIXPERM,SANITY 'pedantic dirs-before of root dir w/o perms' '
> +	cat >expected-out <<-EOF &&
> +	dir_iterator_begin failure: EACCES
> +	EOF
> +
> +	chmod 0 dir12 &&
> +
> +	test_must_fail test-tool dir-iterator --dirs-before \
> +		--pedantic ./dir12 >actual-out &&
> +	test_cmp expected-out actual-out &&
> +
> +	chmod 755 dir12
> +'
>   
>   test_expect_success 'begin should fail upon inexistent paths' '
>   	echo "dir_iterator_begin failure: ENOENT" >expected-out &&
> @@ -335,6 +535,33 @@ test_expect_success POSIXPERM,SANITY 'setup -- dir w/ dir w/o perms w/ file' '
>   	>dir13/a/b
>   '
>   test_expect_success POSIXPERM,SANITY \
> +'dirs-ignore of dir w/ dir w/o perms w/ file' '
> +
> +	cat >expected-out <<-EOF &&
> +	EOF
> +
> +	chmod 0 dir13/a &&
> +
> +	test-tool dir-iterator ./dir13 >actual-out &&
> +	test_cmp expected-out actual-out &&
> +
> +	chmod 755 dir13/a
> +'
> +test_expect_success POSIXPERM,SANITY \
> +'pedantic dirs-ignore of dir w/ dir w/o perms w/ file' '
> +
> +	cat >expected-out <<-EOF &&
> +	dir_iterator_advance failure: EACCES
> +	EOF
> +
> +	chmod 0 dir13/a &&
> +
> +	test_must_fail test-tool dir-iterator --pedantic ./dir13 >actual-out &&
> +	test_cmp expected-out actual-out &&
> +
> +	chmod 755 dir13/a
> +'
> +test_expect_success POSIXPERM,SANITY \
>   'dirs-before of dir w/ dir w/o perms w/ file' '
>   
>   	cat >expected-out <<-EOF &&
> @@ -343,7 +570,7 @@ test_expect_success POSIXPERM,SANITY \
>   
>   	chmod 0 dir13/a &&
>   
> -	test-tool dir-iterator ./dir13 >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir13 >actual-out &&
>   	test_cmp expected-out actual-out &&
>   
>   	chmod 755 dir13/a
> @@ -358,7 +585,8 @@ test_expect_success POSIXPERM,SANITY \
>   
>   	chmod 0 dir13/a &&
>   
> -	test_must_fail test-tool dir-iterator --pedantic ./dir13 >actual-out &&
> +	test_must_fail test-tool dir-iterator --dirs-before \
> +		--pedantic ./dir13 >actual-out &&
>   	test_cmp expected-out actual-out &&
>   
>   	chmod 755 dir13/a
> @@ -371,6 +599,31 @@ test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
>   	ln -s d dir14/a/e &&
>   	ln -s ../b dir14/a/f
>   '
> +test_expect_success SYMLINKS 'dirs-ignore of dir w/ symlinks w/o cycle' '
> +	cat >expected-sorted-out <<-EOF &&
> +	[f] (a/d) [d] ./dir14/a/d
> +	[s] (a/e) [e] ./dir14/a/e
> +	[s] (a/f) [f] ./dir14/a/f
> +	EOF
> +
> +	test-tool dir-iterator ./dir14 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'follow-symlinks dirs-ignore of dir w/ symlinks, w/o cycle' '
> +
> +	cat >expected-sorted-out <<-EOF &&
> +	[f] (a/d) [d] ./dir14/a/d
> +	[f] (a/e) [e] ./dir14/a/e
> +	EOF
> +
> +	test-tool dir-iterator --follow-symlinks ./dir14 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-sorted-out actual-sorted-out
> +'
>   test_expect_success SYMLINKS 'dirs-before of dir w/ symlinks w/o cycle' '
>   	cat >expected-sorted-out <<-EOF &&
>   	[d] (a) [a] ./dir14/a
> @@ -381,7 +634,7 @@ test_expect_success SYMLINKS 'dirs-before of dir w/ symlinks w/o cycle' '
>   	[s] (a/f) [f] ./dir14/a/f
>   	EOF
>   
> -	test-tool dir-iterator ./dir14 >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir14 >actual-out &&
>   	sort actual-out >actual-sorted-out &&
>   
>   	test_cmp expected-sorted-out actual-sorted-out
> @@ -399,7 +652,7 @@ test_expect_success SYMLINKS \
>   	[f] (a/e) [e] ./dir14/a/e
>   	EOF
>   
> -	test-tool dir-iterator --follow-symlinks ./dir14 >actual-out &&
> +	test-tool dir-iterator --dirs-before --follow-symlinks ./dir14 >actual-out &&
>   	sort actual-out >actual-sorted-out &&
>   
>   	test_cmp expected-sorted-out actual-sorted-out
> @@ -412,7 +665,33 @@ test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/ cycle' '
>   	ln -s ../ dir15/a/b/e &&
>   	ln -s ../../ dir15/a/b/f
>   '
> +test_expect_success SYMLINKS 'dirs-ignore of dir w/ symlinks w/ cycle' '
> +	cat >expected-sorted-out <<-EOF &&
> +	[s] (a/b/d) [d] ./dir15/a/b/d
> +	[s] (a/b/e) [e] ./dir15/a/b/e
> +	[s] (a/b/f) [f] ./dir15/a/b/f
> +	EOF
> +
> +	test-tool dir-iterator ./dir15 >actual-out &&
> +	sort actual-out >actual-sorted-out &&
> +
> +	test_cmp expected-sorted-out actual-sorted-out
> +'
> +test_expect_success SYMLINKS \
> +'pedantic follow-symlinks dirs-ignore of dir w/ symlinks w/ cycle' '
> +
> +	cat >expected-tailed-out <<-EOF &&
> +	dir_iterator_advance failure: ELOOP
> +	EOF
> +
> +	test_must_fail test-tool dir-iterator \
> +		--pedantic --follow-symlinks ./dir15 >actual-out &&
> +	tail -n 1 actual-out >actual-tailed-out &&
> +
> +	test_cmp expected-tailed-out actual-tailed-out
> +'
>   test_expect_success SYMLINKS 'dirs-before of dir w/ symlinks w/ cycle' '
> +
>   	cat >expected-sorted-out <<-EOF &&
>   	[d] (a) [a] ./dir15/a
>   	[d] (a/b) [b] ./dir15/a/b
> @@ -422,7 +701,7 @@ test_expect_success SYMLINKS 'dirs-before of dir w/ symlinks w/ cycle' '
>   	[s] (a/b/f) [f] ./dir15/a/b/f
>   	EOF
>   
> -	test-tool dir-iterator ./dir15 >actual-out &&
> +	test-tool dir-iterator --dirs-before ./dir15 >actual-out &&
>   	sort actual-out >actual-sorted-out &&
>   
>   	test_cmp expected-sorted-out actual-sorted-out
> @@ -434,7 +713,7 @@ test_expect_success SYMLINKS \
>   	dir_iterator_advance failure: ELOOP
>   	EOF
>   
> -	test_must_fail test-tool dir-iterator \
> +	test_must_fail test-tool dir-iterator --dirs-before \
>   		--pedantic --follow-symlinks ./dir15 >actual-out &&
>   	tail -n 1 actual-out >actual-tailed-out &&
>   

