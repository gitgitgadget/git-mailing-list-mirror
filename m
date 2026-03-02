Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6E363C47
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453522; cv=none; b=a2/cGBmgHlxizGrBry8xvDw2laSMCMqA+FIqc2fcOZfgZkobaHZG174gGYkwJt1rRKff42nC+9RHXi0HnBF2BAjGXdL8NI2+BM8dqKhViiKA6dZSLTwJLTntw6KMrbn8aX72ZNjIppZQKwCnyuMLSy3hLBr+QqhBatTOXt5DNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453522; c=relaxed/simple;
	bh=xVDN9+g8bIUNNAKClKxFJ5SilN13yrsvU93g8OTA4gw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dXLdfDDwRjW0KCq7x73Xux/GHPfi5uGiGalwRCU6KM0juEYk07JyuAPU7S3EceQpM4vcf0AqcQbCAcLX4URtUwOTTz/P9cmXvmmViHNPEdRxIQxVTrF0QzcQfbQMpM7LZcp0zio9Jm8YwxQMbU36I1SjMTfeOaUjq0bBXgrBB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7pHjJGo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7pHjJGo"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8249fc726e9so2374400b3a.2
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 04:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772453521; x=1773058321; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JD7vr/bv8lReTE6dZHyhiVk1+PinlXYb+Q2A2igMXwQ=;
        b=F7pHjJGosvFODCsLD74AaRkCx5I6Vmhzo/+/2o5PLvOMa9bM43bZWB0IXdckzaF141
         ba2lfYIAN/WGOBkVgBm+z/+42bthqA1j/79Ng6pGEL665Yc3lUzwaZ4y+QrH7XhfPPth
         S1HFqP36nVXL++TR6bcvgZWfcN+9XkwUx7kg624NC7G07QwNh5hd15V3a6SSF9PF+h4t
         9SvfVmEYa6JD2ctLdc0YetFOitZJoLXuKqlPJwsHD3XQ3ymoJ/IVUJ1EFJbCUbg+H+c/
         WYlNsv0qgFBuE3mF0rllq7JGnwXBOaUUYAHvzC42S3vu9bOl/7oBnEU8LZbVRVDLjv6T
         I7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772453521; x=1773058321;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JD7vr/bv8lReTE6dZHyhiVk1+PinlXYb+Q2A2igMXwQ=;
        b=wtoqQUQgFiwUIe9s+/lgk89Gya6NAGcBjBTy3yv1LWQhf9kvaV0AFGAwYBHIvkksJj
         /GMR6hnE6oEoBofkuTPvpMUecuuUvkgxsGYfr6o1s2+PK+hXULM1zPzRkraJ4zPC7Rx0
         eGXGOCVhqTyo/ZBE4EvwVXumu+Sf69SLYhEtzsUvi4xwml04BdZlLe/+sQaOMvU+NQSL
         hihG+tQTCtwWIFHV59E3/blsmvhxUkJgUOoBBDT9h88YNJLITsHyCAiPArGqCp5xdBh9
         2dZF3zELBtoxQ0wbWBLgg0/+myzqSd8hBvwcSZaUU4psN70pmWROr+ViCMbmDe8MauP2
         sgtQ==
X-Gm-Message-State: AOJu0YzQHytTIOQrKpwYZsPLRpmH1RB0fUQ3Ost/wXI8WLbjTylh1yUk
	FX+N7SuaUgrDHVTRsqGBj0gLLEtVz4EWbGeqEV/Wvbv6cqzPUhkZsW1mOVJZCoUOdI0=
X-Gm-Gg: ATEYQzyCybmKrO5/PM0PXi7Z4li9u5CMVJJT+v+FDUcV3Clt1FnsL3cjDdAyxkR3DMk
	5INGAq4j+w0aw+EsVAWiDX3g4ZrierEj/2K2K2N/KrhEJBYkBvgr6EnHfEMK2jHMwmPHbPlQbOv
	Jlz4XdGdhPjta1Y3/n8D2ks6EpHpIv3xpLd1KjuylJMmhnmY+XJR9aeS5ktsRxEvfQyTATW+DU/
	ZgLZ01QSuE+unvRvgIpWu8J0irPm+eftvcoD+wbyfWO0YqKfJ+0M1X38TTnOI+w4OipCUWoKz2N
	ExWZSXXmeV1i0y1H3wGpyBdvc9H4jXfN3YLitO6N9CwxhQlYsX7TSaVVQa0BABpXGYBvugOvshF
	SmPUC86GIEU4zowbDgGNLdfureOdN4LqI+KcHbVV/x/kyMWq7I/LZN0xYYMLYk5XL87V1h1hsrK
	VOxa73j6m09N2VadpAqF4POISXPVA7uPYiSs6oh5GAOyFJJXeTHNG7QVq4KYlsxHl1jAVspUZJj
	0nmQ82/CnBMGUaSPd6A597nPvF+4JJGu2oNrSA=
X-Received: by 2002:a05:6a00:2341:b0:824:3eb9:11e2 with SMTP id d2e1a72fcca58-8274da12ebemr10322398b3a.46.1772453520501;
        Mon, 02 Mar 2026 04:12:00 -0800 (PST)
Received: from localhost ([59.89.50.211])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82c531sm11931378a12.24.2026.03.02.04.11.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 04:12:00 -0800 (PST)
Date: Mon, 2 Mar 2026 17:41:50 +0530
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: git@vger.kernel.org
Subject: [GSoC] Introduction and Microproject: modernize t7412 submodule
Message-ID: <aaV-htnX0qM8azC1@ThinkPad-E14-Gen-6>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

My name is Yuvraj Singh Chauhan, and I am interested in contributing
to Git for GSoC 2026. I have prior contributing experience with linux
kernel and now I wish to work on GIT as well since these are the two
projects I personally use a lot.

As part of my microproject, I would like to update the `test -f`, 
`test -d`, and `test -e` assertions to use `test_path_is_file`, 
`test_path_is_dir`, and `test_path_exists` helpers in the t7412 
submodule.

Is this a suitable microproject for me to start working on?

Thanks,
Yuvraj
