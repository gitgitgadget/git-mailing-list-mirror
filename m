Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175F224AF7
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186322; cv=none; b=F/tnO+xLj9a1spaqTWCoEWQZV/vLBXhUbGRHlyxcJvgLeS/GXXvBjlmEH4evXmmBm7ZZ+M7SIbZ7aPUr9r1J0iMmlHOoF9TDyrgpurBUFBOZVwS+Hn3siOvyi1SNCsCsJl9UvYCxV/ZqB9j+7W4XwIld1mF2sLsE6ToUWb5XKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186322; c=relaxed/simple;
	bh=4BNcog3hSh2aKtppZigXPHtXYpS9jlMhBv/jPbattD4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Bcicj6EkIaQH302X5EtEqtfyEpMvqmpzxNk4x8mkPeBIw8fixHXmDsm8Sj3wA8QXvwz5q0YKuJc/jca0Tl9ozwTDVG17gLVIVZ9TbxE8nt+dvDT5E30PjpE0LYa2gTjd/ZQWIC4Zwxc1NqSqnHEzhfZ+GFaJNJ7p8bPEicrnnRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJGkxoSY; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJGkxoSY"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-124afd03fd1so3785267c88.0
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 12:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771186320; x=1771791120; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5FvsL+VGbL0/WULuycIDzqDtYDWvcd8yr2GnDd5vDE=;
        b=HJGkxoSYVDW8gFuDH+MYjJ11hSL3hoZQm5DJajFkJ62olvjklkFYlUwiYmogpH8TU9
         RG3lWrBJ9N0UMw/J3HVXoauT71gLIg2rWJa/rOcw8q6oLWLZG+BO9KfI+OBo8/iQ9rTN
         It+pYfkm/isQF29wxk04HHrlQrddEOeL7ZnPOLJN+kd8UckgeO4dh9Z2X8vsqYXhD1/4
         4iaCpTe/FiRtESyP7w3k0XPG1EbT67uuBe+XHIAWjI+mLawzTB37Laaxu0X/rs80p5Fe
         oNCByGKIduu33EVVzTDmf/Lk6X6nOIX3KOsntmJmTHTLMhSZxm1932MuenTxavZPUN10
         2k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771186320; x=1771791120;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f5FvsL+VGbL0/WULuycIDzqDtYDWvcd8yr2GnDd5vDE=;
        b=Jda617TDp9XLgZmJWU82N+c8XotI07oHXQwgGFMa3HmoCaQMuQ5oY9tF9B21QYWfyP
         s9RTgmK6SCtbtOZ04nBtvke7puejRKnFUqo+ZeLmVg3OtxAcI/kHiiQrU++rMpdUMnrF
         W5YXv+VdoyeY5Vu7EZ7pDmAFFSN+xguFuZU6KybKnGuyBD9au2DkMDUt4eE2iFCWjxU2
         RLen/SeT9wXl9qEKoiEx894fXPqZks7kW3bjt0PwLKgNuvXhFYBIxlmWM3JV3H5cW5qa
         d7VqLN4mkbb4R+aYo8b+fpGI4qHj3dLwREHq8OvHDHCzkyJfesDgnHqLsyE2bOYYC59L
         6vog==
X-Gm-Message-State: AOJu0YwFxWf/sleMluPP+uZnpu/u7iUKAqHKRYFchwKsTZ1ak1fGEZok
	xF+S7OT+nZxmePyAg76iCcyISuccvtYfix6WbgqE3ADxv1ppq76uVcz1Kd/RBg==
X-Gm-Gg: AZuq6aIwkX25Cl9on6xt5PRDKoCV7jjwHgL0VQ/ZNxN50qMzXcUyVpDjibMUwlYLS7v
	RXBuOe1N1qIMlV24Tg+6hLz3YEd/UpjM0+6PmTVK22PYEtuevwgdcMvykxjR+HjuRFU3g91EqYk
	RB1Dyu+35kCA/KN915EOj5BMA6uaGOkmPtDp42tiTpOWzXIBKYGoHG1wcDeAliq7XzwohdugfMo
	PXS6pdOCQqHCLhOCSd5x71nJSjmn77b8j5vLzqKbN3M9T049d64clUU8uAHHJ5MM+Ur7RV/mlwh
	WvnmdXHtwzRDOnbLxlx424L10ob/7NIfrzfhh6MKqBLPCv+S8ktxsQ8oQBNhlZdwy8kpbjX/ONK
	GNIxjYzUciu6oN+AjxhuLLCsfoaUd4POn3toNEGqtAPeoCGI9tZqa2jQza5xm4LAzw8JW5I2llu
	I8Vw/CzMl5ydfqqkFLpfvxhDh4MFnp9R+6nXJEcA==
