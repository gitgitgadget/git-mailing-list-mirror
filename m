Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C738F947
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681457; cv=none; b=MMEGcCwSe+4WvvuAZA1mOLfR3dR+OZ+IBeHc0eRFUUVrHWutcj92vGIB6LQII/IMwAmobw2n68L1qP3zdqxGk3wYdE6U9I2Q6tOZ/NbjTosKlM8y9Jq3t2vNqKkr/xY2ulDgEU+gQjeJbl+Pn6ZUu00rB4fG03Olqtp/2CgeKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681457; c=relaxed/simple;
	bh=6DUDJxYaInJi3wnxxpeUEWbfloIWdT/OQ1Wh40ccY5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgMk15OyUMOs/pGtaIkTJR8xy8d6lPTCx08VehXGkglClTEtF5G6EmHc4PmnT4Dgj31sJeXgD0W9FznJk0gYsMeow6uYXZjpJdR2ENcs0j61FIv46CuoJJl2ibONAUf1ResIBzSjYEjXUArC5Yau0F4g787tjxtTYqR63LNFdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACpwjA8K; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACpwjA8K"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so1780356a12.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776681455; x=1777286255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drHDufs26TKiRM+nGfcRpIE3+6mdiaAHPqrZfPu6diY=;
        b=ACpwjA8K02+pNatis1E1tnwFtT2SCZvxuCMANrxJqCLlImY53cT8sQJAMaZDVB7uUy
         FDNLRPC1hUaOEk56U4prTVrDXRXrZ9/sfzbXXI+qO3vioGV3pPKlYTMa8j7KkEUFLBpB
         YBr/hjygsj1te6D52l5vxW4imUyNUT71yUCmKWkNdxq4F1u3G1hv2S9SekVxl+Fhuq7T
         OPyh3xBQ+CoQxt82FK2AC5r+18X5ZJojZpte571IkcV9IZjH/9QU62QdifunBF7zJa7y
         APQx+PduF2lw+voGp950e0vCyLO/0wbUM796LFtjNLN+4ZIdPuAfL7/CXJA6/W913VaY
         J92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776681455; x=1777286255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drHDufs26TKiRM+nGfcRpIE3+6mdiaAHPqrZfPu6diY=;
        b=JdOmFgmCjbJWauLAvXJ/oKlFvPLL3rtAfsZv8tG0YNeaIVOcUg5nZPk1XomuRoSB5/
         tsmgNB9H6Ez1Kgb1PoKesMCzzO8AnWrFCBAe2LLw775OomNvLGEyMSUvtqflIiEhhynA
         CLQN7WUxdHVD2vJHjICLRMR0Qz5BWALArj+o4g4m6K2AZO/NZI76I7io38VOIBWTZpTU
         +cf2sL03A1fHTVfCc8KmyRX6+oA7pX3EGFcSODjz28B+0k1uySLmdsynvclBGbW/1JQR
         IdhSbGfv00ivE/LYmYOXXLTF2+ss/s9tHDARFmgdmvWGi5uhdZWaCUJfvhzpZD8Ast2y
         bEuA==
X-Gm-Message-State: AOJu0YzaPI8dM9Xqi5lNSWqDQSZYX0uPv99QPlalShu/Is1UjTc43VR6
	jOBgYGg/zLLmFTMOzGfghzIz6dB8hncvXzJ7UnoltkaycwSYniIKbc93
X-Gm-Gg: AeBDiesWCY+RmnTDksGHBrdvsf7uZqUKhr5OR9QsVHvuTAtHYke95ZQBKfZ8WMHABO3
	EKH9M9mbcr+M5wJe81EfVV2fHD+eoZa4iEyT5npAHh0vGZLNoj2cFk3i/XhmQn5H9TBZcvRt9hM
	1zCOF5Tyku8a+1AvxgHilSCZed92VKcT/9PXlbUbxyyKCrqCfJDDbqE41eKtXB3MtvLZuC04Yxv
	l3c2/3Vj76Yatj064E4YVhGuVhpQCvLaUNwVJusneiGte0oFKCgQRYaLz5ibmJHx5Kjd2C6URzG
	aLj1UEtPoLZdVns8P0T80a52nRkQPNgjpXv9CGGpKta+F4lrp7EYFJH5om+EK2u/EFD2+8cNJ18
	LIwdd5dEMrqmwyZTqzFv2cJeRl5V1LWgtmp4ibUV77TcZP8pqDe/Px8+0VdqelY4OQlxHFD2Zko
	Bau8SXXXipYT0uBJPD/E75CvTatD8B0J2XAOuYWxeeuBEbpKimGXj+oBIyg27b5ylf5GzYP6Lph
	841d4TcWNwgVh5k8+14xiQOT98UONOD+/TvQ9lamRcG
