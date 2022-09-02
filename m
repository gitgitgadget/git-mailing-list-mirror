Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C45ECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 03:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiIBD3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiIBD3G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 23:29:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5271B2CEF
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 20:29:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r69so867277pgr.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 20:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=N7Ew0nUG+kvRPZ+cXC+M8vWR38k/UaSiEtysUXIYmjs=;
        b=RASLGAIcQf+CzhUraRJ6sRj54OwlSkoZNy07S5yNcBlhwS4T/Hq+4MupI9b2K/j3mI
         y44JsSd6P4QGumP5TRR4vn6Z1WBsZ5M+Jp6OVxrhd0vYcurUD5GROlmna+HSON0sDFGc
         VzeUM5hZcTiLQDC84juUh9Juj124YQYA4SJgRFqBlgOMuuvNJOLiJaODaRCiVD8YG5yz
         6i25XDiZkuJidCpCxppBtdsFqVt8w2eYlRB97VxuHV2lxC3J8Gecfh3xPSQKril1M/MS
         cIEU8W1ykqnyXRXFSNJIm0YfuwGVhTx4Qz6IsvmAeNogIggKGwpnXdvaKnQAIkr5US7e
         KDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=N7Ew0nUG+kvRPZ+cXC+M8vWR38k/UaSiEtysUXIYmjs=;
        b=yS7QBhkVceywSXsBa0ijfUmEuIDaWRTSTFfgIjBv0B6Y5svcDA2C1BHnGGs0LHvCE4
         jkJzXQkTSZHpCpZZ9a6qqfxte4VUWNpaoWh0R1NhQO7Wlw+kSPxWeL9iVSce8DYxLjML
         tUYayC1SpDHEilgF1d4sFZpazMj+8S34+HCg/q7Cd0ELF2dSJgP48N7BkTfQPldbtPz9
         9C+tNt6bAwdhUeQ1LTl/9BzDRwMoY2DV3EutTav0x/9oU5umc+T612JBjr+sZH9kX+GS
         /9E/w0dZyXnKOTj5DFtb1YNJxkeeP/s7osXdLFuZqqYdacybaNSFsoX0/64ro77wBZjP
         1VFA==
X-Gm-Message-State: ACgBeo1kKu8BgoQwTP4NaFGhf9ENkYZ+S40uml4PyglsgPcvYpUyuMzb
        ZcBNKjneuHP68Zqcp7lBtr3m
X-Google-Smtp-Source: AA6agR6Jf85p2KySjMtlMhYKJDNdIoOlSK3QuUlz8T3PMNUCt5ZDQhMfh3HvzuAcy8Wbrdu3PgxrkA==
X-Received: by 2002:a05:6a00:2292:b0:538:1d03:9818 with SMTP id f18-20020a056a00229200b005381d039818mr24482385pfe.42.1662089338138;
        Thu, 01 Sep 2022 20:28:58 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id e16-20020aa798d0000000b005360da6b26bsm388553pfm.159.2022.09.01.20.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 20:28:57 -0700 (PDT)
Message-ID: <4b65d7dc-e711-43a6-8763-62be79a3e4a9@github.com>
Date:   Thu, 1 Sep 2022 20:28:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v3 3/3] builtin/grep.c: walking tree instead of expanding
 index with --sparse
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-4-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220901045736.523371-4-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Before this patch, whenever --sparse is used, `git-grep` utilizes the
> ensure_full_index() method to expand the index and search all the
> entries. Because this method requires walking all the trees and
> constructing the index, it is the slow part within the whole command.
> 
> To achieve better performance, this patch uses grep_tree() to search the
> sparse directory entries and get rid of the ensure_full_index() method.
> 
> Why grep_tree() is a better choice over ensure_full_index()?
> 
> 1) grep_tree() is as correct as ensure_full_index(). grep_tree() looks
>    into every sparse-directory entry (represented by a tree) recursively
>    when looping over the index, and the result of doing so matches the
>    result of expanding the index.
> 
> 2) grep_tree() utilizes pathspecs to limit the scope of searching.
>    ensure_full_index() always expands the index when --sparse is used,
>    that means it will always walk all the trees and blobs in the repo
>    without caring if the user only wants a subset of the content, i.e.
>    using a pathspec. On the other hand, grep_tree() will only search
>    the contents that match the pathspec, and thus possibly walking fewer
>    trees.
> 
> 3) grep_tree() does not construct and copy back a new index, while
>    ensure_full_index() does. This also saves some time.

