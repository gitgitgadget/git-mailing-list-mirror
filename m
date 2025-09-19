Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F2B303CAD
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296334; cv=none; b=XXwEImR9JGvgE/PTLWrUfjPATbNQB7JiSZCPVj+decEPxF/cN0V7/BdGCjo4DiLP2ZqS8adrW0RIeCZy7ZfYgWMJXmCvu2Y9Z8XuRkbCQBvDWcyolGeH7+s8CMfyNxV8wHtssptzrJTD1nE06SLg8FaU9ZQqeuvWM1YpETUFcKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296334; c=relaxed/simple;
	bh=d341e818ERfenHNVl9eGEyGxAzHiQvUOG2F1oFYVwZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJVS5Ut/V0iCH8r1uW9ueU/R0GSUGeK/h+C+Q1oJxTd2gjb4ntuogwOnjk7EofeuYqzZWEvLdR/EvGQZO2+hY7q8c9baxvJxAnukedqoykC52nvkgoMmzvar/Ak8KtY2ryHnHP4gLoXkR90f+3ITHxVlofvdDzkAibu0DjIGdgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6OrqWbQ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6OrqWbQ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8117aef2476so233394785a.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758296331; x=1758901131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=289jZlHtd09UcAjS/BeH72TDXWFaJzwk2W0cn0YeilA=;
        b=D6OrqWbQ7DvuSEljF3CHt2Ye3PwU+b3Kkn8+VnaoFdb+PDyxoyfAKNlzdzNBoKxV1f
         PeAa6Dwad1sR+1mkW4/HeQEbdDPIHRbFai5NHJCag1OCrLg+dwxkvINGJRFnlsL+PbHE
         Odx35LLuo2Lms2Xt5rILybe7bdbtU3dmblPTARmUKskGu0iDSzIwMGBOFy4hrjJrrywS
         QBHb/+DO1hxVxxHI7SRQu+WHoo5K7t+G+ji635+T8myVAlWAlAoWY6izD0ts3+4kpJid
         j7nuUXCbRU8+IKPmvty/FjD3IrCRP8Ha4SMWkKhkZSHXCsv9vAw+INJRbZWsXtKc2ksT
         vTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296331; x=1758901131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=289jZlHtd09UcAjS/BeH72TDXWFaJzwk2W0cn0YeilA=;
        b=AvQa5i5FkGMd1fiXarGGFskn7Xq417CynjFM1HepcOgEA4MRsb/FAvZeOPDjlyS3ds
         BD3+2XmPNiwyWLEluOzw6BA6zRQFRBRTy31xtpmU83d5VGwY8X5JzPQN12t0XkKjnAMo
         7lh1DSWQK3ORZtMmQX3rznaeGaJmj1Uk9uPJ7FI3C19xcECuXdNjOC6EsQ9kGzk0dxsr
         9qoYXrfuWGJY92Es5ZmirPclkYODHdJSkzvrbAw02es8e9+ART+veTMVtk4ayxhZwee+
         2swNgWXo7yGMgK+8hjjN4mpMbW4o7FPaW0gyj+2yDCa2hHe5hK2E0K2pNebJx5cUjrjx
         KtHA==
X-Forwarded-Encrypted: i=1; AJvYcCUMtIORsgQOsf+1HrxIALZvbmYZ+AAkPrjKnkj8U9psz6PAAwfSD7xf8MPS2twKUpNML7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtztRtWMpqsZhyfGWnLiF9FS/LIZCOkUCEH2xihHGaTCgxNL4
	TekuHc/MDTaZ89DH4YDnLgJcKNcKJ13b2P2d4uLq2LdlGBpgzn7P7iYb
X-Gm-Gg: ASbGncsSE3rdn0Ufbc6IhrMPeSm/6R2L37zEMEnhPinDuy0hr8MvhhUUBIpv+yj64us
	Ev/PybHceJfc8GDewo75IRTDCWzIDowTpr0VL/lLJ0QgFMqW2lXlqkYx76Kl21KRVb4cOJUF+7p
	N1ky1yUqh5Nu50cwX40ssbSSUn5N6lIgS5rr9PDqcaw7mdRQpKR1f6N4emS8pM6lAWQ3BNhP3JM
	eF8rf9gTmvETN0x8Yg8X5aaBwcOGvgNZBR/tb9U6jxiWi9CmPSB/PuoRYSuPFzkSrlMkpVXCHtG
	HaldaBHPY5cuAFwWMAFcN0eOoDn+wnytJk30w3dKYB144CwbuJo4bZhY16rXypYaf06QI5pavVk
	6XsI5mfBoOeLzM0+1a55EVYC7/6Rt0x9+j2zVlOKsSnPMvysUosnRsgUlaE0hEeHOcZI78G/U2g
	==
X-Google-Smtp-Source: AGHT+IGVf0g2wnAM/ClK0KC8ql/VYBZ0Mc6VmTdw/6TOx+Iju0f2PSA6lCs7vymmL8ggsfkZ+2D+Rw==
X-Received: by 2002:a05:620a:4556:b0:814:da1f:376d with SMTP id af79cd13be357-83bae34b65emr436386285a.71.1758296331378;
        Fri, 19 Sep 2025 08:38:51 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:b465:3774:7590:352e? ([2605:a601:a6de:d300:b465:3774:7590:352e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8361b486263sm365498785a.0.2025.09.19.08.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:38:50 -0700 (PDT)
Message-ID: <08deb8a8-6c34-4f11-a36b-93d151a56f9b@gmail.com>
Date: Fri, 19 Sep 2025 11:38:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] how to find options set by scalar?
To: Junio C Hamano <gitster@pobox.com>,
 Matthew Hughes <matthewhughes934@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <vppjutjcdglp44qvsk4qozphycyg663yrq5775zztim2oe7ty5@uttjrshb52bd>
 <aMkVqNbdgxqBJ9K4@pks.im>
 <evxbvwwyo4p4iboc4k6r2cd2cvlnm2upgxumqopdijwmvhxhxs@7xvg42heibp3>
 <xmqqikhf7bdf.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqikhf7bdf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/2025 4:29 PM, Junio C Hamano wrote:
> Matthew Hughes <matthewhughes934@gmail.com> writes:
> 
>> I was also looking through the list of config options (within
>> `set_recommended_config`) and thought it might also be useful to comment why
>> each those settings are recommended in the context of working within a large
>> repository.
> 
> That would be ultra useful.

I think all of these ideas are good ones. Adding the comment as Patrick
described is good, for sure.

Instead of commenting the _reason_ in code or in the config, it would be
good to list the reasons for each recommended config in the Scalar docs
so they would be visible in web docs [1] for easy discovery.

[1] https://git-scm.com/docs/scalar

It seems like Patrick is already 80% of the way to a patch for the
comment in the config. I'll see if I can carve out some time next week
for the commentary on the config options in the Documentation.

Thanks,
-Stolee

