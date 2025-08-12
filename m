Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98822EE607
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012396; cv=none; b=j8waaUkcEQHK4lj3gnnl3xHdeZrLh5eM8tlC5l9gfCJoFE1jXyjL+93jA0vNwvvPNOfayn9d+cyOwtJEa5WdJ74OVPquE8OTw9WI84ydvrH/ddqe2mpQeJL9dTqGehKfakmIXiOdLm+lLtGhMptGDMf5UJXlaXpYrLu+y9BMqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012396; c=relaxed/simple;
	bh=Y/lxjO9LRhn36uGbP2U4ony2TnOVv5ECxKoib7hMY9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Eu0uvC8Cj3tqX9x0uf2Qjo3MrYPRu5YVUzp2r2nWlgs2pmUbgWOonNZF5et/07OP1CdZd1U1KiH2lUU5qGkVhLu7KrclKApGto650hKj1UhW9Snm29lkRWKWg1TrlrjDX7flOnZ/w+9ZXOEO6WQWpMoZor1y7x+FlRJCoNeXiTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5rAnWa/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5rAnWa/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bd041c431so4994977b3a.2
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755012394; x=1755617194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6jeThsBDvjP5JHCh5fPWy1p5ClOh2WxfhCrYUzUGIqQ=;
        b=C5rAnWa/IVdo7bb3RUHerl5Ennm84hux8xzSUaqPkEVePz49ghxjBp2UT5VllFqKH/
         qtSA3eG6cPAhK/Cnuh6HvtXDa4iK9UGKAsoFd8JQkuXWren58Z6EGJeQytSv6EEoxDwa
         gNAjnYYHZ/VlBwql/LlPlwv9QB/NSqDZPUvgBG6phXJ1Tf2tiDzr03nsCkgCxkqGw7ky
         oeJY1Ow5l67WiBO0I0zrplX/hHLEGfDohhVyn3rvZO3q4wZ4wT5IHzCuSAS38XfNN3JC
         Okwh+dHK1zhqUkfAShB0yQPLPCSJJqYwxtv0bxtEJb5Gcoz/lwZoYiET5XijKVYdWe6k
         9+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755012394; x=1755617194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jeThsBDvjP5JHCh5fPWy1p5ClOh2WxfhCrYUzUGIqQ=;
        b=nJ99jKEzZcBURFd7mGY8k2wT7FrmdUuprV1czP1vIERToXi24sW5gEOuq0//u+5DoO
         NTaxWqgXhbOutHDTuX8GWNgMAZ9mDMAbusz1pFtz3iWhZ73Ol74WJvVMuxue3LE24olB
         GwgsMl3SE1z9sXMcQeTBqP9ghxZVxHotreJ21Olkabz688890fugmkSfLtoVyGyizWv0
         fJsFMmVGnzHhyQxXljI0oCAlEu45DsG2z/ryPq5SWLQKHGGKyd/LQE63vJXRRp0JHQHd
         aZjKs/2hdz6ufFi/LW+sdaXCQXmbV6xrTyO78/XjBJ9JC51IwPmhslYfTDhyCQLKC/du
         9dBA==
X-Forwarded-Encrypted: i=1; AJvYcCVrWbvIqt/SOvlka/95aISQMvKcLfUM3OInNNY0XoNrl/vZf/9t2Ugc/7TiqvN8WAQNATk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEe6sFFIPEp03Pgn6FtBT9VYZcqD9aI0rT0K6Lp9voHiLhoJSY
	WlYh/qQOevyq4c6ECiM7uaUB1rnCQaiuI2EdulN3UmxcpNyqRZnuRgyc
X-Gm-Gg: ASbGncsOidg1JPVwizUbmu4tEbGpH1RAnSHznmPbay4k738Vk+yksxKZ/3SxX5Ztv9n
	O9MkgfYS+8/BdRW9nV/Quo2KgJxAG8us1bZ0vIPBka2TUx58Cb2fXKx3lqT2xkOlIsb6vSX4z35
	GV/O7OXk2aHTDxGcvuXRZSuGqJD5t/NPtaJLOGs7ipcsE7c1/JDZiBOae5HEqM1Q4hZvJ298Jz3
	1W9ubGFFIssqyVmDpq7l/9BvdS67AzVyOfZeHM4nsVs1WA+yZ0KqEiMzzsUFmw7Lelq3NfQFyvK
	mqcCtxD7PkRCRznL1ZZApNl35rXxu7lN1PfQGAj28DF26mt3mRDqp/YjFH3Y/NEd2mYe8EZIKaD
	4EqXtJsZefaoSdRdFT/Qer/gHbcnUfBDTxbVPacYsUX/3V1eRPu4Zgl1Hnw==
X-Google-Smtp-Source: AGHT+IFmNtGWmNMFEVwOjttJXyVLEdE8FJENUAZnhYqqvZVYd0+dJIp9FhtfINSTSkfZN2K4ZYJN6w==
X-Received: by 2002:a05:6a21:6da1:b0:23d:54bd:92e6 with SMTP id adf61e73a8af0-2409a97be24mr6279250637.29.1755012393921;
        Tue, 12 Aug 2025 08:26:33 -0700 (PDT)
Received: from [192.168.1.105] (23-93-88-48.fiber.dynamic.sonic.net. [23.93.88.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0391sm25095679a12.37.2025.08.12.08.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 08:26:33 -0700 (PDT)
Message-ID: <e463481d-b6a6-4928-86e1-63677f5a88b2@gmail.com>
Date: Tue, 12 Aug 2025 08:26:32 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] abbrev: allow extending beyond 20 chars to disambiguate
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Derrick Stolee <stolee@gmail.com>
References: <xmqqfrdx517b.fsf@gitster.g>
 <aJpd2MYMWgEoxQWi@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
In-Reply-To: <aJpd2MYMWgEoxQWi@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/11/25 2:17 PM, brian m. carlson wrote:

>> To see how many leading letters of a given full object name is
>> sufficiently unambiguous, the algorithm starts from a initial
>> length, guessed based on the estimated number of objects in the
>> repository, and see if another object that shares the prefix, and
>> keeps extending the abbreviation.  The loop stops at GIT_MAX_RAWSZ,
>> which is counted as the number of bytes, since 5b20ace6 (sha1_name:
>> unroll len loop in find_unique_abbrev_r(), 2017-10-08); before that
>> change, it extended up to GIT_MAX_HEXSZ, which is the correct limit
>> because the loop is adding one output letter per iteration.

I'm new to all this but the way I did it is much simpler.
What I did was to check all the files in the appropriate
object store directory (e.g. .git/objects/XX, where XX are
the first 2 letters of the object given on the command line.
If any of the filenames in that directory start with the
string given on the command line, minus the first 2 letters,
then that's a match. If more than one filename matches then
that's ambiguous.

What's wrong with this approach?

Jon

