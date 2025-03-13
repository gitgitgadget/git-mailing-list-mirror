Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF941267B6F
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877087; cv=none; b=gz/mqWrsKcejr5gw1HQNvojXDTa9khJzzveXMkEjsEkpRSPhcH3qX1w7HmN7DcMAmeAUNkxhtHrM6TVUc15PcvwCXeWwkXG/zjXMPFacq8RqVtf8/UAEGOUMqnOe5NGRPYNxJlERh3krmnpGjhrGHpGez2RywWC61H7OzdxZHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877087; c=relaxed/simple;
	bh=0LWoNskVEKIwrxRo9MLaTPJosvsMNhyeXB9CyF2Az6o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=oNGIDJTfhwmpsuJFcCR4RL7uiwqCwiINm72VvnrJeWZssTz5h791FjIORVhTX1W+Wtd7wV+5hdN6bWMDY+bLBiBeI8X63nf2Rn4sXTo6SzVdpPsz9rDUwGauLYtF45EDO2oGTx0zaaONUqiuwRVrs6NY2XZaqZ3fP3keEj2BeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpjXdvzm; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpjXdvzm"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d2fba8647so904368241.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741877085; x=1742481885; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QejObjL7fqWklqG0f9R1tjTMpkpOnwfFpetDXNhUqVg=;
        b=JpjXdvzmb7Z2ZUQodX7xD7WGvRhBdVgvrsBEf9PiVotOsGUGXY5XW44d4Tg331IKqF
         /LMCWg/1FEjtCMgfMGT2UzGe+O8PL8bUSLKTN1mYQjkKCNVAh532wHf0V9x8RNZnjHAw
         BOxwGX/meicbed1VfURL9qgLvc/QPw4x8T+USnaPCtUK+2dGMZY6DJ3mBbTrf6ruIuTK
         1jekHsDYCiIOuc7+EUDjp4c/cX9gWPeywuGcgwnGlqIhL8avz3r9VC/AtSGq2lH+ZAvx
         ULcwXLi6CD8OhTgrych7rBV+633iHBSeAyFiMgEFo+rKq1YGFhJmZ1/W1j76jF6zRlxz
         xlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741877085; x=1742481885;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QejObjL7fqWklqG0f9R1tjTMpkpOnwfFpetDXNhUqVg=;
        b=EhA7lk4jRlb4Q+cg730FFuBz6KGgLeS5Iqa2YZjIhAWA13R/61wePvnLtPGRgkHbze
         18vBbQVYE0qZpTzIHqqHPqY9NBAy4Yo5l3P2ep4nwyXEsXkVmVWDPXTh7duvrNgNr07x
         ieBpmnpSlkbD7NiGxkpHdnvSYaY5xTAwj+BwFbLlXUpmYWVBRVY0rnbwS253HMaKQWVL
         G7VV/Ux6w7I16BGC49tRXahEsmhDAjFsPOw/7S5ENEFZWJVwIhcTCm7FUEzc2P0mWbzZ
         YiweqO98eAAWmFDP5wU9FxZvP1F/kJjFJW2Omq0gG1frvedrF6Epaw9z3kfz5qkNic2a
         XvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZNLFcmschzHnu+nfz77tR1wtZ3OpQrZ3X55LQIRIuAZLKqrrklAn5QljNewHkqkal68k=@vger.kernel.org
X-Gm-Message-State: AOJu0YygA3SLaRsuKLYm7RI6bJVSLI+N5AboF9tjLrscyfLbY3w/o6/f
	NPM9hONz01IuPEwo3NrLl3EMAIQLD2DmmPCdJKpx5klbQmPwrKPWrfYg7uTl7dSHZ2O9GiPyvfY
	BCvSEmwWy1GCNg2e2FFvO/swwaJE=
X-Gm-Gg: ASbGncvlAVeYXa+IZzYsTfUUlfzUWPNDiGvJgGtD+LuqGWl+FCvXvYu0VTZTwvZ+vZ4
	eZmHl1siTdtB4en/04W/XThncdKuJ14GRlqFetAF55kRrOlI3SgbIW7/UMfwcGXkoWI0RcasNTM
	RrhvijbrEV4CMvw09qDjO8GH51h4A=
X-Google-Smtp-Source: AGHT+IEXXxIVvPvosCLNsQ01v7u1pQywgDdfOn3l0uaJDB5P80tUi2mfPh0E2ovoB2DG53Od52m09PD7WhBdBLDGvA4=
X-Received: by 2002:a05:6122:4d15:b0:523:e2bd:b937 with SMTP id
 71dfb90a1353d-524197efd20mr12807928e0c.3.1741877084636; Thu, 13 Mar 2025
 07:44:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Mar 2025 10:44:43 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <0946673c-72ce-4848-b7f6-edd7a1cc7ff4@gmail.com>
References: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
 <CAOLa=ZRNJD7NqceGQ4B8ox+50m2q1nU1t29x7O0roc=-_4ww0w@mail.gmail.com> <0946673c-72ce-4848-b7f6-edd7a1cc7ff4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2025 10:44:43 -0400
