Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972947C0FC
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380782; cv=none; b=qUM38957vBRjaT1Qto7i4K6S2iMZaSzTVrdlIskaqFcI+4EKp2dtKz0TsNCYfpZXe3hLBqaZLxlO/8ZTpy7jFZ2WGgMk71GPpREohb6AKeLPkW2VrBuSm1Iu91NpXLUQcKxlyA8A+FyXjYE7ckM4QxkY+7L+2SZ7PfyomMHJ61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380782; c=relaxed/simple;
	bh=Wq7LZx8Gz2ZM+yhmKcDM+7xjwM67zRfV52sqR5XUGH0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UIt0hgmbkVZXU75jxFki5sBR/A0mubwuTpfelOhcVNFpBZ86QdEd5Ba9hAOLv9F9Y7veNcrTBBKxa7UqxGDL89wqf+NdjF39CQ3RXpNQhNwS2WeVFlGVEk9EtgEG5e93bdaWWOBALySC6YnxXUQDAiNRyV8WM3KfwrlMBwB9dbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REMIM8gq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REMIM8gq"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c247f6687dcso275121166b.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791380770; x=1791985570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mTJxBIcXIIfEgKrF5mzGOoCPPTngeY2A8aCUqhyXVl4=;
        b=REMIM8gqU2xl7OHHFjy+7XqwZ/Sj7FTJbDPQORT/ejn7tpwsKzHoak6oqMj5BSk3zE
         19ERiiPRjstd2OR1mOS6p1YDYxqOfet2AmL/v5TYx1/xYFXHJimQCECzzN6CLuD92XR1
         oqhnWWHBQd9+Rj0Khj8qfZVUPXGm0za3d/Sxz7kCmdfC2POVEnsdGDdTx3itMpqC1iCp
         BO6ygQTZ+M1khqSmHozurrraZ/zOIFHEWR88ZYqIqiUlBp0Kovs7C0Duq6pU7p+ATu8o
         JTPbsvA9XmoTW1tEhryY+CgM2tC+dsOnMEQYkDXVdvlJusSqCNoLPpjkJ52+WI49CD6l
         88xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791380770; x=1791985570;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mTJxBIcXIIfEgKrF5mzGOoCPPTngeY2A8aCUqhyXVl4=;
        b=EoBO9lzMPfm/90wNheCYpzhAFj9asNiU5fzXwCZ8tLFG8unuJkthgyOfEHCmKoaiu9
         4ai30NHdvEFj/n4Ps+NaManem2oFkE5x8Uha6pwv6X4XCqKQFVvSBk6cXCBDnxtaYG9e
         q9jWjzWBPCe9RQfPpMXvBj8TkYGf1PTkox5HAXbdP6zDlqmmil3aWUn2ysdhg4KpCYKR
         SJWIOBxDsZXZLtbmIu6X2Bn2u8wPFROLyv0J1QNV+UHtAmelEFjbkqJudyXYDiuwNroE
         F7VYxbauFQvM98ElrHtfpime8xyoyHcNv8mmaWlZJmuLxnCbQniofdSWX2hj6BysHt7U
         I+sg==
X-Gm-Message-State: AFq9FYLxToPdF9VM0Zfq6QYYW3DNTP77qO3L7dZctvDj+nNKuEbV3dJ0
	avnrxEQWNHro8UjnGcIa3p3evLmAVVvPmWeh05a2VlTQxmVMM2e8nf72
X-Gm-Gg: AYBFou1xWkL9hqTvP63c9RX4CS2Rg6vk/gjy1EugLZGWXxGTrnzxYDeAP7t3PKHeDlL
	84muEdpOHm7mlo4cVfRrH3VbkbAMRjXBll9+Rc9OKQUqz7nSgNQiLVQDTRDqFSYOazUCYwfS21L
	qrBz0fjq+mqg4bWcupu8IkZWMBxteW3lG+UR0cDVkCwH31SXuLToT8eJS413gA+IFaVEd5A3MF/
	+cG9CfpSyyt0HlfbCc6Hg5cQs4MrB0aZLnRFFSeH+LU9THfiAG/E1PrrazFQtuuqN08XAZURT2j
	D2MIl0yuX1HgR5hh8JBCK7a2owJnFrn4ORwxsv3vSO8jxYvs1yttZZOEhwY13i3hWbNsk3HBJ5i
	wNgk/lDqG0VuA9AQ3sLBL9IQyPNfHOzjXn1oIXjKcS8+Q354sqNJhlAQcWPQxZVLaA/5xmaOkhy
	tgXriRtYNSGA/tek0JKrw4azz+4wWmLhV9Beulu/CKi0FXCZaIMBmOCRvHaZaxxBBKG0WlQUO/J
	l+sbGqHp6kMha1z150izg8A0mMDSi4iVaexknXZn0fJKJi60yMbwg==
