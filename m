Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7684207A
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504224; cv=none; b=heNgQQcu9WhJW3MUzPfxX/bhhQhZ3t3vfZVinvxCrlU4zg5gXEJdHWB71YxuoKvzFgbqtb2f7d+xxhdYifZs0/a2pwUdmtEG9s2Ll7FRuDiLdrdAmLsLuyYgdMbktuMhx4XLtfo3RJQlEBcU9+HQEMM1fWLCcfl0sOVu4RDjmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504224; c=relaxed/simple;
	bh=MsZotBy690FXQFtkhf3ihifa6xwoHlUb3quoIhcbFT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6xg0NAvKeIZ7X3wXJ3P82kJEz6FR0j/CvRamHhuTP/aUObkITGGKCMjG3ukCm8nRVhKb5xiWYFZdXxvkvBFMirb0aEneQsEbQIfLqKJdLAu46o2ycvg4XjepaQljodCLle6Phz9zddk4XF5gRVsyePIkXhqocs3bTltlOXN2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eylFzgf2; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eylFzgf2"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so5874316d6.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785504222; x=1786109022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/QlqqHYWTzqHp4urpn2LfzM74x3pKZxxsjwuYTGN1A=;
        b=eylFzgf2LUGE7DtUVGkqiu8REEwR0zXEUih5spxQvxGq9NZT0TPrm9mDhxMDd1M5F0
         qPKRGLsfbnHWLl7CxxzHp05pvpyztTrB3nvtjZkW85MZY2AfAwy8ookf+JTpJHeIX9al
         H2CyfqTWnN2Q12zCteY/FaVNozdEqaW1tD9UGXtsDbzST+Grf3m5aJjV2iOHEywrTZkd
         6iKpMNce8LzJFv/aRVEFLbUq6u636wJjc/Kny+D9tYCkh0ssbLrA/oUORp0MoPMchpAX
         pm+EH6bTSmlUpCVKmO5Ny7FxnN0/Fsr8rAa3wF4ebPPXGwfjwlTvBc5nTrsjTT9joPmc
         zQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785504222; x=1786109022;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/QlqqHYWTzqHp4urpn2LfzM74x3pKZxxsjwuYTGN1A=;
        b=oXtvXUI6oq78LL3MuF72iWpueWrLEb8FQEym8i5OvtkXwsEonzI9Jb3Njao16DVrM5
         WyS0ruUcpKf825eHS8bKlAXDWBIynGR9iMEmRAqiz5Ata/W8BO1VPKYc/jl+Obk6gHAH
         tvm2/oiisyLEzWARLJtSAJPGONQjQIT6ivQvDMu8kS3+jJHaG2a1CC7Q9NQXgP+rSDEk
         YYmfKLrp7HqitzpF+75m4/j/JKQe7KhZHijn4/p++5FcOW4iVS+LpwlKWFqWOsaAW/i+
         iOBSXp1iyet5cXc1eE4IV7ktN+h3fpWq0hm/HydtuNiFTTF4PzdEjGWDbxeVxkMw/RWY
         r/pg==
X-Gm-Message-State: AOJu0YyoqYmQ86kn2Y393GIkUyVu6ZT3NqusPkkS+ER1vjB9zH1ZudUv
	dhtEWCwKJQiEc6C3ylQn9cCAwzp9IiB9NEtyrdsqAGlSW17iMBtmlyda
X-Gm-Gg: AR+sD11aa2NJh6aSfl+YcAb3vdq5oRYNynCi3NeXPpMa9gRrC5zlcdHDOxSqhfXsvTk
	kFvQXBuyNfobjJz7x/oVO0hRo0rMb870uu5rlWxbknHjpKduYxvpLeGrGBZTgW8fCbFhN1e9Pa6
	wvXx0C+m88os1dmb2s6TyWvt01Xtj+2m+8scYO24CjrmxHYH75zVcM19uB8TcFILqFQ+Vct6Vdi
	cv4bcUhDuTVtXf8MWD0opzjDfW00U+Vqh6ux/+7OTNlfocs9sQex+4w8VCp3BRIY1Raf6c9fOrY
	i54brRQR4wU+X6aUhJ526PNgtBsgy0xrINr7DHkAL04/ZahotuTcE/aA4h1u9J8VlgxzHZNdy5w
	2QZh0TJqrclx6Nxtwm7vMmGZsiXAFBNZEs8T/KXbGgTtPl9+0G/EMtuXbd+EnHRhqlHgsxqAphg
	jXlwad0uf7dLkTpGhZCjKk1m4cWlQi8XFZFodfl970XZEAJcwS+hrOUF1Zve9jR8oLGotid+oQx
	yWTgnZe4BWRf/RCIiUGoXGV/NbLrKMebF4pixZBncYs8b+NQS9mlXLoCMcO4SIFmRI4K9OxnKiT
	CsE68/m31EeMFZM=
X-Received: by 2002:a05:622a:1353:b0:51b:fc67:c738 with SMTP id d75a77b69052e-52b56791b53mr301841cf.29.1785504222365;
        Fri, 31 Jul 2026 06:23:42 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4eb6d94bsm7627041cf.14.2026.07.31.06.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 06:23:41 -0700 (PDT)
Message-ID: <e4cce4e2-4287-4e1a-8833-d37ee48ff7d6@gmail.com>
Date: Fri, 31 Jul 2026 09:23:41 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparse-index: avoid crash on intent-to-add entry outside
 the cone
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2167.git.1783345853272.gitgitgadget@gmail.com>
 <xmqq33x1o465.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq33x1o465.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/2026 5:51 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> When collapsing a full index to a sparse index, the recursive
>> convert_to_sparse_rec() walks the cache tree to determine if any
>> of the cache tree entries can be used to represent a sparse directory.
>>
>> As it goes, the method tracks how many cache entries are being represented
>> by the cache tree entry. The cache tree node's 'entry_count' represents how
>> many cache entries are covered by the node.
>>
>> However, this value can be negative, representing that a node is invalid,
>> and is no longer reflecting the number of cache entries fit within. This can
>> happen when the user uses 'git add --intent-to-add' to mark an untracked
>> file with the intent-to-add bit to avoid committing without finishing the
>> add.
> 
> Yes.  If the code were not anticipating this, I can understand how a
> bug can arise ;-)
> 
>> Theoretically, we could scan to find the range of entries that match this
>> directory and determine if they truly do have an intent-to-add bit and then
>> collapse as many child trees as possible (the ones with valid cache tree
>> nodes). That would be a non-trivial change for performance-only benefit.
>> Since this combination of the intent-to-add and sparse index features has so
>> far gone undetected by real users, this scenario is unlikely to be worth
>> such a change.
> 
> I tend to agree.  That does sound nasty.

>> +		span = ct->down[pos]->cache_tree->entry_count;
>> +		if (span < 0) {
>> +			/* cache-tree entry is invalidated, cannot collapse. */
>> +			istate->cache[num_converted++] = ce;
>> +			i++;
>> +			continue;
>> +		}
> 
> OK.  That is an easy and safe cop-out that is much better than segfaulting.
> 
> Shall we mark the topic for 'next'?
Thanks for taking a look. yes, this should be a pretty safe change that
can merge.

Thanks,
-Stolee