X-Gm-Features: AQ5f1JrZ9F16HEjKbmqd36GaD7_oWK8erNvRpYLVVzjpYK9CUifnTEzKoPUFapA
Message-ID: <CAOLa=ZTRA_7UpUamtc2NeJH75uEw16z73qWFqY8veV=mToeUhg@mail.gmail.com>
Subject: Re: [GSoC PATCH] pathspec: fix sign comparison warnings
To: Arnav Bhate <bhatearnav@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dfab8306303a5c18"

--000000000000dfab8306303a5c18
Content-Type: text/plain; charset="UTF-8"

Arnav Bhate <bhatearnav@gmail.com> writes:

[snip]

>> While this is correct, now we have 'i' & 'j' as iteration variables,
>> generally this is used in O(n^2) loops to define the outer and inner
>> loops. Here, however, we use it to simply define two different types. I
>> find this deviation from convention a little confusing.
>>
>> Perhaps, we could simply utilize the option of intializing loop
>> variables in the loop itself?
>>
>>   diff --git a/pathspec.c b/pathspec.c
>>   index 89663645e1..ff8854afb8 100644
>>   --- a/pathspec.c
>>   +++ b/pathspec.c
>>   @@ -35,7 +35,7 @@ void add_pathspec_matches_against_index(const
>> struct pathspec *pathspec,
>>    					char *seen,
>>    					enum ps_skip_worktree_action sw_action)
>>    {
>>   -	int num_unmatched = 0, i;
>>   +	int num_unmatched = 0;
>>
>>    	/*
>>    	 * Since we are walking the index as if we were walking the directory,
>>   @@ -43,12 +43,12 @@ void add_pathspec_matches_against_index(const
>> struct pathspec *pathspec,
>>    	 * mistakenly think that the user gave a pathspec that did not match
>>    	 * anything.
>>    	 */
>>   -	for (i = 0; i < pathspec->nr; i++)
>>   +	for (int i = 0; i < pathspec->nr; i++)
>>    		if (!seen[i])
>>    			num_unmatched++;
>>    	if (!num_unmatched)
>>    		return;
>>   -	for (i = 0; i < istate->cache_nr; i++) {
>>   +	for (unsigned int i = 0; i < istate->cache_nr; i++) {
>>    		const struct cache_entry *ce = istate->cache[i];
>>    		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
>>    		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
>>
>> This would read much cleaner and also avoid two different loop
>> variables. WDYT?
>
> We could certainly do that. My impression was that the convention was
> not to do so.
>

This is specifically mentioned in 'Documentation/CodingGuidelines':

  since late 2021 with 44ba10d6, we have had variables declared in the
  for loop "for (int i = 0; i < 10; i++)".

So actually, the convention is to do so.

>> Also a bigger question is, shouldn't the type of `pathspec.nr` and
>> 'istate.cache_nr' be the actual change required? Shouldn't they be set
>> to 'size_t'?
>
> I tried that first and found that it required making a large number of
> changes spread over many files. As noted in my commit message, both
> signed and unsigned types are used at different places for this
> purpose.
>

I can see that, but that is the correct change, no? either ways, it
should be called out in the commit message why that was not the approach
taken.

My personal take is that this fix is more of a bandaid, it would be
better to fix the issue at source. Adding these smaller local fixes is
going in the wrong direction, because we're increasing touchpoints which
have to be changed when the actual fix is made.

>>> @@ -78,7 +78,7 @@ char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
>>>  {
>>>  	struct index_state *istate = the_repository->index;
>>>  	char *seen = xcalloc(pathspec->nr, 1);
>>> -	int i;
>>> +	unsigned int i;
>>>
>>
>> Nit: We could also drop this and move the initialization to the line
>> below.
>>
>>>  	for (i = 0; i < istate->cache_nr; i++) {
>>>  		struct cache_entry *ce = istate->cache[i];
>>> @@ -130,7 +130,7 @@ static void prefix_magic(struct strbuf *sb, int prefixlen,
>>>  	if (element[1] != '(') {
>>>  		/* Process an element in shorthand form (e.g. ":!/<match>") */
>>>  		strbuf_addstr(sb, ":(");
>>> -		for (int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
>>> +		for (unsigned int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
>>>  			if ((magic & pathspec_magic[i].bit) &&
>>>  			    pathspec_magic[i].mnemonic) {
>>>  				if (sb->buf[sb->len - 1] != '(')
>>
>> Shouldn't we use 'size_t' for this, since we're iterating over the
>> elements of an array?
>
> We can use size_t there.
>
>>
>>> @@ -341,7 +341,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
>>>
>>>  	for (pos = elem + 2; *pos && *pos != ')'; pos = nextat) {
>>>  		size_t len = strcspn_escaped(pos, ",)");
>>> -		int i;
>>> +		unsigned int i;
>>>
>>
>> This too should be 'size_t'.
>>
>>>  		if (pos[len] == ',')
>>>  			nextat = pos + len + 1; /* handle ',' */
>>> @@ -354,7 +354,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
>>>  		if (starts_with(pos, "prefix:")) {
>>>  			char *endptr;
>>>  			*prefix_len = strtol(pos + 7, &endptr, 10);
>>> -			if (endptr - pos != len)
>>> +			if ((size_t)(endptr - pos) != len)
>>>  				die(_("invalid parameter for pathspec magic 'prefix'"));
>>>  			continue;
>>>  		}
>>
>> This makes sense. But is it guaranteed that `endptr - pos` is greater
>> than 0?
>
> endptr - pos will be greater than or equal to zero, as endptr is set by
> strtol
>
>>> @@ -400,7 +400,7 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
>>>
>>>  	for (pos = elem + 1; *pos && *pos != ':'; pos++) {
>>>  		char ch = *pos;
>>> -		int i;
>>> +		unsigned int i;
>>>
>>
>> This too, should be 'size_t'
>>
>>>  		/* Special case alias for '!' */
>>>  		if (ch == '^') {
>>> @@ -564,7 +564,7 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
>>>
>>>  void pathspec_magic_names(unsigned magic, struct strbuf *out)
>>>  {
>>> -	int i;
>>> +	unsigned int i;
>>
>> This can be inlined and made 'size_t'.
>>
>>>  	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
>>>  		const struct pathspec_magic *m = pathspec_magic + i;
>>>  		if (!(magic & m->bit))
>>> @@ -803,8 +803,8 @@ int match_pathspec_attrs(struct index_state *istate,
>>>  int pathspec_needs_expanded_index(struct index_state *istate,
>>>  				  const struct pathspec *pathspec)
>>>  {
>>> -	unsigned int i, pos;
>>> -	int res = 0;
>>> +	unsigned int pos;
>>> +	int i, res = 0;
>>>  	char *skip_worktree_seen = NULL;
>>>
>>
>> This can be inlined, but this change is done to match 'pathspec.nr''s
>> type. This goes to my earlier question, I would say we first need to
>> modify 'pathspec.nr' itself to be 'size_t'.
>>
>>>  	/*
>>> @@ -845,7 +845,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
>>>  			 * - not-in-cone/bar*: may need expanded index
>>>  			 * - **.c: may need expanded index
>>>  			 */
>>> -			if (strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len &&
>>> +			if (strspn(item.original + item.nowildcard_len, "*") == (unsigned int)(item.len - item.nowildcard_len) &&
>>>  			    path_in_cone_mode_sparse_checkout(item.original, istate))
>>>  				continue;
>>>
>>
>> Similar here, I see the types of 'item.len' and 'item.nowwildcard_len'
>> are 'int'. Do they need to be 'size_t'?
>
> Same as above, will require a large number of changes.
>

Continuing from top, I would say that the goal is not to simply remove
all 'DISABLE_SIGN_COMPARE_WARNINGS' definitions in the easiest way
possible. Specially when we end up adding more things to be fixed
eventually.

I would say perhaps picking one of these structs and fixing their types
might be more suited. Let's see what others have to say here!

--000000000000dfab8306303a5c18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ae4548045cd1a11f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mUzcxa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWVuQy8wVzc5Z3c4Q1BORHNkQ0NUSWsrY1RiWjg0MAp4VGs5QUhwUW1l
NXJqeGd2dHN2SCs1VlNFN05TQzN2STZZbXdoK28rWEZabFRYdTdqUHRMTGt2clJ5VUs1b0kyCnV0
SUc1NXVRQ3dmQ3c3VDVzLzJrK2owNGQ5U2R2TE1qWlpNUWRzSW45Znd1anVKOEtXeUY2Zk5FYWlF
eUtuNjcKOXFLR21xbGR0dHBscElPbmQ4TS9yd1hKaGllanQydmpwVkIxN3U1c1lFZGdwYWQyUGdC
dlZvNXdMVU04dWtxMQpHOVNadmowUXAzMzNFbHQrQWhRV0hBb2svSlVyeUxDbzNqZHRXNnUxOTFD
V1hZQXpkR0hRK0wzcG00eEVES2V2CldQNERQamdyb2pRazV1eGVsMHNYaG43SkVHdzdQNFliVkN1
YmpaSkFDRXBER2txQVJWTHhnc0xCczJROXZOOHoKdStrSDFrVXRnWkpxVW9QbVUzWmQwYnVWN2oy
OWVSZ3RmSFNZZzZndXlSWHh3aC9SYjlTN1RmSXl2OUx3SUNxbApkSEVNa0tSZUpPZzhPYndtUG53
bkhUTVg2UlYzVGhCSFBNQWg0TDZKMldQR1hDYjhBSlhkUVhzVi9TRFA0RWRPCkxRMTVOVG5YOWR4
eThhb05HSHZvVHc2bDJ1WFQ2ZmNVeitPcXlkRT0KPWw0MVcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dfab8306303a5c18--
