Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7E267B6A
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875658; cv=none; b=GDIqFV9G/eaF3Cfd3pVMgnuv7G/w1+4h3CvIbxcVEgbGhTg46OkGVwftwpGjdjMni0C44Fj36VdKV63iGk5MpXcOZLlcl2FMRKm2cedOZsL2eXE/gXW/ea7U3EJrl5Efa3QjOqH0Qx6TkRFK/6qoajd4t7TtSgjk9FQVBHc93ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875658; c=relaxed/simple;
	bh=hrthF6qkzidnPtnRBAHOUtGr9age573ggLOX3SkbzwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S9OKHaf0vuA9OIzEyYTrIr5JCfdZKjFWorD7aj7hRJlIEBKBlgO0CYVd2+MNJRqdJzRKOe0fNYAL4S4N36gypdSfdAFDPc7D8QNGs+KK1hLJ6u1numXDycunIritnbzW0CS2bFy+tDiZP9btB//CihgcJd5SPlWFNOlQDShukUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY/Fy3Qe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY/Fy3Qe"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22438c356c8so19361545ad.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741875656; x=1742480456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htTwBfJfUiJood/0HqL7LWCi/EU0EAAwXXITFfWHzDg=;
        b=kY/Fy3QeNMLzVHiIBCEJ/FbMW5ENHup3KO/CEHujDqga/5VMdZPF1FgFnlwpNIdSnN
         TKFItUPyfDyJNupOlygR+dVEPj/2TL3YiVZ6FHRA2ANBZYUbwk64JsckBX/vc1tgejRB
         5kpx3wIqvAiP121mpynNhHjzIpvz4jLC8pCHQ5+bnhxMk1rnkHJVm87nAhvdMPvdpegA
         Jnj8GfIiThQpHJ7gRtmnak/miVoLpfAWw6vg+pMTBX844xuFsK1zKa8boqb7c7gV3dLy
         9tzwmSXL+bMO74v8fJ16PT2Aim5P3d1i3X4IyOCtd20GEEi0F7jz0AbX3la1CDDkST2w
         Aa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741875656; x=1742480456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htTwBfJfUiJood/0HqL7LWCi/EU0EAAwXXITFfWHzDg=;
        b=VXNYBmaLn3B1wMvJlLPfijy3F/Ztk2XCf5esszo0EMWdN4XUhbS/FeylH4GzJVLTWr
         O2o77CTcEpvF7BLFnTbkj65ilL56u1FexH/3P9YAmi0h8Jzzm/y1N6YpfB96mfhSLlLy
         HhlcVKEau7zpEP0LhvGkZlZMLH0IygYG1h8mosUFWxMz00MIAbPZQLCvqCaqTWU/t+j+
         Lzj5MU5iw3/3hsVZruh73BKgAkgS3GH8mvSJVt1fhF3/l+fXMestWS7E8rPyvs+/H06f
         fXwJfwSiAMURCjxiZmJ75au01+iugXU86tMMdtVSQkQ5DGl9He5hqOXSYMd7YgwWGWIi
         Zmuw==
X-Forwarded-Encrypted: i=1; AJvYcCVMzJuXL2N5mnUizmgLUA+LFjPpzmcDlydwNWLkP1Ys7ziZjUcqSUphMKDe5pnJRQtOcy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6Sxe8tU9ccvFAMKjQfuvpccDiHQNmvUV6OlMBPxUTw89KCP5
	5A8A7tySITaphdMwJt+aqHcYS9WAWEvUmkoJm1vAMXsOhLDc7dR6
X-Gm-Gg: ASbGncvHS+CwdIabsdJjbLmeoSVDpGfoM0zLYZ0CphvgJvC6OvH4g/ZwvYlaqM9YC4B
	JgFD9UIHocjBk8bnrUSIEaBaT3PORcIiLTTx1Ce8zGL8UJyvdkDSED6JskHQYpWNknlk+D92D4J
	FKa05UtE+IrElRRhUjFvVNDkHaG7sVY2vh7ZcQ5AxLrHuRQPmLuvV050psJmamZgjfe8UXGBRqF
	Gqz/1mB0M4JnN0yEFnlfmBC3NBNw/Ciy7gqqSIbESDjMtyaJkqz1/PUmVk5lnRy4qwHAbavQ9dt
	TlMGmTZV0FQAcJAuVsnuhNavMfSQle5QPoTCmd/dCEnECkcf5pILwT8xfg==
X-Google-Smtp-Source: AGHT+IGPNOnto2Fth1i8fS7Z/xAYr83vYgD27Y8UXcZuVVvo5oeGj2F/blIzlHyKxE5Ct/DM5/A6kQ==
X-Received: by 2002:a17:902:d488:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-2242887eb5cmr399101585ad.5.1741875655617;
        Thu, 13 Mar 2025 07:20:55 -0700 (PDT)
