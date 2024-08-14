Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9D1B5808
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651177; cv=none; b=o6J9vAUdQkUEm0GZhmWDaflDAHMWy4hcZiPR1dXvnt/zK5dL+H0KHBsvvuXnKiPjHMKlEqYBAX4noT01SJezNHLtODhvJht4aEq4ZveXa5nxSf0RYhda35k+hQ190eQ2LsbqtkWHI3N8EJYk2I3w9PPKwi2Oy/wbtC3oZoTPaJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651177; c=relaxed/simple;
	bh=MfQ6xhIoGwP2irk+lTTc9u/plB1rtIQtmg8q8lLE7U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+CZN1KSKpETnJjS3I0KDAXbN9R6fYOOvAuE+TqS8ukua6F4OE+2nLb7xPmzxY+oCO15eD2pjEjDBttBxBQBAExYuRdS72Jhfvbhh+DC0n+GYCPY/Ut50cTypjBkoml4VHhkm+usOnvfJPS59oNW/Jz00N1y/ufMwIKkxDgFNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJYer+/S; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJYer+/S"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428e1915e18so46760545e9.1
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723651174; x=1724255974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vp9Lwx9M1C59kq00TD6cTqMRnroMV57K9De35mOLeD4=;
        b=fJYer+/Szpt419qtlizZjSIdt4QjyN8JRJBPstb9QHyEVJZmbQ2YPyt61fVttIfw8+
         9xIWKYzCeuGxjrJp0wclk0969JAKbm+lDrZDeh/v/dqmyYEBLdA9Ksy7hx0l9EJZiHtK
         YGtHYhw13uN3LtleNxL5zP0wtj/8LtC6KYgIr4YFBtdogcyzt5TdDCVUZrP3hhYCPTXy
         dUy36mOVGDq3e2SGHWDR73prmSNV1BlrBvDtnVgemR7FVs21Rtcm3e3LdiuKGXASW5Oc
         9l7Bq2ro2uEE1FDEOY+JW2MSWhgyGKWy4Yv8Mw8MdCBtOvHPbrtyreFyJWTABQazi/ke
         6EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651174; x=1724255974;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vp9Lwx9M1C59kq00TD6cTqMRnroMV57K9De35mOLeD4=;
        b=DdI+8PxRO+tXg5sXtMy08kW1tnVXEv979+q28zTUqgnkzGY9q5MQabtp/syiXXVOqE
         Fjl6LCxwUhyKeyq9Khrp3knb2+SCVXWUm+Cx1cNc+ivA5wGxt8ffWMtyso6HSG8WMA77
         LC8a8gDBkwVneYUlTuXKL8GVLJ+U+0G0/IGHNWUCteyLn4dyJ6tnNLyxYEkFy2eQIzZw
         HTOs7F4ixKaFR1S+SCUMFurYSsisVZQsE7WGh9e6WMIOutdn5esIsXntfSrUgCjQm165
         zN+hs9FIzJqWotN/lrvIWY2uk9MXy1Jimg/urQHcjpINMj6x4sWeGUJBdCdorHjpL5bm
         EtsA==
X-Gm-Message-State: AOJu0YxJ/SDcstMDLorggd1Kp2ub/YJYQi0Ss/mKh4kzPXlTO7Xxy915
	QWk7CTke1gR8DLEvRBeBKmSG7OtDzXp4lxHoAtUjiPif8Edr0EbL
X-Google-Smtp-Source: AGHT+IFl4Nde4KXLQ2AcYtBhOi73gowNhZoN/2SxZwVOuwJ0fyihA/kWOpGriICbCJwKUiUo+M+xkA==
X-Received: by 2002:a05:600c:470c:b0:426:654e:16da with SMTP id 5b1f17b1804b1-429dd1effa4mr25212045e9.0.1723651173666;
        Wed, 14 Aug 2024 08:59:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d7830539sm54231255e9.0.2024.08.14.08.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 08:59:33 -0700 (PDT)
Message-ID: <b676bd17-1cc8-4639-acb7-675dde32a1ae@gmail.com>
Date: Wed, 14 Aug 2024 16:59:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: apply and cleanup autostash when rebase fails to
 start
To: Patrick Steinhardt <ps@pks.im>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Brian Lyles <brianmlyles@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1772.git.1723641747309.gitgitgadget@gmail.com>
 <ZrzA0yp45w9NuTp2@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZrzA0yp45w9NuTp2@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 14/08/2024 15:36, Patrick Steinhardt wrote:
> On Wed, Aug 14, 2024 at 01:22:27PM +0000, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If "git rebase" fails to start after stashing the user's uncommitted
>> changes then it forgets to restore the stashed changes and remove state
> 
> s/remove/& the/
> 
>> directory. To make matters worse running "git rebase --abort" to apply
> 
> s/worse/&,/
> 
>> the stashed changes and cleanup the state directory fails because the
> 
> s/cleanup/& of/

Thanks for catching those typos

>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index e3a8e74cfc2..ac23c4ddbb0 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -526,6 +526,23 @@ static int rebase_write_basic_state(struct rebase_options *opts)
>>   	return 0;
>>   }
>>   
>> +static int cleanup_autostash(struct rebase_options *opts)
>> +{
>> +	int ret;
>> +	struct strbuf dir = STRBUF_INIT;
>> +	const char *path = state_dir_path("autostash", opts);
>> +
>> +	if (!file_exists(path))
>> +		return 0;
>> +	ret = apply_autostash(path);
>> +	strbuf_addstr(&dir, opts->state_dir);
>> +	if (remove_dir_recursively(&dir, 0))
>> +		ret = error_errno(_("could not remove '%s'"), opts->state_dir);
> 
> This seems somewhat dangerous to me though. Should we really delete the
> autostash directory in case applying the autostash has failed?

Applying the stash should not fail because the rebase has not started 
and so HEAD, the index and the worktree are unchanged since the stash 
was created. If it does fail for some reason then apply_autostash() 
creates a new entry under refs/stash. We definitely do want to remove 
the directory otherwise we're left with the inconsistent state we're 
tying to fix.

>> @@ -1851,9 +1871,14 @@ run_rebase:
>>   
>>   cleanup:
>>   	strbuf_release(&buf);
>> +	strbuf_release(&msg);
>>   	strbuf_release(&revisions);
>>   	rebase_options_release(&options);
>>   	free(squash_onto_name);
>>   	free(keep_base_onto_name);
>>   	return !!ret;
>> +
>> +cleanup_autostash:
>> +	ret |= !!cleanup_autostash(&options);
>> +	goto cleanup;
>>   }
> 
> It's somewhat curious of a code flow to jump backwards. It might be
> easier to reason about the flow if we kept track of a variable
> `autostash_needs_cleanup` that we set such that all jumps can go to the
> `cleanup` label instead.

It is slightly odd, but in the end I decided it was simpler to say "goto 
cleanup_autostash" than try and keep track of what needs cleaning up 
when saying "goto cleanup". There are a couple of similar examples in 
builtin/stash.c:show_stash() and 
config.c:git_config_set_multivar_in_file_gently()

Thanks for the review

Phillip


> Patrick
> 
