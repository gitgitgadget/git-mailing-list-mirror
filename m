Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0B1DDEA
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186029; cv=none; b=bM4BLTVO9dRtaamsRSEfEkDKQkiRdi/R1iJZe2WsvdLf9MHhF02wIEH+SQev7/JyAQXFrm6kG8cogZaftAL1XYd9jNNyMcK1r49uzyi2g3kw5mm4Y1HdBTtoU2dhL1rP+QARx7GbPrZP4QxT53tRXmBk+LBRN2xb1x4XnqNXW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186029; c=relaxed/simple;
	bh=xhNUhgpcC722hwUf8Qzcnd9hWCiqHhbD0VzZDmPIzrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMil+WVFMHQIRYEGqLaynOQpjPE0uojtW6RvRPJTqFSGaFhhgarR6AYO+mRI3XZaNBaYTIduAtxvxKaikJdJ20I0ZORkKw4bhyh8hp5CeqmlrhLIKUIVMBiaqsHe+sr5xo1kK1n23A7tVRjMvQNj+sH3sS/SJc+WwcstwaKzfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlKqg/5r; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlKqg/5r"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374b9761eecso4177240f8f.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727186026; x=1727790826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W88i+JFheBpj6DBSxeKXA++HwP0FgBno8Gvh/lhVDXc=;
        b=NlKqg/5re7cj4hS1qQvwOiX4mx/8vuL9qdB52TSHTdhzs6dmNvXWQ7dFbHm6nc5QU6
         gSylhwxq/r2D/21N0ggdyfHxDHkztdBZX1UxAuZ70Tmi3CqOwStkbjW0r1hmQJPGt2g4
         sFU+qHeBohzIf5CDS9uAp/0S2eMaeu30MAsLQ3Me6VrwUazDHv+nrURkc4/M48OEPr7G
         9pE+Tym+mGAErCCsWxQ37ZNky6ELjuSHOWDkl+y9k9nz1gHRaEdVbWquRaTZf4QbAZ/3
         YZzIweioM3ZeHluSMboMc6fjuM2WnX98rT/IJCFjyITxYVQ5ZrxkVnXr40I2euVQXF9h
         SlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727186026; x=1727790826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W88i+JFheBpj6DBSxeKXA++HwP0FgBno8Gvh/lhVDXc=;
        b=NTfDUDzDfjXAqwfm8sMQNpWYx8870wno3JdtVx0Fg7oZob/eXjpiPPNGbN+qRz+eJR
         IzgYmz+d5ka8NUa1/8Yuxd1+zGgJZKMnmLC/YcSSfdDPNWr8vo3T2zgog8IfHCtk9+75
         X9IrSf+nWBzkratjShWA+uYM5bCTfkzqb7jWmdaMryV/LgNooC8vEHmDwzOvEcN0iDfh
         AdODejb2gChCdx1qEZE8VgcSi+TpomdmQuMqcbTlpmKgU+zSX2wzGN4j/FvJ1eB4s++4
         bERdwugCwWe3FLgxCMOJ7+AvCQa5hHZZLieYsAuit3tDak//pptJ8DBrbAgUxFzdcUjs
         tbWA==
X-Gm-Message-State: AOJu0YzPJqzBiqAB0ysRohk5sZF8ihkpcBI7qNLYpIR7Xyf45bENDnmS
	GqWqXmNxw+1JRA+zKeVAiSh5zSN1iFSPnPziL2lq4a/DzcjZwnmN
X-Google-Smtp-Source: AGHT+IEhaVZ4rkGVWn634yOWAGI3CLOXPXITReqo8kQGeolhEak/pomZrkMxeyyyP20kl1q8MW9ybQ==
X-Received: by 2002:a5d:6e92:0:b0:367:96a8:d94b with SMTP id ffacd0b85a97d-37a42386765mr7642511f8f.57.1727186026177;
        Tue, 24 Sep 2024 06:53:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4d791asm788300a12.83.2024.09.24.06.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 06:53:45 -0700 (PDT)
Message-ID: <87afa860-52f4-414a-82da-09e7eeac1301@gmail.com>
Date: Tue, 24 Sep 2024 14:53:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: "git worktree repair" modifies the wrong repository
To: Eric Sunshine <sunshine@sunshineco.com>,
 Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>
Cc: git@vger.kernel.org
References: <E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au>
 <CAPig+cQ8=Y6sVvN_dBo_GQ5nLkQ4GJ7AM6mE2kt_2QV7CR0omg@mail.gmail.com>
 <3b579ddd-b386-4daa-ad63-1e75522b7462@stuart.id.au>
 <CAPig+cTkpLLoTxTa-8xfycNGFibN_M71+kkHtT-wgp6HRPi-aw@mail.gmail.com>
 <4781ff6e-c20a-4340-851b-c9d324d1fac8@stuart.id.au>
 <CAPig+cTop=2+k0XbqYbsCTbJVo77evY+_a+FqDV_ziKf2q+Dzw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cTop=2+k0XbqYbsCTbJVo77evY+_a+FqDV_ziKf2q+Dzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/09/2024 19:52, Eric Sunshine wrote:
> On Thu, Sep 19, 2024 at 7:40 AM Russell Stuart
> <russell+git.vger.kernel.org@stuart.id.au> wrote:
>> Interestingly, people (including me as it happens) start out by trying
>> to emulate the hg approach using a single parent directory to hold a
>> bare repository, and the child worktree directories.  Then they discover
>> bare repositories mangle the remote links, and give up on the idea.
> 
> Can you provide more details about this "mangling"? Although the
> use-case you describe was not directly considered in the initial
> design, worktrees hanging off a bare repository became an
> explicitly-supported use-case not long after worktrees were
> introduced. So, it should work properly and we know that people use
> worktrees this way, but we haven't had any reports of mangling in this
> scenario.

I can't speak for Russell but a while ago when I added a worktree to an 
existing bare repository I had to update remote.origin.fetch and 
remote.origin.mirror because "git clone --bare" implies "--mirror". I 
also needed to enable extensions.worktreeConfig and ensure core.bare was 
set appropriately.

Best Wishes

Phillip