Received: from [192.168.1.6] ([182.48.215.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe4f2sm13577115ad.181.2025.03.13.07.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 07:20:55 -0700 (PDT)
Message-ID: <0946673c-72ce-4848-b7f6-edd7a1cc7ff4@gmail.com>
Date: Thu, 13 Mar 2025 19:50:52 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] pathspec: fix sign comparison warnings
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
 <CAOLa=ZRNJD7NqceGQ4B8ox+50m2q1nU1t29x7O0roc=-_4ww0w@mail.gmail.com>
Content-Language: en-US
From: Arnav Bhate <bhatearnav@gmail.com>
In-Reply-To: <CAOLa=ZRNJD7NqceGQ4B8ox+50m2q1nU1t29x7O0roc=-_4ww0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Karthik Nayak <karthik.188@gmail.com> writes:
> Arnav Bhate <bhatearnav@gmail.com> writes:
> 
>> There are multiple places, especially in loops, where a signed and an
>> unsigned data type are compared. Git uses a mix of signed and unsigned
>> types to store lengths of arrays. This sometimes leads to using a signed
>> index for an array whose length is stored in an unsigned variable or
>> vice versa.
>>
>> Replace signed data types with unsigned data types and vice versa
>> wherever necessary. In some cases, introduce a new variable, where both
>> signed and unsigned data types have been used to store lengths of arrays
>> in the same function, where previously only one variable was used to
>> iterate over both types. In cases where this is not possible, add
>> appropriate cast. Remove #define DISABLE_SIGN_COMPARE_WARNINGS.
>>
>> Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
>> ---
>>  pathspec.c | 26 +++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/pathspec.c b/pathspec.c
>> index 89663645e1..fd7dfdfd84 100644
>> --- a/pathspec.c
>> +++ b/pathspec.c
>> @@ -1,5 +1,4 @@
>>  #define USE_THE_REPOSITORY_VARIABLE
>> -#define DISABLE_SIGN_COMPARE_WARNINGS
>>
>>  #include "git-compat-util.h"
>>  #include "abspath.h"
>> @@ -36,6 +35,7 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>>  					enum ps_skip_worktree_action sw_action)
>>  {
>>  	int num_unmatched = 0, i;
>> +	unsigned int j;
>>
>>  	/*
>>  	 * Since we are walking the index as if we were walking the directory,
>> @@ -48,8 +48,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>>  			num_unmatched++;
>>  	if (!num_unmatched)
>>  		return;
>> -	for (i = 0; i < istate->cache_nr; i++) {
>> -		const struct cache_entry *ce = istate->cache[i];
>> +	for (j = 0; j < istate->cache_nr; j++) {
>> +		const struct cache_entry *ce = istate->cache[j];
>>  		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
>>  		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
>>  			continue;
> 
> While this is correct, now we have 'i' & 'j' as iteration variables,
> generally this is used in O(n^2) loops to define the outer and inner
> loops. Here, however, we use it to simply define two different types. I
> find this deviation from convention a little confusing.
> 
> Perhaps, we could simply utilize the option of intializing loop
> variables in the loop itself?
> 
>   diff --git a/pathspec.c b/pathspec.c
>   index 89663645e1..ff8854afb8 100644
>   --- a/pathspec.c
>   +++ b/pathspec.c
>   @@ -35,7 +35,7 @@ void add_pathspec_matches_against_index(const
> struct pathspec *pathspec,
>    					char *seen,
>    					enum ps_skip_worktree_action sw_action)
>    {
>   -	int num_unmatched = 0, i;
>   +	int num_unmatched = 0;
> 
>    	/*
>    	 * Since we are walking the index as if we were walking the directory,
>   @@ -43,12 +43,12 @@ void add_pathspec_matches_against_index(const
> struct pathspec *pathspec,
>    	 * mistakenly think that the user gave a pathspec that did not match
>    	 * anything.
>    	 */
>   -	for (i = 0; i < pathspec->nr; i++)
>   +	for (int i = 0; i < pathspec->nr; i++)
>    		if (!seen[i])
>    			num_unmatched++;
>    	if (!num_unmatched)
>    		return;
>   -	for (i = 0; i < istate->cache_nr; i++) {
>   +	for (unsigned int i = 0; i < istate->cache_nr; i++) {
>    		const struct cache_entry *ce = istate->cache[i];
>    		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
>    		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
> 
> This would read much cleaner and also avoid two different loop
> variables. WDYT?

We could certainly do that. My impression was that the convention was
not to do so.

> Also a bigger question is, shouldn't the type of `pathspec.nr` and
> 'istate.cache_nr' be the actual change required? Shouldn't they be set
> to 'size_t'?

I tried that first and found that it required making a large number of
changes spread over many files. As noted in my commit message, both
signed and unsigned types are used at different places for this
purpose.

>> @@ -78,7 +78,7 @@ char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
>>  {
>>  	struct index_state *istate = the_repository->index;
>>  	char *seen = xcalloc(pathspec->nr, 1);
>> -	int i;
>> +	unsigned int i;
>>
> 
> Nit: We could also drop this and move the initialization to the line
> below.
> 
>>  	for (i = 0; i < istate->cache_nr; i++) {
>>  		struct cache_entry *ce = istate->cache[i];
>> @@ -130,7 +130,7 @@ static void prefix_magic(struct strbuf *sb, int prefixlen,
>>  	if (element[1] != '(') {
>>  		/* Process an element in shorthand form (e.g. ":!/<match>") */
>>  		strbuf_addstr(sb, ":(");
>> -		for (int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
>> +		for (unsigned int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
>>  			if ((magic & pathspec_magic[i].bit) &&
>>  			    pathspec_magic[i].mnemonic) {
>>  				if (sb->buf[sb->len - 1] != '(')
> 
> Shouldn't we use 'size_t' for this, since we're iterating over the
> elements of an array?

We can use size_t there.

> 
>> @@ -341,7 +341,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
>>
>>  	for (pos = elem + 2; *pos && *pos != ')'; pos = nextat) {
>>  		size_t len = strcspn_escaped(pos, ",)");
>> -		int i;
>> +		unsigned int i;
>>
> 
> This too should be 'size_t'.
> 
>>  		if (pos[len] == ',')
>>  			nextat = pos + len + 1; /* handle ',' */
>> @@ -354,7 +354,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
>>  		if (starts_with(pos, "prefix:")) {
>>  			char *endptr;
>>  			*prefix_len = strtol(pos + 7, &endptr, 10);
>> -			if (endptr - pos != len)
>> +			if ((size_t)(endptr - pos) != len)
>>  				die(_("invalid parameter for pathspec magic 'prefix'"));
>>  			continue;
>>  		}
> 
> This makes sense. But is it guaranteed that `endptr - pos` is greater
> than 0?

endptr - pos will be greater than or equal to zero, as endptr is set by
strtol

>> @@ -400,7 +400,7 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
>>
>>  	for (pos = elem + 1; *pos && *pos != ':'; pos++) {
>>  		char ch = *pos;
>> -		int i;
>> +		unsigned int i;
>>
> 
> This too, should be 'size_t'
> 
>>  		/* Special case alias for '!' */
>>  		if (ch == '^') {
>> @@ -564,7 +564,7 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
>>
>>  void pathspec_magic_names(unsigned magic, struct strbuf *out)
>>  {
>> -	int i;
>> +	unsigned int i;
> 
> This can be inlined and made 'size_t'.
> 
>>  	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
>>  		const struct pathspec_magic *m = pathspec_magic + i;
>>  		if (!(magic & m->bit))
>> @@ -803,8 +803,8 @@ int match_pathspec_attrs(struct index_state *istate,
>>  int pathspec_needs_expanded_index(struct index_state *istate,
>>  				  const struct pathspec *pathspec)
>>  {
>> -	unsigned int i, pos;
>> -	int res = 0;
>> +	unsigned int pos;
>> +	int i, res = 0;
>>  	char *skip_worktree_seen = NULL;
>>
> 
> This can be inlined, but this change is done to match 'pathspec.nr''s
> type. This goes to my earlier question, I would say we first need to
> modify 'pathspec.nr' itself to be 'size_t'.
> 
>>  	/*
>> @@ -845,7 +845,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
>>  			 * - not-in-cone/bar*: may need expanded index
>>  			 * - **.c: may need expanded index
>>  			 */
>> -			if (strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len &&
>> +			if (strspn(item.original + item.nowildcard_len, "*") == (unsigned int)(item.len - item.nowildcard_len) &&
>>  			    path_in_cone_mode_sparse_checkout(item.original, istate))
>>  				continue;
>>
> 
> Similar here, I see the types of 'item.len' and 'item.nowwildcard_len'
> are 'int'. Do they need to be 'size_t'?

Same as above, will require a large number of changes.
 
>> @@ -860,7 +860,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
>>  				 * directory name and the sparse directory is the first
>>  				 * component of the pathspec, need to expand the index.
>>  				 */
>> -				if (item.nowildcard_len > ce_namelen(ce) &&
>> +				if ((unsigned int)item.nowildcard_len > ce_namelen(ce) &&
>>  				    !strncmp(item.original, ce->name, ce_namelen(ce))) {
>>  					res = 1;
>>  					break;
>> --
>> 2.48.1
> 
> Same question as above!

-- 
Regards,
Arnav Bhate
(He/Him)

