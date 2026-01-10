Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6130FF1D
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 04:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768018661; cv=none; b=jVje0rwD2RW/snP2onseeByOh9ZtdMlYM5rbzF9fnMYyA1NCk6A4GiqjPdUpeskkYDXDxaTVI1w7RagnIxj0v0NHc9RGf6JGLJuYEMrmq3vywIna+4wwcHICvUV0OqBMXGgsY0yFusHIIZFJR772Lia1JBKODTjKFK/l0fdvPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768018661; c=relaxed/simple;
	bh=bIfVyG7FVvRkrS16/N2nRMqrnoP6ZDfjlatH0SttTXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHUdTqJFIephw/THp3B2K60Yx8Ny6xJlufhH7tg8TJ9FTBDIB6We07M8h4/a/KZy0GFd+jOFCzUM5DMSKqPtA/MpoeIyfYrzuPQwDBqcT0XGul9Zj4VOKw+5dxln8rwdZB5Zj6u1VkWwBJ6FrDZkSx1BR8Rmfa6oP9j+SMwYT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cZdcQnT/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dc0ssPfd; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cZdcQnT/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dc0ssPfd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2AB67A0087;
	Fri,  9 Jan 2026 23:17:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 09 Jan 2026 23:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768018654;
	 x=1768105054; bh=/GfRet2x1j5QoTEA0Qkr/QOFhjxAG19+nZZ67WF4fkI=; b=
	cZdcQnT/Ftcbd7wQh25unoNpXbKRZ7Xgzj0rpnX6r8Rw0kTmnVFZnPr9K0M/2a78
	mdVP7Vd2nFmJdtFq82GWHS2oqI4atfxCnRFfFZPGhEohlAyeYC0aE2byqqTG5eEZ
	mc7YrhAM99ioy6hVw/qSZqQBmwBqbWsT1ikjteI2MbopFxpqnQ2pQEugzXxdns1H
	Z1q2cKEPCcdCP0rb3J28NUO025JCwRUm1cWPG4xxjGBtk93lAn9DL/P62PN9dHoD
	le+KoeIvmIv1P/2I1Q3tEqsUmiA+wByKRqQf/m7DqwxoXriZ9ZcqKFMA/BbSWFJW
	RMLQ8r9QHNwGqg0NEKssIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768018654; x=
	1768105054; bh=/GfRet2x1j5QoTEA0Qkr/QOFhjxAG19+nZZ67WF4fkI=; b=D
	c0ssPfdF3KEWZ/88grcQVFSJ0kVV0bPcpdWPFUvLv7V2dRvp6N/JMCxGTcJKFBJs
	ocNApoUrFvNMbui5Lepp3Skz2cTGu1dZ8FbQomustLOi7dMyTd7wVQUWS/5puACg
	GIHUX2tlA1Ibo0D7nCus0DS36hjtTKU92sNxRfssOHsCmcEjsz8ZNjT2myRm4VDd
	P39ZA6WJYoBZDssnXbzmgbWFMv+EHb1eP/Am0/PRxwgWuRxoGvM6Shl8LOqrFOjm
	FJMrdP6G32vDUufPbrCZmt4K8BjZU6rQTXTr5WIu5N6vwhybLon2s9AHjVxp0zEJ
	jebb20YTnQkO83BdEUHrA==
X-ME-Sender: <xms:3tJhaQMBtu0S19BZQEu7OUlRwsDlGHBJdpUxjZ325sulhBq6J-SltQ>
    <xme:3tJhad0GWF9uDBNNj-6txMRuTG1BbJAOaKtPPjmM3MGo1o106GsgdzmqcO58lDTkE
    vMo5ZEfV4OhR4YLodE4LJ2OdIWKgon2TvQpnvmsliHDOQYwb00oXA>
