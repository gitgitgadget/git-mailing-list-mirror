Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC882BFC8F
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448573; cv=none; b=cuXN1fZc+EdfUiJjxrrDoYChw5LivjyaIqyg4habDmAFAtYAc1liEydS75U4ueQpuGoRsyrCfrjWyzrVnOhMPDQTrMDbVjAYI74NjsUYZKByAJTTdX58wUS6o+XjkFjv56QueLjqn1siDoNpuLtvjVghg2azbcQjEiwswfB1k/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448573; c=relaxed/simple;
	bh=ZdYlKchTIoEGyx8WXGJ4S6EEcP23g98jcCZTnBrrSF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Faf2Qn4VkSntfoo63qM5mfj9RS053yvK3xzrwHAlugSuLfCTpbb9yOBSiNnYYBJeat0sokqaO4PHMkFqk6W3oEmIvXnfCHSU8Sit2nxVSjhqRhStXVA3Ta992vBNYtyvtfYD10nQ9iXV9IUeVoCUTEPGDSawi6O2CPZKYfg6cyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1meYf8V; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1meYf8V"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b550a522a49so1390402a12.2
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759448572; x=1760053372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hh0jI5QCWAa9fKmM1/3UJFYDM4qm6+No9VvBWU654I=;
        b=A1meYf8VPcL/WqH013i4BMCOT1LJQQlYpnBUXYfH6syPrJK7iQzxzwjImXSQeNzWiI
         A5f7TsQcl00WYgpi6oloctOUYRZB6OUb285/v7lpEdGDwRz8uaCABdfggmfvk33welb5
         1lufpdCyZ0KgIDhDaDAyGiv2bUUwM4mE/LKyFUL/Ycl+xg06JzJ80zZVEXjIP7aNX6j6
         lddHwxswlSmrrlnodpv+vbVt2yXGfJhtOKUxrJP8eyOewg7t/m9WF5o5UbwWlfP8jbZC
         eJ6P8EOctijR2yP7VE+LdvyO51T/ZWrTQm0PTQpjCiqCVpxqw5WvHsHXznR9Gm2zmktz
         V3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759448572; x=1760053372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hh0jI5QCWAa9fKmM1/3UJFYDM4qm6+No9VvBWU654I=;
        b=N46ggGyKTopU47FKUKNRj9umnvQoycqEBmn4BQNIyjB4M/zh4cpJvmDiSejha/ZbPY
         lIRIWfOO0ZumO3qdUlSeMFdMZ4iUJFxj8FZPDBXPd1MT/dHWrUh98tUxcQYUWTjDcowX
         nAteXu++eITcSJ9HyTmbwOdmx2MFihDFJSAWsWR/xNyNW1TcPZAv44NvEd98+C67sfkd
         RYD5JmADK1CQCIDCEg13nVjue2PSxXK6ydXQBkJ8cMnIyphibfez38rGODivSQuG5sAv
         vPrO2lRXSyRkG7sar/sdFI/jCQXzjvYBxLJw0Nwcs/LBtd6CKyZRbK5PPiHMpFrQs1lb
         eLDQ==
X-Gm-Message-State: AOJu0Yy6ZQPdCMmqkOfQ9Vlb9fWU9sLPKDX2lUX5JVuVhrULQeBZYF8v
	QoLezNTvg1pxvWO/4EGDX1nG0mAVkxv+dQ8ApqyIy6XUmesC6oMi/1wY
X-Gm-Gg: ASbGnctNNXwz09j25wuDAdjksmXzAqX61RCPW6w7ldsyUjg05/PGPe2N/fUwPBLf7s7
	0l439g4bOh4zkq1lm62RRAaUAcy7tmrLoO7uPj2s0/GRJXKpkfdLaLOMuIjYhgPfL7VAAeqY4fn
	zuZ3ma1LyTq4oqPcqW8ImGDqb61zpMXBmsYlHN4ijJf5CXcSZ//BuD3YYWXWXFrg6qifFaBnDW0
	HbsxllSlaYzb6NrwMjkWwA3EiYygNWYWqD5nLGopmQ+9YJqbyd6juVNfqPEltRzZpryJrmtET+k
	x3HaJTUsHGQxgp7sBMOX01uh3TqSQFAFReRQeqZuDZBEDcGy5Wj4wXFqyO8M3VmJYpwLt+NXbaP
	S8MdA/vdVorUV/ZKD7B9nVy4IoyZFIudMyp6zYc9kNgaTtFGHczQpQ3HC5gIfYPu9n5IxZugztM
	LxJnN0F8Oa7bSyhVj7kjseljEcKjHLHlQ4gU+eT1PTI42hP6Wu8TdWW9/iJsyYEdK2MloAhtsmZ
	pSu/yT1k0ofBUexm8AA5CfetAvDBuOh4w==
