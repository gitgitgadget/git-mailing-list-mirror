Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983042AA6
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877163; cv=none; b=YeEiXB1D4ScLa6skY+7x87kRla5lTrp/3oNaXuKoXoCPOYjLRZPAlklnqkJFjDB7volppPbKWsT5yMCwkWiQ5Y2P6dTwq+Xf2Dgt8vaRsxuYgxdPRfjpQs6xZ1iugwQge48HWybHqOyy/z2+uLRggQcjU4OJu+X7PU+NXpe9AG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877163; c=relaxed/simple;
	bh=qfEFoIms95dETsa582BfQRdddQfX2d3vmxITfokrSoI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVp+Bu4evmF9R8RURA5zT+RKUjvKngDZ3e4bVNBUORpLZTT4Kqm87qHR8ECCN6G1lTDVoqzjXWXAPdrrLNF7cac05LJJcUeV2z4MTw4ohZi/M7jn14L/yKpZ2Ydxzj6mJOzrbv5YR8jPTcWkZRnImr9E6zgRV2IzccV4XHHMNFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKYoXg1I; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKYoXg1I"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd1962a75bso8557316d6.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741877160; x=1742481960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U7RDq7m6FhdPf5NbZMEP5YCKFCU+DmVzw+RgDTjKJ+k=;
        b=UKYoXg1IKJXSVQxoNNH8vPhHCtjdrbhUg+yGAWOFL0xB3z1sBJXhRsMOovWw6SZFUr
         pS8ADFMRUIyzCejzjPOVHje7N8TTBUBKQ6pTPh4MnRat1G+ZIQXsVKLqHg7uUCxtO1ZO
         wV+0eKCMyqVtf05szCH/UjdHn83qGceXMe+waRmqMhEnRba3Kt+ZxlAKqv9dXtzrxhfC
         +LjSPRl+dQ86fzGPDQu2xPuxhlPk6FPMHz/SGZ74ljii2LxkvIW2FEy6EJgy3jqbccwg
         xBPTNXyyg+6DzgnfiAmGSPIwM4ZaIpP3NBFob06YkS6xmfle3xqzZX2gFTHs1UerzpqQ
         hzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741877160; x=1742481960;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7RDq7m6FhdPf5NbZMEP5YCKFCU+DmVzw+RgDTjKJ+k=;
        b=tGUn8LM3h6lQaNQPMAYkD3GTm/fv8n8h7W5LbLlCazMmTlj0sGiE5iBoLdIkU2e87f
         innua+5g0IO6vYWpaGW9pK0/3mNSG/vAinUn7ILhnqnVSyz6PYH9K5NrAyHLLZ4hRipS
         WDLfmnp19mv6i+qoNsHnz3WrBnJ09/2nEz3ygyWV6tDynHXi8ZmFs0fTJKZLbwz0OH6e
         rq/fkK2g9liPc7D1PaoaQ65MqEkSfM7NrjpeeOOPU6poAO3pBCja3YWvn0G6yC6r54zc
         L7KC8VLlMByHFJUAMxoPdBh2MJlN+6FnfewHEgFsnPM+RgZvvqLfLYwcoImak+TP0UMB
         AwzQ==
X-Gm-Message-State: AOJu0YyBWKBn40sGmTS4VgP5xXxJlT90lQzckMaOwtER+eQNZyEDlGT2
	GkyndV7FD5IyQuktFNZ8gJg/MfZKlO3N1jnXlLIoE4c1l/cdRnedkKNl5SLbvBbXo3UM8E7rF99
	56GQiZEiSfBieqbsFzRPnah/Gk74=
X-Gm-Gg: ASbGncu+Qz0L+q3ZE2z2ryFyTxvXKzga06jrRTNVlMa8U0CsnkdY9OB7E8qDbiDGZXz
	+if28xATxbuEJ/04PCpQnUQmlpA1pAtj50UvRgNGS91IrpgSChWiGUYrFuKIOm/DoVAmZ4TzA3i
	x79UHIc76nTUHRvmLA/LSkrhEgk/I=
