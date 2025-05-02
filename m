Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160F2F2F
	for <git@vger.kernel.org>; Fri,  2 May 2025 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746164140; cv=none; b=Sh7Xc09yCJ2p5C5P3tg7AQHLflyLVjo/xbzVdNf4mrZ4KxNaDOyQadiNt9qA5HiUdUGCCIgO3A9h9pQ4WcsggGuGTFol4l5Rd59f/cwRax7HvYf3Q1vCEgOqOruXJwSF6LtPSJnhOciX2fAR5RFEu3+5Y9vnUAg80dadkunSdEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746164140; c=relaxed/simple;
	bh=3abmZYrIjM7HyEQd8jjCOJahGVitSNBFVAcnJFGjgA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJDa13nMnb+eDxK/Zd+grrKPVkL+UXQU4jPFgWWmBS/SyhLHMKlWTp7s/lIv8kQgBXUBfaoAs5UDwbIEdSpJ43IXHsCNzQQQQYgVCcdsA3htZ/lW+qiJFWgBdtYZwqHx5vou62l4w7UImDxeqUDJfToEHt9W484IuXmjRbz8Gmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvVo4ZH0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvVo4ZH0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso2427096a91.1
        for <git@vger.kernel.org>; Thu, 01 May 2025 22:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746164138; x=1746768938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4yp3waxr1z4LxPWlfmBMnVZnLoUtjnE2EzBGTfjtoKY=;
        b=HvVo4ZH0wxgNAbvNybJu57mSFJrkhXdgLcsv39Yw+drtxP21INec3tfR0AiTXrmXqK
         00VWnJifAig6A9Vn0G9EUFrNem4VAwJ0/RJliWfs/wl+xWQwsYzjmxeZLonhd/oZbU7R
         wBMaFXiYeO7mQc1+Z7z84cSkSj2NLlyJx8IhnDcT+kp8nt9XwD+4nOyVKHJgkCoShDlk
         3cNzseTc6q7eXtydxzKcht3tb6aOFbaCEd03309eetHxfuvHnzBQUscmOgtf6k/KZ6/Q
         nykTRC5fjZmWumfvpLpSNPyIDRpANTEH0e09E8h27/Wn8vCSjB6h/DBVmQ5kZ7FCGzVO
         dQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746164138; x=1746768938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yp3waxr1z4LxPWlfmBMnVZnLoUtjnE2EzBGTfjtoKY=;
        b=iAn222tkNk0OdSRQTcEDPUWHyzd5eKtAjfI90675VtkoaQIbxOtzcadFAksIld3v12
         dFw6j9SnPDd/DH0SnMv0OQIyEhsGjhxffJKXLwORiTdKv6mGJaqQguxGerV6vvVPVajG
         UcDxBeWdNNL5aKkI3VO7VKosQOscSLdT3+Lpg/eG8lV3LGfx4N5ViC0bqNU7ZUvjwIlP
         o+IjYB/lyV99b1/ADgl7zslJBGSiRXvx9IA47ZTNqcTm5ska7nw32x+khu5BEQA5du+F
         TIYeMsAI60cIUw1chUY9svINBSoFrel3llpJHMYeOWH1U2uGGrU4eSKrRlVqLwgyGegs
         u11w==
X-Gm-Message-State: AOJu0YypsazZ2JTOBPGbLvoemA90XNUYvEJgY+NsfiWBLOMZE2g3rd8T
	CqUOvcvV2sVQI8LKIviETw73FtzRxKHrHinYAyOf8RJMxhJ2236E
X-Gm-Gg: ASbGncuIbURVFggftw+HPy1Dsb2/YsQDi91cG6ZHQ9GEVl2gBXI1u8klLrjBuKcdFlv
	y9M4dJBTJToO4Ytr6EtxHKxxegHOh3dcMzJm9R2pSwMp5r5G4jx2ywLLVjc1Y0pRu7RVCtL3PV0
	mj67v2xIlHJKVznJFAGH0HKZzewwyk1ITrNy95qD0CqdXoEj/PjUXrlnf6vlo4Kf1kne6ODfKTg
	LVdSREhQ9bh2shQkSUoFgKWvbxWCILFEdiskExTxiIshKl0VIZvdKt3T7BgjJlX8aF8v0dUDGa/
	yio+RPGCT71E8+wrVTlnSaMLP0zJXR0IleEmsUtJ7U5Sz0Q8k9Xb7sTD3mGyMN8cNejSi7n8DjB
	HJnjA/9YZgD53H2SgbPUd/yWx
X-Google-Smtp-Source: AGHT+IFSEQnYa2zZra+OvHrO759mA/yi4Md+PHK7KBq++Sd2Wyn5W8mEM3QciJ+k/S9FiG4lgOv5fA==
X-Received: by 2002:a17:90b:2241:b0:309:e351:2e3d with SMTP id 98e67ed59e1d1-30a4e5a6097mr2957781a91.12.1746164138350;
        Thu, 01 May 2025 22:35:38 -0700 (PDT)
Received: from ?IPV6:2401:4900:263d:5de5:447a:38aa:3207:4f89? ([2401:4900:263d:5de5:447a:38aa:3207:4f89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e10940cd6sm5773775ad.224.2025.05.01.22.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 22:35:38 -0700 (PDT)
Message-ID: <e41dd273-faa8-4b23-bbf6-dc7b0d512f08@gmail.com>
Date: Fri, 2 May 2025 11:05:29 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Collaborative community interview for Git's 20th anniversary
To: Elijah Newren <newren@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>,
 Markus Jansen <mja@jansen-preisler.de>, =?UTF-8?Q?Jakub_Nar=C4=99bski?=
 <jnareb@gmail.com>
References: <85ea4aa0-c595-4f0b-a2ac-d0113aca464a@gmail.com>
 <CABPp-BH2yH4iJ28Bo7Q=uryu68LLk7a0Tvb2SzAbAiHK8QpRug@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CABPp-BH2yH4iJ28Bo7Q=uryu68LLk7a0Tvb2SzAbAiHK8QpRug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luca, Lucas and Elijah,

Thank you very much for your interesting and detailed answers! Apologies 
for the delay in getting back to you on this. I've finally curated your 
answers into this month's draft. You can check the same here:

 
https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-122.md#community-interview

Kindly let me know in case of any corrections.

Thank you again for taking the time to give us your answers for this 
anniversary special edition :-)

Lucas,

> PS: can I share your questions in local Git communities?

I know its a bit too late to answer this. But feel free to do so if you 
still want to. We can possibly include interesting responses in the next 
edition :-)

--
Sivaraam for the Git Rev News team.
