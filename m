Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948301A0712
	for <git@vger.kernel.org>; Sat, 24 May 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748093920; cv=none; b=JcgIPklPRr8lTGun+wx42ST1tWHdNRTQnzDizhZiFrJq+8fM7sew2rj1zuaSLnYfefZZRI4cI90NExOp++OCewEaaQr8/uSKkDiyUKWpXz/ERhQvvw2cHJ9lzQdK3b+G/z+ko3gmKxl7mxW7pJ546T4YAnKXfXZX+7ksirnE7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748093920; c=relaxed/simple;
	bh=1TV7giyrNG/Zp+zp7YSS8nNgEsium7ncYiXPl3b5Aww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxS5t8LJGN/wD2hLxROkgw34PFVCpBdTK9AKbxYaM+Eh3MMhuHwyolaeG9fIIgHB+SIMaDLvQQNfwFQefmRCQrlJp9yXWc19u2KLeVzsbCFWm54XKLVkkeUFq7fgYXNPZViITxM9smk0JiGLwk6u2fY6qVqwo6bl8L5ih8Ni420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4sPFiZg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4sPFiZg"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4c95fc276so903819f8f.3
        for <git@vger.kernel.org>; Sat, 24 May 2025 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748093917; x=1748698717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZw5O+1sK6Uv8fUDZBhVdi1JzkTnSBJi5ue1GXnNJS8=;
        b=U4sPFiZgmidE11kTPYAoPCSmYsV+oMQN8tYZULEo+kVVhS7oAnHO/jht+EI4yO+Eov
         HJAKjiTv59GJN347GVv/WwEIGTyWj5D2RdulUi+tDViDrnvXOLMKAHquJOuqaZmITcg5
         sDodiGX/SrMDJecdjluhFKJOln8wrRmhRWVYzofsX8uXw5k+6bLHQKXsHkOvlkhs085b
         MrC9SArauNyl/P21X+H6aX6l++PIwEoaYUzYH0MUMCHhi59lLy02MmMXGRiuKzsaaRww
         uIuwCNfLpUhxPvNt5JNvx6BiJ3g33XJJVCyJjoJtx20gWHOAH+tNy0/Livk195diiapr
         cjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748093917; x=1748698717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZw5O+1sK6Uv8fUDZBhVdi1JzkTnSBJi5ue1GXnNJS8=;
        b=UwCE77sq58ACAzFyNKQFlkSvV2UCwjWZkOmPQxicmJ2/jomgjJlFmvBy1vVTBKudUt
         SJSSyWX+oGfK0ve0wbO53yvCkIgiRraxl0eIcMxcLn1rGYPLnRYiMT7HksfIVbNeclvr
         BK1ynxaoyyPGMy2m7zMo8IhKSgHv3LnZrd88m4tOQquBHOrByvRJ6RPjOBCXHbXZjQ5p
         kx5yX1ZIpZr3rpgAo0jFrQUcP1eiH/O6XuC8/8q4aktAFDz2Xae25UmveoYSnzXJYE9/
         ukQ+vgr29MFk0m58GUKcFBg7f9CoiaZk/zG+NVP8xAh1RrIlOAx9Z6BuPF/SBysLRDmH
         8iqg==
X-Forwarded-Encrypted: i=1; AJvYcCVqs5idx4zzl2O3hpr3e+zknOA3DkqOdw1zLpkmk8g/FJNp2HbfZnGoLJ29VsZVKgBHupM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5vrldzGNl8o8d9epy/9kank2tmyFeZg9tQb5NvU4BUz7WXuuT
	BnBSv3FQgNOYjABJT/qsFwobRVbXRryEy/490nuHTIuiry+F4NtJ/qbV
X-Gm-Gg: ASbGncvoSWOb16idSRvK+QkQ2v1bIaBoOusERhXZR56qVpKHxVLa9yyBpbwXJBlGbWG
	ouxpiUF1iOVR5JXuKYOMmXnziYu3Barw1RtIMwD+6XXiUVAlo58dHwseA3QQa8gHcuxLNpc16hD
	nxKMwIWXfcapAQULMAFCJ1iiwNf2j94CXXAr+tlh0IJujFDuO0t64d9RSiZxh9FWKNHqSFtAWUK
	QvlX6A6MqoVlclem6HL808bbf0h5QEEzYzCy1fdgtTQqdE4NFu5aeLrFx/+tm4Af7TY/WrjM2sU
	Exc2f+/8X9NBH1qcMR+UVcLKzbS9KUZH/V/AwJ5Nb0Rwsw6MlIPEnx9Gcnm8Y+gng/Vl4RUz/jm
	ukAU5LW4fb1Mw6SxP0C8UuVAe1Q0/I32V6H1KfQ==
X-Google-Smtp-Source: AGHT+IHi8ldl0mtm7DWG+wI2iF2Ig8PC0z3/IXuyZIzTqeZDav6I7nbyUifySFIhK86XOCHFlzW38w==
X-Received: by 2002:a05:6000:2082:b0:3a1:fb11:4b36 with SMTP id ffacd0b85a97d-3a4cb489a1cmr2507419f8f.47.1748093916478;
        Sat, 24 May 2025 06:38:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d0d708b4sm671788f8f.50.2025.05.24.06.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 May 2025 06:38:35 -0700 (PDT)
Message-ID: <2b9c5e91-67ab-4e46-93c4-15c8b79841be@gmail.com>
Date: Sat, 24 May 2025 14:38:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Fix buffer underflow in xdl_build_script
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Alex via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Alex <alexguo1023@gmail.com>, jinyaoguo <guo846@purdue.edu>
References: <pull.1976.git.git.1748033500935.gitgitgadget@gmail.com>
 <037b4612-ea92-45bf-bacb-ba66204f941e@web.de>
 <a58bf04a-d9fc-4ecf-96a5-82d31ada510d@web.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <a58bf04a-d9fc-4ecf-96a5-82d31ada510d@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/05/2025 10:08, René Scharfe wrote:
