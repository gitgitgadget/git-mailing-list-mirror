Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA641DDC2C
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235208; cv=none; b=Y+DBbYYL7Hr8gapSwFq6r29fuujzrYSdP/g3CDJcf3SoBb1D3BvbiyKzqa2Xv5KRqf3Vw9sNQOV0At5P9mHB4ZcwlrMaCETq+yg5LIKSYvbUlKiuBWeH3KZCGHKg13J7h6mQRROdQQqZIVibvKaIJBKvT2vQ9vpj55IkBPSPia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235208; c=relaxed/simple;
	bh=bI8tBt8oTvDPcoUc7craOSGMUCehEpgXvvKqUv8viYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UM2usn8XUNh0GrC1QWgaMkxw91Nnoa64EyuxWCn+U5LsasF50LV1GCqrRMS8ilN7SWUyU7OrDNCTpC2ZeaB+EhGoIuuh0nI0i9F9Eu/X8S3McTux1HeK4M6+z09XCOQFX+4M+9hCJExXcIu4faMIaFPJx/c42pZ5R/05LXwR98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=CPxGaWR4; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=lxXU+6j5; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="CPxGaWR4";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="lxXU+6j5"
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-85db7a3da71so411389239f.1
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 11:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235205; x=1742840005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RwwV73tY1BvtZwNQs77HZPfznf1vs6M1uX+UpCFV01E=;
        b=KQTZfCM4/15hn4bqy0izPeuLU74ObqjE26puw/Ga2JHYd37/dEwDoVbuZxzDBVgJFA
         pZlN5qOLSh1iRF+xoP0bBNMS+c1ExTNwP0R5gT9MnPFeNIBPG8qF8lcFRP220BgqvY8g
         hSL3SOHbe8DNoqDAHcFjlseXLzag6q8e9wrYZrBxVWI23cH4RDifP4zHHp/wAgKZNww4
         abw1nXXQsQtRfiu7WzoduhAHc0HOxJJS42QouBW7kRUqLEaeYXMORrvwD4K+UtHS0fEU
         O4469rC/ZLICpZFxdkPvFtYdl27rd3ux5ZaMk+TZvyerVXlVpA+INOZ8xSCS4W5h7vd3
         sShA==
X-Gm-Message-State: AOJu0YwJ5gS/JbJqSbDtvWLV66DhujasNCL6ybYA4PG0y2e73XMJuQH9
	jaNbKJCdG7zscv+qx1M2vRG2nJwf7QMRNaf3w+EW/Q8zYxDi5D9DrkNAv0vfQWYJSPKaGm+Gg49
	5+bpBd6YCt4DK8u/g0+24DWH//ys5zESY
X-Gm-Gg: ASbGnctiOToxxrhKsgdZoYCL/PJa9fV+7VbAcnBgvIh8XybZ8GhwEByJWgUysnibSTs
	weMgqy1p7mUgSVi4zTNV71SIHECWT1+NxWSYEGuRVNt55mn064KVdvFm6+J2hZeTVdX5kuo1xJZ
	NXCATdz/YoUKwyG0PgokWl3KpRfGKILfepQClo/hpYSGz43SGiXwfGz2o4Cy10ANMaEZUIC3oGK
	nE/C+AYHETDe5wiBTEqbX5BP41Zp4wDBQIAmigWbtJN2TjPXvLMvUeUEipQCKwsKdMHPheVhc8a
	VHbkFIsWfsbnqT3uEnhHV6VWbvMR0Dcyi/Wmj/nSzL/1SkhDGx9b57OLfhmNSzstoLjEecScE/g
	dUel4hShWzY3d91JL/IitAiagwQ4enQ==
