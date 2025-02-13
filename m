Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848C520D508
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439794; cv=none; b=hqqul5A7QfG5/5Cr7xMG2DGUb65YN68A/874bB7t0K4rKmEotqKwFhnU5vFRIthK75b3JsX94qHhOgZuGVNtwzt+g65N+odfEeZ/c0dgJRbzcby2aw0Bqz/8Ow2MvwhTxUCGIqbiLcDC9Cl6aHUDfxQt2JFuvXeLh4bqMfDHHUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439794; c=relaxed/simple;
	bh=e0ttb8ObuWt7YobOWpnTA/NcHJFH1gW+jie0Z/ilrKo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oLfLZD3E/Sh+3De72NKk+VntedT9lXMrYNr7LXm+F2Hdg1x3qaUq5i6/0BTFeEJKHxPrST4R3cxqjQLYZqENAkp7n8J2uVlU9XzbMqfQ/2wzlQVb+IhrVDrylES9lqTLM6gHTq8Tyjvc4oVD6fYV2Fo74KV4uQRcbMM5XnECqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irQOviD2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irQOviD2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4395b367329so3880045e9.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739439791; x=1740044591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/ZbD0D7lGrjlwC5yLmDwpnGCbwZTgSLasixoue7TLM=;
        b=irQOviD2oJWleH8UMa0CpDyhnfOEjotNcID68h62+5aHoNOUgpVbvWPMFB6eyYHoKy
         R3R3CcBccxLUAZrlNBBC0eQSPihgALXoaFKTzcPQFnc6Ip53sK0TPX22NR9LgvUBmlWs
         6EtXE/6jAZ4xhwP4laz5eNVOlQWV/iVYcn2P1UchsWX9zQOK70ojW3ss3wTA4yKH/nXn
         z7HRqbu75NQ4Wx3TMTbkTcXQ3798i07Z7T1fbgE5yBxAZHzgA4BEDXPAGkiTTz+q0Z6w
         jBpFFq7mPf/p0QP+vgzd9HV79SRZO90S4akQO+Us4XMPuHzF8dGuQMUAECJVT4DdD2mU
         8hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739439791; x=1740044591;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/ZbD0D7lGrjlwC5yLmDwpnGCbwZTgSLasixoue7TLM=;
        b=lI+/AhvDjVyL1fk/9J8FG9GOWCpWUosMc2h1iS7/7qJnOBWTVsXXLs+0lSPUNW9AX3
         EuzCFIvtqDz3hsJuQVFzx8A0xrefUJcyxPh2QQ4YXcfnke/vFNDYT/BzLYr4PGnoqXSa
         7uzeFcBOZFAHJMRT1h2azZQxWLfoR1iDkdiigJAsEbadlfezLUbxheM3nlgpNEuhXMmO
         1YiWieBop9mRHocW0/hz9K/sEwLAkCbCd4K347K8MWm5ADpdvKmjEKDTXoGTXckc6KeS
         kIbnkB84aIs3MkFu4gdqQ/Om6Vnqf6qG7e/HeCCe+xNs8obadBRBvMUbzSm3l9EXewgw
         tBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBh9ItqO3CWnDDsFxfYebGiJWh+TSjaOAp5Zrulnc2VvgfTYwXYGeB6xie4haVJdn5d7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXz6kKKgssu6DVFOeO2GXWaxqOwoJDOjhws8WHQsnSve7Voys
	yQa8JD5skijngVK2UbtftXUkTyIvaadm7IeX6ZkB0o69FzO7QS/1
