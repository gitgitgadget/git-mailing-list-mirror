Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE871AF0AE
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714132; cv=none; b=FqikhHbEWIKZO442A5qM8b+5SkARnRAbie9bEKvCnnvocSqOeXg7bvXG+E8RPY2RLVsPvx5fJ00DwGn9oC4pxSE0itD5iOkGRz4zyn4p2cfox1rGK0gENJX+xRCrg2KM3x1xhrrZYW6qngjI9d3DMtBa+x/8CEeJUO8K+yJHXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714132; c=relaxed/simple;
	bh=v4Us2fwP4dSiOmiPMy9SsbhRHOrG2xYHqhzfpIEY6Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=XmBw+ZjYmB0brc0f1VvecQxCubldsztHB8EdJSFPJwgo6yWSDIuVYeOevS3YStfTRqu8uNiOYF9SPkpd4H2PzJ+Udc/Cb/itbCPKtva0VDR1jkKGAZWuPUG0N2hLyNyZoXvzYRZcht2gik3Mh1E5diML306YiwPADGdOOveeco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQwToB/n; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQwToB/n"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so2976462f8f.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 01:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730714129; x=1731318929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0KfDz7pMbC6i7MZkRaSI8/QbWbqstIFHDhb18BwWGzU=;
        b=mQwToB/njCZEpHFlE5UJor3qMCyxxhF6JOXg+kl5vmP+rbdbcLSj9Hg+47blWzpz3l
         AZK7aH5FakEAeCmE29PMEYtY3g6iXoZ6goky+Z/st5hAc7UclJGMq+OyiYXq3h6sn6ps
         OKR4n6oiJU2KYgl8aXr4Q7425QKxtAhMWY7UFWkV8OMNXwq9e+knh8dHMusmVZLMUGtA
         NfEkws+c6HqKp6S6/30nsS+HQZAOoLKSaJRiCWBpaSsMfoDuZnU2mwNgs4C3yrppgv0G
         2B5DQqbokfwCHyE9Yzw7VRzO8fIonHupaR6H4hruGq8GiBQfQ0GMooGEU7dDK8eCOt58
         Dgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714129; x=1731318929;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KfDz7pMbC6i7MZkRaSI8/QbWbqstIFHDhb18BwWGzU=;
        b=uzGAUmzNEZhmAoyfjZaSVAMsu2z2Al2qvoTkzFI+XPmswsDWbhxGpslTyD5wln8USK
         okqs1gzoGjZ4cO2cGHgf7D0BLJ1uLf6Fbm2HqpKH2liLz9AWYCHfjIDhWWMgH4JxOJlC
         BhG16B0Fkq/uaEoBj0217d3M7NqgSWJVN+bkSt7t6KbGqkgsRo5Kp0Iut8gsNN0L7z2N
         8FjDc+ifbWSKRYZ3rM6tVGEkAL9r5yCod3cxkgYDJ0Z2rauIQFunClO0l+AS6WVzFoIJ
         Nh+CDAU3dxqKv7pMV+HtoFPV/5DuYqZpXlCV+sg8+Tdoq3bR5+XPpYQMq+nTnXxRPhiO
         PX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoKzEv7S048pKkdj7f33dlf/VNjSUiTkLScKHxSgb3KNMly9GQ0aeLLJ9In2k0t2Ojd1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1QjjoeLDClS7Wo6709MTJSZ+Zw6x6UIeHEpFg25lhUBUkUxb
	/ntzH3xvvP50zy7GcLgeu7W623OJ1m8nGp75VoN01UaLS/yeM6Sa
X-Google-Smtp-Source: AGHT+IEcxJiWHYgyAxLu2aLtxazqV7ZKdXJtJF/FeK4M8PWAIDzC6j4yFMIL4//Dy89S/9FZGvPD5g==
X-Received: by 2002:a05:6000:1863:b0:37e:f8a1:596a with SMTP id ffacd0b85a97d-381be76517cmr12227795f8f.3.1730714129059;
        Mon, 04 Nov 2024 01:55:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158? ([2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1168afcsm12768829f8f.91.2024.11.04.01.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 01:55:28 -0800 (PST)
Message-ID: <c1a8eb10-ac62-49f2-a40e-36c41bbdc991@gmail.com>
Date: Mon, 4 Nov 2024 09:55:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git revert cannot be aborted if the repository directory has been
 copied
To: Marco Stephan <marc.stephan96@hotmail.de>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM0PR02MB4980D186BDC087336C760132E6502@AM0PR02MB4980.eurprd02.prod.outlook.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <AM0PR02MB4980D186BDC087336C760132E6502@AM0PR02MB4980.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/11/2024 01:25, Marco Stephan wrote:
> Hello,
> 
> I have encountered the following bug:
> If you copy a Git repository directory to another path while there is a revert in progress for the Git repository, "git revert --abort" does not work anymore for the copied repository. Instead, it will report an error of the following format:
>       error: Entry '...' not uptodate. Cannot merge.
>       fatal: Could not reset index file to revision '...'.

"git revert --abort" is a wrapper around "git reset --merge" so I wonder 
if we should change "git reset --merge" to refresh the index.

Best Wishes

Phillip

> I can reproduce the bug consistently with the latest version of Git that is available for Windows (git version 2.47.0.windows.2) by performing the following steps (all command line except step 12):
> 1. mkdir test_repo
> 2. cd test_repo
> 3. git init
> 4. type nul > test.txt
> 5. git add .
> 6. git commit -m "Initial commit"
> 7. echo test > test.txt
> 8. git add .
> 9. git commit -m "Changes"
> 10. git revert HEAD --no-commit
> 11. cd ..
> 12. Manually copy test_repo to a new directory test_repo_copy using the file explorer (using e.g. "robocopy test_repo test_repo_copy /E" does not corrupt the repository)
> 13. cd test_repo_copy
> 14. git revert --abort
> This consistently produces the error "error: Entry 'test.txt' not uptodate. Cannot merge.". I would expect step 14 to work regardless of how the repository directory itself has been created. Running "git status" or "git update --really-refresh" fixes the seemingly corrupt data and the revert in progress can be aborted.
> 
> I have not verified if the bug is present on other operation systems, too.
> 
> With best regards
> Marco Stephan

