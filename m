Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698E522F
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744512964; cv=none; b=ANyOJduG14xC4vRpNk+FeoVUUdrkPYwfCiFstlMlauUznaQrnAcLw7l1BmBoHWDEF9y1a2MCCkphTawOCgbTbl1RMsabZ7CtFSG772/DKMndCSng8MWS6z572AH5KcOVlc9FGhcO7rRR96fX1DaF/auVbz2HINLpKxiP55VeO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744512964; c=relaxed/simple;
	bh=oxVxr/xbzoZaDZ7bk/GFFDvqrArdZdHbOV5IvWGbf+w=;
	h=Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cWtBkopxCOXueO81WFkVVlqgCLKpyJjoef1Zr2ABtKGHk+HmD3cscEWa95pwNMnnj1PjXU+T3mWOGjMwlfITRp2k6a0uz5y0dIjdSxJsm7kc3wrQZo0ZE4MLPe5Z20+UjsQ4EG5DnUA+jOIc4x0uxi5Pi4MhmuUQLzuR2pAfnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJFM5EDs; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJFM5EDs"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5ba363f1aso445019585a.0
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744512956; x=1745117756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHiPy512NXwgrtMq2BnViY+l0x2Gak7K7/svV94meDg=;
        b=IJFM5EDseBaiVadvEh88AkgCGE8a4ZSNnzp2rI5xwWrRpXPw8H8mc+mdSAkjCy6TKz
         VMeFu3uBLbwDiiLK1HbpThqG+Tov2PXTer0fl0+FyY5xhTm20Dgl/MmnrfmbEEG255DF
         jyZu5/PktP5jup06QOjCSMZuS8iVxLMi1/EwfPSk5GrDjN78m4fuBt1uoyTVIkfbqyrI
         58AFeJMt4splEK+vvQvyKWZYHt2JuEKtXBYjpwER9pA7WhleBPA3I2UtYLnUjqL8rEiI
         f5AjV7N6Q6AAhJIBLY6IKNq/2/L6+vB/2zKx3k8r1mcp4TmXv4SijoCv827EArZi5ro2
         eUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744512956; x=1745117756;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHiPy512NXwgrtMq2BnViY+l0x2Gak7K7/svV94meDg=;
        b=AbD5NbWpzVNBUUIwWJBPeWsT8rTtWW1mCk/Uydv1OPgwc1XbquRP1nv2Fpj//3e3KC
         xSMBI8Yf9q+GoDJFhXlGf9LnED3uvaVIFmiai+eN6oK3PMNtjhgfhc1kwZKJ7PxGlWUg
         PamCuQ45zsB31Px3oSK02MAmlvkGvbrKDyZBj10AmoZkuINhSwGObdKobzC+Cp2pSnSZ
         VoYHLTIAZV07hoi5bIc/Q9WDhfUqRn8RjqAOIefYAWufqFOk7oKXu/uf52oTb6kIxi37
         tzU6DgMIelORaTE3w2sCIwCkGs8BQZ32AvGUrCHO0xUZ835vrD2RmaYZBBHChKkXJjxP
         rdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Fm9+m9PVinkXPpJneLlUL/p/o2O12A16Ocb3SQ3bUbKBiXG9zR8CYMAnMBcOxL328WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpFVhaegl/Gff7jskEeC7l1SpAIeVTx37acJCr9YvoH/rIb/e
	Mx5DmHZ7PEa0hopdPumpu1zkXFIfT8Vq8AkJAJsGMFjMGd8uv0ChdjDnaw==
X-Gm-Gg: ASbGncuB53eZVed9r6o7pmLtavpjPmsAqW9G1IWpyBd5iCY+5k3x0Yupk+qDhCMaHBo
	67esLb1rh1xP6wzWCaXdvXnsL1Qw+cRiuAMQQW/ppm4oECrzuD1vf/slONrz+fDATsG8ncMEAw8
	kRKkglQmLoXMhkEUhoqIZOobTDi3H991ua9iXxhlXs3RoZetz9SWl1fM5Ll08sCr2E8HMUh2Jz6
	NATmkK2CGJgQHgjR9BH7JfvA99ZQf3x1lD0da2MWv/65LkfCCLZNM0oO/IIOESWN/3f0xs2tsfH
	JuCkYrmYXt+469qf8jZSeSk8tILJCQ6x5czNbbTh4i7B9yl+dmV2hQUQp08fSWOLdIQ9R3/Y7dD
	R+t9KSxbFsJWh+Kd7bADAoWOedsohYRGABgQB5ASDLmh3
X-Google-Smtp-Source: AGHT+IGBBVxinsf74+gUgkjBfaniaXI72YP/hK/LruZNIiDgTvGIC3+ripaLitpx1QOc+0M5tZPdwQ==
X-Received: by 2002:a05:620a:c46:b0:7c7:a555:4a11 with SMTP id af79cd13be357-7c7af1d84fbmr1235023385a.44.1744512956223;
        Sat, 12 Apr 2025 19:55:56 -0700 (PDT)
Received: from [192.168.50.110] (modemcable021.80-201-24.mc.videotron.ca. [24.201.80.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2945bsm49322441cf.32.2025.04.12.19.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Apr 2025 19:55:55 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2025, #03; Fri, 11)
From: Philippe Blain <levraiphilippeblain@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmscml2zq.fsf@gitster.g>
 <5a257012-39ff-80af-7d65-029ec250a321@gmail.com>
Message-ID: <4b8dce0b-9159-4793-2da6-ddeb230d333a@gmail.com>
Date: Sat, 12 Apr 2025 22:55:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5a257012-39ff-80af-7d65-029ec250a321@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Le 2025-04-12 à 14:03, Philippe Blain a écrit :
> Hi Junio,
> 
> Le 2025-04-11 à 18:58, Junio C Hamano a écrit :
> 
>> * pb/perf-test-fixes (2025-03-28) 2 commits
>>   (merged to 'next' on 2025-04-08 at a8aaeee41e)
>>  + p9210: fix 'scalar clone' when running from a detached HEAD
>>  + p7821: fix test_perf invocation for prereqs
>>
>>  "make perf" fixes.
>>
>>  Will merge to 'master'.
>>  cf. <Z-pD1puYT87YKAd4@pks.im>
>>  cf. <Z_TAtJ9LEeHo2AQN@pks.im>
>>  source: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
> 
> I actually found a small error in the comment at the top of p7821,
> I'll send a new version with a 3rd commit on top.

v2 is here, the only difference is an additional commit
fixing this comment:

https://lore.kernel.org/git/abd146b7c2a62aaef5c22269cff155387f33fe32.1744481732.git.gitgitgadget@gmail.com/
