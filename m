Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E26322747
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513288; cv=none; b=FYu16DBbEvHFuyKIzH5TqoX/XwGJLkAE6QjHsNMSy9ie2f/+E9eHXCPku0rE02U2sjKKGaI8N4Ub72/1fPm1wwCauorGRGEmGUYHg7wjvmvuKv2aHlLtfC2hY5TGFxyUF3vOCd6Abme/bSvTFvpa4C28FauUAIDseDsNkx0X9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513288; c=relaxed/simple;
	bh=L6lOsTGagHZlmBuua9yWZ+4+F+N2Q5TSPtzqq935teg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BTXN88dCuqXSFrDgBXsCeltV+sfYr4+yPf5+ldWb6dLe4xfblcHBJpSoxZteGxiexdGdb+9ixOPkW5QK+NmwwmlxzKJqGFbIEO+9JhiVhjeunFz6R1pXppBQU4qBDkkkiMaDXvm/JBow30WpR0IZ+JS5zjNXGe2pYRsNsB54aFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKoaqotY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKoaqotY"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so3435633f8f.0
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513285; x=1758118085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFRW0zRwtyDZwlftj4vWeZwEOEBaBikAJq5cisQja/Y=;
        b=hKoaqotY8lIDKUeZF/3udzwvOxrDr9LfINJtwJTjHgrT8VXYGpd6ITXuScjRhgX901
         8Qd8MSNQQsW/quae1QWLuy1roYkceVVeGsAqZ3Wowmh0KVV4UAf2w8gg9dqDZxV0juf8
         zQUGpNvLzRSWaDs+h2Z3KRuvDGWf3mwR2aJEVOFu/JJ9EoE4cCYSTK5dLJIzmmUdytw8
         CXrnW9KUbXF7YALbMtO36KpxsagEcPutqLRyRqwSC4AKqrgZIMthX7lMlzQvDnQYpAGG
         XVNjzVnFElVTccHHlZaxrdbZpfUXLNe7FmL0Pn+8Oqr3V3v3DCmO4XESkMJxQIQSCqFe
         IfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513285; x=1758118085;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFRW0zRwtyDZwlftj4vWeZwEOEBaBikAJq5cisQja/Y=;
        b=CEt3/ZJJop2R+DjVXv1fHM4d5o/fF0oSjOlUO3a37AX6NBnAPtJHO/CdMGEvCdzXp5
         mps14nz9sMTHAYxh/YdxuO1+xlFc7Q3ZCQr8kgHBWFwH79RU/PNcXASu7dywHAaRVM6c
         P/01j6O2DPjTrBPld9BK6JdnqS0gP1ZNKjxUCizEpd6GWuT3/7NkcmQLJhafwtNcIxjm
         xLk1PpJyfaicv9bmUQZm7g7RrcQqK8zndrC6xxLP8TLMS9RGSAdqWb19bXYGsTyGtGgK
         beNcG9fVFfWUA6oVaa8rBSRMUasHH+jumz63TuoVdcNCypmdegxWr55ebHT+GG2njsra
         UaMA==
X-Gm-Message-State: AOJu0YyJBdZIrZBkbRHUky6I0XTgMfssXpkOioZyKnB6f2e02cwM0vQQ
	sewVlbUhBqkjZ4hVrbDDL8V5DTqyoW1SdQX8/cyFUiuG4WhHKBVcxOmp
X-Gm-Gg: ASbGnctC7eH8TMkqBj42EGqfQWbI9r9X2HT2cdD9ijgOgUboyd2f3BZwfKjDYGWu/eG
	hdKHZUN2D+ibkO0wP3q6B/OWLfbPXS7OdNyeycttjYefIl/nE2ECQbcs+dIfgZ4qOXFVSWqrGRF
	PqlTdxn23QoL0zxP6qUmVQogJJeshI6k/m+zGEOuZ8/L6LwpF4G+xhttHXImiWm2kt89r5+Bo13
	0k1znz3+irNSEXbQqzjX5TL8DlR9PwQY8+7A6DHg4TqAYC6J/S58DsLT0qx0eK8KpzIeo32l3vW
	Reubyqm4+nEkymUA4jMCmbINJVpWOrbI7W1gfWP12l0WwktdQPd/lSRhaEOgtQWEVZqiRXRh9gX
	+Te8J8D3s/xEjt5mHHZCqFb8ruln1zfxVCybN5S3LvAwpqLr+w0awvhBnYelT5BacYzHxNDhoMM
	d0DjtNGaVaww87X2hHuM7e
X-Google-Smtp-Source: AGHT+IHKcmg6Ruqkk3M8r+dkTqjnVrIhxKt3rkRPtYl+DBaIgfyKfPzFOgW6biI7/a5GTX4m2LzcsQ==
X-Received: by 2002:a05:6000:2f87:b0:3e0:c28a:abbb with SMTP id ffacd0b85a97d-3e6374655a1mr12278289f8f.13.1757513284778;
        Wed, 10 Sep 2025 07:08:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81e4563sm29738125e9.7.2025.09.10.07.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 07:08:04 -0700 (PDT)
Message-ID: <413ce210-09aa-460a-8a35-f7c0877dc23d@gmail.com>
Date: Wed, 10 Sep 2025 15:08:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v3 00/18] Introduce git-history(1) command for easy
 history editing
From: Phillip Wood <phillip.wood123@gmail.com>
To: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <CABPp-BHeXtJPq7BE1UZ+zH0C-9VzQcSYRo+t0P-KWth68Zd94Q@mail.gmail.com>
 <978e6351-1c08-44eb-8a2e-4a39541b9337@gmail.com>
Content-Language: en-US
In-Reply-To: <978e6351-1c08-44eb-8a2e-4a39541b9337@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2025 15:05, Phillip Wood wrote:
> 
> new commit whereas "git-rebase" does not. There is some discussion at 
> [1] where people were pushing back against copying extra headers by 
> default.

Sorry I forget to add the link before sending

[1] 
https://lore.kernel.org/git/pull.1902.git.1744041163929.gitgitgadget@gmail.com

