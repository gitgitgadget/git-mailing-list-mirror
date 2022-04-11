Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEEAC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 11:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344440AbiDKLTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiDKLTT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 07:19:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D56F427D5
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 04:17:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u15so11482614ejf.11
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hcYUoZ6ipIC2uI6hILm0/KAXtzSpPsZyyBECMCaRuBI=;
        b=n86mDAKqqk3BKGH+WWR3Lw2KNf4kuyIH6OM2mUyIMrMpnxLBX3tOvmQVtj8bS1DFom
         qg70Xc3fjhN9wuYMASckYm/Jx2u/4wn+2ULoljtupMZM7rGud5vzICLGxjvVMZthf7Ut
         B9so94FeKfMs9P4Rh3e//aH6BoyamnC2iNt5ZxgAfzaQHsYP74QhqsDufei0MUUHjeNd
         qkatu3np7vToTS/YqJrFkdo0c03973hCYPun5xljeTcTNTCh77AdLU2ZIrllCoQooKyt
         6A+pptzODIBWw9DI/u+EfZLQ9cKCN7llcasOQNiQBhxJkK/hdIjIMxcD3c2Yi4cnvyVs
         vGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hcYUoZ6ipIC2uI6hILm0/KAXtzSpPsZyyBECMCaRuBI=;
        b=wsJtfGw3SwS7u9ztw2NJkP4gieSIhHqmB5y2WTUK9jNV2yjsTAIF0StSKmOiYlduPc
         MOXddg8CgHy6lXSx+BVfK7f3xmKMJIroQxu1NEvYRt/KqkHh76eAt4/rA24d/Z8jzTkS
         Xzq1uWymWpijlGg+tjSoxv5FDHX8FTQi3dSFjjOBdngLVIJPaFYVaJtnrJ3zE7aCAxOb
         D9mux576SFNOX83C1N4uUZ9g9btRJ1xR1htEq+/o5xrFwpBfmHFoHBE2K0nZ2bRRb8Xi
         vdHF+gJsXjonYDZB651i8mB2R2/t/C2Nw4idTaglYa3lhUaup17L1T+LFIuqhmY9Xvc4
         pboA==
X-Gm-Message-State: AOAM533JvvNXPYvbw8UtGMnVY/e5UFFszZmIk9dLqoeAHwQM6XmdWwmr
        cJAU/zy3c7wNQMZA102S/+Y=
X-Google-Smtp-Source: ABdhPJz/hibZIIH9/qyvfvV/Elx2lpgd+MTV4AE6/xq+uKl7DxMMSFhG9vs83D62kJFqCndAvI1Reg==
X-Received: by 2002:a17:907:720b:b0:6e8:78bf:10de with SMTP id dr11-20020a170907720b00b006e878bf10demr7643330ejc.135.1649675823660;
        Mon, 11 Apr 2022 04:17:03 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ga5-20020a1709070c0500b006de43e9605asm11774159ejc.181.2022.04.11.04.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:17:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nds2Y-000h7X-F9;
        Mon, 11 Apr 2022 13:17:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Plato Kiorpelidis <kioplato@gmail.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        mhagger@alum.mit.edu
Subject: Re: [RFC PATCH 3/6] dir-iterator: refactor dir_iterator_advance()
Date:   Mon, 11 Apr 2022 13:11:06 +0200
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-4-kioplato@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220410111852.2097418-4-kioplato@gmail.com>
Message-ID: <220411.86o817j2dt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 10 2022, Plato Kiorpelidis wrote:

> Simplify dir_iterator_advance by switch from iterative to recursive
> implementation. In each recursive step one action is performed.
>
> This makes dir-iterator easier to work with, understand and introduce
> new functionality.
>
> Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> ---
>  dir-iterator.c          | 225 ++++++++++++++++++++++++++--------------
>  t/t0066-dir-iterator.sh |   4 +-
>  2 files changed, 148 insertions(+), 81 deletions(-)
>
> diff --git a/dir-iterator.c b/dir-iterator.c
> index b17e9f970a..0f9ed95958 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -7,8 +7,7 @@ struct dir_iterator_level {
>  	DIR *dir;
>  
>  	/*
> -	 * The length of the directory part of path at this level
> -	 * (including a trailing '/'):
> +	 * The length of the directory part of path at this level.
>  	 */
>  	size_t prefix_len;
>  };
> @@ -34,8 +33,9 @@ struct dir_iterator_int {
>  	size_t levels_alloc;
>  
>  	/*
> -	 * A stack of levels. levels[0] is the uppermost directory
> -	 * that will be included in this iteration.
> +	 * A stack of levels. levels[0] is the root directory.
> +	 * It won't be included in the iteration, but iteration will happen
> +	 * inside it's subdirectories.
>  	 */
>  	struct dir_iterator_level *levels;
>  
> @@ -45,34 +45,53 @@ struct dir_iterator_int {
>  
>  /*
>   * Push a level in the iter stack and initialize it with information from
> - * the directory pointed by iter->base->path. It is assumed that this
> - * strbuf points to a valid directory path. Return 0 on success and -1
> - * otherwise, setting errno accordingly and leaving the stack unchanged.
> + * the directory pointed by iter->base->path. Don't open the directory.
> + *
> + * Return 1 on success.
> + * Return 0 when `iter->base->path` isn't a directory.
>   */
>  static int push_level(struct dir_iterator_int *iter)
>  {
>  	struct dir_iterator_level *level;
>  
> +	if (!S_ISDIR(iter->base.st.st_mode)) return 0;

style: missing \n before "return".

Also, the one existing caller before this patch is:

    if (S_ISDIR(iter->base.st.st_mode) && push_level(iter))

Why not continue to do that?

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
>  		errno = saved_errno;
> -		return -1;
> +		return -2;

Perhaps we should just add an enum for these return values instead of
adding more negative/positive values here. That makes your later calls
of activate_level() more idiomaic. E.g. !activate_level() instead of
activate_level() == 1.

>  		warning_errno("failed to stat '%s'", iter->base.path.buf);
> +		return -2;  // Stat failed not with ENOENT.

Don't use // comments, use /* .. */
> +	} else if (stat_err && errno == ENOENT)
> +		return -1;  // Stat failed with ENOENT.

Missing {} here for the else if.

> +	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
> +	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
> +
> +	struct dirent *dir_entry = NULL;
> +
> +	int expose_err, activate_err;
> +
> +	/* For shorter code width-wise, more readable */
> +	unsigned int PEDANTIC = iter->flags & DIR_ITERATOR_PEDANTIC;

We usually don't add \n\n in the middle of variable decls.

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
>  	}
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

Don't compare against NULL, use !dir_entry.

Also: Manually resetting "errno" before isn't needed. It will be (re)set
if readdir() returns NULL().

> +		if (errno) {
> +			warning_errno("errno reading dir '%s'", iter->base.path.buf);
> +			if (iter->flags & DIR_ITERATOR_PEDANTIC) goto error_out;

more missing \n before goto/return.
