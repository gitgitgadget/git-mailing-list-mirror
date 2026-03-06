Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51C281503
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812378; cv=none; b=cAZtDBvNaXAKTy17e1iZn6ohX5Xjp603cC6Z8uP5w0TwM1/lACrDDhlHqneV4M8w9VYtkYi+gfPKC19sCxLHGqCcWYuOeNV67ycTjaYBSzVkDvFXWoxcFKiScJHIxlc3vDF3zWOpbWsvteHcIl9el9XZvPYU3I2ZluuzM7o+MYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812378; c=relaxed/simple;
	bh=ZGFTPZowJ3bX6kuM89EdHAzJEudJovYSNsuchr0x/HM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CD+2OrV69y+sSH/CFxnmTXXTuSpKEDDl06Ach+vXYJpuh5QOy+sRI5vVkMb0pWgm/0uAYGihCbzhXYZmsIslUYbfwhfUK94BtCdUEpEWT85qhJj1AbRxKwhRO+RKcf1q6V+53nXuAg7E+k3+93Jp6K5blGrOGLAnK+2EyPViWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LshkAClm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LshkAClm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48336a6e932so60573715e9.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772812375; x=1773417175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDV0+WEjLJK2+fVr/VitRZX7AZXEdPA1MlgvGO/q80g=;
        b=LshkAClmlwPq2HYQz2J7BMVKWMYtzEHaXooZEG6/rHtePk+R+fNN/jChbN88aE72uy
         1o0Stleji+tyRLtvAEnWW62RrMJTebIQYXC5kuGOa781vb6m7l8SXXAmfRc5PcEV9TIs
         zpt6SRv5ySNukE80YfE04I0g+xLir/4UQqis8JrSmxnndemMflLjUu6uqSbwcGas0G9d
         ndqxUOkC+KTQoCWY0dGj/gIienVd1cIeT3Km7GKSJ/JlWXQ7qCZEBJy3ybAkqxIqtibp
         NNtBzFUCLB2032fDoMOGUsCCjzCGmz1rD3S6d5SFa5J1K1gpIDExVbFEI+QKKSl1Eogc
         5KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812375; x=1773417175;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDV0+WEjLJK2+fVr/VitRZX7AZXEdPA1MlgvGO/q80g=;
        b=qJzQqLOcNbawJsH7ec4Ey3NP+ufgjzW06WB3bCG5n3O0n0i0R5blq8lKPBup15yeDF
         4exGvMnNrFfE8d+U4kYx1nHIJd+AkNu3PQPzqwqwrKLprVeHNviGvcjU1m3R+oKBhcc0
         QXUu6IIWnzJSN1FUxTf2ZImZ8zlxtX75JWM3EwAFSx4e8oCBGtrCW8huVQPSNOOPNFxu
         X27PvWKvG6NGBZHixj75QtqRkNKd9XIsJn1cA4vxL5hkYjwdiFGYBd5AJIBxsvSwHMxc
         hDWUS/7Q6q+UgFlE5FP7yiRirtl8atiT0eYlQ+lbjTiuh3DMFeBJZkPdvr+DkpIq48U6
         VWug==
X-Forwarded-Encrypted: i=1; AJvYcCUBFPly2wxZtSdexO9K1HB25ZFDUfstgmo4EKQKnLX5iZVqXaBcWvEK2OXpZ50Mk8Mi5xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLQwubuw3135TPayjcAccTtQWtqYbOfU09S1Y3WMpZnYI2gBF
	9Xf3jnTXG1WXQLmMbFLLKd0KBiu1jBMIzpdB1kFiZ4th/jyaOHOxtcDG
X-Gm-Gg: ATEYQzyjpWEdWCdo9BjunfLuQhSLWdHyCMWW2x4NukRY3pSwxUBm1AXzC4shhHx5d8l
	yOHVOyEoOilm1T3tFZREbZcRQ+0jMdPi3ue4ZLZ/3+2VnboZzF/6nkAa9euonBDk9uyVgFgTSxl
	ZAobjTxTCrtNeKwlgdBgF8glb8ST+BLJ635tVCIIgv4+hU7zzkGLk2j/y+UBpFlbafvIURC3MN3
	FJ/nLKQkSI1HV7lAqX15Tmupi8wB3950VKqYkdCfxUj6KBXQ+7G2zp2/5S4hlen25Y0c3wSvIq1
	5pQcUE2GZ7H2IVDuskaZ6nG1J5jXnY8RkM2Ue2hEb2UZV1voei7JjAowTU/5uun2dA6phXWUqJy
	cNz+N60DhWWbrT95HWMIMVm+mBBn4liAp5Nm4FZxPprl2SWvAIQIfRtWosdYGj1aVxp8WEYftJQ
	JNQftidakNqlvCtD+H3a/iLuDvapJd9oxwUbD1IwoesIBZyj7SH9vhuQY0hw/2ZBHrhdQrWlwdi
	FrTUA==