X-ME-Received: <xmr:3tJhafkMdEvXwoUUyMeo_egYyuwkL2QhM7KeSovli-DBKZojtTJLguN3vs9ZLcYOmgK_gRl76CuFcUpeZBdD3mwj1IJPdwtOuuqpWl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddtjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghmohgpphhoghgrtghnihhksehtqd
    dvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3tJhaUVmPs1M3sKTjoTd5PsZIZP0so1_2LDsTXFw_jZwYev743DzKw>
    <xmx:3tJhaVtGJcY6__tMcpUxXHEgU0nRSL26hHfWVCv0EmNBsBkDoXfc-w>
    <xmx:3tJhaXYQ9aSh9jxdrwr6oEkJRcONe9Qc8DgpXadS_--yR78rmMt6mw>
    <xmx:3tJhaUVOI0C8aFJJbJ93Hsdz70cUGNJ-56amRndrP-4_dA6tnsSzJQ>
    <xmx:3tJhaWyzKHAdnxcMd4W-mQSp6LuD7q6o4-k-bFCuikD6OYem60OUd8Ay>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 23:17:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Samo_Poga=C4=8Dnik_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Samo
 =?utf-8?Q?Poga=C4=8Dnik?=
 <samo_pogacnik@t-2.net>
Subject: Re: [PATCH v2 2/2] shallow: handling fetch relative-deepen
In-Reply-To: <ba1f80105f3e1c3dc6d133fb319e1df69a19bf8f.1767997426.git.gitgitgadget@gmail.com>
	("Samo =?utf-8?Q?Poga=C4=8Dnik?= via GitGitGadget"'s message of "Fri, 09
 Jan 2026
	22:23:46 +0000")
References: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
	<pull.2121.v2.git.git.1767997426.gitgitgadget@gmail.com>
	<ba1f80105f3e1c3dc6d133fb319e1df69a19bf8f.1767997426.git.gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:17:32 -0800
Message-ID: <xmqqsecertib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Samo Pogačnik via GitGitGadget" <gitgitgadget@gmail.com> writes:

> 2. Deepen shallow clone with fetch --deepen=1 (NOT OK)
> Shallows:
> 0cb5d204f4ef96ed241feb0f2088c9f4794ba758
> 61ba98be443fd51c542eb66585a1f6d7e15fcdae
> Graph:
> *   033585d (HEAD -> main) Merge branch 'branch'
> |\
> | * 984f8b1 five
> | * ecb578a four
> |/
> * 0cb5d20 (grafted) three
> ---

This three-dash line will act as a marker to tell "git am" that your
log message ends here.

To avoid such an accident, make it a habit to indent any and all
displayed material used as examples, e.g.,

2. Deepen shallow clone with fetch --deepen=1 (NOT OK)

   Shallows:
   0cb5d204f4ef96ed241feb0f2088c9f4794ba758
   61ba98be443fd51c542eb66585a1f6d7e15fcdae
   Graph:
   *   033585d (HEAD -> main) Merge branch 'branch'
   |\
   | * 984f8b1 five
   | * ecb578a four
   |/
   * 0cb5d20 (grafted) three
   ---



> Note that second shallow commit 61ba98be443fd51c542eb66585a1f6d7e15fcdae
> is not reachable.
>
> On the other hand, it seems that equivalent absolute depth driven
> fetches result in all the correct shallows. That led to this proposal,
> which unifies absolute and relative deepening in a way that the same
> get_shallow_commits() call is used in both cases. The difference is
> only that depth is adapted for relative deepening by measuring
> equivalent depth of current local shallow commits in the current remote
> repo. Thus a new function get_shallows_depth() has been added and the
> function get_reachable_list() became redundant / removed.
>
> Same example showing the corrected second step:
> 2. Deepen shallow clone with fetch --deepen=1 (all good)
> Shallow:
> 61ba98be443fd51c542eb66585a1f6d7e15fcdae
> Graph:
> *   033585d (HEAD -> main) Merge branch 'branch'
> |\
> | * 984f8b1 five
> | * ecb578a four
> |/
> * 0cb5d20 three
> * 2b4e70d two
> * 61ba98b (grafted) one
>
> The get_shallows_depth() function also shares the logic of the
> get_shallow_commits() function, but it focuses on counting depth of
> each existing shallow commit. The minimum result is stored as
> 'data->deepen_relative', which is set not to be zero for relative
> deepening anyway. That way we can allways summ 'data->deepen_relative'
> and 'depth' values, because 'data->deepen_relative' is always 0 in
> absolute deepening.
>
> Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
> ---
>  shallow.c             | 44 +++++++++++++++++--------
>  shallow.h             |  1 +
>  t/t5500-fetch-pack.sh | 23 +++++++++++++
>  upload-pack.c         | 76 +++++--------------------------------------
>  4 files changed, 63 insertions(+), 81 deletions(-)
>
> diff --git a/shallow.c b/shallow.c
> index 497a25836b..1a32808865 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -130,11 +130,12 @@ static void free_depth_in_slab(int **ptr)
>  {
>  	FREE_AND_NULL(*ptr);
>  }
> -struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
> -		int shallow_flag, int not_shallow_flag)
> +struct commit_list *get_shallow_commits(struct object_array *heads,
> +					struct object_array *shallows, int *deepen_relative,
> +					int depth, int shallow_flag, int not_shallow_flag)
>  {
> -	size_t i = 0;
> -	int cur_depth = 0;
> +	size_t i = 0, j;
> +	int cur_depth = 0, cur_depth_shallow = 0;
>  	struct commit_list *result = NULL;
>  	struct object_array stack = OBJECT_ARRAY_INIT;
>  	struct commit *commit = NULL;
> @@ -168,16 +169,30 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
>  		}
>  		parse_commit_or_die(commit);
>  		cur_depth++;
> -		if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
> -		    (is_repository_shallow(the_repository) && !commit->parents &&
> -		     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
> -		     graft->nr_parent < 0)) {
> -			commit_list_insert(commit, &result);
> -			commit->object.flags |= shallow_flag;
> -			commit = NULL;
> -			continue;
> +		if (shallows) {
> +			for (j = 0; j < shallows->nr; j++)
> +				if (oideq(&commit->object.oid, &shallows->objects[j].item->oid))
> +					if ((!cur_depth_shallow) || (cur_depth < cur_depth_shallow))
> +						cur_depth_shallow = cur_depth;
> +
> +			if ((is_repository_shallow(the_repository) && !commit->parents &&
> +			     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
> +			     graft->nr_parent < 0)) {
> +				commit = NULL;
> +				continue;
> +			}
> +		} else {
> +			if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
> +			    (is_repository_shallow(the_repository) && !commit->parents &&
> +			     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
> +			     graft->nr_parent < 0)) {
> +				commit_list_insert(commit, &result);
> +				commit->object.flags |= shallow_flag;
> +				commit = NULL;
> +				continue;
> +			}
> +			commit->object.flags |= not_shallow_flag;
>  		}
> -		commit->object.flags |= not_shallow_flag;
>  		for (p = commit->parents, commit = NULL; p; p = p->next) {
>  			int **depth_slot = commit_depth_at(&depths, p->item);
>  			if (!*depth_slot) {
> @@ -199,7 +214,8 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
>  	}
>  	deep_clear_commit_depth(&depths, free_depth_in_slab);
>  	object_array_clear(&stack);
> -
> +	if (shallows && deepen_relative)
> +		*deepen_relative = cur_depth_shallow;
>  	return result;
>  }
>  
> diff --git a/shallow.h b/shallow.h
> index ad591bd139..d1b3878635 100644
> --- a/shallow.h
> +++ b/shallow.h
> @@ -36,6 +36,7 @@ int commit_shallow_file(struct repository *r, struct shallow_lock *lk);
>  void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);
>  
>  struct commit_list *get_shallow_commits(struct object_array *heads,
> +					struct object_array *shallows, int *deepen_relative,
>  					int depth, int shallow_flag, int not_shallow_flag);
>  struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
>  						    int shallow_flag, int not_shallow_flag);
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 2677cd5faa..5a8b30e1fd 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -955,6 +955,29 @@ test_expect_success 'fetching deepen' '
>  	)
>  '
>  
> +test_expect_success 'fetching deepen beyond merged branch' '
> +	test_create_repo shallow-deepen-merged &&
> +	(
> +		cd shallow-deepen-merged &&
> +		git commit --allow-empty -m one &&
> +		git commit --allow-empty -m two &&
> +		git commit --allow-empty -m three &&
> +		git switch -c branch &&
> +		git commit --allow-empty -m four &&
> +		git commit --allow-empty -m five &&
> +		git switch main &&
> +		git merge --no-ff branch &&
> +		cd - &&
> +		git clone --bare --depth 3 "file://$(pwd)/shallow-deepen-merged" deepen.git &&
> +		git -C deepen.git fetch origin --deepen=1 &&
> +		git -C deepen.git rev-list --all >actual &&
> +		for commit in $(sed "/^$/d" deepen.git/shallow)
> +		do
> +			test_grep "$commit" actual || exit 1
> +		done
> +	)
> +'
> +
>  test_negotiation_algorithm_default () {
>  	test_when_finished rm -rf clientv0 clientv2 &&
>  	rm -rf server client &&
> diff --git a/upload-pack.c b/upload-pack.c
> index 2d2b70cbf2..4232eef34f 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -704,54 +704,11 @@ error:
>  	return -1;
>  }
>  
> -static int get_reachable_list(struct upload_pack_data *data,
> -			      struct object_array *reachable)
> +static void get_shallows_depth(struct upload_pack_data *data)
>  {
> -	struct child_process cmd = CHILD_PROCESS_INIT;
> -	int i;
> -	struct object *o;
> -	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
> -	const unsigned hexsz = the_hash_algo->hexsz;
> -	int ret;
> -
> -	if (do_reachable_revlist(&cmd, &data->shallows, reachable,
> -				 data->allow_uor) < 0) {
> -		ret = -1;
> -		goto out;
> -	}
> -
> -	while ((i = read_in_full(cmd.out, namebuf, hexsz + 1)) == hexsz + 1) {
> -		struct object_id oid;
> -		const char *p;
> -
> -		if (parse_oid_hex(namebuf, &oid, &p) || *p != '\n')
> -			break;
> -
> -		o = lookup_object(the_repository, &oid);
> -		if (o && o->type == OBJ_COMMIT) {
> -			o->flags &= ~TMP_MARK;
> -		}
> -	}
> -	for (i = get_max_object_index(the_repository); 0 < i; i--) {
> -		o = get_indexed_object(the_repository, i - 1);
> -		if (o && o->type == OBJ_COMMIT &&
> -		    (o->flags & TMP_MARK)) {
> -			add_object_array(o, NULL, reachable);
> -				o->flags &= ~TMP_MARK;
> -		}
> -	}
> -	close(cmd.out);
> -
> -	if (finish_command(&cmd)) {
> -		ret = -1;
> -		goto out;
> -	}
> -
> -	ret = 0;
> -
> -out:
> -	child_process_clear(&cmd);
> -	return ret;
> +	get_shallow_commits(&data->want_obj, &data->shallows,
> +			    &data->deepen_relative, 0,
> +			    SHALLOW, NOT_SHALLOW);
>  }
>  
>  static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
> @@ -881,29 +838,14 @@ static void deepen(struct upload_pack_data *data, int depth)
>  			struct object *object = data->shallows.objects[i].item;
>  			object->flags |= NOT_SHALLOW;
>  		}
> -	} else if (data->deepen_relative) {
> -		struct object_array reachable_shallows = OBJECT_ARRAY_INIT;
> -		struct commit_list *result;
> -
> -		/*
> -		 * Checking for reachable shallows requires that our refs be
> -		 * marked with OUR_REF.
> -		 */
> -		refs_head_ref_namespaced(get_main_ref_store(the_repository),
> -					 check_ref, data);
> -		for_each_namespaced_ref_1(check_ref, data);
> -
> -		get_reachable_list(data, &reachable_shallows);
> -		result = get_shallow_commits(&reachable_shallows,
> -					     depth + 1,
> -					     SHALLOW, NOT_SHALLOW);
> -		send_shallow(data, result);
> -		free_commit_list(result);
> -		object_array_clear(&reachable_shallows);
>  	} else {
>  		struct commit_list *result;
>  
> -		result = get_shallow_commits(&data->want_obj, depth,
> +		if (data->deepen_relative)
> +			get_shallows_depth(data);
> +
> +		result = get_shallow_commits(&data->want_obj, NULL, NULL,
> +					     data->deepen_relative + depth,
>  					     SHALLOW, NOT_SHALLOW);
>  		send_shallow(data, result);
>  		free_commit_list(result);