X-Google-Smtp-Source: AGHT+IGyrZ0DpYjGAyogTWntU5J4BeWsoCCLCkovxomozhhSXCEol0plPH2h4MflaYLthLQdtWbA15KxOz++
X-Received: by 2002:a05:6602:3997:b0:85b:4362:3403 with SMTP id ca18e2360f4ac-85dc4812871mr1705105239f.7.1742235205345;
        Mon, 17 Mar 2025 11:13:25 -0700 (PDT)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org (pool-108-49-41-183.bstnma.fios.verizon.net. [108.49.41.183])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f26382b250sm417289173.72.2025.03.17.11.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:13:25 -0700 (PDT)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1742235204; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding : from;
 bh=bI8tBt8oTvDPcoUc7craOSGMUCehEpgXvvKqUv8viYI=;
 b=CPxGaWR4i0bjqtff8CggeJAyiunLDIZpAFHB9ymFxtl732rcJ9G+zJoagdJ6p5ymVoSwp
 2BuxnWIRSHqQT1NBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1742235204; h=message-id : date : mime-version : subject : to : cc :
 references : from : in-reply-to : content-type :
 content-transfer-encoding : from;
 bh=bI8tBt8oTvDPcoUc7craOSGMUCehEpgXvvKqUv8viYI=;
 b=lxXU+6j5uejX8DwdJz2jn/0T544d0c/FIk8baFRog+BGQ73SLiOZWA3+eUr7/+eqEIw9K
 +C5oRg/sJ8/ZZGwTz+x7YgV3fVTH3ExGvKquynO8vvmSkv8mtal76gI0BaXCImFpf8ygFKw
 M/8p8dt0qF5du7tBiDHsD0i7mKeN/Cl2mBmQrBjS/tNj2cerr7xALWBF/D9aj+Xr9FksEJT
 cEj0bsPbqCJmcf5N2Nm/QfjWarQjfUTT88ORhxhQoSXrB4GiC5/zQSXJmfPKDuMouYkNYz+
 aagYTPth6dspDC+a7Dux7fK38cV43mh4sDlkAqlFlW624YY8iYKVaAgSw2Eg==
Received: from [IPV6:fde5:2b79:35f0:2::166] (unknown [IPv6:fde5:2b79:35f0:2::166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4ZGjl83WKQzySw;
	Mon, 17 Mar 2025 18:13:24 +0000 (UTC)
Message-ID: <feeef061-1b44-44c2-9fde-06b73e58c516@mandelberg.org>
Date: Mon, 17 Mar 2025 14:13:24 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git switch --force vs --discard-changes: docs don't match
 behavior
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <bce5a500-76c4-4462-8f99-b17a6f21f7ec@mandelberg.org>
 <xmqqo6xza838.fsf@gitster.g>
Content-Language: en-US
From: David Mandelberg <david@mandelberg.org>
In-Reply-To: <xmqqo6xza838.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 2025-03-17 om 13:19 schreef Junio C Hamano:
> David Mandelberg <david@mandelberg.org> writes:
> 
>> $ touch Makefile
> 
> You'd need to explain this example a bit better.  The reproduction
> must be done in a repository where the master branch has Makefile
> tracked, you are not on the master branch, and the commit you have
> checked out does not have Makefile tracked.  IOW, this is not making
> Makefile stat-dirty, but is creating a new untracked file.

Sorry about that. I had originally meant to copy/paste all the commands 
I ran, but the `git fetch` command produced a lot of output and I 
decided to only paste the ones that showed the bug, not the setup ones. 
Here are the commands I had run, starting in an empty directory:

git init
git remote add origin https://github.com/git/git.git
git fetch origin
# a few status and show commands, but those hopefully aren't important

So I actually didn't have any commit checked out, but I think having a 
commit checked out that did not have a Makefile would have done the same 
thing.

>> Is this a bug in the code or documentation?
> 
> I do not have a strong opinion either way.  It may appear to some
> users that giving a finer grained control is a merit.  Even when you
> are willing to throw away changes to already tracked content,
> getting stopped when you may lose a totally untracked thing might be
> nicer.
> 
> On the other hand, I suspect to many others this finer grained
> control does not give much value while adding more confusion.
> 
> I am obviously biased because I am accustomed not to have this
> distinction and accept "checkout -f" as a reasonable way to force
> switching to another branch discarding any and all local
> modifications including untracked new files that get in the way,
> though.  But I do not feel strongly enough to say that the behaviour
> and the feature itself is misguided and we should rip it out.  As
> long as that "finer grained control" is working in a consistent and
> explainable way, I'd actually vote for fixing the documentation to
> explain how "--discard-changes" is a bit milder than "--force'.

Makes sense. For what it's worth, I don't have much of an opinion one 
way or another. I want some way to do what --force currently does, but I 
can always use `git checkout` for that if needed.