X-Gm-Gg: ASbGncuQkcMl3IUB1QoJMXQmE0evx54BwhfAxZuhHYi7sjUuzpEW6v3hJB/IvcoGvC5
	r3jETVInaCdLdtmqKplt88LBpM/Ll1c04C0XpobOKDvUJDYwlhQLi2Z84I/3d5ftD76EHJPbk5A
	pdjtLJfZyAdHC/LilYxUXj+UNtiD9oINvjJeZU74sNa2BBFCQFKyz8pLdLuoMU5HKc5pvp3fl9l
	fxtXTPRdpinOXk8V2XWhwXIs6HnhvZAEelWX50qIhz44NbDkWsKBCwz6nn8u0gBgpjOVDCVoca8
	gM1AHAPD/GlWOCQ+CvnovWqko7fLTowaoFTfeJxrepjmdEwdOSD6n5VtlTsSYpRIx6t2FA==
X-Google-Smtp-Source: AGHT+IETmwAsLm0ChCEcCi81DnffuL/KSmjjDZg4G4UmyhQcvBEXAOHLBOJqgqh+kVvPgBA9W5RRPg==
X-Received: by 2002:a05:600c:698d:b0:439:574c:bf76 with SMTP id 5b1f17b1804b1-43960179b7amr33153135e9.7.1739439790468;
        Thu, 13 Feb 2025 01:43:10 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396180f231sm12311865e9.16.2025.02.13.01.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:43:10 -0800 (PST)
Message-ID: <8a259585-97f7-4756-a126-17a982da58d7@gmail.com>
Date: Thu, 13 Feb 2025 09:43:07 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
To: Ivan Shapovalov <intelfx@intelfx.name>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Alex Henrie <alexhenrie24@gmail.com>
References: <20250210191650.316329-1-intelfx@intelfx.name>
 <1279671f-4063-4347-b153-9f6ff079bd77@gmail.com>
 <f689c263ead8104ec42f63f1e9ed10350a27ae1d.camel@intelfx.name>
 <5b605c3e-ef6a-433a-9637-1e8f277dfde9@gmail.com>
 <f0fa961084281b1d5948f59c42cf0c87e731d9bc.camel@intelfx.name>
Content-Language: en-US
In-Reply-To: <f0fa961084281b1d5948f59c42cf0c87e731d9bc.camel@intelfx.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ivan

On 12/02/2025 17:18, Ivan Shapovalov wrote:
> On 2025-02-12 at 14:26 +0000, Phillip Wood wrote:
>>
>> Thanks for the explanation. So this is about copying a branch and then
>> rebasing the copy without updating the original. A while ago there was a
>> discussion[1] about excluding branches that match HEAD from
>> "--update-refs". Maybe we should revisit that with a view to adding a
>> config setting that excludes copies of the current branch from
>> "--update-refs".
> 
> This idea stops working once you have a bunch of interdependent feature
> branches (consider two branches work/myfeatureA and work/myfeatureB,
> with the latter based on the former, with each having two versions as
> described above, and then you rebase work/myfeatureB-v2 from v1 onto v2
> and expect to update work/myfeatureA-v2 but not work/myfeatureA-v1).
> Excluding branches that match HEAD is a very narrow workaround that
> only fixes one particular instance of one particular workflow.

Good point

> I don't understand the opposition, really — in my understanding, an
> ability to restrict update-refs to interactive runs is a significantly
> useful mechanism that does not impose any particular policy. It answers
> the question of "I want git to _suggest_ updating refs by default, but
> only if I have a chance to confirm/reject each particular update".

I'm not opposed, I'm just trying to understand the problem and see if 
there are synergies with other issues people have brought to the list in 
the past. You've convinced me that supporting 
"rebase.updateRefs=interactive" is worthwhile but I do not think we want 
to change the commandline interface. I'd much rather reserve the 
optional argument to support filtering in the future so that

    git rebase --update-refs='*-v2' --update-refs=^not-me-v2

would update all the branches ending in "-v2" except "not-me-v2". We'd 
want configure any default patterns separately to whether 
"--update-refs" was enabled by default which means we can add "rebase 
.updateRefs=interactive" without boxing ourselves into a corner.

>> Maintaining multiple versions of the same branch sounds like a lot of
>> work - whats the advantage over merging a single branch into each release?
> 
> Different people, different workflows.

Fair enough, from what Junio said it may actually be less work anyway.

Best Wishes

Phillip

