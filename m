Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 446361FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 06:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbdDQGxA (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 02:53:00 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43045 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932574AbdDQGw6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Apr 2017 02:52:58 -0400
X-AuditID: 12074412-4bbff70000000b04-ff-58f46648f42f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 45.E7.02820.84664F85; Mon, 17 Apr 2017 02:52:56 -0400 (EDT)
Received: from [192.168.69.190] (p5790773A.dip0.t-ipconnect.de [87.144.119.58])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3H6qsRf019477
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 17 Apr 2017 02:52:55 -0400
Subject: Re: [PATCH v8 4/5] dir_iterator: refactor state machine model
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
 <1491442767-54068-5-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9b8dd7f4-89d7-1257-4187-bfe362009253@alum.mit.edu>
Date:   Mon, 17 Apr 2017 08:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1491442767-54068-5-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqOuZ9iXC4Fwzq8XjT2/ZLLqudDNZ
        NPReYbbonvKW0WLz5nYWB1aPnbPusnss2FTqcfGSssfnTXIBLFFcNimpOZllqUX6dglcGQ8/
        L2ItWO5S8XvZddYGxglmXYycHBICJhINt/ewdTFycQgJ7GCS6Dl4gx3COc8kcerBN0aQKmEB
        N4kbfzqBEhwcIgLWEtfXeIGEhQTKJW4/X8wOYjML2Egcb+oFK2cT0JVY1NPMBGLzCthLrNo2
        hw3EZhFQlfh/cAcriC0qECIxZ+EDRogaQYmTM5+wgIznFHCU+HIvDGKknsSO679YIWx5ie1v
        5zBPYOSfhaRjFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdPLzSzRS00p3cQI
        CV2hHYzrT8odYhTgYFTi4bU49jlCiDWxrLgy9xCjJAeTkiivmOqXCCG+pPyUyozE4oz4otKc
        1OJDjBIczEoivC8SgHK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8
        IqlAjYJFqempFWmZOSUIaSYOTpDhPEDDS0FqeIsLEnOLM9Mh8qcYFaXEeUtTgBICIImM0jy4
        XlhqecUoDvSKMO8HkCoeYFqC634FNJgJaHBEANjgkkSElFQDo2SZfMxqDwmp09emhDWs8XKS
        dlTaOs3KcsVPEeagGAefW5kdOS+aJF5uNSizz76cn37cKfHHl3bOJxUX12j95b6/1v2ExU+3
        /67vL00+mnU40NBBhdtJfX7WH6kdkrKVe7TX2O05eC7r4+kETrfooql3RRPP+f1n8NzDwKfp
        yWkzyXtahMIvJZbijERDLeai4kQA/eRcXAgDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/06/2017 03:39 AM, Daniel Ferreira wrote:
> Perform major refactor of dir_iterator_advance(). dir_iterator has
> ceased to rely on a convoluted state machine mechanism of two loops and
> two state variables (level.initialized and level.dir_state). This serves
> to ease comprehension of the iterator mechanism and ease addition of new
> features to the iterator.
> 
> Create an option for the dir_iterator API to iterate over subdirectories
> only after having iterated through their contents. This feature was
> predicted, although not implemented by 0fe5043 ("dir_iterator: new API
> for iterating over a directory tree", 2016-06-18). This is useful for
> recursively removing a directory and calling rmdir() on a directory only
> after all of its contents have been wiped.
> 
> Add an option for the dir_iterator API to iterate over the root
> directory (the one it was initialized with) as well.
> 
> Add the "flags" parameter to dir_iterator_create, allowing for the
> aforementioned new features to be enabled. The new default behavior
> (i.e. flags set to 0) does not iterate over directories. Flag
> DIR_ITERATOR_PRE_ORDER_TRAVERSAL iterates over a directory before doing
> so over its contents. DIR_ITERATOR_POST_ORDER_TRAVERSAL iterates over a
> directory after doing so over its contents. DIR_ITERATOR_LIST_ROOT_DIR
> iterates over the root directory. These flags do not conflict with each
> other and may be used simultaneously.
> 
> Amend a call to dir_iterator_begin() in refs/files-backend.c to pass
> the flags parameter introduced.
> 
> Improve t/t0065-dir-iterator.sh and t/helper/test-dir-iterator.c to
> test "post-order" and "iterate-over-root" modes.
> 
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  dir-iterator.c               | 216 ++++++++++++++++++++++++++++++-------------
>  dir-iterator.h               |  35 +++++--
>  refs/files-backend.c         |   2 +-
>  t/helper/test-dir-iterator.c |  27 +++++-
>  t/t0065-dir-iterator.sh      |  44 ++++++++-
>  5 files changed, 245 insertions(+), 79 deletions(-)
> 
> diff --git a/dir-iterator.c b/dir-iterator.c
> index 9e073a0..4c919d1 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -4,8 +4,6 @@
>  #include "dir-iterator.h"
>  
>  struct dir_iterator_level {
> -	int initialized;
> -
>  	DIR *dir;
>  
>  	/*
> @@ -20,9 +18,20 @@ struct dir_iterator_level {
>  	 * iteration and also iterated into):
>  	 */
>  	enum {
> -		DIR_STATE_ITER,
> -		DIR_STATE_RECURSE
> +		DIR_STATE_PUSHED,
> +		DIR_STATE_PRE_ITERATION,
> +		DIR_STATE_ITERATING,
> +		DIR_STATE_POST_ITERATION,
> +		DIR_STATE_EXHAUSTED
>  	} dir_state;
> +
> +	/*
> +	 * The stat structure for the directory this level represents.
> +	 * It comes with a st_is_set flag which indicates whether it is,
> +	 * in fact, set.
> +	 */
> +	unsigned st_is_set : 1;

In another email I just agreed with you that it would probably be
cleaner to call `lstat()` on the top-level directory from
`dir_iterator_begin()`. But if that weren't an option, rather than
adding a new state variable `st_is_set`, it might be more natural to add
a new value, say `DIR_STATE_INITIALIZING`, to `dir_state`, and do the
special case initialization in the main loop in `dir_iterator_advance()`
rather than in `set_iterator_data()`.

> +	struct stat st;
>  };
>  
>  /*
> @@ -48,15 +57,23 @@ struct dir_iterator_int {
>  	 * that will be included in this iteration.
>  	 */
>  	struct dir_iterator_level *levels;
> +
> +	/* Holds the flags passed to dir_iterator_begin(). */
> +	unsigned flags;
>  };
>  
> -static void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
> +static void push_dir_level(struct dir_iterator_int *iter,
> +		struct dir_iterator_level *level, struct stat *st)

The `level` argument is no longer used.

>  {
> -	level->dir_state = DIR_STATE_RECURSE;
>  	ALLOC_GROW(iter->levels, iter->levels_nr + 1,
>  		   iter->levels_alloc);
> +
> +	/* Push a new level */
>  	level = &iter->levels[iter->levels_nr++];
> -	level->initialized = 0;
> +	level->dir = NULL;
> +	level->dir_state = DIR_STATE_PUSHED;
> +	level->st_is_set = 1;
> +	level->st = *st;
>  }
>  
> [...]
> +/*
> + * This function uses a state machine with the following states:
> + * -> DIR_STATE_PUSHED: the directory has been pushed to the
> + * iterator traversal tree.
> + * -> DIR_STATE_PRE_ITERATION: the directory is *NOT* initialized. The
> + * dirpath has already been returned if pre-order traversal is set.
> + * -> DIR_STATE_ITERATING: the directory is initialized. We are traversing
> + * through it.
> + * -> DIR_STATE_POST_ITERATION: the directory has been iterated through.
> + * We are ready to close it.
> + * -> DIR_STATE_EXHAUSTED: the directory is closed and ready to be popped.
> + */
>  int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  {
>  	struct dir_iterator_int *iter =
> @@ -97,7 +158,26 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			&iter->levels[iter->levels_nr - 1];
>  		struct dirent *de;

`de` is only used in one branch of the `if` statement. Its definition
could be moved there.

>  
> -		if (!level->initialized) {
> +		if (level->dir_state == DIR_STATE_PUSHED) {
> +			level->dir_state = DIR_STATE_PRE_ITERATION;
> +
> +			if (iter->flags & DIR_ITERATOR_PRE_ORDER_TRAVERSAL) {
> +				/* We may not want the root directory to be iterated over */
> +				if (iter->levels_nr != 1 ||
> +					(iter->flags & DIR_ITERATOR_LIST_ROOT_DIR)) {

These two `if` statements can be combined into one:

			/* We may not want the root directory to be iterated over */
			if ((iter->flags & DIR_ITERATOR_PRE_ORDER_TRAVERSAL) &&
			    (iter->levels_nr != 1 ||
			     (iter->flags & DIR_ITERATOR_LIST_ROOT_DIR))) {
				/* ... */


> +					/*
> +					 * This will only error if we fail to lstat() the
> +					 * root directory. In this case, we bail.
> +					 */
> +					if (set_iterator_data(iter, level)) {
> +						level->dir_state = DIR_STATE_EXHAUSTED;
> +						continue;
> +					}
> +
> +					return ITER_OK;
> +				}
> +			}
> +		} else if (level->dir_state == DIR_STATE_PRE_ITERATION) {
>  			/*
>  			 * Note: dir_iterator_begin() ensures that
>  			 * path is not the empty string.
> [...]
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 50188e9..c29dc68 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3346,7 +3346,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
>  	files_downcast(ref_store, 0, "reflog_iterator_begin");
>  
>  	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
> -	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
> +	iter->dir_iterator = dir_iterator_begin(git_path("logs"), DIR_ITERATOR_PRE_ORDER_TRAVERSAL);

Actually, this iterator *doesn't* care about directories. If you look up
in `files_reflog_iterator_advance()`, only entries for which
`S_ISREG(diter->st.st_mode)` are processed. So you can set the flag to
0. (You still need to retain the `S_ISREG()` check, though, to exclude
other types of files.)

>  	return ref_iterator;
>  }
>  
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> index 0394a13..9ac3fa7 100644
> --- a/t/helper/test-dir-iterator.c
> +++ b/t/helper/test-dir-iterator.c
> @@ -4,15 +4,34 @@
>  #include "dir-iterator.h"
>  
>  int cmd_main(int argc, const char **argv) {
> +	const char **myargv = argv;
> +	int myargc = argc;
> +
>  	struct strbuf path = STRBUF_INIT;
>  	struct dir_iterator *diter;
>  
> -	if (argc < 2)
> -		die("BUG: test-dir-iterator needs one argument");
> +	unsigned flag = 0;
> +
> +	while (--myargc && starts_with(*++myargv, "--")) {
> +		if (!strcmp(*myargv, "--pre-order"))
> +			flag |= DIR_ITERATOR_PRE_ORDER_TRAVERSAL;
> +		else if (!strcmp(*myargv, "--post-order"))
> +			flag |= DIR_ITERATOR_POST_ORDER_TRAVERSAL;
> +		else if (!strcmp(*myargv, "--list-root-dir"))
> +			flag |= DIR_ITERATOR_LIST_ROOT_DIR;
> +		else if (!strcmp(*myargv, "--")) {
> +			myargc--;
> +			myargv++;
> +			break;
> +		} else
> +		   die("Unrecognized option: %s", *myargv);

The indentation above is wrong.

> +	}
>  
> -	strbuf_add(&path, argv[1], strlen(argv[1]));
> +	if (myargc != 1)
> +		die("expected exactly one non-option argument");
> +	strbuf_addstr(&path, *myargv);
>  
> -	diter = dir_iterator_begin(path.buf);
> +	diter = dir_iterator_begin(path.buf, flag);
>  
>  	while (dir_iterator_advance(diter) == ITER_OK) {
>  		if (S_ISDIR(diter->st.st_mode))
> [...]

Michael

