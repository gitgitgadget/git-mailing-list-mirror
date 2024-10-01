Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA23B67D
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776872; cv=none; b=s/jh/UIBm2sw/yVAra34XbMUdQuR1p1wOaOViG6BpYn1b/ucXlhnNyUph4B2Hr+uX5DqJq/q9YHd4lLP85J8x/AATtmeNZjORAVh+vS+qbSoh/RX8Ox3GvXe9PH0R5poaf4ApxB0+uYXNLAazY9OS1pQLT3U5wXujTQH0ao8K5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776872; c=relaxed/simple;
	bh=+8nht/RTl8Zn+wKiVlZfTyzz1uDz3hs/dzNjQU2xE2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIRgxe7khGCsRrMjwzqRQSf9Cn/Hn8fBKN/VFWuhGJFFUv0jymDH/HxMg0TQERmFqGW8ZdB7UzXlilFHgXTOayDD/CNrRSNQ7I2tBJDuTsg3xlO9+4Xy4qbPhyc1QW33emujbI+mh9i1PqfBBMRYi0Y21BokWQ/MlMxr6NAlkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVx2RBo3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVx2RBo3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b49ee353cso36487995ad.2
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727776870; x=1728381670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAxpaJ4YovIgpkKXmJTyrAD2N0Jt9jagu/9oRCw4hpY=;
        b=LVx2RBo3TB5tYdMXEBqXGRyCJ2DBC7/mNLbjHgkEMdMbm7AWBE74s14fOBdUiHUoRa
         ZggubKpOzD+k+Bg0VP6U4rxTegmOfZ14KGrk/JzUcwTjOsF/4aUcLFFAB0E65mXRs3eq
         U+xHwpSSiXoAk+xo7Tv+wHURGmqdyU9Qaq6VadGWtDJLKzOT7ER+lN+OH8AYGfE8ga8W
         rI19jpm7SlWXQ7LQ0IGfb3OFfiN620JGigKQD8qtUi74ZxCxRjkUdBqpDnBsN4Bin9we
         NOzVapl21Dw0oogftCGF3UpcuG3GEwWwPh3k5j2DnZlIrT3m4FCfD4sw85jIBMorv4tM
         5JbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727776870; x=1728381670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAxpaJ4YovIgpkKXmJTyrAD2N0Jt9jagu/9oRCw4hpY=;
        b=wbrBHXRjP0ZXta7I9CLr4PiY1fmewWK3+J3BcOkDW2oBJGEc7SAHMf4MajtFkeP0Gk
         17huXR/8zqmcHOSG5Y2tnyRZwI3aj8L2wO8qNKBYHLJIr1yyFtY8dCZfHjeE7HZbjFxF
         fzoYqL7c2QNVpukJm03ZAmfF8TfN61EoDc/0lGZdEBozapPSkS8kM8Qp0S3DrSUutWKG
         EXLzZfcZ3BZIIN5xG8qPQz8uTrVvjotMJlKUF10BOC+tGhI2BBHMtEodmffPhUBbXdet
         jPKd1h5Wucr+FLSD71I6itxgKkCxa/2Bm4Amh4rhvKYxHgzSrMNBesfbGtdjaB44ldbN
         blXA==
X-Gm-Message-State: AOJu0YyIqZkXEFdasZVdvdsELGDDFkM2Ks+BR3hjAWbxfYITjL4SiQ2q
	rx1KY/IwyUQYpP2xXlonRcYl9FcBwMZymcpaMBOhFTgHKi9sIuTN
X-Google-Smtp-Source: AGHT+IH488Bhkf1+iOp6Z+QhB0x3AQDC012iit8P14Gg9l8CS1/fVuj+roRJm/sXGWqsA9H9G3wiww==
X-Received: by 2002:a17:902:d490:b0:20b:8f04:b076 with SMTP id d9443c01a7336-20b8f04c764mr90967835ad.13.1727776868827;
        Tue, 01 Oct 2024 03:01:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:f0c7:be19:c0b9:ffdb? ([2600:1700:60ba:9810:f0c7:be19:c0b9:ffdb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37dabc6esm66617325ad.101.2024.10.01.03.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 03:01:08 -0700 (PDT)
Message-ID: <0f257003-5a8d-4eca-987d-517d9754f1fd@gmail.com>
Date: Tue, 1 Oct 2024 06:01:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] read-cache: free hash context in do_write_index()
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
References: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
 <b6fe5b3ef7e5f4ac8cc339685d92e3ac39fcb456.1727696424.git.gitgitgadget@gmail.com>
 <ZvqaRIY1OzOIh1bc@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZvqaRIY1OzOIh1bc@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 8:32 AM, Patrick Steinhardt wrote:
> On Mon, Sep 30, 2024 at 11:40:24AM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>

>> diff --git a/read-cache.c b/read-cache.c
>> index 3c078afadbc..51845c2e611 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -3126,6 +3126,7 @@ out:
>>   		free_hashfile(f);
>>   	strbuf_release(&sb);
>>   	free(ieot);
>> +	free(eoie_c);
>>   	return ret;
>>   }
> 
> Yup, this one looks correct. I've sent out an equivalent patch via [1] a
> couple hours ago.
> 
> Patrick
> 
> [1]: https://lore.kernel.org/git/c51f40c5bd0c56967e348363e784222de7884b79.1727687410.git.ps@pks.im/

Sorry for the collision. I had checked when prepping the GGG PR on
Friday but forgot to check again before submitting. Your patch is
better in substance and context.

Thanks,
-Stolee

