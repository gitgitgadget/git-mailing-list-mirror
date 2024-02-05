Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FF7482C9
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159350; cv=none; b=TSHA7+zP8buyGBnil7efLk5/vbiiMrEq0pIJ+p9ssYo9ER2WdWKJ8sYy3rUDMvv+4QplAmegl3NiB4IQz1x07gMD9xIZ6I9nECswhEq4OWvt8ZYiQY2Z4+Lv9e2SDTo/GqEf3p8FuRPZFJqujVrTXJsi4CIpkP7+F8OkirZEw24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159350; c=relaxed/simple;
	bh=fsXYR8JKaZxldGGCz/MHJNE3Oc6JTWI3B09xlcMuwaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JwTcelUnT5lMCrV/+kwqbV+NSgfQIzRnB9F0YzV+hTBSXJsf37gDcr5DAO1YjnJaQ33U6oNxf9VBdfw3h3Z/Q2004yeXpDV7oqad5W8HD4GJOLJ/gUwcCVRM9Uiw8roL03ymbnueNVRnktfbzGdEB0A+9NZ+ueIJZE+PNQjm6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcbbfk1l; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcbbfk1l"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e038bdf6b1so1030803b3a.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707159348; x=1707764148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKMUxT2mUrD1S5MdbAoMy/0vfnM0hjbC5AULBWgyeBY=;
        b=jcbbfk1lpso86ruYl33xtimTxlIPSxQIfm1hXUiGWqBmkKOffByrbR9UnvDEZJu3CO
         8/DWPIS4U0jcO0/wCgCzUlUbydlt902wviDYghaIT309nOoXB+BHA0HhpiSG1VqlGm2C
         QA8RBVFBVgZ9/CmxMV0eJzCSQ+YdsbrR09vw/o/zrbOSeLFcrerIcHKW8tFBlJMZ733s
         F1JPmphNet8EaSB8waSf9a2tnEek6xX5AsMj+HrT9QdLuZfdDAmKsnUb2YPXQ6Ij9wQP
         9huKRwG+NGJIdN9CPi8f+aNN0OMHy00ozYTiVkAMRKWFAn+qamkm3hZV2tZKCAHahV8O
         +IHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159348; x=1707764148;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKMUxT2mUrD1S5MdbAoMy/0vfnM0hjbC5AULBWgyeBY=;
        b=BXlpXd2vmpBp2pMqwLQSbY7rlyRpLshHgq9Rn36RYoFKvhbEaRgod2faHeq9amLb1C
         lSKnidMzUony4N+hqbNDeFPGpbSgraz9JxRxcDj0U9MKB49bdr1jXW3Pl3hRTvJBYtnA
         pvUrHMLGQxX+0PCklXX5klZeHfrfMT/6fPnbHy4YsWqOLjOzYAKAkqPuDNa3J43blyuv
         oye8vJvXyi07Wf5PWRCLBmCKVyWrR9WUhSA4wJSbVN1bfOgO9ljnGNpkzTVWvEpq+vkO
         f3TY9/jAlvoScOfKTeOsV8iO0cQE0HRPUtlmZuSBM2cLiDwABX3JJF+IZs1xHJGkiuTc
         b6pA==
X-Gm-Message-State: AOJu0YxGUBjM8pyj4OmET22gWZE9daF4bQFveP4+HKeovo+Rs2kJTv2d
	+fVTug9N1Shh1kOsrEq3aKYDqdFCoCT5QXWZkxY2tMwxXjj5R6vdo2s2B5Hd
X-Google-Smtp-Source: AGHT+IExMO8W7ktNOsCUfw0JMKisXt4CfQQrbGbgaOxze2qdsRhVcMRXIcxAsdbiZKcAttz5PdQ+/Q==
X-Received: by 2002:a05:6a00:8d87:b0:6e0:54bd:271d with SMTP id im7-20020a056a008d8700b006e054bd271dmr472162pfb.12.1707159348007;
        Mon, 05 Feb 2024 10:55:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW3MhC83kTm1MkmAgfpWqxC8UzTn7BbOwDTqQ7ggAy9iC3LRlrSXFy1g6fNp0T+czhHNbXOj4kp9Y4syPRay/rjoQ==
Received: from five231003 ([2405:201:c006:31fd:5631:f072:bdeb:d2e3])
        by smtp.gmail.com with ESMTPSA id w20-20020aa78594000000b006e0427b57e8sm189149pfn.4.2024.02.05.10.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:55:47 -0800 (PST)
Date: Tue, 6 Feb 2024 00:25:43 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/7] refs: add pseudorefs array and iteration functions
Message-ID: <ZcEvLwp0t8-rcyGn@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023221143.72489-6-andy.koppe@gmail.com>

Andy Koppe <andy.koppe@gmail.com> wrote:

> Define const array 'pseudorefs' with the names of the pseudorefs that
> are documented in gitrevisions.1, and add functions for_each_pseudoref()
> and refs_for_each_pseudoref() for iterating over them.
> 
> The functions process the pseudorefs in the same way as head_ref() and
> refs_head_ref() process HEAD, invoking an each_ref_fn callback on each
> pseudoref that exists.
> 
> This is in preparation for adding pseudorefs to log decorations.
> 
> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---

[...]

