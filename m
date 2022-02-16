Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ABFC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 09:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiBPJhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:37:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiBPJhc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 04:37:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1A65CD
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:37:20 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f17so2904316edd.2
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=85JCM1jvQ1gWWwhgwK4xnNuGpezrA8/7P00mRkpC0Q8=;
        b=S8xIIOJE2mLVeSwCjXOl0KG5CPO6C0eK+b4QJnFWXWmCtqTXTd5q2bzv8eBE4Qcs6d
         rrMs/s24Q93gEItnAFLz7Kp3kK489QBB4UreCiz21kG/fRIjrwZyAghga5qUxNqnkqp1
         iB7BcRZ9OMtNn1M1NP+zjpd9Nx0ddcBpcpJcvv5DMIZLxBr7XBcB0vfSTYmYLqdPI7hR
         RIGX0sJhDv5XrDB8auqrxT/zS4XGTeFDBXAPZeDam6DM4KYkvn9XfHEqebc2hADUccBP
         U+qlKwLvd4MqIoGVw1G3pKQYhTI6dP5uCCOWInLgHQ3RNL5dm9o7zew0tFjwrOYx/wsZ
         MgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=85JCM1jvQ1gWWwhgwK4xnNuGpezrA8/7P00mRkpC0Q8=;
        b=1t6v6QMNtTZ+JiLudUvNxU0MDFbt/dGQua3mzb54BtK9IE25ANOZ9Oi1MOQNQeu8Pw
         0UzlDKn7UbhQUSGe6vLT98LbNI4mxmMNx3oCW+Rne920pxde4KS8y8Xq5vmtH0xuPwGZ
         OfMzo42DzBjuhJjJGM+L1QWeoOdIgASRnCjamlGr4pFu37I5LLmOYoYPFMVopW7oYKAS
         tQ4ZUv0YTVEaL+obXkB1npNPkJ1fqyRupPWWc8ae3un842zxhjCqELKzSKXYLpDsSvNM
         0Of2WgN+cgwcKBfBsTliIQAe/FDtdCa4fiDZwV1zSKBLYe4zLRL7s3vWbGRG5yqbey73
         jF3w==
X-Gm-Message-State: AOAM533/bUKrfgFLnJiuYKPndKz+vsSlkZX2tdhBMGK4KeW3+mG4bTY2
        KNchulRbH4gR7r/T9mlWkjBggOtWgfy6Bg==
X-Google-Smtp-Source: ABdhPJwBmI1ugn2sq9LijikbngcEmyY+r2nT7kq9neO9tClzeWD5ZmoRwEU+PE26w5/bTZ0CfGgvTQ==
X-Received: by 2002:a50:fe14:0:b0:410:8621:6e0c with SMTP id f20-20020a50fe14000000b0041086216e0cmr1930016edt.356.1645004238717;
        Wed, 16 Feb 2022 01:37:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m17sm4022122ejn.118.2022.02.16.01.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 01:37:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKGkP-003A4n-Eg;
        Wed, 16 Feb 2022 10:37:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 5/5] Accelerate
 clear_skip_worktree_from_present_files() by caching
Date:   Wed, 16 Feb 2022 10:32:12 +0100
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
 <05ac964e630a2e72eebaa1818a8807cd7a7d4f7e.1642175983.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <05ac964e630a2e72eebaa1818a8807cd7a7d4f7e.1642175983.git.gitgitgadget@gmail.com>
Message-ID: <220216.86fsojup82.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> [...]
> +static int path_found(const char *path, const char **dirname, size_t *dir_len,
> +		      int *dir_found)
> +{
> +	struct stat st;
> +	char *newdir;
> +	char *tmp;
> +
> +	/*
> +	 * If dirname corresponds to a directory that doesn't exist, and this
> +	 * path starts with dirname, then path can't exist.
> +	 */
> +	if (!*dir_found && !memcmp(path, *dirname, *dir_len))
> +		return 0;
> +
> +	/*
> +	 * If path itself exists, return 1.
> +	 */
> +	if (!lstat(path, &st))
> +		return 1;
> +
> +	/*
> +	 * Otherwise, path does not exist so we'll return 0...but we'll first
> +	 * determine some info about its parent directory so we can avoid
> +	 * lstat calls for future cache entries.
> +	 */
> +	newdir = strrchr(path, '/');
> +	if (!newdir)
> +		return 0; /* Didn't find a parent dir; just return 0 now. */
> +
> +	/*
> +	 * If path starts with directory (which we already lstat'ed and found),
> +	 * then no need to lstat parent directory again.
> +	 */
> +	if (*dir_found && *dirname && memcmp(path, *dirname, *dir_len))
> +		return 0;

I really don't care/just asking, but there was a discussion on another
topic about guarding calls to the mem*() family when n=0:
https://lore.kernel.org/git/xmqq1r24gsph.fsf@gitster.g/

Is this the same sort of redundancy where we could lose the "&&
*dirname" part, or is it still important because a "\0" dirname would
have corresponding non-0 *dir_len?

More generally ... (see below)...

> +
> +	/* Free previous dirname, and cache path's dirname */
> +	*dirname = path;
> +	*dir_len = newdir - path + 1;
> +
> +	tmp = xstrndup(path, *dir_len);
> +	*dir_found = !lstat(tmp, &st);

In most other places we're a bit more careful about lstat() error handling, e.g.:
    
    builtin/init-db.c:              if (lstat(path->buf, &st_git)) {
    builtin/init-db.c-                      if (errno != ENOENT)
    builtin/init-db.c-                              die_errno(_("cannot stat '%s'"), path->buf);
    builtin/init-db.c-              }
    
Shouldn't we do the same here and at least error() on return values of
-1 with an accompanying errno that isn't ENOENT?


> +	free(tmp);
> +
> +	return 0;
> +}
> +
>  void clear_skip_worktree_from_present_files(struct index_state *istate)
>  {
> +	const char *last_dirname = NULL;
> +	size_t dir_len = 0;
> +	int dir_found = 1;
> +
>  	int i;
> +
>  	if (!core_apply_sparse_checkout)
>  		return;
>  
>  restart:
>  	for (i = 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce = istate->cache[i];
> -		struct stat st;
>  
> -		if (ce_skip_worktree(ce) && !lstat(ce->name, &st)) {
> +		if (ce_skip_worktree(ce) &&
> +		    path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {

...(continued from above) is the "path is zero" part of this even
reachable? I tried with this on top and ran your tests (and the rest of
t*sparse*.sh) successfully:
	
	diff --git a/sparse-index.c b/sparse-index.c
	index eed170cd8f7..f89c944d8cd 100644
	--- a/sparse-index.c
	+++ b/sparse-index.c
	@@ -403,6 +403,7 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
	 	for (i = 0; i < istate->cache_nr; i++) {
	 		struct cache_entry *ce = istate->cache[i];
	 
	+		assert(*ce->name);
	 		if (ce_skip_worktree(ce) &&
	 		    path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
	 			if (S_ISSPARSEDIR(ce->ce_mode)) {

I.e. isn't this undue paranoia about the cache API giving us zero-length
paths?
