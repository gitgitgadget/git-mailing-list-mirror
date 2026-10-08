Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7544F561
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466551; cv=none; b=DgkZV/X1KY7KlHgk8SN2mhoNfpw2ZKDHPNgTfhx8lWN9jdO0bPIh02khCHoHPjC99fVPPQaDMWDRgHEqO6db0ysDWE3G1V4xjo13mkQb9odD7wrWPHU36XFtONfUyGRtZq6aYjrbwtumYHXZmFkOKex7ifNlGWIf3tPd3IxjZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466551; c=relaxed/simple;
	bh=mnnPylEUZPXkfDd/gQqNOI42UKsRRFuSLyKcM9CXfDo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p1CFTXwJf9ordaDOpZMBRA8FvoH7A0vKb7q+xo10QvoCbOowIaLnEgA3R3YIvCiHYxEq4oisNBXLN8We7BkzJ3hBTS/9jrBSCqKMWmZd8N8y0dxNXpmkMBlTdZhOzzbtaaCBNfLBz1aX36z4JwCeKn344eQ/WmafaOAKEJKUhCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5suLyvS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5suLyvS"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso53406135e9.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791466549; x=1792071349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IHVZuywW14fp5O11hLt3ci6TAfQtasjQHr/O8uua9UY=;
        b=U5suLyvSw9vCY8xCzxGiWajDJyEtXuhtriCTd8ocUeKsbeQ6+b64IcqeZnuHbJ0tX4
         IRCSlVjMWe4dedQnCqpjt/6Z+MRsAjeIMQTRY9xCsQ4R7mNRRmsnZaBSoPX/lH7k6Vh8
         wA2USrevQLPbKry87qBUNLtv0eyGM4qIvMaHDN6Cxhsdk7WPEgkcRSmC5aoFVzxoHsor
         i+gPShapCPWM5/HpVF8/9JE4ySDnm8KoMgv3peTo0u6gWNNHqfiJbc1/sZ6zQYNkU+vD
         Zq0PhsZct1djAt6aOv3AlvukBGDgfDAmuFpy2ieuyl7SnExq7ezx0g2S4dm2n1g7BTHb
         50oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791466549; x=1792071349;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IHVZuywW14fp5O11hLt3ci6TAfQtasjQHr/O8uua9UY=;
        b=1yvtiSs9G0gnHpb3cyS0CAVgNbtDmOcMMw2puT4cUPBv2J9jfqwr0+2/YcherlAoKp
         Tv3bZmU4wDYOmJhruYWobsr43qMRH8GG+bTCvtCgouVKlMRD9j10OSo2r6mjsP5kjLts
         PRL0qC3NAzVaOPnxSQF0PY1ufY0ynS5nhyEpT5vs0emPkeUcW8KQJNOtz0YZwIviY4CP
         X1M5VVIV0+NROI7TUKFwA1gRhoNs6jFbTiHxTHg0WUPajTDeH1HtOnmzJe10IbpAeYt2
         RH1yuUHQPS53iPZqd7KxakmnvBLJvBulxkhie0Xzrd7goARVjFxbKGhbbeNT1VxFy0j0
         TWDw==
X-Gm-Message-State: AFuF++n1GHye9/r3KUddZ2MSQ5HUUiE4wyA+iS78QS7hCj2NFoBvzcWm
	vyEvdhUFt8L2VP+avawF6p/MsN78Wrk29lPLAGlvd+M5bBqrojDLg9dTBk4ddBp9
