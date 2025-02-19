Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4291B983E
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976758; cv=none; b=FMWqpY6qrKXb/SSCzY9WZkwruCw5mDjwrmHIp2Zo7/2T6HHmDNjo2I2mfCw4PUxVUky0BPFYsPWaohozuLrImIzt6+a4IlaB+TOSx4L39ivXYJc2JUGuDuoNxykC6rp3b5Tp5PJdi3XuD9Kc4FpOx4g/gidwK9DhRT7bGkhHOU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976758; c=relaxed/simple;
	bh=JgPZ/R1+I/a3G6cBctQA8NPLx9+/sD0SrMMZZ8uCOBg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ERWp9ZzeoF9X8klUNp7vANtNWN/rrPDcd6Lsjx2S8QLco/ug9bOlXbAilLMSXdXKvZm+5XI2R49btJwW6kc0unag9QTocT0ancnkyDO4cpr1WQU0xBP+LC+NLltVMnQ8G37uTG9EMw3UQMUXwT4z2KVzpQ7X7plNpfp0EhzPTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPDR3PM3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPDR3PM3"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so4531017f8f.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 06:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739976755; x=1740581555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMcaIAz1VZakC8D5pxJuzcYRCPj7gJLFTlYbt79W1gg=;
        b=XPDR3PM30EDFV+YFcl7495AqInSx4i35a6jCefOGEVAGQLCHBV6eyJe9QSq9GnVhUi
         PJ10PJaPJ5/lB5+xJurgkeIf8u4tDroJw2+om+/PlnlndcLWzJiUs4MrKmCuDfyuTPuZ
         tNj87OGwgJ9OJgjbK4PWtj/rqPivB5FHx0xFvJWJ5voBIM8pNBaZojmDFBnvr0q5v3/S
         wLf3mFzVv37vNXgKPxaXwqgUi9lyQ6YDaRBw6QU3/RezduuYeGd/lLvg8CzDnhyuHO8C
         g2h1sKcHlRj9Hdhlx/iemellWlG/tOdkZwnNQl+iizIOX9v2UHvhVynhgNb/I/WuLEES
         tLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976755; x=1740581555;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMcaIAz1VZakC8D5pxJuzcYRCPj7gJLFTlYbt79W1gg=;
        b=xPgdLms1NrpgIUfYlTeH4zMj6VAUBLHA+oCDhjPr7ZS9BTHV1dZjAn2fI/16GbvQHx
         Yvhs+pDds0kpjdYdwsVBqc27fraEE0wIe7UgJWQ4leDG8DozVIjmPBI4FajZ9/ZylbaJ
         HY7gdA081MWcVONV2JyXX/JT+tTldiMb/ith27XG2WXVvdJkE+ZlqDmYlUiapGpc2/zk
         YQLPIqEFlzRdmgHWdMM2QxpQwx4kxhM4CmW03gLYXQN0f2znWLMWhsJ0M6AAwXrPHJvp
         XDSy2/P4xRVF3EHNfah5CpgxJL49kqJ6467j1VRF4M8wwJuhJ9sf9F2tTyXZcxkSqGoc
         BDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC0gsVX5QXJZnO+mwHIi891jPnv2HECaz52NBZCwtg7xjL+fgL0lkLLMIuzsVPZmNlG3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hITYHG8FXIObj2AbMuwABlN0LpR4KD41BQs/q375YS3MZRBs
	Zi/jHmNitZektc2Y8zbhkWFzyNe1tPIA0GHEXJI4R9Zz2PNwPn0J
X-Gm-Gg: ASbGncsV6IA6XxnzXjG/caU5xbX7LLNFIEH4JtrOLyqN5chIBvRsqCT9Bjws89duImg
	jzGOVVmx/+MjbjOQ3HMLO6Zyt7h5fXcJ0A9Ysx4gRUb/gR0S9bZkp7bmvN4+VIRXCVcQfvPFO/a
	A8QzgrKJP+5AmNGpiIuok0Y7i9Mh6RtI1jrT2CZozC6H+C5+mZ1vjmH8ucVRe+uXxo1Yd9qQYTe
	ONkyjNtXr16yozv3SIAkg2C5LrBMTtMnAzxqpQSfIfONf7Pvg9vIvdUN+UJnyZuGO97iHA8K3e6
	Okeje24x5OMLlE3pOXJlFCmOSGg/x01V8hHDSJLHMM9+7PeixTW3gu/ypRzbIJ38M6agvA==
X-Google-Smtp-Source: AGHT+IG40iJxSFpkG//00CaviNu3zVys6Bu3BHfz9lq9tPvKwxPrtmkOP/PMgiHjM50DTtM4DcAvSw==
X-Received: by 2002:a5d:404d:0:b0:38d:cf33:31a1 with SMTP id ffacd0b85a97d-38f33f40a63mr13337265f8f.23.1739976755147;
        Wed, 19 Feb 2025 06:52:35 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5b40sm18263981f8f.68.2025.02.19.06.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:52:34 -0800 (PST)
Message-ID: <d48cbeb9-2b88-43cc-98af-c0f5d597415c@gmail.com>
Date: Wed, 19 Feb 2025 14:52:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
To: Ivan Shapovalov <intelfx@intelfx.name>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Alex Henrie <alexhenrie24@gmail.com>
References: <20250210191650.316329-1-intelfx@intelfx.name>
 <1279671f-4063-4347-b153-9f6ff079bd77@gmail.com>
 <f689c263ead8104ec42f63f1e9ed10350a27ae1d.camel@intelfx.name>
 <5b605c3e-ef6a-433a-9637-1e8f277dfde9@gmail.com>
 <f0fa961084281b1d5948f59c42cf0c87e731d9bc.camel@intelfx.name>
 <8a259585-97f7-4756-a126-17a982da58d7@gmail.com>
 <1c69cee93c7edf62579d8eb3f40b0a98f3a5d075.camel@intelfx.name>
Content-Language: en-US
In-Reply-To: <1c69cee93c7edf62579d8eb3f40b0a98f3a5d075.camel@intelfx.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivan

On 13/02/2025 12:04, Ivan Shapovalov wrote:
>> would update all the branches ending in "-v2" except "not-me-v2". We'd
>> want configure any default patterns separately to whether
>> "--update-refs" was enabled by default which means we can add "rebase
>> .updateRefs=interactive" without boxing ourselves into a corner.
> 
> Makes sense, that's indeed a better use of the optional argument.
> Alright, I'll send a v2 with +stylistic changes and -CLI changes.

That's great, glad we're in agreement

Thanks

Phillip

