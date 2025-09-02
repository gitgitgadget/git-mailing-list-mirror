Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB81DE2A0
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826012; cv=none; b=LEIcTV5N4q1mph8az35Z80GV7tXbsrpBmFdxvYqFtD3UNq/nimzjOx+1MfSSDDt9qMCjHLViaWD7nQnBLbMeJ/s4qHgxJSHFJIiIWsM2I1h0hWSTUQUlH0HexvaAnEikM5On3PLkCYsB01nDuayQX6BJAhhoOR5jlAbJ7wnLPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826012; c=relaxed/simple;
	bh=Rbvgr974j94jFzfN3+ihy2NZ5Mv9vpUSwNKmyHUrWFE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iAvDtyBju4LZIsdAG2xhlhshtjjYqur1Mw0JiKdRbSoCbMoKVXVvvy2MuMePvmYaPEySBti0XQ+oRLO+vNamMQIs3SGyL3QOXQTuo74r9l5LKlNOTLZBHGh0nPYr0yGGWmwchvOoHJkSYLRTPmC9+fUkKPD7xGzoYcn/6WEbdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLWDpQoE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLWDpQoE"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d44d734cabso1926027f8f.3
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756826009; x=1757430809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mVH3x5MkCNGu3GOkDow7cKLtIwDcooMSLTP1vMKe6dU=;
        b=PLWDpQoE77DfNteDLlI+ToNPTAYPXhOSHzZ6mxlL9DonMz2CW+rd0H1q+sB8Ew2nfe
         qLnGRj/RMsD8lT93kX45SQqVDL88XZSq0Hv9fWBKnoG2vwq4M1sw+WDSa75eTB3UdDAX
         +z4pxnL5CFNxjSI3z+HfyQSzeliSQS785L9yKmqktlQOzSrEP8tva1ql8xqNCxudA6G1
         MOeX0n7/LP+yR6Xj7aq0AaRy0/I6A8cIr2j7oRN0C4Uge0kYCEKNzcppWzIQwPGLRdQ1
         Wl2cRrEhZMPzWV6ZZWxcdffPRbSd6BbSAjp/71wys8w4C0E/KedWVGZ6w/9gemTOtood
         vIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756826009; x=1757430809;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVH3x5MkCNGu3GOkDow7cKLtIwDcooMSLTP1vMKe6dU=;
        b=mVJkJBUxB7U6hgea3TjnyIUFEnyKyDCbRXqYTJ0xgq7Oo6rXrvIuUGe7O3uyJ4WXpZ
         pc1fUVoyO/ijmox1/dXWnwdexA4Xh+j/gr3redkyQMRp5pKpnztEqGT3PZ2TbhgOhVXP
         o3aAWqLJpFauDSzAjvyqQZT4b/PbNaZkCW181nkLdWCt/obJsaiaFFKAW3hu6RxOAqZq
         ir0iro3kvfwg2S42Irgt2IA6RZ2VtRkMA5WOapz8Ynpbsqdt3OwcsROoQ2HUQmKUuN9p
         PvL4C/nUJUBpF1tP+G4voquLxo3/nWPlaEFxCvUnVbHdYcBN76b6YFRARUM/9Uh4bt3X
         1SXQ==
X-Gm-Message-State: AOJu0Yzui1+JlAFnbMsBaQqRzLdGX6IWpqQFPkTBZE+ihUWona58ewbr
	6drkCnupdQsAxl90kVqHGOx/HE4hRdHAmFNEyEp5jB3xv4djAfci+BuL
X-Gm-Gg: ASbGnctTTv/bxsJbdE6aaQ+qx8XaJjtig9CrY+M9bOV0qioiEK/rllnQJUzfqCjiUY1
	ljX+kh2zRHypYHuYsWaNfhgoMtN5VKfKDt748PqjXw87E73bButrnQRo2jqaaTWmQA3XdaSROAY
	9DM90Szx667xyHjW5hFewut10Ra9H4i49ZVKTJec3lO36gmISJRfq7fu4FX3FNGZs49IQnxwmru
	NuR3sJTlhIlrFKx/IN0BBL446e95ORV4BFHM5h/tGczdTE3bHEy5o7qzG48DnDVyjqjdOnkOcBK
	OhCWunJJnJrXajgg5axYk01Bn75L/v2RRujcZx4sNlploLlEXe6P2m8anetx/U5o3OaLe4qIMb9
	NeAi9PMhxaNrlZDCkv7ffJM6FSrrBquhe5c/vXRZKxqFHcC8MO5OElBz/QY06WStMHurOjy1vQl
	klnEu43Tx6zpGBD3k=
X-Google-Smtp-Source: AGHT+IHZ3ozYwMlbsuvvtn1pyHucy99B//xI8sYcMkbbK1J7O9kZDrZR2fmqFVy9WBxd4NpkOsZY/g==
X-Received: by 2002:a5d:6495:0:b0:3da:e7d7:f1ec with SMTP id ffacd0b85a97d-3dae7d7f7camr1335207f8f.32.1756826008968;
        Tue, 02 Sep 2025 08:13:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d60cf93cb2sm11138998f8f.12.2025.09.02.08.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 08:13:28 -0700 (PDT)
