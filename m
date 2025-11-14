Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C831A041
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151080; cv=none; b=hg/yF9oh2vF66JBxExvOFW1Bv8kEZ2+I/d/qMKwU5DPj9AYOdxgsVAhobww+hLwtbfThYygxsNheAT45XY8nVZqU+FsRg9IUPaf1GAAqJ/ERyNq/040PJ6TqOB/NLOTlEEUZ68koMlX5XGBWI3j2n6YelByNKxIxZQKbWP49ULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151080; c=relaxed/simple;
	bh=wZ0OO0UEy5ptVmWFshoHc9q6rmq2dkvLuD8qZTBKBQE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=tqi2pwENsisCuCmiW0R7QMQSU8CBmlgJ0UEbMSvMKyb8jMZfr05dWBqLpiigtyS7sTjhFduJmMSz/8r3xq/SuP7CeJLHXtQk8wAs7EGAfEoMPmxOHuIZ87dcZBosPmq6XUHdqKSxA7Zjhl9wXexbhdEGC2DClMG1IUkMbbr24Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GULDiOiR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GULDiOiR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47758595eecso13286585e9.0
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763151077; x=1763755877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKWHWmDhS2FEeSsJUwCaj2VKz6H8R24HJCJ5iDC9Wvk=;
        b=GULDiOiR8/1KXS0IANd7VIdWHysJhei7E/qDnEe6bH1pcdXpGIy7J/D7cbcAXysWK5
         wbuCSqeBAOLxCXMI/qhY/wQGRzdHKQzjtmwzK2BeImbZmbURN/eQHaJPCnWfqA0mpiE/
         ptAIRtPz7z0xrRkkUpXNDa0YrtZBAve0rGm77Bd/a2CZhd1HHP7ShRbmEyJ+macpglbz
         5sYcvLiKbptI40dIcKBzk8YE97wzeL9LiPrbzOqkerVGQf9pH/ozljfQQ5Gk+JgIsBXG
         DuT9oyS57Jd6hgtjToYrNqpPORwii1pFakAlh4R7xbh9ADGJ/voCfkAH9s6EsIUK2ZOp
         jT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151077; x=1763755877;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKWHWmDhS2FEeSsJUwCaj2VKz6H8R24HJCJ5iDC9Wvk=;
        b=X3mJlff+UpY+SFkocD6drO9ipOKmGofKtGgnn4MRrcknLxhDyVKXa6R0mu8wrm68TC
         04KSELhxpKolM+Mn7GiympKH6ZDIqOx/YK1V/0+xJ+p1DSQFQ7jE889snmfz6HoOuVx2
         41DL2O3Gryu4hXvBS+VPNO7fp7K4mvSz2cL+tFxvVMKYAM3sDqwmWBSH76JGPUC0hO4T
         +wX6LE4n1UZQcif1u2zU/Yxv/fmPd6kCjpG53jnG9AM4KWe7ch2D8M7bJbMz7wMUT5Nm
         ZkfeelaArSWRBNsz57lrGDGkHQFfwtUSnYA0hor0/h5uxeyjWqVJXPkPgvcnWn83Ao0/
         ejCw==
X-Gm-Message-State: AOJu0Ywxgy77Ammn6V73sRTx7rtre1Ps50br+rUS9tMFUcsoCeJp+ZQ2
	LNug7JyvcZDc8828hiHeLo61Vz5w+dvZzQMhqeZRXVIgsjXlA0dbGsnui7FDPw==
X-Gm-Gg: ASbGnctwOOTJa2p/gftMogC96manbMJBiusK4BpThQpxxAmHVxp0GBQrDS3bfxkICgw
	xj6EYP7EvzSOkBDvuhSXBvgqljvRGd44STfirXz///cx3O1zJLJTtlutfrrZxt8okTRFNqS3oZ5
	1RRAbFSc757DUAAhRRF0K/GSrqJygPQfhGYSMb7L8ud2ZigBlr62VAoKTokiYSc9743mRjL9VHy
	9yBls8iWqvJ741Gv2MRCWAiENsRJgv9NvrHXNNvjOe2o6vVf/Q5dwOkAXiPLBwUKirrr0luPqtr
	fGCFmvTUs3OKJPa1eWOd0UpVreCAbbxCcx6TEpnz/rE2RY9GFWSlKrPunS8pdL48lrD63ehvgFX
	duTa46R7/p4B6LqSDfRONUwsUrHtZ77OLejC59chlKGS3jAQhzmDwNwfSM6gaQ8NdSq3AitKeIC
	Bt/psUdJMMBJ8HnfEfZ40EMjQaMzhudxAIQCrbg1BZFvybsGGUW/j6pmE1bYorcb8o2Vt9cSLtI
	g==
X-Google-Smtp-Source: AGHT+IEZ3Rgs27xw4W4IxOOuhGixrCDM1fDLQI8GWF7ObKpcn3OgFsJKVbnjPICinQI8mGn4GOtA7Q==
X-Received: by 2002:a05:600c:46ca:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4778fe4f06dmr45242185e9.3.1763151076746;
        Fri, 14 Nov 2025 12:11:16 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bcf75b8sm54766965e9.1.2025.11.14.12.11.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 12:11:16 -0800 (PST)
Message-ID: <b1775e1a-4f6c-4116-9587-69526d379b42@gmail.com>
Date: Fri, 14 Nov 2025 20:11:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: CI Failures
From: Phillip Wood <phillip.wood123@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
References: <ddefb36d-f023-45c1-b518-a9f70dba0696@gmail.com>
Content-Language: en-US
In-Reply-To: <ddefb36d-f023-45c1-b518-a9f70dba0696@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2025 20:00, Phillip Wood wrote:
> I'm seeing all the Ubuntu based jobs fail. Judging by the error messages 
> at [1] it appears that their version of sudo no longer supports "-- 
> preserve-env" which breaks all of our scripts. Does anyone know how to 
> make sure we install the C version of sudo rather than the rust version? 
> Failing that I guess we could switch to using "runuser"

Sorry for the noise, I see this was fixed last month, I had accidentally 
rebased onto a stale branch.

Thanks

Phillip
> Thanks
> 
> Phillip
> 
> [1] https://github.com/phillipwood/git/actions/runs/19371231059/ 
> job/55427466699