X-Google-Smtp-Source: AGHT+IFlQOjDovxQrAEn0iiKvZxHw9/9dPVGClpS6kQTw+x7BQIHkiT/zTp8ES8x/g5ioPd1T+MjSNIWkfDq6iuBhqk=
X-Received: by 2002:a05:6214:c6c:b0:6e8:f2bf:7262 with SMTP id
 6a1803df08f44-6e900681d23mr305588086d6.41.1741877159679; Thu, 13 Mar 2025
 07:45:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Mar 2025 09:45:58 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <69d10d0a-35ac-4543-a699-b3237ae4ccfd@gmail.com>
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
 <xmqqy0x9s8mg.fsf@gitster.g> <CAOLa=ZTia95Lib6bkz_nWi2BYEteAaOxsrrX9DqLTEz1t02ggA@mail.gmail.com>
 <69d10d0a-35ac-4543-a699-b3237ae4ccfd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2025 09:45:58 -0500
X-Gm-Features: AQ5f1JpODVuTD1ObBdythZp7y3ncy0TMExroz6ok_K_sGu-627VaQwhQgOJLWo0
Message-ID: <CAOLa=ZRmYP9DV268W=UFMmYvjuLczH2d9yU3q2P4sNMH50RLKQ@mail.gmail.com>
Subject: Re: [GSoC PATCH] rm: fix sign comparison warnings
To: Arnav Bhate <bhatearnav@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000058b58606303a61d1"

--00000000000058b58606303a61d1
Content-Type: text/plain; charset="UTF-8"

