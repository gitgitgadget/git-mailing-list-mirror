Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B518C325
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533190; cv=none; b=IRnPNOvcI3b3zypVv34hInxsc3gI3E7TD3a7KolPGyDaq3godq6hdbh5XmnZqT7NX/zRVkJjaCIL5CGJjq40hQ2Jq5FObh/JcYN2F3TDkeVY96pcu5KyC54Xw7D2pfIr63fW6G1hiP5rpLH0pOBbcU98PiFcCwHFJaGtRDuWRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533190; c=relaxed/simple;
	bh=rK/taRnXZY0MHa4/56kG/us7N+pLvXb7MUoAOBGUZ1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JMV4IvfskXmUs+itBapTKe/R21VD5tJA/o56GSijOmR0p5AwhdDaWdga5jNAbulcbYiO6xfBGIEv/gfD9z2IOf1zMaIRe0GL4J2SyxPjOjMCRFOCdU62gs5KfzTw60/qJrVK+uBIpfhuXZI6wnXvgKJ6VS9LodXbUfkgL/0fV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVALKDG0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVALKDG0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367a464e200so2798375f8f.2
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720533188; x=1721137988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9v60KtVQq3tjrNd1kWk3rrP11sdgowRmbcQsJEn7+Qo=;
        b=fVALKDG0nAh2w00z8M/jya/o8XUEVoKdYFGdMP9E3wVW0Xrxy4bwZ8xvFdPZuv4xXY
         99GKV3aQw4WNBk6k9RMpg72ZZcSaTtZiUvsoYyEF14DmyRRGbKDNr37g1VqJvrDLbW+9
         Atm3LllknCkkRZ86N7ReFXWGJTDyqQ1Yjg/7zFOWw6NGb9poM0m3a3ihUQWua0Cr8Is5
         EZobw4b0wa5sgRiA8ICRNJdN5ZPkhLVkaxW9Q7lpJn6dTzAn6X6yFLr8CxbDXoK0E5r5
         QOQEFPoUZlWll7xC7XT6MlXVDUIdGlbOZWVmeQgh8+kT0doy36gKkHPbMA9NwJlKQYZn
         1D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533188; x=1721137988;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9v60KtVQq3tjrNd1kWk3rrP11sdgowRmbcQsJEn7+Qo=;
        b=VrK+9FVFx3Mthui33Qc9SPYB3MyPER9cbDTFLvKDmRmLnBJDpIVIJusisoJtNjhkVB
         k6re5QnYKHCBZksBpjR+9us/bngv2ifMncB95Knr9OwNaVZMvgGvwwI43r8nwTDKFfzN
         8QTDDF6FHrugxHUyaVWf0G5F4htQe9k8G52T9vzvTvmMaHvf1WpyGNqVCPz4hkHb34kD
         51eQbFVk9CdBAH9opZKgifSTY8tLbLOwVBZ0mQpUxKR3bn+Xg9rzs2i7aisKwfvzBVZy
         V6R60KiYsDc0jPZHeqOEdBKD6hqtpUuCvoTnI8AW9ziXfnDax0ivr57AHQES+ys1YgbS
         PPkw==
X-Forwarded-Encrypted: i=1; AJvYcCVaRsSFesYtpcUjx6auYZPMXaDcm6ZZVKMycfr8ix4y4Zd0UgZlAx4kmDCe9F8D3jMnKqQ8dTJ1Vlvv8Kvh7juY+SPi
X-Gm-Message-State: AOJu0YxQr8QJTcmHuUsrBb9yxZabNHCshJhgda5a/LGx+191R5pwfGYG
	nJicwqpK4qB/d6T9TzxDGRZ8Gcsamzmi29wlCC6NSha7FcS+eAN8
X-Google-Smtp-Source: AGHT+IEw0oq6zpCyeyJhyiHMCbxem03WAvyAoU+YzOVm+f9Jd037UAKCyewQX1YJV2kXSN/gZ9sPug==
X-Received: by 2002:a5d:5f51:0:b0:366:e685:d0cb with SMTP id ffacd0b85a97d-367cea46907mr2384407f8f.6.1720533187429;
        Tue, 09 Jul 2024 06:53:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab0bfsm2630907f8f.99.2024.07.09.06.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 06:53:07 -0700 (PDT)
Message-ID: <9e2e32d2-4f52-43db-b2bd-8cf2df1af10c@gmail.com>
Date: Tue, 9 Jul 2024 14:53:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] var(win32): do report the GIT_SHELL_PATH that is actually
 used
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
 <xmqqed83g1e6.fsf@gitster.g> <Zox48sVp-PybvLxi@tapette.crustytoothpaste.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <Zox48sVp-PybvLxi@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2024 00:40, brian m. carlson wrote:
> On 2024-07-08 at 18:54:41, Junio C Hamano wrote:
>> The "look on the %PATH%" strategy does not make any sense as an
>> implementation for getting GIT_SHELL_PATH, which answers "what is
>> the shell this instanciation of Git was built to work with?", at
>> least to me.  Maybe I am missing some knowledge on limitations on
>> Windows and Git for Windows why it is done that way.
> 
> Well, it may be that that's the approach that Git for Windows takes to
> look up the shell.  (I don't know for certain.)  If that _is_ what it
> does, then that's absolutely the value we want because we want to use
> whatever shell Git for Windows uses.

As I understand it this is the approach Git for Windows takes

> I will say it's a risky approach
> because it could well also find a Cygwin or MINGW shell (or, if it were
> called bash, WSL), but we really want whatever Git for Windows does
> here.

Git for Windows prepends the MINGW system directories to $PATH via some 
extra downstream code in setup_windows_environment() so looking up the 
shell in $PATH will find the correct executable.

Best Wishes

Phillip
