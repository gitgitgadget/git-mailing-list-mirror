Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B6145560E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297242; cv=none; b=nGy7J9fuzzDo4ksfS9cuBU2P3oO8w2KlCxpBcfnQc96GQ8R9nyvDJjMiWhLQx+2tzxZoxYyitt3wPcJJyj+pDYmWvHmTFCpa3zS1YVdFXkVE90ZOc25J9C3GnwpMyYA2qrl/1xMI4WYl/pS6qBpfn9nsSHV4qYQvaS3s/da4KLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297242; c=relaxed/simple;
	bh=4K0Yn1F7G5llEAgsDva3Vu9cSy/2sajKMzgYdaRq+PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsDtLZKRHlrpb2Ar7DjspHMM37KEDMTUrKKh55XOLRssJkjOBlm02tM2EoSy1bBzWJ/OjQF65OMaCUlu2HuDHQ0909AajW2PL+e9WM4meFAWW7+3F0KttqELSrWqsGUuq7n84nGEaGARAxVAUgZ3MNL5g7KjvFJeLctxWdno5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/Tq8MEW; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/Tq8MEW"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5c5f23666d0so730641e0c.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791297240; x=1791902040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elYkTaAJzH83Jl0Z52101ApL1lwuRr/i8Wn240fUVNc=;
        b=O/Tq8MEWI4nI8UHeTzfl8UPHt9ISTZGK1B/J2H1+eK8ogigOTZHfsWEASuE+nRq55j
         +lp96eoMdN/uwB6BtGqlx19pP4wOADgcCSiCW861JkGHwiqLOO/AfwdKRYWMNa4mIhmW
         MC0Wo873GoDxg6KGAhIWFRizcCeu0hAiqZQN/yccHDvJ8TyqzuR5R/7d31cC08XocXTM
         Ym5JiWV7f09pTNcottD5acMV95q9jWCg/aW9A9UMZSxvWrmbwO8cMq8029Sf6X3PzjOR
         wZEmikLCQVKsRgp1ASQo2f1ip5ooDcZGQhpS1z1bfPQLzlE5wZcNH6zLQNxg2SkTxb06
         +8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791297240; x=1791902040;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=elYkTaAJzH83Jl0Z52101ApL1lwuRr/i8Wn240fUVNc=;
        b=SKvxAkUi6gSxJB4Ih2ZAOIWcIS7QiQuANM5eHVS1asZ0DYSXDJ3XOh2HDAwDLygevT
         ImWsm21qaPT32dB50xDjlvZITSiqXI1yiCvMjMp5pApTya3cHdac0eiJq237rDwa47dk
         BMp4OuuTi+GWw4mimljpzy/TLalISPUh0yMFylk82WoA1ioZslggyx96af/PY8FrfkYn
         jiSOpTVK+lQ3lyC8RECC++BJz32YZfZ+ipMLGjM23Fl8fr498k2HYP38BBLtnlGulk/8
         Zn/ZyMpbgV26Gw6osGK8V0pvgTE/bVc/v/yE4wjtCEyMzV3GvNFuh1wHwSjIZ3/xQWaV
         iyrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnGRD9L3WgD3DWc6Q6XLHTlTfoPkxhBcPaP9UENW7+ACxHgla2wk9od+5q9re7Zf+eE9w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlVeDYRhwILlU3rlVKbQW2Lb8FztZn588CzqhQsNU4MHu0WtXJ
	kYTYW75utcgmvxN5rneJ+QkUAiHPjuGsqcTl6ybsBc5CAJo4Ke7JQlS7fI0tVA==
X-Gm-Gg: AYBFou3dgYpRByFRI3ABAPXp6cxT7e3wdsYbB/sQ/E/F2AT2/xvhKZPdIpi7tb3J9vu
	FMl/og9rYOMWoxrWFhdK8/ZoPR3qig5aonFvy5sjjThs+Ev3BKAWk49NTcyEoFd1Lp2Iw5g/kjS
	7cacRCpOizbybxzbALfwosJmnhj5CyRH528bgJW/55cN+nlrHyf80Bh9dmpqPd2Dyn2t8Vniyk6
	GfXFCmq+Y9TGG+FgXcI7EnfBf2qneaNTwdMIvdTQDsT9mmbLXpFXxw/+i2/wO1MAn52T8mfNVxZ
	zda1scQ9sLt2G7Fqjvw0WO87aMypjBg0ie9BEPQbsUJzhCFP3J48ihLWt2Xn6heJ4LYpIvqs2+7
	CJGVR9GxUxjQzTffhHLRSJ4mk3FvsbsUJ6qEOiEU/FkNiFxHRxS3lGNZsiHphUDqk60lLdWhLxo
	E6F9GqOf2KOxi7+ocmufPbzN7Xx773iADHLFRqP9G5Qno9LQXDcIpRf6f2R7erIo4d5Uo7+3Yrz
	Ec6XXgT9UYrfApVLKZeHZsrz3It6q6I5wCR72O0qHsCvVlJaeqJ6IZo4Vr3UCWRSJZ5Hcuay3Zo
	qr65bBmreElukn/3dOeC27FhZexoFBTwuKkZx9LS5PHyDAkYzhKwAJP0wTJd6BncSTL3dfw7v8v
	g9Q44wpTYuUHk6Qqx1BTzudyZZQ==
X-Received: by 2002:a05:6122:1354:b0:5c8:c5f:e8fa with SMTP id 71dfb90a1353d-5e5c40129e3mr609584e0c.4.1791297239243;
        Tue, 06 Oct 2026 07:33:59 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e54c7a015csm2695952e0c.1.2026.10.06.07.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 07:33:58 -0700 (PDT)
Message-ID: <0f466dc6-f9c5-48ee-bb94-f3e8a951ee5d@gmail.com>
Date: Tue, 6 Oct 2026 10:33:57 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] [RFC] Create a 'safe' strbuf API
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
 <9adb1d94-c72b-43f2-aa02-004e3e476eb1@gmail.com>
 <20260923194628.GA44327@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260923194628.GA44327@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/2026 3:46 PM, Jeff King wrote:
> On Sat, Sep 19, 2026 at 04:23:41PM +0100, Phillip Wood wrote:
> 
>>> The goal of this short RFC, such as it is, is to get some feedback on
>>> whether this is a worthwhile direction to pursue or if I should abandon this
>>> idea of having this definition of "safe" for some APIs. This decision may
>>> also determine if we should abandon ds/trace2-tolerate-failed-timestamps or
>>> leave the existing behavior as-is.

> Yeah, I don't love the term "safe" here for two reasons:
...> So what I had imagined when seeing the initial subject lines was not
> strbufs who report malloc errors, but rather strbuf-like functions that
> operate on a fixed-size buffer (with either a static max-size like 4k,
> or perhaps a per-variable max-size recorded in the struct).
> 
> You can still run into errors, of course; we might run out of room in
> the buffer. But we'd see those cases deterministically for a given
> input, rather than occasionally when races or other external factors
> cause malloc to unexpectedly fail.
> 
>> For the strbuf API having to check for failure on every function call does
>> not sound attractive, I think having a sticky error bit like the stdio
>> functions so that one can build a string and check there have been no
>> failures once just before using it would be a nicer approach.
> 
> Agreed. I think that is a good approach for the static_strbuf idea
> above, too.
Thanks for taking the time to consider the RFC. Sorry I'm so late in
responding, but I find your feedback insightful. It requires starting
over on this direction, but I don't currently have time to do so.
Maybe I'll give this a try again in the future, but I'll set it down
for now.

Thanks,
-Stolee

