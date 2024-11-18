Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FC1AA1FF
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958126; cv=none; b=U1qn3eD8+5DWtxOqrNsxE9E6UKs7K5u4XWYh3u1iYl182PtXVIbgHUBzBEYTzTUXxg2hQr2zyJcLIDA0l2dkSp8ITuErIgwWjbnr80wyNYxzwavSxvfd27CWsfSryTy3nEDHJdeyL0ivQr7zZH/1gBtxU9z+CpNtrIwcnXMckds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958126; c=relaxed/simple;
	bh=2iTHvrXAAVOhfirYY8+F/RQDmop7vthVTjoyzsakKlU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WUPKB4ahA7xwjit0eeZ22v9xHYuSQlCP2/3CCjk8H4Fnr4RTYJppA691oh/dEqaFAvuPbZ65Q4oUnzyuoOGcz47toUZdejse2O6A8YxmNvMsCnY8jw+PnsV/ScD2se3Ri1ljGZnujwgRhvHR+oUTF1i/bkQR/hQdmTdDYCqTNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS7SvUuK; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS7SvUuK"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e5f86e59f1so1902516b6e.1
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731958123; x=1732562923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5DTW0d+eGM90MNqVaMfci0Jsu6HaWlrmhVCFTDKx/k=;
        b=gS7SvUuKDmD2vQ5OTvZ/8yySS68rx0oqJjn9Pa8AeyjdpsLeJKBiQOu79nVMn1bCou
         c7H9+sXWyX0OD+95mBJvXzay/8IT53eg0vhZlQ9tLaAJye2qpZHJVa8PJz+CagrJxxMP
         NE8Q+DKpZVdqX3nt53JanRLt+bsiAdhOXi7VnxpHYnknmgTB/z1A4Wxfrkxp23rA6WKW
         Ds5ptjLqgqxOHjJqpkefkkeHsL1QkNscV+X5f/6X/opQ87vmDsr1caUBQiGXEEcEurzC
         Vy4fOn+F8YbTYaRMHkvDwQywT31gbTHs+96tslFsNdoi5eXr6x55UiFDzamzxw2J1M5o
         ziQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731958123; x=1732562923;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5DTW0d+eGM90MNqVaMfci0Jsu6HaWlrmhVCFTDKx/k=;
        b=lvtOqVDjRCOSJ74/Ab7dnntMsKDA9Pwl6/6nS2GnUOXpl1oeujvehb3KN1ppiuZZUK
         Fxc3Wp46DC8F6gf+nPlINfQa5ppDrfBTV+3xVwTLRrCdtKXbEP8cnfOnOaxnh7yfiZN2
         49wfmqR78WiUQwBzJ+aa4It2wo594IvVLoRFG6H4E3ekWrqtYYufAtvJl/DhVuX9SW0f
         bJlfgbK+yg1lmOafEMC1HJQn7QzM77n+Pib345x2HoWcxSy7jC9pwHAnrSnD8KNyf/3M
         2STGrutXdrGViA19yiBl3G8HjKQqTpBytc6XAgcJzO2DXd+YHFEGUQqnvmAkLfKeptxg
         w50Q==
X-Gm-Message-State: AOJu0YwPuy4g4T4Kv19mpWEJEOSkvDCIokLFutAagNMzhB4cqnR8A1VB
	tzMzM8yN0QStwQkMGrAOxNJMhLTcH1s8f3qbFXT4sMAsm19WUCuFj+BoCA==
X-Google-Smtp-Source: AGHT+IGE6R8aOlsQQ7mbBM0iMDIZh4QIFwXxmYwibquEK/ZDe6XT4Qa93UzQXm8Mnq6x8yw8jleOAg==
X-Received: by 2002:a05:6808:1689:b0:3e5:db57:c479 with SMTP id 5614622812f47-3e7bc7a2307mr12025426b6e.3.1731958123184;
        Mon, 18 Nov 2024 11:28:43 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:6fc4:882f:9015:71cf:9197? ([2606:6d00:17:6fc4:882f:9015:71cf:9197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dbe15d9sm39569336d6.20.2024.11.18.11.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 11:28:42 -0800 (PST)
Subject: Re: malloc: *** error for object 0x1: pointer being freed was not
 allocated on MacOS with git 2.47.0
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <5FFE9429-7496-429F-BEC5-9D00C8409AC3@enrg8.com>
 <4ca84916-c5f5-4d52-8f6a-08b729bb66b8@web.de> <xmqq34js1kd2.fsf@gitster.g>
 <Zzr4cgk_5MJNcHm1@pks.im> <xmqqjzd0k92c.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <b09b16f5-4fa1-c802-86ac-9f0b1bcc9f53@gmail.com>
Date: Mon, 18 Nov 2024 14:28:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqjzd0k92c.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2024-11-18 à 07:42, Junio C Hamano a écrit :
> 
>>     pb/clar-build-fix
> 
> Not all that urgent (it is not end-user facing).

I'm not sure what you mean by "not end-user facing".
I ran into this issue while running 'make -j -l 2.5', 
as I mentioned when I sent the patch [1]. I guess you mean that
end-users do not normally build the code themselves ?

Cheers,

Philippe.

[1] https://lore.kernel.org/git/pull.1810.git.1728323033680.gitgitgadget@gmail.com/
