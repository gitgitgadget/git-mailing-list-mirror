Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FE30E835
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165006; cv=none; b=aZKGRqOLX5QOohlhBAowtShb8O6D5mELh1VamU0YlcYOHFsUO162ExxMa8dR3n2Zb75gp7vwvnIlUaSdXdq3z25kNKcwxz8mERDXw7xc432Sy3QsTc3yYJtFWVvkgvwxmC+c1wRH8fGVAuz7PajEAHhsNTnUOmtLcsvp8thLTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165006; c=relaxed/simple;
	bh=bi+cXeJNDW6p17LVvamN8dYUUNITm5V5pxc3gog85vM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W3AB9UOgzmnSgenRYq16nhFBj9ZlRRZ9ryXseHEBtp4TweISUKU5vNyFwv9J0bruuont3AylpCjSw28y8lyKYgOEI9Tto+7MPWuK0OSK58a2iaPNB+xaufV0Vs02kYIuYdfKgt7Teu/Fwq1wSX1nbBj/nz4V1MLwhHMO6z3v7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWJN618e; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWJN618e"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4358fb60802so1170600f8f.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 02:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769165003; x=1769769803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ktz0vRiN7bSYY9T/pbytsXhEAExNb4sA5iYUoxqnlNs=;
        b=TWJN618eIb8+aOvp0aiWHiw/YPPYq4MoXlXXkXeMWw8JzIT/ttPxJYgMIrnvaTlL32
         oY2kLXJ2lMs3j1D4myhrA1C/8Yt5Ad9OSDvxPSagWDy1/qPBgkfx8H6SiB8aUv7s92Io
         2MsXAHMvbasE10fnSGMXGILGji9R4gnYBFdtLJ7VIEzjNk9qyzce5MXeh9hEG8tg4+R7
         MLwpI4X0J9SLkfMNQ++a5XoC2gZHhFTIlIXdUKzeoCEEMEv6rh0PJKc3FF+h3VE9djOW
         /zpR1Wm9eMd5vRgMTQPmnlDvX/7DkSdLVzshcACvsIjkZtISVDiJPEh/kpUspgXFNIrT
         tpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769165003; x=1769769803;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ktz0vRiN7bSYY9T/pbytsXhEAExNb4sA5iYUoxqnlNs=;
        b=S+p5moUgTkAArHPasKIol/qnG/XW1lBLmselG5VYta2anrG7Yb9kagnQpOOsBJf/90
         Fi57TfJv3oEdJvKgHc8j0x8SbtMzBO1jikU5aV0gfdQ6wqkqYnKs/PclIcrMQH3nT3u0
         4hyPO+5nfFHNd0B4L8fccj6+Rdpu0buU8mWpzEqMH35Tbb8wt5dg6BZCcQYM9Aqd9eTK
         IVvwrjrntxXDbVewzKItkTI5JmjwTYr6Y4eS0Ld3jOI73nO04++lOZ63F+YCaSMZ0j0m
         i/jtGYmJFBIHwiRl1d4ycGoGKm/3eMgGgRCynaSjyYNk1sydJ06QWs+BHG6NBTL1EPmv
         2jJQ==
X-Gm-Message-State: AOJu0YyjoEGeJ+saCm6W3DGp9OFD2kIj/5lSeD4M7Swt4+2jm5N+3Nqu
	quDa6YA2hFRi3vfnq85mi/7nEdqZkyd+NyZ6pChjzWRCso4f0HqhMfoFmS3V6uCq
