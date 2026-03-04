Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95253390C88
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622190; cv=none; b=KNmhAd09RPZxREQ3iJaUoUq7pmAQUkIjxnwFojkbygUYazA7tAWIdD8wAWrFmcT5wRE9div/RTX4AiIYTlPkx5/3ULeX6dWEAnL0gZOq2VuZaSNaqw2aXIjz923JZB5N5K1zT0XuUb/PdjTDmoEbhW1RQkJZP1QIdM1oZP+xDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622190; c=relaxed/simple;
	bh=eDsEMIO7wUNPhW39WcjiNlX/OXl1AHU1gamFcO1x3WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYWqS8hJNyGaywhQ5Xwg0AHjWALQXq4oyggDH3HkR1OtUuXEWnPjXUnIvs+XoFv2QiDGGSfOot/igr1m3nznIXW1bunxeXXjGbaKdd/E6DMyl73BZt13PjM1nnHHUFav4V6eAgAsGjoXYZfnKpjrfI09QPOTHrwV8cnartTwtQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJpjm3zc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJpjm3zc"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8297bc55c0bso15932b3a.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 03:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772622189; x=1773226989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wwsMzi/UHvz3xNgWPPumbs5B/awmuiWZVjimoz7okg=;
        b=ZJpjm3zcgfNxrA5G27xufxjhCDJTkPF+CNNX+Mo/IFNGJOtkV8arDYSNyID9SpaE+I
         UhlaylEzgaszZUieDtbui67RVE5LwmV4Ghw7DvXMAEpatwKR1GolmV4FV46ZjrMghMjI
         lUj6MPuoBBpM9EVMej/WMhN+SiY9Ty3rdJZ5k/fkZ6+cA7SWrtsujoAuRAIEECdBHI6y
         bmZSE3PWr/4XXwHw8zrtwke7vDhLiTBffFhcwkFm6Di1wWW/zpwc6U55+sYWJKcvfo6q
         rKHhcHpxsklDSn7FJM0NSsGHe+FD5McFzsVC9ybbRDdb8USc/pLwt5Melo6BSOcJQRkD
         y/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772622189; x=1773226989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wwsMzi/UHvz3xNgWPPumbs5B/awmuiWZVjimoz7okg=;
        b=xPDGpeW4hxiFFff0ZrKPw11045a7fBhpkY9U4ij4e3mvgx59doPFxock5IAXINfxal
         a5nwuLz+Tjvox1pS6XtODFWp9caNkkHeZRa0N2bY2mubeJq2Fg19NeGvPFLrRn8ZS1Mf
         8suP1kGiE5K43dCbmf8VugPml1SYZWqxP1EsUuJNmJOjHk2TqICKkFeuyx/RWTAir12T
         cAeVzGv6BgStu8t7IBDLxj0o5NlpBmflIT2ruouZpHsZqOg8LOqbwgxt+FI+rvUMb0p5
         euKbVMCaRu6O7svlDjF5IKAKHCo1yd/OmhNXcBxkYoBuDA9YyJhrRH9QVP6HqXCm6cJu
         UxNg==
X-Gm-Message-State: AOJu0YwlJlNRicXl2lugI1sXXZfpEEOKVUzI4gXmgkGbF0gcPuqX2MbW
	ZbjzMYuCSvRU4BK0AIDyiVuqNC15JX8nnYDIO6EbVlVhgeXNGt4hnUQr
X-Gm-Gg: ATEYQzxELDS7Z8rGQhHyRwojTFogG1BzTedWOMzlOQkC3P9hgSDTHEAB1SP4YlW8VBX
	XmuAYuvCXibg/pMZ7/Qub64mDghmtWox8K2L2yYkiV+3pHm3H3A4/4kDKuT8qHQPsE5mTjZw+mg
	rePACORhdTZdjWoeOtVh2PPHgTzaujt0Wd020s2XNyqe4OIsRe0ZW+O99EVYWE+heRG+9y/RkAH
	OisqLKM/dgSdd/R+S0PxVYg1ZuaStT/6xYfVRqvcnWZ/Xf9TgizK/GGftAH3c7HAsTQzxvwLiV6
	rUAtwX+fnefRRTwWZdtC+7vzTiwkkjLO115M/Z2G9Vo4P1ZFEqke3XciXZhO0FG5okxt1Chl6P5
	WyggWcDzN38N9ZeF0QcysX/K3+Z007fOOpiLejFmk3Eacb+ba0N2+ry8Q4FmUiae4OvHlFMLC1C
	hB8Wq9q2OhjZrU9/cV6vqfi2uN+RHWMqbUBFVblIoc8DBkXL9Zyzo63O/AfcmjbcxH9wPifLJx/
	IZsvrH9wuF4
X-Received: by 2002:a05:6a00:950a:b0:823:26e8:aa41 with SMTP id d2e1a72fcca58-8297290ef5dmr1166702b3a.2.1772622188773;
        Wed, 04 Mar 2026 03:03:08 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82974e75a4csm1157917b3a.30.2026.03.04.03.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 03:03:08 -0800 (PST)
Message-ID: <99c6a437-3fc3-4d9a-9465-4c47a9777776@gmail.com>
Date: Wed, 4 Mar 2026 19:03:05 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20260222102928.377519-1-a3205153416@gmail.com>
 <20260223074410.917523-1-a3205153416@gmail.com> <xmqqpl5rumy0.fsf@gitster.g>
 <xmqqjyvu42pw.fsf@gitster.g> <460f00d5-97b4-4a6c-be45-6f60a17cd33e@gmail.com>
 <xmqqo6l49mrt.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqo6l49mrt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio and Phillip,

Thanks for the detailed reply!

After reading through your discussion, I believe the most crucial point is:

> "We were given an invalid GIT_DIR, we are not doing
> discovery, hence we are operating without a repository"

If I understand correctly, the expected behavior should be: when a user 
explicitly passes 'GIT_DIR=/dev/null git diff', Git should no longer 
need to "search" or "guess" anything. Instead, if it's a trash file (or 
something similar) rather a repository, Git should simply act as if no 
repository exists. Is that correct?

So what I'm doing next is:

> All calls to read_gitfile_gently(path, NULL) need to be
> audited and then we need to decide which ones to leave lenient, and
> which ones are OK to tighten together with the call used during the
> repository discovery.

Will be working on it in the next few days.

Regards,

Yuchen
