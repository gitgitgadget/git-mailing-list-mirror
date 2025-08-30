Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37A82866
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756564423; cv=none; b=FUAzd/rz2l+PAL/0ix3IMktpZEjqlG9BVbJVuucH5jVZZzIwrYVhGAOmec+3mzg7n39pz0eChcMicD6c3qAbNuThNQKCzx5weyc48syQgfUa+jkDBG8zcJXbTdObNIXzRXnkMVo2yrqw45GGAINT4eAAkLfBw22PdjF7tKdU5PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756564423; c=relaxed/simple;
	bh=OjBehNt0WYDKtZhytWpWBtC3VLFLchzi31j5pyQkAuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+4NmRigmt5XFQsPgDPQWUzMEwke104kqrB4R+HlAhpggIDwxvTNdTD0lUx3B9TeBksBh2TXpBl/cNEsxkoozEP/4UwJXmq8EOGCUHvLPxfuYY0k+kpFPXMmqlfUSqV6OIh7IWHUe3TwWGABaDXlbL8gOGM4/S9YxEzRnOlib14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgSJAhjj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgSJAhjj"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7f6f367a248so270414985a.3
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756564420; x=1757169220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSNdZF2L635esVXgqJ4XtwSF7hKp20RV5CGt4q9EosE=;
        b=JgSJAhjj2Xcy+VLPNe71vejFfAuEmdBaL7naJmfY9AZ8a5zIbqaJPhhiyDRPSz1ASb
         h/CoRzs6QHFammnl1LjEwUK1W4BSw+S6EdC3+E0RJAG74OcMgBzHYQz5qeOAPDRoilEn
         0SbKCWHWJJOx8HqkUA9X+bW/1fG+LExN+ceJCbcbeRxNQPPuzKJ1FiQ/5OqPVLkqvEN1
         4+mZ+KYbsZC8mfHRhh+lCJYEDlkdZclgqu4YN+4GlWn1PghHEV2rTziiP1aAelJ+o2VI
         KKM9qGlR41vOMVo/AGUXu0LO/XJQrLhM9E1Fbk9Nl9z72QjEcghd3f3VsQnPYwAAXDKu
         rp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756564420; x=1757169220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSNdZF2L635esVXgqJ4XtwSF7hKp20RV5CGt4q9EosE=;
        b=sFt2mTuz1tFxpi3H7jgKBK9ZoSQvfKdYLcMmFiSZVe9g7F97+nOXXwfq6u4ygAu4SI
         WkuNWy71PmEcRG7xrknRTIgEJC5ggB1OoyXKzRP9qpVnoQkt4+1p9R7WlIEB4gez/AOp
         LyLb3spTQ1KCfdrFsywmph8BnRCSBKpRa71XsfUzpvH+eUPX8BnogJ+bwGCAi18v8czh
         jzhmj6D0plYuTlE6ICEuPevUvKtpkLhs+EQdYPIQxUNoVhwPkmdQu8VePDDMqsytmSxo
         JwLkRAE+q9rU+MlXDYcXAfSnzKAFXr+b5tSYJVCbbI/Y8Z2fNFxLIZ3mDC/PS0jA/tgK
         tm9Q==
X-Gm-Message-State: AOJu0Yz/WOS9CD3PEd93ms9FvvnNtXzibZqHu/nXTZ1u6NMpu8w4BLB2
	o9Q+w4BhyAmlVuZXuvZortS2sS0Sby0x5PKriRHuncZUBtR0qk9g1fq8f7w11XL1
X-Gm-Gg: ASbGncu8/R+/0gLAmK4UUuq8hO135YuPM0D3EY7oB7F+F8YGXyvUDX4RmhCLd57Ro0r
	ip3uM7AeIJiCRdvivrPn8dqsYHFuYAejjNxSIU8He0Ig84BTRr5bcdXBLd7dnGA/SY1rMrEnrX4
	E3P0z8nHSrm11WjM3cCvvRnRRHqfiFDS4Qv5guQuNcgHa0pdINP6kGnproYAnE4NUpWxKSePJfO
	1BsJL6GFDv2OAAEHVUDHw+xudnbzzIAcWOBNtS+efj0mQYmX/fxAyyvQm97EQZJj8iTg6nJPqTo
	4rgVXNw9CYSVIVC49HoN1GtCc6g4asp+rp4xqjUdXTgnCdRNYkAujG3evwKFmhhVMD9shwgAdaL
	o0RchuBtdU2hzCqHXnFUO8Xtp0lTy02E4kCfcd0Ir1CHzBlgOUfET5nDpFg4eUVPxfJ4iNMrnug
	lzfNImz/IqynXoskcqwNxp
