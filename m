Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28BD3C0D
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 04:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576320; cv=none; b=pnynLDLiZ1MFuP8wcyRyWZdfwt/GWtaRXj06Z9IwWNyLJnZ8XJmMVDITvTCEFtv8Yi7vi6xfX6RB7j0sRwyV7E2CnHEzhb7IxbDLVgwaxnmLEbkJbVQ91vEpa7/ZS4/94u2tUTJY1/+f4oi4Kg1y5sthIVX7gciTjWKXtY4loIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576320; c=relaxed/simple;
	bh=7QAKhZGpu803jaRaWx9gDxyWKxPDmwI79uO63cC7QmA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DUqRBf94cgK3exX+5jFJJi/FPRR5aLdDY91QnlyMI0+9H3kT1/s/1jEmnF2NNNHTxpBBnoyLzq87pU3Gkhh+rvBdKyGc8o5e1x2vmMWxryqQpQzDx9i3Qis4l7RQjDTc/FKFLPX2FTQv0Z1dvbgWqnSX8tsU4eHM8uQvg+SAlgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCv8fiA4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCv8fiA4"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso6164639a12.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 20:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708576318; x=1709181118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RzEwEglTPJ7MptbsVg/xg4V1Pc3KAkSSng5wJEUE4g=;
        b=SCv8fiA4yJSDfkGDw8paqqpG3rhrYzLKtjsN1ucjUeC3LuQ6oAbIcBYu1ElnIqFZft
         2PEAWwHTXLfWrAQUZF9igJHfz9htuN2fUtXZcracGNhIMNGpZ5iPd88rPMe0SqNv/dOQ
         c5xvk0vtD+IawaOQT0G/8boJ/pfZslqBqxKloKz9ECBMlixEt9Y7DeHNmeirPi8NZxep
         Fi7V8z6OKpufv6eHY8RzTtp684/QuOydwpGO4MUHG51FYiS2YSCvzWyZF2q84pwL+7Pv
         yd9wd5uIybw1k+7VfhkwPk+79nLr9RrRPYDuwWivRFM5RaxlZuFnqkHga7tUd1sO+rXH
         SgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708576318; x=1709181118;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RzEwEglTPJ7MptbsVg/xg4V1Pc3KAkSSng5wJEUE4g=;
        b=PWoKxo4+0bBjMnHmfOMo6I2tkauVLjd8T2gjcchHQiA/mdaMzozGiEsm4gfrJGsj4n
         NFEg13YP8I/1pQewnhMw+RFdf9OcSMcNdifwdyjDqkeEUuNKeu4XMLarn5+XcMvhR6ns
         usp4eZn8Cc5IYBXxQmTTYDua6pOYglPj2yGgyf/N0k1xQGjO6zY58FdHH2TZjFZsdjfk
         Feui8fRxk82CqkO2l1AzAkgsqjqYJdrpq/RenUN5X0DdWPfpf5wOf+qEHeZHAmdScx+n
         1LlANRM6QQ5CM5kkTpvRdKraOlqOxVeJTJ+se3ZVnYJ6LOcTqF4gfcG4bs8oqis+wefi
         pUSw==
X-Forwarded-Encrypted: i=1; AJvYcCXH7CkknRvqOUvx2J+uPuFpe5irRyYBJRvWnMhX0tOVjck8smB3jyCgMpjlU1TbUr0mBawJYeySHik7BTKlsBnGrfQ7
X-Gm-Message-State: AOJu0Yz3znPzoTZXyUjo3EE1e9euE4MU8Pcr8rWm6tkp/+GiJvQ1hqND
	yOnxVQaieYoX18gRGPmWWGSfsiXmWo2YHWRzMnG35xgad944n+XC
X-Google-Smtp-Source: AGHT+IH/UizSxWR/4HBi1G37JwI8WLgip4gl1e/aB6Rv0ngpmlQpJfa1ei/Y8AdMdJyc30hr42uq+Q==
X-Received: by 2002:a05:6a20:9f4f:b0:19e:caf3:87ea with SMTP id ml15-20020a056a209f4f00b0019ecaf387eamr26338878pzb.49.1708576317950;
        Wed, 21 Feb 2024 20:31:57 -0800 (PST)
Received: from [10.93.4.115] ([220.158.131.105])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902e98900b001db45855528sm8781370plb.198.2024.02.21.20.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 20:31:57 -0800 (PST)
Message-ID: <9cec06d8-971b-4c5d-9d85-969021b0dd48@gmail.com>
Date: Thu, 22 Feb 2024 10:01:54 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2024
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Christian Couder <christian.couder@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
 git <git@vger.kernel.org>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Victoria Dye <vdye@github.com>
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki>
 <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com> <Zbtmoo8qTmj-yt99@tanuki>
 <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
 <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com>
 <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
In-Reply-To: <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian, Patrick, Karthik and all,

On 21/02/24 10:32, Kaartic Sivaraam wrote:
> 
> Christian, could you do the following so that I could add you as an Org
> Admin for the 2024 program?
> 
> "Visit https://g.co/gsoc site, click on the 2024 bar which will display
> the 2024 Program Rules and Org Member agreement, read and agree to the
> same."
> 
> For mentors, as Patrick and Karthik are new to the program, we need to
> invite them first and only after they've accepted the invitation can we
> add them to the program.
> 
> Karthik, I was able to get your Gmail address and have sent an invite to
> you. Could you accept the same after reading through the program rules
> and member agreement?
> 
> Patrick, could you kindly share with me your Gmail address so that I could
> invite you to the program?
> 

Thanks for the quick turnaround all! I've added all of you to the 2024 
program. I hope you're able to access the program page at [1]. Let me 
know if you're facing any issues.

Also, it's official now. Git has been selected as one of the 
participating organizations[2] in GSoC 2024!

Let's look forward towards a summer with great GSoC contributors who 
hopefully become continued contributors to the community :-)

[[ References ]]

[1]: 
https://summerofcode.withgoogle.com/organizations/git/programs/2024/timeline

[2]: https://summerofcode.withgoogle.com/programs/2024/organizations/git

-- 
Sivaraam
