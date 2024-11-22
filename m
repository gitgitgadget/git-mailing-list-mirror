Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB82818651
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732246336; cv=none; b=R7/tC/s1a2XwkZmsBY+9nmfXzTfzj/LKMYvpWKP7ZD6ZchQxmgtpHdKI5ODiHj3ian3ZdklHck8VCAnZZ4EjsBxWw5P/J1DUupDgy9R+AtEy+FUu3P1dB6j5CvcnJQxgJSGHKB7cs3YfW00O6qQQyP+vF9kU94KAv1nZVE8Jx6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732246336; c=relaxed/simple;
	bh=qbRFoTTvB7cbn+n6DbSOE2LzJVr3hikay6RRQSAMCuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKTKWIbywMpyQZ0PlETdGTEJAAUbjzfDW3xfFIDe/Ysf8iHQW4YHn3hyQrj3ySq1C2z+rmtdiIowuNAR4j7r2KCKLeSSKK7fyYP3hbULX+Nl5ojUl5bRuM4W+frCfpldtMxcbcGxw35NU4/ygKAkHUrEZOUdjDqWZRPaA49siMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7Utj0WP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7Utj0WP"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e4eb91228so181507b3a.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 19:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732246333; x=1732851133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dn/1ZxBftPuInzdpieLTw3W4Bz1ZKsfyHKIU4h0Wxzg=;
        b=k7Utj0WPcyZUyWiM+lDYoBBshQG0Kp+X2U91zwJ7CQAvyCqHXYVTjjNoj50h3tlT0x
         O1/Ah5w7fzP9QXbihFQxr1ykyAIUDJYEpFcD8SdHL67GbR5duLxGXRw3iIENpdszNW5w
         FOIK3iZivAHoott3fGHf2W/iFY8ef2172nxz8qj0nZl2gXK3gYIvl1GfbHnUlg/A77Np
         CHOZyaKMtao6/D1qkZDNoHDMHMUUUJP1T8D86wxzLx6M4jbKARTnsMyk6hrxBoSzgkyp
         oj6C80k8fUshukRSa3C7mzvzOTCgccliaroPiwOWXdCdBCBFAS4gv1vK9dOc+Xcd0FXj
         0C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732246333; x=1732851133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn/1ZxBftPuInzdpieLTw3W4Bz1ZKsfyHKIU4h0Wxzg=;
        b=OlBQ5ajTI8vcxFN5JdpHGMudhbDWERQx6fCQ3wOMav3a6C0ZnZDXxWSVThMJXnDEA/
         WMkZFjrgVsdKFDJUxLGxE+FHnxQFCkDVg6WftrmNGwrTrsxFpxb7COmHTm1dPbOh4+23
         502bT9cVR58eB1VpDDUGlJvmTWJbiKW4N+7vQHCrlw7jW4WZqfKqAhQlktt2yoqYj9Q4
         k5aph5wWrqU/oWc9GADUnuddJvjH8V85WGb9PTDMQpsVPPPo1DWzYO1t7QYBnCIao1/k
         9/2/TMZxGredUgNq4XraLkcEKizFWq/FI89dlLWfbwwf8keZPs4ivV6eeyXJB4vfO4yU
         sneA==
X-Forwarded-Encrypted: i=1; AJvYcCU1NbFevx6y/FEHZ4IDjbquc4ArDgbtARtb/boaOQJ4WDKUWY4kBfSBZMgdU7GzPsuVHbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytBp5qAW/6Ole4NsXe/+JY3HBsLlFHX38hZJ0AReOkFN6PAZ/i
	tK3butjHY+Ebv1U/pDVSIdmXTS1tMD7pWdAFBH7A7FJ3YEPfLFV3