Arnav Bhate <bhatearnav@gmail.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Arnav Bhate <bhatearnav@gmail.com> writes:
>>>
>>>>  static int get_ours_cache_pos(const char *path, int pos)
>>>>  {
>>>> -	int i = -pos - 1;
>>>> +	/*
>>>> +	 * This function is only called when pos < 0, so -pos - 1 is
>>>> +	 * greater than or equal to 0, so it can be safely be stored in
>>>> +	 * an unsigned int.
>>>> +	 */
>>>> +	unsigned int i = -pos - 1;
>>>
>>> "Can be safely stored", sure.
>>>
>>> But so is "int i" perfectly adequate to hold such a value, no?
>>>
>>> This is one of the many instances that demonstrate why the
>>> "-Wsign-compare" warning is of dubious value, and invites worse code
>>> than necessary.
>>
>> I have to agree. I think it would a bit cleaner to actually change the
>> functions argument type itself. Perhaps, something like:
>>
>> -- >8 --
>>
>> diff --git a/builtin/rm.c b/builtin/rm.c
>> index 12ae086a55..79e47d6e9e 100644
>> --- a/builtin/rm.c
>> +++ b/builtin/rm.c
>> @@ -40,10 +40,8 @@ static struct {
>>  	} *entry;
>>  } list;
>>
>> -static int get_ours_cache_pos(const char *path, int pos)
>> +static int get_ours_cache_pos(const char *path, unsigned int i)
>>  {
>> -	int i = -pos - 1;
>> -
>>  	while ((i < the_repository->index->cache_nr) &&
>> !strcmp(the_repository->index->cache[i]->name, path)) {
>>  		if (ce_stage(the_repository->index->cache[i]) == 2)
>>  			return i;
>> @@ -83,7 +81,7 @@ static void submodules_absorb_gitdir_if_needed(void)
>>
>>  		pos = index_name_pos(the_repository->index, name, strlen(name));
>>  		if (pos < 0) {
>> -			pos = get_ours_cache_pos(name, pos);
>> +			pos = get_ours_cache_pos(name, -pos - 1);
>>  			if (pos < 0)
>>  				continue;
>>  		}
>> @@ -131,7 +129,7 @@ static int check_local_mod(struct object_id *head,
>> int index_only)
>>  			 * Skip unmerged entries except for populated submodules
>>  			 * that could lose history when removed.
>>  			 */
>> -			pos = get_ours_cache_pos(name, pos);
>> +			pos = get_ours_cache_pos(name, -pos - 1);
>>  			if (pos < 0)
>>  				continue;
>
> This is a good option, I think, but perhaps 'i' should be renamed to
> something more descriptive.
>

Of course, that's why I said 'something like' :) This is only a guidance,
the final changes are left to you.

>>>> @@ -58,7 +62,7 @@ static void print_error_files(struct string_list *files_list,
>>>>  			      int *errs)
>>>>  {
>>>>  	if (files_list->nr) {
>>>> -		int i;
>>>> +		unsigned int i;
>>>>  		struct strbuf err_msg = STRBUF_INIT;
>>>>
>>>>  		strbuf_addstr(&err_msg, main_msg);
>>>> @@ -271,6 +275,7 @@ int cmd_rm(int argc,
>>>>  {
>>>>  	struct lock_file lock_file = LOCK_INIT;
>>>>  	int i, ret = 0;
>>>> +	unsigned int j;
>>>>  	struct pathspec pathspec;
>>>>  	char *seen;
>>>>
>>>> @@ -314,8 +319,8 @@ int cmd_rm(int argc,
>>>>  	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
>>>>  		ensure_full_index(the_repository->index);
>>>>
>>>> -	for (i = 0; i < the_repository->index->cache_nr; i++) {
>>>> -		const struct cache_entry *ce = the_repository->index->cache[i];
>>>> +	for (j = 0; j < the_repository->index->cache_nr; j++) {
>>>> +		const struct cache_entry *ce = the_repository->index->cache[j];
>>>>
>>>>  		if (!include_sparse &&
>>>>  		    (ce_skip_worktree(ce) ||
>
> --
> Regards,
> Arnav Bhate
> (He/Him)

--00000000000058b58606303a61d1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aa51e2699d75dcdf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mUzc2VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0V2Qy80NFRpTExRZXFMcXZlUXpkQlJXQ09wT1dRYQoyQ1pMdE1mYWFk
NlR2SmZISmh6STIwWFljajZtSzJzUGdnMDhZRkptbWtQYUdUL0Zid1FGWmVQSkVSVVdEMGlSCjFX
a3B2QjRDUXpWQ1VtUHZ4TERjaWRURXBPbE1nYm1EaTdGb2VnTnJZTTVsK1pKK2lCQnJ6cWU2ZVA0
U3FrdkYKcGZOQ3BDTG9qMTVyWnhzbnBuT245QXpMQUpubzFkd0xuUiszYkUwcHNmdWlvU0kzaXNx
ODFSOExzVncwUUQ1RApsRU5wczEyVFlxc2NCM0FHbFVrZ3JTM0Z3dUVyMGNjOHgvQ2hKVy9LRkxT
TjJpUjNpaFFXUVJuOHRobml1YWlqCnlwdWpTWjdZU0V2YzRkaE9jbEwwT3hZbHFSRnJGaldCbWxT
QzJrQVJUVk5Gby9SWUVFYWgzSlVZV0xYSGdSZG8KdVhJRmRSZXJaTk9qTS9KTmlQcXBtUVhTN1ZH
amF5bE1VVVRDbS9FWGpzWklYR3BYV01hOHcvVmxBc0xuc3hDegpvNEJ5NUYwU08rTWNVQzY2RlNQ
L1RiRjI5WEFzUE5MMU9aZUNuSDY1c0ZzbXhESUJOSE4zT2tIWnc5T0pvbVRmCmtPTm5aODJ1SVJH
NnI2MkpQT0YvR1RDWnNaSGFWaTNONjVMdzkyST0KPURDRHcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000058b58606303a61d1--
