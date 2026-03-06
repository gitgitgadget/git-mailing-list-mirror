Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3381D5141
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772773530; cv=none; b=NbvWwVJs2BvEtxUifOegs0sTFKA2Nwm/e/Rf15SwYpxTCFwdO7MwPsg/E3RjfvjYlXIoDsNcG7Szf473+OvXWfaftBR7u2/I5+EgGBPPI5d6ORw/gqEkj/gr0Eq0bx0m19mX732eVj7Y2dG8abeFhsv98PdmpUdv3rEY0M3S1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772773530; c=relaxed/simple;
	bh=APP8HWq+09WnMT0tS+GCMeOFeSnngcql4dNgnYXuL6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ufy/xGQE/878zWIYLdfoRD1/aUVRiW3Xt40Rix/glc2wCD2jSfGwnpxeP4E3+DcwrxgR74pURt8Q6XoujkscNiVozvO4ptC6vaRW8/2bb8+uX9IK8xEt+B8mWo46yO/fH3asPEoExYgihEFATao+BKtyzPXxKpdF0DsLDH1s5gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzzyMIOq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzzyMIOq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae505619baso31389185ad.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 21:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772773529; x=1773378329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bGJ+878oQ57zf09WuRPWlWukg5DtQXg6VyBQj1l1eME=;
        b=FzzyMIOqtaCMglPaNYhZc6WwZPZdXAuFBHEzA9ovG2GgD8Lnb/UnvVzP4UyFD2nKvr
         G6mpFYnRB/b6akQuCTOVB8x+12EWkTJWVEmRdtZ9rbBClD9mOPsXDRjMgp6Pme1n7Rkw
         APz2fMVhqP9WiQB9NfF2mdVqJwJpYvnPabrC5g/6jtHp/oGiULnAkiPxWELi8Zf330Jb
         Izbgv2NBHgksqS/hje5nV5+F+/JzcpI/aodab7xM2rBml9hOK3HaWXW4ibKlX22ZCzP1
         jpPgYSxUsNVk2sundeV6Pn+KHZr/sSDabjtxSuwfkK5MotOyZ6INCKhTfU66olDCsmX4
         7ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772773529; x=1773378329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGJ+878oQ57zf09WuRPWlWukg5DtQXg6VyBQj1l1eME=;
        b=okdI52ynEsyxLj81vZOqUinfgecUuwJSNravHKW3N/pxLc2Cmcx9PRKz987mclGrO9
         wfh5fqcRFARse7eRda6JjWbkXzmIyRZtBhph5XZKxmHxhAKQMoUlPAd1C0ESxZKxqEfN
         T0teu+88jRUu8w9irgWAA1M7K0S5yOghfFADrwHs+wcfQH4q2AW5Gth/asoVANi1wNsY
         baSHP6UI34apk3/m3BU+xQuTnEUwFodGBHTiOGo1aC+Xs04ZmPq3MSW5RC8DCEme+jzp
         y+3LuGeZiOU1BciYdE4qCrXDV9w5I3VDALiwjFnWQ5TH2Ji+8EHpJ49xlhQe0t6ldQ6M
         8bMw==
X-Forwarded-Encrypted: i=1; AJvYcCXog1KN0eg+FmgVRGUUlPGmUJXaZxx5R4u9flZGqpat6B2eQHN8Bcg8px6lu/+WJlvIPwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznNhfUvnK3yPf5D8QENqzA6d27LzXizVrLLEHCd/BhtW96xL1S
	y8qClC9XxzCu4kc+qivMXJxaBc/wG4g2N/K9beYmrZt4wwtAlREDns7A
