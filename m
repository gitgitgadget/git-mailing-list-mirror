Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D53FA5DD
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106788; cv=none; b=gHC2g09DrsZ+6d83nZpPdHrVYJXggLBK0Rp1yrg0skofD94AQZb1R1YdFkfXhU9XoV7TjmbYVA2UhNycBlcagF+k8eZVaXBp0l4MTspyJtgceAOXm0GRsR+FSanwq290FFeGwVh2h098mcGLqxX9jUBDE+2amONgpSNDJ5zO3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106788; c=relaxed/simple;
	bh=zhEJAK5y3CVzfqunE6hfI9+4vLygGrxlUk8hCSFx54E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iL5zmntVkp0OYxnzYTKNwhaPxXZmExJX/V0D9EQkFnZlvshKOFiQQ5reFGvZOjlTwRwIiXMQGXy7WtHi38FcMBaELNeSiPP74J44Z9X2/MWoeQLZYJ0bKoXOK5hW67AH2nGKRnxNEqg02TD90UsGFkyWdGVX2QoTtoVJmkXwAwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlykuK8i; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlykuK8i"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso30835365e9.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784106781; x=1784711581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZhZqBO/BoE5pfiWOR6R/r1Rd8LuI2aHrYHiITBRdhnc=;
        b=XlykuK8i99ACwAaLVqzoMoPmzw0RQDwBPGVlla8UomUTFVmH190EE3C0+EDMbLXeaR
         nNdmPWOmCeQ5lAn7fGdIalsQhovKMlDqsYmgBGypPX8Ww9FOk6kXDLMz19LFemvLb5uD
         nKpvBP1bxzUEiV9JWXvoVt1smO+s0jfN6H3q6WJxhjX6OKQ91lYUiTt3PK3dQkHjCWtC
         x1ELp31p9zLLiZctPsG3nEaYzMsWLS2gOBVefdw0wc0w3T4dCby8VeKU93jl3TrS0YGJ
         OH0e+At+M0N4XKx6juMP9oL4YBGmUq+IIqdeBjUlE/VC62lV//qg7GhChcJz39Yd3VUL
         N8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106781; x=1784711581;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZhZqBO/BoE5pfiWOR6R/r1Rd8LuI2aHrYHiITBRdhnc=;
        b=iWFTnPMLjF0XZkG0UvxgoH0gJBOiL+myIYEfpBiLv7FY0Rsf4hYe30VDmHZCDQ3/6P
         YMPLXELvPs2MNHqsZ7qeAnc0HMMANM2REs7xNCSj6f+RaaVt121rdX5wdxtvlrJdcQiu
         G5XzR5CPriYkwMU06VSVfASQF8wRavq5EpqXIgkb5w/LjyWweWDlSYddwuxGznTVkCeV
         /pNXk9tM2vKxdviDICYA5BXQTt8g7+kxDFb9fcyo1b1iNTm5z0RHxXcgtVpNrGXJ41Ew
         MRfWhQWA4YlGTivvURHgZT/QOTRF3DS5kOa93+YUs7FdkcWf6P6oVs2gQZqdfpMqxZUI
         vfSw==
X-Forwarded-Encrypted: i=1; AHgh+RqCQfAZbTMyAn+EbZUv69Kkv5Cugb70st641fvo3yEWiTFyFsX7j2PYjCDZAwvy+UK0RA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTJicax5Y42ENcoJ1OAG6DShugREDsDDV53qmHRldK10fVeGn
	gVWsBMHWQ0K920kjx0iBPzKRpbEjIqe/3pU9YGcobg3UDSUp9sqlwoEJ
X-Gm-Gg: AfdE7ck1pxIEYWkUpgCMBVuKglafVwq85NW2f9p0Z6AdudeDe9w7h9m3SCwgFomxdm6
	PCkF2WhfK9TWR+nwIO5QqMI6QTXuKcvhACVEg/KCRIWl0JpYhXhQ54lR2o2SwdrPP1tGtzYtnEp
	5vP7Owp2nNNmpRbM1KMbEMwcN2cYz2i1Pj1UM7z9vqkbRTcXAadcYlCpr7CtWz9B8v7lrJhComn
	qhRdCwQ+9HR92U4G07y3aSH0lS3nUCd5H8yKtTLeKTvMm9yO+iMhMvYJAdQTotJ2r6EmMlUXzAj
	E3A8rZdPBhm09/7a5sLnIRLsMqvLvsk7/vYO+p9lAmkCNaEh5/TRem4UaKUwfsNatL1RfeB9IWF
	DGkzkjw/LAIxTHTCtAT0BRfXYHPUWFafNJZEQFC0tQ0rNJTe516zzLrkQgk0g1OAslCHYGQc6+O
	oYecRtGdDMei3Tz2zDNZ6eXm1FsbBYFQgJhO0svu5grpGUKatcoIzdC+qd1Ugvj8sM8I0=
X-Received: by 2002:a05:600d:84ca:20b0:493:c984:db9c with SMTP id 5b1f17b1804b1-495389ce041mr43115115e9.2.1784106780900;
        Wed, 15 Jul 2026 02:13:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508728019sm134099065e9.5.2026.07.15.02.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 02:13:00 -0700 (PDT)
Message-ID: <3856a84b-4680-41fd-bae6-3fab538dc3d7@gmail.com>
Date: Wed, 15 Jul 2026 10:12:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 02/10] sequencer: move definition of is_final_fixup()
To: Andrei Rybak <rybak.a.v@gmail.com>
Cc: farid.m.zakaria@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 oswald.buddenhagen@gmx.de, phillip.wood@dunelm.org.uk,
 u.kleine-koenig@baylibre.com
References: <02670f57e7d81d4ff7341fecff3ef04b9fdc0102.1783948637.git.phillip.wood@dunelm.org.uk>
 <20260714225056.2285055-1-rybak.a.v@gmail.com>
Content-Language: en-US
In-Reply-To: <20260714225056.2285055-1-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrei

On 14/07/2026 23:50, Andrei Rybak wrote:
>> Move this function earlier in the file in preparation for adding a
>> new caller in a later commit.
>>
>> @@ -4925,6 +4910,21 @@ static int reread_todo_if_changed(struct repository *r,
> 
> 4910 is greater than 4627, the function is_final_fixup() seems to have been
> moved _later_ in the file.  But the commit message says "Move this function
> earlier in the file".  Am I missing something?

Oh, thanks for the sanity check. I could have sworn I had to move this 
function to get a later commit to compile at one point, but it clearly 
doesn't need to move now. I'll drop this patch.

Thanks

Phillip

> 
>>   	strbuf_release(&buf);
>>   
>>   	return 0;
>> +}
>> +
>> +static int is_final_fixup(struct todo_list *todo_list)
>> +{
>> +	int i = todo_list->current;
>> +
>> +	if (!is_fixup(todo_list->items[i].command))
>> +		return 0;
>> +
>> +	while (++i < todo_list->nr)
>> +		if (is_fixup(todo_list->items[i].command))
>> +			return 0;
>> +		else if (!is_noop(todo_list->items[i].command))
>> +			break;
>> +	return 1;
>>   }
>>   
>>   static const char rescheduled_advice[] =
>> -- 
>> 2.54.0.200.gfd8d68259e3