X-Received: by 2002:a05:7022:618a:b0:119:e56b:91e6 with SMTP id a92af1059eb24-12741bb83aemr2733975c88.23.1771186319627;
        Sun, 15 Feb 2026 12:11:59 -0800 (PST)
Received: from [127.0.0.1] ([172.182.224.114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c6430asm7431369c88.6.2026.02.15.12.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 12:11:57 -0800 (PST)
Message-Id: <pull.2121.v5.git.git.1771186316.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v4.git.git.1768602661.gitgitgadget@gmail.com>
References: <pull.2121.v4.git.git.1768602661.gitgitgadget@gmail.com>
From: "Samo =?UTF-8?Q?Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Feb 2026 20:11:54 +0000
Subject: [PATCH v5 0/2] shallow: handling fetch relative-deepen
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

When a shallowed repository gets deepened beyond the beginning of a merged
branch, we may endup with some shallows, that are behind the reachable ones.
Added test 'fetching deepen beyond merged branch' exposes that behaviour.

On the other hand, it seems that equivalent absolute depth driven fetches
result in all the correct shallows. That led to this proposal, which unifies
absolute and relative deepening in a way that the same get_shallow_commits()
call is used in both cases. The difference is only that depth is adapted for
relative deepening by measuring equivalent depth of current local shallow
commits in the current remote repo. Thus a new function get_shallows_depth()
has been added and the function get_reachable_list() became redundant /
removed.

The get_shallows_depth() function also shares the logic of the
get_shallow_commits() function, but it focuses on counting depth of each
existing shallow commit. The minimum result is stored as
'data->deepen_relative', which is set not to be zero for relative deepening
anyway. That way we can allways summ 'data->deepen_relative' and 'depth'
values, because 'data->deepen_relative' is always 0 in absolute deepening.

Samo Pogačnik (2):
  shallow: free local object_array allocations
  shallow: handling fetch relative-deepen

 shallow.c             | 73 ++++++++++++++++++++++++++++++++++++-------
 shallow.h             |  2 ++
 t/t5500-fetch-pack.sh | 23 ++++++++++++++
 upload-pack.c         | 72 ++----------------------------------------
 4 files changed, 88 insertions(+), 82 deletions(-)


base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2121%2Fspog%2Ffix-fetch-deepen-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2121/spog/fix-fetch-deepen-v5
Pull-Request: https://github.com/git/git/pull/2121

Range-diff vs v4:

 1:  f8a8d077cd = 1:  f8a8d077cd shallow: free local object_array allocations
 2:  e9b20ae06f ! 2:  8d48ba9cd1 shallow: handling fetch relative-deepen
     @@ Commit message
      
          Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
      
     +    Fixing v4
     +
     +    Fixing v4 again
     +
       ## shallow.c ##
      @@ shallow.c: static void free_depth_in_slab(int **ptr)
       {
     @@ shallow.c: static void free_depth_in_slab(int **ptr)
       }
      -struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
      -		int shallow_flag, int not_shallow_flag)
     -+struct commit_list *get_shallow_commits(struct object_array *heads,
     -+					struct object_array *shallows, int *deepen_relative,
     -+					int depth, int shallow_flag, int not_shallow_flag)
     ++/*
     ++ * This is a common internal function that can either return a list of
     ++ * shallow commits or calculate the current maximum depth of a shallow
     ++ * repository, depending on the input parameters.
     ++ *
     ++ * Depth calculation is triggered by passing the `shallows` parameter.
     ++ * In this case, the computed depth is stored in `max_cur_depth` (if it is
     ++ * provided), and the function returns NULL.
     ++ *
     ++ * Otherwise, `max_cur_depth` remains unchanged and the function returns
     ++ * a list of shallow commits.
     ++ */
     ++static struct commit_list *get_shallows_or_depth(struct object_array *heads,
     ++				struct object_array *shallows, int *max_cur_depth,
     ++				int depth, int shallow_flag, int not_shallow_flag)
       {
     --	size_t i = 0;
     + 	size_t i = 0;
      -	int cur_depth = 0;
     -+	size_t i = 0, j;
      +	int cur_depth = 0, cur_depth_shallow = 0;
       	struct commit_list *result = NULL;
       	struct object_array stack = OBJECT_ARRAY_INIT;
     @@ shallow.c: struct commit_list *get_shallow_commits(struct object_array *heads, i
      -			commit = NULL;
      -			continue;
      +		if (shallows) {
     -+			for (j = 0; j < shallows->nr; j++)
     ++			for (size_t j = 0; j < shallows->nr; j++)
      +				if (oideq(&commit->object.oid, &shallows->objects[j].item->oid))
     -+					if ((!cur_depth_shallow) || (cur_depth < cur_depth_shallow))
     ++					if (!cur_depth_shallow || cur_depth < cur_depth_shallow)
      +						cur_depth_shallow = cur_depth;
      +
      +			if ((is_repository_shallow(the_repository) && !commit->parents &&
     @@ shallow.c: struct commit_list *get_shallow_commits(struct object_array *heads, i
       			int **depth_slot = commit_depth_at(&depths, p->item);
       			if (!*depth_slot) {
      @@ shallow.c: struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
     - 	}
       	deep_clear_commit_depth(&depths, free_depth_in_slab);
       	object_array_clear(&stack);
     --
     -+	if (shallows && deepen_relative)
     -+		*deepen_relative = cur_depth_shallow;
     + 
     ++	if (shallows && max_cur_depth)
     ++		*max_cur_depth = cur_depth_shallow;
       	return result;
       }
       
     ++int get_shallows_depth(struct object_array *heads, struct object_array *shallows)
     ++{
     ++	int max_cur_depth = 0;
     ++	get_shallows_or_depth(heads, shallows, &max_cur_depth, 0, 0, 0);
     ++	return max_cur_depth;
     ++
     ++}
     ++
     ++struct commit_list *get_shallow_commits(struct object_array *heads,
     ++					struct object_array *shallows, int deepen_relative,
     ++					int depth, int shallow_flag, int not_shallow_flag)
     ++{
     ++	if (shallows && deepen_relative) {
     ++		depth += get_shallows_depth(heads, shallows);
     ++	}
     ++	return get_shallows_or_depth(heads, NULL, NULL,
     ++				     depth, shallow_flag, not_shallow_flag);
     ++}
     ++
     + static void show_commit(struct commit *commit, void *data)
     + {
     + 	commit_list_insert(commit, data);
      
       ## shallow.h ##
      @@ shallow.h: int commit_shallow_file(struct repository *r, struct shallow_lock *lk);
     + /* rollback $GIT_DIR/shallow and reset stat-validity checks */
       void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);
       
     ++int get_shallows_depth(struct object_array *heads, struct object_array *shallows);
       struct commit_list *get_shallow_commits(struct object_array *heads,
     -+					struct object_array *shallows, int *deepen_relative,
     ++					struct object_array *shallows, int deepen_relative,
       					int depth, int shallow_flag, int not_shallow_flag);
       struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
       						    int shallow_flag, int not_shallow_flag);
     @@ upload-pack.c: error:
       
      -static int get_reachable_list(struct upload_pack_data *data,
      -			      struct object_array *reachable)
     -+static void get_shallows_depth(struct upload_pack_data *data)
     - {
     +-{
      -	struct child_process cmd = CHILD_PROCESS_INIT;
      -	int i;
      -	struct object *o;
     @@ upload-pack.c: error:
      -out:
      -	child_process_clear(&cmd);
      -	return ret;
     -+	get_shallow_commits(&data->want_obj, &data->shallows,
     -+			    &data->deepen_relative, 0,
     -+			    SHALLOW, NOT_SHALLOW);
     - }
     - 
     +-}
     +-
       static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
     + {
     + 	struct child_process cmd = CHILD_PROCESS_INIT;
      @@ upload-pack.c: static void deepen(struct upload_pack_data *data, int depth)
       			struct object *object = data->shallows.objects[i].item;
       			object->flags |= NOT_SHALLOW;
     @@ upload-pack.c: static void deepen(struct upload_pack_data *data, int depth)
       		struct commit_list *result;
       
      -		result = get_shallow_commits(&data->want_obj, depth,
     -+		if (data->deepen_relative)
     -+			get_shallows_depth(data);
     -+
     -+		result = get_shallow_commits(&data->want_obj, NULL, NULL,
     -+					     data->deepen_relative + depth,
     ++		result = get_shallow_commits(&data->want_obj, &data->shallows,
     ++					     data->deepen_relative, depth,
       					     SHALLOW, NOT_SHALLOW);
       		send_shallow(data, result);
       		free_commit_list(result);

-- 
gitgitgadget
