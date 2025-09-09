Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067BF21FF3F
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399813; cv=none; b=PBOxVZMuibOSpFQN6qv+3m1d6/XvfnJ8qF25tBTyOBlTQfkxvyfkLzh25clc4cnhwYhhDj1ixvvfyfZKJp1PjCpwMhKudCPnkjDcLyBvHHPIuBuHsHTBGFIJt0FLlzTtaixfq5OLPN9xqQzKbeQwyyCdXzePqPENKtlwlJ72yEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399813; c=relaxed/simple;
	bh=7YqJz9cQAqEDL4FhN7KZd5tntc6+2PN45qo98BAWZqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqqGQEV5Fv5FCWJiLO59rE7945c1CygWA0TfWeRbyMq8X3+bD/KVCx7/NVVV8lu2yDvFs6GbH+DW2iCRdn1g7vBiOoS1RthhjohGftjHCanRu5c5h1miW1S+/3tTSB/r9bJ1B8wAcoLT1egZejXUyXfIYhMzIxpi+Xm+86jucto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQmOAYoZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQmOAYoZ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so3191853a12.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 23:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757399811; x=1758004611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfzM6MG0qe3KfiV27NQLOYSSuZPFYcb7H2ah3bT6e9A=;
        b=cQmOAYoZfRYEFAurDws47FUy8PRMztBcJ8GpEO6J29wfR/8t9QBeqg2G3WpDBNEguN
         v5jaBij3cLp+jysQ/y2wLIMRGEsmvuzA9OFNV+x80PYBlBO9Znf/AuAOaTzlzGbLCN3T
         PBlCLOQ4f8J71ucJkZpbdKnPbTu4XtKU+nmSg15NCKa7uyTxU4shCVNzy6L8zVneP37b
         ckRD5tNhZlgA4nLuMPC1wh5HMxYz/bZ7R50vXzVwBAPYtYG2iGNFM84oQJNB67qDCThx
         7S5h5ROMdF5LTTi1JxqejXER/Rg1BceIO3wmV9aWLfBJZcC774AXdxcbOTRlVJIHR7F8
         xGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757399811; x=1758004611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfzM6MG0qe3KfiV27NQLOYSSuZPFYcb7H2ah3bT6e9A=;
        b=mBwbxEKafxxWt1qhA+jrGp1xeOXP/xxKibYg20As8oxQa46DGzZiIjqeM4hBatsjF9
         xCyZQ+V9quVWPAhzDWaGGnnrJjzMSFP8EfWMzWv51U+WatN39+VpA+CP5vaSdnrN8Sfy
         kSTFvzR4D7V/XIijlc/nLl4s1onM1gIb35o2Iivo05qmcLX6h6dnC1sKZy+9fR7EModS
         RPAoDaRYVsiI2wdi8XFFDZPsO3tRIRX9KKEQiSxqh4vkNvRlqh9O92OZwb0IJSRFC9hH
         fYXJPXeI8znt6xr5d0jFldbtFsstgqoXT8133eWCkA/ADWY6Hw359DWnwJdUjfmHCAO7
         MQcQ==
X-Gm-Message-State: AOJu0Yy1mqNVpNiWPCS6TopWwUPoaiKalAuGP4KHn6gOOxUhhpur2qRz
	xKNiQskTidUTcdBz9zTfhAmDh2dKHb14MOct2RRxjetp/3l8jhx5sHIn
X-Gm-Gg: ASbGncsuuIQIsfqnqzMdDSns6/N4WovMegVGQxfyzAOGytswL1KcknLOIRyzwcddeEz
	1b8MpCVxD+98sofwaz64rqt0n7h/MgJDpgT0guXpQl0MjrcOeCJuduJWMn8tSpm0dPVO4a88xfY
	qt9HoLMR263+T6Iehv2RYhwFYx13KQez8vSHy2qNm4MnvGjSapHHHpCOyeleQ8ppy/oZBm+8z5g
	OmXa8CpkH1CCCB9hiE6rIkvdABMXjVXGTFzw2OkIoDEJ4ogzFTWbnI0cZMQ7WQ1+pz+nwQBUGvJ
	BN0jGBrPgFsRdMwG7p4YDRF10bEDEBn7gzY4jdPfgjmjGPyzmQiS1UioyKj9Ye1DVh07Gi2et4J
	fdr9z6ET5/TvCBiKUf+vPrZKOD8VQa0yPk2F/1otXxqQj94Y8wUwnqSoiENXoTNBztWZvnvFnmS
	L/WZVQ5jYpRQ4nt04x69Z0PLn8WROKZGXNNA==
X-Google-Smtp-Source: AGHT+IG79Zk2O5CoLX7agFCW4huQ0vJhzibDlybD0X+If/C7Z18pVcrEVoLdlZudagJftwF6NGENiA==
X-Received: by 2002:a17:90b:1e4a:b0:32b:6964:1474 with SMTP id 98e67ed59e1d1-32d43f00776mr15870086a91.15.1757399811175;
        Mon, 08 Sep 2025 23:36:51 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:7e97:c01c:f128:b5c5:e0c? ([2406:7400:56:7e97:c01c:f128:b5c5:e0c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da90ee17sm32223210a91.24.2025.09.08.23.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 23:36:50 -0700 (PDT)
Message-ID: <f4025223-a0ac-416f-b489-d42a07acc0b7@gmail.com>
Date: Tue, 9 Sep 2025 12:06:45 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] replay: add --update-refs option
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Toon Claes <toon@iotcl.com>, John Cai <johncai86@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <CAP8UFD2XyqgypPfkQav4Fub0AEwyJjXpvfwMPe-adWyCKRa7fQ@mail.gmail.com>
Content-Language: en-US
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD2XyqgypPfkQav4Fub0AEwyJjXpvfwMPe-adWyCKRa7fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08/09/25 11:37, Christian Couder wrote:
> On Mon, Sep 8, 2025 at 6:36 AM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>> This patch series adds a --update-refs option to git replay. Right now,
>> when you use git replay, you need to pipe its output to git update-ref
>> like this:
>>
>>      git replay --onto main topic1..topic2 | git update-ref --stdin
>>
>> This works fine, but it means running two commands and doesn't give you
>> atomic transactions by default. The new --update-refs option lets you do
>> the ref updates directly:
>>
>>      git replay --update-refs --onto main topic1..topic2
> Thanks for working on this.
>
>> I discussed this feature with Christian Couder earlier, and we agreed that
>> it would be useful for server-side operations where you want atomic updates.
> Yeah, right. This is something the Git team at GitLab has been
> interested in for some time.
>
>> The way it works:
>> - By default, it uses atomic transactions (all refs get updated or none do)
>> - There's a --batch option if you want some updates to succeed even if
>>    others fail
>> - It works with bare repositories, which is important for server operations
>>    like Gitaly
>> - When it succeeds, it doesn't print anything (just like git update-ref
>>    --stdin)
>> - You can't use --update-refs with the existing --update option
> There is no existing --update option. This series also introduces the
> --update option.
You are right that was confusing wording in my cover letter. Both 
--update and --update-refs are new in this series.
>
>> This should help with git replay's goal of being good for server-side
>> operations. It also makes the command simpler to use since you don't need
>> the pipeline anymore, and the atomic behavior is better for reliability.
> I have commented only on the documentation patch for now as I think
> it's better to review the design of the new options first, and the
> documentation looks like a good place for that.
>
> Thanks again.
