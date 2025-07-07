Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DEFEEDE
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901300; cv=none; b=BSJBmAMgVT6J+jIg0EzsCF7gQy2UEtpwlDfo3QHfeqaUqvEjg+1OgrAne8LVkun0q1VWoogxrunn8wkjBU3KVGcg+j+nNUKBEPvWK3BWAur8xIa9M+ym8qs+fzW1n595PwnHoJvxtWoSutNDTcAmSrY8fie2nW8CWQXBU0cE/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901300; c=relaxed/simple;
	bh=HfoMwyPE36eKHPZnIZC30FL6jT8cZjMMKEgTAyLaq34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rd6FWesF5ZCEd2gQ2hx7DX6ROPlGzajJr3pJL2vpHmoOHrCR6t1VFmFVk8OTRtqVwGkZJvHubMUkhHKoyYJz9od++fvkvKXcyED2ZGeSVOMeawX2fJDNAQeFlMG3lhwnWdjKIuf5E2Ww7MIpvkJpC7g/V0SfF33WsmNJC6/laUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PubYpaXI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PubYpaXI"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31329098ae8so2507654a91.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751901297; x=1752506097; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKEN9z1hSsIdkL+f9/tKXqzhTciwe0x6vVM20I8+Fy0=;
        b=PubYpaXITcTjgbMKxVXAM0xHazXtpydrETqZkWVmn9yLGHTrhXpIakThABZFuR1/Vy
         3oJSMBVO5EiY7uKJMfGEsYRp/aKRhX6oQupjiTkuhn0e/vIap/XB+5Anh3oVMaK8eoLh
         Ab8agJtRcZ96Lfhw8YnUK3jGiKvpPqfYFRP3P23jBAatzDrF3ufD9Vs5/roY5pEmsg/I
         yHKOl/NXYsDbKkKI6cPzBp4Dj9ycWvQTJmypOjlskj+DSgm6xGkohq6rhg91WKckOY+0
         GrsxLNzKc57/HpEWUWor7xf1Z3nQjAvG+ysOJfl7J5+6G74ss+t4rKzg3Ydn+UjR1KJY
         ARnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751901297; x=1752506097;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BKEN9z1hSsIdkL+f9/tKXqzhTciwe0x6vVM20I8+Fy0=;
        b=PLU2XZqU3Aq7kFwg9SppYO5jSXWjpaiN2Z0hmLwg+QzvknoLFke1MSAU1si1xwVeuO
         VesbMBcx9EzOaZN12pSvkTWzDiKjLOO+9kvvSCq+Su7/k87QGYiJ3O+7muTyu6J64jEo
         JW7g+bXxHCQfqhk6jATXjrk32zozdRr5ObrRfddWDJIun/PO/C6lWBC7089j46E+nu12
         nEiyYsiKcmfdZTBWSiedoIND2v7MrjSZSu4IgG1zcNO+h/fSfQNqxtaL02yMXPWmvNHM
         rd6WrsAsqVYS/4fsgVYTBDr0zp070YN4Y4Nk1jfCogUmdVkjHThBj2Ed4/a7Urephdjx
         LjMw==
X-Forwarded-Encrypted: i=1; AJvYcCVCRbu7c61Chd5qMdRQw+WvAFdKSrIOb3VJHsHph3Ir/h9x7vxdywdNttalKP8D6QEbK54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6G8p9qqklFhiBEKVhDQwkqZ4unixZWQq8VdcHLVALFp8vW9C
	XD/VknZo9xva0IWV8zcX7f1vfAICqWIGe9/0m6sa9WwXT4gwBEG+m4L5
X-Gm-Gg: ASbGncs/uqFQqXvPwMinL4qq6nGT+fR8GyE1YcMFTBNG7WCHDXZo6SQx8u+vc9EUnF3
	leNbH37Pxu0kaVp/tdsy53zte8wuhG21/Gl68Ef+vJVVzGZs+avcuuLVizjkKvfOVi6UqKR+oam
	OoXCZCj8Zx97ogy9Zk1s2HLNICxhP3ydvAP6POeUuv4r19j9SeffHpUzgA19+ymM1mmVgYz6/Mc
	qyTkqXzrHlyhmCgZ5eoYYO/jX0AUtmJH9ljPRqztP024nvQjJBksK2z0nhziMgXT5ZUerlouBo+
	jsqsT6zbxLxR0D8+hVg7XvwduFRg/kQQTgV2BHOoJieoRWGzxQaIo+nWAqDTL2fXT685c4n7LHG
	1nkZbu8pzoHKGvktPTgt3ZdOHJfEdzN4SlAIgHQ==
X-Google-Smtp-Source: AGHT+IFd5eW3JoYtxrH3lRyKToHW+Upc8viLmVmdj2qlwdEOWQIsMdKMnA8rAEtC8iRUeUI/EcbYvw==
X-Received: by 2002:a17:90b:3c88:b0:312:e73e:cded with SMTP id 98e67ed59e1d1-31aab05a639mr18348635a91.16.1751901297203;
        Mon, 07 Jul 2025 08:14:57 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8419269dsm88753155ad.0.2025.07.07.08.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:14:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  502024330056@smail.nju.edu.cn,
  git@vger.kernel.org
Subject: Re: [PATCH v4 4/4] bloom: optimize multiple pathspec items in
 revision traversal
In-Reply-To: <ea144a72-0975-4ac9-b2e4-ae0f7fcb6837@gmail.com> (Derrick
	Stolee's message of "Mon, 7 Jul 2025 07:43:19 -0400")
References: <20250628042140.1097910-1-502024330056@smail.nju.edu.cn>
	<20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
	<20250704111437.2660251-5-502024330056@smail.nju.edu.cn>
	<ea144a72-0975-4ac9-b2e4-ae0f7fcb6837@gmail.com>
Date: Mon, 07 Jul 2025 08:14:56 -0700
Message-ID: <xmqqikk458y7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 7/4/2025 7:14 AM, Lidong Yan wrote:
>> To enable optimize multiple pathspec items in revision traversal,
>> return 0 if all pathspec item is literal in forbid_bloom_filters().
>> Add code to initialize and check each pathspec item's bloom_keyvec.
>> 
>> Add new function release_revisions_bloom_keyvecs() to free all bloom
>> keyvec owned by rev_info.
>> 
>> Add new test cases in t/t4216-log-bloom.sh to ensure
>>   - consistent results between the optimization for multiple pathspec
>>     items using bloom filter and the case without bloom filter
>>     optimization.
>>   - does not use bloom filter if any pathspec item is not literal.
>
> This would be a great time to add some performance statistics when
> using this feature with multiple pathspecs on some standard repos (git
> and the Linux kernel repo are two good examples).
>
> We don't have a great performance script for this, since each test
> repo will have different paths to use for comparisons, but you can
> use 'hyperfine' to assemble your own comparisons before and after
> this change and report them here (and in your cover letter). 

Excellent suggestion.  Very much appreciated.

> The size of this diff is unfortunate. I wonder if there could first
> be an extraction of this logic to operate on a single pathspec and
> bloom_keyvec in a way that would be an obvious code move, then this
> patch could call that method in a loop now that we have an array of
> bloom_keyvecs.
>
> I think it would make a cleaner patch and a cleaner final result.

Hmph.  Didn't think of that extra "preliminary clean-up" step
myself, but I think you have a point.  That would likely make
the resulting series easier to follow.

Thanks.
