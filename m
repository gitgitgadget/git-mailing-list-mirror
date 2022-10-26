Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9222C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 22:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJZWsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 18:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZWsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 18:48:16 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EC7201B9
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 15:48:14 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k131-20020a628489000000b0056b3e1a9629so7577849pfd.8
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 15:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cn9KahdmcSxrw0ZWCGrj0RDrDBgLXiNLj80ZvbQJC0E=;
        b=sD7/Eck7xzHGENPZdmI8z4aLPyGHTeQsOD0uFi6Kk8W0uSchCqQkF8t4InBdtBaU8B
         qI1JkD5qZvsqiQz+4FcwQURnlfzBvgBz86A1uKGPTUHc9BCchcday771iL1q7RvsBjhV
         B38FqnV77iIrZ8EbjOiKiF8HmM3YfIS7Ps86R6bsbD5NIa76iuRNq16CVf0HfF9agIHs
         ayK+FJIw8uH2edcx/q/x3pk0JhSa3C/+Qx8Nok+zecuAgwAe03tk/zkPiyZPoiont7lb
         Ca4S+iFnFoKmjnzbeOz5mLxrsXQcPWen2vmB/y0YUw+VUtU3ZB8YHSVQjKmmsd/0Z1Q5
         6dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cn9KahdmcSxrw0ZWCGrj0RDrDBgLXiNLj80ZvbQJC0E=;
        b=ne8RGDO+ggqnzFmjKm8+n91fI0QJsCXnr4NgY7Nnx31McI9FZeYScXmSyJwDvH4W0w
         Yi5WtR9s0HntLJ7LeyGEcGQo/wnCZ5J/814oLx5Ky4xTnBNyqqWxwVC6G/K/dkrMAn6Y
         rOrFW51DfB0wjRboNWNDRRXuIY1fOaYIuYmqPcGCHJP/kzaA280fCsrDO3z+WmA9vnXh
         2xiX9ImYdnvIabj90FYFa551M/xggjTPZCKf8lPaqXxVMGY0v9PjKg72FS7w6lUcpUsV
         ks5xZf0tRSTG71aLe3S5dlQOcajE2uRaI+8s+FXSI3TP9QBW2s9yrKXjd95zCu8W7NBP
         ADMQ==
X-Gm-Message-State: ACrzQf3KSC2o8ZJWcbIikvMtu6CrRnX7LHPlTR1xrIclh/UwW8+GurpO
        mnHR0al7qX+dd1NGFNEZfqQZG0Ge9mrqUA==
X-Google-Smtp-Source: AMsMyM4f/PTCwKbl3iPOCPHBYXRzNLzyVJJhPZDgPKBZ5Qs/G1sgYieaYs0EM9TenoXiTvLP0RzhMy8aZG97CQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2288:b0:56b:fe9d:b4b7 with SMTP
 id f8-20020a056a00228800b0056bfe9db4b7mr14196173pfe.79.1666824494381; Wed, 26
 Oct 2022 15:48:14 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:48:12 -0700
