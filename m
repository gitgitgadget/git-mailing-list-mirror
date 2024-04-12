Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199A50A87
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914409; cv=none; b=NsvO1GQo3+03K8u++LtfxWIGuTTKY//SHvcVmLG4gFByLT0uJjd0cjVXBrOxnXIINYHN5lLbjH2K88hGU24w+UbMlpsLgBBeo4tCw6yVexA16X/vwUMFuE6H4zKfKEAtP4yChGSvZum39Il7tH8wKtmweAyBrcwAnEk3V11ybBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914409; c=relaxed/simple;
	bh=/vGMHZHV3mx12T0Rf2iJxOKf6y99PYxlMpgWc2Pa4qY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TNDFV3Wr4ho3z74/nVSRtRhL12KDpkfBENQa50uQ7BT7Bnve0FyxaH17/ReZtPEx1ezzCusq9JJbJOACNAMx3uCE3WahuLRLqZ4ElwBWqcfLH/9gp6BUjsjnP3seBB4HK/8fqtSDcb7aQYfFya3hYN0P1KjunCvH0mIuA0bgGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0KVNtCZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0KVNtCZ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3462178fbf9so333819f8f.1
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712914406; x=1713519206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZZvzbrjN7msrYeTnRPn1DZPwaSM7EcUpKv51KXaea4=;
        b=C0KVNtCZSVKIs38wwFTh67XXx/rEb7DvzUISLgF3Ne6I2NRurUXQdJ5vsNaOPMTcCi
         3lqZ8hxGHmO/n55UVUVRJL++DknCBjv4/dXVJ21tfFgS5ues5cZjFCSO4gnEoT2xpplr
         vWLwBNks6E1QRmrOBBdmLNx789PhxiaDSRHb2NsWNDfmfhATKdabDUhiaukm2j/tbOHq
         FGcWCvAIU7Np8M60MTRV06CzI5ur71a6tdAuCmKhfcSuI65pQRIW8eTSsSvHsllubioH
         XjEmglSe7BzeFLL6P/CqdQjSXJlF+OnrhV0g+r02Lkp/hH7bLaeeh/SJhdftiJex3EvN
         vt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712914406; x=1713519206;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZZvzbrjN7msrYeTnRPn1DZPwaSM7EcUpKv51KXaea4=;
        b=BEPFbCAL4O8u+6hdR+qJZeyOf2EsIbPn03KVdfT+1kBCm318ApD1Uiy+FjkwmOGNED
         6VE+MOPfDAvl1rYmS3bUvif8cJkYmvX/1mpG+8lrcU7w65NguB/bODq/+8yyj0omucAf
         ht7jjpbDr1XZcfqJsESM8D+qLlt/BJCKseAStyKmB2hEPSh44CN4a67lffxzhWDb+Zv+
         LJIf9V1uWpfNi2CrfCokupj4oxtJImhzvY7bYN9K0uQIp3k336i+U3eXifIk9dh8FtJ2
         27OsiiQDVz5YVYU4VAAMHmS+yI7eUX+SzKlWNKzjxYxDn2PvWV55WUlAbR86jM0Mpeh4
         zL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuPLt+9wgjzdCkf0qKS7ywN3AduwVnMVUvAMbOgp1//Nf8/1EXpT6h6qpO4ze/S0xRmm+36Ju9R5SsnM8iYVbaQcH5
X-Gm-Message-State: AOJu0YwVROpRM31SL2viQMtt/+5n8EqH1wvMszSKLxebq7T9EfLNZdwy
	QEIYyFUwsXrNpyRRGf51DQASj1/hXKkAs1aKijLdZwgFfAYPsUUf2Gg4ZA==
X-Google-Smtp-Source: AGHT+IFOI6w5R1pZ5e6yBnlJkxSKOTOFd0Zbt8T0eIxfTTIt46irC+iJuNTFzyfaLbplbqm6ILZHpg==
X-Received: by 2002:a05:6000:1091:b0:345:a2cb:3202 with SMTP id y17-20020a056000109100b00345a2cb3202mr1561603wrw.65.1712914405545;
        Fri, 12 Apr 2024 02:33:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id h5-20020adff4c5000000b003437a76565asm3829305wrp.25.2024.04.12.02.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 02:33:25 -0700 (PDT)
Message-ID: <33c6c944-e1f7-48e1-a9f2-8bd5027b7c61@gmail.com>
Date: Fri, 12 Apr 2024 10:33:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] t3428: restore coverage for "apply" backend
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
 <b45af37e3c0a22cc9e0514eb681300be0b968e02.1712676444.git.gitgitgadget@gmail.com>
 <xmqqzfu2yw00.fsf@gitster.g> <6ab115bf-7b78-4633-a64c-9a0925d68e3f@gmail.com>
 <xmqqjzl5z4a9.fsf@gitster.g> <5e0ec9eb-2e2c-4cb6-91e2-eef6b5c4300c@gmail.com>
 <xmqqa5m1w4ik.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa5m1w4ik.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2024 17:45, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
>> On 10/04/2024 15:22, Junio C Hamano wrote:
>>> phillip.wood123@gmail.com writes:
>>>
>>>>> Hmph, doesn't this lose coverage for the merge backend, though?
>>>>
>>>> I don't think so, we had coverage for the merge backend from the other
>>>> tests before 2ac0d6273f as all of the other tests in this file use the
>>>> merge backend. We're no longer testing "--signoff" without specifying
>>>> some other option that selects a backend but it seems unlikely that we
>>>> could break that without breaking one of the other tests.
>>> OK, so we have "rebase --merge --signoff" tested elsewhere and we
>>> are replacing "rebase --signoff" with "rebase --apply --signoff"?
>>
>> Exactly
> 
> Perhaps we can write that in the log message to help the next person
> who reads the patch?  Something like...
> 
>      t3428: restore coverage for "apply" backend
>      
>      This test file assumes the "apply" backend is the default which is
>      not the case since 2ac0d6273f (rebase: change the default backend
>      from "am" to "merge", 2020-02-15).  The way "merge" backend honors
>      "--signoff" is already tested elsewhere, so make sure the "apply"
>      backend is tested by specifying it explicitly.
>      
>      Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      Signed-off-by: Junio C Hamano <gitster@pobox.com>

Sounds good, I'll send a re-roll

Thanks

Phillip
