Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849AF2D7393
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230007; cv=none; b=Cup1DRRQchS+rQa1A9Ushpc46OE7/Q8Ea5PvpmzBf2A6eioMWFoKkKj3hen8s+9z1cACwGqWWeZtD3rD63NZKVpfNRByXkwd2xL0u7tAPIEOcoRG9xuguejo7golWdZ2Pr6jZqMbi214wFq5ONjLYVaGVD02ifIJZH+PaFlNWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230007; c=relaxed/simple;
	bh=Z2GAB0/bkdhdyn6akt98nApJPgBGvGQkEKzxSvFQNKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbpyR1g/FdNtKihS1oS/vKJHi+FTv4KdfhTG4kjbNZ2oWb2r4S/4AYF7SwSY6ghQwaq2PJiERgRkZD9Jzwlg6IyemLv/Ky3N+/wnHbFdY06FTzP0A+TvW8zNL8jBRc+FzJAbGm8qTHKsIcyMY+PFVlWkcDJc3RXiRLIOENrHBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIgHFk2i; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIgHFk2i"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso240745e9.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782230004; x=1782834804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yirARN1dkJCFDeCmPg/TR2KVXJmgGbgOHOXnyV3SuDA=;
        b=fIgHFk2iF4ZygXIgNZ/dsNtQh5fLm+lMafk0VmWBcRpulVYWTaKQBZZLqIn11YireC
         TQ/cBXH9yPqGbPuyj/QwQJVr2S7fJzCLCGQZDu/PSrK8f2BoBkEGlMD4xNIwbefqnW5b
         ALzE0KwH9SFL8YJXrrVePBUuCG2a2S0oXhYGpyWd0EdvfTPDpbiIHyxfPyJPi/EEzW/Y
         8/cHEVZlIGGXoPqb0QEbtYUH7h5DM3P/wc33Va/eTPw24CR/nh3tTnJaM1O9uikPZdXb
         wMTrUh4x5Uhco3sK7B61z/2YBSXRmTI/AHAEoQ6Ii/3HHyChj26BV2JH9c/7G1AoYCzX
         Qf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230004; x=1782834804;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yirARN1dkJCFDeCmPg/TR2KVXJmgGbgOHOXnyV3SuDA=;
        b=jrD5fFL54FlASaPn3NWFFkM3/70GBRaUdMlr6Hxy0MIuOj0Iu0zbPfPs80phSPNH2J
         IU6bEHztQiCOyToOc2azt0byebENfPCO7dyEjCrnUDD+dd1v9dTLK/JPCA107T9GE+19
         85pdYqr24FhJebgi4g3X4GYfDcQlEnpKgZE1wj/zOxrAoIJgt/dUNRY/Uf58uu7KuV36
         DGvCZuqs+iKWqb3Z6wxQPDmeqTR+U9DLoij0TWAub/Os3pJI4ayxAXKXhMB4wE1fqCI9
         K3h0umUaDWipGHaU9fnO6vr71SQj6DxIbEGdGvKfIHV5vAXGDVWs1u5ezsuDwom0w8C7
         UmHw==
X-Gm-Message-State: AOJu0YxQM9bw21IzqEb/oK8okUbmBPbgGQgT4P2yMR0PKJ5ZbrRaOykS
	oOEGrY+m0p1o2K1huDgFZO79dFdrlyb+chrghXRBvRVtvlSsrGHA7pxdmkGG5w==
X-Gm-Gg: AfdE7cmPy9xLyyhOr79s/2YBGCDc0YWTIT/De+BHrpG6zoPRUpbbMZbmwtsmLJRV5Vt
	Ra+4H4AsDKvyAfJrAaTe4GZwk+uqa8mLn2liZB84WwQ6WvClK8FtKnAhThXYrtzEteOy9PcG/GA
	rHIUIK1wx6yux5irQxcbwQr3ZLIxsAaIFUvbIiNlH28dlMQwZfuPD0mMya5QQpSk2aAHyVNH6Y2
	kpuzpJk7mE3uad4a23OK3FjGviqCWY8uBlo1kL65kkprS8LQlHAV3OD2unEpMFMN0F2R2UMlhMy
	sKsfA7DWOuVNJTytYHl9hwQjmytZPsb5mP607k3i0tAk/aaHIliFbTj4aibFjYix3Rj1jheeWCU
	A0BPMUVx10Uj1rRrtIah93W0YIwweTHO1Cn7K3D38hFYQe9qv/HhBLEgeqTlUijgt3Ht7ipOWIR
	9HdFU68ASmOJmrVPBJZYa1M4aZG2LZSeoHo/ONwlfK1nWuq5WUcw9b7nfFR0ECbQqNUsk=
