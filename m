Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718F3B6C16
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380969; cv=none; b=LXApLm3vHJmRu4rXoJL5obairIkJuYLMsWRowyJogFdgB7Ng8wSxSJjRFCcEQCJtJ71AAKdUI4A7rAfS1al5ujeM4lvmxCiAwZJReoWKSLFWoWID0psFPTbpPI98kqAEFpEl4iwOY16DJG1zS6wcSInIBs/J8ARrS8xkw9W3q/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380969; c=relaxed/simple;
	bh=rIcnmcSTGrnE5pHvFNpuNsHuzYiW+skwHiFL3hAKeFI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YK/+Wzcf02847l7rUfEdvadxOWncRYJASwzeGax1/Yk8ATdptTeTwBZ3uNGqRd+tbCCnHmwryiG+tcTP/1Lj6lJn7+ich6p3zy6JSOgUbP0spYNgSt5E0MU7tmeM2UMM46nYGssHSyJkFBsTOhys+R1vQQxhxN+sbmPTx97JrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcnNBVZJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcnNBVZJ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6afe29c08ccso2441659a12.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791380957; x=1791985757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gv1exei/UPZFFSuQsvjDgDXXPep0jmSd/yBrQS807c8=;
        b=PcnNBVZJoCPf0vY5sjQpRpA40rPQ0+TzI9Tb6D3pZ2ny3DdfadWx9dCkqVCh1wSkpV
         ZHsIN3SfoLDfuqjDhx3nKX1FTClwB4oCJbzCzQj/jsMnBLhcvfSyUhulgxvqAbta8aWF
         hIW5/GywoYJiE1Mpzy4zUZO94hQNr3h4kgriPKqMTe4+aHsD2iD77kF5eoZvxcGlYuh5
         mNVv+lPFyFXjRcjZxuS1veDOjFwXRDrZeCwE1Lz5MLPAoS8oh85r7HS2g+QYt5XVOmjj
         gLNjfVS1YFy0I2O5HnKGjA/H43eegaekDUry8PwV7Eo8xEg9QAFuB4SIMpDSSlfKYoki
         pu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791380957; x=1791985757;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gv1exei/UPZFFSuQsvjDgDXXPep0jmSd/yBrQS807c8=;
        b=149+m1F0944eC07EnGBslQxlHuq18ynygE7Jib/hcbFIvEJe0DPPqXxYd58PK14Izu
         Po65AULynDm144gYoFEgZK03+1D6IBwFTMDMFeKQMRTpNxAP2IFr0ZNzMLOeHljjvgv6
         wLtkgGlHDivN+IljRvpniCllyV8HyW9+IUFcEHRtUGuyfpL73xxGF+zafFPU4WJ0ev3D
         7uWpyWIdFPwEt7MxXYmU9rqg1czFSaLJ+ojxm83JLa43FX2JyHP/sInWRChAxfXNmwQK
         0opS1gI1GPHojdG3e3syh1JdtnT3OmXVVKy+K15/v9HJvnTph9Q+sL0+pT1OuVhBSW9H
         T37w==
X-Gm-Message-State: AFuF++muiFbsePUV+nVGMcgGbxbKipBJC1CSfant2Fq4wT1rdF2FVP3s
	aKyVivpxINX3371YAdYPkoesBGFCx+xCzdfePHaezrq7b+xZtbZySFXd
X-Gm-Gg: AYBFou0bS4bMxqIWSC4AuCczAOwIUftSCVz38ygOsV6qZ4I8SZAaoile9aQIlqMnN05
	k7VJY0yMOlsmTKMxA+bKAy27mqCVY7deMcvqkh4ec5DQv7SJGps1Uu9Kk/SW14VJIXqT4Z6kXL7
	fSapkptql6PBnFptp7mtDjs6ndchXQC2TYaWdoWirgT55Wx9NPaBw+nwgs5hcLG1/+5lKSGHxpr
	VG9haCD89E2fY0kqRbmqA3K2wU+d93kibPSTrIUyAx/gqWsthyDTiALi1svRgBwJlqbWu3U4K4B
	7uu/QUbsUMrAdCQt/Q2OATuYV8YAS27yyfVQc2txRp0Accr34l4ClQE13HGkpT7H9PqxRbVY/q2
	ghfZB2rZXBUpiqrZ37xDmlN4nNlydzkYQ6xjXNLXCIVRPyKF49TQoMalPzwo9ZlFeKiau6A1S1N
	Z9bzL/i8ugic/cCTAOejNmgrixiKxcgTtaWFWyajiTQ5iFIIhuUpR4Y4kklkt9boCj86GK+NVQU
	G0u2yur+XJLuDolK8t430sN+p4MMxpYg91/VZMQofffrexsYcv7
X-Received: by 2002:a17:907:9693:b0:c2e:2d8c:4585 with SMTP id a640c23a62f3a-c317c109165mr211136166b.36.1791380957342;
        Wed, 07 Oct 2026 06:49:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3184863732sm64872966b.4.2026.10.07.06.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 06:49:16 -0700 (PDT)
Message-ID: <771a2364-7e5e-4d6f-be34-1764e609c514@gmail.com>
Date: Wed, 7 Oct 2026 14:49:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] stash create: remove duplicate changes detection
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
 <1617d92942d283017272ca6f27f1254f8f9389b0.1791218125.git.phillip.wood@dunelm.org.uk>
 <xmqqpkxngfrw.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpkxngfrw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/10/2026 13:44, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Before it creates a stash, git checks if there are any unstaged,
>> or uncommitted changes. If there isn't anything to stash it bails
>> out. Since ef0f0b4509 (stash: optimize `get_untracked_files()`
>> and `check_changes()`, 2019-02-25) "git stash store" has checked
> 
> "store"?  Aren't we talking about "create"?

Sorry, it looks like I managed to confuse "create" with "store" when I 
wrote the message. It should be

stash create: remove duplicate changes detection

Before it creates a stash, git checks if there are any unstaged,
or uncommitted changes. If there isn't anything to stash it bails
out. Since ef0f0b4509 (stash: optimize `get_untracked_files()`
and `check_changes()`, 2019-02-25) "git stash create" has checked
for changes twice, once in create_stash() before we refresh the
index and then again in do_create_stash() after the index has been
refreshed. That commit claims it is an optimization but it is not
clear what it is trying to optimize by checking for changes twice,
especially as checking for changes before refreshing the index is
unreliable (the scripted version of "git stash create", called "git
update-index -q --refresh" before looking for any changes).

Avoid checking for changes twice by removing the call to
check_changes_tracked_files() from create_stash() and restore the return
code handling in create_stash() that was removed by ef0f0b4509 so that
we continue to exit 0 when there are no changes to stash. In principle
we could remove the call to check_changes() from do_create_stash()
instead, but then we'd need to pass in the list of untracked files.

Thanks

Phillip

> 
>> unreliable (the scripted version of "git stash store", called "git
>> update-index -q --refresh" before looking for any changes).
> 
> Ditto.
> 
>> Avoid checking for changes twice by removing the call to
>> check_changes_tracked_files() from store_stash() and restore the return
>> code handling in store_stash() that was removed by ef0f0b4509 so that
>> we continue to exit 0 when there are no changes to stash. In principle
>> we could remove the call to check_changes() from do_store_stash()
>> instead, but then we'd need to pass in the list of untracked files.
> 
> Again "(do_)?store" -> "\1create"?

