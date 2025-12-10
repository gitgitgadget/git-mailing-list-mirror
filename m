Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D22C3278
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765396185; cv=none; b=fqpKbRVclomALXCbdtOznCjF9Xy8nJFcWJqfr5H5BB31OL287aS6ajbFYbjtkB20tsGbMIIbd1YwB7hKzHom+WQgcqq8hdAh7WWnmyS60OdOs2yPEU9ji9p9h0b92Xunf4qik7CQP8AmLjfgKSDelhuCR7Gl0JGJc+w92YdVbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765396185; c=relaxed/simple;
	bh=8VDHMAXXx4aKUOJc3XPEGC0StygIiBlLb/x9TE4RQ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJyR3SohLZBrJVTKf9UVDBRmqJpDqHL3p7bSw/xio6cEuurFgI8OeVrQeYX4nyo5X/RiS+4xUAIuNHHxCTBuMUPrMa/jBpm//KeCilAGDPN4mN5txGrbRySg6ZzjUWjj+oR5aNXysjyau+4UMY99DCJDZ7tQnGr16jfA48AYkac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8LUzIJL; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8LUzIJL"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6cc44ff62so217539a34.3
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 11:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765396182; x=1766000982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PtaLkWBwz9swWy5zd3nWeqKm3Vt/vQhJ5ql+6HOhgCw=;
        b=J8LUzIJLwPED8hucK+J8x9gthVTxNd/nShHewC4za47XIp0hs3ZllyRWJNPwJ7tW9Q
         1Ta0V8e0mhmLG3yydBD1r6jfpXYSVrzdz8OTOwRYelNW6LySgz+bbT+Zps3hJUSMI3I3
         7EpGNnUHx6ml/e2S2egzTgXootohnOJKojGUGmWL8GKo2MsqWj2yw5PIY97p/wXfxNbj
         oFIUc+g/KkHSG341Kun6qz+BQprkQeEi0AR/GxCxgBvw4EGUEozDG144GRD35jlmHYGT
         Iag+fzCgYIkzXGwK5dCS3m9pyUSXWY4SKK2mQrUZyi5iyip/J+cjRcngpBzbtUMjeMj7
         FotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765396182; x=1766000982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtaLkWBwz9swWy5zd3nWeqKm3Vt/vQhJ5ql+6HOhgCw=;
        b=khLYS62q7F3hyHdyCogZfkdBQ13Z2UnUxp9bTYUFpAk8Qfl77NZsFjzeU7sBU68QCr
         G6TRCNVgzcPhpgoljzncTvQ93BqLySKyKXPv9KIeqt++O3m2yiuAV6yJbeBZQAUIkeOL
         vFumOfTkIRL3GS8tDP2oe3fIg2TVVwvc8GNz8Edi3eRyRAJBnPV/dk5uOAEIlgI+92aT
         LjuP7RlsW8YWFwFrOMh9VNnGaq6ljRIRIjveLNX1ai1YEGKl9ck/M1q4eKc0ifZbCutj
         fOBFQS3pyu9Pq179YFjMuGkPNyqTu73DE8mQcNsC93eYDKyQwY/uoNmIrWbH8yt//NVX
         7eXw==
X-Gm-Message-State: AOJu0YxnAIP2N2OZfoX9CsmA+g7hMl7sHHR/OqH6lt90WrGSswGqvshk
	kzLt7XLESkAbDgpeG0kf+wjYwjVSdOpuUGff8RXasrykxSXnB2dr7nbqR1H91w==
X-Gm-Gg: ASbGncu7JUptBUTSnyexGfiJGEh6gsavZzUugJCzt0FAb/YkbAlVtI0nj2xaNqYfAAt
	sl8HoOD4Cqh3Us13rYbYy51NnkQ0sVuXuRhoGnVzJL9zC9s/usPZgcJdGQ8VtAMtN1tqS556c/w
	/CloezR5p6dJInWTa/W2y/R427b0hZkDRtPMiuilBl/GR0J/aVbmu/yqTyxzKt5wsoAz56rNXJa
	+Av1cbZJl8ggqqAT0xq7uNJfowqfBOdMoDjR/cTy+Pt7PpRgoBEV6I2fZOx7MYQSrjEzH7VoOLO
	0FYz/G4nrOgO4LZ+hD6rz4AEj67/SsM6+Pj/m+oXXzEMfN4DgqZS/RrI9GQ38OF0hA21RGu4v0Q
	L2uuzfvIqQQJ41pNtUldcveOsDO7wArqMojPoKOAsvEXR4c/Jp5iydz6FwFPlRj+o4vQsQwExoD
	wLxrnB
X-Google-Smtp-Source: AGHT+IE/P8eRHO9rnknOssL51IqztSiOJTgEPKuEtLfVMFnBamDOAqK7HjtYZ5QKmIZ/fgu++Vv18Q==
X-Received: by 2002:a05:6830:2690:b0:7c5:3a34:994a with SMTP id 46e09a7af769-7cacebd8238mr2940906a34.17.1765396182358;
        Wed, 10 Dec 2025 11:49:42 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cad920e388sm324326a34.17.2025.12.10.11.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 11:49:42 -0800 (PST)
Date: Wed, 10 Dec 2025 13:49:39 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] builtin/gc: fix condition for whether to write
 commit graphs
Message-ID: <gdyc7mdim2p32fesvcb672ssozoom4pdi7dyygacj3s66v7gd4@ydzwijirha3a>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
 <20251205-odb-related-fixes-v1-2-ef4250abb584@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205-odb-related-fixes-v1-2-ef4250abb584@pks.im>

