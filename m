Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96091EBFF7
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771387723; cv=none; b=kwfU2kMPRkEaICRNk/HXpyjdEK/Q3KdjORBuGcSvGYD6/fXTvddu570xlF/bpMviZ4xGOXJ1WGF+Fa5I/T26oCRI9WyAbd/q4w0bfjJuH7tBh5ph3VSIKMV3KhjWY4fmgJNoyDRN5xXPkImjgvdxS5ydYYVRsB8SZU7gnfbKImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771387723; c=relaxed/simple;
	bh=uoCpqjdk4iRCEnrmVquOOGDhbVaEjlKDRECiiKj2AUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUAX7GMRoVN5IPSN2nDydBCfTAU/g3z2ytKLGRD+JHaWw3qijPu0PnGhIH9zqK89pZ39nnxjPsZsZaILtn4tcI03wvxdzP0+/aygG5sgxT8vmYgU492vX3BEBsm4jbmhnAHnifcEZS/+TFnlK7CZDRFgsd1oD+kFd3bXa93ahws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq1NUJfF; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq1NUJfF"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c6e49b67239so307273a12.2
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 20:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771387722; x=1771992522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bw6x7YzRBXuC8utCT8GB9x1supNyPBjfGR/LBmTrUsA=;
        b=Lq1NUJfFpU802BXm0dSR+Dh6urmc3zTU1MnEwLwKwcz1EHvouyUlMLLn3LTFrEqDf9
         +fMj3jiAfpAmSY+edZE+HByrWIBRZIYd5p+yICuoDRkU6k5U6QaeecZmimC9bJTFYrt8
         WBI5LjK6RmDxaHloCiHNg0WoeVAfrvdCGRZvvEL05E5S6tDa3XDyItzgPpKa1f0ohAH9
         em3TRqz+yR+DRb+wPRyKrSCmP4UZt6Qt1yTClWg17UrW85HvhRtcwzUOApjWoKDQnyqp
         qBEysCu8MH4om84HxbuITRMVpIDs6wuWnF/TLJm2Ig+J1z8UpvIlb6vleQzMiNpmNI0a
         8fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771387722; x=1771992522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bw6x7YzRBXuC8utCT8GB9x1supNyPBjfGR/LBmTrUsA=;
        b=atesjdftqKtRHHwuDPZDdui5v0Ur5qpQLopkVv68YcSqf3wLyR4OJrrI1is7cm1tAb
         ZaIM5Ybo5EVDwzGqJY3eli/PV1UdZxQUZnb7/xVnyFWRro6BBLvjeUc6wSS7MnDzxXn6
         QqDwYjbrEm9PWeDcltB5doUAu/EWILCgGPSbwhgbbAAFc/ffTkjuLZ+A5zzRpEAF95Ud
         x3w9n8S4JmA/d5vlf5jQtBFjprpy9nMEXnz4SsYLGE3gJsXUF+ftDAzyXfhUkj3MByo2
         7mKTjNmCmY8KVe0cNuvQj/mNhzHpbkSYyR2Y6Azopgr+O2d2LlP5OHHdUTR8LLQR9pMw
         ldpw==
X-Gm-Message-State: AOJu0Yx6uocU6Ma+Fg9VKxcLQgeNrDiasNM4KlteV772JBGwQAuWo6lC
	mciV6OklYK7UyOLutVhv4K+noztFcSxYH2EV8JPnpuvd7C55b+6ElrvV
X-Gm-Gg: AZuq6aJBZFOk1clBCEQpQR7gsM1ViUvLL1nPe2YR0qiL8B+0KfXDBvPMporLFj+BjYn
	ticIvUc15Idv32lB+hkpPs9+TMZWmqitp/1PaGXKK3ZNQsHFTQUEdBOz436gsNgGz6gOr3YtGQK
	NoYYtNXYKAHdvpiJVyu5o9jtN1mOxD0QgdEN3kZzwB1+itJXAvpymHr+SkoKFFfVTb5pOxxpCAo
	xjp0UsYzjXcze4+o6bn4dnloiuNP3p9q7G2es9hdATxxfWGSQwqzpeaj0ZLpkLhKm2hyvz+N+kk
	my29G/O23SZ1cVneG78CNIVIEqen996rSAOlOH86RRsKQ2cJ7RtVsWFD9jXwLz/M2gJuDzmaXYk
	VF4zfxzpXMFnodF+WqWfs5aJLowc5VpJoOY1INBAbeKQsva3ftq2me8rL+BqrqXXJF0H2uIjOIF
	DoqaHoFNNWmXphfTyuy4hxEewNG8U=
