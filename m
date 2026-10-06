Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B941D11C
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300112; cv=none; b=AzQ5b09sgC0uAIaCsH7fANbmst78sqQbm2HTQHCRkUo8n88B0lKispJTBWlSQk1of2ICtoOOlA1xQdfmfrBEG6+V6voO6ZTq3PKOwPWgV2ScKNboQwQdzKQd0kKQF8aRxV4Dj+za+h1elMj9bB5CYd21ZEkdhsn8LE1FUDBOIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300112; c=relaxed/simple;
	bh=BfDR1VEEMpzjCKRZuWysw5F2DBbvAiWdDtwl3+jZYfg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V3yD+zISrm8fNjc9beeckBCSceevhZ1/A42C4WIBGLMSpS80YzeXN2L2Uvpca2D63G36MQ3gNYsmm0RJslzLQrQqMVfGF+rRkktJcNFEDtcgvO8zwKi2utrC7s7rw19vdEc0qK2e4a6QYSwUwa+oHFi+zNji4q9zXeot33AINVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkVqkhqA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkVqkhqA"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso9346025e9.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791300109; x=1791904909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lua+bJC7ZYkOlZid75lh+aZsIFVkjP4qzoFQGhsjRpw=;
        b=gkVqkhqA1vf3fl4/GbWzqP37JJfwJphkz7vWlbTWj06ZRYkphRUsCdMCb468x0Wt6O
         1VSstli6WRIurgw2t+fU/z0w9RDPsPTKPdR+iqp4IBTUpaincjRWtGsjEBK+c7qP7jj9
         CSGnCyiMtukZ3pmOR54IRfwVhI0MYiTVLoRXIAvO2MmJm2uh0EAwRMJm6W+PKzQ1iW3B
         HrUewIQxh0POfnXxiK7U1Cf3HQfbVtKeW7lLkKpyQ2LhndG9p94y4XLLRNOAkJ/M1pKd
         f9mc/vM/Knx3meqqQqXio25EXxBMgzYDoycV3IVP/gt4cZBGopE+iUTNWPYNY4S8uyHl
         IRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791300109; x=1791904909;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lua+bJC7ZYkOlZid75lh+aZsIFVkjP4qzoFQGhsjRpw=;
        b=iR6U3bUahYOgUxymMnWWy1Wa1ehiceQsCo+EmVi0deebSZAKnfhMBNA0aJVkG5moiP
         fgdu/L0kZhjj7I8f5HjxRIgZ7lxBozJWfuIpOzRKlhGKx/eJussGsBVrBc5nYVmj3RS5
         8FxziJ4I1veEVF6/DW3j77MRn4AlAgmca6L0wycbFyAfS/U5qwmi0bH3s7xUEuxcQYId
         r4BmR7hBkVU0qaU7sWXH/DriPHX5Cy90Et5mOg7cPzLGKbk6HGjm6JxetAHGM3hFwgfg
         kzJ6/rMxKoYUXPq7n720fYBeqLuK8rbPr3mVVqbALSonQvbQMw7Xs2gWXamq2esSy7bP
         p74g==
X-Gm-Message-State: AFuF++lBlt/kZo+diIOquB2+2K8kRpkn0o0NITobEaHmRWWF3CnoP6R2
	rBIVle11v0irtlZquBxXJRTZLr9iHnXT4rMy4wXqeKGuUKmiRwQnI/EG
X-Gm-Gg: AYBFou2eDlpkRCw+7xXyqfzlhaxnGG1Ekj8fdBYSy/pajb6NSRS9qG5NUcBcJ6UhE7J
	BywYKtHMTF9MZafN9fUwgU83a/J8417jXO03YBjhjvNLORc2pG+zwDAXJ+o2l2ooW47NVvW3XxG
	IpE1jJMIEEveieTY8JVGU0elLF4+P37/FhokPhLEH85WyJTqIfOl+g9+recl0d5wAVoletrtM91
	DSVpV2+u0XFEfWSpWbDS/rObRx3ATRaorSEcOXiNwK7USjcURtaG/BSLGKU2sUHt2thUBWaz5Tf
	5JZRs0xaAtTeffHMEvkneeURXOfGnyF/vlRcHn7tP0rTwif7xgL7LKg5GU4maI8rdaDQdZJt8Pt
	h01QY1Pbx0o/3QjIYRgtk1FlqCBFgvUa+EVjqw0znV8Hty7Px84AcMI29of8tLwG2KNgZLu9/NJ
	V6lNUEdRBwEUXQ+NN+JXOPEb+ae8XjHtG1DZiSceEL4S24TBSXsTau6K5p0f4aQHQG8IjquBMQw
	tuqPZPPC9E5ZOMJQFnopvGbXyOsrcaW+iSwE4hZsIho0J4i/APD
