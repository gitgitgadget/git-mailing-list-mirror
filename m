Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C1355033
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052440; cv=none; b=HbfP0iy110AqN4hXyflMjT7sUAjO6cY5Skb7H6n0LlvwfyQTV3HHDMrjNnL33g4JJap7PIlU8YFcwbK0yUHLIvGk/o3A9+xXVm3bwcns2tVv7ENPrRaedyINp6FzV1lFR5lXFkYcS1i84epRbseaJrROZhnMBGl0m7mUQCCGnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052440; c=relaxed/simple;
	bh=eZsGO0YRORtt+rNaF1/402zK4tUJfNObqbC0b6JLT/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFh3R8CLBtQAFDmn5GgaSNFK7PqcqsmWxpVnjwEezE5PD82LnnolSMn9JSuJkVil5QwtpAmzsYjxajW2OpqfQBNRJqK6U4rL10OZ/LsmmJnD+u8ITMSSeEeiMHHZzn4sWMT9tHdqQ1JQ78xn374QfPbn8Zraz/cNzl/cOxbhmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ko+w91mc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko+w91mc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471076f819bso44012075e9.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052437; x=1761657237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fmlNxDV/6irIIJGy2pg3ml1HedL7VQCK5uMv/J36YdU=;
        b=ko+w91mc0capXFR043RaL+p1QRZTZ6vCqU30/0EhCm3dMrp9LL5JonGA01w9rZtqUg
         CVhI6J30tStc65bVyFb8MjyKRBC3YvgTM3XYvRqJMn5lLCK/Rnsiw2QqMX5iWnfuAvOF
         U1nPDJjswl3gdnlX8/WVahxeZ0ISq1EJ2r9CGu1V74co4Ogt09tGxBWaC+iNwmffpZfD
         GJzo+Qp6czrmFTMK+kkHSdyCMQb35ydKj0/fKPbA9P3aF5c4rW764eCb8xQu19PEqjJu
         tXYdjzw+zZUV7xVg8tbcV9m7e2jumlxA0w6cz851uCdUyKCKlOiZCYgZy9PC2WVjQpwB
         kKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052437; x=1761657237;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmlNxDV/6irIIJGy2pg3ml1HedL7VQCK5uMv/J36YdU=;
        b=XlBUCY06RGrppl9fqToAZiEgF0gHl5D9WN/zAC8qYnhvYqxqRdxJgzdJwqpd1eJJrY
         uigzGkPSztd2+Qv+36fUAI3ShLVmpB+dTpE7m++dY8UmHQ5LwKV7uUXpOJdnjD84vQf4
         3VcYjwvpbF8IcN10EF6ijeZ2ANhbcBvoebvq0fh10c3zfNpOUvjfEaTlJSyInrJXfGmO
         pMLgl/+NC1PoV3775zCS5OT2NfvZzKoWiwQN+TNoZzJIh2FhPs5Uy+K0lAfxoZZ7acwr
         ZmgH9RizS1eFgPqn8h7W28F+iWmhMLq5IhUXsRK9qhpJPfw9GKlPwqagj7kbRmNnH5i8
         qqXA==
X-Forwarded-Encrypted: i=1; AJvYcCXo9dVmP2Kn6AyKcZw+MLipCRMIVjx06Aypz+amXpn6zbJtC+KdEMeVsLQuJ7IxPrhwxrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBDuJVliPW64OEOva9+ViSqdwe+Th6mf27IAp6z+4MtTR8uf6
	C247ccfePE+okMvSd8a8cmW2iA7TH5U/kXxU4u+qLkSTvlSxGByQUCxOYUu0P73GJxs=
X-Gm-Gg: ASbGncuZLN5Z4CMl7xVFnaq9qhq6HQbvP80bHXOLe9TOT1ZSMdVOY+m4CPkTG68pTDm
	Bu+WBOAeNUtc00XimeRmXQd2MNUIntXkfMYA/bw18fDlUaenLEnib2KtLO7ELvPVxWyQKvPutaT
	rLWEuBJSQOSnux3GDCO7QrsFlJNLF27IiIE7v64IHvzHeZGFG6nAP+LkZCI9ctr6Y3MsPwRNQ1q
	/VkPebC8yyk8TVjDyMUFzIRlW21yf3UxJfdvQuKj8f7S76n9aOduhb4Gto9gS++TJoUYKw+LvyX
	5/2G3O2nV+ShI+mjTSDpkfZJcHR6JWeGDG4CEyDuXywUXrGDFw9CDlqmxOWPmOzR3Mr1wrRCBN3
	muHXS/ln1ZjLMBGNgs0ieBx9uz70iw5FVauVwvQx95trO6TY0ZhTU2lzsrLTz1j0OENsnKl4B3g
	cx1ir1SnOqnqv4hW4j0fzdvHoZLHy0WX1wKD0sUE3mMa2tOOdkVwjWCMXXkr4+I3o=