X-Received: by 2002:a17:90b:56c4:b0:356:2872:9c5a with SMTP id 98e67ed59e1d1-356a7a9c53fmr11573105a91.7.1771387721848;
        Tue, 17 Feb 2026 20:08:41 -0800 (PST)
Received: from [192.168.0.105] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3588795d31fsm316128a91.7.2026.02.17.20.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 20:08:41 -0800 (PST)
Message-ID: <8e9399db-e35b-4c0c-902d-b64c99cdc099@gmail.com>
Date: Wed, 18 Feb 2026 12:08:38 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] setup: allow cwd/.git to be a symlink to a directory
To: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <5b29218a-8d18-41f0-8a03-eac707151945@gmail.com>
 <20260217084124.150366-1-a3205153416@gmail.com>
 <CAOLa=ZTeTWhb0Yc8rPEv8vONTHtSg3bSvW6FBC-AWrZzi12oCA@mail.gmail.com>
 <xmqqv7fvcnj5.fsf@gitster.g>
 <CAOLa=ZQ8i0pUAbF8NGidR=6jVLJuiYdUWu=ZLDrJMek005D9bA@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CAOLa=ZQ8i0pUAbF8NGidR=6jVLJuiYdUWu=ZLDrJMek005D9bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/26 02:50, Karthik Nayak wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>>> @@ -994,7 +1000,9 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>>>>   cleanup_return:
>>>>   	if (return_error_code)
>>>>   		*return_error_code = error_code;
>>>> -	else if (error_code)
>>>> +	else if (error_code &&
>>>> +		error_code != READ_GITFILE_ERR_STAT_ENOENT &&
>>>> +		error_code != READ_GITFILE_ERR_IS_A_DIR)
>>>>   		read_gitfile_error_die(error_code, path, dir);
>>>>
>>>
>>> I understand the exclusion here (they are non-fatal flows), but wouldn't
>>> it more make sense to add these two exclusions within
>>> `read_gitfile_error_die()` which already has two such exclusions? By
>>> separating this out, it gets really confusing.
>>
>> Absolutely.  The point of this change, IIUC, is that these two
>> existing exclusions were too broad.  stat() can fail for many
>> reasons, but because we did not differenciate ENOENT (which we *are*
>> happy to see and do not want to consider an error) from all other
>> error cases (which we may have been better off if we diagnosed them
>> as error), we pretended both ENOENT and all other stat() failures
>> were happy case and "case ERR_STAT_FAILED:" covered both.
> 
> Yeah, so this is the situation before the patch, and I'm in agreement.
> 
>> To fix
>> this, the patch splits stat() failures into two, ERR_STAT_ENOENT is
>> the happy case we should have been returning without dying from
>> read_gitfile_error_die(), and ERR_STAT_FAILED is the rest that we
>> should have been dying there but in order to return from there
>> without dying when we got ENOENT, we were not dying there.  Now we
>> have a separate ERR_STAT_ENOENT, read_gitfile_error_die() can (and
>> should) die when we see ERR_STAT_FAILED, and it can (and should)
>> return to us when we see ERR_STAT_ENOENT as a happy case.
> 
> Okay, this is what I was expecting too, historically
> `read_gitfile_error_die()` treated ERR_STAT_FAILED as the non-fatal path
> which made sense. But now that we have ERR_STAT_ENOENT. It should treat
> the latter as the non-fatal path and the former as an actual issue.
> 
>> The story
>> is exactly the same between ERR_NOT_A_FILE (which had been non-error
>> only because we wanted to treat a directory as OK, but we can make
>> it an error) and ERR_IS_A DIR (which is new, and is an OK case).
>>
> 
> Yup makes sense.
> 
>> The above exception on the caller's side you quoted is a complete
>> opposite from that line of reasoning, and that is why it is
>> confusing.
>>
>> If there are other callers of read_gitfile_error_die() and different
>> semantics, such a "now we die on every possible errors" may also be
>> a valid position to take, *but* then it does not make sense unless
>> this patch makes read_gitfile_error_die() to die on ERR_STAT_FAILED
>> and ERR_NOT_A_FILE.
> 
> Exactly! Thanks for clearing it out.
> 
> Karthik

I don't think leaving it up yo the caller to determine "which are error 
cases" is as confusing as you suggest. But honestly, your approach is 
indeed much clearer and more readable.

I'll split this into two commits and send them shortly.

Regards,

Yuchen
