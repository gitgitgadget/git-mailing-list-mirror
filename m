Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016912DD87
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970807; cv=none; b=S6r5D83BPi97F7P4LKAGTx7G6Gm2UfnbA90NH5/OcR2Fz2YI6oJq9uXr+U08xE446HcVeGm3tk/82zzn8Vo0z3NE1WLXTIiEns5DF7srMm+2TRtnY4aHViIU6znVjmZd7vP3XT4N4WWzYyo73gLJXtwVS61VAQLHxBSnY1Nm9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970807; c=relaxed/simple;
	bh=kOJnWzDjvyOjcaHcQKtMrENEKD/H8CWkd04h/tDuTFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSPOZReIJ8BNl1425EfyxS1j7VTIKQPU24LfazbumNgQ7UfSnxEJ4+TyuvQ+BiiOssSp1yNbkhaofjmypP/uOr7zGoHHeXCygFz50/dNAQlekSqyl4umFjdq6tHUinasSkY0VByNAA+d2dW6JXhBo0t7QlbpWDOetXu7JuXvtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=DKNgvGT+; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DKNgvGT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708970800; x=1709575600; i=l.s.r@web.de;
	bh=kOJnWzDjvyOjcaHcQKtMrENEKD/H8CWkd04h/tDuTFo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=DKNgvGT+NEu/GltOtDH6sCWxSid0Z0JssQ6Ln7ox2HWK6MfAu2yGUDpyTwqlqzRz
	 n3QacDBpcCPP3y96lr2mUuycKDPx8XnI+kTvtIjcxx2WeJ+GtiBthAx7tnSS/9A0u
	 eNqvjJAMUSP/tRpkuJW1qwsvCFvy7McjrKeajOWl6ZKHfG1eC5nwbycvocJypIFpR
	 C1FtCwRqBf04Wh0niH67DaKsrBGFA0ITxboc5qdqsClFZHnmMwEKIwbfew19Awkhv
	 LkmfzUXSAYmIHG7NADt29RgLw5cNwNh5iD44b5D6YRx4yFWdoaMNpQbSNbY5M29BX
	 /Ap4DQU2bRIi6nUPAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmq2-1riXFG0htu-00Eu0Y; Mon, 26
 Feb 2024 19:06:40 +0100
Message-ID: <53cfe0db-458e-4a43-b5ac-0c01cc6e79ea@web.de>
Date: Mon, 26 Feb 2024 19:06:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] name-rev: use mem_pool_strfmt()
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20240225113947.89357-1-l.s.r@web.de>
 <20240225113947.89357-3-l.s.r@web.de> <xmqqfrxghtef.fsf@gitster.g>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqfrxghtef.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JtnLmw+JLjajNc+n7XsrDn/5znZSVSBpzkSklMgfjssLD+TSpZs
 SPXP3TvkuaMy80z7RJE9hbKK4oQHn6NA46wLqgsft8Ddy8VQ2iPVK5yK1mvWWseOtQMjcKV
 TisN1zEff5RtqNyO/9oJoQx6Z5pHytqdEuzfHCeDMSXFCDLGYkOczZZsEECdgPO31IEmpIR
 VRwlelitC138UZPs7Bpcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ulBQfSuEoGI=;ES4P8RAZARrbZDRcmp9Ug8FO3jW
 dTL/Bu/g9S0PsFavKh9Byoepffck7ryjxCZhQ0K+UIHWBl9emUe1Ogi5WXTsMWxSXlwqlNFvM
 KG4uCfj2kj6ZDYfn87qJAmr/mEJB6vRAP5zsv3wOicK88unGXfXStE2am2SeabN6LuSWhfc2B
 wPxVTiJD2wzYvF38JBKwj2McdkosPMyp8aPgKA+NBt3nEQVTVR4yMy0jOkdRv6FxG1YIfibtP
 /ylxjG7ddjP8PXcUZacBDVnIKDDjj6l91mrKBwrxmU6+xfKzfRZ9h8rGUlmZzjUnB1K9gAvuP
 +2s5FB5buvarzIHkiKZVe77N9mgK0GacJqZLwAbDgbcQhyKqhC6fA+HB35igmdexpxDwqj4LN
 M/Zh3RtfhIDVbXwKO06BQX63aW0+vLSnUNmmS3cwOWuYTz3fMMO5hWnKk9ykjw6IcssndOsMx
 gfz4NfzV6+wfxAam83wDz4SKGOjmPCmh18nayf5OBuvrEZBmiUy1oHR42CIyM9xT6VI4GPZdv
 u0sOCrbgoKamiMuYHsxhTpBH0+TbL9Iw9XUTitXMvhIsSaTn1PtmzF+o4GSnA1d/sFse2Jm68
 xbFJIvAXVpNXooIAHlN/pm8kuFMAiQXLLaehDraGDq6wY7sN40PwG4hWHpi8qcP/P3pZ/F7oR
 gwC74jSa+7eJ7dKFCVrZQ0QZHvs5sjLUBiAI1526ZNPLY9thki8SblAV2FTovxNzivpgtkiCs
 jTkRp3Gw4y7IAi6+epNvcUL3Xw+rBUxV0VSYVPIe0/8ezSJjUQ6LRs7bENhSIpTQ08/xHkRB5
 KuwxWaNYXUeB86VjpZ8sH5GJb6JpZYN5I9mQIA69gE8EQ=

