Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A54A0F06
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343669; cv=none; b=qzasL7nn6vmhH0a9DXG4pM4WEdDWjtuOpIjykKw7sMWUV0ALeYw2uS1XiJbEYWWxfph7kzf8VzGLOpz13PJkxz6ViMfp+mAfdkY7EJhazHPd+0o5Taifq4B05Uvxp88WN+wGU6y9ccPV3zp65pyv5yKerKyFVaGUUmXSM7nXqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343669; c=relaxed/simple;
	bh=Olr9/sJTSYoCZu2YxJweTXn3j7Ri9DTMI94SpJc6Ibg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fExgPlMvvG2LszI3HMe9Z/Xd9/dmNbx3Ns0fwV8pF8Lg5kS75kC2qNLjOQroAkZXvXKFyiEec0L4uIJYm0gLWF/oPr6MgT3j6Gol8OQEym2udFTxogSMkRzsTfMmoaQ3AlJPDHcfARxPVI1eLWfaTgNc4cxbyXAOFHReg9zo37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1GhZ0Bt; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1GhZ0Bt"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-880483985aeso296184b3a.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790343667; x=1790948467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YzkxoaSg+69YtBHsUlNFbNi858ej4OcDUsdN182wG4A=;
        b=W1GhZ0BtaTpRfTCn7n6oU6yHmasLc1yJLAciqY65PIwoQzrLvf5vztK3UV+o726q7e
         XA7u5xjw9oepZ8pkK3b1JZVo6Nu+3HBS1muWo1w2o7T3k1SL18AfkFxXWCQIySSW7MDM
         1QIEeeKaJLkLfgh6f2oH6pU/khVz/CKaaw7SuR0fw0618QdGXIjTkZcviOIPUg+vqPd8
         NRVZjyOp9rYTc0m16Q32KpUdRQSAf/llQW5nxN4TiVrXJQNMo99cz7/KUuYFG26Knnyc
         NPRzslzO2+I0BLZwYi+KW66x1AqeM7tOcNvV/qLPhI9wqo9Zs7j5Yh1kbPSSyvtbVYBj
         8+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343667; x=1790948467;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YzkxoaSg+69YtBHsUlNFbNi858ej4OcDUsdN182wG4A=;
        b=CwQlXvUdAcjSpIoQnd5py/wdvq/kVcFMUxWgP4E059B2Y0J39WWVGXbeMh12W6tMbd
         fYPM30OcHMMcKMm57geNXZGf/0JO240GvIzgTpXe4FZkqB/f7CErQWCVXPYAdSCiiBs6
         iMOzp2h7fAr3jQUZpaUT+Y5BiytuWqO7iS3yUxhP+XUt1xqUViYZ4mxkjCULCo5edHaP
         i5FhsmmKBURqFgSHOoVuDWuf9tWbMN5V2Xe80cHxTNBz4e0HG3eAlHKZ+IJmLE9Dcpb7
         iYBOoSB7eBwMpLC3H0lvorK+CX3lwZhGYpJMEPbGz/B+5+xBcDQSdjOWqQIWyUcG76dC
         23vQ==
X-Gm-Message-State: AFuF++k7ffVLLthXjzaLY3YRhVa3s+0uaM/ESreoiosbd+dBqlb1dc4Z
	jej95Jfn1kUbTk65RRtNs7eL0LsCfgVjsDG3A0uS0dDhrz9jrPihpOI5
X-Gm-Gg: AYBFou094XVtaEo+qnPPig+nSP9wGWmF4kcJwq3qIbKxOEo0NLgIKgzDuow3/yinj3B
	HffpWfp8NiCQsU3qNMYOsXBv+sdPbE6uYAXEptjvwuOP/QikxfHwdi9b5DZ62UkNxJT2TPC59mb
	OnJ615wIGbtV6gbpEVrKGXJAVVvqUMI5HvHeNDuQxe1xZ614XwtpiR8XShQL9yaYCHTjRJWaKa0
	PDr0TqiZbBKt6oI3fVSzHqzptJctblQ7wBpg3/FodC523uuMKfu5s2oZjts2H2yhC1R1cnKvvA6
	JYtnsVWXa0EXZWcVv0w0dNrYhhXSiwbpSULd9nuUruzFPMbsHftoiPqiFSpKPS1gigzqR7dmn2f
	z+XT8GQCIZkzq7N9Nhn56hmy+WkqaShgWtbAkz+NnlDMdbX7pKqa6c4kbGSQWVZyeRahSe+8RYn
	/S90P2GyK5DjWJPr0EVrCCmk1FXbxD+jcPtd1YIMqap/5EcceZyirxZRE+ItBWKpg2TTd1fSkuq
	koL2TpESvw46g==
X-Received: by 2002:a05:6a20:3d20:b0:3d1:d188:b0fe with SMTP id adf61e73a8af0-3de0e707c90mr5031198637.13.1790343661989;
        Fri, 25 Sep 2026 06:41:01 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc790c80e62sm740603a12.28.2026.09.25.06.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 06:41:01 -0700 (PDT)
Message-ID: <efec0b1a-2b02-42d3-acd9-74155925c749@gmail.com>
Date: Fri, 25 Sep 2026 19:10:59 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] t40*: modernize
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org
References: <20260922202152.842793-1-markchucarroll@fastmail.com>
 <067c83e4-7ff9-4e2f-9ca9-2592288bcc93@gmail.com>
 <DLNPWO76XNMJ.45P0NL3HVZ3H@fastmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <DLNPWO76XNMJ.45P0NL3HVZ3H@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 22:50, Mark C. Chu-Carroll wrote:
> On Thu Sep 24, 2026 at 10:58 AM EDT, Kaartic Sivaraam wrote:
>>
>> Just a tip, you might want to use the --in-reply-to to mention the
>> message ID of your previous iteration's cover letter. This ensures your
>> iterations end up in the same thread. With this, you do not need to
>> manually include links to the previous iteration.
> 
> Should I resend this with the in-reply-to to attach it to the thread, or
> just leave it this time?
>

I may not be the best to comment. Yet, I believe it should be fine to 
start doing that from the next version.

-- 
Sivaraam