X-Google-Smtp-Source: AGHT+IGkWiqatJDC7DobAqUUOL8tbhtoaEmHce8UjSYjKyDoqsLuCaVWphzcs7WnUihmwIsUxkzOmw==
X-Received: by 2002:a05:620a:1a87:b0:7fe:3894:5966 with SMTP id af79cd13be357-7ff2aa22393mr234366485a.41.1756564420221;
        Sat, 30 Aug 2025 07:33:40 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:85d0:178d:3525:8f0e? ([2605:a601:a6de:d300:85d0:178d:3525:8f0e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b54cc37sm31288401cf.12.2025.08.30.07.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 07:33:39 -0700 (PDT)
Message-ID: <f161727d-7688-4f62-9eb4-67d1b9033503@gmail.com>
Date: Sat, 30 Aug 2025 10:33:39 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] midx-write: only load initialized packs
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <4a4b35c69413ff18f87930dd15335f018ec71910.1756402795.git.gitgitgadget@gmail.com>
 <aLEAaNsm8LE2M3TE@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aLEAaNsm8LE2M3TE@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 9:20 PM, Taylor Blau wrote:
> On Thu, Aug 28, 2025 at 05:39:51PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The fill_packs_from_midx() method was refactored in fcb2205b77 (midx:
>> implement support for writing incremental MIDX chains, 2024-08-06) to
>> allow for preferred packfiles and incremental multi-pack-indexes.
>> However, this led to some conditions that can cause improperly
>> initialized memory in the context's list of packfiles.
>>
>> The conditions caring about the preferred pack name or the incremental
>> flag are currently necessary to load a packfile. But the context is
>> still being populated with pack_info structs based on the packfile array
>> for the existing multi-pack-index even if prepare_midx_pack() isn't
>> called.
> 
> Thanks for looking at this one. On the surface this looks not great, but
> I am having a hard time coming up with a smaller test case that
> exercises this behavior.
> 
> I can get what you wrote below to fail on my machine pretty reliable
> when building with SANITIZE=address (even without --stress). All of the
> spots that read from the pack_info array and access the actual
> packed_git structs are guarded by either writing a MIDX bitmap or having
> a non-empty preferred pack.

I'm glad you're able to reproduce it. My --stress runs had about a
50% hit rate.

>> Add a new test that breaks under --stress when compiled with
>> SANITIZE=address. The chosen number of 100 packfiles was selected to get
>> the --stress output to fail about 50% of the time, while 50 packfiles
>> could not get a failure in most --stress runs. This test has a very
>> minor check at the end confirming only one packfile remaining. The
>> failing nature of this test actually relies on auto-GC cleaning up some
>> packfiles during the creation of the commits, as tests setting gc.auto
>> to zero make the packfile count match the number of added commits but
>> also avoids hitting the memory issue.
> 
> Hmm. Is this portion of the commit message out-of-date? I can't see the
> check you're referring to that ensures there is only one pack remaining,
> nor can I see the spot where we disable gc.auto.

You're right. When I added more robustness around the packfile count
by removing gc.auto, the test stopped failing pre-fix. Then, I forgot
to remove mention of those test updates.

>> The test case is marked as EXPENSIVE not only because of the number of
>> packfiles it creates, but because some CI environments were reporting
>> errors during the test that I could not reproduce, specifically around
>> being unable to open the packfiles or their pack-indexes.
>>
>> When it fails under SANITIZE=address, it provides the following error:
>>
>> AddressSanitizer:DEADLYSIGNAL
>> =================================================================
>> ==3263517==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000027
>> ==3263517==The signal is caused by a READ memory access.
>> ==3263517==Hint: address points to the zero page.
>>      #0 0x562d5d82d1fb in close_pack_windows packfile.c:299
>>      #1 0x562d5d82d3ab in close_pack packfile.c:354
>>      #2 0x562d5d7bfdb4 in write_midx_internal midx-write.c:1490
>>      #3 0x562d5d7c7aec in midx_repack midx-write.c:1795
>>      #4 0x562d5d46fff6 in cmd_multi_pack_index builtin/multi-pack-index.c:305
>>      ...
>>
>> This failure stack trace is disconnected from the real fix because it
> 
> s/it// ?

Thanks.

>> the bad pointers are accessed later when closing the packfiles from the
>> context.
>>
>> There are a few different aspects to this fix that are worth noting:
>>
>>   1. We return to the previous behavior of fill_packs_from_midx to not
>>      rely on the incremental flag or existence of a preferred pack.
>>
>>   2. The behavior to scan all layers of an incremental midx is kept, so
>>      this is not a full revert of the change.
>>
>>   3. We skip allocating more room in the pack_info array if the pack
>>      fails prepare_midx_pack().
>>
>>   4. The method has always returned 0 for success and 1 for failure, but
>>      the condition checking for error added a check for a negative result
>>      for failure, so that is now updated.
> 
> Oops ;-).
> 
>>   5. The call to open_pack_index() is removed, but this is needed later
>>      in the case of a preferred pack. That call is moved to immediately
>>      before its result is needed (checking for the object count).
> 
> I think we need to do this in at least one other spot, but see below.

Interesting!

>> +			if (prepare_midx_pack(ctx->repo, m,
>> +					      m->num_packs_in_base + i)) {
>> +				error(_("could not load pack"));
>> +				return 1;
> 
> Looks good, though I agree with Junio's comment in his separate reply
> that we could probably just turn this into "return error(...)" while
> we're at it.

Can do.

>> @@ -1223,6 +1204,11 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>>
>>   	if (ctx.preferred_pack_idx > -1) {
>>   		struct packed_git *preferred = ctx.info[ctx.preferred_pack_idx].p;
>> +
>> +		if (open_pack_index(preferred))
>> +			die(_("failed to open preferred pack %s"),
>> +			    ctx.info[ctx.preferred_pack_idx].pack_name);
> 
> This makes sense, but I think we need to apply similar treatment in the
> "else if" arm of the if-statement immediately above this one too. That
> portion of the code handles the case where we're writing a MIDX bitmap
> but didn't provide a preferred pack.
> 
> When that's the case, we loop through to try and find the oldest pack
> that contains at least one object. If we don't call open_pack_index()
> all of those ->num_objects fields will still be zero'd, so we'll only
> find the oldest pack.
> 
> That may actually produce wrong behavior if we have duplicate objects
> that aren't uniformly resolved in favor of the earliest pack in lex
> order. I'd have to think about it a little more to be sure, though.

I see. In this case, we need to open_pack_index() before relying on
oldest->num_objects, which only needs to happen for the first pack
and any packfile that wins via mtime preference. It also seems like
we can _warn_ on failures to open packfiles in those cases, since it
isn't fatal if some packfiles fail to open.

Thanks,
-Stolee

