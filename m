Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFCC32143D
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210841; cv=none; b=i/tQZ68Suby78Fe0N077zCan6UYT7Mej53kgfVTC3v3DAGx2ymSkb0S6jYiyEeDWYEcyxLO7pRxJn5xKL2vPNI09NW4nYYAWngG4ox+Bgk8dGtCVT2so8RxUQfSxaF8BdKTKdQs++QyZu0U2UbiePFHb32dDUrFT/Vvd7zhyBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210841; c=relaxed/simple;
	bh=sjR3cOrmsdbx/57vi4Q5+qFoWVVLpJq0yG4DcR+lAPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW3tvm0JkqLbRwyjUzShjvESoxO7sshqhBtTnWOizpKR+uHzt9hcgR9S+ZD86cAS+5XcuYPuCmkB9xfrgh0DQNLi2KLCk8CUpFSbFt1YhOMJfIz2g1VH1Ub+rDiUDJ7dPAWslD6YPGDBk3puOIcKifRaanXG74/Hf/nPIxqIjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBCOg0RR; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBCOg0RR"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70d9a65c371so37286876d6.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210838; x=1756815638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8/yMV+d4ox9uMZOSJDYsVGKRP9HYQM8YtUh+0e+RLA=;
        b=QBCOg0RR9FvjtJmZ8iuVcIvMpnjRxFhuFF20vzwx+bEMxrC58CV51KCkeEKPT103cm
         Y61HLJsPNwA5qYv0LyD4fml02uDmOzKjwShiROHw9LEu8Gucv2sze/ADUOIa42s2oKP1
         I+NUhJGHoAbcRA2SxPZkJnlQJJnwouyUMcmAs/W2QRtc3Y48sJXxsgNHA/h5ysIxn/Uf
         +i7usdM4lVpd/SDr3QmqEsIGbQB14kRo2C17tfnirEo3OIxMj525RIcB3K7jYe++kMBw
         Usx6Nkher/y297e6UN7XOA2YGeAGk8i6RofzJZ86xvHo3sQknvUROy4AkRyMKfoX8z/O
         taNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210838; x=1756815638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8/yMV+d4ox9uMZOSJDYsVGKRP9HYQM8YtUh+0e+RLA=;
        b=v7Om57bNzGvN7S+bl2zV0e1Uis2LrAuI8zA6hRCuucrep6I16F7bT1DQZXtRAch7Nl
         VNC88DsAUXIjdck6J4xRBtLpnDnG2T3jWmBevCvQmqBJkjkEh2oizdibAMTFvDEPpI37
         4Z/9AnPCj7R31WbrqRbfw/VG9iilwct3ud1J/GMKSuan92kh4F9KVPV5w3j1PsEH+uQn
         bNbQYhtxQ9eZUIIraAxx4qdp8UiZiRFz7xMdegNm7JflDBV/r9Pjcs6iZ0y/1ylBW1W+
         +XFSuS6Nzo5P92KBuUKYD5eRd8pYImlwlBTK3OYhih2MTSQQ+QBunhYYkrPv3JF0o42K
         BOMw==
X-Forwarded-Encrypted: i=1; AJvYcCVi08ZrKzzfAzZsEE5ImU4ymAy0uxIzEpnQbhcbsXlJAxlZ0Sg895iwaWAT47d8Tz6FeRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOX8coUlJjD5PYw+lFKZeTnj3r3YTSrvgq80uWSsALqwMcnAXP
	jgGCBXKPmZSo/TElglv3UJz14eXJyPrqa/pcveAAJWozQonGe4SLAHT6
X-Gm-Gg: ASbGncvYaDNCp54dYMjkoduqEpCHtbSW4t8PSRuEmin05Bb6/kWEKLP9IH1OHQxKH5P
	DcRtpA7HcpTlcB3jdvHdbyKzOIBizYv4dsAi5aHc1fnAQUTmmXe3NB6sQ8uKpkEoP2gSBKvSr4p
	Rke1h3+cCbhMZ9Q9AXaDNvRWoY76KFytBXPG2NeJ8OjCIZaSpH0I+EaQlqTDfhB6LYoDhaWNv73
	VocNYAjzlWQpNhHBdv4JCSgUXWRO2FQZxdwK4KMVZviT16ryTW/5pB7G8e8WiCIEs7wQac2Dbkf
	4ALWnL0+L9uEFVL9+EzVodoq5tocCQ8nK1sZk3ivtbVjYR8m5BMMwJ4Xt+qG++1eu7VYOi0s4Bh
	NtaZz/icSm0QJdYFMyA+1T0khT1+Ov3Rn6GzJ2WdeYC1HR3nuu/g0p6NkTsSMywwGSGMNVxXnDz
	GdGtk2zk8xSQ==
X-Google-Smtp-Source: AGHT+IFM1pfAispDYaxA5YIvgYagwcYaEOHLowWUaWbx9NVlp2zO6TIdwHUV27+A+o4CF9IGudSgtw==
X-Received: by 2002:a05:6214:248c:b0:70d:cd1a:4a43 with SMTP id 6a1803df08f44-70dcd1a4ad2mr31121566d6.46.1756210838382;
        Tue, 26 Aug 2025 05:20:38 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:35d4:8c92:558f:ba56? ([2605:a601:a6de:d300:35d4:8c92:558f:ba56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da714603dsm64436526d6.2.2025.08.26.05.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 05:20:37 -0700 (PDT)
Message-ID: <47d09c43-6d27-40ff-8dbc-22cc4a5949ed@gmail.com>
Date: Tue, 26 Aug 2025 08:20:37 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, phillip.wood123@gmail.com, ps@pks.im,
 gitster@pobox.com, ben.knoble@gmail.com
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
 <cover.1752882401.git.ayu.chandekar@gmail.com>
 <CAE7as+b2QKcPVnyEupriK54bMSSxdRAmSrMZqTvfq_KabaU-Ug@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAE7as+b2QKcPVnyEupriK54bMSSxdRAmSrMZqTvfq_KabaU-Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/25 11:36 AM, Ayush Chandekar wrote:
> Just an update, I'm still working on this patch series.

Hi Ayush. Do you have an update on your progress? Perhaps there
is something you're stuck on and could use some help?

A few weeks ago, I played around with the ideas around updating
the location of these globals into the repository struct and
made this critical observation:

   It's "easy" to move the global into the_repository, but it
   becomes harder (and changes behavior) if we start referring
   to the data in each repository struct.

It may be good to separate the two things into different steps:

  1. Move the globals into the repository struct, but only set
     or read from the_repository->sparse_checkout[_cone].

  2. Replace the use of the_repository and instead refer to a
     specific repo. This may change behavior of the feature in
     the presence of submodules with different config than the
     root repo (tests before and after will be necessary).
     We'll also need to update the_repository during the very
     early config parsing but then update other repos during
     repo initialization.

Does this make sense based on your progress in this space?

Thanks,
-Stolee