On 25/12/05 09:19AM, Patrick Steinhardt wrote:
> When performing auto-maintenance we check whether commit graphs need to
> be generated by counting the number of commits that are reachable by any
> reference, but not covered by a commit graph. This search is performed
> by iterating through all references and then doing a depth-first search
> until we have found enough commits that are not present in the commit
> graph.
> 
> This logic has a memory leak though:
> 
>   Direct leak of 16 byte(s) in 1 object(s) allocated from:
>       #0 0x55555562e433 in malloc (git+0xda433)
>       #1 0x555555964322 in do_xmalloc ../wrapper.c:55:8
>       #2 0x5555559642e6 in xmalloc ../wrapper.c:76:9
>       #3 0x55555579bf29 in commit_list_append ../commit.c:1872:35
>       #4 0x55555569f160 in dfs_on_ref ../builtin/gc.c:1165:4
>       #5 0x5555558c33fd in do_for_each_ref_iterator ../refs/iterator.c:431:12
>       #6 0x5555558af520 in do_for_each_ref ../refs.c:1828:9
>       #7 0x5555558ac317 in refs_for_each_ref ../refs.c:1833:9
>       #8 0x55555569e207 in should_write_commit_graph ../builtin/gc.c:1188:11
>       #9 0x55555569c915 in maintenance_is_needed ../builtin/gc.c:3492:8
>       #10 0x55555569b76a in cmd_maintenance ../builtin/gc.c:3542:9
>       #11 0x55555575166a in run_builtin ../git.c:506:11
>       #12 0x5555557502f0 in handle_builtin ../git.c:779:9
>       #13 0x555555751127 in run_argv ../git.c:862:4
>       #14 0x55555575007b in cmd_main ../git.c:984:19
>       #15 0x5555557523aa in main ../common-main.c:9:11
>       #16 0x7ffff7a2a4d7 in __libc_start_call_main (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a4d7) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
>       #17 0x7ffff7a2a59a in __libc_start_main@GLIBC_2.2.5 (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a59a) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
>       #18 0x5555555f0934 in _start (git+0x9c934)
> 
> The root cause of this memory leak is our use of `commit_list_append()`.
> This function expects as parameters the item to append and the _tail_ of
> the list to append. This tail will then be overwritten with the new tail
> of the list so that it can be used in subsequent calls. But we call it
> with `commit_list_append(parent->item, &stack)`, so we end up losing
> everything but the new item.
> 
> This issue only surfaces when counting merge commits. Next to being a
> memory leak, it also shows that we're in fact miscounting as we only
> respect children of the last parent. All previous parents are discarded,
> so their children will be disregarded unless they are hit via another
> reference.
> 
> While crafting a test case for the issue I was puzzled that I couldn't
> establish the proper border at which the auto-condition would be
> fulfilled. As it turns out, there's another bug: if an object is at the
> tip of any reference we don't mark it as seen. Consequently, if it is
> reachable via any other reference, we'd count that object twice.
> 
> Fix both of these bugs so that we properly count objects without leaking
> any memory.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c           |  8 +++++---
>  t/t7900-maintenance.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 92c6e7b954..17ff68cbd9 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1130,8 +1130,10 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
>  		return 0;
>  
>  	commit = lookup_commit(the_repository, maybe_peeled);
> -	if (!commit)
> +	if (!commit || commit->object.flags & SEEN)
>  		return 0;
> +	commit->object.flags |= SEEN;

Now we are marking the object at the reference tip as seen so it will
not be counted more than once if used by other references. Makes sense.

> +
>  	if (repo_parse_commit(the_repository, commit) ||
>  	    commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
>  		return 0;
> @@ -1141,7 +1143,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
>  	if (data->num_not_in_graph >= data->limit)
>  		return 1;
>  
> -	commit_list_append(commit, &stack);
> +	commit_list_insert(commit, &stack);
>  
>  	while (!result && stack) {
>  		struct commit_list *parent;
> @@ -1162,7 +1164,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
>  				break;
>  			}
>  
> -			commit_list_append(parent->item, &stack);
> +			commit_list_insert(parent->item, &stack);

We change from commit_list_append() to commit_list_insert() so the new
item is added to the list without discarding the other entries. This
fixes the memory leak and corrects the other miscounting issue. Looks
good.

>  		}
>  	}
>  
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 6b36f52df7..6f3117304f 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -206,6 +206,32 @@ test_expect_success 'commit-graph auto condition' '
>  	test_subcommand $COMMIT_GRAPH_WRITE <cg-two-satisfied.txt
>  '
>  
> +test_expect_success 'commit-graph auto condition with merges' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git config set maintenance.auto false &&
> +		git commit --allow-empty -m initial &&
> +		git switch --create feature &&
> +		git commit --allow-empty -m feature-1 &&
> +		git commit --allow-empty -m feature-2 &&
> +		git switch - &&
> +		git commit --allow-empty -m main-1 &&
> +		git commit --allow-empty -m main-2 &&
> +		git merge feature &&
> +		git branch -D feature &&

If we left the feature branch instead of deleting it, would that help
test that commits are not counted twice?

> +
> +		# We have 6 commit, none of which are covered by a commit
> +		# graph. So this must be the boundary at which we start to
> +		# perform maintenance.
> +		test_must_fail git -c maintenance.commit-graph.auto=7 \
> +			maintenance is-needed --auto --task=commit-graph &&
> +		git -c maintenance.commit-graph.auto=6 \
> +			maintenance is-needed --auto --task=commit-graph
> +	)
> +'

Nice fix.

-Justin
