Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E1D139CE0
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675080; cv=none; b=kYqax60/85fzdnBMVIE/vlcF1iWWrfrVY2GxvOWvZbkT02lsYnEflLExsOEjM8RNs8PhV/nyCRjDu4oJJhB7svR3+dTZDxoE3HzO60n4+j3YfLD3gT0dH+RZWiGLjVHM/OWbY54eiKXyQnPQcfxt/CjvBY8f8TtzZjD5RcagJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675080; c=relaxed/simple;
	bh=foHQ9SBQyAv6UuqElHVKUql1YNLP8GxGyxRU8dw0BSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMuKwVi++IgoSTk0TWQQFnf2jVztknTU40O+x1DEINJ5+JKvrBuUKMQOiRSEN247pChwsn33s9j8mVRbu/X5BAt4TS2kfPi6vKVPs1DZH54Dg+wafsgxq+J1/8/ia9wjYWy6Yi+v0pcLTaIup20b83gvE8u0Okukz6xwrca2whI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uymmn0WM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uymmn0WM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41551639550so39928135e9.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712675076; x=1713279876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6VWTf9d7vJYAJrGfu3QohZ3ac+ZAlXPQzGXGsyuZLAg=;
        b=Uymmn0WMsAhYZseV5AKDnO2IXfXBfGx6JD/SG5A35fFDjtXyRtiD5thFEy72YPDh5i
         qft9qKZH7edBhuJl5aVaTy/u1V4CDb8Fz2nCnIHlUGrxXIBtNVLLiYOE+15Ty+LcRnkL
         ElKAcCFbYTaLiXH3vY/6au/uAR5TgwmMs5wbol7zDP+Xso2h7juUuGZGiMcFuaH+/pWU
         tyOEC1af+wGpbfgtFPaNba2rqKOthfv5wt86oBSFRMDmbGp7+xDn7vvtxlLRbnwjdAWE
         EZaewtblmvEFz/bZi0+5dk54DRYXJ47EshQ4wR0pGjMkIGfD+DTqb3aqaX0/bMEPQ9A/
         FpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712675076; x=1713279876;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VWTf9d7vJYAJrGfu3QohZ3ac+ZAlXPQzGXGsyuZLAg=;
        b=KVCmFAbcreILUIE11sZUclbQ5MdiHU78wZGP/RyXRQtwMfR820c5+AqnUaCpi2Z/pe
         i5f6L1YEe7pYwekdhapFaL3hOGfVlI5Labh80stl7Xed4+DrtLM6x+Yajr1jarSgsnu3
         CDRsylbe5TJgy2AN3D3tI98FNNCAdbo0TWd0dt+mxp6V7pbdu3cuwuZ9o69NpcTmgMRn
         LuPiWFKE/P5jYMMvduicjih8LP2ODFWqyEPdn5EKc49oNHThCIEKLxwslwraLUu6CoKQ
         Pj1Cdul0m7v8BE/WP5lapB6ANYITXt8+zUlI6vvOHfuX00GcBoZTf8VdYdGNzJ1632jB
         lRYQ==
X-Gm-Message-State: AOJu0YyVfbSSKuLVif/DhG6HK+4DU+52i5Hca0uyPDBukuTGNda+gXcH
	SD0twqatp990eqJZSKSV5YacWMcc/NsRWpp8tUpAOv/kfc0IoViP
X-Google-Smtp-Source: AGHT+IF0pTynNfAWb11F5iEJVTi1nP0Ykt1zSdM202hV4WbvwIbYJMkaqrPUa098BqRP0/dQqSVTWg==
X-Received: by 2002:a05:600c:468f:b0:414:cbd:1ee2 with SMTP id p15-20020a05600c468f00b004140cbd1ee2mr11275206wmo.35.1712675076147;
        Tue, 09 Apr 2024 08:04:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d5187000000b003434c764f01sm11658892wrv.107.2024.04.09.08.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:04:35 -0700 (PDT)
Message-ID: <1b74f6f9-f4b9-4909-82b3-26f19b7a1347@gmail.com>
Date: Tue, 9 Apr 2024 16:04:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase -i: improve error message when picking
 merge
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
 <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
 <fbc6746e0188ed7b69c238935ec85b69112ddd79.1712585788.git.gitgitgadget@gmail.com>
 <xmqqle5n7ajt.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqle5n7ajt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 08/04/2024 23:29, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +	case TODO_EDIT:
>> +		return error(_("'%s' does not accept merge commits, "
>> +			       "please use '%s' followed by '%s'"),
>> +			     todo_command_info[command].str,
>> +			     "merge -C", "break");
> 
> OK.  And when hitting the "break", they know that they are supposed
> to say "git commit --amend" and then "git rebase --continue"?

Yes. I guess we could add a hint to that effect if you think its worth it.

>>   	item->commit = lookup_commit_reference(r, &commit_oid);
>> -	return item->commit ? 0 : -1;
>> +	if (!item->commit)
>> +		return -1;
>> +	if (is_rebase_i(opts) && item->command != TODO_MERGE &&
>> +	    item->commit->parents && item->commit->parents->next)
>> +		return error_merge_commit(item->command);
> 
> This is good for now, but we may see command other than TODO_MERGE
> learn how to handle a merge commit, and when that happens, I wonder
> what we want to do here.  One thought is to do this:
> 
> 	if (is_rebase_i(opts) && is_merge_commit(item->commit))
>          	return error_merge_commit(item);
> 
> and teach error_merge_commit() to silently return 0 on TODO_MERGE.
> Other commands, when they learn how to deal with a merge commit,
> will then update their entries in error_merge_commit().
f
It feels funny to call error_merge_commit() for a command that we know 
supports merges but I can see that would make it easier to extend in the 
future.

> Would we want to customize the message from error_merge_commit() to
> make it closer to cut-and-paste ready?  For that, something like
> 
> 	int error_merge_commit(struct todo_item *item)
> 	{
> 		switch (item->command) {
> 		case TODO_PICK:
> 			return error(_("'%s'" is bad, plase use "
> 				       '%s %s'"),
> 				todo_command_info[item->command].str,
> 				"merge -C",
> 				oid_to_hex(item->commit->oid));
> 		...
> 		}
> 	}
> 
> might go in a more friendly way.

If we want something the user can cut and paste then we would need to 
suggest a second parent for the merge. We cannot just use the existing 
parent as it may be rebased which means tracking all the commits we see 
while parsing the list. If the second parent is rebased we need to make 
sure the user labels it so we can use that label here. For that reason 
(and the fact that I don't think can we really tell what the user was 
hoping to achieve) I think the best we can do is point the user in the 
direction of the "merge" command even though that leaves them to figure 
out what to do with that command.

Best Wishes

Phillip

