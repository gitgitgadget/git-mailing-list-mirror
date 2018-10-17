Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C711F453
	for <e@80x24.org>; Wed, 17 Oct 2018 22:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeJRG4K (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 02:56:10 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:38339 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeJRG4K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 02:56:10 -0400
Received: by mail-vs1-f73.google.com with SMTP id w20so12687927vsc.5
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4lglBK0lV7IYl9jB4/iYqcnP3d0eqfbFSoAtzgKG8Cc=;
        b=e4NBQPZZwBlPM2QHwiEkIAViB9/DhjQCOGxneNO+Fik0Vx3t5gaJE83Z25Ad8gGaP3
         bP3hNtkXLV3uEriOLzbYcyD2gzAh55LJglWSMYxy3t9sZcYm3j/JFRi/7zYJEv8T0Nj8
         288GGq4EZMbs+LnSO6NBPas5cdff4bu+d8L0VgWM4r3uqpgVmfXjQaVyfwBMFg5xgnsb
         ls6a6QeiDq1EswjpcHQ9Gfkuu0WsGpg0pK3Q364jk4r9nfY9kxPnGE9TydbiaXUKESUi
         RfaOy64udnVmLOrJivYIGN5uYiya7ds3tuSEW4u07G+wMKdWoK7N+ZEg8SrW83cswBYy
         OQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4lglBK0lV7IYl9jB4/iYqcnP3d0eqfbFSoAtzgKG8Cc=;
        b=kcroT1a+Y6ep8nDblvvZRbywh8QdMBDNP7x/2StuMAXiMX1XaPYAdZ3uZBsjTKPhMg
         LYS2vqx5fJuDVxNVHX6bUREb3L6UgDBZEQNQLG/6vfcY04chEp4jKsENFQgHLHtdQ7Zx
         ee5Edtyr+I5NvRa1MTfhQXMJiD4Xgk3Y2ChD3YrW0k5M4Q95hNdouNn7k5FlwltKHfPi
         pMgR2stZB9YUYFqtkrMiPcPWGDkk8Xwi5zrKHcNj45Ae/9w62bjKt//3dc/uJ/qAHQsD
         y2lum7tfURmlElprs6iO0y0jFTSg30w3rkvX5xVxzQ7JNc2ZEFtYGcaRQlaK/yKj6RPL
         1usw==
X-Gm-Message-State: ABuFfoiTzxVhhB2WlXK1gMogYb0WrW4qIH/0CoP5mKCDsu6KAMUqeuHC
        e55m0JeHjLAwKdK8Z1PLSk/8CFWtwkK6sz5vduSq
X-Google-Smtp-Source: ACcGV60Zl26LAE5+AI9ok9M9WBNyyNn13jhtVCPgJZS+zeuu8SZ2iYeGNdEMW3//wCnk24Qlgtk1MLsDmUwHcr+JMgGO
X-Received: by 2002:ab0:a9a:: with SMTP id d26mr26090597uak.6.1539817095308;
 Wed, 17 Oct 2018 15:58:15 -0700 (PDT)
Date:   Wed, 17 Oct 2018 15:58:11 -0700
In-Reply-To: <20181016181327.107186-8-sbeller@google.com>
Message-Id: <20181017225811.66554-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-8-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 7/9] submodule: fetch in submodules git directory instead
 of in worktree
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This patch started as a refactoring to make 'get_next_submodule' more
> readable, but upon doing so, I realized that "git fetch" of the submodule
> actually doesn't need to be run in the submodules worktree. So let's run
> it in its git dir instead.

The commit message needs to be updated, I think - this patch does
significantly more than fetching in the gitdir.

> This patch leaks the cp->dir in get_next_submodule, as any further
> callback in run_processes_parallel doesn't have access to the child
> process any more.

The cp->dir is already leaked - probably better to write "cp->dir in
get_next_submodule() is still leaked, but this will be fixed in a
subsequent patch".

> +static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
> +{
> +	prepare_submodule_repo_env_no_git_dir(out);
> +	argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);

Why does GIT_DIR need to be set? Is it to avoid subcommands recursively
checking the parent directories in case the CWD is a malformed Git
repository? If yes, maybe it's worth adding a comment.

> +static struct repository *get_submodule_repo_for(struct repository *r,
> +						 const struct submodule *sub)
> +{
> +	struct repository *ret = xmalloc(sizeof(*ret));
> +
> +	if (repo_submodule_init(ret, r, sub)) {
> +		/*
> +		 * No entry in .gitmodules? Technically not a submodule,
> +		 * but historically we supported repositories that happen to be
> +		 * in-place where a gitlink is. Keep supporting them.
> +		 */
> +		struct strbuf gitdir = STRBUF_INIT;
> +		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", sub->path);
> +		if (repo_init(ret, gitdir.buf, NULL)) {
> +			strbuf_release(&gitdir);
> +			return NULL;
> +		}
> +		strbuf_release(&gitdir);
> +	}
> +
> +	return ret;
> +}

This is the significant thing that this patch does more - an unskipped
submodule is now something that either passes the checks in
repo_submodule_init() or the checks in repo_init(), which seems to be
stricter than the current check that ".git" points to a directory or is
one. This means that we skip certain broken repositories, and this
necessitates a change in the test.

I think we should be more particular about what we're allowed to skip -
in particular, maybe if we're planning to skip this submodule, its
corresponding directory in the worktree (if one exists) needs to be
empty.

> -			cp->dir = strbuf_detach(&submodule_path, NULL);
> -			prepare_submodule_repo_env(&cp->env_array);
> +			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
> +			cp->dir = xstrdup(repo->gitdir);

Here is where the functionality change (fetch in ".git") described in
the commit message occurs.
