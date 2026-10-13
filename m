Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701F53161B
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906584; cv=none; b=PM7uelZPoKoYk7g0X3PcxDEBXRvdIF7SqWnjwpEdSWsg7XJLvTM/nEDw36wftptif0uDKE4gIyXbWPeTsrISqTtiKdV/DfBzUeb/mROJRXDmGc6Z4rKkWZFWsb+Yud52ncy792646/g6Fq2sFL3NZ18ANaP33N0l6WcQrzqpEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906584; c=relaxed/simple;
	bh=BlJ+qOOpg8srPF3a3sSNSOPl7OQYEv3HRJCiLhq3j2I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ojN2HXjY/hff/E9drtoUQgL7/kjN4CBMjH7/cHu66dYhpsRvgcY+2VBWhPzwN2u56EWLib43uS66N/IwOtTdFk0VhBA0PN0tXqXIO+hIcjGJpaMTQuPQIMyRH0KSDLhGwJ+8ynbwBv9kz2WTJFewWbpH4NgKhm2wskVSD4kyxyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ+N5dD2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ+N5dD2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so724275e9.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791906581; x=1792511381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NnIOjYMirdbn2pzOdPNzeGrE2JewTea6qdRAa9HhXzI=;
        b=IQ+N5dD2/7DDP+C9FC9eBPwCCsiY/0JLYJlLtJZ6E4wFQRadqe9krqfSdOTCf4ZOA7
         h67FenCkzYkbidjEX5hTOMn2EgOonw2NpquzPZw0ZnthNVGF2yeDO7tQaPGiTuNABVdf
         YX07lCtdNLuMcix1FnzvfJARak16hDEblHsL/RgkPs8fVvCZdMscFSRMivERnIb/4RVY
         M70GW6D5W+JJR0v/7VF+Og0gsewpSOJRf2UYKDGUH6vUVtG+fn+dOjnWDOFuUpmPaNWw
         wyY3gddELnNzcKHfzlru0eu+WuvTBPh+gbBdKQbDsvH/odUBxKr/ukP5fwFFPtnLVlOw
         Vlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906581; x=1792511381;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NnIOjYMirdbn2pzOdPNzeGrE2JewTea6qdRAa9HhXzI=;
        b=AegwCxd+5RC1YpOBTjMlD3rwQW17q2Y3S1AGxmStC1zwTqSwhA/tHNGwT4YshY2JMe
         3uvbGBm6xuAiN5dEdvR/tx/dfNuhBero0z3WYZwozdxONXoWavb8GFSeuz4HwCI2ogKG
         lis1TbKQLcH8Kf8hqEumkQKQ/sK3StqnslpaIo2WIiJH4JBBh34hhgsbSv6BqVoEU3GA
         tVkd7U06J/ZO+7ot/pfwA/Onkg3iAX5EA1/BueXg9ykWpN8kTGloHDTog7/pHRGcUPDv
         noc/EMNsQQHT3G7RmehhkKDhFbCO0DmV+mGAFGr31U8fUyotlxEqQfYJV0Qp6EkceYI8
         xQSg==
X-Gm-Message-State: AFq9FYJHRe8OpTu0BZ4gP9u8Erl/MZNrh+3mctArqg9V33vjoYuG3XDZ
	Mfk2SCwxDbwNL0jAX9M5jR//gQp4ZcTJKZ7VutRDOFMXiJPGsPxGJSAXEMY7gQ==
X-Gm-Gg: AYBFou3AH2VIorH/o0Iy79fWbY9RAxWao4jSvrxFrHS1oRaZYZeS0U76xnfl1wjXbx5
	7XRKlO1ebvLRW3I8vhlNTn4oRPcIffEsK9ZlU80CpVg6DzLGcbaRyPL9H3F+alnJfRwjlGLdeYt
	NUGPzzz/b0+n7BsrnFJR7d7tUwqW+X0U6A5LpljKrRjeZRWnCtSgbc2UwTVFD0m5yK9MSS79mg3
	Sq5MIYEixs5f4BgYgfdyFaFfjIpucyiOL32ZAEVUAIkRazHnPgMP1nJrreztBU5bNLBab2YaoL0
	7cd7M7afZGMO6cLKXeYQukmBKbSBgeBgekRp6bMMzPlkoa3mYvx4wr5fy8pDZfkm9Johik3nm+D
	7HI2x/CQ/jPh2aqFBxnHVSa0WkTt48drw1M4euQaOnr3i/ZQLzUMs+8sSjGj0WU4Rufkoqx4/nJ
	dVctnxmM6MliY2rPbvzHvAo0buxOa7pyYH/YWMY1HxodR1JQ/y+lKtSHJ6FmsO4z7loXp9fUhYZ
	7bCo7IeigoIhuhi7M+rA8nSe78mEqSc96k4a/Xa5jjIWWa6kF0KQg==
X-Received: by 2002:a05:600c:3e87:b0:4a0:a34:6e7d with SMTP id 5b1f17b1804b1-4a18e4bacbfmr236268365e9.18.1791906580916;
        Tue, 13 Oct 2026 08:49:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa9f9sm6080003f8f.19.2026.10.13.08.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 08:49:40 -0700 (PDT)
Message-ID: <0e8e5042-9b0c-447f-a320-a3d58d364282@gmail.com>
Date: Tue, 13 Oct 2026 16:49:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] merge: remember conflict labels
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Johannes Sixt <j6t@kdbg.org>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
 <cover.1791537203.git.phillip.wood@dunelm.org.uk>
 <182edb2e8874986206a38a0af005e4df9ef9dd8f.1791537203.git.phillip.wood@dunelm.org.uk>
 <xmqq1p9yjtcp.fsf@gitster.g> <9ac1a744-b326-4b61-869a-546fee80da20@gmail.com>
 <xmqqld839cr2.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqld839cr2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/2026 16:09, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 10/10/2026 01:24, Junio C Hamano wrote:
>>>
>>> This function is called once for each conflicted path, which means
>>> we would read the "merge.renormalize" configuration variable and the
>>> MERGE_LABELS file, both of which will stay constant during a single
>>> conflicted "checkout -m".  The issue is shared with the original,
>>> but looking up the same configuration variable repeatedly would be
>>> helped with in-core configset cache.  Compared to that, the overhead
>>> added by this patch is to open the same unchanging file, read & parse,
>>> allocate and deallocate.
>>>
>>> Perhaps we want to have another preliminary [PATCH 1.5/2] before
>>> this step to allow setting these "per invocation constants" once to
>>> be reused?  Then step [PATCH 2/2] can read labels in the prepare
>>> phace just once, use it from the data structure in
>>> checkout_merged(), and free them in release phase when we are done.
>>
>> That's a good idea, I'll re-roll using the diff below (I assume you're
>> happy for me to add your sign off?)
> 
> You assumed correctly, but if you ask me, I would say that it
> probably does not count much as coauthorship than a mere helped-by.

As the new patch is a very lightly edited version of your diff I've made 
you the author.

Thanks

Phillip