X-Gm-Gg: AYBFou1xDGGEyGpPWvHi1L+JSCCI3Ped/LnuDpEENvxi5Es+zIi0CXo+p2Y7kjK8pr6
	PJ0+UBaoWi/dUBdACyjkB4bTChfRhHF5BYOCp41GCLRxFEILgTCPK0WCzt0Cc9By21fnf6bgHl9
	SSO2rnwZhZlXHuKpFhQJlUZkIdMElNk17/XwTUSlKULRGH/V79STZIEMvNYz26RWZtbpTnE3kWa
	M61+lgDj+9/D2BEgb54n4NSBddnlJWwvvJGzg6umH8oOoI1W+6D+zpUpXJGbc3VDPeiJG1pJWog
	JKi+OiW2f4O1EG78MHP4AMbpd5quFh+uV2uxQ4WYubGB7aVpTKnL1h2iV/M5VNaSXedcmMgP150
	7O6W0aKb9VIVJYEZklLQ9R2giX3lxZdiycI5KXVRrgW0aYcnWmYPbF51ulomecbQ7no/sw/YYPf
	14xBYgdDpp5Lb6DFPh+nqaNeoRyX1+h1v2IEhLpDHoi2WSNPt1jOt4fO9EuDqcbo9ZoMqSrTIfM
	hMKbpqANOrfUdTdxKDv4G8gRtVBEDhZd+xMwI84a7/8dDNGbHOb
X-Received: by 2002:a05:600c:810c:b0:4a1:7163:3e41 with SMTP id 5b1f17b1804b1-4a1804234ffmr93546205e9.9.1791466548086;
        Thu, 08 Oct 2026 06:35:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3d44asm11897870f8f.54.2026.10.08.06.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 06:35:47 -0700 (PDT)
Message-ID: <82bf1054-8455-489d-b832-302909711b2a@gmail.com>
Date: Thu, 8 Oct 2026 14:35:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] stash push: remove duplicate changes detection
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
 <95b7d582a2f86a3db4a9e182e482e9eb904ddeee.1791218125.git.phillip.wood@dunelm.org.uk>
 <xmqqpkxmgb00.fsf@gitster.g> <725487d3-5a07-40c6-a603-990a661e0193@gmail.com>
 <xmqqa4opa0up.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa4opa0up.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/2026 18:15, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> Before the precontext of this hunk, repo_refresh_and_write_index()
>>> is called to refresh the index.  We used to leave early when
>>> check_changes() saw no need to save.  We no longer do so, and
>>> instead keep going.
>>>
>>>> @@ -1743,8 +1737,15 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>>>>    
>>>>    	if (stash_msg)
>>>>    		strbuf_addstr(&stash_msg_buf, stash_msg);
>>>> -	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
>>>> -			    interactive_opts, only_staged, &info, &patch, quiet)) {
>>>> +	ret =  do_create_stash(ps, &stash_msg_buf, include_untracked,
>>>> +			       patch_mode, interactive_opts, only_staged, &info,
>>>> +			       &patch, quiet);
>>>
>>> And we call do_create_stash().  The first thing it does is to call
>>> repo_read_index_preload() and repo_refresh_and_write_index().
>>>
>>> Are we refreshing the index twice now, even though we know nothing
>>> has changed in between, when we run "git stash push"?
>>
>> We've always been doing that when there is something to stash (which is
>> the normal case).
> 
> So when there is nothing to stash, we only refreshed once but now
> refreshing twice is not a regression?

If there are no changes then the first refresh will mark all the index 
entries as up-to-date, which means the second refresh wont stat anything 
so I'm not sure there is a noticeable change. To me the more important 
problem is that we're lstat()ing each changed file half a dozen times 
before we call check_changes() when we should be lstat()ing them twice.

>> To avoid that we need to make the callers of do_create_stash()
>> responsible for refreshing the index.  At the moment
>> create_stash() calls do_create_stash() without evening reading the
>> index, but do_push_stash() needs to read the index to check if it
>> the pathspec contains paths that don't match the index. That would
>> also avoid calling preload_index() multiple times.
> 
> Yes, that exactly is the right direction.  Then we can reduce the
> number of check_changes() without increasing the number of
> refreshes, right?

Yes and improve things for the case where we actually have something to 
stash.

Thanks

Phillip

