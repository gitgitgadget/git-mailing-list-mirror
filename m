Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708415F409
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933694; cv=none; b=DKsWkBR5eegY/wUoJeZ0cCrIM8UqHOCaLLQ+Dm25tsy3ORPXY4SQWdd5mdbWMuaymt5ypTq4Onf/2UBburbSD6MEKyAmvc3wmwNb/eparegfpO3ztS41UFSg9aRNum5fks1jK6Le7MJAqwaNhytVy4vtWBFnm9s64Noz6VKyC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933694; c=relaxed/simple;
	bh=ebp0otHfDkKMCxWo75/DSn8E1sWmtIWOO4cG8v6pAdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7ZAP0RPtAksCrjhu51fhYF2gh13XN3iYT9peAAsMiFwrHKW9OsUpskF1yvAa6fp5/w/81BqoG978CP1DADmmNhPWBILC0tCLJgLA4BWwuTRRyrmKlsKkXl96VRLEybcPc/Njy72IvLFQDSlFUw1CKtBm+Cs/fve3evh4WTjfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmxFwJUi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmxFwJUi"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so3388755e9.2
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722933691; x=1723538491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9tCP6hJg08x5Xdf1kcE3FNNONEZ+l2zEm5ECPNuic4=;
        b=UmxFwJUirmhHqx3b6mmKMLbJr1sajPMpPNnC5l1AQwSmXcuRRHW8jIUF94L8lMQapA
         avvDUxpd5j74MJsnfO4fp71gI2EHk524/2uA1AeZVwCGP+dmysXHG3NZ49BepdsIaJiQ
         yVrxdrKl+cLRi1sZlb1rV1yT7AK0Wbh6wGTjaI/Vwbz19NGqG7rinKf7Yool7OuQXshq
         /399kBaGSLZ1VQpavNfOao7tu6vdFE5imYhtWtLwxBJzmglGbZ3/1pBL4pTYnicTLyNU
         wVkrYCIJiIZmTaOFEkHEClG0B3uOHC5gvN2RqOSxWWutvyNugM20DY8vORBrA7mKonrj
         8xJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722933691; x=1723538491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9tCP6hJg08x5Xdf1kcE3FNNONEZ+l2zEm5ECPNuic4=;
        b=Ytpzvt5MtManWTxj/TYcRZkBYbCFtyw8fgQOhckxJA9VSGp6Me9TNj8ckbwkDXDdbD
         55G07xUpjUuTRtInIshBLhdmjAkr4XL/3pfwzTEmPCdt3WUa26Iq6WKQSQhQn2pmas3h
         Jvcd1/SyoiD6q4NYZJ8YxJ4VfF0B0zM/y+3oBfpjmd9YMWzFz1cDzdRHxQCRb3K5refE
         RQuXM9fL/9QFIjlL4PGGqtbwdkcgUpKcHK4taIl/AJaiCMc1vcIFQt/SH8uQO6mQJu4j
         vseSjbp4EoJ50Y85iXa3ittc9MDOGlyelxBqIxp478TVzrQ1htOjeAoZPiAHBnBFQfRL
         88GQ==
X-Gm-Message-State: AOJu0Yxz8cbyNybXY9UN7wkiAvU/3J9at8rfmfjqrKFaIQlKT1mDNxFl
	0935ir9pgBuPbYX+p6kl4IHM/Kpy8LM/dOrh9a0ik7VKdvCBDFTl1n8aORbS
X-Google-Smtp-Source: AGHT+IGAFmvIOuYQs8yV64zYbTTT/DTvcFvpRQQ8185ZGPj5ZMZifY+1Dzpf/79dN9WoxZqewUa5HA==
X-Received: by 2002:a05:600c:4752:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-428e6b0274emr113556625e9.11.1722933691192;
        Tue, 06 Aug 2024 01:41:31 -0700 (PDT)
Received: from [192.168.1.6] ([197.40.163.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428f069bec5sm119503825e9.37.2024.08.06.01.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 01:41:30 -0700 (PDT)
Message-ID: <fa477ba6-18d2-461f-86fb-4fff75464b9c@gmail.com>
Date: Tue, 6 Aug 2024 11:41:29 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] [Newcomer] t7004: Do not prepare things outside
 test_expect_success
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
References: <20240805235917.190699-1-abdobngad@gmail.com>
 <20240805235917.190699-5-abdobngad@gmail.com>
 <CAPig+cQehwONpjnjPVJEVvviistiSLODLNx-yFBusEPaihnf+w@mail.gmail.com>
Content-Language: en-US
From: AbdAlRahman Gad <abdobngad@gmail.com>
In-Reply-To: <CAPig+cQehwONpjnjPVJEVvviistiSLODLNx-yFBusEPaihnf+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/6/24 06:29, Eric Sunshine wrote:
> On Mon, Aug 5, 2024 at 8:00 PM AbdAlRahman Gad <abdobngad@gmail.com> wrote:
>> Do not prepare expect and other things outside test_expect_success.
>> Also add '\' before EOF to avoid shell interpolation and '-' to allow
>> indentation of the body.
>>
>> Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
> 
> When you reroll, it might be a good idea to explain _why_ we don't
> want to run code outside of `test_expect_success`: in particular, if
> such code fails for some reason, we won't necessarily hear about it in
> a timely fashion (or perhaps at all). By placing all code inside
> `test_expect_success` it ensures that we know immediately if it fails.

Thanks! I'll do that in the next version.

>>   test_expect_success GPG,RFC1991 \
>>          'reediting a signed tag body omits signature' '
>> +       cat >fakeeditor <<-\EOF &&
>> +       #!/bin/sh
>> +       cp "$1" actual
>> +       EOF
>> +       chmod +x fakeeditor &&
> 
> It's completely outside the scope of this particular patch, but
> another modernization which could be done in a separate patch (or a
> separate patch series -- it doesn't need to be part of this series)
> would be to take advantage of `write_script` which eliminates some of
> the boilerplate-work that the above code is doing. For instance:
> 
>      write_script fakeeditor <<-\EOF
>      cp "$1" actual
>      EOF
> 
> Notice that `write_script` takes care of emitting the `#!/bin/sh` line
> and the `chmod +x`.

There is only two cases in this file. I'll add a patch to the end of v5.
