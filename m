Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301E3921C4
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052523; cv=none; b=tNbzO/HBZy0h0XzGh7Wmqzju3tq1PM8vB9kMJzf4IdlkhXF849thLW3iq8cbvEJTRbyrz7MA6fXqOFZIVz4NBrc11pEb8wiQpz5F3PvtkgCdrAR/Eg4ls9+oeERWEBGTVxlY9oAgvdwgnLgPli9L6V6kiBZ5InNN79D7B8cNzBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052523; c=relaxed/simple;
	bh=5YVUj+T6lK3X4sy5dAHZXRwbCigmU0ZgAWEPrcV/6Ss=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oZG8+dd1fCxPM/64AUeSqHaLphmQjFySdXf1FgEj2vE39cBFq1udNuEdf19qVKTUQc93+CoCtX/3FdWAKDsmGoAkoTYw+IOROWYGwIjSAWxd9sjWkoHFrS/TP5FAymiDtgs765LDUQE+COsxJ3mGLvI06gFaDP5/zU+ezlHHPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sw2LDMF7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw2LDMF7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439af7d77f0so7308797f8f.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773052520; x=1773657320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ztydFhnV7fWf62qwtBiAM4pwcL+D0hfO9vVVlX2JgPM=;
        b=Sw2LDMF7Qanwqscg5kGzNR5vlSY3gUVNPMTeX+f/HRcxXaLSUJoae7AAnVSjPMLz+U
         tsgPtjwj2Zn+SHaMI5yxakNBO6kmiYmDKjIdtfFwipm1vlFgSFiLGaB1bUAe7k5/D78b
         aslCK3oG7IyoZk3KZl2TAW6n6adGYN0JKOOHx2qNoH1fOLFoiQqR60N+B13r7eX+vkGW
         wbpzP6Q005QHv9jTnDDKqvrEeK5G9656lTL4CG+o1Pg4er3MgQfoli32TfdWq+U9tEkO
         BKaJAetxXEquCFiO/BtU/LOKVxRNPCiMXCCV4Y4UkcMWslmGQUEL4b/xodIQUINXVoka
         va0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052520; x=1773657320;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztydFhnV7fWf62qwtBiAM4pwcL+D0hfO9vVVlX2JgPM=;
        b=oy16hcQx2r2IAQZgTuSLUQGp2ua6V/RaoocpIUedOP9M1lsSYgDbwPNXLRReBg+TzC
         xo+KNo1c8XGadxRogXotmVJHjFXT8mhLKVplDnrBLtF/jo/F0pniWsbnbU79UDCvTZ5S
         aZ2sIEtcp4h75FuEbAOrtOX6pUSRaAmOAeC4PF/Sof324v28Xu38p/P9gIbNAHgYhOEf
         NFztjUWHuJLjYPDNRLbe5/rdHWE/RHWq7p3GjLZeBoESTRaoGXufcA1TRlrMMtPRqm18
         G3Tdx4fl/vkQcnc1ZhDT9zmPGCQI7UtDBx4QxOmkKAKOViXq7bEkXwSSohP1DyrjeE4F
         tbZQ==
X-Gm-Message-State: AOJu0Yzt3y6DlLSvYVrjOWSwh+cBWxgkk7t/UG9+i2NDC//hMql5BNmv
	FZVhXQdI+S7jnMji/tsycPOEdcQBRX4XDpcdb6dHqm7ZrnNHGQoFZss1
X-Gm-Gg: ATEYQzxJB8DtnSOVz8PCqD0IAtZzqDsvtmTt7iNkMoUorpoJ/YNfsObLjxv35wYlfwT
	6MZ9JPIKhJbrv3PSemMz+VkpH/jNPOjvqPX9A+47Rk3O1oRUV+kdbqI3NdeSDqqRMtfrhmIniXz
	O/CN+GdiiuhhlKjSoCbsw5Zvfl1slj/K+FslX7QV39xwYRa+we21Pj4rIpgSIU9bkHhbsPb4l5H
	FHJBtgrQPw4Y512af6O4U/1N3cj/XjhnmWOcApu8akF0ENG0kSydry3cFTUfmR1hVhQ9gZZ3BNE
	v9x/xUN8hXyNfTIuoNSvOEMDTPGyTyH5387IvfaswiSvJjE+ALn3paUm9SyCwpUe2MntBS1/HVP
	nHGRMrx7uvqyrvOxovyIJQdHskUW22mECLissr0zvgD24hvND7+Oc7+KcMuZ3Q0IyVV6mZLW2JV
	dR91hFq405VsDp5G8Usz9NLjAwEBqdr5W2XvjEpzfQjOWHJReCBqEH4YsAG84OOVbU0+svtg5gr
	ZDNqg==
X-Received: by 2002:a05:600c:8b88:b0:485:30d4:6b98 with SMTP id 5b1f17b1804b1-48530d46ef4mr110211695e9.15.1773052519704;
        Mon, 09 Mar 2026 03:35:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246fd127sm124050685e9.6.2026.03.09.03.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 03:35:19 -0700 (PDT)
Message-ID: <6c3fbe17-1db2-4823-8aa6-6caf15cc61d8@gmail.com>
Date: Mon, 9 Mar 2026 10:35:17 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/3] wt-status: reduce reliance on global state
To: Junio C Hamano <gitster@pobox.com>,
 Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com>
 <xmqqbjh0y4i1.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqbjh0y4i1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2026 22:31, Junio C Hamano wrote:
> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> 
>> Changes in v5:
>>   - Added the usage of struct repository *r in addition to adding it as a parameter to the functions,
>>      in patch 1/3 instead of doing that in 2/3.
> 
> We haven't seen any reviews on the latest round, but the previous
> iterations all had good discussions.  Is everybody find this round
> satisfactory?  If so, let me mark the topic for 'next'.

Yes this looks good, lets merge it (sorry I thought I'd reviewed this 
round when it was posted but clearly didn't actually get round to it)

Thanks

Phillip