X-Received: by 2002:a05:600c:628f:b0:490:bd66:e522 with SMTP id 5b1f17b1804b1-49240e72434mr314466825e9.29.1782230003698;
        Tue, 23 Jun 2026 08:53:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240f1f330sm240915975e9.2.2026.06.23.08.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:53:23 -0700 (PDT)
Message-ID: <65d38915-019e-4e2c-838f-980023e0c2af@gmail.com>
Date: Tue, 23 Jun 2026 16:53:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] sequencer: factor out parsing of todo commands
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
 <cover.1782117361.git.phillip.wood@dunelm.org.uk>
 <d27dddff93144f7b6d7fc89719bdf53b6856c9fc.1782117361.git.phillip.wood@dunelm.org.uk>
 <xmqqpl1i1pef.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqpl1i1pef.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/06/2026 18:00, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Move the code that parses todo commands into a separate function so
>> that it can be shared with "git status" in the next commit. As we
>> know the input is NUL terminated we do not pass a pointer to the end
>> of the line and instead test for a blank line by looking for NUL, CR
>> LF, or LF. We use starts_with() instead of starts_with_mem() for the
>> same reason. This results in slightly different behavior when there
>> a CR at the start of the line that is not followed by LF. Previously
>> such a line was treated as a comment rather than an invalid line.
> 
> Meaning that the input validation is tighter than before? 

Yes

> I think
> it is fine in this case, as I do not see a reason why anybody wants
> to use a lone CR as comment introducer.

Agreed. In the unlikely event that core.commentChar starts with a CR we 
still treat the line as a comment, but we don't treat lines starting 
with a CR as a comment anymore. I think that behavior was a lazy way of 
handling empty lines with CR LF line endings.

Thanks

Phillip
>> +bool sequencer_parse_todo_command(const char **p, enum todo_command *cmd)
>> +{
>> +	const char *s = *p;
>> +
>> +	for (int i = 0; i < TODO_COMMENT; i++)
>> +		if (is_command(i, p)) {
>> +			*cmd = i;
>> +			return true;
>> +		}
>> +
>> +	if (starts_with(s, comment_line_str)) {
>> +		*cmd = TODO_COMMENT;
>> +		return true;
>> +	} else if (s[0] == '\n' || (s[0] == '\r' && s[1] == '\n') || !s[0]) {
>> +		*cmd = TODO_COMMENT;
>> +		return true;
>> +	}
>> +
>> +	return false;
>>   }
> 
> I notice that the order of noticing concrete comments and comment
> lines are swapped relative to the original.  There is no inherently
> "natural" order between them, so the change is perfectly OK.  I just
> got confused slightly while reading it until I realized that is what
> you did.
> 
>>   static int check_label_or_ref_arg(enum todo_command command, const char *arg)
>> @@ -2716,29 +2737,23 @@ static int parse_insn_line(struct repository *r, struct replay_opts *opts,
>>   {
>>   	struct object_id commit_oid;
>>   	char *end_of_object_name;
>> -	int i, saved, status, padding;
>> +	int saved, status, padding;
>>   
>>   	item->flags = 0;
>>   
>>   	/* left-trim */
>>   	bol += strspn(bol, " \t");
>>   
>> -	if (bol == eol || *bol == '\r' || starts_with_mem(bol, eol - bol, comment_line_str)) {
>> -		item->command = TODO_COMMENT;
>> -		item->commit = NULL;
>> -		item->arg_offset = bol - buf;
>> -		item->arg_len = eol - bol;
>> -		return 0;
>> -	}
>> -
>> -	for (i = 0; i < TODO_COMMENT; i++)
>> -		if (is_command(i, &bol)) {
>> -			item->command = i;
>> -			break;
>> -		}
>> -	if (i >= TODO_COMMENT)
>> +	if (!sequencer_parse_todo_command(&bol, &item->command))
>>   		return error(_("invalid command '%.*s'"),
>>   			     (int)strcspn(bol, " \t\r\n"), bol);
>> +
>> +	if (item->command == TODO_COMMENT) {
>> +		item->commit = NULL;
>> +		item->arg_offset = bol - buf;
>> +		item->arg_len = eol - bol;
>> +		return 0;
>> +	}
> 
> And the extra stuff that are only relevant to a comment line is
> naturally processed by the caller.  OK.
> 
> Thanks.  Looking good so far.
> 

