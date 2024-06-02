Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F40639
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717311942; cv=none; b=IM9J7VLbeq1ftx6rP//IQyd0W8K5x+PH3RAvCBrJHFNhWLmh3cHqmx5H9fm/lLzeCNOg6hEakj18pgucBt79HTnAucBdxFs5LQjr8XcMnMGoad8lY6cDPjT7X/cGaccwMyEqdNXwuLqrPqVdil4caDWR3vtPE9OMIAYcy/Wlb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717311942; c=relaxed/simple;
	bh=pONG8uyl2h+MqdmchlXUfeOjuqywK/eDDDchmNuJ2mI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uamr2at9bD/3A886nAA+tS/DQG7+iLoikHP6TJ4mXRY5I/3sdK7mkJYl+mY4bciWgjWAI9rNZS4xDQMrBDZ1uyPBD0wJV4xzjzdbqV4v+g1nKnsCS9DCEbePr+fqDIHtAMfQmvhibPMqL1CF2GlvSw6jT0GSpU+7iWmcecgWMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPXZQI+Q; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPXZQI+Q"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4df550a4d4fso890218e0c.2
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717311939; x=1717916739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pONG8uyl2h+MqdmchlXUfeOjuqywK/eDDDchmNuJ2mI=;
        b=hPXZQI+QuqhHAjVTMXGRVG5xqnJgU49pigfRnd3bbNWMUaPkdfAxQrSONKEydu7rDv
         EtSHecmclWiQNKPpYcoWWg9TY0nsfI968Sn4r2YJLCNrV/lPgaE30j/WyeYd2nxffMDZ
         HNo0+8vhL6bwqK1hOkTduasdswj7rGyhZ7Y5LYNNvOtFTyjzmeBoGym2/xn1EfJ8368C
         dSnarwGJ33txqSdcCkg5v9yUUUTttjgTZ0crknspPB+kFQuOaLpGzAz52aFB2c8dvLvc
         HulGZcxY46G/nxgad/ItL/ylJmlarRH0sQnJPdN3wGnk4dC6busWgoyayGtSmp2ZbKX3
         ve0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717311939; x=1717916739;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pONG8uyl2h+MqdmchlXUfeOjuqywK/eDDDchmNuJ2mI=;
        b=Ftf0PGr7T5tymgqmTCJsPiO/xWase4JEOoHVfX15ayVzRKagJUdmz8bDOD8+HKSibb
         d4IeDiyUaI8m9onhRTuzcGuFwqRKM2HWfmVDF3FR38wsffLS+9r/OqDDx3AU2RhgjEx5
         Pkdz8Q1IxJ/mHSgEkQLfTXyy38l2m/WokK3AKdHCz0V81MHPfj2Gu27aJneNuA5/F+Nn
         b2SANPHPoXV+RU+KKB7FjAtLtqZWHEiMmhaNCxq+dDRnsWdi/vRb5LJ5jl9xwR2dhQ4M
         /0gEwHEh8qdV9HOm0EEeexX4Mj02mY2xhMcR6y6KIV21OysvZi9tntNn10GNJq15Lq7h
         NACQ==
X-Gm-Message-State: AOJu0YxEL8hWTUB85mcRpAdudH42TBa14LK86OwKCbDn+Tr1Xd22LaQp
	uVXYI3Z6bQw8QkbZRqaK5tamYIVX7VoTC2gNuxfkNx4QuLXaYZP61/sbYravTvLy1DGSeNEFIwl
	YSgiQyniYsKSxhr9uTWfnwsx9CDhI9egPMEw=
X-Google-Smtp-Source: AGHT+IHds17nLmeWUujfGv1OsdAnsQBt0QRKyT3mNm8HKBBn0QEvAvg3QpKZrNeLtNsXjP/ZWUeoRFuhiZWwirM56PA=
X-Received: by 2002:a67:f48a:0:b0:47b:7420:a2cd with SMTP id
 ada2fe7eead31-48bc20f6813mr5068712137.4.1717311939311; Sun, 02 Jun 2024
 00:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 2 Jun 2024 12:35:27 +0530
Message-ID: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
Subject: [GSoC] Blog: move and improve reftable tests in the unit testing framework
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, here is my blog post for the first week of GSoC's
official Coding period:
https://chand-ra.github.io/2024/06/02/Coding-Period-Week-1.html
Please let me know if you have any sort of feedback.
Posts for the rest of the weeks can be found here: https://chand-ra.github.io/