> +/*
> + * List of documented pseudorefs. This needs to be kept in sync with the list
> + * in Documentation/revisions.txt.
> + */
> +static const char *const pseudorefs[] = {
> +	"FETCH_HEAD",
> +	"ORIG_HEAD",
> +	"MERGE_HEAD",
> +	"REBASE_HEAD",
> +	"CHERRY_PICK_HEAD",
> +	"REVERT_HEAD",
> +	"BISECT_HEAD",
> +	"AUTO_MERGE",
> +};
> +
>  struct ref_namespace_info ref_namespace[] = {
>  	[NAMESPACE_HEAD] = {
>  		.ref = "HEAD",
> @@ -1549,6 +1564,33 @@ int head_ref(each_ref_fn fn, void *cb_data)
>  	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
>  }

The first thing that popped up in my head was "Should we somehow use
is_pseudoref_syntax() instead of manually listing these?" (although I
read in this thread later that Junio was okay with the listing) but then ...

I thought I saw something similar in some other thread (which entered
the mailing list much after this patch series was submitted) ...

	https://lore.kernel.org/git/20231221170715.110565-2-karthik.188@gmail.com/T/

The whole thread is really interesting but some points that are worth to
be mentioned in this context are

	" ... Patrick's reftable work based on Han-Wen's work revealed
	the need to treat FETCH_HEAD and MERGE_HEAD as "even more
	pecurilar than pseudorefs" that need different term (tentatively
	called "special refs") ... "

So since we are introducing this array in refs.c, which acts as a "refs
API" currently

	"A lot more reasonable thing to do may be to scan the
	$GIT_DIR for files whose name satisfy refs.c:is_pseudoref_syntax()
	and list them, instead of having a hardcoded list of these special
	refs.  In addition, when reftable and other backends that can
	natively store things outside refs/ hierarchy is in use, they ought
	to know what they have so enumerating these would not be an issue
	for them without having such a hardcoded table of names."

All that said, the above mentioned thread led to a series of patches for
a different purpose than this [1] (which are currently on their way to
"master" according to the latest "What's Cooking" email on Feb 2).  The
ones that have significance w.r.t. to THIS patch series though, are

	https://lore.kernel.org/git/20240129113527.607022-2-karthik.188@gmail.com/
	https://lore.kernel.org/git/20240129113527.607022-4-karthik.188@gmail.com/

(ignoring the reftable part).

I find these to make sense HERE because using the functions introduced
THERE are much more robust when dealing with pseudorefs and can be used
HERE.

I haven't given it much thought but I think we would still end up
writing "for_each_pseudoref()", although much differently from below
(and can't use "refs_for_each_all_refs()" directly) because of how we
call this function in PATCH 7/7 when actually doing the decoration - that
is the decoration for pseudorefs is different (?)

Another approach would be I think to refactor the whole of how
decorations with refs work and somehow use "refs_for_each_all_refs()"
with its callback handling how we decorate the various refs - I need to
dig deeper :) - since the end goal is to support showing all kinds of
refs when showing the log

	$ git log -1 --clear-decorations --oneline master
	2a540e432f (ORIG_HEAD, FETCH_HEAD, upstream/master, upstream/HEAD, master) The thirteenth batch

(with color enabled)

> +int refs_for_each_pseudoref(struct ref_store *refs,
> +			    each_ref_fn fn, void *cb_data)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(pseudorefs); i++) {
> +		struct object_id oid;
> +		int flag;
> +
> +		if (refs_resolve_ref_unsafe(refs, pseudorefs[i],
> +					    RESOLVE_REF_READING, &oid, &flag)) {
> +			int ret = fn(pseudorefs[i], &oid, flag, cb_data);
> +
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int for_each_pseudoref(each_ref_fn fn, void *cb_data)
> +{
> +	return refs_for_each_pseudoref(get_main_ref_store(the_repository),
> +				       fn, cb_data);
> +}
> +
>  struct ref_iterator *refs_ref_iterator_begin(
>  		struct ref_store *refs,
>  		const char *prefix,
> diff --git a/refs.h b/refs.h
> index 23211a5ea1..7b55cced31 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -320,6 +320,8 @@ typedef int each_repo_ref_fn(struct repository *r,
>   */
>  int refs_head_ref(struct ref_store *refs,
>  		  each_ref_fn fn, void *cb_data);
> +int refs_for_each_pseudoref(struct ref_store *refs,
> +			    each_ref_fn fn, void *cb_data);
>  int refs_for_each_ref(struct ref_store *refs,
>  		      each_ref_fn fn, void *cb_data);
>  int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
> @@ -334,6 +336,9 @@ int refs_for_each_remote_ref(struct ref_store *refs,
>  /* just iterates the head ref. */
>  int head_ref(each_ref_fn fn, void *cb_data);
>  
> +/* iterates pseudorefs. */
> +int for_each_pseudoref(each_ref_fn fn, void *cb_data);
> +
>  /* iterates all refs. */
>  int for_each_ref(each_ref_fn fn, void *cb_data);
>  
> -- 
> 2.42.GIT

So yeah, I just wanted to point out the above things as we would need to
refactor this commit and the commits following this - patches 6/7 and 7/7.

Thanks

[1]: https://lore.kernel.org/git/20240129113527.607022-1-karthik.188@gmail.com/