> Am 24.05.25 um 07:57 schrieb RenÃ© Scharfe:
>> Am 23.05.25 um 22:51 schrieb Alex via GitGitGadget:
>>> From: jinyaoguo <guo846@purdue.edu>
>>>
>>> The loop in xdl_build_script used `i1 >= 0 || i2 >= 0`, causing
>>> `i1` (or `i2`) to reach 0 and then access `rchg1[i1-1]` (or
>>> `rchg2[i2-1]`), which underflows the buffer.
>>> This commit adds explicit `i1 > 0` and `i2 > 0` checks around
>>> those array accesses to prevent invalid negative indexing.
>>
>> xdl_prepare_ctx() in xdiff/xprepare.c allocates an extra entry at both
>> ends for rchg arrays, so an index of -1 should be within the bounds.

and rchg[-1] == 0 so i1 and i2 can never drop below -1

>> i1 and i2 are decreased in lockstep, though, so one of them can become
>> smaller than -1 if nrec is different between the files.  And that's how
>> this code run can indeed run off into the weeds.
> 
> Actually no, i1 can't seem to reach 0 without i2 also being 0 and vice
> versa.  Or can it?  It makes sense that we reach the start of both
> buffers at the same time if we walk backwards from the end, don't
> misstep and have consistent rchg array contents, but I'm not sure.
The code looks like

	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, 
i2--)
		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
			for (l1 = i1; rchg1[i1 - 1]; i1--);
			for (l2 = i2; rchg2[i2 - 1]; i2--);

I think I've convinced myself that it is safe assuming there are an 
equal number of unchanged lines in rchg1 and rchg2 and rchg1[-1] == 
rchg2[-1] == 0. Each iteration consumes any changed lines in the 
preimage and the postimage plus a single context line from each (apart 
from the final iteration when the context lines may have been 
exhausted). At the start of the last iteration there are three possibilities

  - i1 == -1 && i2 >= 0 => there are insertions as the start of the file.
    As the context lines in the preimage have been exhausted all the
    remaining rchg2 elements represent added lines and are consumed by
    for (l2 = i2; rchg2[i2 - 1]; i2--) so at the end of the loop body
    i2 == 0 and the outer loop will exit.

  - i1 >= 0 && i2 == -1 => there are deletions at the start of the file.
    As the context lines in the postimage have been exhausted all the
    remaining rchg1 elements represent deleted lines and are consumed by
    for (l1 = i1; rchg1[i1 - 1]; i1--) so at the end of the loop body
    i1 == 0 and the outer loop will exit.

  - i1 >= 0 && i2 >= 0 => the first line is unchanged or there are
    insertions and deletions at the beginning of the file. At the end of
    the loop body i1 == 0 && i2 == 0 and the outer loop will exit.

We could add

     if (i1 < -1 || i2 < -1)
         BUG("mismatched context line count");

before "if (rchg1[i1 - 1] || rchg2[i2 - 1])" inside the loop if we're 
worried about bugs that break the assumption that there are equal 
numbers of context lines on each side. Any such bug would generate 
invalid diffs. I don't know how likely that is to happen in practice.

Best Wishes

Phillip

> 
> Are you able to demonstrate any out-of-bounds access with e.g.,
> Valgrind, AddressSanitizer or an assertion?
> 
>> Curiously, AddressSanitizer doesn't report anything, but if I add the
>> following line after the outer for, I can trigger it to report a
>> heap-buffer-overflow with e.g., git show 8613c2bb6c:
>>
>> 	if (i1 < 0 || i2 < 0) fprintf(stderr, "Oops: %ld %ld\n", i1, i2);
> 
> That's because I forgot to add braces.  D'oh!  I can't trigger any
> out-of-bounds access or that Oops with them properly in place.  So I
> let myself get fooled by a daring coding style. :-|
> 
>>
>>>
>>> Signed-off-by: Alex Guo <alexguo1023@gmail.com>
>>> ---
>>>      Fix buffer underflow in xdl_build_script
>>>
>>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1976%2Fmugitya03%2Fbuf-1-v1
>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1976/mugitya03/buf-1-v1
>>> Pull-Request: https://github.com/git/git/pull/1976
>>>
>>>   xdiff/xdiffi.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>>> index 5a96e36dfbe..2e983965328 100644
>>> --- a/xdiff/xdiffi.c
>>> +++ b/xdiff/xdiffi.c
>>> @@ -951,9 +951,10 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
>>>   	 * Trivial. Collects "groups" of changes and creates an edit script.
> 
> Trivial for Davide perhaps (libxdiff author), but not my mushy brain..
> 
>>>   	 */
>>>   	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
>>
>> Should the || be a && instead?  From a birds-eye view I would assume we
>> can stop scanning for changes when we exhaust (reach the top) of either
>> side.  We just have to make sure everything from the other side is
>> accounted for in the last added change.
>>
>>> -		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
>>> -			for (l1 = i1; rchg1[i1 - 1]; i1--);
>>> -			for (l2 = i2; rchg2[i2 - 1]; i2--);
>>> +		if ((i1 > 0 && rchg1[i1 - 1]) ||
>>> +			(i2 > 0 && rchg2[i2 - 1])) {
>>> +			for (l1 = i1; i1 > 0 && rchg1[i1 - 1]; i1--);
>>> +            for (l2 = i2; i2 > 0 && rchg2[i2 - 1]; i2--);
>>
>> Nit: The indentation of that line is off.
>>
>>>   
>>>   			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
>>>   				xdl_free_script(cscr);
>>>
>>> base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0
