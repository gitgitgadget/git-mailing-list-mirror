Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F1763C7
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008596; cv=none; b=KYJuDmxETbwM+7rFpqnNrEBZHPvc3HmVD9WSt+4qAEnbadRsKR3Ne0BplJFYe0ek5HR5Q+FROBFk9nU5SDfRIjnEXCUK9snu5ol5DHj4n4RJOegcnNsjtUOBuqSpZHlpjQKYUscoc6uVyTvton7Q3kWnLBwd8uTufBce5tsHpDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008596; c=relaxed/simple;
	bh=/Xz7yFvnWokr0rA0zD/zIP5UIdu+3Vovs4SkEa1BrDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiVcLou4/O1WmlWNfi17DKqOHw6yYIw1cPNYsuKJQEGI/oIKWonaQCtwjacL6tIBtzcpLAUON64JNrq3+C1tEmENYG5V1YUCowyrnjNTKups84D8UAFXTh1mQrXJUDoIXL3+C4eeZxomAC8kq/xFBPGwN0IoTi+g6qstV291CMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa1AsKvr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa1AsKvr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421b9068274so6301825e9.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718008593; x=1718613393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dGKrub9d3ZujudmV83HBe/a61trDfLnCL3aOI91LLSM=;
        b=Sa1AsKvri2zUwPUF0avnUiWlODZoGhTmK1qanONIA5CzhPUGCa3IJrvuccW/229YjN
         8jkfT3Hsq9AW+m86xt7V77oAIGCCJBiLXL8YrY91prUYrAVKgRlGT4V/3TLQfnDioB0i
         u+mG9sMgxuNHYrpTpcPW8uoOmSBx9d3QmDZxrXtHj3xFlDRFZ1WCsKVEL70ufjFuKgpT
         CSQpOlL0wzOvIqdKDLyOHQv7Xn8DmKSvPg0RL/owe2fEu1yzuj3ju9BtA8u+8SVlAT3f
         +zwao/aTLkKAia84K+wVpoqDjZxiAD01QGJvgF9f7lkFEAZxhnKcpQj6KFjWDWywhDuY
         BvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008593; x=1718613393;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGKrub9d3ZujudmV83HBe/a61trDfLnCL3aOI91LLSM=;
        b=kBbYEsIMfnHPw09mctIRxZ5xOi9vEFah4Xr4FvyvYwGWYp5qiSOlfIdHWMGcsD6oli
         CjDBOh6tqJ2DEkrC5Ks8oHP8ch4Eh/Bji3Cwg6QWg72dTgUK+HGNorCLqWZ1amoFcqst
         AWHe4MlhLC3DsSXdWCKkogIb94MFARtoVwBVHV0ijwsc6FEgQTkOo/+ehk+xdFcwYRSO
         Ss+NBPo31GQqAkcySdDZQwP3m5vXYPJgFLOHFhC61PkHAHzkjT0H9usAhoEBzEGXi1yX
         R8es2Qu9vdmDjVP0WI04fegVt3lAOFPGtyLVUi0HBa5keMZvCUw6EDH1Bol5Dxnaxdx2
         wcdw==
X-Gm-Message-State: AOJu0YzG4odPU/KiLJtAGEHyoU3rQ9vj+PjgGkOrzC+0eYSJodVSinPA
	lDTNNsTqVC+i8EjLAE25t1R6Rhy4U5EzhpmYTE0+a//HZwAwYIHT
X-Google-Smtp-Source: AGHT+IG+It5L5GOKi/+hslptHgEPGiGPxGtLBMQ1OZ8tSxmxRYUzT8syv3taEz59iGcUIdwtd5qzsw==
X-Received: by 2002:a05:600c:4506:b0:41f:b0e7:f299 with SMTP id 5b1f17b1804b1-421649f0c0fmr70660385e9.9.1718008593015;
        Mon, 10 Jun 2024 01:36:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421f23d06ddsm15598745e9.8.2024.06.10.01.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:36:32 -0700 (PDT)
Message-ID: <16a6b206-1733-4d64-89e6-c3e2368903ac@gmail.com>
Date: Mon, 10 Jun 2024 09:36:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] am: add explicit "--retry" option
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk,
 =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
References: <20240606081724.GA1166769@coredump.intra.peff.net>
 <20240606082114.GA1167215@coredump.intra.peff.net>
 <xmqqzfrym3fu.fsf@gitster.g> <xmqqtti6m2yz.fsf@gitster.g>
 <20240608112920.GC2966571@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240608112920.GC2966571@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff and Junio

On 08/06/2024 12:29, Jeff King wrote:
> On Thu, Jun 06, 2024 at 09:48:52AM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> Jeff King <peff@peff.net> writes:
> But I do think as a general rule we should never provide any action
> _only_ through heuristics like "is stdin a tty". We should let the user
> be explicit, and use heuristics to guess the right thing when they don't
> feel like being so.

I agree that's a good general rule to have

>>> "--retry" is a horrible word, in that it makes it sound like it will
>>> keep trying to apply the same patch over and over until it applies
>>> cleanly or something.

"retry" means "try once more", so I think it is a reasonable name for 
this option. (Programs often retrying a failing operation in a loop but 
then they are retrying many times.)

I haven't looked at these patches in detail so I cannot comment on the 
code changes but I do think the general aim is a good one.

Best Wishes

Phillip