In-Reply-To: <d3d1738e670d5dbf1378fc5c3209b2e98234a771.1665973401.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com> <d3d1738e670d5dbf1378fc5c3209b2e98234a771.1665973401.git.gitgitgadget@gmail.com>
Message-ID: <kl6lk04mqk0j.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 4/9] tree: handle submodule case for read_tree_at properly
From:   Glen Choo <chooglen@google.com>
To:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -47,40 +48,73 @@ int read_tree_at(struct repository *r,
>  			return -1;
>  		}
>  
> -		if (S_ISDIR(entry.mode))
> +		if (S_ISDIR(entry.mode)) {
>  			oidcpy(&oid, &entry.oid);
> -		else if (S_ISGITLINK(entry.mode)) {
> -			struct commit *commit;
>  
> -			commit = lookup_commit(r, &entry.oid);
> +			len = tree_entry_len(&entry);
> +			strbuf_add(base, entry.path, len);
> +			strbuf_addch(base, '/');
> +			retval = read_tree_at(r, lookup_tree(r, &oid),
> +						base, pathspec,
> +						fn, context);
> +			strbuf_setlen(base, oldlen);
> +			if (retval)
> +				return -1;
> +		} else if (pathspec->recurse_submodules && S_ISGITLINK(entry.mode)) {
> +			struct commit *commit;
> +			struct repository subrepo;
> +			struct repository* subrepo_p = &subrepo;
> +			struct tree* submodule_tree;
> +			char *submodule_rel_path;
> +			int name_base_len = 0;
> +
> +			len = tree_entry_len(&entry);
> +			strbuf_add(base, entry.path, len);
> +			submodule_rel_path = base->buf;
> +			// repo_submodule_init expects a path relative to submodule_prefix
> +			if (r->submodule_prefix) {
> +				name_base_len = strlen(r->submodule_prefix);
> +				// we should always expect to start with submodule_prefix
> +				assert(!strncmp(submodule_rel_path, r->submodule_prefix, name_base_len));
> +				// strip the prefix
> +				submodule_rel_path += name_base_len;
> +				// if submodule_prefix doesn't end with a /, we want to get rid of that too
> +				if (is_dir_sep(submodule_rel_path[0])) {
> +					submodule_rel_path++;
> +				}
> +			}
> +
> +			if (repo_submodule_init(subrepo_p, r, submodule_rel_path, null_oid()))
> +				die("couldn't init submodule %s", base->buf);
> +
> +			if (repo_read_index(subrepo_p) < 0)
> +				die("index file corrupt");
> +
> +			commit = lookup_commit(subrepo_p, &entry.oid);
>  			if (!commit)
> -				die("Commit %s in submodule path %s%s not found",
> +				die("Commit %s in submodule path %s not found",
>  				    oid_to_hex(&entry.oid),
> -				    base->buf, entry.path);
> -
> -			// FIXME: This is the wrong repo instance (it refers to the superproject)
> -			// it will always fail as is (will fix in later patch)
> -			// This current codepath isn't executed by any existing callbacks
> -			// so it wouldn't show up as an issue at this time.
> -			if (repo_parse_commit(r, commit))
> -				die("Invalid commit %s in submodule path %s%s",
> +				    base->buf);
> +
> +			if (repo_parse_commit(subrepo_p, commit))
> +				die("Invalid commit %s in submodule path %s",
>  				    oid_to_hex(&entry.oid),
> -				    base->buf, entry.path);
> +				    base->buf);
>  
> -			oidcpy(&oid, get_commit_tree_oid(commit));
> -		}
> -		else
> -			continue;
> +			submodule_tree = repo_get_commit_tree(subrepo_p, commit);
> +			oidcpy(&oid, submodule_tree ? &submodule_tree->object.oid : NULL);
>  
> -		len = tree_entry_len(&entry);
> -		strbuf_add(base, entry.path, len);
> -		strbuf_addch(base, '/');
> -		retval = read_tree_at(r, lookup_tree(r, &oid),
> -				      base, pathspec,
> -				      fn, context);
> -		strbuf_setlen(base, oldlen);
> -		if (retval)
> -			return -1;
> +			strbuf_addch(base, '/');
> +
> +			retval = read_tree_at(subrepo_p, lookup_tree(subrepo_p, &oid),
> +						base, pathspec,
> +						fn, context);
> +			if (retval)
> +			    die("failed to read tree for %s", base->buf);
> +			strbuf_setlen(base, oldlen);
> +			repo_clear(subrepo_p);
> +		}
> +		// else, this is a file (or a submodule, but no pathspec->recurse_submodules)

In this patch, we say that we can ignore a submodule when
pathspec->recurse_submodules is 0, but unless I'm missing something, I
don't think that's the case. The preimage is:

		else if (S_ISGITLINK(entry.mode)) {
			struct commit *commit;

			commit = lookup_commit(r, &entry.oid);
			if (!commit)
				die("Commit %s in submodule path %s%s not found",
				    oid_to_hex(&entry.oid),
				    base->buf, entry.path);

      /* ... */
			if (repo_parse_commit(r, commit))
				die("Invalid commit %s in submodule path %s%s",
				    oid_to_hex(&entry.oid),
				    base->buf, entry.path);

			oidcpy(&oid, get_commit_tree_oid(commit));
		}
		else
			continue;

		len = tree_entry_len(&entry);
		strbuf_add(base, entry.path, len);
		strbuf_addch(base, '/');
		retval = read_tree_at(r, lookup_tree(r, &oid),
				      base, pathspec,
				      fn, context);

which isn't a no-op since we actually do recurse into the gitlink. I
don't know whether the subsequent call actually succeeds though (e.g.
maybe it always failed and it was just a de facto no-op?), but that's
much harder to prove. Since this function has callers outside of "git
archive", it would be better to be conservative and keep the original
behavior in the S_ISGITLINK(entry.mode) && !pathspec->recurse_submodules
case.

>  	}
>  	return 0;
>  }
> -- 
> gitgitgadget