Would you mind adding some 'ensure_not_expanded' cases to 't1092' to codify
this (probably in the 'grep is not expanded' test created in patch 2)? If
I'm understanding this patch correctly, you've updated 'git grep' so that it
*never* needs to expand the index. In that case, it would be good to
exercise a bunch of 'git grep' options (pathspecs inside and outside the
sparse cone, wildcard pathspecs, etc.) to confirm that.

> 
> ----------------
> Performance test
> 
> - Summary:
> 
> p2000 tests demonstrate a ~91% execution time reduction for
> `git grep --cached --sparse <pattern> -- <pathspec>` using tree-walking
> logic.
> 
> Test                                                                          HEAD~   HEAD
> ---------------------------------------------------------------------------------------------------
> 2000.78: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (full-v3)     0.11    0.09 (≈)
> 2000.79: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (full-v4)     0.08    0.09 (≈)
> 2000.80: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (sparse-v3)   0.44    0.04 (-90.9%)
> 2000.81: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (sparse-v4)   0.46    0.04 (-91.3%)

These are fantastic results!

> 
> - Command used for testing:
> 
> 	git grep --cached --sparse bogus -- f2/f1/f1/builtin/*
> 
> The reason for specifying a pathspec is that, if we don't specify a
> pathspec, then grep_tree() will walk all the trees and blobs to find the
> pattern, and the time consumed doing so is not too different from using
> the original ensure_full_index() method, which also spends most of the
> time walking trees. However, when a pathspec is specified, this latest
> logic will only walk the area of trees enclosed by the pathspec, and the
> time consumed is reasonably a lot less.
> 
> That is, if we don't specify a pathspec, the performance difference [1]
> is quite small: both methods walk all the trees and take generally same
> amount of time (even with the index construction time included for
> ensure_full_index()).

This makes sense, thanks for the thorough explanation of the results.

> 
> [1] Performance test result without pathspec:
> 
> 	Test                                                    HEAD~  HEAD
> 	-----------------------------------------------------------------------------
> 	2000.78: git grep --cached --sparse bogus (full-v3)     6.17   5.19 (≈)
> 	2000.79: git grep --cached --sparse bogus (full-v4)     6.19   5.46 (≈)
> 	2000.80: git grep --cached --sparse bogus (sparse-v3)   6.57   6.44 (≈)
> 	2000.81: git grep --cached --sparse bogus (sparse-v4)   6.65   6.28 (≈)
> 
> Suggested-by: Derrick Stolee <derrickstolee@github.com>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/grep.c                    | 32 ++++++++++++++++++++++++++-----
>  t/perf/p2000-sparse-operations.sh |  1 +
>  2 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index a0b4dbc1dc..8c0edccd8e 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -522,9 +522,6 @@ static int grep_cache(struct grep_opt *opt,
>  	if (repo_read_index(repo) < 0)
>  		die(_("index file corrupt"));
>  
> -	if (grep_sparse)
> -		ensure_full_index(repo->index);
> -
>  	for (nr = 0; nr < repo->index->cache_nr; nr++) {
>  		const struct cache_entry *ce = repo->index->cache[nr];
>  
> @@ -537,8 +534,26 @@ static int grep_cache(struct grep_opt *opt,
>  
>  		strbuf_setlen(&name, name_base_len);
>  		strbuf_addstr(&name, ce->name);
> +		if (S_ISSPARSEDIR(ce->ce_mode)) {
> +			enum object_type type;
> +			struct tree_desc tree;
> +			void *data;
> +			unsigned long size;
> +			struct strbuf base = STRBUF_INIT;
> +
> +			strbuf_addstr(&base, ce->name);
> +
> +			data = read_object_file(&ce->oid, &type, &size);
> +			init_tree_desc(&tree, data, size);
>  
> -		if (S_ISREG(ce->ce_mode) &&
> +			/*
> +			 * sneak in the ce_mode using check_attr parameter
> +			 */
> +			hit |= grep_tree(opt, pathspec, &tree, &base,
> +					 base.len, ce->ce_mode);
> +			strbuf_release(&base);
> +			free(data);
> +		} else if (S_ISREG(ce->ce_mode) &&
>  		    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
>  				   S_ISDIR(ce->ce_mode) ||
>  				   S_ISGITLINK(ce->ce_mode))) {
> @@ -598,7 +613,14 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>  		int te_len = tree_entry_len(&entry);
>  
>  		if (match != all_entries_interesting) {
> -			strbuf_addstr(&name, base->buf + tn_len);
> +			if (S_ISSPARSEDIR(check_attr)) {
> +				// object is a sparse directory entry
> +				strbuf_addbuf(&name, base);
> +			} else {
> +				// object is a commit or a root tree
> +				strbuf_addstr(&name, base->buf + tn_len);
> +			}

Hmm, I'm not entirely sure I follow what's going on with 'name'. I'll try to
talk myself through it.

Stepping back a bit in the context of 'grep_tree()': the goal of the
function is, given a tree descriptor 'tree', to recursively scan the tree to
find any 'grep' matches within items matching 'pathspec'. It is also called
with a strbuf 'base', a length 'tn_len', and a boolean 'check_attr'; it's
not immediately clear to me what those args are or what they do. What I can
see is that:

- 'check_attr' is true iff the "tree" being grepped is actually a commit. 
- both non-recursive callers ('grep_object()' and 'grep_submodule()') call
  'grep_tree()' with 'tn_len == base.len'.

Stepping into 'grep_tree()', we iterate over the entries *inside of* 'tree'.
We assign the length of the tree entry's path to 'te_len'. Notably, a tree
entry's path *not* the path from the root of the repo to the entry - it's
just the filename of the entry (e.g., for entry 'folder1/a', the path is
'a').

Next, we skip the first 'tn_len' characters of 'base->buf' and assign that
value to 'name'. Because 'tn_len == base.len', for this first iteration,
it's an empty string. Then, we check if the tree entry is interesting with
path 'name'. But 'name' is an empty string, so 'tree_entry_interesting()'
thinks the tree entry is at the root of the repository, even if it isn't!

At this point, I think I've figured out what the deal with 'base' is. Before
this patch, only 'grep_object()' and 'grep_submodule()'. In the former case,
it's either "<objectname>:", or empty; in the latter, it's the path to the
submodule. Both of those are things you'd want to skip to get the correct
path to the tree entry for 'tree_entry_interesting()', but it isn't true in
your case; you need the path from the repository root to your tree for
'tree_entry_interesting()' to work properly. 

Based on all of that, I *think* you can drop the 'check_attr' changes to
'grep_tree()' and update how you provide 'base' and 'tn_len' so
1) 'base' is the path to the tree root, and 2) 'tn_len' is 0 so that full
path is provided to 'tree_entry_interesting()':