Am 26.02.24 um 03:05 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> 1c56fc2084 (name-rev: pre-size buffer in get_parent_name(), 2020-02-04)
>> got a big performance boost in an unusual repository by calculating the
>> name length in advance.  This is a bit awkward, as it references the
>> name components twice.
>>
>> Use a memory pool to store the strings for the struct rev_name member
>> tip_name.  Using mem_pool_strfmt() allows efficient allocation without
>> explicit size calculation.  This simplifies the formatting part of the
>> code without giving up performance:
>>
>> Benchmark 1: ./git_2.44.0 -C ../chromium/src name-rev --all
>>   Time (mean =C2=B1 =CF=83):      1.231 s =C2=B1  0.013 s    [User: 1.0=
82 s, System: 0.136 s]
>>   Range (min =E2=80=A6 max):    1.214 s =E2=80=A6  1.252 s    10 runs
>>
>> Benchmark 2: ./git -C ../chromium/src name-rev --all
>>   Time (mean =C2=B1 =CF=83):      1.220 s =C2=B1  0.020 s    [User: 1.0=
83 s, System: 0.130 s]
>>   Range (min =E2=80=A6 max):    1.197 s =E2=80=A6  1.254 s    10 runs
>>
>> Don't bother discarding the memory pool just before exiting.  The effor=
t
>> for that would be very low, but actually measurable in the above
>> example, with no benefit to users.  At least UNLEAK it to calm down lea=
k
>> checkers.  This addresses the leaks that 45a14f578e (Revert "name-rev:
>> release unused name strings", 2022-04-22) brought back.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> This doesn't make any test script leak-free, though.
>
> Hmph, is the root cause of the leak because no sensible ownership
> rules are applied to .tip_name?  Sometimes it is allocated for the
> paritcular rev_name, but some other times the pointer is copied from
> another rev_name.tip_name?  As the way currently the code uses the
> .tip_name member seems to be "allocate and use without any freeing",
> I tend to agree that throwing them into mem-pool does make sense.

Yes, the tip_name string is shared between child and first parent (and
its first parent and so on, until a better name is found.  Without this
sharing the peak memory footprint of "git name-rev --all" in Git's repo
goes from 40011328 to 46286528 for me currently.

I'm not too worried about the leak, though, as we can't release the
memory until we're done anyway.  The ability to build strings without
having to calculate their sizes in advance (either by running vsnprintf
twice, which is slow, or by doing format-specific calculations) is more
interesting to me.

The reason why none of the test scripts become leak-free is other
commands (i.e. not git name-rev) that are still leaking.

Ren=C3=A9
