Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A96DC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJQNsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJQNsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:48:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CFB52816
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:48:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so12740544wme.5
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WzgI7ZgQ+JswTs16gVl8J2eTEpmZa3hXJPvXknKKgLA=;
        b=mq7irnQfMOpCCmaPvHB3IpAYwP0K2lf+ahgJ/KjgqUtYwJHMr80QnbhIuqGFcoTsuf
         DX+878U3QUpfW8E7dap29A7T/kiF3MiIJGjflI8MIVVH/Ms7qt670QXOweOu57kbPSzf
         poOatuNVXR5FDyg+UZab5xF+lmyaqRA/6Td3mx+6Np+SOedkIbGgzk5wlEXgtWF3WJQS
         OiTx9ZtpPhz54ssTgWEaQ00K9d9Sz88WGz92OF1lSfZEII16TlBwgcuLW1uvb1j2i3gC
         QibHfFhb/go5dr5OsKsQDf3lWHwSr2O4CAZkdDbBwNDO5qmWPPg9RSxm695Umrdr4jlS
         YsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzgI7ZgQ+JswTs16gVl8J2eTEpmZa3hXJPvXknKKgLA=;
        b=WgF7L+QCxmDCl/1NQNEgP6Ph0m7FePoXQ3S2G5T9QTZxwaf+i9bZ/YgSkX5p6vzwwi
         95wVSv1NIFJD4RelJLWQOCDlRVgdnzonwjP6VHMHHTM3KHMgs+uUPiTFt7U/lN+nItaR
         NNeoDEesLS/IuxuaKoH38vPD7UEGA4WkB2GuJFeny5/y0hl1XWZ+CLA01jdLoQ7NoFv0
         M/RdQHUo14qtXh2OMHR7IK0ww1jmugCnCZSVIVBXMEm3WnNaltAExkhvrZdBvCwI9bI1
         tWP+wdbqdwLwWmyYvjsejhM1CLvD0/M8vKg/jz8BNbMBgXxaMd+v/9z7UnAtF+AMHXEo
         Hp3w==
X-Gm-Message-State: ACrzQf2mnGiaXMVmma8iUF373OXoaWKqqKDDtLIyrBHC5qmqzafxyXA5
        JY+mMzPOaeKscdqWc4kcfq/MiIoWUao=
X-Google-Smtp-Source: AMsMyM5oRytdPp+z88oEIAxjin90nr/HZajIWCXrvM0JF8BeLoHt4oMnePsqFaRd0YH8O4w77jno1w==
X-Received: by 2002:a7b:cd93:0:b0:3c6:facf:1fa8 with SMTP id y19-20020a7bcd93000000b003c6facf1fa8mr2083234wmj.85.1666014485712;
        Mon, 17 Oct 2022 06:48:05 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id s21-20020a7bc395000000b003c6fb525b4csm1109598wmj.38.2022.10.17.06.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 06:48:05 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <bf890f94-10b7-e344-fe20-8ce129923c4f@dunelm.org.uk>
Date:   Mon, 17 Oct 2022 14:48:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/9] tree: handle submodule case for read_tree_at
 properly
Content-Language: en-US
To:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
 <d3d1738e670d5dbf1378fc5c3209b2e98234a771.1665973401.git.gitgitgadget@gmail.com>
In-Reply-To: <d3d1738e670d5dbf1378fc5c3209b2e98234a771.1665973401.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Heather

On 17/10/2022 03:23, Heather Lapointe via GitGitGadget wrote:
> From: Heather Lapointe <alpha@alphaservcomputing.solutions>
> 
> This supports traversal into an actual submodule for read_tree_at.
> The logic is blocked on pathspec->recurse_submodules now,

I'm struggling to understand what this is saying.

> but previously hadn't been executed due to all fn() cases
> returning early for submodules.
> 
> Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
> ---
>   tree.c | 88 ++++++++++++++++++++++++++++++++++++++++------------------
>   1 file changed, 61 insertions(+), 27 deletions(-)
> 
> diff --git a/tree.c b/tree.c
> index 13f9173d45e..2a087c010f9 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -8,6 +8,7 @@
>   #include "alloc.h"
>   #include "tree-walk.h"
>   #include "repository.h"
> +#include "pathspec.h"
>   
>   const char *tree_type = "tree";
>   
> @@ -47,40 +48,73 @@ int read_tree_at(struct repository *r,
>   			return -1;
>   		}
>   
> -		if (S_ISDIR(entry.mode))
> +		if (S_ISDIR(entry.mode)) {
>   			oidcpy(&oid, &entry.oid);
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

Normally we'd just use &subrepo wherever we want a pointer rather than 
defining an alias like this. For example it is common to see

	struct strbuf buf = STRBUF_INIT;

	strbuf_add(&buf, "hello world");

we don't define a buf_p variable

> +			struct tree* submodule_tree;
> +			char *submodule_rel_path;
> +			int name_base_len = 0;
> +
> +			len = tree_entry_len(&entry);
> +			strbuf_add(base, entry.path, len);
> +			submodule_rel_path = base->buf;
> +			// repo_submodule_init expects a path relative to submodule_prefix

I found the comments in this section code code helpful, but single line 
comments should be formatted as
	/* single line comment */

> +			if (r->submodule_prefix) {
> +				name_base_len = strlen(r->submodule_prefix);
> +				// we should always expect to start with submodule_prefix
> +				assert(!strncmp(submodule_rel_path, r->submodule_prefix, name_base_len));

Rather than using assert() we tend to use BUG() as that then provides a 
grep-able message. It also means that we wont have an out of bounds 
access if the invariant is violated when compiling with NDEBUG. So we 
could drop the comment and write

	if (strncmp(submodule_rel_path, r->submodule_prefix, name_base_len)
		BUG("missing submodule path prefix");

> +				// strip the prefix
> +				submodule_rel_path += name_base_len;
> +				// if submodule_prefix doesn't end with a /, we want to get rid of that too

I think there is a typo here - if the prefix does end with a / then 
we're dropping it.

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
>   			if (!commit)
> -				die("Commit %s in submodule path %s%s not found",
> +				die("Commit %s in submodule path %s not found",
>   				    oid_to_hex(&entry.oid),
> -				    base->buf, entry.path);
> -
> -			// FIXME: This is the wrong repo instance (it refers to the superproject)
> -			// it will always fail as is (will fix in later patch)
> -			// This current codepath isn't executed by any existing callbacks
> -			// so it wouldn't show up as an issue at this time.
> -			if (repo_parse_commit(r, commit))

Style comment for the patch that added this code. Multi-line comments 
should be formatted as
	/*
	 * Multi-line
	 * comment
	 */

Best Wishes

Phillip

> -				die("Invalid commit %s in submodule path %s%s",
> +				    base->buf);
> +
> +			if (repo_parse_commit(subrepo_p, commit))
> +				die("Invalid commit %s in submodule path %s",
>   				    oid_to_hex(&entry.oid),
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
>   	}
>   	return 0;
>   }