----->8----->8----->8----->8----->8----->8----->8----->8----->8----->8-----
diff --git a/builtin/grep.c b/builtin/grep.c
index 8c0edccd8e..85c83190f1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -546,11 +546,7 @@ static int grep_cache(struct grep_opt *opt,
 			data = read_object_file(&ce->oid, &type, &size);
 			init_tree_desc(&tree, data, size);
 
-			/*
-			 * sneak in the ce_mode using check_attr parameter
-			 */
-			hit |= grep_tree(opt, pathspec, &tree, &base,
-					 base.len, ce->ce_mode);
+			hit |= grep_tree(opt, pathspec, &tree, &base, 0, 0);
 			strbuf_release(&base);
 			free(data);
 		} else if (S_ISREG(ce->ce_mode) &&
@@ -613,14 +609,6 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		int te_len = tree_entry_len(&entry);
 
 		if (match != all_entries_interesting) {
-			if (S_ISSPARSEDIR(check_attr)) {
-				// object is a sparse directory entry
-				strbuf_addbuf(&name, base);
-			} else {
-				// object is a commit or a root tree
-				strbuf_addstr(&name, base->buf + tn_len);
-			}
-
 			match = tree_entry_interesting(repo->index,
 						       &entry, &name,
 						       0, pathspec);
-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<----- 

I still find all of this confusing, and it's possible I'm still not properly
understanding how 'name' and 'tn_len' are supposed to be used. Regardless, I
*am* fairly certain that finding the right values for those args is the
going to be the cleanest (and least fragile) way to handle sparse
directories, rather than using the 'check_attr' arg for something it isn't.

It might take some time + lots of debugging/experimenting, but it's really
important that the implementation you settle on is something you (and,
ideally, the readers of your patches) confidently and completely understand,
rather than something that seems to work but doesn't have a clear
explanation. As always, I'm happy to help if you'd like another set of eyes
on the problem!

> +
>  			match = tree_entry_interesting(repo->index,
>  						       &entry, &name,
>  						       0, pathspec);
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index fce8151d41..a0b71bb3b4 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -124,5 +124,6 @@ test_perf_on_all git read-tree -mu HEAD
>  test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
> +test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/builtin/*"
>  
>  test_done

