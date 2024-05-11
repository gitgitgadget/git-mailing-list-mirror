Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B41E526
	for <git@vger.kernel.org>; Sat, 11 May 2024 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715439683; cv=none; b=W17CGoB//XqAW+p/BKR9qesEH3kq0VP2clX9SxcsfCFzEq3x1RbfPaMwR0yLiicKbiErdhbZO/eCA1bGFVCnHIbJUtbglSYcbG3zu2RiEWuTQZEXBTUrcta7p2ppyk9hLPSas3EYNXdTAJtRwoMz8g7uIvuG6pS4E8L5onHyXrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715439683; c=relaxed/simple;
	bh=0eztHubc5jYNm4q6/yIg1OoprVH8f5K6KsZOVcuZ0b0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NDw/oSQ8Tz8uuvEtttJ2zHc7O0/M7YQwtnZJs13BVFgrPPdmsrcIZ/rvCtsInlqzIGlrlnPTvL/nLq3rR3D4BZQClLcV/Vcme+yoSP0GQ+sJRWT8ldPQngqFuM4jchIhFrwjZgXy94wZ7J+bNRYUj/TCBEPkz0pET8pJdlmW9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMoBVsiV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMoBVsiV"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4200ee78f35so4602945e9.1
        for <git@vger.kernel.org>; Sat, 11 May 2024 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715439680; x=1716044480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUTZbL62LA7wpFbzmyZLTWD5BSgCgB54kcKipiBVqFs=;
        b=OMoBVsiVUteaUzGFRbTKSDNM+5A37mrCqsP2VAyK0PyW3n8XCEK2Fg0sZTSh42iHqt
         S+jQwEvdihYGKPkjWG8SWEsns0bI4qwFDbLRrkxns1Hi/Xo/haF4RRy6kvCXC+YV26HQ
         r4mdX5+cKB3lghkSM9p0gcpqgdWgwsFrgnJha5u2z9sQAxn5z24l9pkn8Q/TCit4D8PK
         V6pEKb6izGOTyFytWKEsmS+nrKdIlG77fwMzbhaokVGXJRntU+Blc6dvUpHnUqNno5W6
         skliJvQNcPMG0ML+yw77nnRR8nPk8DQCShHEJxvRJp6v08jcu5u4gLXi+gdY/DeWZ4/D
         Z3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715439680; x=1716044480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUTZbL62LA7wpFbzmyZLTWD5BSgCgB54kcKipiBVqFs=;
        b=AaC2r+0Uvfo6teV+M7MJDAveLYtt0VLXiBDCGB07WBwzwmqzqA5FNU4/TJJRPesDWB
         2Mkdqv1krNFpSj+HimIO/+TXfGozuDA0zjqD8t3IEcpJVZEd5/NNRLfg9mNYQ4jbxKEd
         Mz0cIw8kaoaCfOd14/acAxK2EBRLml60b2xQNWPzfJF8LEchXBl9Z6mrlPAMqkhgWLs1
         AehGKk7mCYhtlbnF/YiP2W/HAwF/JAR6vf1QLdz5hdvzxFIphAxX9/Z+dRIzxmoFM2CW
         Ho+508CzABNxZT02HHSqc+3NZQ4DuaWqVr2Qyqxsx6q0zTRTwX0juDFRlG49xMN1XGjT
         JpCg==
X-Gm-Message-State: AOJu0YyVEhtLyDesyiVaWWB3j/L3XPN260OrfD4LbR8z6zd3FFtRiEGX
	kQ5ZQwErrT8Dy8DkPnKnmJbq0fbUYWG+fqZi9SYAAPf2eXfSsdyV
X-Google-Smtp-Source: AGHT+IHyQsct4vFCKb2im+hmrLtFVmqQmChnEyGZRy3gtndYUhY1Jqt3ShTsyjqKRBSUywMQwQG6RA==
X-Received: by 2002:a05:600c:314e:b0:41a:8055:8b89 with SMTP id 5b1f17b1804b1-41fea931ac6mr62605215e9.6.1715439679752;
        Sat, 11 May 2024 08:01:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee962esm100119215e9.31.2024.05.11.08.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 08:01:19 -0700 (PDT)
Message-ID: <3a48b2fe-78c0-41f4-9e60-4146f15dfa97@gmail.com>
Date: Sat, 11 May 2024 16:01:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git-cherry-pick(1) -- path
To: Alejandro Colomar <alx@kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
 <xmqqv83mqxg3.fsf@gitster.g>
 <kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
 <9b42e684-32e0-4372-8da6-40f9b708b6ca@gmail.com> <xmqqcypt61lo.fsf@gitster.g>
 <bpjfsabhstkbuvo6ksj3owoxvutgquripmqmqi63ykaquhky2u@r7mfrwucgnye>
Content-Language: en-US
In-Reply-To: <bpjfsabhstkbuvo6ksj3owoxvutgquripmqmqi63ykaquhky2u@r7mfrwucgnye>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex and Junio

On 11/05/2024 12:46, Alejandro Colomar wrote:
> Hi Phillip, Junio,
> 
> On Fri, May 10, 2024 at 10:03:31AM GMT, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>>>>       $ git format-patch --stdout -1 $ThatCommit -- $ThisPath |
>>>>>         git am -3
>>>> Hmmm, I hadn't thought of that; very interesting!
>>>> Although I have some concerns with git-am(1); basically that it's
>>>> almost
>>>> clueless when there's a conflict.
>>>
>>> "git am -3" should be fine here as you're guaranteed to have the
>>> necessary blobs available to create conflicts - this is what "git
>>> rebase --apply" does.
>>
>> Good thing to point out.  "am -3" is just as good for this purpose
>> and "almost clueless" is a derogatory comment that requires an
>> apology ;-)
> 
> Huh, I am quite surprised by `git am -3`.  I've tried it just now, and
> it's amazing.  I certainly must apologize.  :-)
> 
> I tried it yesterday, but the patches were from a different repo, and
> not available locally, so it really didn't do anything.  But now I tried
> it within the same repo, and it's really nice!
> 
>>> As far as the implementation goes I haven't thought too deeply but I
>>> suspect we'd want to create a couple of trees based on the commit we
>>> want to cherry-pick and its parent filtered by the pathspec and use
>>> those in the tree-way merge with HEAD.
>>
>> If we were to use the ort machinery, it may not be too bad to use
>> the pathspec only at the final writeout phase.

That would be tempting if cherry-pick didn't have a "--strategy" option. 
I think we need something more generic to cope with that.

>>  That is, perform a
>> full cherry-pick in the in-core index, reset all the entries in the
>> in-core index back to HEAD that are outside the given pathspec, and
>> then write out the result to the working tree.  That way, an old
>> change that was made to paths at the original location can be cherry
>> picked to a much newer tree after these paths have been moved to a
>> different location.  Doing the same with the recursive machinery
>> would be missier but perhaps the more recent merge-tree that uses
>> the ort machinery to work purely in-core might be a good way to go.

My hope was that the changes required to create a couple of new trees 
that are then used instead of the original commits when a pathspec is 
given would be fairly localized.

> I didn't understand the last part well, but I guess I may do when I
> start researching into it.  :)
> 
> Apart from <builtin/revert.c>, do you recommend I look into any
> particular files?

sequencer.c. If we go for the "write new trees and use those in the 
merge" approach then we'd need to change do_pick_commit() to create the 
trees and we'd probably want to change do_recursive_merge() to take 
trees rather than commits. We'd also need to add a new pathspec member 
to struct replay_opts to pass the pathspec around.

Best Wishes

Phillip
