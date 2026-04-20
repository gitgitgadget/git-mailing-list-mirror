Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5932F260F
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681225; cv=none; b=l+dS0TCT1iR166asyBwwDA+NKDk8U4Xqng3kOh8gKVRtFzAruQ0+Qd4e/XyzklEYpalmHElc3ulgJ1Q4QFIzvFi7T3c/BwTWTIomRiobJw7YiZ3TXN8fgdo3PUwRwy8V0D5VwKHrAGRjsHHOa6tAjgqUe9QJx3hBeVY0wxbCUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681225; c=relaxed/simple;
	bh=Eh7N8Tq3c2IncpkELV09bKcn2W8/m2feAaqy18U+zGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuB2WIkPDtXCG6ZFjVzcq9gPpQcVL9n0TU+JCQQXLxbbm831gWXVoAAWvP8KjDIbeeFGKTqnEWUHPx2kN+J90Ejz1ZuJTbFg1+EHaegB88jMnjJW9Ufy8g9PXKDC+RNlK8lqtb+IdslCFbYrvbr0mrUTFEOFEzWy0DKsboL52pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+Fx4dfP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+Fx4dfP"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f4a53ae20so2181723b3a.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776681224; x=1777286024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhJjl6QNu+4vtuKWgt372+XZ73jzk+LYaPrMn8FXvrM=;
        b=q+Fx4dfP+YLUhtPsw8GC888FrUYngeqfWzMH+5NpRlJlwFwvA8Wf1YqKwRrpReEmnt
         wYullgRkan8Bi0/JSMW2w/QjXj+j1awxAmOsjbz+IuPP4YS/WeqqjzGibYvNhKmcq6Et
         EU27F83PB98fsFPPfI9ErFaCNwLg7gmkp7E8/GsN7j7lU3RSDylnX3vQIbKLL/LOYn0s
         Ub3pU8BMBS68fenkQubvniDvZY/fvpSw+CsYMK+r4lUwtfBfyUKnqOSnrcu3kRkVC06o
         tgtqVqV5/gEuDo9kFggDXOWve9Y2qCM7ifgzMxBvN4KhhBNGZmaPWie6v2Dj1aQctbax
         sQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776681224; x=1777286024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhJjl6QNu+4vtuKWgt372+XZ73jzk+LYaPrMn8FXvrM=;
        b=hPfjhr6nVZrF2MZQk8mWa0IcQxqWvllLieO+xTEliGS/aTggEoa5FtwK8xvHcnPevC
         FckZdze3Z2kpwKbXmJQjuvV+TwMrU9AfZjpcp+yXc7L3JwV33pOi6vfSQMyVJR1GYr9M
         S8Al129kBK2S6MzRmE4v9zT79ohb190jushncZBX0Mf32trAH9B92RygXy5GJf6YePrI
         O0RYNCjy59dQ+hdtAR8kJqxfwXeAdPQSmh19MmyKcWb6g90MJiXXiqjcQFV1t+0aqlKe
         l5XI3npl4pA/J8WcIvTRydyo9/LO8fXP3UIJJba/O41zu+hxNvcr8LSVve0DcxlakDbZ
         lOCA==
X-Gm-Message-State: AOJu0YzruBLkYtfO1LN6n70XE9DwoTu8q92bxIw1hFwRLUXiKRAeJsLS
	XGUVJUTGa2AIWzLXGhTq+oMXgpvKJiTptHmxCu8kRqQcf4eO1comXTQW
X-Gm-Gg: AeBDieu6WaOKPE0FsSpp5KJB0RV3dNN0cPJD/Adyvn8GyBBp28I5vYSzKQNqTG5Fmzn
	7k8OVvjIm4DLpw4NoQ9Zzh0MvN5Kly0eRMs19QslLFapiu28OIw2CigGEz1YsD8c96F+H/w1Gva
	XYNCPflpWcRBqqO7MhUV0cov6y3qV9h5l+Oq3XP6buMYphUu0GqExPb8d5agn0h3sCKrFOtnUUo
	NV9d4xGLoduBy+VyNy3o5RM8af6PTUyeKR/AllzIR3JQtzxk9uJpB3B8RdQ5HDgu7u27pSq4Oq5
	2t1qzNOVRj/pI2Ys3GWJByVOFkBdu3hX48Y9haPWGcTY4tYDE4XZ2+hRGNV2ddR5zkgpLVyz/Ex
	XQ6hPATBv7iwoah3sQYcqYyX65bKwRiISEM4czXtAbkF2ylm2BOEpdxlOvCo49HaxcOEjH807x8
	ArbTiXxntjFAbilqFE7dtTLu4MBCIdrsZYBIiitiLhP4vs3aOKYj5RB8fDjezVA62TJqxf2ambZ
	nogu5hQokA9Qx/imjam1an1EKAXPZrl24faCt0v53fa
X-Received: by 2002:a05:6a00:2ea5:b0:82f:8a29:e3e0 with SMTP id d2e1a72fcca58-82f8c91bc7dmr14940288b3a.42.1776681223700;
        Mon, 20 Apr 2026 03:33:43 -0700 (PDT)
