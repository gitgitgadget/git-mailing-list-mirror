Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5662F30
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750984003; cv=none; b=oxlZtlQYMo+ztU18t/J7Pz3hR36+gCmktiHrgmVmIp0QHRnnO5eiirTaEJslK2I/VF4I1F0UX1SDPON9VKpK0brryY5dx/LffZq3CYUP6Om2YCsTf9PEi4uG0Hr3st+IRTJZkJGuMLqQtIEf2pkMPq33H/PU6ay6hrC96s3NXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750984003; c=relaxed/simple;
	bh=N2uVtiIV/wwokgJdTZ/5qS997mhjJlAqzKezwbxcYXg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Wqccv3nX5Cz8oRMdzw1L5CCMErUfr4ZQLC/8lQTVISiHNNwsZF3YKOwHOiIE8FkEYuwUZ/EPtcDIdGfa/Bo13rubTMBvdRCEZnvtiHm0mWYXXRzFxShBWZHjloB+bEEoq35xiPa+RGdPXJXeeV3tLDvsSX5NGJiPiA0jgGi+jT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwV5z+MJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwV5z+MJ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso1636017b3a.3
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 17:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750984001; x=1751588801; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2uVtiIV/wwokgJdTZ/5qS997mhjJlAqzKezwbxcYXg=;
        b=kwV5z+MJiX0+lOkqw8aaEEDr8M+BgKFU3GijlEuQsY5BP5Sfv0zZFn+7HEHgAuSCp7
         Liu9yrzRcntKBZcX+Oh2FxkuKABygufSW22/SaVCuFgmZIWiQ4ijh/B9uELSv47lmfjW
         GPZh9XsOuRdVSjMF8S19ajIth9KdR6AeFtAV71bK4XaER+QZs4+RJ5LBI+gDXOFXwKbK
         /SWqkew29g1YuHOV7QfyONRCdv2iCADHs/8ACtmIyBIBMy+f3rBP1l39r/NNi0K3iikC
         W6CvNJ7PiOvXNh06B/epCtKs1byqg6+pq9//tLhjSGm1av04Srq/0zckg4mGo9zF+/1Y
         NrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750984001; x=1751588801;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2uVtiIV/wwokgJdTZ/5qS997mhjJlAqzKezwbxcYXg=;
        b=LP2ueKckQXG83JXOjyC8f1LskffvK95MlFKQM8S0Vii7iFmnbFkIXtEBojnn4MbaAa
         y1tH1+TI5xeEwRERTdBTl6ZrFLg0QZ0xa9GYRNdbotUUBW/Opt7ksxGsF8kCiZBzx0Bi
         L35MUwO2rd5wof6qnKn1y/jJgTwDzNQCz+XaGozZCzNjlQc96IFAo9ElWoBFMwfwB/lA
         g6BRUK5lJzJCe0I2bow6k3/MsQbMhr1wluWj+MEUM0fc9WWvaTU8z1qx7agbfXCVYAcG
         Kmp0qIgAHK12v2z988BZWnNpsq+MflzqMPT40Uft4XgB3P2tWOcrm8Tyvq5XN1A+KjQR
         EIbg==
X-Gm-Message-State: AOJu0Yx83IaXKlOsY+Jp63ouRBycvUBnRMZD1JG99UmPhEkODwZRB/AR
	2MObTQIki/GiT/THHiG1OyfH0uCWQJLI3EtlRqEPjt3ND8elmiSPfMAsrRnl0w==
X-Gm-Gg: ASbGncuv/to9AOVkBgKbdur6HdukLoR2kKFpjr0XDVzsrBDw28QXvhudPmTJeQRuJBf
	whuGi6QPgqbI9jEAhdBU8Bb63EDXn8b03CGK4WU0PI52BXbWSYANJyW1X9hHsXlBdPxqeepmcJU
	Y9NrtqxBEH0a8p2zyR7WJqkKsCd9JXDrbjuxMvQyHRFeOuJOMTvETf5HCYsZfsv8afmhumxjaKx
	gLvT5baa+v0gvYoJqqVqCbrikuaTEcZSBaXDptNEE7m6w9FqZF0ftcIPXFRmYMwVZiW+50UMVDq
	mlSMC20+KtCygk+V28GMXNyPjbK3g5ke2kjt6qTsaRi+e/FwO1qm72pnnT76a3G/cHdf8URxgNW
	MgAiViWY33I8E
X-Google-Smtp-Source: AGHT+IEvB0AfVq4Z5wYT64RCrbV3ouOq+CzD+wOW/W5aqZwz0rJvDGMV1UCxL5bvLrm1S1kZt36vkg==
X-Received: by 2002:a05:6a00:92a7:b0:748:ecdc:ca0d with SMTP id d2e1a72fcca58-74af6e39d2amr1313172b3a.2.1750984001242;
        Thu, 26 Jun 2025 17:26:41 -0700 (PDT)
Received: from smtpclient.apple ([191.181.56.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ef0f3sm844520b3a.154.2025.06.26.17.26.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jun 2025 17:26:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: [GSoC] Blog: Machine-Readable Repository Information Query Tool (week
 3)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
Date: Thu, 26 Jun 2025 21:26:27 -0300
Cc: Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: 7bit
Message-Id: <01D987DF-4B04-4DCE-BDD7-48E1492DF12F@gmail.com>
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi!

I forgot to send here before, but I updated my GSoC blog with the third week!

You can check it here:
https://lucasoshiro.github.io/gsoc-en/#week-3-jun-16th-to-jun-22th