X-Gm-Gg: ASbGncvR31O3nuL3ML7XqLIm0iBkCAlLQQyNeAYgvpwhIWocEnD6D7EF70z3LGjcODD
	/kHJYhy9VsBhe4i/UyXIXLaonBjHtYetREjySuqr+FoCBCSdPS5OOfCQgAxFON6p7qJGZip+WSQ
	2UjYhiBdyg0QLYDvNlHXC+mymtyNnd06FZlDts9dhsGtqtqdwPp+OHOYBQNY3ZnzxZAYfUMUDCG
	uglaHGpf2FgyWuLZaBeyP6JgmYc3ZKxqIlhhYs+PC0u4MOcA9yOZb21a/FL+H7TiCP/+RWZr60K
	Uhh6Pd334koIizE=
X-Google-Smtp-Source: AGHT+IFInFcl354Ts+mIH+/np4h8QH8qLqfVAYoQ4x+On2kmJ/TQqFe4x4QJAOcqqq/4ES0sCcc4Qw==
X-Received: by 2002:a17:902:e1c5:b0:212:6494:353b with SMTP id d9443c01a7336-2129f225ffdmr8751345ad.4.1732246333084;
        Thu, 21 Nov 2024 19:32:13 -0800 (PST)
Received: from ?IPV6:2606:4700:110:879d:83c0:a91e:5f7e:c6a7? ([2a09:bac0:1000:686::1c6:5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1200asm5744085ad.174.2024.11.21.19.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 19:32:12 -0800 (PST)
Message-ID: <972d0904-650b-4161-a13c-e3081d55a212@gmail.com>
Date: Fri, 22 Nov 2024 09:02:08 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: git-blame extremely slow in partial clones due to
 serial object fetching
Content-Language: en-GB
To: Han Young <hanyang.tony@bytedance.com>, Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>,
 Burke Libbey <burke.libbey@shopify.com>, git@vger.kernel.org
References: <20241120185228.3204236-1-jonathantanmy@google.com>
 <xmqqikshikgz.fsf@gitster.g>
 <CAG1j3zEEN5EJwTsM3q87gCSqXG4+=DZVvcQdDhoj5Epe-S0nPw@mail.gmail.com>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
In-Reply-To: <CAG1j3zEEN5EJwTsM3q87gCSqXG4+=DZVvcQdDhoj5Epe-S0nPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/11/24 8:42 am, Han Young wrote:
> On Thu, Nov 21, 2024 at 7:00 AM Junio C Hamano <gitster@pobox.com> wrote:
>>>   - We could also teach the server to "blame" a file for us and then
>>>     teach the client to stitch together the server's result with the
>>>     local findings, but this is more complicated.
>>
>> Your local lazy repository, if you have anything you have to "stitch
>> together", would have your locally modified contents, and for you to
>> be able to make such modifications, it would also have at least the
>> blobs from HEAD, which you based your modifications on.  So you
>> should be able to locally run "git blame @{u}.." to find lines that
>> your locally modified contents are to be blamed, ask the other side
>> to give you a blame for @{u}, and overlay the former on top of the
>> latter.
>>
> 
> In $DAY_JOB, we modified the server to run blame for the client.
> To deal with changes not yet pushed to the server, we let client
> pack the local only blobs for the blamed file, alone with the local
> only commits that touch that file into one packfile and send a
> 'remote-blame' request to the server.
> 
> Server then unpack the relevant objects into memory
> (by reusing code from git-unpack-objects), run the blame and return
> the result back to the client. This way we avoided running blame both
> twice and interleave the results.
> 
> It works quite well in very large repos, with result caching, the speed
> can be even faster than locally blame on a full repo.

In a large sized partially cloned repo that I have, a `git blame` can 
take several minutes and network roundtrips.

Junio — would it make sense to add an option (and config) for `git 
blame` that limits how far back it looks for fetching blobs? This would 
prevent someone accidently firing several cascading calls as they open 
new files in an editor that does git blame by default (IntelliJ) or 
popular plugins (GitLens for VSCode) that can startup multiple heavy git 
processes and bring a user's system to a crawl.
