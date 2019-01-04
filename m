Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987F21F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 22:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfADWvG (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 17:51:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38250 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfADWvG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 17:51:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so37856135wrw.5
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 14:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FR6UYMzAkGqss6BZ5vZa7HalNLG7vWnhJ1TxecIB6f0=;
        b=J/R8I+Sij0llMZ1J+z0BVkRtj7QYtWveGaxt9no9wmD3hLFPdGDPCT3cT7szHo21ek
         E9JNve6vtP0VKTwoHxr5k/X/Z5eA68u7BWot6BL2ow4VX4vUq4lCrFnhVPWorGF/ovfV
         yDPMLLa07uXYSU+YLWJHhjDEcAH2ej1DrTr0u6/c/pc41ul3sv81gHlKxnbrh+R9LQj2
         opBjhGoalXOYw/mzxM9hDrSwtJ9vrbqhfFReDu5CxGYWDfEF4dQxctlYM8PfcCyXBNSU
         fZo4CW08RsSe+KGQo44kVmCRQV26kx9PHb3WVWBVxkao1dVX04bZXm6a95X/hKjCifYr
         kIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FR6UYMzAkGqss6BZ5vZa7HalNLG7vWnhJ1TxecIB6f0=;
        b=pOpHWowkoBV2tykcV+5BdEat8vAYMTH+ISoZJoB0iqGYvzp57g17jJdjCGNyboxtju
         tzFOViDwFf3Ob3mv3MAw+2fBcHz6FeJ6ulSk3OeVZ1xYxOfToSgMw6DME2SQV2lKwkuw
         fbkN5laMXuVQKSu+WsHS6kOr+GPjtIt0t/moBYk3396RLPew+DEIpYKMVPcsovT7aqen
         wjQdUlQZX3aq3Hy8jboec2p1KP3INBRHEnl+1L7reF4UtNWkycx8pxR6+VerW5Zd3vlR
         pQu0gC6GdLU1w7JbvBi3QZXTo76ZbWnYLzraHJD8HqIP7+5wojOmZy6QpW/PzUuA0hU/
         Q1+Q==
X-Gm-Message-State: AJcUukfTTcB+2fg/nkffzrlxQGut6gXoXg0SRAHJvb2boJgkqx5xlsM0
        QEtsdZo67oajB9QdcjuzvEY=
X-Google-Smtp-Source: ALg8bN6FbxpkkUfcbtrkt+UPvFFGJMlalZYBh1yGi214YwudPIcNZ0uEOUPBbWg0DcycVnfJAyk3og==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr45168329wru.222.1546642263746;
        Fri, 04 Jan 2019 14:51:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b7sm41306787wrs.47.2019.01.04.14.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 14:51:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org
Subject: Re: [PATCH v2] worktree: allow to (re)move worktrees with uninitialized submodules
References: <20181216121239.10017-1-pclouds@gmail.com>
        <20181216144657.31181-1-pclouds@gmail.com>
Date:   Fri, 04 Jan 2019 14:51:01 -0800
In-Reply-To: <20181216144657.31181-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 16 Dec 2018 15:46:57 +0100")
Message-ID: <xmqqftu8avfu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Uninitialized submodules have nothing valueable for us to be worried
> about. They are just SHA-1. Let "worktree remove" and "worktree move"
> continue in this case so that people can still use multiple worktrees
> on repos with optional submodules that are never populated, like
> sha1collisiondetection in git.git when checked out by doc-diff script.
>
> Note that for "worktree remove", it is possible that a user
> initializes a submodule (*), makes some commits (but not push), then
> deinitializes it. At that point, the submodule is unpopulated, but the
> precious new commits are still in
>
>     $GIT_COMMON_DIR/worktrees/<worktree>/modules/<submodule>
>
> directory and we should not allow removing the worktree or we lose
> those commits forever. The new directory check is added to prevent
> this.
>
> (*) yes they are screwed anyway by doing this since "git submodule"
>     would add submodule.* in $GIT_COMMON_DIR/config, which is shared
>     across multiple worktrees. But it does not mean we let them be
>     screwed even more.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Fixed Eric's comment. I was a bit annoyed by the duplicate die() too
>  but didn't think of adding "else" in front of "if (read_index"
>
>  builtin/worktree.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)

Is this a fair description for this 1-patch topic?

	"git worktree remove" and "git worktree move" failed to work
	when there is an uninitialized submodule, which has been fixed.

If so, can we have a test case to cover this fix?

Thanks.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 5e84026177..3f9907fcc9 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -9,6 +9,7 @@
>  #include "refs.h"
>  #include "run-command.h"
>  #include "sigchain.h"
> +#include "submodule.h"
>  #include "refs.h"
>  #include "utf8.h"
>  #include "worktree.h"
> @@ -724,20 +725,36 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
>  static void validate_no_submodules(const struct worktree *wt)
>  {
>  	struct index_state istate = { NULL };
> +	struct strbuf path = STRBUF_INIT;
>  	int i, found_submodules = 0;
>  
> -	if (read_index_from(&istate, worktree_git_path(wt, "index"),
> -			    get_worktree_git_dir(wt)) > 0) {
> +	if (is_directory(worktree_git_path(wt, "modules"))) {
> +		/*
> +		 * There could be false positives, e.g. the "modules"
> +		 * directory exists but is empty. But it's a rare case and
> +		 * this simpler check is probably good enough for now.
> +		 */
> +		found_submodules = 1;
> +	} else if (read_index_from(&istate, worktree_git_path(wt, "index"),
> +				   get_worktree_git_dir(wt)) > 0) {
>  		for (i = 0; i < istate.cache_nr; i++) {
>  			struct cache_entry *ce = istate.cache[i];
> +			int err;
>  
> -			if (S_ISGITLINK(ce->ce_mode)) {
> -				found_submodules = 1;
> -				break;
> -			}
> +			if (!S_ISGITLINK(ce->ce_mode))
> +				continue;
> +
> +			strbuf_reset(&path);
> +			strbuf_addf(&path, "%s/%s", wt->path, ce->name);
> +			if (!is_submodule_populated_gently(path.buf, &err))
> +				continue;
> +
> +			found_submodules = 1;
> +			break;
>  		}
>  	}
>  	discard_index(&istate);
> +	strbuf_release(&path);
>  
>  	if (found_submodules)
>  		die(_("working trees containing submodules cannot be moved or removed"));
