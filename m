Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B63164CF
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502791; cv=none; b=piGqQK7WPVaY6KH4OhyoZj9J6fic+w/nvFGjcCTn2XuVIFxn67QNwz1FzedXP6oqd9CpZ5zq+yZ3PTR1ARVxFKTCvVc6L8DKm62TKc6W4Ci/gBqhPAmFyMnSj8qWa4XGJ5lbnOydlcbGNf27acmkViR7gQZLV4K8ULL+bakyQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502791; c=relaxed/simple;
	bh=As8fFFwJENPXQlP3XRaMPSkYSOPKJz9uhxa0hEkLD4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKuXwqZovL3fn/8twCO4Nd7DEUzV/gb1lockloSJAWJReqp3bv2s7gwEajJJyABaY3xZFZb7dRqSbUdTDGvqzy82tNbYSmlj/zKdy0w+jPsUnZmlqQXaMGnFT3Bw4NcvpFk6In6sPOnQmVw7JZIIPwWTpoZ+Gfh8rGV1xiKmbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkvBrsVZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkvBrsVZ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77459bc5d18so2417023b3a.2
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757502789; x=1758107589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USsdsJ3MuDlX3XjNNCmya8f1wCfeZV5lUeU+lQNRNtk=;
        b=nkvBrsVZDBZ0WpL0r4gcTnW1LOsTkDCVoxUJbMxZQTKM6G5ve4gMB+6qc8NcOnS5Gf
         /gOhOV86d2lZUCTkxoG0lCFaSq8iRWeDWuAznzqept7uY24koCf64b377Ff7WFXCnuwP
         dDqVbTGEug2xaXEOKh0hEMlaJp3xHslSV7xYYuaxuupNiwse/zUfZ0g5G+Nict1z3L+H
         izF7ImmMM9YB5HqyTz1mrsTmDQWiqFhylyx3qc2epCalMc4EnBYz6z9byR7toapBnAT6
         4kIm31nR161TG/gRihbGwUFKfB4XJms/u1OED6oAnwadj/SV1Pwbag8QQDRcuidk5zTl
         842w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757502789; x=1758107589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USsdsJ3MuDlX3XjNNCmya8f1wCfeZV5lUeU+lQNRNtk=;
        b=vjVjyNZg4zIyyPM7xYwKcK8fVyz7kNcqw/r+9vg4tJx8sOTkGRCd8ZHl07/DjaPhSh
         44o+23sqdWgjbjt8Y9nfnp3WVOrV4XjBQsjyY4EGmpyYfsX5A5ys6RTNwsksqCmJxych
         n8wLw9YtNCQ83v90IKobhWjsBm2POOkz2a7CcKfsdJ9J3zYu3enGNZl/RVyQzhvgF7Ls
         klzvcydhq4MVjTUAWPT56RNfTZP33VYOXEjikAVz4BwGtc9llmLcOvImT0M9+VBuWYdX
         oPPT0/T4zmjkEFANIdoCCB0NQZ7cB8bR+ihvinMk8u+Xtd91bqxrvTejzl9bpBxPNsiK
         K7ew==
X-Gm-Message-State: AOJu0YwR0sLc2djSBW73d0XYEch72gcrb1M6svxIWKP1HrMq+J1aR/YG
	NqPTN4WLzYvBMeGxUvfecATIpUA/FH22rYnjg92h6QLNJVr1f25jBcyz
X-Gm-Gg: ASbGnctyYxlIrbALa/puIeIFRG9/5/Qx6YD6CkSQhXlC4vs+HQOAkGttokX6ZZU4A2T
	eczKI6T8jRh6RTp+I9ygYhGBdfQ1mjLcNJ9s5x0ZJiyVjhf6YzfQs+1eF2+IEXAWnc45Aw+0cD8
	wvlfzRmVtyfy8xChG4xXOsYcKTtAXO5VswxGeGe8toRXMyYoiSJowJjhUN8Rxg24DStFks4irE3
	UdEHJ0zD6YD5OGpQ63zXPV+1R6S2e/Z8bjWWLmxzoS1+2Edr4Pbh0SgrUnFyRaD+5pDWZE4XqV6
	1zj2F6RBI65HEihrgsKWeZ+p45O0Yjahy5vmphCyyZwhn/03LvI2jE2DA6+MPyOnFhXN/M8K6Z2
	C1lEjTXPQY4Obwj2rl+7y4pmw4Dxuys9Dtgijbuh9WrKk
X-Google-Smtp-Source: AGHT+IHBZf+I4VispvrmpUHlBRnF51ZjtpP44KSChcWevPIHfrhvdGM4uUXxrtTL2GU/RAQFdbSCiQ==
X-Received: by 2002:a05:6a20:1594:b0:24b:c7d9:88e4 with SMTP id adf61e73a8af0-2534557a964mr22064612637.42.1757502788976;
        Wed, 10 Sep 2025 04:13:08 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6bcaffsm2296229a12.45.2025.09.10.04.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:13:08 -0700 (PDT)
Message-ID: <dca4e74e-26ae-401d-bac9-f8b6f13296ef@gmail.com>
Date: Wed, 10 Sep 2025 18:13:05 +0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Shallow clone support in v3.0 and beyond?
To: Patrick Steinhardt <ps@pks.im>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Jeff King <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>, Askar Safin <safinaskar@zohomail.com>
References: <aKzy6naLtdeq7Tgn@archie.me> <aMFcH2nfKO-DZcwm@pks.im>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <aMFcH2nfKO-DZcwm@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/25 18:08, Patrick Steinhardt wrote:
> Hi,
> 
> On Tue, Aug 26, 2025 at 06:34:02AM +0700, Bagas Sanjaya wrote:
>> Hi,
>>
>> Askar Safin <safinaskar@zohomail.com> posted on the ML about his complaints
>> regarding grafts removal in v3.0+ (see [1] for the full thread). He also
>> briefly mentioned future of shallow clones (aka git clone --depth=1).
>>
>> The question is: If grafts support is removed, then how can shallow clones
>> be implemented in terms of git-replace(1)? What about its implementation
>> details? How about unshallowing (git fetch --unshallow)?
>>
>> Thanks.
>>
>> [1]: https://lore.kernel.org/git/198c29e9058.119e3a5c065010.5888624019176274871@zohomail.com/T/#t
> 
> I think the BreakingChanges document could use a revamp in that regard.
> The mechanism used to implement shallow clones is of course _not_ going
> away, and the internal mechanism to facilitate this will go away.
> 
> So the intention really only to remove ".git/info/grafts" as a
> user-visible mechanism. Users should exclusively use git-replace(1).

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara
