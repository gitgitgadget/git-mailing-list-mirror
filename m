Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DADE12D213
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361336; cv=none; b=ld4tIE70wQbudp0wRYQvzfUbAFPnsmMH7DCqHurO585erPQuU92QoS7tuRYs0rXMd4+JeI+dLOW9oj/iqyDciqfsWAi3kfztNxBuGxzQM7K0D8oXbrW+gKG6BibF/npB6pEYBOXlrBe6IEU8qcVi/w25EnGwZPoljGEKhP1dAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361336; c=relaxed/simple;
	bh=b7XNukJkGmZKksKhGtgEsFGC6YXv6QpU81LsFYby+nY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hkAftyBjchMkuZKOZxSAd5rOccFejn9FuT1fJaUhuga+4minkghZLoae8oYLxJ2W6WCtokurkdRjj2hB6ae3A6N1DYTeYugjlnroO8yffMrZgburR6cKL2UnnJGLjaInWKRwcxgNGJPp+MFvzr+hA8an2iGq9QTuM0uXFhLSUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHFV1lKH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHFV1lKH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3416a975840so3163934f8f.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711361333; x=1711966133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AQcTjA/K4PXMErUxvKmQ5STPIpGUoBVxi3ZYQF5g9JM=;
        b=YHFV1lKH5B8aEv2vE7PMNWZCZpYuZxNBeH+0faXDEtM0l90FNIGhkfSAaLQkwIXe5h
         Z8XSak64BQ9U/SD0rMEnC1We75WazCRvdotyKP88wGGXwggqtBnjeRsnPlUy54RxCjfY
         LlRulSMs7/fkefK8j6VR7wB6PXPzFVwuwOD7BuvgpTfwdF6a2MR7pYJat9GYtUjMRclx
         fyB11inVBHwreZPQRqnO1USOyEQ14ekrnE2NYB/wIoLVp6rf3Te0UHR1fA3vtu5HO648
         9MA5PpipLQ9tg5bmNbsfFWtADQLaNK4m+1Vy1/R+fjUQMhjDS/OkiSq3wo21qLmN0TzO
         7vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361333; x=1711966133;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQcTjA/K4PXMErUxvKmQ5STPIpGUoBVxi3ZYQF5g9JM=;
        b=YSaaMVuospGSM3fMskxmkAgdmH7cf4Hc8dQWYNmMAYxnMqe/3LDnxUBcLiRAqXKG5z
         beyil5KOIOwh74zrnDdUh9kKjlWpJwHad9WYxid14frWBevG5F0BCPyo2iHhUHkYBsxr
         HJbpZlozgYiejNf0xttB7n38j+7JOPpGMSWn4WY3+V/ur58eB054aNcwleiQ7qTlZ4lu
         cyuXStUPLu2+l0/g0nSQJTiDeG9OlyrrGRJu876I/UTkc2qWNoJYkZ1Ss6KPINaylPFK
         DeX3meUhqR4ASQkxu0GmQQCrMh+hFreXJvKv+crKGEG1849V/MfI85LTw2UkbXwLLv2o
         zjLg==
X-Forwarded-Encrypted: i=1; AJvYcCWvWq2uFSGUBeOpAzvScDQsd2nFK9J2lI8WZxsxNNQbAGqFCQGCRtTYfiNXjNkuAJA+igIlDd5tYHqini/eR4gAJP0C
X-Gm-Message-State: AOJu0YxBXYku4q3CpkYPCd5vek0PId3TjUA7GqS0yoQIfGngaOwa62/v
	z1U9RPI6rX11N7LWtzyDw2Qeb6+7fSOf8FZ94pbFNitcCpbyqG4f2qFkVelq
X-Google-Smtp-Source: AGHT+IFZrUBPLB0UAdPcmxUEP3FhkbbjNLb9JTM6rly2Yv/RRYDS5RQUaQeIl8yix1tMsR83HljjBQ==
X-Received: by 2002:a05:6000:1374:b0:33e:a1e3:87b3 with SMTP id q20-20020a056000137400b0033ea1e387b3mr4679586wrz.41.1711361333454;
        Mon, 25 Mar 2024 03:08:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d5585000000b0033ed7181fd1sm9115396wrv.62.2024.03.25.03.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 03:08:53 -0700 (PDT)
Message-ID: <82415cdc-6544-4bb2-8080-90b002b1ed1d@gmail.com>
Date: Mon, 25 Mar 2024 10:08:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/6] maintenance: use packaged systemd units
Content-Language: en-US
To: Eric Sunshine <sunshine@sunshineco.com>, phillip.wood@dunelm.org.uk
Cc: Max Gautier <mg@max.gautier.name>, git@vger.kernel.org,
 =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
 Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com>
 <CAPig+cT1Bz9M5zsB_OSEu-LTTVMBPY6U4vaDHmoHtmoDfH+hpg@mail.gmail.com>
In-Reply-To: <CAPig+cT1Bz9M5zsB_OSEu-LTTVMBPY6U4vaDHmoHtmoDfH+hpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/03/2024 17:03, Eric Sunshine wrote:
> On Sun, Mar 24, 2024 at 10:55 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> 5 - documentation updates
>>     I'm on the fence about having these in a separate commit like the
>>     current patch 5 or updating the documentation when the code is
>>     changed.
> 
> It's generally more reviewer-friendly to bundle documentation change
> into the patch which changes the observable behavior. This way, a
> reviewer has the behavior change fresh in mind and can verify that the
> revised documentation matches the new implementation. Same goes for
> revising tests in the same patch which changes behavior (though, of
> course, revising tests at the same time as the change of behavior is
> also mandatory for maintaining bisectability).

Good point, I think a couple of the documentation changes like 
recommending "systemctl --user edit" were improving the existing docs 
and so they should be in a separate commit at the start of the series. 
The other patches should update the documentation as the code changes.

Thanks

Phillip