X-Google-Smtp-Source: AGHT+IH9xCmgIWhl9vlXoq1uFEF0HI5X2XM+IkfWvUMQpPZBZNGVo2n1BqkfDclTpYrgiaCS0dvkFA==
X-Received: by 2002:a05:6000:2406:b0:427:9d7:870f with SMTP id ffacd0b85a97d-42709d78818mr10153255f8f.5.1761052436230;
        Tue, 21 Oct 2025 06:13:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0e9csm20510525f8f.5.2025.10.21.06.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:13:55 -0700 (PDT)
Message-ID: <786d6c19-0a13-4e55-8f4b-39b57dd6ea28@gmail.com>
Date: Tue, 21 Oct 2025 14:13:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/9] xdiff: make xrecord_t.ptr a uint8_t instead of char
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <7b9e8961d42e0f367ba0782e7d932607aa7e0b0a.1760563101.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <7b9e8961d42e0f367ba0782e7d932607aa7e0b0a.1760563101.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2025 22:18, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Rust uses u8 to refer to bytes in memory. Since xrecord_t.ptr is also
> referring to bytes in memory, rather than unicode code points, use
> uint8_t instead of char.

It C "char" never refers to a unicode code point so I don't follow the 
reasoning here. Isn't the reason you want to change from "char" to 
"uint8_t" to match rust? Given "char" and "uint8_t" are the same width 
why can't we use "char" in the C struct and "u8" in the rust struct as 
the two structs would still have the same layout?

I agree with Patrick's comments on this patch - it would be nice to know 
how you decided where to add casts. Given that rust is going to be 
optional for at least a year we should take care to leave the C code in 
good shape with a minimum number of casts.

Thanks