X-Google-Smtp-Source: AGHT+IEmxYxxHKqUOurHfYyxwJ8Zu3kbb6vd3fLAw6LOZLEiIl+iCw+DyZdvwZSB5q1roe+3mTDjhQ==
X-Received: by 2002:a17:903:298d:b0:25c:d4b6:f117 with SMTP id d9443c01a7336-28e9a62dd06mr10887605ad.35.1759448571600;
        Thu, 02 Oct 2025 16:42:51 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:b4ff:982c:6a19:d5f4:4acb? ([2406:7400:56:b4ff:982c:6a19:d5f4:4acb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d95bdsm31730525ad.119.2025.10.02.16.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 16:42:51 -0700 (PDT)
Message-ID: <d78578d2-2df1-4e10-89fa-154cdf574fd7@gmail.com>
Date: Fri, 3 Oct 2025 05:12:45 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
 <xmqq7bxdw44y.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqq7bxdw44y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 02/10/25 23:57, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>>    * it provided a natural low-level tool for the suite of hash-object,
>> mktree, commit-tree, mktag, merge-tree, and update-ref, allowing users
>> to have another building block for experimentation and making new
>> tools.
>>
>> I was particularly focused on the last of those items for the intial
>> version at the time, but it should be noted that all three of these
>> are somewhat special cases, and the most common user desire is going
>> to be replaying commits and updating the references at the end.
> Yes.  We could even tweak the stream in the middle with "sed" or
> "grep", I presume? ;-)
>
>> Sure, but it's quite trivial to add, right -- as shown above with the
>> extra "start", "prepare", "commit" directives?
> Very true.
>
> Completely a tangent but, isn't requiring "prepare" at this layer,
> and possibly in the form of ref_transaction_prepare() at the C
> layer, not so ergonomic API design?  Once you "start" a transaction
> and threw a bunch of instruction, "commit" can notice that you are
> in a transaction and should do whatever necessary (including
> whatever "prepare" does).  I am not advocating to simplify the API
> by making end-user/program facing "prepare" a no-op, but just
> wondering why we decided to have "prepare" a so prominent API
> element.


For this patch, I am using the simpler pattern: 
ref_store_transaction_begin()
→ ref_transaction_update() → ref_transaction_commit(). Looking at
builtin/update-ref.c and other code, it seems commit() already handles
whatever prepare does internally when you are not using the explicit stdin
transaction commands.

Should I continue with that pattern, or is there a reason to use prepare()
explicitly even when not doing the stdin command flow?

On the config option you suggested in v1: I will add a config setting so
users can set their preference once. I am thinking either replay.updateRefs
(boolean) or replay.defaultOutput (string: "update"|"commands"). Any
preference on the naming pattern?


>
>> ...
>> Might I suggest a rewrite of the text of the commit message to this point?
> I do think it makes more sense to the reader to know the reasoning
> behind the _current_ design, and what its strengths are.


Thanks Junio. Elijah's rewritten structure is much clearer - I will use it
for v3. It properly explains the trade-offs without the false claims I made
about atomicity.


>
>> =====
>> The git replay command currently outputs update commands that can be
>> piped to update-ref to achieve a rebase, e.g.
>>
>>    git replay --onto main topic1..topic2 | git update-ref --stdin
>>
>> This separation had advantages for three special cases:
>>    * it made testing easy (when state isn't modified from one step to
>> the next, you don't need to make temporary branches or have undo
>> commands, or try to track the changes)
>>    * it provided a natural can-it-rebase-cleanly (and what would it
>> rebase to) capability without automatically updating refs, I guess
>> kind of like a --dry-run
>>    * it provided a natural low-level tool for the suite of hash-object,
>> mktree, commit-tree, mktag, merge-tree, and update-ref, allowing users
>> to have another building block for experimentation and making new
>> tools.
>>
>> However, it should be noted that all three of these are somewhat
>> special cases; users, whether on the client or server side, would
>> almost certainly find it more ergonomical to simply have the updating
>> of refs be the default.  Change the default behavior to update refs
>> directly, and atomically (at least to the extent supported by the refs
>> backend in use).
>> ====
> This reads very well.
>
>> Why is --allow-partial helpful?  You discussed at length why you
>> wanted atomic transactions, but you introduce this option with no
>> rationale and instead just discuss that you implemented it and some
>> design choices once you presuppose that someone wants to use it.
>>
>> Is there a usecase?  I asked for it last time, and suggested
>> discarding the modes without one, but you only discarded one of the
>> extras while leaving this one in.  I'd recommend discarding this one
>> too and just having the two modes -- the output commands that get fed
>> to update-ref, or the automatic transactional update of all or no
>> refs.
> I know there are people who like "best effort", but I too want to
> learn a concrete use case where the "best effort" mode, which
> updates only 3 refs among 30 that were to be updated, would give us
> a better result than "all or none" transaction that fails.


I don't have one. Elijah made the same point - I was trying to anticipate
needs without justification. I am removing --allow-partial from v3, keeping
just the two clear modes: atomic updates (default) or --output-commands
for the traditional pipeline.

Thanks!