Message-ID: <96e128d9-e5e3-4bfc-9e33-3caa75cacfe6@gmail.com>
Date: Tue, 2 Sep 2025 16:13:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] breaking-changes: switch default branch to main
To: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
 <aLbWuGQhriQCMFbO@pks.im>
Content-Language: en-US
In-Reply-To: <aLbWuGQhriQCMFbO@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 02/09/2025 12:36, Patrick Steinhardt wrote:
> On Wed, Aug 27, 2025 at 04:24:50PM +0100, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The advice printed when init.defaultBranch is not set is
>> updated to say that the default will change to "main" in Git
>> 3.0. Building with WITH_BREAKING_CHANGES enabled removes the advice,
>> changes the default branch name is "main" and removes support for
> 
> s/is/to/
> 
>> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME. The code in guess_remote_head()
> 
> As Junio already mentioned, I don't really think it's necessary to drop
> `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME`, making much of this commit
> series obsolete.

I'm happy to drop those patches if there is a consensus that 
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME is still useful after we've 
switched the branch name. I'm still not quite sure what it is useful for 
though. Removing it makes it clear that the tests are relying on the 
builtin default branch name that users see rather than some special name 
used only for tests.

>> that looks for "refs/heads/master" is left unchanged as that is only
>> called when the remote server does not support the symref capability
>> in the v0 protocol or the symref extension to the ls-refs list in the
>> v2 protocol. Such an old server is more likely to be using "master"
>> as the default branch name.
> 
> Hm, that's probably fair.

That's more or less a direct quote from Peff's mail 
<20250826111234.GA1925107@coredump.intra.peff.net>
>> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
>> index f8d2eba061c..93922299321 100644
>> --- a/Documentation/BreakingChanges.adoc
>> +++ b/Documentation/BreakingChanges.adoc
>> @@ -165,6 +165,11 @@ A prerequisite for this change is that the ecosystem is ready to support the
>>   "reftable" format. Most importantly, alternative implementations of Git like
>>   JGit, libgit2 and Gitoxide need to support it.
>>   
>> +* The default branch name will be `main`. We have been warning that the default
> 
> Let's explicitly mention here that this is only going to be the case for
> _new_ repositories. It's obvious to us, but for others it might not be
> that existing repositories will not see any change in behaviour due to
> this.

Sure

>> diff --git a/advice.h b/advice.h
>> index 727dcecf4a3..fc1dc872049 100644
>> --- a/advice.h
>> +++ b/advice.h
>> @@ -18,7 +18,9 @@ enum advice_type {
>>   	ADVICE_AM_WORK_DIR,
>>   	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
>>   	ADVICE_COMMIT_BEFORE_MERGE,
>> +#ifndef WITH_BREAKING_CHANGES
>>   	ADVICE_DEFAULT_BRANCH_NAME,
>> +#endif /* WITH_BREAKING_CHANGES */
>>   	ADVICE_DETACHED_HEAD,
>>   	ADVICE_DIVERGING,
>>   	ADVICE_FETCH_SET_HEAD_WARN,
> 
> Okay. I don't really think it's necessary to conditionally compile this,
> but it doesn't hurt much, either.

My thought was that by making it conditional, it makes it harder to 
forget to remove this after Git 3.0
>> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>> index 01823fd0f14..a21834043f3 100755
>> --- a/ci/run-build-and-tests.sh
>> +++ b/ci/run-build-and-tests.sh
>> @@ -9,7 +9,6 @@ run_tests=t
>>   
>>   case "$jobname" in
>>   linux-breaking-changes)
>> -	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>>   	export WITH_BREAKING_CHANGES=YesPlease
>>   	;;
>>   linux-TEST-vars)
> 
> Nice.

Only if we remove GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME though? Part of 
the reason for removing it was to make it clear that the tests are using 
"main" when WITH_BREAKING_CHANGES is enabled.

>> diff --git a/refs.c b/refs.c
>> index 4ff55cf24f6..e73f63ff6b8 100644
>> --- a/refs.c
>> +++ b/refs.c
 >> [...]>> +#ifdef WITH_BREAKING_CHANGES
>> +		ret = xstrdup("main");
>> +		(void) quiet; /* Silence -Wunused-parameter */
> 
> We have the `MAYBE_UNUSED` attribute that you can apply to `int
> quiet` to avoid this cast.

Thanks, I didn't know we had that

>> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
>> index f593c536874..7223a98773d 100755
>> --- a/t/t0001-init.sh
>> +++ b/t/t0001-init.sh
>> [...]
> Should we also add a test conditional on `WITH_BREAKING_CHANGES` to
> verify that the new branch name is `main` as expected?

If we remove GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME then all of the tests 
that rely on the branch name "main" are testing that. If we keep that 
variable then we should probably add a test that unsets 
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME and ensures the default branch name 
is "main"
> Thanks for working on this change, I'm very much supportive of this. It
> feels like the ecosystem has already been moving into that direction, so
> it's time that Git catches up with that change.

Thanks for your comments, I'll try and re-roll later this week.

Phillip

