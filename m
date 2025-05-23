Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3935976
	for <git@vger.kernel.org>; Fri, 23 May 2025 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748033032; cv=none; b=TeN1r68O7sOw5WdvFuhe199nHJpgiYEkbfWi4fG5hx4udc/u/fFtGG11UYNAhqaEhOGh00Xa7a70GLtOmXZZDJlhqMaudrJk/JM2zLCO2/lwIs/UoIIAlimcOR9Nqfs7KElja7A+B9s97LGYQMmN2OEqV+lTNLP7lzzWCgP+nto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748033032; c=relaxed/simple;
	bh=HDuYRso+slWw6xDQBED9NI3w5cE9Jg6eC8Qhct5orb8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AY2FvtMgvCQ9iV7OiJ6qZEpLJva/HQkZlqWSwgDq0yXHNJsuGEi6oKyxCdgt5v4Tw3N09A4ohcwbaKk5+Fe1PX2vMK3hF5UfjQRIrEkTz8NR6xpnoaS2SlC09dh5hMI9ziw0sp8Snw1oJUch242dsOorx9DkPKAGhIeq6mQH9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ablkxl5t; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ablkxl5t"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f8d96499e7so3787886d6.3
        for <git@vger.kernel.org>; Fri, 23 May 2025 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748033029; x=1748637829; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/cFSvn5v/M7mwNyLbfzk0zcEncYGChZIPLBVGce4+4=;
        b=Ablkxl5tzUHvJzcRRh95CSXlcFN0szaOA3rn/kk+bJbZQdDTMEoKSgPzxMWpWz+tnp
         Am7C1l2QgnVZvARtYXuLq2S02japH+zHdC9YsZrl/6hSjYSidZYpSHMec5ysp/IEsbuI
         SOYpTZ4kj/pzuimk4DfHp/+MVBUjk7GggMdUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748033029; x=1748637829;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/cFSvn5v/M7mwNyLbfzk0zcEncYGChZIPLBVGce4+4=;
        b=k1QLhdAmZPkRnsf8Smo7fY8Uo2dYW08ED7Cem44+idNRLvRwFWGwpVAtuf9bMUoNVR
         90cS1Nf9c9VUe1pLYnmneF8ExORcd/scwQ8PUQj5mx4g9qUj7rUoRPk2jVZOTpeYjFH1
         wcw2V9+hG/RUz4J1QNIwoiV945AUX22dFUNFWSUW5aOkBe2YcuZcCBIsRjF4h0n2fE6F
         ATefBt7lrnwn3GDRGYG6qfHUf1dT7bwDz6kduaBhwdbaDxjLtjdpws5mhJnVdI2B5upd
         ikx7r3ScvYBPq7QXoHz2UZIBOq0Xw/6soKz1igINvPjWIIlCUK0TH86omR9wiBvBm4uX
         y2bw==
X-Gm-Message-State: AOJu0Yz1YGQPX2od/DWm1WQ1yke3ykgaf2f8hBlhA6120XqLtrxjb6SV
	mXIYk98q+HH7uVQ7h8cU58AVp+iGXE+oqBRw7Kt/7Pc0aqYEEIA2MrVUrwsARlqkZQ==
X-Gm-Gg: ASbGnct95zrDO3NDwyCmU6VRGjRnBCPuM1ZRZxTFZqVMqtg8eJVTR9s/DyEaorPFU1E
	8wqhqLqtw6jUBRs2H/ovtfKabTjQRF46veQ71vFmg97Cvq9rXETbA84UrneXl2cwttbvY1dM7SG
	wm/haYzA7R9zwxQ4Smw01Lw+E+DOPnv5Q8Es+iyqx+U1JRRJ5y0eRMOiQKdXT9op1yiqtNLUpuk
	Za9Kq1Ffr1goo93rX/FjkY5yx2/tKq9eJHywFnBG7Ez262eVyWWcqpRFBkissY9tQUKl4mS6EDR
	+kQM5E9MSx2fqMGgL0FYB3/gh9NxvNT4PH9mk9Duqn7d1cAHbQOPP5HN0UxOqcpG+MZrF5qdUoN
	N4C5qoRmQ06/10beNUZFMQAv2omAbBPYq59j2NdA=
X-Google-Smtp-Source: AGHT+IEh0cbFsvA6C+a5fOUZZCvN5FH6DWKk7L5/lzHXZMKZgyuZNqEjcjtLaXj1k7yZ1ghqriEdGQ==
X-Received: by 2002:a05:6214:5198:b0:6e8:f470:2b11 with SMTP id 6a1803df08f44-6fa9d2ae87dmr15373556d6.23.1748033029461;
        Fri, 23 May 2025 13:43:49 -0700 (PDT)
Received: from [2600:4040:9ce0:6400:e585:dc50:f5e1:64e7] ([2600:4040:9ce0:6400:e585:dc50:f5e1:64e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b0883f2esm120956346d6.25.2025.05.23.13.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 13:43:49 -0700 (PDT)
Date: Fri, 23 May 2025 16:43:40 -0400 (EDT)
From: Mark Mentovai <mark@chromium.org>
To: Eric Sunshine <sunshine@sunshineco.com>
cc: Git Development <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>, 
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7900: use pwd -P in macOS maintenance test
In-Reply-To: <CAPig+cRpS=t-wNLxdV_WoKF0Wzy-S1oLUEyS18S9r-4OBQ87VQ@mail.gmail.com>
Message-ID: <88e8231f-7c08-652d-f734-22c4632aa728@chromium.org>
References: <20250523193722.68344-1-mark@chromium.org> <CAPig+cRpS=t-wNLxdV_WoKF0Wzy-S1oLUEyS18S9r-4OBQ87VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Eric Sunshine wrote:
> However, have you tested this on Windows?

Yes, via the CI: 
https://github.com/markmentovai/git/actions/runs/15217563313.

> I ask because, despite the
> test's name, this and most of the tests in this script, are actually
> run on all platforms, and because `pwd` is overridden by a shell
> function for MinGW on Windows:
>
>    # t/test-lib.sh
>    ...
>    # git sees Windows-style pwd
>    pwd () {
>        builtin pwd -W
>    }

That MinGW fallback pwd ignores arguments, so any pwd in a test regardless 
of whether it's specified as pwd or pwd -P will result in an underlying 
pwd -W. The t7900 test's behavior should not change as a result of this 
patch. If it's succeeding in some MinGW environment before this patch, 
it'll continue to succeed after.

> My quick testing suggests that this patch's change might be problematic:
>
>    # on Windows
>    $ pwd
>    /home/me
>    $ pwd -W
>    C:/msys64/home/me
>    $ pwd -P
>    /home/me
>    $ pwd -W -P
>    /home/me
>
> FOOTNOTES
>
> [*]: In the long run, a better fix would probably be for the tests to
> sanitize the output of the Git command, replacing (via `sed`) the
> actual emitted path with some placeholder, such as "%HOME%" or
> something, and then have the tests look for (`grep` or whatnot)
> needles using that literal placeholder rather than trying to perfectly
> match the path emitted by Git. This approach makes sense since these
> tests are about overall functionality of git-maintenance, not about
> the specific path in which the person happens to be running the tests.

The specific front of the path is not important, but the tail should be as 
expected, and I suspect that it remains much less fragile and complex to 
perform this equality comparison than it would be to try to reason about 
the path's inner components.

The existing print-args in this test could be modified as you propose, but 
the changes would also need to spill into the "start and stop when several 
schedulers are available" test later in the same file. That seems more 
invasive and produces less clear test code than just calculating a path 
expectation in line with what git maintenance uses in the first place.
