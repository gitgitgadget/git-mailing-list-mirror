Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D821771A
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694041; cv=none; b=g9IWhZCAsJ6+uOBSTzH/MEpTooMRLVkgPBHrZ4HMOfw4reA690DU5f5DPTomV1HDY0+LPjZSWl/iKraTJHfob/F5fqJRIYhq3MdhrrdQw5OW34AyFmXKC+wKANdzMFuFzvJqTeN4Ij+XygDvuaQtnDl0QXCXWqlFND1ehKSWI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694041; c=relaxed/simple;
	bh=g6C83kUbzn5EVqT5ikOKL+0qIOiCh1gVr+/GTyONCBs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IeYvv2EM8N7PfUuDU5RAwGbEFkZStzhANWKbxvgaRXIWiznGIKdX98l13N14XtZgfeoI5TEGfPULCPGi0oU/DKmHG+6nR1PG4NRUsRPNdjpzWsxerPWgZygcI582sshywKRly8uFbgO0SDgg/Ro2Bib0cFeNHKEPW9mAk0ZLqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDPr8g4U; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDPr8g4U"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2161eb94cceso75195795ad.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694039; x=1739298839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZLmJNZK95ZDyyCPNRyiAv5pIjFdZXcGgoOUvG3C9Jg0=;
        b=HDPr8g4UlsHSS+LSAxUy49vnhnaCWd71B6vnEOM1sKXRC6bJza6ywLPFTTEHrfiO6X
         47TLC2tFSB//KKVhu42BGIWw5f/N+zBCa5WFnlhK4a21Iwxbl19MHi9D5ETWeiaq1rPC
         gX7zkMoLQ+m03u5big7APJWrgBiodI20n58eTfjriiOrvSjkpMyq6zKLYbmiMKyJPD9I
         86ckT1cXca1Eo+j9tJA3shyjKACKDq+jNlHKkk4I1RHf5w5QXNDg3YYSViInstlf1/qN
         KvNDBpmvhDxhE/eSLsqtL8zWJtOVVIybBFc62XmizyTAExktDSlAPxgMICpF04ehqhZc
         lX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694039; x=1739298839;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLmJNZK95ZDyyCPNRyiAv5pIjFdZXcGgoOUvG3C9Jg0=;
        b=YiblQULZlVoKnVVB6Qbw7z48Cw5lgucRUeCw5bhI8AYOJZeoOnoB7I4B/BRDRWrGAu
         rs/YptSbLko203Ga92XGcHJUlN708fGyvoYuG6D97zC2PW6nVayu+PsUxZkgWH5tJvbM
         haiBoaen0XhdnJ57D12c23sfb6ib5T4/KHuqZC8V3Kq+BX9ipaVjHG400xdVXYnge6YG
         tEQejOjgYBXghHSgEPym4k5Vr38npePSwMgoq/xSTXs2TnQ4bRef1IwW64HB/pMTAZVB
         O2Qi1qVtIaviqwUr1fOtm6f6zWOhvwi6yRqyV4ik4uwx1+jOddSxF7OWR0xjGfnAOHuG
         QwxQ==
X-Gm-Message-State: AOJu0Yz1VAlsyqynyLtpMVmVUoMTFDOYaa1S+vz+4hQZu1t4A105iq1j
	m0AVBjSynUHE1aGM5Ta3/PRdCc9qY9bjMmPqr2WHay7ptGvS6hLH
X-Gm-Gg: ASbGnctnxrBkrfByamS6falyxK+1xrZoZYEFiq0jDkZ0VbM2Revx9SK/ErEoTFuSV4V
	DE8iMj/9Vlu1UdINybFrL0oIs7ga9biCgJw+ghpERMYbrGXl0enPbhww/koKKrhn66w/pLgX0Sc
	h+Ddr5EwM6XluezytCsEMbz1g0ZYY04rozmPpD1CD9WEhhIuMFnW5ELE4VETlJj7wkO1t3pJt48
	SV7b+dOfM8/4Y3c9keB5Ej5smV18y3ofyT+5zMfhnrEGWBSzMKl5eYbsYM1fQM2ApZP1TZryOAd
	PUOxl1sbScEFrQBhQHCLlRXT
X-Google-Smtp-Source: AGHT+IErYCevJAbeKvuCgv96c4mfO1n88C+hpISoogQ5GBR2EVao5MgKUeqpR0EhRDujHiDF5CqOxA==
X-Received: by 2002:a05:6a00:4642:b0:725:f1b1:cbc5 with SMTP id d2e1a72fcca58-72fd0bc26c1mr47695788b3a.3.1738694038622;
        Tue, 04 Feb 2025 10:33:58 -0800 (PST)
Received: from [192.168.0.7] ([106.51.24.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631c039sm10945375b3a.25.2025.02.04.10.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:33:58 -0800 (PST)
Message-ID: <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
Date: Wed, 5 Feb 2025 00:03:34 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2025
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Patrick Steinhardt <ps@pks.im>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
Content-Language: en-US
In-Reply-To: <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick, Karthik, Jialuo and all,

On 02/02/25 17:22, Kaartic Sivaraam wrote:
> 
> Gentle reminder that the ideas list needs completion. 

Thank you for your responses! The updated assignment is as
follows:

- Consolidate ref-related functionality into git-refs

   Possible mentors:
   * Patrick Steinhardt
   * Jialuo She

- Refactoring in order to reduce Git's global state

   Possible mentors:
   * Patrick Steinhardt
   * Karthik Nayak
   * Jialuo She

- Machine-Readable Repository Information Query Tool

   Possible mentors:
   * Patrick Steinhardt
   * Karthik Nayak

- Implement support for reftables in "dumb" HTTP transport

   Possible mentors:
   * Patrick Steinhardt
   * Karthik Nayak

Note that I haven't assigned any mentors / co-mentors for each project. 
I suppose we could assign that based on the applications we receive and 
the ideas that we end up selecting.

Based on Christian's inputs, we should be able to distribute
projects among mentors well.

--
Sivaraam