Phillip

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xdiffi.c    |  8 ++++----
>   xdiff/xemit.c     |  6 +++---
>   xdiff/xmerge.c    | 14 +++++++-------
>   xdiff/xpatience.c |  2 +-
>   xdiff/xprepare.c  |  8 ++++----
>   xdiff/xtypes.h    |  2 +-
>   xdiff/xutils.c    |  4 ++--
>   7 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 6f3998ee54..411a8aa69f 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -407,7 +407,7 @@ static int get_indent(xrecord_t *rec)
>   	int ret = 0;
>   
>   	for (i = 0; i < rec->size; i++) {
> -		char c = rec->ptr[i];
> +		uint8_t c = rec->ptr[i];
>   
>   		if (!XDL_ISSPACE(c))
>   			return ret;
> @@ -993,11 +993,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
>   
>   		rec = &xe->xdf1.recs[xch->i1];
>   		for (i = 0; i < xch->chg1 && ignore; i++)
> -			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
> +			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
>   
>   		rec = &xe->xdf2.recs[xch->i2];
>   		for (i = 0; i < xch->chg2 && ignore; i++)
> -			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
> +			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
>   
>   		xch->ignore = ignore;
>   	}
> @@ -1008,7 +1008,7 @@ static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
>   	size_t i;
>   
>   	for (i = 0; i < xpp->ignore_regex_nr; i++)
> -		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
> +		if (!regexec_buf(xpp->ignore_regex[i], (const char *)rec->ptr, rec->size, 1,
>   				 &regmatch, 0))
>   			return 1;
>   
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index b2f1f30cd3..ead930088a 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -27,7 +27,7 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
>   {
>   	xrecord_t *rec = &xdf->recs[ri];
>   
> -	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
> +	if (xdl_emit_diffrec((char const *)rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
>   		return -1;
>   
>   	return 0;
> @@ -113,8 +113,8 @@ static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
>   	xrecord_t *rec = &xdf->recs[ri];
>   
>   	if (!xecfg->find_func)
> -		return def_ff(rec->ptr, rec->size, buf, sz);
> -	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
> +		return def_ff((const char *)rec->ptr, rec->size, buf, sz);
> +	return xecfg->find_func((const char *)rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
>   }
>   
>   static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index fd600cbb5d..75cb3e76a2 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -101,8 +101,8 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
>   	xrecord_t *rec2 = xe2->xdf2.recs + i2;
>   
>   	for (i = 0; i < line_count; i++) {
> -		int result = xdl_recmatch(rec1[i].ptr, rec1[i].size,
> -			rec2[i].ptr, rec2[i].size, flags);
> +		int result = xdl_recmatch((const char *)rec1[i].ptr, rec1[i].size,
> +			(const char *)rec2[i].ptr, rec2[i].size, flags);
>   		if (!result)
>   			return -1;
>   	}
> @@ -324,8 +324,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
>   
>   static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
>   {
> -	return xdl_recmatch(rec1->ptr, rec1->size,
> -			    rec2->ptr, rec2->size, flags);
> +	return xdl_recmatch((const char *)rec1->ptr, rec1->size,
> +			    (const char *)rec2->ptr, rec2->size, flags);
>   }
>   
>   /*
> @@ -382,10 +382,10 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>   		 * we have a very simple mmfile structure.
>   		 */
>   		t1.ptr = (char *)xe1->xdf2.recs[m->i1].ptr;
> -		t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
> +		t1.size = (char *)xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
>   			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1].size - t1.ptr;
>   		t2.ptr = (char *)xe2->xdf2.recs[m->i2].ptr;
> -		t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1].ptr
> +		t2.size = (char *)xe2->xdf2.recs[m->i2 + m->chg2 - 1].ptr
>   			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1].size - t2.ptr;
>   		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
>   			return -1;
> @@ -440,7 +440,7 @@ static int line_contains_alnum(const char *ptr, long size)
>   static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
>   {
>   	for (; chg; chg--, i++)
> -		if (line_contains_alnum(xe->xdf2.recs[i].ptr,
> +		if (line_contains_alnum((const char *)xe->xdf2.recs[i].ptr,
>   				xe->xdf2.recs[i].size))
>   			return 1;
>   	return 0;
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index 669b653580..bb61354f22 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -121,7 +121,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>   		return;
>   	map->entries[index].line1 = line;
>   	map->entries[index].hash = record->ha;
> -	map->entries[index].anchor = is_anchor(xpp, map->env->xdf1.recs[line - 1].ptr);
> +	map->entries[index].anchor = is_anchor(xpp, (const char *)map->env->xdf1.recs[line - 1].ptr);
>   	if (!map->first)
>   		map->first = map->entries + index;
>   	if (map->last) {
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 192334f1b7..4cb18b2b88 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -99,8 +99,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
>   	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
>   	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
>   		if (rcrec->rec.ha == rec->ha &&
> -				xdl_recmatch(rcrec->rec.ptr, rcrec->rec.size,
> -					rec->ptr, rec->size, cf->flags))
> +				xdl_recmatch((const char *)rcrec->rec.ptr, rcrec->rec.size,
> +					(const char *)rec->ptr, rec->size, cf->flags))
>   			break;
>   
>   	if (!rcrec) {
> @@ -156,8 +156,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
>   				goto abort;
>   			crec = &xdf->recs[xdf->nrec++];
> -			crec->ptr = prev;
> -			crec->size = (long) (cur - prev);
> +			crec->ptr = (uint8_t const *)prev;
> +			crec->size =(long) ( cur - prev);
>   			crec->ha = hav;
>   			if (xdl_classify_record(pass, cf, crec) < 0)
>   				goto abort;
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index 3514bb1684..57983627f5 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -39,7 +39,7 @@ typedef struct s_chastore {
>   } chastore_t;
>   
>   typedef struct s_xrecord {
> -	char const *ptr;
> +	uint8_t const *ptr;
>   	long size;
>   	unsigned long ha;
>   } xrecord_t;
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 447e66c719..7be063bfb6 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -465,10 +465,10 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
>   	xdfenv_t env;
>   
>   	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1].ptr;
> -	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2].ptr +
> +	subfile1.size = (char *)diff_env->xdf1.recs[line1 + count1 - 2].ptr +
>   		diff_env->xdf1.recs[line1 + count1 - 2].size - subfile1.ptr;
>   	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1].ptr;
> -	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2].ptr +
> +	subfile2.size = (char *)diff_env->xdf2.recs[line2 + count2 - 2].ptr +
>   		diff_env->xdf2.recs[line2 + count2 - 2].size - subfile2.ptr;
>   	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
>   		return -1;