X-Received: by 2002:a05:600c:4451:b0:483:bcff:7948 with SMTP id 5b1f17b1804b1-4852692427cmr41484835e9.10.1772812375098;
        Fri, 06 Mar 2026 07:52:55 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681e2bsm46093275e9.5.2026.03.06.07.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 07:52:54 -0800 (PST)
Message-ID: <ed9818d8-fe30-4967-897c-edc83c83c299@gmail.com>
Date: Fri, 6 Mar 2026 15:52:44 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] replay: add --revert mode to reverse commit
 changes
To: Siddharth Asthana <siddharthasthana31@gmail.com>,
 phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, karthik.188@gmail.com, johannes.schindelin@gmx.de,
 toon@iotcl.com
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-3-siddharthasthana31@gmail.com>
 <405b0d34-c2ad-498d-93a1-2e7925ae11f1@gmail.com>
 <77fa95d9-3ea3-4a32-b8fa-22c05c048160@gmail.com>
Content-Language: en-US
In-Reply-To: <77fa95d9-3ea3-4a32-b8fa-22c05c048160@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/03/2026 05:28, Siddharth Asthana wrote:
> On 26/02/26 20:15, Phillip Wood wrote:
>> On 18/02/2026 23:42, Siddharth Asthana wrote:
> 
>> I do think we should seriously consider reverting commits in the 
>> reverse order that they were created (i.e. do not set '--reverse' when 
>> setting up the rev-list options) to reduce the likely-hood of 
>> conflicts when reverting a sequence of commits.
> 
> Good catch. sequencer.c does exactly this in prepare_revs() -- it only 
> sets reverse for REPLAY_PICK, not REPLAY_REVERT, so git revert processes 
> newest-first.
> 
> The complication in replay is that pick_regular_commit() chains commits 
> through mapped_commit(base, onto). With oldest-first, the parent is 
> always already in replayed_commits so the chain works. With newest- 
> first, the parent hasn't been processed yet and mapped_commit() falls 
> back to onto -- so each revert be independently based on the original 
> branch tip instead of chaining.
> 
> The fix is straightforward: for revert mode, pass last_commit instead of 
> onto as the fallback in the main loop:
> 
>      pick_regular_commit(repo, commit, replayed_commits,
>                          mode == REPLAY_MODE_REVERT ? last_commit : onto,
>                          &merge_opt, &result, mode);

As we only allow a single range of commits with --revert that should work.

> That way each revert builds on the previous one regardless of walk 
> order. I will do this in v4 together with skipping the reverse=1 
> override for revert mode.

Great

>>> @@ -226,25 +269,46 @@ static struct commit 
>>> *pick_regular_commit(struct repository *repo,
>>>  [...]
>>> -    /* Drop commits that become empty */
>>> -    if (oideq(&replayed_base_tree->object.oid, &result->tree- 
>>> >object.oid) &&
>>> +    /* Drop commits that become empty (only for picks) */
>>
>> Why? What's the advantage in creating empty revert commits?
> 
> 
> Consistency with git revert, which doesn't silently drop empty reverts 
> either -- it stops and asks the user to deal with it. 

So does "git cherry-pick" unless you pass --empty=drop or --empty=keep 
(I was surprised that "git revert" does not support --empty, that seems 
to be an oversight)

> Since replay is 
> non-interactive and can't prompt, I kept them rather than silently 
> dropping, to avoid hiding that something unexpected happened.

I don't think creating empty commits for revert is very helpful, when 
cherry-picking one could argue that the user may want to preserve the 
commit message (though I think that's unlikely in practice which is why 
we drop commits that become empty) but that does not apply to revert.

> That being said, I don't feel strong about it. If you think dropping is 
> the better default for replay, I am  happy to change it. Or we could 
> error out (exit code 1) like we do for conflicts?

We don't error out when cherry-picking and so we shouldn't do that when 
reverting.

Thanks

Phillip

> 
> Thanks,
> Siddharth
> 
> 
>>
>>> +    if (mode == REPLAY_MODE_PICK &&
>>> +        oideq(&replayed_base_tree->object.oid, &result->tree- 
>>> >object.oid) &&
>>
>> Thanks
>>
>> Phillip
> 

