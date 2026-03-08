Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337BB640
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772980968; cv=none; b=MHVytfmWBe2bJ4/6gh0pzIe0rbvADnRQVEkHuSt0hjGVHKGovBFZtkgCtnNsAvFevIeE0b/1G4hM8eiqXPWi6ZdDu4/9cptB5mPaAu1+PhFWI/utHy5MCNIPBJw2OYZmXQstDfDBFY2vmkkiPEIDNRnUhtOLSpHqILaLJfKDAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772980968; c=relaxed/simple;
	bh=QWayofmct6f+8oEPu8vtXNVnpH4jm4JHSJLGvV8ty80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHqAGwJfxwhEQGBPQdxKQBdKVwP8PlcRd8W2jo7pZpB+qQuxN+WCNDsaOthyW5HOO9xFActcF9Ul9vrhoZgL8dFxLv7jA6zjRBruZOCsAXczVF/1RZEn2qNBmmbVi7Y1BoeKaTWMQh0BVmk3N9uc6S0aYGXso0wPCZgHvaIDguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdQr7SyR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdQr7SyR"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c738fcba660so566761a12.3
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772980967; x=1773585767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02V2Fj3V+tu7C06/AMo1l1d0iTDs9lpoVSMxvHbOkmc=;
        b=fdQr7SyROw2FqbfpTzAgJ7p28Xl4IDuA5BmSjQMgRVyawAC0zDBHslJ17Olw45AOqi
         VHbmN/rmQgiWxP8lHYAYUtYouDyaIFxdhoNSgo0Ji4naXVmp4dzfK8ggrqqdqqekmzKl
         cKJvx0aBK9ltPte2NQDo3vp6VPkZYkDKCbNzLAv0OJ0AZMrDOeRVAiYyX1roZK3jRkV0
         hjXS7KSC5rf4F4RIwpJy6X/+auSdUQtm65127fBtZJrX2QxI3S1gAhFoTsXQlxJFejZo
         r9UXpmk2ly4Bp8HtYaRl8tbjdBaGdnj4i8Bb2ADkPF93VLYlLAAEk4rS33t8QvD0OVLA
         C87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772980967; x=1773585767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02V2Fj3V+tu7C06/AMo1l1d0iTDs9lpoVSMxvHbOkmc=;
        b=MsRotlFNs40Iuy1VNdFdEyShfuMd6XVcmraeNdXYsThoqohEO7EQAWr4tFSa8OtzHm
         CW6oBstiDdt5s5qaSU7OTrtL8Qd4k8ldmI+ZfiZ/JS96gfvqzNgP6B219DDD8GPaYiV2
         7a3fiH/WuBzG34BJzN+E9u900/ULZMTMZ6Jy84Ve13SUiIz8HSfTLzev4yeEMihQEqAS
         lX40gQ0dsaVhU+HMnEOt5I2supq5/iCxJe31nG/ayVIJxfOA6b68d+wB20qpUgiFqqaR
         aYcr3W70TbomkbLFkYjCqMaclbDT/BNUoVF8A1t/w/lEHSMNHsAy+aqG+u0lCIkgQwAf
         +xpw==
X-Gm-Message-State: AOJu0Yx9bVRplqtZo215k3eeGrFOsBbm4D5I1A8SaZtfnek+BXqFSO5r
	CkIsUpYPzQAitn8Xyx4lmuFWNj0owLkdk5yeXA93j/cHTfi25uckWE6servW/CrM
X-Gm-Gg: ATEYQzwavKSKATDcwr/FreDXAgfrB6jGS/avyGDUilgyMH8wsrfrNb0LeDEuaDwZTaZ
	qDwdQ6uPJBNuAfhonc4B3aIn/SBIqKY8m0z91mebejBcD/4VpuoCESMC2GFlNYabmSXQyKpRbWc
	k2twRhJMrfOsA39cocFtBJeeAZ1IJixrtW+F9fIJnk6smuTW7VBHOwa8exlxjvUKM9e76gWfIbc
	xduh9OaJvVGKP1zlsCvVIX8idpiJ8ycgKIfplTLFHF08QyK4meuIOvb3055dnfEJ+mjXBuAPSVG
	CdiAnDKbpfpHEteZpZtu4c6tWtw9W9OnCcQGIThDtOdLsGN08cdxn2I6T0l+5bn/XNOyQqOOWwp
	FKC0HCK4le2fn4sU7moSZdwrDTAqfWOTuonN0ycwMgyJimd34oOnOW6LWXvPElQChMIA4wqfaPU
	U91o/vgWbGeXHwnMaV3uWU/oulIF01WwZ8QrvP7mPgzrL5dEXqWfm80zo7FmzcXZ6GWsZLjySLp
	Kqz2BSCrweM
X-Received: by 2002:a05:6a20:a103:b0:398:84d9:64ef with SMTP id adf61e73a8af0-39884d973cemr1116471637.2.1772980966603;
        Sun, 08 Mar 2026 07:42:46 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0c7427sm6838201a12.9.2026.03.08.07.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 07:42:46 -0700 (PDT)
Message-ID: <1a1ed5c6-8843-4bd5-9f57-187ef39497c3@gmail.com>
Date: Sun, 8 Mar 2026 22:42:43 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] patch-ids: achieve const correctness in patch_id_neq()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20260308043131.77782-1-a3205153416@gmail.com>
 <xmqqseaasuph.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqseaasuph.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

On 3/8/26 14:26, Junio C Hamano wrote:

> The fact that `patch_id_neq` receives `const struct hashmap_entry *`
> parameters--which is a requirement of the `hashmap` API--is what is
> clashing with our lazy initialization here. The original code
> handled this by casting to a non-const `struct patch_id *` right at
> the beginning (via `container_of`). While this also "drops" the
> constness, the original is at least more honest about the fact that
> `a` and `b` will be modified.

Oops, This is something I hadn't considered before. I admit I didn't 
think things through carefully enough.

So, we actually find ourselves in this dilemma:

  - The Hashmap API specification mandates that input parameters should 
be const *in principle*.

  - The lazy loading mechanism requires us to write the results into 
memory; otherwise, there will be significant performance loss.

Am I correct?

I find that maintaining the current approach seems the most reasonable 
option. Computing all patch ids before putting objects into the hashmap 
appears to be a move that affects everything else and is not worth the 
effort. On the contrary, slightly breaking the Hashmap API conventions 
seems to be a more *cost-effective* approach...

Or perhaps it would be more reasonable to slightly modify this NEEDSWORK 
flag here?

Will send the next patch shortly.

> If we truly wanted to achieve const-correctness here, we would
> likely need to avoid lazy initialization within the comparison
> function altogether, pre-calculating the full patch ID before it's
> needed for comparison. The NEEDSWORK comment should remain until a
> more fundamental solution is found, or if we should just admit that
> the current lazy evaluation pattern is what we want and document
> that (i.e., add a comment to justify why we strip away the constness
> here). As it stands, this patch doesn't "ensure" const correctness;
> it just masks the violation with an explicit cast at the location
> the pointer is used.

Regards,

Yuchen