X-Received: by 2002:a17:907:3f1b:b0:c2e:4389:8615 with SMTP id a640c23a62f3a-c317bb4d2c1mr239259766b.2.1791380769907;
        Wed, 07 Oct 2026 06:46:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c318672c74csm51951366b.36.2026.10.07.06.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 06:46:09 -0700 (PDT)
Message-ID: <725487d3-5a07-40c6-a603-990a661e0193@gmail.com>
Date: Wed, 7 Oct 2026 14:46:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] stash push: remove duplicate changes detection
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
 <95b7d582a2f86a3db4a9e182e482e9eb904ddeee.1791218125.git.phillip.wood@dunelm.org.uk>
 <xmqqpkxmgb00.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpkxmgb00.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/10/2026 15:27, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> diff --git a/builtin/stash.c b/builtin/stash.c
>> index 9a5006e3d92..79fdfff09a2 100644
>> --- a/builtin/stash.c
>> +++ b/builtin/stash.c
>> @@ -1538,7 +1538,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>>   	}
>>   
>>   	if (!check_changes(ps, include_untracked, &untracked_files)) {
>> -		ret = 1;
>> +		ret = 2;
>>   		goto done;
>>   	}
> 
> It may be time for us to introduce symbolic constants once we have
> three choices instead of two.

That makes sense

>> @@ -1728,12 +1728,6 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>>   		goto done;
>>   	}
>>   
>> -	if (!check_changes(ps, include_untracked, &untracked_files)) {
>> -		if (!quiet)
>> -			printf_ln(_("No local changes to save"));
>> -		goto done;
>> -	}
>> -
>>   	if (!refs_reflog_exists(get_main_ref_store(the_repository), ref_stash) && do_clear_stash()) {
>>   		ret = -1;
>>   		if (!quiet)
> 
> Before the precontext of this hunk, repo_refresh_and_write_index()
> is called to refresh the index.  We used to leave early when
> check_changes() saw no need to save.  We no longer do so, and
> instead keep going.
> 
>> @@ -1743,8 +1737,15 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>>   
>>   	if (stash_msg)
>>   		strbuf_addstr(&stash_msg_buf, stash_msg);
>> -	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
>> -			    interactive_opts, only_staged, &info, &patch, quiet)) {
>> +	ret =  do_create_stash(ps, &stash_msg_buf, include_untracked,
>> +			       patch_mode, interactive_opts, only_staged, &info,
>> +			       &patch, quiet);
> 
> And we call do_create_stash().  The first thing it does is to call
> repo_read_index_preload() and repo_refresh_and_write_index().
> 
> Are we refreshing the index twice now, even though we know nothing
> has changed in between, when we run "git stash push"?

We've always been doing that when there is something to stash (which is 
the normal case). To avoid that we need to make the callers of 
do_create_stash() responsible for refreshing the index. At the moment 
create_stash() calls do_create_stash() without evening reading the 
index, but do_push_stash() needs to read the index to check if it the 
pathspec contains paths that don't match the index. That would also 
avoid calling preload_index() multiple times.

> do_create_stash() does call check_changes() to return early without
> creating stash, so we did save the cost of check_changes() with this
> patch, though.

Yes, lets add another patch to avoid unnecessarily refreshing the index 
as well.

Thanks

Phillip

>> +	if (ret == 2) {
>> +		if (!quiet)
>> +			printf_ln(_("No local changes to save"));
>> +		ret = 0;
>> +		goto done;
>> +	} else if (ret) {
>>   		ret = -1;
>>   		goto done;
>>   	}