X-Gm-Gg: AZuq6aKDfuy3SVwPTamgZYk3Xu073OU9cTOZ/1yPwfqR6jwK4pSaS1lsOGXQ/WHNvQC
	6WokddWrCjkb/SvNGI8yuBgM9wOIsDBsfI0NCJ6V1MdaO4FTU1VGUcboJpWInnSUsD1/3+d+1AT
	RpN1NiPJjr1lJLHUI10Of04bhONRnKUbjQNqkiCswNecvQnzjoGk+XtmiivFI6HIWcSKHcAVD3R
	G2iabSONupB3i4w+8Y4zousRXeu7jtKmGQc7bxtMuTajboNzN6HTTtTcwYngO2gD8K35ScKCqCx
	Z0NDMv7h+2fQ4zRPu0+cRVqef0UYSBeMn/0h7O11vGp7GzT25LEStm9ELlhzW75GSLkV/Xr4hQ8
	0qtjMvpm8/bMuozmAH2caFXhmPp82/3PYxih+z7/jCLx4qoTy9cGBv9zUhk29xVPWrX+HRhkTT7
	u9agVFGoS1ISWaw1y68Y0Isj4M6rQKm/T7fsnzZlgupL6p5gF6SvQ6O4Nuh8mlScClwQ==
X-Received: by 2002:a05:6000:1446:b0:429:cb8b:b58e with SMTP id ffacd0b85a97d-435b1b8b671mr4705136f8f.28.1769165002532;
        Fri, 23 Jan 2026 02:43:22 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7c269sm6041287f8f.43.2026.01.23.02.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 02:43:21 -0800 (PST)
Message-ID: <4f19e70f-8ab5-4322-ac71-76bc925b324a@gmail.com>
Date: Fri, 23 Jan 2026 10:43:19 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v3 2/3] environment: environment: stop using
 core.sparseCheckout globally
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com,
 karthik.188@gmail.com, Toon Claes <toon@iotcl.com>
References: <cover.1768681947.git.belkid98@gmail.com>
 <fd95169de42891452b430814476d78c706e4a7e2.1768681947.git.belkid98@gmail.com>
 <18b5d932-8a5a-4f33-a803-ef6f0c7d2750@gmail.com>
 <CAD=f0L9JhJq95kV7oUsaN5FqmUAH2qeSTLPLYXKAHUtNiHK_WA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAD=f0L9JhJq95kV7oUsaN5FqmUAH2qeSTLPLYXKAHUtNiHK_WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/01/2026 15:29, Bello Olamide wrote:
> On Thu, 22 Jan 2026 at 15:41, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>>> diff --git a/builtin/backfill.c b/builtin/backfill.c
>>> index e80fc1b694..5fc8c51ed1 100644
>>> --- a/builtin/backfill.c
>>> +++ b/builtin/backfill.c
>>> @@ -139,7 +139,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>>>        repo_config(repo, git_default_config, NULL);
>>>
>>>        if (ctx.sparse < 0)
>>> -             ctx.sparse = core_apply_sparse_checkout;
>>> +             ctx.sparse = repo->config_values.sparse_checkout;
>>
>> Using "repo" rather than "the_repository" here is dangerous because only
>> "the_repository" contains the parsed config. This applies throughout
>> this patch.
> 
> Okay noted...
> Sorry but I have a question.

You don't need to be sorry for having a question - it shows you have 
been thinking about the feedback you have received which is very good.

> I observed that the address of "repo" is passed to builtin/backfill.c,
> is gotten from git.c:handle_builtin
> which passed run_builtin "the_repository" as a parameter.
> 
> Won't the address of "repo" and "the_repository be the same"?

Yes, but I think it is safer to explicitly say "the_repository" so that
if any of the functions you convert here are ever passed another 
repository instance the code will keep working as expected. It also 
documents that the config value is only stored in "the_repository". Once 
we make these config values per-repository then we can use the 
repository instance passed to the function.

Thanks

Phillip