X-Received: by 2002:a05:6a20:2591:b0:398:7d6e:27f4 with SMTP id adf61e73a8af0-3a08d6eb34cmr15620981637.1.1776681455277;
        Mon, 20 Apr 2026 03:37:35 -0700 (PDT)
Received: from ?IPV6:2401:4900:86e8:71dc:a082:d961:4e27:7d6? ([2401:4900:86e8:71dc:a082:d961:4e27:7d6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701b0f0sm7923338a12.17.2026.04.20.03.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 03:37:34 -0700 (PDT)
Message-ID: <3363a365-9529-44e5-bc4e-ba19bf97ed97@gmail.com>
Date: Mon, 20 Apr 2026 16:07:27 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rev-list: add --missing=print-only mode
Content-Language: en-GB
To: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, toon@iotcl.com,
 karthik.188@gmail.com, justin@parity.io
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
 <20260419084840.33986-2-siddharthasthana31@gmail.com>
 <aeXZOAtILSr638LG@pks.im> <491a27af-3ea4-4978-9d51-9c540ad31589@gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <491a27af-3ea4-4978-9d51-9c540ad31589@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/04/26 14:27, Phillip Wood wrote:
> On 20/04/2026 08:43, Patrick Steinhardt wrote:
>> On Sun, Apr 19, 2026 at 02:18:40PM +0530, Siddharth Asthana wrote:
>>
>>>   static struct oidmap missing_objects;
>>>   enum missing_action {
>>> -    MA_ERROR = 0,    /* fail if any missing objects are encountered */
>>> -    MA_ALLOW_ANY,    /* silently allow ALL missing objects */
>>> -    MA_PRINT,        /* print ALL missing objects in special section */
>>> -    MA_PRINT_INFO,   /* same as MA_PRINT but also prints missing 
>>> object info */
>>> +    MA_ERROR = 0, /* fail if any missing objects are encountered */
>>> +    MA_ALLOW_ANY, /* silently allow ALL missing objects */
>>> +    MA_PRINT, /* print ALL missing objects in special section */
>>> +    MA_PRINT_INFO, /* same as MA_PRINT but also prints missing 
>>> object info */
>>> +    MA_PRINT_ONLY, /* print ONLY missing objects, without the "?" 
>>> prefix */
>>
>> Makes me wonder whether we'll eventually also want to have
>> `MA_PRINT_INFO_ONLY`.
> 
> Perhaps we'd be better to add a "--missing-only" option that limits the 
> output to missing objects? That would avoid the problem of "-- 


Make sense, its orthogonal to --missing= and handles print-info-only for 
free.

Question though: should --missing-only without --missing=print (or 
print-info) be an errro? I am leaning towards requiring it explicitly so 
the behavior is always obvious.

Will rework v2 around this.


> missing=print-only" not really explaining what it does as well.
> 
>>> +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
>>> +do
>>> +    test_expect_success "rev-list --missing=print-only with missing 
>>> $obj" '
>>> +        oid="$(git rev-parse $obj)" &&
>>> +        path=".git/objects/$(test_oid_to_path $oid)" &&
>>> +
>>> +        # Capture present OIDs before hiding anything.
>>> +        git rev-list --objects --no-object-names HEAD ^$obj 
>>> >present.raw &&
>>> +
>>> +        mv "$path" "$path.hidden" &&
>>> +        test_when_finished "mv $path.hidden $path" &&
>>> +
>>> +        git rev-list --missing=print-only --objects --no-object-names \
>>> +            HEAD >actual &&
>>> +
>>> +        # Only the missing OID should appear, without the "?" prefix.
>>> +        grep "^$oid$" actual &&
>>> +
>>> +        # Present objects must NOT appear in the output.
>>> +        while read present_oid
>>> +        do
>>> +            ! grep "^$present_oid$" actual || return 1
>>> +        done <present.raw
>>
>> How many present object IDs do we have? I'm a bit worried that we now
>> execute grep(1) hundreds of times. Can we maybe do some tricks with
>> comm(1) instead?
> 
> If we want to verify that it only prints a single oid then
> 
>      echo $oid >expect &&
>      test_cmp expect actual
> 
> would be much simpler more helpful if the test fails


yeah much cleaner, will use it. Thanks



> 
> Thanks
> 
> Phil


Thanks,
Asthana
