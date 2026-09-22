Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C7486439
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088826; cv=none; b=ltMG0NF29xmLaCdjIv9aoogIHo5bsj9chiEOTqcZFiTyztxGIaA2sBHi5w8EWUfLnTooHaHCLpgwR/sGvGpQHY83vKF6LLeMl3+r/7JlyVk1NypHKXdNrNCwgD/VndPPUHZhAqypneOxA/Sy9liXepw+a69bInDKWOf1b1Csp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088826; c=relaxed/simple;
	bh=4H2UeenZKtzFqyPmmVUs4zl0/btKU/Sq6g4jU4uy1+s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JYOhzLjmfl1Hvw3daEi+VH6b5ht/YY2bXMcJ/VRICrt+NUJ+GlNLUJaPO01sS9TFNPjdUzWex8fSwHM6k8MRoy6ITMyMgYv17Uu7AyYDZ9As75TV77PQicEBS5pvRLH+YiGE6WmDN05z4/ZeD5RKiZ2dK2uMv6X8FhQ3ymRgisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxW8V924; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxW8V924"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so1250754a12.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790088823; x=1790693623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/RTfAVvBfqHbywHpPCwhK/vjcWkC77jHZVFYQO8evg8=;
        b=PxW8V924AO237lrIYZadwUDLO5Po5G+22ZTuj09jHirVzWGUMNlhicyASvMeYHck/h
         +VgihJS5dgHanEzo4jXzaIlRDl0HbwWj+6LaiTliitBPAqeHwB7iUAOpESE9RwEx2HQN
         X1BA9H4kmKLO3iXELK28nxdk5/6kxfvbq3EYMwqIaQihuJKYshSYTtCjAi5iTCCT9LxM
         ugqsnlThoPZtfvmZMrfCLeMr2PBZueGjCOVwsbnrvnE1ei1fQ5pHaAXZ29qJhTfJUwkl
         Sm4Tz1GWQXn5RWStoB5AV+d8sfG1FWuRrutB0i0kUjrpm80xNnug3I8CUvj9oHE/CN7D
         BlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790088823; x=1790693623;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RTfAVvBfqHbywHpPCwhK/vjcWkC77jHZVFYQO8evg8=;
        b=DN6sH3wz6/X4zgP78LTQVLnfdnPczgX2+p+ysX6dxBXl7NDyXE7bM2kwaMs7yZOBii
         ntQHUYClUeNGkYny8DYOx6v4oBywUifEnBeQP2T+F3GYgaFzIPyoZ8U8gNklTjt5+4/K
         QOrkcRPcI4W9AnrlSPcHJoPvO5K3i+1YAavN25fK4Ai0cQl0uVv1gpanjKQc5ckEA9Fm
         AgTjVPia3nzK3a6Bk3NokbPRYqZPuWEDYHQGbC/YkfKuKSwKvPrZQgMYPlALW1pTxE19
         y93t8VMhLmucREg/RbyzYQ/Srxa5mGO2qBhaMHS6t8qgU+vQojvVJ8jfdmYALtmBnjKA
         fqyA==
X-Forwarded-Encrypted: i=1; AKwUvBwSYlJ7A8F8tH2JOOWvETH/EEXOOIoN1b3PxqZafVQvRK9h27ivrqgKX9qPoODbySsp/JA=@vger.kernel.org
X-Gm-Message-State: AFuF++kXxowOt5RsIDCROMPzizicE7sZUcHJch7wjAJsF5C4ODvSJO+X
	eEPhBTRDluztJvT3qDj61iyNJPRZprp3POkgmPPhZ5aWEwDc/GJ1BOYj
X-Gm-Gg: AYBFou0XR9JBo1KFYoevkPZ2LvqbN5f3AwkU2nc+qlwmYAxLK1tiSf+7GR0e+RXRzgo
	rVq4i95hZmFcwM26k8FIucTZ8RQsss+JUWdQ08p8q6z0VafKKaoqpaU5i2FYcciPQGIVd28dGla
	yBS6UgjeElqRx2pdILkeG+MTRu74Utau9m0d0gIumELtHIQVHRDRBn4ZxI2+97pqr/UdePEVZP+
	Qr5VB2sV7qHod5FNM1/TpM47Huw6PKtMfbO/iuy0kSCLQa1UIJGbF29CBCc79zerMSR0Ys+7hPy
	mHmsSMqzrxfMo47AUHS1s/MHE/pZiSiaOVs4fPxDET8CVfkY0g5JG8s8NYYR25bvaXoLDBKF0YX
	VYOWJXfnRELE1nAahVnea+tnhbMIp3XGa9I+6wH3ebbZYaf4nX8Ta5N87+ynY+MnweyBfiySgpe
	Neaj9Km7RATgUnEDa3u9IXO2r/+91fZU2ryZeBwz1Fu5Lx2S14TaSqKoqUVcOrNgEl/wswge6fl
	e2TjWF5IH1e6sJr8sICxfKChWqD/j+qdMXkNCVWty1lOwBSpYqyPg==
X-Received: by 2002:a05:6402:332:b0:6a9:a0ca:ea5c with SMTP id 4fb4d7f45d1cf-6aa9feb3b0amr2077295a12.5.1790088822476;
        Tue, 22 Sep 2026 07:53:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa44f9a77sm1255824a12.17.2026.09.22.07.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 07:53:41 -0700 (PDT)
Message-ID: <15c85d2d-4fb0-427d-b52e-8e4dd958dcb9@gmail.com>
Date: Tue, 22 Sep 2026 15:53:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com>
 <CAHwyqnWbbCK40qAU1vhCFmN86J-dCY3tv_N_nBYgK2Bxf3o1fg@mail.gmail.com>
 <CAHwyqnUVkVUjKCiN7YT3tkvHEVCQwb3jDGM0OTojPxptFKrsLQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnUVkVUjKCiN7YT3tkvHEVCQwb3jDGM0OTojPxptFKrsLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/09/2026 14:00, Harald Nordgren wrote:
>>> If it is the former then we should think
>>> how we can improve the behavior of "git remote add" in a sparse
>>> repository to prevent it adding a wildcard fetch refspec and instead
>>> setup the new remote to fetch only the branch(es) we're interested in.
>>
>> I didn't even consider that, that sounds like an interesting idea!
> 
> Would you suggest we do that instead of this, or in addition to this
> fix?

I'd say instead - if we can fix "git remote add" then the problem 
shouldn't arise in the first place which is better than having an opt-in 
config option that most users are probably unaware of.

Thanks

Phillip

> Seems maybe we only need the fix on "git remote add".
> 
> 
> 
> 
> Harald

