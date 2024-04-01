Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34A54F86
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007682; cv=none; b=R15Yjc5UU7uHUiu0i1vzdGHkGWqIwVIaj1sIojbHUx/DDbsTDHjrnahDc95rzgHFM7UklW65a/NtGUYj093F37SaqGYvpC6i2f0CgQOqfq2Nw6Fz3PlZBukBQKRMpAsMNafrsNFCor4nd/6K8F4QrB/SdzfcSU5KPhqYE3aaHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007682; c=relaxed/simple;
	bh=/G4TLf8GPFATG5tf/A07mi0+rUG4oW5naZHvIMM/Xfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9/oQ1lTRGFYehZWeV+kYLasf8DDJ9Ue2bpRjE76nmq9jApkrMQr8Hn1KTn/Wnv5PkWbA20afE1VCp9hJ6PyypZ9X0NFUncsxA3W/v0icPrtcMyE1bolkECRClcYgEzh5alvS/i8/OqXSReAnn+/Csg9abm8NsE2H4cYP5F8STE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh7ysBzg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh7ysBzg"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-515d55ab035so1448677e87.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712007679; x=1712612479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHGrsgbrMWQx8RLmZzNAeA3tclH3wfZOVoeljye3tj0=;
        b=Mh7ysBzgwq+Ny/XBvrYyOLjKdYwNc09mvqV8+Hflk4pmeepdCx42qtHVbN201oMFqj
         w4hcIl1l7Dy6dyBysG2qQQwVqjpqSP080XO+ErKLG+CYv5lAa9HfYio/w3kUW4jwZQK6
         DSBQZdNEXZs+u24DQOe3TaLdG8obMKQ8wYg+gRL82ZzR3Zd3nVtZ4EdBS9vu9dVwQhow
         bpmGSsj4Q4jlkoutuzOop8XKWpeX9iVZn5uLtwWS5w+F44zyoLrV+ZvneHLaGjDjWj8P
         OKrCj6jN9YFBkzG5JRceotO2Gbl2vqScpFXfT5toN0brP1RziECTd4Pcy8jGa+wzqLSA
         BAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712007679; x=1712612479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHGrsgbrMWQx8RLmZzNAeA3tclH3wfZOVoeljye3tj0=;
        b=Isp53pEKlMwu1YmtZON6yJ+jx66FLgeG8ZY4JjYu+1jbah/FD/E/WxE8OU/SjoiWKA
         q+Oojpn7n6qkeNeEGwlwajeH+r+gM5IWysODUWj5hKj3C2f2GlKEjZfKvnGwhqAUcOVJ
         Rw0M/zij5RohWJzi8X09HXL7Yv64hzkc2Wa/z6wfFxBqbeGsQQAE2yXe4BPpkVVdUyLY
         RQuEYn6+HEhTt9It1qq5p1BU8sMJos53SQclWWv75KLGj0gI8PLsyzZDP+042IksI0uc
         JMnRaswuC4rWv1emVXt5kXyclgd6ZejWOKHISHfqFhk5m+iKap+kdbfxiudga6VmVm/6
         LKXw==
X-Gm-Message-State: AOJu0YyVmPR48G0Hdozd0KQH7ZAW2axbBXO+HOp/YF4WaqL9Y+/WgTBa
	Q9gBuTE9cBsrhZkTKmMdBlvLqFqlnf30vaguxiZYeorEg/nb+Vf/
X-Google-Smtp-Source: AGHT+IFgjkELCY6Zyy+CSqg4PjO5UZ1ak/h+cPvWy6pVaSL8Avb4PunXw9uyzndHmmF3BxWC7UC5hQ==
X-Received: by 2002:a2e:7817:0:b0:2d6:957e:10a9 with SMTP id t23-20020a2e7817000000b002d6957e10a9mr6374012ljc.16.1712007678956;
        Mon, 01 Apr 2024 14:41:18 -0700 (PDT)
Received: from localhost.localdomain ([31.124.44.211])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b0041488691eb1sm18861887wmq.17.2024.04.01.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:41:18 -0700 (PDT)
From: M Hickford <mirth.hickford@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	mail@boanderson.me
Subject: Re: [PATCH 0/4] osxkeychain: bring in line with other credential helpers
Date: Mon,  1 Apr 2024 22:40:57 +0100
Message-ID: <20240401214057.2018-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> From: "Bo Anderson via GitGitGadget" <gitgitgadget@gmail.com>=0D
> To: git@vger.kernel.org=0D
> Cc: Bo Anderson <mail@boanderson.me>=0D
> Subject: [PATCH 0/4] osxkeychain: bring in line with other credential hel=
pers=0D
> Date: Sat, 17 Feb 2024 23:34:52 +0000	[thread overview]=0D
> Message-ID: <pull.1667.git.1708212896.gitgitgadget@gmail.com> (raw)=0D
> =0D
> git-credential-osxkeychain has largely fallen behind other external=0D
> credential helpers in the features it supports, and hasn't received any=0D
> functional changes since 2013. As it stood, osxkeychain failed seven test=
s=0D
> in the external credential helper test suite:=0D
> =0D
> not ok 8 - helper (osxkeychain) overwrites on store=0D
> not ok 9 - helper (osxkeychain) can forget host=0D
> not ok 11 - helper (osxkeychain) does not erase a password distinct from =
input=0D
> not ok 15 - helper (osxkeychain) erases all matching credentials=0D
> not ok 18 - helper (osxkeychain) gets password_expiry_utc=0D
> not ok 19 - helper (osxkeychain) overwrites when password_expiry_utc chan=
ges=0D
> not ok 21 - helper (osxkeychain) gets oauth_refresh_token=0D
> =0D
> =0D
> osxkeychain also made use of macOS APIs that had been deprecated since 20=
14.=0D
> Replacement API was able to be used without regressing the minimum suppor=
ted=0D
> macOS established in 5747c8072b (contrib/credential: avoid fixed-size buf=
fer=0D
> in osxkeychain, 2023-05-01).=0D
> =0D
> After this set of patches, osxkeychain passes all tests in the external=0D
> credential helper test suite.=0D
> =0D
> Bo Anderson (4):=0D
>   osxkeychain: replace deprecated SecKeychain API=0D
>   osxkeychain: erase all matching credentials=0D
>   osxkeychain: erase matching passwords only=0D
>   osxkeychain: store new attributes=0D
> =0D
>  contrib/credential/osxkeychain/Makefile       |   3 +-=0D
>  .../osxkeychain/git-credential-osxkeychain.c  | 376 ++++++++++++++----=0D
>  2 files changed, 310 insertions(+), 69 deletions(-)=0D
> =0D
> =0D
> base-commit: 3e0d3cd5c7def4808247caf168e17f2bbf47892b=0D
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1667%2F=
Bo98%2Fosxkeychain-update-v1=0D
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1667/Bo98/=
osxkeychain-update-v1=0D
> Pull-Request: https://github.com/gitgitgadget/git/pull/1667=0D
> -- =0D
> gitgitgadget=0D
=0D
Hi. Is this patch ready to cook in seen?=0D