X-Received: by 2002:a05:600c:c84:b0:4a0:bc9:28c6 with SMTP id 5b1f17b1804b1-4a17b56e171mr30621395e9.34.1791300109069;
        Tue, 06 Oct 2026 08:21:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm341359815e9.2.2026.10.06.08.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 08:21:48 -0700 (PDT)
Message-ID: <b19fc30c-290d-471c-a5b8-57f44339f243@gmail.com>
Date: Tue, 6 Oct 2026 16:21:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] merge: remember conflict labels
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Johannes Sixt <j6t@kdbg.org>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
 <cover.1791206658.git.phillip.wood@dunelm.org.uk>
 <18bdf7df49dde2c8e7f73f3b46c656abb6b26293.1791206658.git.phillip.wood@dunelm.org.uk>
 <xmqqld8cktlc.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqld8cktlc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/10/2026 17:19, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> @@ -128,6 +128,7 @@ int validate_branchname(const char *name, struct strbuf *ref);
>>   int validate_new_branchname(const char *name, struct strbuf *ref, int force);
>>   
>>   #define REMOVE_BRANCH_STATE_VERBOSE (1u << 0)
>> +#define REMOVE_BRANCH_STATE_PRESERVE_CONFLICT_LABELS (1u << 1)
> 
> Not complaining and I have no improvement suggestions, but this
> phrasing made me imagine that we would be passing this flag bit
> in code paths where we want to write the extra file out.

I can see why you'd think that, would appending "_FILE" make it clearer? 
(though the name is long enough already)
> But that does not match the reality.  merge_switch_to_result() calls
> write_merge_labels() unconditionally.  The bit controls if the file
> written survives the clean-up after the operation.

>> @@ -1262,7 +1276,9 @@ static int switch_branches(const struct checkout_opts *opts,
>>   
>>   	if (autostash_res == STASH_APPLY_CONFLICT && !opts->quiet)
>>   		fputc('\n', stderr);
>> -	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
>> +
>> +	update_refs_for_switch(opts, &old_branch_info, new_branch_info,
>> +			       autostash_res == STASH_APPLY_CONFLICT);
> 
> OK, so here we assume STASH_APPLY_CONFLICT result means we called
> write_merge_labels() and left the file.  If not, we did not call it
> and the file should not be there.
> 
> But then can't we just unconditionally leave the file, instead of
> not removing what we wouldn't have created?

Hmm, If a previous command such as "git stash pop" or "git checkout -m" 
had conflicts and wrote the file, and then the user resolves the 
conflicts and runs "git checkout" without "-m" (or with "-m" without 
creating conflicts) don't we want to remove the file?

>> +static char *parse_merge_label_line(struct strbuf *buf, FILE *fp)
>> +{
>> +	if (strbuf_getline(buf, fp) == EOF)
>> +		return NULL;
>> +
>> +	return xmemdupz(buf->buf, buf->len);
>> +}
> 
> Wouldn't strbuf_detach() be more intuitive?
> 
>> +int read_merge_labels(struct repository *r,
>> +		      char **pbase, char** pours, char** ptheirs)
> 
> Be consistent.  Asterisk sticks to variables, not types.

Oops, I'll fix those.

>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +	char *base = NULL, *ours = NULL, *theirs = NULL;
>> +	int ret = -1;
>> +	FILE *fp = fopen(git_path_merge_labels(r), "r");
>> +
>> +	if (!fp)
>> +		return -1;
>> +
>> +	base = parse_merge_label_line(&buf, fp);
>> +	if (!base)
>> +		goto out;
>> +
>> +	ours = parse_merge_label_line(&buf, fp);
>> +	if (!ours)
>> +		goto out;
>> +
>> +	theirs = parse_merge_label_line(&buf, fp);
>> +	if (!theirs)
>> +		goto out;
> 
> The repetitions are a bit annoying, but it does not get much better:
> 
> 	int i;
> 	char bot[3] = {0}; /* base, ours, theirs */
> 
> 	for (i = 0; i < ARRAY_SIZE(bot); i++)
>          	if (!(bot[i] = parse_merge_label_line(&buf, fp)))
> 			goto out;
> 
> so I am OK with what was posted.

Yeah, they are a bit annoying, but as there are only three of them it 
isn't too bad.

> It may be helpful to future developers to leave a comment that we
> deliberately ignore cruft after these three lines in the file and
> why, instead of diagnosing it as an error.

Will do

Thanks

Phillip

>> +	ret = 0;
>> +	*pbase = base;
>> +	*pours = ours;
>> +	*ptheirs = theirs;
>> +out:
>> +	if (ret) {
>> +		free(base);
>> +		free(ours);
>> +		free(theirs);
>> +	}
>> +	fclose(fp);
>> +	strbuf_release(&buf);
>> +
>> +	return ret;
>> +}