X-Gm-Gg: ATEYQzxqHE9Bxg1TgBp7IJo4uPZ8JtR+ETtIpsPBXwqwUlZ0xWg+BSFK95gUh2I0Gce
	I3jnq2+gYamfYvl/C7xajRdDtOYQZ/VASYrvO8DNBxlzJOzGc0+8xZ4cV3j5irD+iFSM8I5eGE3
	28+Hm66vEQ+G0h74qoQ6xhiiiNEu3EWq8weuKHgONN2FlETaP6oKCDoGUTworWMydTtbH4CQS7S
	xSqlMMhHTOLOitqwThWtXEnHKiC3JgSi/sfuGJWDqPb/btU+0FcT2PMHmVnY3cigLujaTwD1zb6
	JkDNhwvgOulzywXlGTt4SL3NHQhy6Ff3n8Y/poJgqtSx32Iv/TIs96baLkVKceS2sr+LfHphVAp
	pXynuPAUXcFUa42fhmr5XR4Kr2Kn0Fvr5o7wAKjImw9eK3U86tktzFw3VwzTn/xZaMKxhIL5bMQ
	WJtCfEg7Y12j+tGWec/M1IaQBImg2R3erMqTLoHOe5YcYgKI03FQ+8tmPhraIZvmDCbxPOC19gX
	jYMPr2dYGkb+odLQE4Xb4iwWlf0KzXcrMKK
X-Received: by 2002:a17:903:1a0f:b0:2ae:5a7c:286 with SMTP id d9443c01a7336-2ae823feab0mr10959815ad.4.1772773528822;
        Thu, 05 Mar 2026 21:05:28 -0800 (PST)
Received: from ?IPV6:2401:4900:862d:bb67:1c20:bec7:1904:ead0? ([2401:4900:862d:bb67:1c20:bec7:1904:ead0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83d85a2asm6125565ad.0.2026.03.05.21.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 21:05:28 -0800 (PST)
Message-ID: <31384cd8-6739-40dd-a963-ce1597921969@gmail.com>
Date: Fri, 6 Mar 2026 10:35:21 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] replay: add --revert mode to reverse commit
 changes
Content-Language: en-GB
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, johannes.schindelin@gmx.de
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-3-siddharthasthana31@gmail.com>
 <87tsvbe2sm.fsf@iotcl.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <87tsvbe2sm.fsf@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/02/26 23:05, Toon Claes wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
> 
>> Add a `--revert <branch>` mode to git replay that undoes the changes
>> introduced by the specified commits. Like --onto and --advance, --revert
>> is a standalone mode: it takes a branch argument and updates that branch
>> with the newly created revert commits.
>>
>> At GitLab, we need this in Gitaly for reverting commits directly on bare
>> repositories without requiring a working tree checkout.
>>
>> The approach is the same as sequencer.c's do_pick_commit() -- cherry-pick
>> and revert are just the same three-way merge with swapped arguments:
>>
>>    - Cherry-pick: merge(ancestor=parent, ours=current, theirs=commit)
>>    - Revert: merge(ancestor=commit, ours=current, theirs=parent)
>>
>> We swap the base and pickme trees passed to merge_incore_nonrecursive()
>> to reverse the diff direction.
>>
>> Revert commit messages follow the usual git revert conventions: prefixed
>> with "Revert" (or "Reapply" when reverting a revert), and including
>> "This reverts commit <hash>.". The author is set to the current user
>> rather than preserving the original author, matching git revert behavior.
>>
>> Helped-by: Christian Couder <christian.couder@gmail.com>
>> Helped-by: Patrick Steinhardt <ps@pks.im>
>> Helped-by: Elijah Newren <newren@gmail.com>
>> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
>> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---
>>   Documentation/git-replay.adoc |  37 +++++++-
>>   builtin/replay.c              |  25 ++++--
>>   replay.c                      | 162 ++++++++++++++++++++++++----------
>>   replay.h                      |  11 ++-
>>   t/t3650-replay-basics.sh      | 107 ++++++++++++++++++++--
>>   5 files changed, 277 insertions(+), 65 deletions(-)
>>
>> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
>> index 8d696ce3ab..ffdf790278 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
>>   SYNOPSIS
>>   --------
>>   [verse]
>> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>
>> +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
> 
> The modes `--onto`, `--advance` and `--revert` seem to be extremely
> different from each other. So I'm starting to wonder whether it won't
> make more sense to instead create subcommands instead of options for
> these. Maybe something like:


Agree the interface could be cleaner as subcommands. I think Christian's 
suggestion to do this separate series after --revert lands make sense -- 
we would get real-world usage feedback first, and it avoids scope creep 
here.


> 
>      git replay revert --base=<branch> <revision-range>
>      git replay pick --base=<branch> <revision-range>
>      git replay replay --base=<branch> <revision-range>
> 
> 