>>
>>>
>>>        result = do_backfill(&ctx);
>>>        backfill_context_clear(&ctx);
>>> diff --git a/builtin/clone.c b/builtin/clone.c
>>> index b19b302b06..b6b19e83d1 100644
>>> --- a/builtin/clone.c
>>> +++ b/builtin/clone.c
>>> @@ -623,7 +623,7 @@ static int git_sparse_checkout_init(const char *repo)
>>>         * We must apply the setting in the current process
>>>         * for the later checkout to use the sparse-checkout file.
>>>         */
>>> -     core_apply_sparse_checkout = 1;
>>> +     the_repository->config_values.sparse_checkout = 1;
>>>
>>>        cmd.git_cmd = 1;
>>>        if (run_command(&cmd)) {
>>> diff --git a/builtin/grep.c b/builtin/grep.c
>>> index 53cccf2d25..525edb5e9c 100644
>>> --- a/builtin/grep.c
>>> +++ b/builtin/grep.c
>>> @@ -482,7 +482,7 @@ static int grep_submodule(struct grep_opt *opt,
>>>         *      "forget" the sparse-index feature switch. As a result, the index
>>>         *      of these submodules are expanded unexpectedly.
>>>         *
>>> -      * 2. "core_apply_sparse_checkout"
>>> +      * 2. "sparse_checkout"
>>
>> That should be something like config_values.sparse_checkout to make it
>> clear that "sparse_checkout" is the name of a member of a struct, not
>> the name of a variable.
> 
> Okay noted
> 
>>
>>> diff --git a/environment.h b/environment.h
>>> index aea73ff25b..3b5ff7094a 100644
>>> --- a/environment.h
>>> +++ b/environment.h
>>> @@ -88,6 +88,7 @@ struct strvec;
>>>    struct repo_config_values {
>>>        /* core config values */
>>>        char *attributes_file_path;
>>> +     int sparse_checkout;
>>
>> There are several other sparse checkout variables like
>> core_sparse_checkout_cone that we'll need to convert in the future so
>> "apply_sparse_checkout" or "sparse_checkout_apply" would be better names.
> 
> Okay noted.
> 
>>
>> Thanks
>>
>> Phillip
>>
>>
>>>    };
>>>
>>>    /*
>>> @@ -169,7 +170,6 @@ extern int precomposed_unicode;
>>>    extern int protect_hfs;
>>>    extern int protect_ntfs;
>>>
>>> -extern int core_apply_sparse_checkout;
>>>    extern int core_sparse_checkout_cone;
>>>    extern int sparse_expect_files_outside_of_patterns;
>>>
>>> diff --git a/sparse-index.c b/sparse-index.c
>>> index 76f90da5f5..6dd8dd679d 100644
>>> --- a/sparse-index.c
>>> +++ b/sparse-index.c
>>> @@ -152,7 +152,8 @@ static int index_has_unmerged_entries(struct index_state *istate)
>>>
>>>    int is_sparse_index_allowed(struct index_state *istate, int flags)
>>>    {
>>> -     if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
>>> +     struct repo_config_values *cfg = &istate->repo->config_values;
>>> +     if (!cfg->sparse_checkout || !core_sparse_checkout_cone)
>>>                return 0;
>>>
>>>        if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
>>> @@ -670,7 +671,8 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
>>>
>>>    void clear_skip_worktree_from_present_files(struct index_state *istate)
>>>    {
>>> -     if (!core_apply_sparse_checkout ||
>>> +     struct repo_config_values *cfg = &istate->repo->config_values;
>>> +     if (!cfg->sparse_checkout ||
>>>            sparse_expect_files_outside_of_patterns)
>>>                return;
>>>
>>> diff --git a/unpack-trees.c b/unpack-trees.c
>>> index f38c761ab9..2bdfa1334c 100644
>>> --- a/unpack-trees.c
>>> +++ b/unpack-trees.c
>>> @@ -1924,7 +1924,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>>        if (o->prefix)
>>>                update_sparsity_for_prefix(o->prefix, o->src_index);
>>>
>>> -     if (!core_apply_sparse_checkout || !o->update)
>>> +     if (!repo->config_values.sparse_checkout || !o->update)
>>>                o->skip_sparse_checkout = 1;
>>>        if (!o->skip_sparse_checkout) {
>>>                memset(&pl, 0, sizeof(pl));
>>> diff --git a/wt-status.c b/wt-status.c
>>> index e12adb26b9..a2e388606f 100644
>>> --- a/wt-status.c
>>> +++ b/wt-status.c
>>> @@ -1764,7 +1764,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
>>>        int skip_worktree = 0;
>>>        int i;
>>>
>>> -     if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
>>> +     if (!r->config_values.sparse_checkout || r->index->cache_nr == 0) {
>>>                /*
>>>                 * Don't compute percentage of checked out files if we
>>>                 * aren't in a sparse checkout or would get division by 0.
>>