Received: from ?IPV6:2401:4900:86e8:71dc:a082:d961:4e27:7d6? ([2401:4900:86e8:71dc:a082:d961:4e27:7d6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d35acsm10631408b3a.15.2026.04.20.03.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 03:33:41 -0700 (PDT)
Message-ID: <3bb52232-ebe4-4c50-a674-943a175e983d@gmail.com>
Date: Mon, 20 Apr 2026 16:03:36 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rev-list: add --missing=print-only mode
Content-Language: en-GB
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, toon@iotcl.com,
 karthik.188@gmail.com, justin@parity.io
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
 <20260419084840.33986-2-siddharthasthana31@gmail.com>
 <aeXZOAtILSr638LG@pks.im>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <aeXZOAtILSr638LG@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/04/26 13:13, Patrick Steinhardt wrote:
> On Sun, Apr 19, 2026 at 02:18:40PM +0530, Siddharth Asthana wrote:
>> When working with partial clones, it's common to want just the list of
>> missing objects. The current --missing=print mode does this but mixes
>> present and missing objects together, with missing ones prefixed by '?'.
>> Getting only the missing OIDs requires an extra pipe:
>>
>>    git rev-list --objects --all --missing=print | perl -ne 'print if s/^[?]//'
>>
>> Add --missing=print-only which outputs only the missing object OIDs, one
>> per line, without any prefix. This makes the above one-liner unnecessary
>> and the output directly usable by downstream tools.
> 
> Naming is a bit tough, as "print-only" sounds as if we're only printing
> them without doing anything else, but it doesn't quite convey the


The name came from Christian's original suggesttion in the issue [1], 
but agreed it's ambiguous. Phillip's --missing-only approach solve this.

[1] https://gitlab.com/gitlab-org/git/-/work_items/80#note_464005298


> relation to non-missing objects. I don't really have a better suggestion
> though -- "print-exclusively" may convey the meaning a tiny bit better,
> but still suffers kind of the same issue.
> 
>> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
>> index 8f63003709..ba7e3e3919 100644
>> --- a/builtin/rev-list.c
>> +++ b/builtin/rev-list.c
>> @@ -104,14 +104,22 @@ static void missing_objects_map_entry_free(void *e)
>>   
>>   static struct oidmap missing_objects;
>>   enum missing_action {
>> -	MA_ERROR = 0,    /* fail if any missing objects are encountered */
>> -	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
>> -	MA_PRINT,        /* print ALL missing objects in special section */
>> -	MA_PRINT_INFO,   /* same as MA_PRINT but also prints missing object info */
>> +	MA_ERROR = 0, /* fail if any missing objects are encountered */
>> +	MA_ALLOW_ANY, /* silently allow ALL missing objects */
>> +	MA_PRINT, /* print ALL missing objects in special section */
>> +	MA_PRINT_INFO, /* same as MA_PRINT but also prints missing object info */
>> +	MA_PRINT_ONLY, /* print ONLY missing objects, without the "?" prefix */
> 
> Makes me wonder whether we'll eventually also want to have
> `MA_PRINT_INFO_ONLY`.



Right - that's the strongest argument for --missing-only as a separate 
flag. Gets us that for free.


> 
>>   	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
>>   };
>>   static enum missing_action arg_missing_action;
>>   
>> +static inline int missing_action_prints(void)
> 
> How about naming this `should_print_missing_object()` instead? That
> gives the reader a bit more context.


The function is a predicate on the mode, not on a specific object, so 
that name would be slightly misleading. But with --missing-only this 
helper might change shape anyway. WDYT?



> 
>> @@ -1011,7 +1036,7 @@ int cmd_rev_list(int argc,
>>   
>>   	stop_progress(&progress);
>>   
>> -	if (revs.count) {
>> +	if (revs.count && arg_missing_action != MA_PRINT_ONLY) {
>>   		if (revs.left_right && revs.cherry_mark)
>>   			printf("%d\t%d\t%d\n", revs.count_left, revs.count_right, revs.count_same);
>>   		else if (revs.left_right)
> 
> Not a fault of your patch, but I really feel like git-rev-list(1) is
> becoming more and more tangled. The fact that we have to add this check
> to so many different sites doesn't inspire confidence that we have
> indeed catched all of them that need this check.
> 
> It would be great if this was reworked a bit to become more obvious, but
> that's probably outside the scope of this patch series.
> 
>> diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
>> index 08e92dd002..105560ad21 100755
>> --- a/t/t6022-rev-list-missing.sh
>> +++ b/t/t6022-rev-list-missing.sh
>> @@ -198,6 +198,32 @@ do
>>   	'
>>   done
>>   
>> +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
>> +do
>> +	test_expect_success "rev-list --missing=print-only with missing $obj" '
>> +		oid="$(git rev-parse $obj)" &&
>> +		path=".git/objects/$(test_oid_to_path $oid)" &&
>> +
>> +		# Capture present OIDs before hiding anything.
>> +		git rev-list --objects --no-object-names HEAD ^$obj >present.raw &&
>> +
>> +		mv "$path" "$path.hidden" &&
>> +		test_when_finished "mv $path.hidden $path" &&
>> +
>> +		git rev-list --missing=print-only --objects --no-object-names \
>> +			HEAD >actual &&
>> +
>> +		# Only the missing OID should appear, without the "?" prefix.
>> +		grep "^$oid$" actual &&
>> +
>> +		# Present objects must NOT appear in the output.
>> +		while read present_oid
>> +		do
>> +			! grep "^$present_oid$" actual || return 1
>> +		done <present.raw
> 
> How many present object IDs do we have? I'm a bit worried that we now
> execute grep(1) hundreds of times. Can we maybe do some tricks with
> comm(1) instead?


Phillip's test_cmp approach is simpler, since we hide one object, the 
output should be exactly that OID. Will use that.


Thanks,
Asthana


> 
> Thanks!
> 
> Patrick

